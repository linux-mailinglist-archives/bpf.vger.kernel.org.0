Return-Path: <bpf+bounces-48237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF123A0580F
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 11:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B2F3A21CD
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 10:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327121F76CA;
	Wed,  8 Jan 2025 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k04vp9Sx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550A71F76C2;
	Wed,  8 Jan 2025 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736331844; cv=none; b=GUkQ9udZgxD1huO4ksEX5RHtkICPBHDJsGJMvaqVvMGl9zw0ZORNUuDJC1vsDYIFHUH1owTeSFwK5AXq3gZPcwt0HlY4WQRQS4Q2jYmpo/FvRxVUQ/CKCOn46iryzzXQ2k6PqPvf9t4sL3olalkgLtAV14tNTAGlKhCsHFTph2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736331844; c=relaxed/simple;
	bh=NgHJhWsjHuup8yWJLkd4uCUqqkKgRYIx5et08r8DQjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3BoYlt+OMEsZfmrK2A3McK5Y19Nvd+6EEIgH3+LvTQuhNpkxAxw/hRgrw/fTFje0O6HXJBC0JH+C6KcY6Vce13qaEwPBC675EN1TIgfFyroazuJ6hjSSaxpdcTCTH6J6HCW0Nfu+u82689SL2JiT4wYT5WLUC0OSQfUzRiAMoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k04vp9Sx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736331840; x=1767867840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NgHJhWsjHuup8yWJLkd4uCUqqkKgRYIx5et08r8DQjw=;
  b=k04vp9SxcF+MI63M8QCj3CMqhanZnYd4wI1lO5msqK0hz7E3eAvZgYFn
   ns1MnhfIj81k9EGD31l8abolz39a0ecjuELNbszkjysrXVwRholw4UYVE
   SQSEI7LlmcWbhv8h4bSvQ3hiGMVzcQ3QiB8fVwZG9daCfbU/oOn1Gn37y
   zTxr3E2V4KarHdKqwLO/4YhKJHfdiQIWaYBwiLRCLSVdaChGo9lpkn8gW
   LCQkJt3ux6j8odLraS748yxcXlCaSCy8H9XFgungd5YwK71ZaZ+5pgkCS
   XEcj81NWY2mwkL0Aeq9izZ6f7jfF94XdexnOZeYiHLD5VTOTx0v6yCBQ2
   w==;
X-CSE-ConnectionGUID: dUZxAtiBTqW2Sj1XhCbF/w==
X-CSE-MsgGUID: 7TKdTAAhQFODpjUZu6cRDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="47216907"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="47216907"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 02:23:59 -0800
X-CSE-ConnectionGUID: NBhKt0RQSkSmx6ihiRYvOA==
X-CSE-MsgGUID: 2sT2XI3VQOeyifzEQcj61A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="108103424"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Jan 2025 02:23:54 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVTE7-000FvB-2W;
	Wed, 08 Jan 2025 10:23:51 +0000
Date: Wed, 8 Jan 2025 18:23:37 +0800
From: kernel test robot <lkp@intel.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 20/22] bpf: Introduce rqspinlock kfuncs
Message-ID: <202501081853.1N3CiU6j-lkp@intel.com>
References: <20250107140004.2732830-21-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107140004.2732830-21-memxor@gmail.com>

Hi Kumar,

kernel test robot noticed the following build errors:

[auto build test ERROR on f44275e7155dc310d36516fc25be503da099781c]

