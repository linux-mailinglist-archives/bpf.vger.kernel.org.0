Return-Path: <bpf+bounces-70246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C232EBB58FB
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 00:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E09E4826C7
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 22:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53092848BB;
	Thu,  2 Oct 2025 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW85LMJd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EFA272801
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 22:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445640; cv=none; b=Sru+ivpcVQo2jZBWOxmOgLJY2y0k3npVU9pXGdJmWOh62FpWmBDAcnddgMNYhcMbo/KL68bkIrgDv4Fd/a4YFRv8U1FB6zli03AVej8Ye7qBqg8QdBcI01zYe+6hqd2RwDnNHz0LA3M+oag8UwGi9NuDpHoy3K4MUeftBTwmKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445640; c=relaxed/simple;
	bh=s2rYkvR0Cg9Ynbbzzo70Td0UCAsAuzN3OXjFo4E9f48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c6lcZSwGSpMBZUCEBSe9bl3AQZS/p64DW+CValG9ZVg05tRdH6WfnjJ++T46QJZ1vjL78pgC0f64Tf3UWDnh+PHBjcBorRPyy67SoikgcGlc3fhqQgPMrItpkVJ3jDmrsMZrENMkKLYhSoYoZCJtVV5g616aZwzOJUwnA/lGX7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fW85LMJd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso1543160a91.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 15:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445637; x=1760050437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8LjmGErH4dS+NCj2WY2mOcskEuzbRcvQVzUgzfjVzQ=;
        b=fW85LMJdNG02KHRSj1mNfQxaNSxqEA4UK4JvZASpfCE/AaFLTQSF67jJGhXOEmJvfM
         24Q4HCUS9fQZHKLrG9w0XDyxsOLtAp5seAxBKLJ55HDuc6YpWsdSdt+ZcmCQgOZZwVgk
         t9oVEbn86u7crs5iP0bW/yjcR9qTM40PD0aJXuBjnpE3rKORPFm8h3hat/aHL6dmPqqP
         od3y3r5p5DDjTi56VYKU0vEQBhO02ZdgVcAqLNSslXNuiar2MGGCw/bmibRRRe/QNTso
         r6bi0946lurOivzTs6/Hjierq2qr5ql0RrB+T5u3rvELOvdmFA+meTg02ste12ab1m1Q
         5m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445637; x=1760050437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8LjmGErH4dS+NCj2WY2mOcskEuzbRcvQVzUgzfjVzQ=;
        b=X8VUi7XiRzi1sxJBCfDlqQODXEV++tbC48B6e8KWwAtSksF2vwSElPqL22stQ+sW6a
         OtNvGKk+hs5Bnn3qV4/YD0ucIGprjofRJLyPiDmKFmRuABEgID+T5eORyXIFH2X9RYJ9
         2QQTj0UZrDBTuP5tYQC3JIAmRheP8LWmVe65Hs125Zdw1llaem53pvt9OaAa2pXmNepF
         tvlaeb5412URcVm6W8o8Y49qu1jd336I8bu19b9kYNzhHqQ1bA6Sv5vBVr6YgtHKvaim
         SdFB4pXPWUddaT7XdoA0RVY/1U6vEORhXDsb4fD06CMBu4tGs7gu5+MNM0AkEmJXGzoM
         nrcw==
X-Gm-Message-State: AOJu0Yw1zFFM45Krse2U238WL5sjoC+Jr9oGBx1vnx1ZjkNyU6fNZosi
	MOFtNZpa4Pc7OC+rsQwjrTXDYcB4uloh8vPM3rYA78hkAJjkAlt2ms1E4QEzjQ==
X-Gm-Gg: ASbGncsOdT/oJArTeqU0+H5OpKJu16G4Mn1PD69H/PP5K7Lryg1kfKGTPBVF+1RXh0E
	Ktj3HHKzftU2aMRxN54smaUgCnnHwrOx91pH6aWgicn3cOYpQQo8nsvlJrtAIK0K9WBU/UV/2Vj
	VoSTPLxJ1CMmpGvptglyf1nEdub40mMwtvyUm8iKhxRVm+R4C23D681tSvMfq7eqayMf/xruvgU
	1rWungkyxXIDNzXKXFmwNRYIUjynsuC12lD12OxtGY3Dqtg4N9k9OHokHGIUkeI52z+woGjNWYH
	XwYsOC89ed9G8LIUqiVZ9pG0hcsUxd+8kakKWJUl48q2rEmcuwlfb6S0/c5zeExV31lb0u1lP5a
	nxj5bPkRwuB3DkrsqKz2yNR3fxtLUYrfeHHVebw==
