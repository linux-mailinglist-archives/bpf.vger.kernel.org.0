Return-Path: <bpf+bounces-48614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB93A09F98
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 01:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D35E188F005
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 00:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27EF1854;
	Sat, 11 Jan 2025 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOeCyk9i"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8FC184E
	for <bpf@vger.kernel.org>; Sat, 11 Jan 2025 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736556128; cv=none; b=FSyusfuSz0UyM7YrVQ7y43WYaXNp7DOIW2/1sxsPKR1NukfdLKJsqG+vzqwGZOC9S+e/gw1xgGKAtUxgSegIdb68A2z4/cKcZvxSCCrrBX+4zxTOaDmrUhtK7QhnZO6ZDNc5v4WnEc6y/Wti1MW0XW9woisgpAl8EyMP1kBnlgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736556128; c=relaxed/simple;
	bh=rctrNSWbJ47FTC8GaNCMrwKtugqJc455IsDJYhkNVI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY4IlCNEOW3WPc68mqwSit1yDJOzQ5CMyQlRlhxMQsweDSSq7GQv8OpCcZtJDcI7CivZ7iJdZJCQpJ1Ua1B9MeIlHvb96LXHhRUGDhaX7sh0VRmKhn/m/WlNo4LzY1R06+8spwhmQpvh23CFwlANue+fznJqmcygP+pZkqjFn5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOeCyk9i; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736556125; x=1768092125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rctrNSWbJ47FTC8GaNCMrwKtugqJc455IsDJYhkNVI0=;
  b=YOeCyk9iF2yyMvYysxUCRj/Qx0be0j+2okBklHz1o7m89LLCUbrxSfgh
   rm1H0AGFlSvYSWdj6bbkTnQtznqmAuuYcLgp0PrgajCETfm3rjIiGcRwd
   v2sczVtYvbpi/dBc2UePq5Xo5FDPZgMGYcmRWBlEm991S0VzIGgIbowbr
   2yFgT6NEC720LqIW6xfBoNq4ex/a8wsKHqFEptCwfSL4sRF18zn1Zn/th
   7U/0Mx3LVn0MpRbCoa25wdIbNv/Glql0p96UvwF6nx8Fja6+DxT1D0TfU
   3XBIyBjIBe2zMWQCQ3UozD9wHxON1FG6NAqA3u2f8klrETP3MX9ya0p8/
   g==;
X-CSE-ConnectionGUID: GLF58ZXlReWt1HOk+3Vz5Q==
X-CSE-MsgGUID: 4b9lVWZXTqK4ZcaIhbzMVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="37025189"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="37025189"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 16:42:05 -0800
X-CSE-ConnectionGUID: rkn+uTS6QVSekA16gUMFqA==
X-CSE-MsgGUID: Dl+j6nRXSPCThUSeYhdUJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108987625"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Jan 2025 16:42:02 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWPZf-000JyR-2p;
	Sat, 11 Jan 2025 00:41:59 +0000
Date: Sat, 11 Jan 2025 08:41:36 +0800
From: kernel test robot <lkp@intel.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, nkapron@google.com, teknoraver@meta.com,
	roberto.sassu@huawei.com, gregkh@linuxfoundation.org,
	paul@paul-moore.com, code@tyhicks.com, flaniel@linux.microsoft.com
Subject: Re: [PATCH 07/14] bpf: Implement BPF_LOAD_FD subcommand handler
Message-ID: <202501110812.QzSvbAtK-lkp@intel.com>
References: <20250109214617.485144-8-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109214617.485144-8-bboscaccy@linux.microsoft.com>