url:    https://github.com/intel-lab-lkp/linux/commits/Kumar-Kartikeya-Dwivedi/locking-Move-MCS-struct-definition-to-public-header/20250107-220615
base:   f44275e7155dc310d36516fc25be503da099781c
patch link:    https://lore.kernel.org/r/20250107140004.2732830-21-memxor%40gmail.com
patch subject: [PATCH bpf-next v1 20/22] bpf: Introduce rqspinlock kfuncs
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20250108/202501081853.1N3CiU6j-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250108/202501081853.1N3CiU6j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501081853.1N3CiU6j-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/qspinlock.h:42,
                    from arch/loongarch/include/asm/qspinlock.h:39,
                    from include/asm-generic/rqspinlock.h:15,
                    from ./arch/loongarch/include/generated/asm/rqspinlock.h:1,
                    from include/linux/bpf.h:33,
                    from include/linux/security.h:35,
                    from kernel/printk/printk.c:34:
   include/asm-generic/qspinlock_types.h:44:3: error: conflicting types for 'arch_spinlock_t'; have 'struct qspinlock'
      44 | } arch_spinlock_t;
         |   ^~~~~~~~~~~~~~~
   In file included from include/linux/spinlock_types_raw.h:9,
                    from include/linux/ratelimit_types.h:7,
                    from include/linux/printk.h:9,
                    from include/linux/kernel.h:31,
                    from kernel/printk/printk.c:22:
   include/linux/spinlock_types_up.h:25:20: note: previous declaration of 'arch_spinlock_t' with type 'arch_spinlock_t'
      25 | typedef struct { } arch_spinlock_t;
         |                    ^~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:9: warning: "__ARCH_SPIN_LOCK_UNLOCKED" redefined
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_up.h:27:9: note: this is the location of the previous definition
      27 | #define __ARCH_SPIN_LOCK_UNLOCKED { }
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock.h:144:9: warning: "arch_spin_is_locked" redefined
     144 | #define arch_spin_is_locked(l)          queued_spin_is_locked(l)
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/spinlock.h:97,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from kernel/printk/printk.c:23:
   include/linux/spinlock_up.h:62:9: note: this is the location of the previous definition
      62 | #define arch_spin_is_locked(lock)       ((void)(lock), 0)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock.h:145:9: warning: "arch_spin_is_contended" redefined
     145 | #define arch_spin_is_contended(l)       queued_spin_is_contended(l)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_up.h:69:9: note: this is the location of the previous definition
      69 | #define arch_spin_is_contended(lock)    (((void)(lock), 0))
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock.h:147:9: warning: "arch_spin_lock" redefined
     147 | #define arch_spin_lock(l)               queued_spin_lock(l)
         |         ^~~~~~~~~~~~~~
   include/linux/spinlock_up.h:64:10: note: this is the location of the previous definition
      64 | # define arch_spin_lock(lock)           do { barrier(); (void)(lock); } while (0)
         |          ^~~~~~~~~~~~~~
   include/asm-generic/qspinlock.h:148:9: warning: "arch_spin_trylock" redefined
     148 | #define arch_spin_trylock(l)            queued_spin_trylock(l)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/spinlock_up.h:66:10: note: this is the location of the previous definition
      66 | # define arch_spin_trylock(lock)        ({ barrier(); (void)(lock); 1; })
         |          ^~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock.h:149:9: warning: "arch_spin_unlock" redefined
     149 | #define arch_spin_unlock(l)             queued_spin_unlock(l)
         |         ^~~~~~~~~~~~~~~~
   include/linux/spinlock_up.h:65:10: note: this is the location of the previous definition
      65 | # define arch_spin_unlock(lock) do { barrier(); (void)(lock); } while (0)
         |          ^~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: error: extra brace group at end of initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:81:32: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      81 |                 , .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:34: note: in expansion of macro '__MUTEX_INITIALIZER'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                                  ^~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:89:8: note: in expansion of macro 'DEFINE_MUTEX'
      89 | static DEFINE_MUTEX(console_mutex);
         |        ^~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:81:32: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      81 |                 , .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:34: note: in expansion of macro '__MUTEX_INITIALIZER'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                                  ^~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:89:8: note: in expansion of macro 'DEFINE_MUTEX'
      89 | static DEFINE_MUTEX(console_mutex);
         |        ^~~~~~~~~~~~
   In file included from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/atomic.h:5,
                    from arch/loongarch/include/asm/bitops.h:27,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23:
