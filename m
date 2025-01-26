Return-Path: <bpf+bounces-49832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F1A1C86A
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 15:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422D218865E5
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF61155333;
	Sun, 26 Jan 2025 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMeTi7qr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300844A01
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737901785; cv=none; b=Z5TRmEFC7W+YQxINEOBqncMPnjWdr3g71VLrudx8h7tOIM2raLpqT2NsxjrnZjxWeWhoyA/RqRIT8H3tIkDF/SxrC1efMYbCY9aipAmrd3XBKpUWLLHk+5uR5hX7OWzi93lk3bkfrddrb0l6p/ulYpNjV8FT6nyz5NiXEmkGR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737901785; c=relaxed/simple;
	bh=ICwCtmajtbeCHxXOWQp9heFfoiRu9FikxqdBEmxACJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCE51W+XbSElo3z/WPsNItMQ9CA/ExAcM+7raSHICUhvDKjeA5xs9ATmwrNzxRnjNly4pnnk+v5rI0CjmnL4yzY57XcXnjRzg8ktV5dpQ6PYiKkgNve4lDZkymvNz/KnduH4M6L+sNXoZS3BGBuMDOt62b1miN48W4dnds0rHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMeTi7qr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737901783; x=1769437783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ICwCtmajtbeCHxXOWQp9heFfoiRu9FikxqdBEmxACJE=;
  b=nMeTi7qrVfSB6t0pYUUSCg7AAdbB8qan1xfC9vBIra01pLiamAaqkQ0l
   owaukwVxKqeJQZfLSKDxfiN858VEFKqiHP4XnHvEIbVqeiCnC5eKshW4Z
   /zrPlXcL4lUzz7+YjYJFvVZ3ew0ZF+s9LdITThFS/aJO8Ao7BMFR1rJCA
   /bLNjIYSScUoC3nr2/v+beBV9clK6ZJ99SmJnr6J4VppA6fGCsvBESQ1E
   58EJyZdFOwS2M12B9EntwocSwcFeuTPawLmA8lklDUH1Yi/V4HYhjQG6K
   +jU1VXizRYTneo7iJZqAYw+7Muj3riOr986LD3aWUUcF0a12ZFjMiFb7r
   g==;
X-CSE-ConnectionGUID: apOI0NWrTPac3HDETJP6XQ==
X-CSE-MsgGUID: HwWa6RbvRguiq/HRbvCCKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11327"; a="55915037"
X-IronPort-AV: E=Sophos;i="6.13,236,1732608000"; 
   d="scan'208";a="55915037"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2025 06:29:43 -0800
X-CSE-ConnectionGUID: znWr7inoSsCAeGOhhkVZsw==
X-CSE-MsgGUID: K0eMfUkJR3SFuE/oprmQyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,236,1732608000"; 
   d="scan'208";a="108794286"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 26 Jan 2025 06:29:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tc3dp-000fQd-2J;
	Sun, 26 Jan 2025 14:29:37 +0000
Date: Sun, 26 Jan 2025 22:28:55 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Rome <linux@jordanrome.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [bpf-next v4 1/3] mm: add copy_remote_vm_str
Message-ID: <202501262241.ZEkByWKM-lkp@intel.com>
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
config: arm-randconfig-001-20250126 (https://download.01.org/0day-ci/archive/20250126/202501262241.ZEkByWKM-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250126/202501262241.ZEkByWKM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501262241.ZEkByWKM-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/nommu.c: In function '__copy_remote_vm_str':
>> mm/nommu.c:1717:9: error: 'vma' undeclared (first use in this function); did you mean 'vmap'?
    1717 |         vma = find_vma(mm, addr);
         |         ^~~
         |         vmap
   mm/nommu.c:1717:9: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from mm/nommu.c:20:
>> mm/nommu.c:1725:44: error: passing argument 2 of 'sized_strscpy' makes pointer from integer without a cast [-Wint-conversion]
    1725 |                         ret = strscpy(buf, addr, len);
         |                                            ^~~~
         |                                            |
         |                                            long unsigned int
   include/linux/string.h:82:28: note: in definition of macro '__strscpy1'
      82 |         sized_strscpy(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
         |                            ^~~
   mm/nommu.c:1725:31: note: in expansion of macro 'strscpy'
    1725 |                         ret = strscpy(buf, addr, len);
         |                               ^~~~~~~
   include/linux/string.h:72:31: note: expected 'const char *' but argument is of type 'long unsigned int'
      72 | ssize_t sized_strscpy(char *, const char *, size_t);
         |                               ^~~~~~~~~~~~


vim +1717 mm/nommu.c

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
  1720			if (addr + len >= vma->vm_end)
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