X-Google-Smtp-Source: AGHT+IEdL9LVAWcJM+hqjqr6IQxMTpq9UvANEBL0rM60acXn/lBCj7sqtKcyywv6N/4/CUE4TfVh3g==
X-Received: by 2002:a17:90b:3ec6:b0:335:2823:3683 with SMTP id 98e67ed59e1d1-339c2759dfamr1222447a91.9.1759445637290;
        Thu, 02 Oct 2025 15:53:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f3b041sm2824108a12.24.2025.10.02.15.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:53:56 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 00/12] Remove task and cgroup local storage percpu counters
Date: Thu,  2 Oct 2025 15:53:39 -0700
Message-ID: <20251002225356.1505480-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v1 -> v2
  - Rebase to bpf-next  
  - Select bucket based on local_storage instead of selem (Martin)
  - Simplify bpf_selem_unlink (Martin)
  - Change handling of rqspinlock errors in bpf_local_storage_destroy()
    and bpf_local_storage_map_free(). Retry instead of WARN_ON.
  Link: https://lore.kernel.org/bpf/20250729182550.185356-1-ameryhung@gmail.com/


* Motivation *

The goal of this patchset is to make bpf syscalls and helpers updating
task and cgroup local storage more robust by removing percpu counters
in them. Task local storage and cgroup storage each employs a percpu
counter to prevent deadlock caused by recursion. Since the underlying
bpf local storage takes spinlocks in various operations, bpf programs
running recursively may try to take a spinlock which is already taken.
For example, when a tracing bpf program called recursively during
bpf_task_storage_get(..., F_CREATE) tries to call
bpf_task_storage_get(..., F_CREATE) again, it will cause AA deadlock
if the percpu variable is not in place.

However, sometimes, the percpu counter may cause bpf syscalls or helpers
to return errors spuriously, as soon as another threads is also updating
the local storage or the local storage map. Ideally, the two threads
could have taken turn to take the locks and perform their jobs
respectively. However, due to the percpu counter, the syscalls and
helpers can return -EBUSY even if one of them does not run recursively
in another one. All it takes for this to happen is if the two threads run
on the same CPU. This happened when BPF-CI ran the selftest of task local
data. Since CI runs the test on VM with 2 CPUs, bpf_task_storage_get(...,
F_CREATE) can easily fail.

The failure mode is not good for users as they need to add retry logic
in user space or bpf programs to avoid it. Even with retry, there
is no guaranteed upper bound of the loop for a success call. Therefore,
this patchset seeks to remove the percpu counter and makes the related
bpf syscalls and helpers more reliable, while still make sure recursion
deadlock will not happen, with the help of resilient queued spinlock
(rqspinlock).


* Implementation *

To remove the percpu counter without introducing deadlock,
bpf_local_storage is refactored by changing the locks from raw_spin_lock
to rqspinlock, which prevents deadlock with deadlock detection and a
timeout mechanism.

The refactor basically repalces the locks with rqspinlock and propagates
errors returned by the locking function to BPF helpers or syscalls.
In two lock acquiring functions that cannot fail,
bpf_local_storage_destroy() and bpf_local_storage_map_free()
(i.e., local storage is being freed by the subsystem or the map is
being freed), we simply retry. Since freeing of task, cgroup, inode and
sock and free of BPF map are done in deferred callbacks, they should be
able to make forward progress eventually (i.e., they cannot deadlock).

If not familiar with local storage, the last section briefly describe
the locks and structure of local storage. It also shows the abbreviation
used in the rest of the letter.


* Handling rqspinlock return in destroy() and map_free() *