>> arch/loongarch/include/asm/atomic.h:32:27: error: extra brace group at end of initializer
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:81:32: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      81 |                 , .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:34: note: in expansion of macro '__MUTEX_INITIALIZER'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                                  ^~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:89:8: note: in expansion of macro 'DEFINE_MUTEX'
      89 | static DEFINE_MUTEX(console_mutex);
         |        ^~~~~~~~~~~~
   arch/loongarch/include/asm/atomic.h:32:27: note: (near initialization for '(anonymous).raw_lock')
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:81:32: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      81 |                 , .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:34: note: in expansion of macro '__MUTEX_INITIALIZER'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                                  ^~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:89:8: note: in expansion of macro 'DEFINE_MUTEX'
      89 | static DEFINE_MUTEX(console_mutex);
         |        ^~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: warning: excess elements in struct initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:81:32: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      81 |                 , .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:34: note: in expansion of macro '__MUTEX_INITIALIZER'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                                  ^~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:89:8: note: in expansion of macro 'DEFINE_MUTEX'
      89 | static DEFINE_MUTEX(console_mutex);
         |        ^~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:81:32: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      81 |                 , .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:34: note: in expansion of macro '__MUTEX_INITIALIZER'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                                  ^~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:89:8: note: in expansion of macro 'DEFINE_MUTEX'
      89 | static DEFINE_MUTEX(console_mutex);
         |        ^~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: error: extra brace group at end of initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/semaphore.h:23:27: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      23 |         .lock           = __RAW_SPIN_LOCK_UNLOCKED((name).lock),        \
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/semaphore.h:35:34: note: in expansion of macro '__SEMAPHORE_INITIALIZER'
      35 |         struct semaphore _name = __SEMAPHORE_INITIALIZER(_name, _n)
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:95:8: note: in expansion of macro 'DEFINE_SEMAPHORE'
      95 | static DEFINE_SEMAPHORE(console_sem, 1);
         |        ^~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/semaphore.h:23:27: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      23 |         .lock           = __RAW_SPIN_LOCK_UNLOCKED((name).lock),        \
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/semaphore.h:35:34: note: in expansion of macro '__SEMAPHORE_INITIALIZER'
      35 |         struct semaphore _name = __SEMAPHORE_INITIALIZER(_name, _n)
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:95:8: note: in expansion of macro 'DEFINE_SEMAPHORE'
      95 | static DEFINE_SEMAPHORE(console_sem, 1);
         |        ^~~~~~~~~~~~~~~~
>> arch/loongarch/include/asm/atomic.h:32:27: error: extra brace group at end of initializer
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/semaphore.h:23:27: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      23 |         .lock           = __RAW_SPIN_LOCK_UNLOCKED((name).lock),        \
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/semaphore.h:35:34: note: in expansion of macro '__SEMAPHORE_INITIALIZER'
      35 |         struct semaphore _name = __SEMAPHORE_INITIALIZER(_name, _n)
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:95:8: note: in expansion of macro 'DEFINE_SEMAPHORE'
      95 | static DEFINE_SEMAPHORE(console_sem, 1);
         |        ^~~~~~~~~~~~~~~~
   arch/loongarch/include/asm/atomic.h:32:27: note: (near initialization for '(anonymous).raw_lock')
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/semaphore.h:23:27: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      23 |         .lock           = __RAW_SPIN_LOCK_UNLOCKED((name).lock),        \
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/semaphore.h:35:34: note: in expansion of macro '__SEMAPHORE_INITIALIZER'
      35 |         struct semaphore _name = __SEMAPHORE_INITIALIZER(_name, _n)
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:95:8: note: in expansion of macro 'DEFINE_SEMAPHORE'
      95 | static DEFINE_SEMAPHORE(console_sem, 1);
         |        ^~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: warning: excess elements in struct initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/semaphore.h:23:27: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      23 |         .lock           = __RAW_SPIN_LOCK_UNLOCKED((name).lock),        \
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/semaphore.h:35:34: note: in expansion of macro '__SEMAPHORE_INITIALIZER'
      35 |         struct semaphore _name = __SEMAPHORE_INITIALIZER(_name, _n)
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:95:8: note: in expansion of macro 'DEFINE_SEMAPHORE'
      95 | static DEFINE_SEMAPHORE(console_sem, 1);
         |        ^~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/semaphore.h:23:27: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      23 |         .lock           = __RAW_SPIN_LOCK_UNLOCKED((name).lock),        \
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/semaphore.h:35:34: note: in expansion of macro '__SEMAPHORE_INITIALIZER'
      35 |         struct semaphore _name = __SEMAPHORE_INITIALIZER(_name, _n)
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:95:8: note: in expansion of macro 'DEFINE_SEMAPHORE'
      95 | static DEFINE_SEMAPHORE(console_sem, 1);
         |        ^~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: error: extra brace group at end of initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/swait.h:62:27: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      62 |         .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),          \
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcutiny.h:36:20: note: in expansion of macro '__SWAIT_QUEUE_HEAD_INITIALIZER'
      36 |         .srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),        \
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcutiny.h:49:42: note: in expansion of macro '__SRCU_STRUCT_INIT'
      49 |         static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
         |                                          ^~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:98:1: note: in expansion of macro 'DEFINE_STATIC_SRCU'
      98 | DEFINE_STATIC_SRCU(console_srcu);
         | ^~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/swait.h:62:27: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      62 |         .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),          \
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcutiny.h:36:20: note: in expansion of macro '__SWAIT_QUEUE_HEAD_INITIALIZER'
      36 |         .srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),        \
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcutiny.h:49:42: note: in expansion of macro '__SRCU_STRUCT_INIT'
      49 |         static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
         |                                          ^~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:98:1: note: in expansion of macro 'DEFINE_STATIC_SRCU'
      98 | DEFINE_STATIC_SRCU(console_srcu);
         | ^~~~~~~~~~~~~~~~~~
