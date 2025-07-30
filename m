Return-Path: <bpf+bounces-64739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D392B166A1
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 20:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E8E1887F51
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0312E2647;
	Wed, 30 Jul 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZUJbN0J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E672E040D;
	Wed, 30 Jul 2025 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901947; cv=none; b=jqUyBuLJDrHNOswjkEACoey3nE5JNFB2UN2ZcT6HAoXRJLY5DWW717pkTtupAIQ5Ox7N4FITFtJG1RygbkuZJADG6XWUl5dQWsQXkIu+7VbfmyWTcvWQD8WbPPqXvbHmKj5swdQyyWRILEcEl/K1cV9eM2ZPP82Unl/hlY4PJMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901947; c=relaxed/simple;
	bh=9sbowcg/drUdkcPedeiHktT4sqUszdVk3khY8gQb71E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KmXQ7K27LQ6xzjXm2allnBFhk/NtCuF5wzUaSBGHBbjlCc9E5PN105IyjE7yn8lUb+e/JTRz56wYrYEmVjo3U1U6D5N3+qbeNc8Quu7JuaFuzAR8UMJVf+xKy1CpI/PWaJtCqUY4zDFQijfC9zHxCzsPwKDGqegYizw5LDsm4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZUJbN0J; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23c8f179e1bso2556445ad.1;
        Wed, 30 Jul 2025 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753901945; x=1754506745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hfk9xLzaTCd2LGwxnk+XQ1fDW+4JKTY7e71FlqF7RY=;
        b=SZUJbN0J5YjP18zrXafULPXBSMNayzVmFVu3YrOA1ihER6MqyYwMiQ+SqiyhAkj/P5
         EVvGj0ZsicbjhEJonhAOSkNTn1jrFARibihxyiBjFueYQMHqJQ4RvueHZTKjLrduBFDe
         2e1iiM9KHd4vkvlChmUTupbaxem++L9HEVD8zTC80oHieVIkzzGXc4iauK2iT1m8fGMA
         Edz3v92yrs+LH0lffeQymvAg1QZRK3EH5r4SEzA4Q0kmdwkWxocyuCj9lAdVcMdtHdSi
         XITDv09mb4eDaZNOwi++3nIh9XUTooeplq7SfBxkshMB8DsbLa0+TJnlwGdDAfwkaYJv
         esmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753901945; x=1754506745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Hfk9xLzaTCd2LGwxnk+XQ1fDW+4JKTY7e71FlqF7RY=;
        b=IZJEjwsrjU4dyc7D+d/z2LXg/eiX4e3CK8QnS8pl5R4YfZbBNRDExnwZQU6EFgW6eb
         i9x1oMiLKWvriXyKNbfrHhKcRgWifjheDZcI9mOAu2jvjRgWhy+5r2vnbL7jSxzzWVHV
         Hf8/pLw+RQn0HUtnYsYh3LFonaOgljMQLj9jxpxWAemvjOUkEI7LKvkUNj6PbvDzTC3w
         g/w+/D+IDkutrBkp5uxVEZyRT2xVbAwuvajAAiONu8urY/bMw5J9tgItQ1PWdwxjwXDl
         I6kq6KMaRXqief6yZtnDlQqrjhUdf1rY9Uv2EjCS7HS/ifQKAwK9ojbXx72l/33zIl6k
         dPAw==
X-Gm-Message-State: AOJu0YxgxR9e5fY6rPQDgeEybKUcQKb3XyGWwTyxT/JOcCR68ZyJ7mTD
	OtWNlc/YxZvcWmiswRoxn3XpwUabj9QjCd015VdNJfDX0F+NxIg6RXYn9JX8mw==
