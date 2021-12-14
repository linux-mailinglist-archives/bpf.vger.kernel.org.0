Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D8B474BE4
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 20:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhLNT20 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 14:28:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:59894 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237418AbhLNT2Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 14:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639510104; x=1671046104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nzdGFgj1vufDl0qRro1wulMrLeARl5Z/1fFjf59oDyk=;
  b=ETctNUERFzN4j5DLIHKkY2cQy9J1vuYFzrPNq4Ra8Y6hB9sE1HDN7uv0
   O4CkIokJH67CWRgz+QchsEa2S4L918mf9Tr7HbQWf2Jt3EAxWG/h9P3Ky
   MdZFkQzafG8PPwc5ypB0vOmOidUVAQfo1vP8qCcCQS6prYrjoARGWL4LG
   EvNo7Lh7z1n1emKVp+bQO9w62AGY69euZBoE3VbXmB7UErXFXPRh3dWwt
   z1JWcanZ5EN84MZ43PoecpLyvOlNyem9zH5wMQtj+l475dHguHHNq/u1+
   w4MI0riSW6/CXz+cvdEew5oUkzDavbIYsgnmjmmBkK42aN84N0BdRUPSD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="239290845"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="239290845"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 11:28:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="463928000"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Dec 2021 11:28:22 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxDTJ-0000g8-GL; Tue, 14 Dec 2021 19:28:21 +0000
Date:   Wed, 15 Dec 2021 03:27:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     kbuild-all@lists.01.org, bpf@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf-next 4/5] bpf: remove the cgroup -> bpf header
 dependecy
Message-ID: <202112150326.PHRPQfmk-lkp@intel.com>
References: <20211213234223.356977-5-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213234223.356977-5-kuba@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jakub,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Jakub-Kicinski/bpf-remove-the-cgroup-bpf-header-dependecy/20211214-074344
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: s390-randconfig-r023-20211213 (https://download.01.org/0day-ci/archive/20211215/202112150326.PHRPQfmk-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/517f95dd6d9264e4104cfc35eecdd5c1287738ae
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jakub-Kicinski/bpf-remove-the-cgroup-bpf-header-dependecy/20211214-074344
        git checkout 517f95dd6d9264e4104cfc35eecdd5c1287738ae
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/s390/mm/hugetlbpage.c: In function 'hugetlb_get_unmapped_area':
>> arch/s390/mm/hugetlbpage.c:352:16: error: implicit declaration of function 'check_asce_limit'; did you mean 'check_data_rlimit'? [-Werror=implicit-function-declaration]
     352 |         return check_asce_limit(mm, addr, len);
         |                ^~~~~~~~~~~~~~~~
         |                check_data_rlimit
   cc1: some warnings being treated as errors


vim +352 arch/s390/mm/hugetlbpage.c

5f490a520bcb393 Gerald Schaefer   2020-01-16  315  
5f490a520bcb393 Gerald Schaefer   2020-01-16  316  unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
5f490a520bcb393 Gerald Schaefer   2020-01-16  317  		unsigned long len, unsigned long pgoff, unsigned long flags)
5f490a520bcb393 Gerald Schaefer   2020-01-16  318  {
5f490a520bcb393 Gerald Schaefer   2020-01-16  319  	struct hstate *h = hstate_file(file);
5f490a520bcb393 Gerald Schaefer   2020-01-16  320  	struct mm_struct *mm = current->mm;
5f490a520bcb393 Gerald Schaefer   2020-01-16  321  	struct vm_area_struct *vma;
5f490a520bcb393 Gerald Schaefer   2020-01-16  322  
5f490a520bcb393 Gerald Schaefer   2020-01-16  323  	if (len & ~huge_page_mask(h))
5f490a520bcb393 Gerald Schaefer   2020-01-16  324  		return -EINVAL;
5f490a520bcb393 Gerald Schaefer   2020-01-16  325  	if (len > TASK_SIZE - mmap_min_addr)
5f490a520bcb393 Gerald Schaefer   2020-01-16  326  		return -ENOMEM;
5f490a520bcb393 Gerald Schaefer   2020-01-16  327  
5f490a520bcb393 Gerald Schaefer   2020-01-16  328  	if (flags & MAP_FIXED) {
5f490a520bcb393 Gerald Schaefer   2020-01-16  329  		if (prepare_hugepage_range(file, addr, len))
5f490a520bcb393 Gerald Schaefer   2020-01-16  330  			return -EINVAL;
5f490a520bcb393 Gerald Schaefer   2020-01-16  331  		goto check_asce_limit;
5f490a520bcb393 Gerald Schaefer   2020-01-16  332  	}
5f490a520bcb393 Gerald Schaefer   2020-01-16  333  
5f490a520bcb393 Gerald Schaefer   2020-01-16  334  	if (addr) {
5f490a520bcb393 Gerald Schaefer   2020-01-16  335  		addr = ALIGN(addr, huge_page_size(h));
5f490a520bcb393 Gerald Schaefer   2020-01-16  336  		vma = find_vma(mm, addr);
5f490a520bcb393 Gerald Schaefer   2020-01-16  337  		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
5f490a520bcb393 Gerald Schaefer   2020-01-16  338  		    (!vma || addr + len <= vm_start_gap(vma)))
5f490a520bcb393 Gerald Schaefer   2020-01-16  339  			goto check_asce_limit;
5f490a520bcb393 Gerald Schaefer   2020-01-16  340  	}
5f490a520bcb393 Gerald Schaefer   2020-01-16  341  
5f490a520bcb393 Gerald Schaefer   2020-01-16  342  	if (mm->get_unmapped_area == arch_get_unmapped_area)
5f490a520bcb393 Gerald Schaefer   2020-01-16  343  		addr = hugetlb_get_unmapped_area_bottomup(file, addr, len,
5f490a520bcb393 Gerald Schaefer   2020-01-16  344  				pgoff, flags);
5f490a520bcb393 Gerald Schaefer   2020-01-16  345  	else
5f490a520bcb393 Gerald Schaefer   2020-01-16  346  		addr = hugetlb_get_unmapped_area_topdown(file, addr, len,
5f490a520bcb393 Gerald Schaefer   2020-01-16  347  				pgoff, flags);
712fa5f294f377e Alexander Gordeev 2020-03-23  348  	if (offset_in_page(addr))
5f490a520bcb393 Gerald Schaefer   2020-01-16  349  		return addr;
5f490a520bcb393 Gerald Schaefer   2020-01-16  350  
5f490a520bcb393 Gerald Schaefer   2020-01-16  351  check_asce_limit:
712fa5f294f377e Alexander Gordeev 2020-03-23 @352  	return check_asce_limit(mm, addr, len);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