Hi Blaise,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf/master]
[also build test WARNING on linus/master v6.13-rc6]
[cannot apply to bpf-next/master next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Blaise-Boscaccy/bpf-Add-data-structures-for-managing-in-kernel-eBPF-relocations/20250110-064354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20250109214617.485144-8-bboscaccy%40linux.microsoft.com
patch subject: [PATCH 07/14] bpf: Implement BPF_LOAD_FD subcommand handler
config: i386-buildonly-randconfig-003-20250111 (https://download.01.org/0day-ci/archive/20250111/202501110812.QzSvbAtK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501110812.QzSvbAtK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501110812.QzSvbAtK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'load_fd':
>> kernel/bpf/syscall.c:6290:47: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    6290 |                 if (copy_from_user(obj->maps, (const void *)attr->load_fd.maps,
         |                                               ^
   kernel/bpf/syscall.c:6310:45: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    6310 |                 if (copy_from_user(modules, (const void *)attr->load_fd.modules,
         |                                             ^
   kernel/bpf/syscall.c: At top level:
   kernel/bpf/syscall.c:6092:1: warning: 'skip_mods_and_typedefs' defined but not used [-Wunused-function]
    6092 | skip_mods_and_typedefs(const struct btf *btf, u32 id, u32 *res_id)
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/syscall.c:6082:13: warning: 'sym_is_extern' defined but not used [-Wunused-function]
    6082 | static bool sym_is_extern(const Elf64_Sym *sym)
         |             ^~~~~~~~~~~~~
   kernel/bpf/syscall.c:6056:12: warning: 'find_extern_sec_btf_id' defined but not used [-Wunused-function]
    6056 | static int find_extern_sec_btf_id(struct btf *btf, int ext_btf_id)
         |            ^~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/syscall.c:6016:12: warning: 'find_extern_btf_id' defined but not used [-Wunused-function]
    6016 | static int find_extern_btf_id(const struct btf *btf, const char *ext_name)
         |            ^~~~~~~~~~~~~~~~~~
   kernel/bpf/syscall.c:5998:12: warning: 'elf_sec_idx_by_name' defined but not used [-Wunused-function]
    5998 | static int elf_sec_idx_by_name(struct bpf_obj *obj, const char *name)
         |            ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/syscall.c:5948:24: warning: 'btf_ext__new' defined but not used [-Wunused-function]
    5948 | static struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
         |                        ^~~~~~~~~~~~


vim +6290 kernel/bpf/syscall.c

  6233	
  6234	static int load_fd(union bpf_attr *attr)
  6235	{
  6236		void *buf = NULL;
  6237		int len;
  6238		int i;
  6239		int obj_f;
  6240		struct fd obj_fd;
  6241		struct bpf_module_obj *modules;
  6242		struct bpf_obj *obj;
  6243		int err;
  6244	
  6245		struct fd f;
  6246		struct fd bpffs_fd;
  6247	
  6248		f = fdget(attr->load_fd.obj_fd);
  6249		if (!fd_file(f)) {
  6250			err = -EBADF;
  6251			goto out;
  6252		}
  6253	
  6254		bpffs_fd = fdget(attr->load_fd.bpffs_fd);
  6255		if (!fd_file(bpffs_fd)) {
  6256			fdput(f);
  6257			err = -EBADF;
  6258			goto out;
  6259		}
  6260	
  6261		obj_f = loader_create(attr->load_fd.bpffs_fd);
  6262		if (obj_f < 0) {
  6263			err = obj_f;
  6264			fdput(f);
  6265			fdput(bpffs_fd);
  6266			goto out;
  6267		}
  6268	
  6269		obj_fd = fdget(obj_f);
  6270		obj = fd_file(obj_fd)->private_data;
  6271	
  6272		len = kernel_read_file(fd_file(f), 0, &buf, INT_MAX, NULL, READING_EBPF);
  6273		if (len < 0) {
  6274			fdput(obj_fd);
  6275			err = len;
  6276			goto out;
  6277		}
  6278	
  6279		obj->hdr = buf;
  6280		obj->len = len;
  6281		obj->nr_maps = attr->load_fd.map_cnt;
  6282		obj->maps = kmalloc_array(attr->load_fd.map_cnt, sizeof(struct bpf_map_obj), GFP_KERNEL);
  6283	
  6284		if (!obj->maps) {
  6285			err = -ENOMEM;
  6286			goto free;
  6287		}
  6288	
  6289		if (attr->load_fd.map_cnt) {
> 6290			if (copy_from_user(obj->maps, (const void *)attr->load_fd.maps,
  6291					   sizeof(struct bpf_map_obj) * attr->load_fd.map_cnt) != 0) {
  6292				err = -EFAULT;
  6293				goto free;
  6294			}
  6295		}
  6296	
  6297		obj->kconfig_map_idx = attr->load_fd.kconfig_map_idx;
  6298		obj->arena_map_idx = attr->load_fd.arena_map_idx;
  6299		obj->btf_vmlinux = bpf_get_btf_vmlinux();
  6300		modules = kmalloc_array(attr->load_fd.module_cnt,
  6301					sizeof(struct bpf_module_obj), GFP_KERNEL);
  6302	
  6303		if (!modules) {
  6304			err = -ENOMEM;
  6305			goto free;
  6306		}
  6307	
  6308	
  6309		if (attr->load_fd.module_cnt) {
  6310			if (copy_from_user(modules, (const void *)attr->load_fd.modules,
  6311					   sizeof(struct bpf_module_obj) * attr->load_fd.module_cnt) != 0) {
  6312				err = -EFAULT;
  6313				goto free;
  6314			}
  6315		}
  6316	
  6317		obj->btf_modules_cnt = attr->load_fd.module_cnt;
  6318		obj->btf_modules = kmalloc_array(attr->load_fd.module_cnt,
  6319						 sizeof(struct bpf_module_btf), GFP_KERNEL);
  6320	
  6321		if (!obj->btf_modules) {
  6322			err = -ENOMEM;
  6323			goto free;
  6324		}
  6325	
  6326		for (i = 0; i < obj->btf_modules_cnt; i++) {
  6327			obj->btf_modules[i].fd = modules[i].fd;
  6328			obj->btf_modules[i].id = modules[i].id;
  6329			obj->btf_modules[i].fd_array_idx = modules[i].fd_array_idx;
  6330			obj->btf_modules[i].btf = btf_get_by_fd(obj->btf_modules[i].fd);
  6331			if (IS_ERR(obj->btf_modules[i].btf)) {
  6332				err = PTR_ERR(obj->btf_modules[i].btf);
  6333				kfree(modules);
  6334				goto free;
  6335			}
  6336		}
  6337		kfree(modules);
  6338	
  6339		return obj_f;
  6340	free:
  6341		free_bpf_obj(obj);
  6342		fd_file(obj_fd)->private_data = NULL;
  6343	out:
  6344		return err;
  6345	}
  6346	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

