Return-Path: <bpf+bounces-63635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C22B09225
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E641C45D9A
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51EC2FCE3C;
	Thu, 17 Jul 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3LtFwtj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC8B2BE039;
	Thu, 17 Jul 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770926; cv=none; b=sFe+MRalkmX+IWv/nRyPSOugRD91sjvtPn6sm//XR3H73PYX1ulCNhAjR5Nmtpz3lCLRj+b0/0sUEeDj4z3f22Ru4TDSR2oV0i76u0EmpUzVjhBNf1AxDYH7kwHa7HA0MIX8+tnL50Y53sHNESmrjShYcbDvs0d/nCdnfYxbqMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770926; c=relaxed/simple;
	bh=J9OTlutyIDrxyKwrnua/9uUiGYGOBbc673wKtxDGfmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CdexaI1pBrNoSS0ITtwu5/SYTbLJrklAzrt0s/p+KdoS6lY9rvRlQiUI2rZ1b+G/XOBLQut0VcQp713TPFM9uXSVAY6WU+qB8lhW5MG/tbxvEMdx7PwR8wlG5sHK7L1drBSCN/KRh4ZVwEZBzZ0U+kRIWfBhkhYMQWcOohASfS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3LtFwtj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74264d1832eso1732584b3a.0;
        Thu, 17 Jul 2025 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752770924; x=1753375724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KVdPMbegWLKLiVVq6vlP0k6ssUgjV11Nzyr728pYeK0=;
        b=g3LtFwtjTOb6SHG31Cga4eSvo0pXhB5mn9qN/r5S2WfMX9geyng47U58WOhN4Ykn/w
         J0E3Uh118A0aMlY6W8iXWc9dE9N+nv5I6sZ9j8pCLrUH9IPP5A7jpPHE1wU3filCMIvR
         a6fqtRnhYjjOfLSj4a8uZY8OrsG7staITjtrhf6ltlXEOx9Kk7WRdifT030SS2+X3ECn
         6/SzjI0ei052V0NIPT+tuWPGB7RE2bgeKmr+a2QhT00zonkxKPivEgSmPVi/DgBDMH98
         RZ6d5SzeGU4DHwVgIxaIS2wGdHp/OLXq6emcW2NNjvivsguYY8oGcexbRZmkihlzf7EV
         UNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770924; x=1753375724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVdPMbegWLKLiVVq6vlP0k6ssUgjV11Nzyr728pYeK0=;
        b=Hqf8FLV9xI0cKpmri4ioSEoQOIFi75bD9ZvyYoYjqOXQFK++p83opmgDxcxrk6129o
         GYXLIGf7+l0FyIkVeN6PjwjeE7MIGVqgfUb6vhcmJ6HsjXZpjO6gMSwGkhpRh8mW2wbY
         FdTiqDwByNgSq3p+rsO+lQY1sAD16SKHtxp7b13hMN2bBrLNgRk+H4a0mNGFXQKrLGek
         M97vFQEeL6nPSwq06vtkD456o1POKm1sK+inlyO5STbjTdWZ6BzhV9qpTShHziRqCWT4
         VrH2Z7F9P0Rhckvxy5ZriDwehhpa5D9ualDdp6R2MWSBp0TvElgIMj6TXZNWC+59d1TY
         5SWg==
X-Gm-Message-State: AOJu0YxAKl/KnghRCSabLK28FhsKllbeRDf3KKv0wouRC2ZEc4zv7AQ6
	JHnlrmZqI2+FaIk1+/LRqGP/U8xqkS2RdxACi0GFkYvalEcxRIZOronpKBEd/Q==
X-Gm-Gg: ASbGncvNhgb0+SLu1ex1gwbFHz5uaBjKZtJBRZzQWzWRNCuwSTNT5WbiuLvgwHNCoxW
	0ooAvNaXHnXdgIVFf3ShMHQTUlrZytJiQrPt4p6HwmpC4uOvzp9JRkukPT3RCjafft7ROVwSWyf
	UF8wES+z7FHttCVmyy6gwibaGLspOJWnSHrQgE9HOtLedWkGl79DIYXgaVI5/Z9AIYaicyieTfg
	1Z06R7RcCp+/C9Aol+7PfukS2FzVaAPShfzGi1m/3Zb/tp997SeIhrKniD13Me+tKJONQUQzUaG
	la/dGNy+labqZos4ttwi+pCpZsA9IN5XayWLT80yPYjbKr8gSmwUWFvXf/0RqYJwrifYN9mzM/p
	iC3z9IfE4SwUK
