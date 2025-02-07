Return-Path: <bpf+bounces-50773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B77A2C61A
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 15:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FCE916B9FF
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 14:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A01240602;
	Fri,  7 Feb 2025 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qt/Q3gl0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F53DAC13;
	Fri,  7 Feb 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939584; cv=none; b=n8WYqTGMxuN7Hkd1RV1dKMAXF/VD762e7djRjrfd9dG3Fnz+DjLzbwssccYEoTAR9TxxPTXoflebq3vMFnpAYLTJIOTfXS73WcUexGly7L1YNmI+ICtu8LRmrOWvSRWAdWWBm+EWmGfg2RUSwykoACvAqjAqA9OILoHbo6M3+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939584; c=relaxed/simple;
	bh=vC/OWDm/dfWU9Rdnb1rw4VdhifWMLCVsGEWZ1Y/wwg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5PjKVELA3p7dyNcfErBMcHXABQcZyrIByfSUZTFk2I5oKp7E2qQXcpxrNKibb4+FVZA3i9XlkVQgYlQ2+3rohohUzbLi54wFpCjqu2ohAkM/Y3u9908x27jBPhOnkQ6w4D1kWlekRQD+nZNVOjNL29pH9czg64uEvIZUyzINYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qt/Q3gl0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738939581; x=1770475581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vC/OWDm/dfWU9Rdnb1rw4VdhifWMLCVsGEWZ1Y/wwg0=;
  b=Qt/Q3gl0kRxvGbxX3H59VkodAfn2jAMCMOYt3EohJ4NHw1TMvBShN4Rx
   78x4aUaR1nV9LQBgCSx8xEpxSs0zsVUtAxBI5AL7Ex16vvwcNehnThJR0
   29PX7GWUsNa9inPrMNJ45DKMbNXSOYzL8mk6CxFrQckVva/Vp4Tbki/Vh
   Qa7XTLSiwpk7eWNKI4kCRVNyvgrljwhUPVtGkRgiScSv/+EgT/mM4F+wW
   ymnCRtCa6EfAHAmIyrLJnI0+DGdAWLBY836oQK/eVpxfhH+iV4Du7QLAe
   5RGsMBCsyYgTHrvdPYWksQdfifRlJgr+p+DRcGptFFiNePdZHblVnbSsd
   w==;
X-CSE-ConnectionGUID: h/ZDeoKVRp2oMWf6x7PWYA==
X-CSE-MsgGUID: 0Tl35fpmTmqvjJndwqleWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="56997470"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="56997470"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 06:46:21 -0800
X-CSE-ConnectionGUID: PLb9YVuETr67WQ2KncdH5Q==
X-CSE-MsgGUID: 4WBlToFGQvOsbbsT4/3MBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="111461551"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 Feb 2025 06:46:16 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgPcU-000yTX-08;
	Fri, 07 Feb 2025 14:46:14 +0000
