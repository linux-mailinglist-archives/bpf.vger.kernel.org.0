Return-Path: <bpf+bounces-48616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F405A0A01F
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 02:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC7A16A9DD
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 01:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD0B1CFBC;
	Sat, 11 Jan 2025 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAxqJFEm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE83BA4A
	for <bpf@vger.kernel.org>; Sat, 11 Jan 2025 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736559376; cv=none; b=k3Xs5PmvhZ6CQiLbCP0FMYEx8OhXlsX4xlst9kMUzrgSdverAwq7Nv/aFdysOFG/L2Iiu7prPt6g072K9d/pjjDjxrBp6eMypsqKBqbmRri2qDvXPP7qoiCkQhCq6OfSTV/L3zBw2WguslrPLsctVwAfM74TfAhDFa64qPznNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736559376; c=relaxed/simple;
	bh=swiwWlgInd/k1mXaxAB9uDHpKkrWplxRyKf1NkTQYS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcWT/+/gU94Ea48WfsuCcUhRv2eEjZ7VQ824k0gtdHOuu5gNJ18PrmXhJqgHK0c7nz5+hLo8k56fGuVZVwtehRSzewBGIRjhgBUGsy96aKqy3p8gaMYmI2uZh/gKrddZllBbC1Uu6bxp9Q+lXwitccVqR13os7u+zvfVtCllsrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAxqJFEm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736559374; x=1768095374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=swiwWlgInd/k1mXaxAB9uDHpKkrWplxRyKf1NkTQYS8=;
  b=gAxqJFEm/ewBr47StGi7RlhBSvNDIMRhSM1M5fPfvaDX+ec4CJmnrxLX
   lWwdUkdoO3G/QE3gnETBmTKH3zp5VtwA8Frrku74PHYELergT6fnUUZux
   Ip3ksv5onQzH9ZJKXCrq/g5OEVwHhi7tzUXN01s4J5qGaYo2jA9FNM+ZK
   qjhUWbvu1tOQD9PBZbm2k5GGXlSgSdiAua1039BK20/xaYpvAVxySLjX9
   qtSAt113LIWbuqnSf32oWPLfWirPgbG5d/n38OOMmZre/Hn7CUQaMBups
   eRs6cUdMmgS8WIwV81R/ZCg14mYI7KV0Pn4LHczeA7qRelCcDeUOOJTlY
   g==;
X-CSE-ConnectionGUID: UKoMZsGYQN2+X7oZ6YjjDg==
X-CSE-MsgGUID: fGoB7fDESpSwCYuYHEcCmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="37028064"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="37028064"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 17:36:14 -0800
X-CSE-ConnectionGUID: l1Y9ukgwSdqNLU2eMblsJw==
X-CSE-MsgGUID: 35PFpzxTQYWPreKT4q4Xpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="104067989"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jan 2025 17:36:10 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWQQ4-000K0h-0f;
	Sat, 11 Jan 2025 01:36:08 +0000
Date: Sat, 11 Jan 2025 09:35:11 +0800
From: kernel test robot <lkp@intel.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, nkapron@google.com,
	teknoraver@meta.com, roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org, paul@paul-moore.com, code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: Re: [PATCH 09/14] bpf: Collect extern relocations
Message-ID: <202501110801.7aGt26Oh-lkp@intel.com>
References: <20250109214617.485144-10-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109214617.485144-10-bboscaccy@linux.microsoft.com>

