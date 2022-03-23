using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pr.Models
{
    partial class Specialty
    {
        public override string ToString()
        {
            return SpecialtyCode + " - " + SpecialtyName;
        }
    }
    partial class Group
    {
        public override string ToString()
        {
            return Specialty.SpecialtyReduction + '-' + GroupNumber;
        }
    }
    partial class Gender
    {
        public override string ToString()
        {
            return GenderName;
        }
    }
}