X-Gm-Gg: ASbGncsY4t2934GJEKTsDG/uOrB5WtqlF4j6BWRhYIo95wCxE/7qnuBzqV+9UCmqoCi
	miUrN0HAjItsnSPGdSIWE2K+Oxx7jtsCMcV8iOFYF3tksUntfTR0yP83lsIYNUsGgqkMLQf1PWn
	2puSDfklSjV4bQH94KmVOQZfsSvfdRnLfnG9Y1cRleQU3Fser8KVs1YlQMPnPixi7FH/K3YXDbd
	lr3H9R7MVQH5aSYbIZDlWMBzuoKw67nP6APhDkv4dZ17oew8e1wN/4e/V8/eCpRkfOpXN9zFmYR
	5/p+1BzI7IUwAG6W7/Vx5NsiA6bT4WeyTNROpWeZTBR34UA5CzLO/CZbJCFWrjka1UaqlsSnCFG
	6PBmLQbwQaZIHUA==
X-Google-Smtp-Source: AGHT+IHAKDrqMlMqLeGkLRavVZX0YSAURApgIielVqjM+DQT5E1sMLNumfmCs6H4rL0Isc9nIZHT2g==
X-Received: by 2002:a17:902:c94d:b0:240:bc10:804a with SMTP id d9443c01a7336-240bc108482mr25261665ad.43.1753901944532;
        Wed, 30 Jul 2025 11:59:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dbb545sm2687224a91.9.2025.07.30.11.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:59:04 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	linux-lists@etsalapatis.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 0/4] Task local data
Date: Wed, 30 Jul 2025 11:58:51 -0700
Message-ID: <20250730185903.3574598-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v6 -> v7
  - Fix typos and improve the clarity of the cover letter (Emil)
  - Some variable naming changes to make it less confusing (Emil)
  - Add retry in tld_obj_init() as bpf_task_storage_get_recur() with
    BPF_LOCAL_STORAGE_GET_F_CREATE can fail if the task local storage
    is also being modified by other threads on the same CPU. This can
    be especially easy to trigger in CI VM that only has two CPUs.

    Adding bpf_preempt_{disable,enable} around bpf_task_storage_get()
    does not solve the problem as other threads competing for the percpu
    counter lock in task local storage may not limit to bpf helpers.
    Some may be calling bpf_task_storage_free() when threads exit.

    There is no good max retry under heavy contention. For the 1st
    selftest in this set, the max retry to guarantee success grows
    linearly with the thread count. A proposal is to remove the percpu
    counter by changing locks in bpf_local_storage to rqspinlock.

    An alternative is to reduce the probability of failure by allowing
    bpf syscall and struct_ops programs to use bpf_task_storage_get()
    instead of the _recur version by modifying bpf_prog_check_recur().
    This does not solve the problem in tracing programs though.

    v6: https://lore.kernel.org/bpf/20250717164842.1848817-1-ameryhung@gmail.com/

* Overview *

This patchset introduces task local data, an abstract storage type
shared between user space and bpf programs for storing data specific to
each task, and implements a library to access it. The goal is to provide
an abstraction + implementation that is efficient in data sharing and
easy to use. The motivating use case is user space hinting with
sched_ext.


* Motivating use case *

CPU schedulers can potentially make a better decision with hints from
user space process. To support experimenting user space hinting with
sched_ext, there needs a mechanism to pass a "per-task hint" from user
space to the bpf scheduler "efficiently".

A bpf feature, UPTR [0], supported by task local storage is introduced
to serve the needs. It allows pinning a user space page to the kernel
through a special field in task local storage map. This patchset further
builds an abstraction on top of it to allow user space and bpf programs
to easily share per-task data.


* Design *

Task local data is built on top of task local storage map and UPTR to
achieve fast per-task data sharing. UPTR is a type of special field
supported in task local storage map value. A user page assigned to a UPTR
will be pinned to the kernel when the map is updated. Therefore, user
space programs can update data that will be seen by bpf programs without
syscalls.