>> arch/loongarch/include/asm/atomic.h:32:27: error: extra brace group at end of initializer
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/swait.h:62:27: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      62 |         .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),          \
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcutiny.h:36:20: note: in expansion of macro '__SWAIT_QUEUE_HEAD_INITIALIZER'
      36 |         .srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),        \
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcutiny.h:49:42: note: in expansion of macro '__SRCU_STRUCT_INIT'
      49 |         static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
         |                                          ^~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:98:1: note: in expansion of macro 'DEFINE_STATIC_SRCU'
      98 | DEFINE_STATIC_SRCU(console_srcu);
         | ^~~~~~~~~~~~~~~~~~
   arch/loongarch/include/asm/atomic.h:32:27: note: (near initialization for '(anonymous).raw_lock')
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/swait.h:62:27: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      62 |         .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),          \
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcutiny.h:36:20: note: in expansion of macro '__SWAIT_QUEUE_HEAD_INITIALIZER'
      36 |         .srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),        \
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcutiny.h:49:42: note: in expansion of macro '__SRCU_STRUCT_INIT'
      49 |         static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
         |                                          ^~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:98:1: note: in expansion of macro 'DEFINE_STATIC_SRCU'
      98 | DEFINE_STATIC_SRCU(console_srcu);
         | ^~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: warning: excess elements in struct initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/swait.h:62:27: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      62 |         .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),          \
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcutiny.h:36:20: note: in expansion of macro '__SWAIT_QUEUE_HEAD_INITIALIZER'
      36 |         .srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),        \
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcutiny.h:49:42: note: in expansion of macro '__SRCU_STRUCT_INIT'
      49 |         static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
         |                                          ^~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:98:1: note: in expansion of macro 'DEFINE_STATIC_SRCU'
      98 | DEFINE_STATIC_SRCU(console_srcu);
         | ^~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/swait.h:62:27: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      62 |         .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),          \
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcutiny.h:36:20: note: in expansion of macro '__SWAIT_QUEUE_HEAD_INITIALIZER'
      36 |         .srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),        \
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcutiny.h:49:42: note: in expansion of macro '__SRCU_STRUCT_INIT'
      49 |         static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
         |                                          ^~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:98:1: note: in expansion of macro 'DEFINE_STATIC_SRCU'
      98 | DEFINE_STATIC_SRCU(console_srcu);
         | ^~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: error: extra brace group at end of initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:81:32: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      81 |                 , .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:34: note: in expansion of macro '__MUTEX_INITIALIZER'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                                  ^~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:465:8: note: in expansion of macro 'DEFINE_MUTEX'
     465 | static DEFINE_MUTEX(syslog_lock);
         |        ^~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:81:32: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      81 |                 , .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:34: note: in expansion of macro '__MUTEX_INITIALIZER'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                                  ^~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:465:8: note: in expansion of macro 'DEFINE_MUTEX'
     465 | static DEFINE_MUTEX(syslog_lock);
         |        ^~~~~~~~~~~~
