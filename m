Return-Path: <bpf+bounces-49826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C07A1C842
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 15:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF20164224
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D61149C55;
	Sun, 26 Jan 2025 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIn+aKcO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B525A652
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900584; cv=none; b=pq6w4pWSorcyVk4Z4m3YJHR8389GcXJUnUV8w8ze2aFUynKvwbBtf8TBYrEElq6mvVWu8vcAZY/Vg3r0PlH+Va3Pjx4rxjel0sel4ZxkJlGhg9O+KZSmYGhXwZ1aj7u9EZyJGpUlSDDF+VMc7+q7gKTqh66lKB1YrVgFJ/uC+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900584; c=relaxed/simple;
	bh=SN28Hz4kBPo9CE4Gfvp1PzH22or5pSlMhQJuJbCKFdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS7eN2Qe4HPCkclTR/AzqpGUMBtKxTDIFsPlvvr+YVDNaQ+EZgn9F2Py5ljp3K1YVRWTWlZxDdCDWsvcXJZAVkXOg4dPulrCuVlIlE/cLApTx5p7iaRrQYdGqwOQelvisHjAiXiciIOFcj/ZK8JOn5DZ7vR1EV2Z3l2x26ovXWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIn+aKcO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737900582; x=1769436582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SN28Hz4kBPo9CE4Gfvp1PzH22or5pSlMhQJuJbCKFdE=;
  b=CIn+aKcO8KTSNYaLtfo+fJhg5iPpbSE0Kn3N6C2LAmDhjTa1863u50zp
   eW6eg+9SEJkvjMPcmw1C/uJ9BguS3V1XQsv6rRUNHSXeBLOydHBnzBHj9
   Ft+t0UYu9/70j6siTUYTNH+6COf0bbt6NLOaIfmNgjRXe0pdhDwaG1W63
   bPeDDTJH8tTwzlKux6YLyZFH6S5kbMN0NLN6K3zbd9ai/qetk41YllF0J
   k2A3LmLDrTu8PIUuCAAUtiBDUohk4tTGPQz8O+1TocqTSHqy2+HNloY3H
   6nU0QCkKzIv/TZeGNnxqp2TVLSGjd+hdbpdS38tOSWfWuiXB5OzqZg8pg
   A==;
X-CSE-ConnectionGUID: cwvCyv49QaSN77E/PYQo3A==
X-CSE-MsgGUID: aNRUvsdfQa+h8FWCNp697A==
X-IronPort-AV: E=McAfee;i="6700,10204,11327"; a="63729727"
X-IronPort-AV: E=Sophos;i="6.13,236,1732608000"; 
   d="scan'208";a="63729727"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2025 06:09:42 -0800
X-CSE-ConnectionGUID: 1LQVlRlOSDSoDpCzpDXxAQ==
X-CSE-MsgGUID: xny16wPYTAeSahberUmNcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,236,1732608000"; 
   d="scan'208";a="113233046"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 26 Jan 2025 06:09:39 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tc3KS-000fPz-1h;
	Sun, 26 Jan 2025 14:09:36 +0000
Date: Sun, 26 Jan 2025 22:08:37 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Rome <linux@jordanrome.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [bpf-next v4 1/3] mm: add copy_remote_vm_str
Message-ID: <202501262133.9mKauA5U-lkp@intel.com>
References: <20250126124147.3154108-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250126124147.3154108-1-linux@jordanrome.com>

Hi Jordan,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on bpf/master linus/master v6.13 next-20250124]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jordan-Rome/bpf-Add-bpf_copy_from_user_task_str-kfunc/20250126-204439
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250126124147.3154108-1-linux%40jordanrome.com
patch subject: [bpf-next v4 1/3] mm: add copy_remote_vm_str
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20250126/202501262133.9mKauA5U-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250126/202501262133.9mKauA5U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501262133.9mKauA5U-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/nommu.c:1717:2: error: use of undeclared identifier 'vma'
    1717 |         vma = find_vma(mm, addr);
         |         ^
   mm/nommu.c:1718:6: error: use of undeclared identifier 'vma'; did you mean 'vmap'?
    1718 |         if (vma) {
         |             ^~~
         |             vmap
   mm/nommu.c:303:15: note: 'vmap' declared here
     303 | EXPORT_SYMBOL(vmap);
         |               ^
   mm/nommu.c:1720:21: error: use of undeclared identifier 'vma'
    1720 |                 if (addr + len >= vma->vm_end)
         |                                   ^
   mm/nommu.c:1721:10: error: use of undeclared identifier 'vma'
    1721 |                         len = vma->vm_end - addr;
         |                               ^
   mm/nommu.c:1724:7: error: use of undeclared identifier 'vma'
    1724 |                 if (vma->vm_flags & VM_MAYREAD) {
         |                     ^
>> mm/nommu.c:1725:23: error: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const char *' [-Wint-conversion]
    1725 |                         ret = strscpy(buf, addr, len);
         |                                            ^~~~
   include/linux/string.h:113:55: note: expanded from macro 'strscpy'
     113 |         CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
         |                                                              ^~~
   include/linux/string.h:82:21: note: expanded from macro '__strscpy1'
      82 |         sized_strscpy(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
         |                            ^~~
   include/linux/string.h:72:43: note: passing argument to parameter here
      72 | ssize_t sized_strscpy(char *, const char *, size_t);
         |                                           ^
   6 errors generated.


vim +/vma +1717 mm/nommu.c

  1703	
  1704	/*
  1705	 * Copy a string from another process's address space as given in mm.
  1706	 * If there is any error return -EFAULT.
  1707	 */
  1708	static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
  1709				      void *buf, int len)
  1710	{
  1711		int ret;
  1712	
  1713		if (mmap_read_lock_killable(mm))
  1714			return -EFAULT;
  1715	
  1716		/* the access must start within one of the target process's mappings */
> 1717		vma = find_vma(mm, addr);
  1718		if (vma) {
  1719			/* don't overrun this mapping */
> 1720			if (addr + len >= vma->vm_end)
  1721				len = vma->vm_end - addr;
  1722	
  1723			/* only read mappings where it is permitted */
  1724			if (vma->vm_flags & VM_MAYREAD) {
> 1725				ret = strscpy(buf, addr, len);
  1726				if (ret < 0)
  1727					ret = len - 1;
  1728			} else {
  1729				ret = -EFAULT;
  1730			}
  1731		} else {
  1732			ret = -EFAULT;
  1733		}
  1734	
  1735		mmap_read_unlock(mm);
  1736		return ret;
  1737	}
  1738	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