X-Google-Smtp-Source: AGHT+IFq6b31Wu1YNXFIiJKGTA1pYZtFT9TiQjcfZnDxuR872mjoKYtyZyRKDllRc1mhxHMi7Uj7pA==
X-Received: by 2002:a05:6a00:a8a:b0:740:b5f9:287b with SMTP id d2e1a72fcca58-75723165190mr9355733b3a.1.1752770923587;
        Thu, 17 Jul 2025 09:48:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe7281d5sm15885226a12.65.2025.07.17.09.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:48:43 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 0/3] Task local data
Date: Thu, 17 Jul 2025 09:48:38 -0700
Message-ID: <20250717164842.1848817-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Motivation *

CPU schedulers can potentially make a better decision with hints from
user space process. To support experimenting user space hinting with
sched_ext, there needs a mechanism to pass a "per-task hint" from user
space to the bpf scheduler "efficiently".

The proposed mechanism is task local data. Similar to pthread key or
__thread, it allows users to define thread-specific data. In addition,
the user pages that back task local data are pinned to the kernel to
share with bpf programs directly. As a result, user space programs
can directly update per-thread hints, and then bpf program can read
the hint with little overhead. The diagram in the design section gives
a sneak peek of how it works.


* Overview *

Task local data defines an abstract storage type for storing data specific
to each task and provides user space and bpf libraries to access it. The
result is a fast and easy way to share per-task data between user space
and bpf programs. The intended use case is sched_ext, where user space
programs will pass hints to sched_ext bpf programs to affect task
scheduling.

Task local data is built on top of task local storage map and UPTR[0]
to achieve fast per-task data sharing. UPTR is a type of special field
supported in task local storage map value. A user page assigned to a UPTR
will be pinned by the kernel when the map is updated. Therefore, user
space programs can update data seen by bpf programs without syscalls.

Additionally, unlike most bpf maps, task local data does not require a
static map value definition. This design is driven by sched_ext, which
would like to allow multiple developers to share a storage without the
need to explicitly agree on the layout of it. While a centralized layout
definition would have worked, the friction of synchronizing it across
different repos is not desirable. This simplify code base management and
makes experimenting easier.

In the rest of the cover letter, "task local data" is used to refer to
the abstract storage and TLD is used to denote a single data entry in
the storage.


* Design *

Task local data library provides simple APIs for user space and bpf
through two header files, task_local_data.h and task_loca_data.bpf.h,
respectively. The usage is illustrated in the following diagram.
An entry of data in the task local data, TLD, first needs to be defined
with TLD_DEFINE_KEY() with the size of the data and a name associated with
the data. The macro defines and initialize an opaque key object of
tld_key_t type, which can be used to locate a TLD. The same key may be
passed to tld_get_data() in different threads, and a pointer to data
specific to the calling thread will be returned. The pointer will
remain valid until the process terminates, so there is not need to call
tld_get_data() in subsequent accesses.

TLD_DEFINE_KEY() is allowed to define TLDs up to roughly a page. In the
case when a TLD can only be known and created on the fly,
tld_create_key() can be called. Since the total TLD size cannot be known
beforehand, a memory of size TLD_DYN_DATA_SIZE is allocated for each
thread to accommodate them.