Date: Fri, 7 Feb 2025 22:45:31 +0800
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
Message-ID: <202502072210.Fzbbpkun-lkp@intel.com>
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
config: arm-randconfig-001-20250207 (https://download.01.org/0day-ci/archive/20250207/202502072210.Fzbbpkun-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250207/202502072210.Fzbbpkun-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502072210.Fzbbpkun-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from kernel/locking/rqspinlock.c:77:
>> kernel/locking/mcs_spinlock.h:57:27: warning: 'struct mcs_spinlock' declared inside parameter list will not be visible outside of this definition or declaration
      57 | void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
         |                           ^~~~~~~~~~~~
   kernel/locking/mcs_spinlock.h: In function 'mcs_spin_lock':
>> kernel/locking/mcs_spinlock.h:62:13: error: invalid use of undefined type 'struct mcs_spinlock'
      62 |         node->locked = 0;
         |             ^~
   kernel/locking/mcs_spinlock.h:63:13: error: invalid use of undefined type 'struct mcs_spinlock'
      63 |         node->next   = NULL;
         |             ^~
   In file included from <command-line>:
   kernel/locking/mcs_spinlock.h:83:24: error: invalid use of undefined type 'struct mcs_spinlock'
      83 |         WRITE_ONCE(prev->next, node);
         |                        ^~
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/locking/mcs_spinlock.h:83:9: note: in expansion of macro 'WRITE_ONCE'
      83 |         WRITE_ONCE(prev->next, node);
         |         ^~~~~~~~~~
   kernel/locking/mcs_spinlock.h:83:24: error: invalid use of undefined type 'struct mcs_spinlock'
      83 |         WRITE_ONCE(prev->next, node);
         |                        ^~
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/locking/mcs_spinlock.h:83:9: note: in expansion of macro 'WRITE_ONCE'
      83 |         WRITE_ONCE(prev->next, node);
         |         ^~~~~~~~~~
   kernel/locking/mcs_spinlock.h:83:24: error: invalid use of undefined type 'struct mcs_spinlock'
      83 |         WRITE_ONCE(prev->next, node);
         |                        ^~
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/locking/mcs_spinlock.h:83:9: note: in expansion of macro 'WRITE_ONCE'
      83 |         WRITE_ONCE(prev->next, node);
         |         ^~~~~~~~~~
   kernel/locking/mcs_spinlock.h:83:24: error: invalid use of undefined type 'struct mcs_spinlock'
      83 |         WRITE_ONCE(prev->next, node);
         |                        ^~
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/locking/mcs_spinlock.h:83:9: note: in expansion of macro 'WRITE_ONCE'
      83 |         WRITE_ONCE(prev->next, node);
         |         ^~~~~~~~~~
   kernel/locking/mcs_spinlock.h:83:24: error: invalid use of undefined type 'struct mcs_spinlock'
      83 |         WRITE_ONCE(prev->next, node);
         |                        ^~
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'


vim +62 kernel/locking/mcs_spinlock.h

e207552e64ea05 include/linux/mcs_spinlock.h  Will Deacon     2014-01-21  39  
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  40  /*
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  41   * Note: the smp_load_acquire/smp_store_release pair is not
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  42   * sufficient to form a full memory barrier across
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  43   * cpus for many architectures (except x86) for mcs_unlock and mcs_lock.
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  44   * For applications that need a full barrier across multiple cpus
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  45   * with mcs_unlock and mcs_lock pair, smp_mb__after_unlock_lock() should be
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  46   * used after mcs_lock.
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  47   */
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  48  
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  49  /*
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  50   * In order to acquire the lock, the caller should declare a local node and
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  51   * pass a reference of the node to this function in addition to the lock.
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  52   * If the lock has already been acquired, then this will proceed to spin
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  53   * on this node->locked until the previous lock holder sets the node->locked
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  54   * in mcs_spin_unlock().
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  55   */
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  56  static inline
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21 @57  void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  58  {
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  59  	struct mcs_spinlock *prev;
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  60  
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  61  	/* Init node */
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21 @62  	node->locked = 0;
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  63  	node->next   = NULL;
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  64  
920c720aa5aa39 kernel/locking/mcs_spinlock.h Peter Zijlstra  2016-02-01  65  	/*
920c720aa5aa39 kernel/locking/mcs_spinlock.h Peter Zijlstra  2016-02-01  66  	 * We rely on the full barrier with global transitivity implied by the
920c720aa5aa39 kernel/locking/mcs_spinlock.h Peter Zijlstra  2016-02-01  67  	 * below xchg() to order the initialization stores above against any
920c720aa5aa39 kernel/locking/mcs_spinlock.h Peter Zijlstra  2016-02-01  68  	 * observation of @node. And to provide the ACQUIRE ordering associated
920c720aa5aa39 kernel/locking/mcs_spinlock.h Peter Zijlstra  2016-02-01  69  	 * with a LOCK primitive.
920c720aa5aa39 kernel/locking/mcs_spinlock.h Peter Zijlstra  2016-02-01  70  	 */
920c720aa5aa39 kernel/locking/mcs_spinlock.h Peter Zijlstra  2016-02-01  71  	prev = xchg(lock, node);
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  72  	if (likely(prev == NULL)) {
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  73  		/*
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  74  		 * Lock acquired, don't need to set node->locked to 1. Threads
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  75  		 * only spin on its own node->locked value for lock acquisition.
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  76  		 * However, since this thread can immediately acquire the lock
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  77  		 * and does not proceed to spin on its own node->locked, this
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  78  		 * value won't be used. If a debug mode is needed to
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  79  		 * audit lock status, then set node->locked value here.
5faeb8adb956a5 include/linux/mcs_spinlock.h  Jason Low       2014-01-21  80  		 */
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  81  		return;
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  82  	}
4d3199e4ca8e66 kernel/locking/mcs_spinlock.h Davidlohr Bueso 2015-02-22  83  	WRITE_ONCE(prev->next, node);
e207552e64ea05 include/linux/mcs_spinlock.h  Will Deacon     2014-01-21  84  
e207552e64ea05 include/linux/mcs_spinlock.h  Will Deacon     2014-01-21  85  	/* Wait until the lock holder passes the lock down. */
e207552e64ea05 include/linux/mcs_spinlock.h  Will Deacon     2014-01-21  86  	arch_mcs_spin_lock_contended(&node->locked);
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  87  }
e72246748ff006 include/linux/mcs_spinlock.h  Tim Chen        2014-01-21  88  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