The main concern of this patchset is handling errors returned from
rqspinlock in bpf_local_storage_destroy() and
bpf_local_storage_map_free() where the function cannot fail. First,
we explain the rationale behind the current approach. Then, we explain
why the approach taken in v1 is not correct. Finally, we list one other
approach to handle errors returned from rqspinlock.

bpf_local_storage_destroy() and bpf_local_storage_map_free() are not
allowed to fail as they are responsible for cleaning up the local
storage and BPF map. In an unlikely event where lock acquisition returns
errors, we simply retry since both functions should be able to make
forward progress eventually. They should not deadlock with itself or
each other since both functions are called in deferred callbacks and
preemption is disabled in the critical section. They may not run
recursively when locks were already being held, hence AA deadlock cannot
happen. In addition, since we always follow the same locking order
(i.e., local_storage->lock before bucket->lock), ABBA deadlock cannot
happen either.

Another way to handle the return, as taken by v1, is to assert the lock
will always succeed, which unfortunately is not true. Here we look at how
raw_res_spin_lock_irqsave() in destroy() and map_free() can fail.

  1) Deadlock

  While AA and ABBA deadlock cannot happen in destroy() and map_free(),
  rqspinlock in these functions can return -EDEADLOCK.

  However, when other threads waiting for the lock detects deadlock,
  they may signal other waiters -EDEADLOCK. Here is one example:

  (ls: local_storage, b: bucket)

          CPU1                                 CPU2
          ----                                 ----
    bpf_prog1
    -> bpf_task_local_storage_get(F_CREATE)
       -> lock(ls1->lock)
       -> lock(b1->lock)
  
    bpf_prog2 hooked to NMI
    -> bpf_task_local_storage_get(F_CREATE)
       -> lock(ls2->lock)
       -> lock(b1->lock) return -EDEADLOCK

                                  __put_task_struct_rcu_cb()
                                  -> bpf_local_storage_destroy()
                                     -> lock(ls3->lock)
                                     -> lock(b1->lock) return -EDEADLOCK
                                        as signaled by the head waiter

  2) Timeout

  While very unlikely, timeout can happen theorectically. If a local
  storage contains lots of selems, it can spend a significant amount of
  time in bpf_local_storage_destroy(), causing rqspinlock to return
  -ETIMEOUT in map_free().

          CPU1                                 CPU2
          ----                                 ----
    bpf_local_storage_destroy()
    -> lock(ls->lock)
    -> for selem in list lock(b->lock)
       (hold the lock for a long time)
   
                                  bpf_local_storage_map_free()
                                  -> for selem in smap,
                                     lock(ls->lock) return -ETIMEOUT


There are also other approaches to handle the return of
raw_res_spin_lock_irqsave() at the cost of adding more complexity to
local storage. In general, we can try to mark the selem in the local
storage or map as freed and reclaim/reuse the memory later, but I hope
retry is enough and we don't need to go there.


* Patchset organization *

The refactoring is organized into four steps.

First, in patch 1, we change the pointer used to select the bucket from
selem to smap. This will reduce the number of buckets that need to be
locked from 2 to 1 during update.

Then, in patch 2-5, local storage functions that take locks are being
converted to failable. The functions are changed from returning void to
returning an int error code with the return value temporarily set to 0.
In callers where the helpers cannot fail in the middle of an update,
the helper is open coded. In callers that are not allowed to fail, (i.e.,
bpf_local_storage_destroy() and bpf_local_storage_map_free()), we retry.

Then, in patch 6, the locks are changed to rqspinlock, and the error
returned from raw_res_spin_lock_irqsave() is propagated to the syscalls
and heleprs.

Finally, in patch 7-8, the percpu counters in task and cgroup local
storage are removed.


* Test *

Task and cgroup local storage selftests have already covered deadlock
caused by recursion. Patch 10 updates the expected result of task local
storage selftests as task local storage bpf helpers can now run on the
same CPU as they don't cause deadlock.


* Appendix: local storage internal *

There are two locks in bpf_local_storage due to the ownership model as
illustrated in the figure below. A map value, which consists of a
pointer to the map and the data, is a bpf_local_storage_map_data (sdata)
stored in a bpf_local_storage_elem (selem). A selem belongs to a
bpf_local_storage and bpf_local_storage_map at the same time. 
bpf_local_storage::lock (lock_storage->lock in short) protects the list
in a bpf_local_storage and bpf_local_storage_map_bucket::lock (b->lock)
protects the hash bucket in a bpf_local_storage_map.


 task_struct
