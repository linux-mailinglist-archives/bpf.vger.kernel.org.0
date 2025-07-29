Return-Path: <bpf+bounces-64657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CF1B152BA
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344F0545B28
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6458521ADC9;
	Tue, 29 Jul 2025 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euw/hil0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2D22DA0C;
	Tue, 29 Jul 2025 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813554; cv=none; b=pjQQg7yJX5oIQ9GliSiO7kLJ0BHCW/BzEL+njbm7edUnpEVcq+QxWvCv9w/UYWHNy44o2QT1/FzpwwaCn15ajVAhPZ++SE04Rv0PP3LUW90I/KcRHArt7BVe+dS+EAEU8KJrtYoKI3OgVacl6QyJxOiCCGOlB8vREhEfOXySCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813554; c=relaxed/simple;
	bh=R8tAAhDsHaChf/6OH1TL9IoKL1OxAGqSUkmeWxj0sQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eo5FImfTSk4BGuhPkJbZD7E/bLsf3UavUxHccBZetqmt8y8GuWfU/GfEeF5bCs9DiW1UhMNvHeEdKpCc0br/eIB4l1FZXtqzWLifvUTHIkIkaWsnOsP6zpxzMmLyY8IqmJJveQmKfg9qmmoIh6RYWrfy1FP+2Giy35ZTLdkKoWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euw/hil0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-75ce8f8a3cdso3850651b3a.0;
        Tue, 29 Jul 2025 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753813552; x=1754418352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wceFqw6JNPoeqfDtoYx/iGTWc7FUSt0YkQXDCevlJm4=;
        b=euw/hil0BzbIFLan2fzwjaWBRQ3eT8E3N45lvOLwjbRJWJPeECS4pm6/x0TKB6ttZ9
         THAaytH7zwHkuT8Xkn96YAwrnoq6TkPoa0LMSfIu03nc6IqhtjB6OfQ75fK142RWS5YV
         ASwB6GM+tdS2EgW1BaTqUt6YLJYx61V2gZs0RA53ypHvjnyTGYOQDaJLhhTHuww2pT7z
         6hh5EsekP2RWkZ8h5FP7Sx80Xdl2cYaIBi+cox4dN55F48WGn+zx4bqUzyO5R19kxZox
         GFXvsW9Q23lV/f1X2L7yToxvgZdqOdOWGkThmvZbN4Wbmaw7HU5nmbPgD31W7DBW2z6n
         L3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813552; x=1754418352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wceFqw6JNPoeqfDtoYx/iGTWc7FUSt0YkQXDCevlJm4=;
        b=CD4wTvieTCleQUquapUuAevbPmj6yYxJFmfog5TrnhECHcCcIwLitfg9kjwyAUzhZM
         uVhFgqmCZwlCOkFnx1gsN5lXeLgjF4qD0BndFdklu1TrL1GrqpeZndcTOVDhXJ9GqAzs
         AfRcDmjz21SI+TEvkp4Cm3vxc7tx1hSXTJpSdxLNaAD7feb+6+O9F3QzsaAR7G4WZT97
         40InHuCA1Ay74YC6pgAfV1fBbY5hY0vx94xaQ/de/voR0zE7yLJKnHA+9nIzNvw3jLGT
         AJ23z4QPicdX4b4WwvG/9ZQI+R0QkIWRtru68k6zeXCHogXlfLHeUfhWG7oO7jD3QifE
         MSUg==
X-Gm-Message-State: AOJu0Yy6S8opTat3ITPn0GjavXdoaZXA96gZy113anf3fvHybaBN020E
	hb8DkHCetBr+yZ3TlxvSucCAEcbz3y1hPqaL+xKocRMiTQk9AWXUMFcMl9zLwQ==
X-Gm-Gg: ASbGncuuihFVs2Oq33R9eB60/W6FG8+qrBlUfZQkE6KB7Exegm/ZSQ1P4nTBpf2KgSV
	OQy32gBKwZvEsh3IUeBENXaO02S83WEYWCRh6CurF1+WBj7L0fT9EYcATnimsD0LYjAwQdWIynI
	iev4EnB92dzI4O9eLwRxeM+FOdUayzA4X6yNA2ByoxpL9xP82u41yZAg08EPYvE7u9csRSLsV6h
	Ldr6ZFQ+rCfDOVDuaYp4VkaGP9yPSJoKgdd7d1sbPPdVmX2sbFTf7PsblXCTCLZzHMMZKG8mN9h
	b0MzOurx9oT8gin9m+aENPRwUZhr49zyxvLoz8ty1K5zMFq7Sz+tAUttUO14a++qbhf6XzGUN6W
	xAHy/qPbM7zvr