>> arch/loongarch/include/asm/atomic.h:32:27: error: extra brace group at end of initializer
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:81:32: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      81 |                 , .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:34: note: in expansion of macro '__MUTEX_INITIALIZER'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                                  ^~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:465:8: note: in expansion of macro 'DEFINE_MUTEX'
     465 | static DEFINE_MUTEX(syslog_lock);
         |        ^~~~~~~~~~~~
   arch/loongarch/include/asm/atomic.h:32:27: note: (near initialization for '(anonymous).raw_lock')
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:81:32: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      81 |                 , .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:34: note: in expansion of macro '__MUTEX_INITIALIZER'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                                  ^~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:465:8: note: in expansion of macro 'DEFINE_MUTEX'
     465 | static DEFINE_MUTEX(syslog_lock);
         |        ^~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: warning: excess elements in struct initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:81:32: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      81 |                 , .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:34: note: in expansion of macro '__MUTEX_INITIALIZER'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                                  ^~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:465:8: note: in expansion of macro 'DEFINE_MUTEX'
     465 | static DEFINE_MUTEX(syslog_lock);
         |        ^~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:81:32: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      81 |                 , .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:34: note: in expansion of macro '__MUTEX_INITIALIZER'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                                  ^~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:465:8: note: in expansion of macro 'DEFINE_MUTEX'
     465 | static DEFINE_MUTEX(syslog_lock);
         |        ^~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: error: extra brace group at end of initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:56:27: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      56 |         .lock           = __SPIN_LOCK_UNLOCKED(name.lock),                      \
         |                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:60:39: note: in expansion of macro '__WAIT_QUEUE_HEAD_INITIALIZER'
      60 |         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:493:1: note: in expansion of macro 'DECLARE_WAIT_QUEUE_HEAD'
     493 | DECLARE_WAIT_QUEUE_HEAD(log_wait);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).<anonymous>.rlock.raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:56:27: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      56 |         .lock           = __SPIN_LOCK_UNLOCKED(name.lock),                      \
         |                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:60:39: note: in expansion of macro '__WAIT_QUEUE_HEAD_INITIALIZER'
      60 |         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:493:1: note: in expansion of macro 'DECLARE_WAIT_QUEUE_HEAD'
     493 | DECLARE_WAIT_QUEUE_HEAD(log_wait);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> arch/loongarch/include/asm/atomic.h:32:27: error: extra brace group at end of initializer
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:56:27: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      56 |         .lock           = __SPIN_LOCK_UNLOCKED(name.lock),                      \
         |                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:60:39: note: in expansion of macro '__WAIT_QUEUE_HEAD_INITIALIZER'
      60 |         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:493:1: note: in expansion of macro 'DECLARE_WAIT_QUEUE_HEAD'
     493 | DECLARE_WAIT_QUEUE_HEAD(log_wait);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/include/asm/atomic.h:32:27: note: (near initialization for '(anonymous).<anonymous>.rlock.raw_lock')
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:56:27: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      56 |         .lock           = __SPIN_LOCK_UNLOCKED(name.lock),                      \
         |                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:60:39: note: in expansion of macro '__WAIT_QUEUE_HEAD_INITIALIZER'
      60 |         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:493:1: note: in expansion of macro 'DECLARE_WAIT_QUEUE_HEAD'
     493 | DECLARE_WAIT_QUEUE_HEAD(log_wait);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: warning: excess elements in struct initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:56:27: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      56 |         .lock           = __SPIN_LOCK_UNLOCKED(name.lock),                      \
         |                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:60:39: note: in expansion of macro '__WAIT_QUEUE_HEAD_INITIALIZER'
      60 |         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:493:1: note: in expansion of macro 'DECLARE_WAIT_QUEUE_HEAD'
     493 | DECLARE_WAIT_QUEUE_HEAD(log_wait);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).<anonymous>.rlock.raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:56:27: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      56 |         .lock           = __SPIN_LOCK_UNLOCKED(name.lock),                      \
         |                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:60:39: note: in expansion of macro '__WAIT_QUEUE_HEAD_INITIALIZER'
      60 |         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:493:1: note: in expansion of macro 'DECLARE_WAIT_QUEUE_HEAD'
     493 | DECLARE_WAIT_QUEUE_HEAD(log_wait);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: error: extra brace group at end of initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:56:27: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      56 |         .lock           = __SPIN_LOCK_UNLOCKED(name.lock),                      \
         |                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:60:39: note: in expansion of macro '__WAIT_QUEUE_HEAD_INITIALIZER'
      60 |         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:494:8: note: in expansion of macro 'DECLARE_WAIT_QUEUE_HEAD'
     494 | static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
         |        ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).<anonymous>.rlock.raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:56:27: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      56 |         .lock           = __SPIN_LOCK_UNLOCKED(name.lock),                      \
         |                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:60:39: note: in expansion of macro '__WAIT_QUEUE_HEAD_INITIALIZER'
      60 |         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:494:8: note: in expansion of macro 'DECLARE_WAIT_QUEUE_HEAD'
     494 | static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
         |        ^~~~~~~~~~~~~~~~~~~~~~~