Hi Blaise,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]
[also build test ERROR on linus/master v6.13-rc6]
[cannot apply to bpf-next/master next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Blaise-Boscaccy/bpf-Add-data-structures-for-managing-in-kernel-eBPF-relocations/20250110-064354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20250109214617.485144-10-bboscaccy%40linux.microsoft.com
patch subject: [PATCH 09/14] bpf: Collect extern relocations
config: i386-buildonly-randconfig-006-20250111 (https://download.01.org/0day-ci/archive/20250111/202501110801.7aGt26Oh-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501110801.7aGt26Oh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501110801.7aGt26Oh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/syscall.c:6438:22: error: incompatible pointer types passing 'Elf32_Sym *' (aka 'struct elf32_sym *') to parameter of type 'const Elf64_Sym *' (aka 'const struct elf64_sym *') [-Werror,-Wincompatible-pointer-types]
    6438 |                 if (!sym_is_extern(&sym[i]))
         |                                    ^~~~~~~
   kernel/bpf/syscall.c:6082:44: note: passing argument to parameter 'sym' here
    6082 | static bool sym_is_extern(const Elf64_Sym *sym)
         |                                            ^
   kernel/bpf/syscall.c:6463:20: error: call to undeclared function 'bpf_core_essential_name_len'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    6463 |                 ext_essent_len = bpf_core_essential_name_len(ext->name);
         |                                  ^
   kernel/bpf/syscall.c:7097:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7097 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/syscall.c:7147:41: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7147 |         .arg4_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   2 warnings and 2 errors generated.


vim +6438 kernel/bpf/syscall.c

  6412	
  6413	static int collect_externs(struct bpf_obj *obj)
  6414	{
  6415		int i, n, off, dummy_var_btf_id;
  6416		Elf_Shdr *symsec = &obj->sechdrs[obj->index.sym];
  6417		Elf_Sym *sym = (void *)obj->hdr + symsec->sh_offset;
  6418		const char *ext_name;
  6419		const char *sec_name;
  6420		struct bpf_extern_desc *ext;
  6421		const struct btf_type *t;
  6422		size_t ext_essent_len;
  6423		struct btf_type *sec, *kcfg_sec = NULL, *ksym_sec = NULL;
  6424		int size;
  6425		int int_btf_id;
  6426		const struct btf_type *dummy_var;
  6427		struct btf_type *vt;
  6428		struct btf_var_secinfo *vs;
  6429		const struct btf_type *func_proto;
  6430		struct btf_param *param;
  6431		int j;
  6432	
  6433		dummy_var_btf_id = add_dummy_ksym_var(obj->btf);
  6434		if (dummy_var_btf_id < 0)
  6435			return dummy_var_btf_id;
  6436	
  6437		for (i = 1; i < symsec->sh_size / sizeof(Elf_Sym); i++) {
> 6438			if (!sym_is_extern(&sym[i]))
  6439				continue;
  6440	
  6441			ext_name = obj->strtab + sym[i].st_name;
  6442			ext = krealloc_array(obj->externs,
  6443					     obj->nr_extern + 1,
  6444					     sizeof(struct bpf_extern_desc),
  6445					     GFP_KERNEL);
  6446			if (!ext)
  6447				return -ENOMEM;
  6448	
  6449			obj->externs = ext;
  6450			ext = &ext[obj->nr_extern];
  6451			memset(ext, 0, sizeof(*ext));
  6452			obj->nr_extern++;
  6453	
  6454			ext->btf_id = find_extern_btf_id(obj->btf, ext_name);
  6455			if (ext->btf_id <= 0)
  6456				return ext->btf_id;
  6457	
  6458			t = btf_type_by_id(obj->btf, ext->btf_id);
  6459			ext->name = btf_str_by_offset(obj->btf, t->name_off);
  6460			ext->sym_idx = i;
  6461			ext->is_weak = ELF64_ST_BIND(sym->st_info) == STB_WEAK;
  6462	
  6463			ext_essent_len = bpf_core_essential_name_len(ext->name);
  6464			ext->essent_name = NULL;
  6465			if (ext_essent_len != strlen(ext->name)) {
  6466				ext->essent_name = kstrndup(ext->name, ext_essent_len, GFP_KERNEL);
  6467				if (!ext->essent_name)
  6468					return -ENOMEM;
  6469			}
  6470	
  6471			ext->sec_btf_id = find_extern_sec_btf_id(obj->btf, ext->btf_id);
  6472			if (ext->sec_btf_id <= 0) {
  6473				pr_warn("failed to find BTF for extern '%s' [%d] section: %d\n",
  6474					ext_name, ext->btf_id, ext->sec_btf_id);
  6475				return ext->sec_btf_id;
  6476			}
  6477	
  6478			sec = (void *)btf_type_by_id(obj->btf, ext->sec_btf_id);
  6479			sec_name = btf_str_by_offset(obj->btf, sec->name_off);
  6480	
  6481			if (strcmp(sec_name, ".kconfig") == 0) {
  6482				if (btf_type_is_func(t)) {
  6483					pr_warn("extern function %s is unsupported under .kconfig section\n",
  6484						ext->name);
  6485					return -EOPNOTSUPP;
  6486				}
  6487				kcfg_sec = sec;
  6488				ext->type = EXT_KCFG;
  6489	
  6490				if (!btf_resolve_size(obj->btf, t, &size)) {
  6491					pr_warn("failed to resolve size of extern (kcfg) '%s': %d\n",
  6492						ext_name, ext->kcfg.sz);
  6493					return -EINVAL;
  6494				}
  6495				ext->kcfg.sz = size;
  6496				ext->kcfg.align = btf_align_of(obj->btf, t->type);
  6497				if (ext->kcfg.align <= 0) {
  6498					pr_warn("failed to determine alignment of extern (kcfg) '%s': %d\n",
  6499						ext_name, ext->kcfg.align);
  6500					return -EINVAL;
  6501				}
  6502				ext->kcfg.type = find_kcfg_type(obj->btf, t->type,
  6503								&ext->kcfg.is_signed);
  6504				if (ext->kcfg.type == KCFG_UNKNOWN) {
  6505					pr_warn("extern (kcfg) '%s': type is unsupported\n", ext_name);
  6506					return -EOPNOTSUPP;
  6507				}
  6508			} else if (strcmp(sec_name, ".ksyms") == 0) {
  6509				ksym_sec = sec;
  6510				ext->type = EXT_KSYM;
  6511				skip_mods_and_typedefs(obj->btf, t->type,
  6512						       &ext->ksym.type_id);
  6513			} else {
  6514				pr_warn("unrecognized extern section '%s'\n", sec_name);
  6515				return -EOPNOTSUPP;
  6516			}
  6517		}
  6518	
  6519		sort(obj->externs, obj->nr_extern, sizeof(struct bpf_extern_desc),
  6520		     cmp_externs, NULL);
  6521	
  6522		if (ksym_sec) {
  6523			/* find existing 4-byte integer type in BTF to use for fake
  6524			 * extern variables in DATASEC
  6525			 */
  6526			int_btf_id = find_int_btf_id(obj->btf);
  6527	
  6528			/* For extern function, a dummy_var added earlier
  6529			 * will be used to replace the vs->type and
  6530			 * its name string will be used to refill
  6531			 * the missing param's name.
  6532			 */
  6533			dummy_var = btf_type_by_id(obj->btf, dummy_var_btf_id);
  6534			for (i = 0; i < obj->nr_extern; i++) {
  6535				ext = &obj->externs[i];
  6536				if (ext->type != EXT_KSYM)
  6537					continue;
  6538				pr_debug("extern (ksym) #%d: symbol %d, name %s\n",
  6539					 i, ext->sym_idx, ext->name);
  6540			}
  6541	
  6542			sec = ksym_sec;
  6543			n = btf_vlen(sec);
  6544			for (i = 0, off = 0; i < n; i++, off += sizeof(int)) {
  6545				vs = btf_var_secinfos(sec) + i;
  6546				vt = (void *)btf_type_by_id(obj->btf, vs->type);
  6547				ext_name = btf_str_by_offset(obj->btf, vt->name_off);
  6548				ext = find_extern_by_name(obj, ext_name);
  6549				if (!ext) {
  6550					pr_warn("failed to find extern definition for BTF %s\n",
  6551						ext_name);
  6552					return -ESRCH;
  6553				}
  6554				if (btf_type_is_func(vt)) {
  6555					func_proto = btf_type_by_id(obj->btf,
  6556								    vt->type);
  6557					param = btf_params(func_proto);
  6558					/* Reuse the dummy_var string if the
  6559					 * func proto does not have param name.
  6560					 */
  6561					for (j = 0; j < btf_vlen(func_proto); j++)
  6562						if (param[j].type && !param[j].name_off)
  6563							param[j].name_off =
  6564								dummy_var->name_off;
  6565					vs->type = dummy_var_btf_id;
  6566					vt->info &= ~0xffff;
  6567					vt->info |= BTF_FUNC_GLOBAL;
  6568				} else {
  6569					btf_var(vt)->linkage = BTF_VAR_GLOBAL_ALLOCATED;
  6570					vt->type = int_btf_id;
  6571				}
  6572				vs->offset = off;
  6573				vs->size = sizeof(int);
  6574			}
  6575			sec->size = off;
  6576		}
  6577	
  6578		if (kcfg_sec) {
  6579			sec = kcfg_sec;
  6580			/* for kcfg externs calculate their offsets within a .kconfig map */
  6581			off = 0;
  6582			for (i = 0; i < obj->nr_extern; i++) {
  6583				ext = &obj->externs[i];
  6584				if (ext->type != EXT_KCFG)
  6585					continue;
  6586	
  6587				ext->kcfg.data_off = roundup(off, ext->kcfg.align);
  6588				off = ext->kcfg.data_off + ext->kcfg.sz;
  6589				pr_debug("extern (kcfg) #%d: symbol %d, off %u, name %s\n",
  6590					 i, ext->sym_idx, ext->kcfg.data_off, ext->name);
  6591			}
  6592			sec->size = off;
  6593			n = btf_vlen(sec);
  6594			for (i = 0; i < n; i++) {
  6595				vs = btf_var_secinfos(sec) + i;
  6596				t = btf_type_by_id(obj->btf, vs->type);
  6597				ext_name = btf_str_by_offset(obj->btf, t->name_off);
  6598	
  6599				ext = find_extern_by_name(obj, ext_name);
  6600				if (!ext) {
  6601					pr_warn("failed to find extern definition for BTF var '%s'\n",
  6602						ext_name);
  6603					return -ESRCH;
  6604				}
  6605				btf_var(t)->linkage = BTF_VAR_GLOBAL_ALLOCATED;
  6606				vs->offset = ext->kcfg.data_off;
  6607			}
  6608		}
  6609		return 0;
  6610	}
  6611	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