On the bpf side, programs will use also use tld_get_data() to locate
TLDs. The arugments contain a name and a key to a TLD. The name is
used for the first tld_get_data() to a TLD, which will lookup the TLD
by name and save the corresponding key to a task local data map,
tld_key_map. The map value type, struct tld_keys, __must__ be defined by
developers. It should contain keys used in the compilation unit.


 ┌─ Application ───────────────────────────────────────────────────────┐
 │ TLD_DEFINE_KEY(kx, "X", 4);      ┌─ library A ─────────────────────┐│
 │                                  │ void func(...)                  ││
 │ int main(...)                    │ {                               ││
 │ {                                │     tld_key_t ky;               ││
 │      int *x;                     │     bool *y;                    ││
 │                                  │                                 ││
 │      x = tld_get_data(fd, kx);   │     ky = tld_create_key("Y", 1);││
 │      if (x) *x = 123;            │     y = tld_get_data(fd, ky);   ││
 │                         ┌────────┤     if (y) *y = true;           ││
 │                         │        └─────────────────────────────────┘│
 └───────┬─────────────────│───────────────────────────────────────────┘
         V                 V
 + ─ Task local data ─ ─ ─ ─ ─ +  ┌─ BPF program ──────────────────────┐
 | ┌─ tld_data_map ──────────┐ |  │ struct tld_object obj;             │
 | │ BPF Task local storage  │ |  │ bool *y;                           │
 | │                         │ |  │ int *x;                            │
 | │ __uptr *data            │ |  │                                    │
 | │ __uptr *metadata        │ |  │ if (tld_init_object(task, &obj))   │
 | └─────────────────────────┘ |  │     return 0;                      │
 | ┌─ tld_key_map ───────────┐ |  │                                    │
 | │ BPF Task local storage  │ |  │ x = tld_get_data(&obj, kx, "X", 4);│
 | │                         │ |<─┤ if (x) /* do something */          │
 | │ tld_key_t kx;           │ |  │                                    │
 | │ tld_key_t ky;           │ |  │ y = tld_get_data(&obj, ky, "Y", 1);│
 | └─────────────────────────┘ |  │ if (y) /* do something */          │
 + ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ +  └────────────────────────────────────┘
 


* Implementation *

Task local data defines the storage to be a task local storage map with
two UPTRs, data and metadata. Data points to a blob of memory for storing
TLDs individual to every task with the offset of data in a page. Metadata,
individual to each process and shared by its threads, records the total
number and size of TLDs and the metadata of each TLD. Metadata for a
TLD contains the key name and the size of the TLD.

  struct u_tld_data {
          u64 start;
          char data[PAGE_SIZE - 8];
  };

  struct u_tld_metadata {
          u8 cnt;
          u16 size;
          struct metadata data[TLD_DATA_CNT]; 
  };

Both user space and bpf API follow the same protocol when accessing
task local data. A pointer to a TLD is located by a key. tld_key_t
effectively is the offset of a TLD in data. To add a TLD, user space
API, loops through metadata->data until an empty slot is found and update
it. It also adds sizes of prior TLDs along the way to derive the offset.
To locate a TLD in bpf when the first time tld_get_data() is called,
__tld_fetch_key() also loops through metadata->data until the name is
found. The offset is also derived by adding sizes. When the TLD is not
found, the current TLD count is cached instead to skip name comparison
that has been done. The detail of task local data operations can be found
in patch 1.


* Misc *

The metadata can potentially use run-length encoding for names to reduce
memory wastage and support save more TLDs. I have a version that works,
but the selftest takes a bit longer to finish. More investigation needed
to find the root cause. I will save this for the future when there is a
need to store more than 63 TLDs.


[0] https://lore.kernel.org/bpf/20241023234759.860539-1-martin.lau@linux.dev/

---

v5 -> v6
  - Address Andrii's comment
  - Fix verification failure in no_alu32
  - Some cleanup
  v5: https://lore.kernel.org/bpf/20250627233958.2602271-1-ameryhung@gmail.com/

v4 -> v5
  - Add an option to free memory on thread exit to prevent memory leak
  - Add an option to reduce memory waste if the allocator can
    use just enough memory to fullfill aligned_alloc() (e.g., glibc)
  - Tweak bpf API
      - Remove tld_fetch_key() as it does not work in init_tasl
      - tld_get_data() now tries to fetch key if it is not cached yet
  - Optimize bpf side tld_get_data()
      - Faster fast path
      - Less code
  - Use stdatomic.h in user space library with seq_cst order
  - Introduce TLD_DEFINE_KEY() as the default TLD creation API for
    easier memory management.
      - TLD_DEFINE_KEY() can consume memory up to a page and no memory
        is wasted since their size is known before per-thread data
        allocation.
      - tld_create_key() can only use up to TLD_DYN_DATA_SIZE. Since
        tld_create_key can run any time even after per-thread data
        allocation, it is impossible to predict the total size. A
        configurable size of memory is allocated on top of the total
        size of TLD_DEFINE_KEY() to accommodate dynamic key creation.
  - Add tld prefix to all macros
  - Replace map_update(NO_EXIST) in __tld_init_data() with cmpxchg()
  - No more +1,-1 dance on the bpf side
  - Reduce printf from ASSERT in race test
  - Try implementing run-length encoding for name and decide to
    save it for the future
  v4: https://lore.kernel.org/bpf/20250515211606.2697271-1-ameryhung@gmail.com/

v3 -> v4
  - API improvements
      - Simplify API
      - Drop string obfuscation
      - Use opaque type for key
      - Better documentation
  - Implementation
      - Switch to dynamic allocation for per-task data
      - Now offer as header-only libraries
      - No TLS map pinning; leave it to users
  - Drop pthread dependency
  - Add more invalid tld_create_key() test
  - Add a race test for tld_create_key()
  v3: https://lore.kernel.org/bpf/20250425214039.2919818-1-ameryhung@gmail.com/


Amery Hung (3):
  selftests/bpf: Introduce task local data
  selftests/bpf: Test basic task local data operations
  selftests/bpf: Test concurrent task local data key creation

 .../bpf/prog_tests/task_local_data.h          | 388 ++++++++++++++++++
 .../bpf/prog_tests/test_task_local_data.c     | 297 ++++++++++++++
 .../selftests/bpf/progs/task_local_data.bpf.h | 227 ++++++++++
 .../bpf/progs/test_task_local_data.c          |  65 +++
 4 files changed, 977 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_data.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.bpf.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_data.c

-- 
2.47.1