>> arch/loongarch/include/asm/atomic.h:32:27: error: extra brace group at end of initializer
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:56:27: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      56 |         .lock           = __SPIN_LOCK_UNLOCKED(name.lock),                      \
         |                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:60:39: note: in expansion of macro '__WAIT_QUEUE_HEAD_INITIALIZER'
      60 |         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:494:8: note: in expansion of macro 'DECLARE_WAIT_QUEUE_HEAD'
     494 | static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
         |        ^~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/include/asm/atomic.h:32:27: note: (near initialization for '(anonymous).<anonymous>.rlock.raw_lock')
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:56:27: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      56 |         .lock           = __SPIN_LOCK_UNLOCKED(name.lock),                      \
         |                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:60:39: note: in expansion of macro '__WAIT_QUEUE_HEAD_INITIALIZER'
      60 |         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:494:8: note: in expansion of macro 'DECLARE_WAIT_QUEUE_HEAD'
     494 | static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
         |        ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: warning: excess elements in struct initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:56:27: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      56 |         .lock           = __SPIN_LOCK_UNLOCKED(name.lock),                      \
         |                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:60:39: note: in expansion of macro '__WAIT_QUEUE_HEAD_INITIALIZER'
      60 |         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:494:8: note: in expansion of macro 'DECLARE_WAIT_QUEUE_HEAD'
     494 | static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
         |        ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).<anonymous>.rlock.raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:56:27: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      56 |         .lock           = __SPIN_LOCK_UNLOCKED(name.lock),                      \
         |                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:60:39: note: in expansion of macro '__WAIT_QUEUE_HEAD_INITIALIZER'
      60 |         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:494:8: note: in expansion of macro 'DECLARE_WAIT_QUEUE_HEAD'
     494 | static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
         |        ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: error: extra brace group at end of initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:71:52: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      71 | #define DEFINE_RAW_SPINLOCK(x)  raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:1891:8: note: in expansion of macro 'DEFINE_RAW_SPINLOCK'
    1891 | static DEFINE_RAW_SPINLOCK(console_owner_lock);
         |        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:71:52: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      71 | #define DEFINE_RAW_SPINLOCK(x)  raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:1891:8: note: in expansion of macro 'DEFINE_RAW_SPINLOCK'
    1891 | static DEFINE_RAW_SPINLOCK(console_owner_lock);
         |        ^~~~~~~~~~~~~~~~~~~