┌ task1 ───────┐       bpf_local_storage
│ *bpf_storage │---->┌─────────┐
└──────────────┘<----│ *owner  │         bpf_local_storage_elem
                     │ *cache[16]        (selem)              selem
                     │ *smap   │        ┌──────────┐         ┌──────────┐
                     │ list    │------->│ snode    │<------->│ snode    │
                     │ lock    │  ┌---->│ map_node │<--┐ ┌-->│ map_node │
                     └─────────┘  │     │ sdata =  │   │ │   │ sdata =  │
 task_struct                      │     │ {&mapA,} │   │ │   │ {&mapB,} │
┌ task2 ───────┐      bpf_local_storage └──────────┘   │ │   └──────────┘
│ *bpf_storage │---->┌─────────┐  │                    │ │
└──────────────┘<----│ *owner  │  │                    │ │
                     │ *cache[16] │      selem         │ │    selem
                     │ *smap   │  │     ┌──────────┐   │ │   ┌──────────┐
                     │ list    │--│---->│ snode    │<--│-│-->│ snode    │
                     │ lock    │  │ ┌-->│ map_node │   └-│-->│ map_node │
                     └─────────┘  │ │   │ sdata =  │     │   │ sdata =  │
 bpf_local_storage_map            │ │   │ {&mapB,} │     │   │ {&mapA,} │
 (smap)                           │ │   └──────────┘     │   └──────────┘
┌ mapA ───────┐                   │ │                    │
│ bpf_map map │      bpf_local_storage_map_bucket        │
│ *buckets    │---->┌ b[0] ┐      │ │                    │
└─────────────┘     │ list │------┘ │                    │
                    │ lock │        │                    │
                    └──────┘        │                    │
 smap                 ...           │                    │
┌ mapB ───────┐                     │                    │
│ bpf_map map │      bpf_local_storage_map_bucket        │
│ *buckets    │---->┌ b[0] ┐        │                    │
└─────────────┘     │ list │--------┘                    │
                    │ lock │                             │
                    └──────┘                             │
                    ┌ b[1] ┐                             │
                    │ list │-----------------------------┘
                    │ lock │
                    └──────┘
                      ...
  
----
Amery Hung (12):
  bpf: Select bpf_local_storage_map_bucket based on bpf_local_storage
  bpf: Convert bpf_selem_unlink_map to failable
  bpf: Convert bpf_selem_link_map to failable
  bpf: Open code bpf_selem_unlink_storage in bpf_selem_unlink
  bpf: Convert bpf_selem_unlink to failable
  bpf: Change local_storage->lock and b->lock to rqspinlock
  bpf: Remove task local storage percpu counter
  bpf: Remove cgroup local storage percpu counter
  bpf: Remove unused percpu counter from bpf_local_storage_map_free
  selftests/bpf: Update task_local_storage/recursion test
  selftests/bpf: Remove test_task_storage_map_stress_lookup
  selftests/bpf: Choose another percpu variable in bpf for btf_dump test

 include/linux/bpf_local_storage.h             |  14 +-
 kernel/bpf/bpf_cgrp_storage.c                 |  62 +-----
 kernel/bpf/bpf_inode_storage.c                |   6 +-
 kernel/bpf/bpf_local_storage.c                | 200 +++++++++++-------
 kernel/bpf/bpf_task_storage.c                 | 154 ++------------
 kernel/bpf/helpers.c                          |   4 -
 net/core/bpf_sk_storage.c                     |  10 +-
 .../bpf/map_tests/task_storage_map.c          | 128 -----------
 .../selftests/bpf/prog_tests/btf_dump.c       |   4 +-
 .../bpf/prog_tests/task_local_storage.c       |   8 +-
 .../bpf/progs/read_bpf_task_storage_busy.c    |  38 ----
 11 files changed, 177 insertions(+), 451 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/map_tests/task_storage_map.c
 delete mode 100644 tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c

-- 
2.47.3


