Return-Path: <bpf+bounces-50768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D1EA2C4FE
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 15:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E557A1693
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E323873F;
	Fri,  7 Feb 2025 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7xRBf37"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25E2376F3;
	Fri,  7 Feb 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937721; cv=none; b=qKWaf3KEDNyXUws5FswnaIjwlSH+dZhAcfJKv8GXgKTAj2p6T8AnB3ncjaSKjTYIbMA3SxffhKrS6QtGdnK1fGk5yXSDpynZ97cs/MU2SS7O+VaDq4TOff9FRhlCnDwS3RcbCwyE3OgdFuzJL3hIYwE037n5V8gW9ueIm/H5s5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937721; c=relaxed/simple;
	bh=1FkVz/U+uzeZGFUK+7kMEhIACeTn3T5bXbi5T/k6aZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGq6ZVhmN2+nI7b1IyMX7LH+cd94Ft37P5jTEpDqW5xS1Votu1bYVRR6hoUtjDhFFryEB6NfmTs2fAljQwbhoREPE85Cb5xekFDVtzNvRb3t2SYy2dHaFrUK4iEIksRRKYQr8CW0Qpg9ekWJjtEvdQlHnopYk3rIPfkXkyqQwGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7xRBf37; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738937718; x=1770473718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1FkVz/U+uzeZGFUK+7kMEhIACeTn3T5bXbi5T/k6aZk=;
  b=b7xRBf37J/+PK+UivemSuJzVmGA8xC3FMnNNOedbcQ/6BYp5Xz2UEy9e
   YRtEQzcQcscc6CPEHpVHS1leb8yEUTW5vyhrr42RnACw9mP5KktUTgVF+
   iPyTbRPFg+kjmZwMjbIw4TIOmd2UYkAbyvqKxs2JQgpNn6IDxei9tauHt
   ENPOlyCKYxuxzgZfqFrJ++FV06DD+8VnYMBMVF5gYScep3bELHC/Uid+T
   zbgwtY/vzkZwMEstfjqk/R2wg+Kq8sLN+xEqjF5ivd104utfcuibFiD5z
   fMJSuSpKslSFSvyxHE6OWwfpyOiE/+EKWxfx/TzWNWFMUd3vP5g1vh4BM
   w==;
X-CSE-ConnectionGUID: jJeuttIXSLyOpj07Eob58A==
X-CSE-MsgGUID: B3gmaKn6Tey/viWiw3dmiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50199281"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="50199281"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 06:15:17 -0800
X-CSE-ConnectionGUID: qP9Nwvi7S+aRp61EDQ3aIQ==
X-CSE-MsgGUID: RnF9zi/sS2yJP209glu42g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="111319995"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 Feb 2025 06:15:13 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgP8Q-000yQx-0z;
	Fri, 07 Feb 2025 14:15:10 +0000
Date: Fri, 7 Feb 2025 22:14:11 +0800
From: kernel test robot <lkp@intel.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 18/26] rqspinlock: Add entry to Makefile,
 MAINTAINERS
Message-ID: <202502072249.IXcsG9Tu-lkp@intel.com>
References: <20250206105435.2159977-19-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206105435.2159977-19-memxor@gmail.com>

Hi Kumar,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0abff462d802a352c87b7f5e71b442b09bf9cfff]

url:    https://github.com/intel-lab-lkp/linux/commits/Kumar-Kartikeya-Dwivedi/locking-Move-MCS-struct-definition-to-public-header/20250206-190258
base:   0abff462d802a352c87b7f5e71b442b09bf9cfff
patch link:    https://lore.kernel.org/r/20250206105435.2159977-19-memxor%40gmail.com
patch subject: [PATCH bpf-next v2 18/26] rqspinlock: Add entry to Makefile, MAINTAINERS
config: i386-randconfig-014-20250207 (https://download.01.org/0day-ci/archive/20250207/202502072249.IXcsG9Tu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250207/202502072249.IXcsG9Tu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502072249.IXcsG9Tu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/rqspinlock.h:27,
                    from kernel/locking/rqspinlock.c:28:
   include/asm-generic/rqspinlock.h:33:12: error: conflicting types for 'resilient_tas_spin_lock'; have 'int(rqspinlock_t *, u64)' {aka 'int(struct rqspinlock *, long long unsigned int)'}
      33 | extern int resilient_tas_spin_lock(rqspinlock_t *lock, u64 timeout);
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/rqspinlock.h:17:12: note: previous declaration of 'resilient_tas_spin_lock' with type 'int(struct qspinlock *, u64)' {aka 'int(struct qspinlock *, long long unsigned int)'}
      17 | extern int resilient_tas_spin_lock(struct qspinlock *lock, u64 timeout);
         |            ^~~~~~~~~~~~~~~~~~~~~~~
>> kernel/locking/rqspinlock.c:293:16: error: conflicting types for 'resilient_tas_spin_lock'; have 'int(rqspinlock_t *, u64)' {aka 'int(struct rqspinlock *, long long unsigned int)'}
     293 | int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock, u64 timeout)
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/rqspinlock.h:17:12: note: previous declaration of 'resilient_tas_spin_lock' with type 'int(struct qspinlock *, u64)' {aka 'int(struct qspinlock *, long long unsigned int)'}
      17 | extern int resilient_tas_spin_lock(struct qspinlock *lock, u64 timeout);
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/locking/rqspinlock.c:204:13: warning: 'rqspinlock_report_violation' defined but not used [-Wunused-function]
     204 | static void rqspinlock_report_violation(const char *s, void *lock)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +293 kernel/locking/rqspinlock.c

65ba402b78bc5d Kumar Kartikeya Dwivedi 2025-02-06  288  
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  289  /*
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  290   * Provide a test-and-set fallback for cases when queued spin lock support is
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  291   * absent from the architecture.
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  292   */
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06 @293  int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock, u64 timeout)
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  294  {
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  295  	struct rqspinlock_timeout ts;
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  296  	int val, ret = 0;
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  297  
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  298  	RES_INIT_TIMEOUT(ts, timeout);
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  299  	grab_held_lock_entry(lock);
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  300  retry:
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  301  	val = atomic_read(&lock->val);
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  302  
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  303  	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  304  		if (RES_CHECK_TIMEOUT(ts, ret, ~0u)) {
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  305  			lockevent_inc(rqspinlock_lock_timeout);
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  306  			goto out;
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  307  		}
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  308  		cpu_relax();
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  309  		goto retry;
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  310  	}
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  311  
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  312  	return 0;
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  313  out:
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  314  	release_held_lock_entry();
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  315  	return ret;
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  316  }
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  317  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