Additionally, unlike most bpf maps, task local data does not require a
static map value definition. This design is driven by sched_ext, which
would like to allow multiple developers to share a storage without the
need to explicitly agree on the layout of it. While a centralized layout
definition would have worked, the friction of synchronizing it across
different repos is not desirable. This simplify code base management and
makes experimenting easier.


* Introduction to task local data library *

Task local data library provides simple APIs for user space and bpf
through two header files, task_local_data.h and task_local_data.bpf.h,
respectively. The diagram below illustrates the basic usage.

First, an entry of data in task local data, we call it a TLD, needs to
be defined in the user space through TLD_DEFINE_KEY() with information
including the size and the name. The macro will define a global variable
key of opaque type tld_key_t associated with the TLD and initialize it.
Then, the user space program can locate the TLD by passing the key to
tld_get_data() in different thread, where fd is the file descriptor of
the underlying task local storage map. The API returns a pointer to the
TLD specific to the calling thread and will remain valid until the
thread exits. Finally, user space programs can directly read/write the
TLD without bpf syscalls.

To use task local storage on the bpf side, struct tld_keys, needs to
be defined first. The structure that will be used to create tld_key_map
should contain the keys to the TLDs used in a bpf program. In the bpf
program, tld_init_object() first needs to be called to initialize a
struct tld_object variable on the stack. Then, tld_get_data() can be
called to get a pointer to the TLD similar to the user space. The API
will use the name to lookup task local data and cache the key in task
local storage map, tld_key_map, to speed up subsequent access. The size
of the TLD is also needed to prevent out-of-bound access in bpf.


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
 | │ tld_data_u __uptr *data │ |  │                                    │
 | │ tld_meta_u __uptr *meta │ |  │ if (tld_init_object(task, &obj))   │
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
two UPTRs pointing to tld_data_u and tld_meta_u. tld_data_u, individual
to each thread, contains TLD data and the starting offset of data in a
page. tld_meta_u, shared by threads in a process, consists of the TLD
counts, total size of TLDs and tld_metadata for each TLD. tld_metadata
contains the name and the size of a TLD.

  struct tld_data_u {
          u64 start;
          char data[PAGE_SIZE - sizeof(u64)];
  };

  struct tld_meta_u {
          u8 cnt;
          u16 size;
          struct metadata metadata[TLD_DATA_CNT]; 
  };

Both user space and bpf API follow the same protocol when accessing
task local data. A pointer to a TLD is located using a key. The key is
effectively the offset of a TLD in tld_data_u->data. To define a new
TLD, the user space API TLD_DEFINE_KEY() iterates tld_meta_u->metadata
until an empty slot is found and then update it. It also adds up sizes
of prior TLDs to derive the offset (i.e., key). Then, to locate a TLD,
tld_get_data() can simply return tld_data_u->data + offset.

To locate a TLD in bpf programs, an API with the same name as the user
space, tld_get_data() can be called. It takes more effort in the first
invocation as it fetches the key by name. Internal helper,
__tld_fetch_key() will iterate tld_meta_u->metadata until the name is
found. Then, the offset is cached as key in another task local storage
map, tld_key_map. When the search fails, the current TLD count is
cached instead to skip searching metadata entries that has been searched
in future invocation. The detail of task local data operations can be
found in patch 1.


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

---

Amery Hung (4):
  bpf: Allow syscall bpf programs to call non-recur helpers
  selftests/bpf: Introduce task local data
  selftests/bpf: Test basic task local data operations
  selftests/bpf: Test concurrent task local data key creation

 include/linux/bpf_verifier.h                  |   1 +
 .../bpf/prog_tests/task_local_data.h          | 386 ++++++++++++++++++
 .../bpf/prog_tests/test_task_local_data.c     | 297 ++++++++++++++
 .../selftests/bpf/progs/task_local_data.bpf.h | 237 +++++++++++
 .../bpf/progs/test_task_local_data.c          |  65 +++
 5 files changed, 986 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_data.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.bpf.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_data.c

-- 
2.47.3


