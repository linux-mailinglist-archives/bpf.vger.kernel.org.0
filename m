Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B04C457CA1
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 09:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbhKTI7B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Nov 2021 03:59:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:14126 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236597AbhKTI7B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Nov 2021 03:59:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="234783868"
X-IronPort-AV: E=Sophos;i="5.87,250,1631602800"; 
   d="gz'50?scan'50,208,50";a="234783868"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2021 00:55:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,250,1631602800"; 
   d="gz'50?scan'50,208,50";a="456068523"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Nov 2021 00:55:54 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1moMA6-0005bm-3U; Sat, 20 Nov 2021 08:55:54 +0000
Date:   Sat, 20 Nov 2021 16:55:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Jakub Kicinski <kuba@kernel.org>,
        axboe@kernel.dk, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com
Subject: Re: [PATCH bpf] treewide: add missing includes masked by cgroup ->
 bpf dependency
Message-ID: <202111201602.tm0dlDfP-lkp@intel.com>
References: <20211120035253.72074-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20211120035253.72074-1-kuba@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jakub,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf/master]

url:    https://github.com/0day-ci/linux/commits/Jakub-Kicinski/treewide-add-missing-includes-masked-by-cgroup-bpf-dependency/20211120-115325
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
config: riscv-rv32_defconfig (attached as .config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e31b3bdd266ef8f63543f27cf7493e98112fd74a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jakub-Kicinski/treewide-add-missing-includes-masked-by-cgroup-bpf-dependency/20211120-115325
        git checkout e31b3bdd266ef8f63543f27cf7493e98112fd74a
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/module.h:7,
                    from include/linux/module.h:33,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/cacheinfo.h:6,
                    from arch/riscv/include/asm/cacheinfo.h:9,
                    from arch/riscv/include/asm/elf.h:14,
                    from include/linux/elf.h:6,
                    from arch/riscv/kernel/ptrace.c:16:
   include/asm-generic/module.h:33:25: error: unknown type name 'Elf32_Shdr'
      33 | #define Elf_Shdr        Elf32_Shdr
         |                         ^~~~~~~~~~
   arch/riscv/include/asm/module.h:15:9: note: in expansion of macro 'Elf_Shdr'
      15 |         Elf_Shdr *shdr;
         |         ^~~~~~~~
   In file included from include/linux/module.h:33,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/cacheinfo.h:6,
                    from arch/riscv/include/asm/cacheinfo.h:9,
                    from arch/riscv/include/asm/elf.h:14,
                    from include/linux/elf.h:6,
                    from arch/riscv/kernel/ptrace.c:16:
   arch/riscv/include/asm/module.h: In function 'get_got_entry':
   arch/riscv/include/asm/module.h:38:63: error: request for member 'sh_addr' in something not a structure or union
      38 |         struct got_entry *got = (struct got_entry *)(sec->shdr->sh_addr);
         |                                                               ^~
   arch/riscv/include/asm/module.h: In function 'get_got_plt_idx':
   arch/riscv/include/asm/module.h:91:66: error: request for member 'sh_addr' in something not a structure or union
      91 |         struct got_entry *got_plt = (struct got_entry *)sec->shdr->sh_addr;
         |                                                                  ^~
   arch/riscv/include/asm/module.h: In function 'get_plt_entry':
   arch/riscv/include/asm/module.h:104:66: error: request for member 'sh_addr' in something not a structure or union
     104 |         struct plt_entry *plt = (struct plt_entry *)sec_plt->shdr->sh_addr;
         |                                                                  ^~
   In file included from arch/riscv/include/asm/module.h:7,
                    from include/linux/module.h:33,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/cacheinfo.h:6,
                    from arch/riscv/include/asm/cacheinfo.h:9,
                    from arch/riscv/include/asm/elf.h:14,
                    from include/linux/elf.h:6,
                    from arch/riscv/kernel/ptrace.c:16:
   include/linux/module.h: At top level:
>> include/asm-generic/module.h:35:25: error: unknown type name 'Elf32_Sym'
      35 | #define Elf_Sym         Elf32_Sym
         |                         ^~~~~~~~~
   include/linux/module.h:349:9: note: in expansion of macro 'Elf_Sym'
     349 |         Elf_Sym *symtab;
         |         ^~~~~~~
>> include/asm-generic/module.h:35:25: error: unknown type name 'Elf32_Sym'
      35 | #define Elf_Sym         Elf32_Sym
         |                         ^~~~~~~~~
   include/linux/module.h:547:57: note: in expansion of macro 'Elf_Sym'
     547 | static inline unsigned long kallsyms_symbol_value(const Elf_Sym *sym)
         |                                                         ^~~~~~~
   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/cacheinfo.h:6,
                    from arch/riscv/include/asm/cacheinfo.h:9,
                    from arch/riscv/include/asm/elf.h:14,
                    from include/linux/elf.h:6,
                    from arch/riscv/kernel/ptrace.c:16:
   include/linux/module.h: In function 'kallsyms_symbol_value':
   include/linux/module.h:549:19: error: request for member 'st_value' in something not a structure or union
     549 |         return sym->st_value;
         |                   ^~
   In file included from arch/riscv/include/asm/module.h:7,
                    from include/linux/module.h:33,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/cacheinfo.h:6,
                    from arch/riscv/include/asm/cacheinfo.h:9,
                    from arch/riscv/include/asm/elf.h:14,
                    from include/linux/elf.h:6,
                    from arch/riscv/kernel/ptrace.c:16:
   include/linux/module.h: At top level:
   include/asm-generic/module.h:37:25: error: unknown type name 'Elf32_Ehdr'
      37 | #define Elf_Ehdr        Elf32_Ehdr
         |                         ^~~~~~~~~~
   include/linux/module.h:835:32: note: in expansion of macro 'Elf_Ehdr'
     835 | void module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
         |                                ^~~~~~~~
   include/asm-generic/module.h:33:25: error: unknown type name 'Elf32_Shdr'
      33 | #define Elf_Shdr        Elf32_Shdr
         |                         ^~~~~~~~~~
   include/linux/module.h:835:50: note: in expansion of macro 'Elf_Shdr'
     835 | void module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
         |                                                  ^~~~~~~~
--
   In file included from arch/riscv/include/asm/module.h:7,
                    from include/linux/module.h:33,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/cacheinfo.h:6,
                    from arch/riscv/include/asm/cacheinfo.h:9,
                    from arch/riscv/include/asm/elf.h:14,
                    from include/linux/elf.h:6,
                    from arch/riscv/kernel/module-sections.c:8:
   include/asm-generic/module.h:33:25: error: unknown type name 'Elf32_Shdr'
      33 | #define Elf_Shdr        Elf32_Shdr
         |                         ^~~~~~~~~~
   arch/riscv/include/asm/module.h:15:9: note: in expansion of macro 'Elf_Shdr'
      15 |         Elf_Shdr *shdr;
         |         ^~~~~~~~
   In file included from include/linux/module.h:33,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/cacheinfo.h:6,
                    from arch/riscv/include/asm/cacheinfo.h:9,
                    from arch/riscv/include/asm/elf.h:14,
                    from include/linux/elf.h:6,
                    from arch/riscv/kernel/module-sections.c:8:
   arch/riscv/include/asm/module.h: In function 'get_got_entry':
   arch/riscv/include/asm/module.h:38:63: error: request for member 'sh_addr' in something not a structure or union
      38 |         struct got_entry *got = (struct got_entry *)(sec->shdr->sh_addr);
         |                                                               ^~
   arch/riscv/include/asm/module.h: In function 'get_got_plt_idx':
   arch/riscv/include/asm/module.h:91:66: error: request for member 'sh_addr' in something not a structure or union
      91 |         struct got_entry *got_plt = (struct got_entry *)sec->shdr->sh_addr;
         |                                                                  ^~
   arch/riscv/include/asm/module.h: In function 'get_plt_entry':
   arch/riscv/include/asm/module.h:104:66: error: request for member 'sh_addr' in something not a structure or union
     104 |         struct plt_entry *plt = (struct plt_entry *)sec_plt->shdr->sh_addr;
         |                                                                  ^~
   In file included from arch/riscv/include/asm/module.h:7,
                    from include/linux/module.h:33,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/cacheinfo.h:6,
                    from arch/riscv/include/asm/cacheinfo.h:9,
                    from arch/riscv/include/asm/elf.h:14,
                    from include/linux/elf.h:6,
                    from arch/riscv/kernel/module-sections.c:8:
   include/linux/module.h: At top level:
>> include/asm-generic/module.h:35:25: error: unknown type name 'Elf32_Sym'
      35 | #define Elf_Sym         Elf32_Sym
         |                         ^~~~~~~~~
   include/linux/module.h:349:9: note: in expansion of macro 'Elf_Sym'
     349 |         Elf_Sym *symtab;
         |         ^~~~~~~
>> include/asm-generic/module.h:35:25: error: unknown type name 'Elf32_Sym'
      35 | #define Elf_Sym         Elf32_Sym
         |                         ^~~~~~~~~
   include/linux/module.h:547:57: note: in expansion of macro 'Elf_Sym'
     547 | static inline unsigned long kallsyms_symbol_value(const Elf_Sym *sym)
         |                                                         ^~~~~~~
   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/cacheinfo.h:6,
                    from arch/riscv/include/asm/cacheinfo.h:9,
                    from arch/riscv/include/asm/elf.h:14,
                    from include/linux/elf.h:6,
                    from arch/riscv/kernel/module-sections.c:8:
   include/linux/module.h: In function 'kallsyms_symbol_value':
   include/linux/module.h:549:19: error: request for member 'st_value' in something not a structure or union
     549 |         return sym->st_value;
         |                   ^~
   In file included from arch/riscv/include/asm/module.h:7,
                    from include/linux/module.h:33,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/cacheinfo.h:6,
                    from arch/riscv/include/asm/cacheinfo.h:9,
                    from arch/riscv/include/asm/elf.h:14,
                    from include/linux/elf.h:6,
                    from arch/riscv/kernel/module-sections.c:8:
   include/linux/module.h: At top level:
   include/asm-generic/module.h:37:25: error: unknown type name 'Elf32_Ehdr'
      37 | #define Elf_Ehdr        Elf32_Ehdr
         |                         ^~~~~~~~~~
   include/linux/module.h:835:32: note: in expansion of macro 'Elf_Ehdr'
     835 | void module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
         |                                ^~~~~~~~
   include/asm-generic/module.h:33:25: error: unknown type name 'Elf32_Shdr'
      33 | #define Elf_Shdr        Elf32_Shdr
         |                         ^~~~~~~~~~
   include/linux/module.h:835:50: note: in expansion of macro 'Elf_Shdr'
     835 | void module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
         |                                                  ^~~~~~~~
   arch/riscv/kernel/module-sections.c: In function 'module_emit_got_entry':
   arch/riscv/kernel/module-sections.c:23:48: error: request for member 'sh_addr' in something not a structure or union
      23 |         got = (struct got_entry *)got_sec->shdr->sh_addr;
         |                                                ^~
   arch/riscv/kernel/module-sections.c: In function 'module_emit_plt_entry':
   arch/riscv/kernel/module-sections.c:44:56: error: request for member 'sh_addr' in something not a structure or union
      44 |         got_plt = (struct got_entry *)got_plt_sec->shdr->sh_addr;
         |                                                        ^~
   arch/riscv/kernel/module-sections.c:46:48: error: request for member 'sh_addr' in something not a structure or union
      46 |         plt = (struct plt_entry *)plt_sec->shdr->sh_addr;
         |                                                ^~
   arch/riscv/kernel/module-sections.c: In function 'module_frob_arch_sections':
>> arch/riscv/kernel/module-sections.c:102:44: error: assignment to 'int *' from incompatible pointer type 'Elf32_Shdr *' {aka 'struct elf32_shdr *'} [-Werror=incompatible-pointer-types]
     102 |                         mod->arch.plt.shdr = sechdrs + i;
         |                                            ^
   arch/riscv/kernel/module-sections.c:104:44: error: assignment to 'int *' from incompatible pointer type 'Elf32_Shdr *' {aka 'struct elf32_shdr *'} [-Werror=incompatible-pointer-types]
     104 |                         mod->arch.got.shdr = sechdrs + i;
         |                                            ^
   arch/riscv/kernel/module-sections.c:106:48: error: assignment to 'int *' from incompatible pointer type 'Elf32_Shdr *' {aka 'struct elf32_shdr *'} [-Werror=incompatible-pointer-types]
     106 |                         mod->arch.got_plt.shdr = sechdrs + i;
         |                                                ^
   arch/riscv/kernel/module-sections.c:138:27: error: request for member 'sh_type' in something not a structure or union
     138 |         mod->arch.plt.shdr->sh_type = SHT_NOBITS;
         |                           ^~
   arch/riscv/kernel/module-sections.c:139:27: error: request for member 'sh_flags' in something not a structure or union
     139 |         mod->arch.plt.shdr->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
         |                           ^~
   arch/riscv/kernel/module-sections.c:140:27: error: request for member 'sh_addralign' in something not a structure or union
     140 |         mod->arch.plt.shdr->sh_addralign = L1_CACHE_BYTES;
         |                           ^~
   arch/riscv/kernel/module-sections.c:141:27: error: request for member 'sh_size' in something not a structure or union
     141 |         mod->arch.plt.shdr->sh_size = (num_plts + 1) * sizeof(struct plt_entry);
         |                           ^~
   arch/riscv/kernel/module-sections.c:145:27: error: request for member 'sh_type' in something not a structure or union
     145 |         mod->arch.got.shdr->sh_type = SHT_NOBITS;
         |                           ^~
   arch/riscv/kernel/module-sections.c:146:27: error: request for member 'sh_flags' in something not a structure or union
     146 |         mod->arch.got.shdr->sh_flags = SHF_ALLOC;
         |                           ^~
   arch/riscv/kernel/module-sections.c:147:27: error: request for member 'sh_addralign' in something not a structure or union
     147 |         mod->arch.got.shdr->sh_addralign = L1_CACHE_BYTES;
         |                           ^~
   arch/riscv/kernel/module-sections.c:148:27: error: request for member 'sh_size' in something not a structure or union
     148 |         mod->arch.got.shdr->sh_size = (num_gots + 1) * sizeof(struct got_entry);
         |                           ^~
   arch/riscv/kernel/module-sections.c:152:31: error: request for member 'sh_type' in something not a structure or union
     152 |         mod->arch.got_plt.shdr->sh_type = SHT_NOBITS;
         |                               ^~
   arch/riscv/kernel/module-sections.c:153:31: error: request for member 'sh_flags' in something not a structure or union
     153 |         mod->arch.got_plt.shdr->sh_flags = SHF_ALLOC;
         |                               ^~
   arch/riscv/kernel/module-sections.c:154:31: error: request for member 'sh_addralign' in something not a structure or union
     154 |         mod->arch.got_plt.shdr->sh_addralign = L1_CACHE_BYTES;
         |                               ^~
   arch/riscv/kernel/module-sections.c:155:31: error: request for member 'sh_size' in something not a structure or union
     155 |         mod->arch.got_plt.shdr->sh_size = (num_plts + 1) * sizeof(struct got_entry);
         |                               ^~
   cc1: some warnings being treated as errors


vim +/Elf32_Sym +35 include/asm-generic/module.h

786d35d45cc40b David Howells 2012-09-28  32  
aafe4dbed0bf6c Arnd Bergmann 2009-05-13  33  #define Elf_Shdr	Elf32_Shdr
786d35d45cc40b David Howells 2012-09-28  34  #define Elf_Phdr	Elf32_Phdr
aafe4dbed0bf6c Arnd Bergmann 2009-05-13 @35  #define Elf_Sym		Elf32_Sym
786d35d45cc40b David Howells 2012-09-28  36  #define Elf_Dyn		Elf32_Dyn
aafe4dbed0bf6c Arnd Bergmann 2009-05-13  37  #define Elf_Ehdr	Elf32_Ehdr
786d35d45cc40b David Howells 2012-09-28  38  #define Elf_Addr	Elf32_Addr
786d35d45cc40b David Howells 2012-09-28  39  #ifdef CONFIG_MODULES_USE_ELF_REL
786d35d45cc40b David Howells 2012-09-28  40  #define Elf_Rel		Elf32_Rel
786d35d45cc40b David Howells 2012-09-28  41  #endif
786d35d45cc40b David Howells 2012-09-28  42  #ifdef CONFIG_MODULES_USE_ELF_RELA
786d35d45cc40b David Howells 2012-09-28  43  #define Elf_Rela	Elf32_Rela
786d35d45cc40b David Howells 2012-09-28  44  #endif
786d35d45cc40b David Howells 2012-09-28  45  #define ELF_R_TYPE(X)	ELF32_R_TYPE(X)
786d35d45cc40b David Howells 2012-09-28  46  #define ELF_R_SYM(X)	ELF32_R_SYM(X)
aafe4dbed0bf6c Arnd Bergmann 2009-05-13  47  #endif
aafe4dbed0bf6c Arnd Bergmann 2009-05-13  48  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--gKMricLos+KVdGMg
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
uf79DV0BAA==

--gKMricLos+KVdGMg--