>> arch/loongarch/include/asm/atomic.h:32:27: error: extra brace group at end of initializer
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:71:52: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      71 | #define DEFINE_RAW_SPINLOCK(x)  raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:1891:8: note: in expansion of macro 'DEFINE_RAW_SPINLOCK'
    1891 | static DEFINE_RAW_SPINLOCK(console_owner_lock);
         |        ^~~~~~~~~~~~~~~~~~~
   arch/loongarch/include/asm/atomic.h:32:27: note: (near initialization for '(anonymous).raw_lock')
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:71:52: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      71 | #define DEFINE_RAW_SPINLOCK(x)  raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:1891:8: note: in expansion of macro 'DEFINE_RAW_SPINLOCK'
    1891 | static DEFINE_RAW_SPINLOCK(console_owner_lock);
         |        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: warning: excess elements in struct initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:71:52: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      71 | #define DEFINE_RAW_SPINLOCK(x)  raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:1891:8: note: in expansion of macro 'DEFINE_RAW_SPINLOCK'
    1891 | static DEFINE_RAW_SPINLOCK(console_owner_lock);
         |        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:71:52: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      71 | #define DEFINE_RAW_SPINLOCK(x)  raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:1891:8: note: in expansion of macro 'DEFINE_RAW_SPINLOCK'
    1891 | static DEFINE_RAW_SPINLOCK(console_owner_lock);
         |        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: error: extra brace group at end of initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:27:35: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      27 |                 .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),            \
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:34:9: note: in expansion of macro 'RATELIMIT_STATE_INIT_FLAGS'
      34 |         RATELIMIT_STATE_INIT_FLAGS(name, interval_init, burst_init, 0)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:42:17: note: in expansion of macro 'RATELIMIT_STATE_INIT'
      42 |                 RATELIMIT_STATE_INIT(name, interval_init, burst_init)   \
         |                 ^~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:4592:1: note: in expansion of macro 'DEFINE_RATELIMIT_STATE'
    4592 | DEFINE_RATELIMIT_STATE(printk_ratelimit_state, 5 * HZ, 10);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:27:35: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      27 |                 .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),            \
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:34:9: note: in expansion of macro 'RATELIMIT_STATE_INIT_FLAGS'
      34 |         RATELIMIT_STATE_INIT_FLAGS(name, interval_init, burst_init, 0)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:42:17: note: in expansion of macro 'RATELIMIT_STATE_INIT'
      42 |                 RATELIMIT_STATE_INIT(name, interval_init, burst_init)   \
         |                 ^~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:4592:1: note: in expansion of macro 'DEFINE_RATELIMIT_STATE'
    4592 | DEFINE_RATELIMIT_STATE(printk_ratelimit_state, 5 * HZ, 10);
         | ^~~~~~~~~~~~~~~~~~~~~~
>> arch/loongarch/include/asm/atomic.h:32:27: error: extra brace group at end of initializer
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:27:35: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      27 |                 .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),            \
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:34:9: note: in expansion of macro 'RATELIMIT_STATE_INIT_FLAGS'
      34 |         RATELIMIT_STATE_INIT_FLAGS(name, interval_init, burst_init, 0)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:42:17: note: in expansion of macro 'RATELIMIT_STATE_INIT'
      42 |                 RATELIMIT_STATE_INIT(name, interval_init, burst_init)   \
         |                 ^~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:4592:1: note: in expansion of macro 'DEFINE_RATELIMIT_STATE'
    4592 | DEFINE_RATELIMIT_STATE(printk_ratelimit_state, 5 * HZ, 10);
         | ^~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/include/asm/atomic.h:32:27: note: (near initialization for '(anonymous).raw_lock')
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:27:35: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      27 |                 .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),            \
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:34:9: note: in expansion of macro 'RATELIMIT_STATE_INIT_FLAGS'
      34 |         RATELIMIT_STATE_INIT_FLAGS(name, interval_init, burst_init, 0)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:42:17: note: in expansion of macro 'RATELIMIT_STATE_INIT'
      42 |                 RATELIMIT_STATE_INIT(name, interval_init, burst_init)   \
         |                 ^~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:4592:1: note: in expansion of macro 'DEFINE_RATELIMIT_STATE'
    4592 | DEFINE_RATELIMIT_STATE(printk_ratelimit_state, 5 * HZ, 10);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: warning: excess elements in struct initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:27:35: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      27 |                 .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),            \
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:34:9: note: in expansion of macro 'RATELIMIT_STATE_INIT_FLAGS'
      34 |         RATELIMIT_STATE_INIT_FLAGS(name, interval_init, burst_init, 0)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:42:17: note: in expansion of macro 'RATELIMIT_STATE_INIT'
      42 |                 RATELIMIT_STATE_INIT(name, interval_init, burst_init)   \
         |                 ^~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:4592:1: note: in expansion of macro 'DEFINE_RATELIMIT_STATE'
    4592 | DEFINE_RATELIMIT_STATE(printk_ratelimit_state, 5 * HZ, 10);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types_raw.h:64:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      64 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types_raw.h:69:26: note: in expansion of macro '__RAW_SPIN_LOCK_INITIALIZER'
      69 |         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:27:35: note: in expansion of macro '__RAW_SPIN_LOCK_UNLOCKED'
      27 |                 .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),            \
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:34:9: note: in expansion of macro 'RATELIMIT_STATE_INIT_FLAGS'
      34 |         RATELIMIT_STATE_INIT_FLAGS(name, interval_init, burst_init, 0)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:42:17: note: in expansion of macro 'RATELIMIT_STATE_INIT'
      42 |                 RATELIMIT_STATE_INIT(name, interval_init, burst_init)   \
         |                 ^~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:4592:1: note: in expansion of macro 'DEFINE_RATELIMIT_STATE'
    4592 | DEFINE_RATELIMIT_STATE(printk_ratelimit_state, 5 * HZ, 10);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: error: extra brace group at end of initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:43:48: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      43 | #define DEFINE_SPINLOCK(x)      spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
         |                                                ^~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:4622:8: note: in expansion of macro 'DEFINE_SPINLOCK'
    4622 | static DEFINE_SPINLOCK(dump_list_lock);
         |        ^~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).<anonymous>.rlock.raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:43:48: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      43 | #define DEFINE_SPINLOCK(x)      spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
         |                                                ^~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:4622:8: note: in expansion of macro 'DEFINE_SPINLOCK'
    4622 | static DEFINE_SPINLOCK(dump_list_lock);
         |        ^~~~~~~~~~~~~~~