X-Google-Smtp-Source: AGHT+IHwuNndI0REEvGYHvlYTy+JJ7RdBybAZT4Kbp0/hn+08beSkIQSgGxQEi/zujfWOgGXriQeGg==
X-Received: by 2002:a05:6a21:998f:b0:235:b6de:447e with SMTP id adf61e73a8af0-23dc0cf6ef5mr725558637.2.1753813551970;
        Tue, 29 Jul 2025 11:25:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f6b0361sm7651249a12.48.2025.07.29.11.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:25:51 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	kpsingh@kernel.org,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 00/11] Remove task and cgroup local
Date: Tue, 29 Jul 2025 11:25:38 -0700
Message-ID: <20250729182550.185356-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
is no guaranteed upper bound of the loop for a succeess call. Therefore,
this patchset seeks to remove the percpu counter and makes the related
bpf syscalls and helpers more reliable, while still make sure recursion
deadlock will not happen, with the help of resilient queued spinlock
(rqspinlock).


* Implementation *

To remove the percpu counter without introducing deadlock,
bpf_local_storage is refactored by changing the locks from raw_spin_lock
to rqspinlock, which prevents deadlock with deadlock detection and a
timeout mechanism.

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


The refactoring is divided into three steps.

First, in patch 1-4, local storage helpers that take locks are being
converted to failable. The functions are changed from returning void to
returning an int error code with the return value temporarily set to 0.
In callers where the helpers cannot fail in the middle of an update,
the helper is open coded. In callers that are not allowed to fail, (i.e.,
bpf_local_storage_destroy() and bpf_local_storage_map_free(), we make
sure the functions cannot be called recursively, causing deadlock, and
assert the return value to be 0.

Then, in patch 5, the locks are changed to rqspinlock, and the error
returned from raw_res_spin_lock_irqsave() is propogated to the syscalls
and heleprs.

Finally, in patch 7-8, the percpu counters in task and cgroup local
storage are removed.

Question:

- In bpf_local_storage_destroy() and bpf_local_storage_map_free(), where
  it is not allow to fail, I assert that the lock acquisition always
  succeeds based on the fact that 1) these paths cannot run recursively
  causing AA deadlock and 2) local_storage->lock and b->lock are always
  acquired in the same order, but I also notice that rqspinlock has
  a timeout fallback. Is this assertion an okay thing to do? 


* Test *

Task and cgroup local storage selftests have already covered deadlock
caused by recursion. Patch 9 updates the expected result of task local
storage selftests as task local storage bpf helpers can now run on the
same CPU as they don't cause deadlock.

* Patch organization *

  E(exposed) L(local storage lock) B(bucket lock)
  EL    __bpf_local_storage_insert_cache (skip cache update)
  ELB   bpf_local_storage_destroy (cannot recur)
  ELB   bpf_local_storage_map_free (cannot recur)
  ELB   bpf_selem_unlink                  --> Patch 4
  E B   bpf_selem_link_map                --> Patch 2
    B   bpf_selem_unlink_map              --> Patch 1
   L    bpf_selem_unlink_storage          --> Patch 3
  
  During the refactoring, to make sure all exposed functions
  handle the error returned by raw_res_spin_lock_irqsave(),
  __must_check is added locally to catch all callers.
  
  Patch 1-4
    Convert local storage helpers to failable, or open-code
    the helpers
  
  Patch 5
    Change local_storage->lock and b->lock from
    raw_spin_lock to rqspinlock
  
  Patch 6
    Remove percpu lock in task local storage and remove
    bpf_task_storage_{get,delete}_recur()
  
  Patch 7
    Remove percpu lock in cgroup local storage
  
  Patch 8
    Remove percpu lock in bpf_local_storage
  
  Patch 9
    Update task local storage recursion test
  
  Patch 10
    Remove task local storage stress test
  
  Patch 11
    Update btf_dump to use another percpu variable
  
----

Amery Hung (11):
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
 kernel/bpf/bpf_cgrp_storage.c                 |  60 +-----
 kernel/bpf/bpf_inode_storage.c                |   6 +-
 kernel/bpf/bpf_local_storage.c                | 202 ++++++++++++------
 kernel/bpf/bpf_task_storage.c                 | 153 ++-----------
 kernel/bpf/helpers.c                          |   4 -
 net/core/bpf_sk_storage.c                     |  10 +-
 .../bpf/map_tests/task_storage_map.c          | 128 -----------
 .../selftests/bpf/prog_tests/btf_dump.c       |   4 +-
 .../bpf/prog_tests/task_local_storage.c       |   8 +-
 .../bpf/progs/read_bpf_task_storage_busy.c    |  38 ----
 11 files changed, 184 insertions(+), 443 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/map_tests/task_storage_map.c
 delete mode 100644 tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c

-- 
2.47.3