>> arch/loongarch/include/asm/atomic.h:32:27: error: extra brace group at end of initializer
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:43:48: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      43 | #define DEFINE_SPINLOCK(x)      spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
         |                                                ^~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:4622:8: note: in expansion of macro 'DEFINE_SPINLOCK'
    4622 | static DEFINE_SPINLOCK(dump_list_lock);
         |        ^~~~~~~~~~~~~~~
   arch/loongarch/include/asm/atomic.h:32:27: note: (near initialization for '(anonymous).<anonymous>.rlock.raw_lock')
      32 | #define ATOMIC_INIT(i)    { (i) }
         |                           ^
   include/asm-generic/qspinlock_types.h:49:52: note: in expansion of macro 'ATOMIC_INIT'
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                                    ^~~~~~~~~~~
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:43:48: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      43 | #define DEFINE_SPINLOCK(x)      spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
         |                                                ^~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:4622:8: note: in expansion of macro 'DEFINE_SPINLOCK'
    4622 | static DEFINE_SPINLOCK(dump_list_lock);
         |        ^~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: warning: excess elements in struct initializer
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:43:48: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      43 | #define DEFINE_SPINLOCK(x)      spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
         |                                                ^~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:4622:8: note: in expansion of macro 'DEFINE_SPINLOCK'
    4622 | static DEFINE_SPINLOCK(dump_list_lock);
         |        ^~~~~~~~~~~~~~~
   include/asm-generic/qspinlock_types.h:49:43: note: (near initialization for '(anonymous).<anonymous>.rlock.raw_lock')
      49 | #define __ARCH_SPIN_LOCK_UNLOCKED       { { .val = ATOMIC_INIT(0) } }
         |                                           ^
   include/linux/spinlock_types.h:33:21: note: in expansion of macro '__ARCH_SPIN_LOCK_UNLOCKED'
      33 |         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:38:22: note: in expansion of macro '___SPIN_LOCK_INITIALIZER'
      38 |         { { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:41:22: note: in expansion of macro '__SPIN_LOCK_INITIALIZER'
      41 |         (spinlock_t) __SPIN_LOCK_INITIALIZER(lockname)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:43:48: note: in expansion of macro '__SPIN_LOCK_UNLOCKED'
      43 | #define DEFINE_SPINLOCK(x)      spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
         |                                                ^~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:4622:8: note: in expansion of macro 'DEFINE_SPINLOCK'
    4622 | static DEFINE_SPINLOCK(dump_list_lock);
         |        ^~~~~~~~~~~~~~~


vim +32 arch/loongarch/include/asm/atomic.h

5b0b14e550a006 Huacai Chen 2022-05-31  31  
5b0b14e550a006 Huacai Chen 2022-05-31 @32  #define ATOMIC_INIT(i)	  { (i) }
5b0b14e550a006 Huacai Chen 2022-05-31  33  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

