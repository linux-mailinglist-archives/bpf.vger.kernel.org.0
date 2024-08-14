Return-Path: <bpf+bounces-37143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA255951314
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 05:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8144E2835BA
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 03:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE9B10953;
	Wed, 14 Aug 2024 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpVc3277"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2901CD26
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 03:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723606216; cv=none; b=ozHK/IO4N4b3Oam3ORcZM7vHSVKopttojUPxsOfcYcFbzXXKbedkPw0kDvW6yum+H4R5BP4aAv8xUj6A4jlhWJKDsIhZmJNh2IIuYCEZQlIJOZSpdY6u7USvtXrQ285BXl874cbtdlj5XzQvxVOKY5+y+b/1rsRCaoQCPPqcozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723606216; c=relaxed/simple;
	bh=OTiB3pbOdiEyEsXeycr0x90PRK/QsWHDGfEqi0SLVZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R1zHp8XKPVddrpfZG7HRGNiyiNGZlN8kEdQhRZgKSCZ5Eeb6r6bvHzBLVVK0DY6vXE8zu4QaOLPiy2Vr+XefgFXtaRNA8Z+4d6imRLV21cBj0Mr/kUZtyktF3sof2qCKI2eqmv9qgS44OHG1bFVuQ4+4fjluLPf5Ik9QHj1Svc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpVc3277; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-66599ca3470so59057107b3.2
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 20:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723606213; x=1724211013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/25dmHx7OsocRcNzVx+zanfd0gDcLozIuO++I6OMWTE=;
        b=VpVc32776t1FlfIVgxxgvlJcCCA/SSp5PnlyFonbHwF7NnTxmTdRuYNyW4laT/zRcS
         TDeo+hNmMfDJ9iJDGoFGVxE6iIxhCp3wYjv5o7wb5ZOS/J6tjGpxD4flb++6EDCpmq/b
         W8mkFfr0I61VXfFZ8qA+/+MTXFkerS5wC3I0HI5ohNR1MzKaNSwRX/0JGAvmZu0QO9fT
         y5ZusUOTszMC99k9dg+UMUvzgPABIrKtpVgkLq8dZ0ml6bomNczMNumE/EdmQHObxhM4
         kME+MEQYCdCgWK7CSx7+QWA8HXXyzmXhjKO3K0UT6Mj4fce0tCzYjVPf3HXZ6pMMeFdg
         koTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723606213; x=1724211013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/25dmHx7OsocRcNzVx+zanfd0gDcLozIuO++I6OMWTE=;
        b=NWplaS5U3AeTHFL4hptexHOwd2C21HpmO8p8NtWeXqIwp72HSDQ1U3AkYgGvKNNIWq
         MiFlI9zcqZYwNJnPFgiCaWky9yBJF5EY7raXNSykeitSRbB/HzvsuYvA7c+I9A6jtirD
         QPb/sHnfOdf6IqEntKnfWn4aIDlUqC1e9pUSGrposdHk6jhpW7hu6Nq+ZBYiGmcIkgBi
         umDwrP1KPt5q5EunqEF1/DIk2xI7gc5jPzFu96uMrufQBJ5Sa9EjA5S9QIv17AsXwQpo
         qDqHkFzOhBytmSqqg4t4EVFIQpfblmq/RmRsdC4olxoJ+F2Kfc9O1488p307dR8d5pik
         2Ifg==
X-Gm-Message-State: AOJu0Yw7jX/fUy3SNIY+Vjc9CCYKGWuGQsL/aOm3VRDrejFkODsiXlAg
	WZIC6TrwXM9QOjFfR/UNvtAfjkA0+HM06neIJ6+heF9146oYpm+QTQxwLB5x
X-Google-Smtp-Source: AGHT+IHC4B5Nbz21m8pZKR7ghLjB65SFt29Qexk8NxzYEd8V0Z7jKEucW+6lO1L1IiXpv1onwa7xYw==
X-Received: by 2002:a05:690c:3183:b0:6ad:4548:2a85 with SMTP id 00721157ae682-6ad45576cf0mr5355737b3.39.1723606213164;
        Tue, 13 Aug 2024 20:30:13 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:3c23:99cc:16a9:8b68])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a451b597sm15109587b3.117.2024.08.13.20.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 20:30:12 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v3 0/7] Share user memory to BPF program through task storage map.
Date: Tue, 13 Aug 2024 20:30:03 -0700
Message-Id: <20240814033010.2980635-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of BPF schedulers (sched_ext) need hints from user programs to do
a better job. For example, a scheduler can handle a task in a
different way if it knows a task is doing GC. So, we need an efficient
way to share the information between user programs and BPF
programs. Sharing memory between user programs and BPF programs is
what this patchset does.

== REQUIREMENT ==

This patchset enables every task in every process to share a small
chunk of memory of it's own with a BPF scheduler. So, they can update
the hints without expensive overhead of syscalls. It also wants every
task sees only the data/memory belong to the task/or the task's
process.

== DESIGN ==

This patchset enables BPF prorams to embed __uptr; uptr in the values
of task storage maps. A uptr field can only be set by user programs by
updating map element value through a syscall. A uptr points to a block
of memory allocated by the user program updating the element
value. The memory will be pinned to ensure it staying in the core
memory and to avoid a page fault when the BPF program accesses it.

For example, the following code fragment is a part of a BPF program
that embeds a __uptr field "udata" in the value type "struct
value_type" of the task storage map "datamap". The size of the memory
pointed by a uptr is determized by its type. Here we have "struct
user_data". The BPF program can read and write this block of memory
directly.

File task_ls_uptr.c:

    struct user_data {
    	int a;
    	int b;
    	int result;
    };
    
    struct value_type {
    	struct user_data __uptr *udata;
    };
    
    struct {
    	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
    	__uint(map_flags, BPF_F_NO_PREALLOC);
    	__type(key, int);
    	__type(value, struct value_type);
    } datamap SEC(".maps");
    
    pid_t target_pid = 0;
    
    SEC("tp_btf/sys_enter")
    int BPF_PROG(on_enter, struct pt_regs *regs, long id)
    {
    	struct task_struct *task;
    	struct value_type *ptr;
    	struct user_data *udata;
    
    	task = bpf_get_current_task_btf();
    	if (task->pid != target_pid)
    		return 0;
    
    	ptr = bpf_task_storage_get(&datamap, task, 0,
    				   BPF_LOCAL_STORAGE_GET_F_CREATE);
    	if (!ptr)
    		return 0;
    
    	udata = ptr->udata;
    	if (udata)
    		udata->result = udata->a + udata->b;
    
    	return 0;
    }

The following code fragment is a corresponding user program. It calls
bpf_map_update_elem() to update "datamap" and point "udata" to a the
memory block residing in one page. The memory pointed by "udata" will
be shared between the BPF program and the user program and should not
cross multiple pages.

    static void test_uptr(void)
    {
    	struct task_ls_uptr *skel = NULL;
	static struct user_data user_data __attribute__((aligned(16))) = {
		.a = 1,
		.b = 2,
		.result = 0,
	};
    	struct value_type value;
    	int task_fd = -1;
    	int err;
    
    	value.udata = &user_data;
    
    	task_fd = sys_pidfd_open(getpid(), 0);
    	if (!ASSERT_NEQ(task_fd, -1, "sys_pidfd_open"))
    		goto out;
    
    	skel = task_ls_uptr__open_and_load();
    	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
    		goto out;
    
    	err = bpf_map_update_elem(bpf_map__fd(skel->maps.datamap), &task_fd, &value, 0);
    	if (!ASSERT_OK(err, "update datamap"))
    		goto out;
    
    	skel->bss->target_pid = syscall(SYS_gettid);
    
    	err = task_ls_uptr__attach(skel);
    	if (!ASSERT_OK(err, "skel_attach"))
    		goto out;
    
    	syscall(SYS_gettid);
    	syscall(SYS_gettid);
    
    	ASSERT_EQ(user_data->a + user_data->b, user_data->result, "result");
    out:
    	task_ls_uptr__destroy(skel);
    	close(task_fd);
    	munmap(user_data, sizeof(user_data));
    }

== MEMORY ==

In order to use memory efficiently, we don't want to pin a large
number of pages. To archieve that, user programs should collect the
memory blocks pointed by uptrs together to share memory pages if
possible. It avoid the situation that pin one page for each thread in
a process.  Instead, we can have several threads pointing their uptrs
to the same page but with different offsets.

Although it is not necessary, avoiding the memory pointed by an uptr
crossing the boundary of a page can prevent an additional mapping in
the kernel address space.

== RESTRICT ==

The memory pointed by a uptr should reside in one memory
page. Crossing multi-pages is not supported at the moment.

Only task storage map have been supported at the moment.

The values of uptrs can only be updated by user programs through
syscalls.

bpf_map_lookup_elem() from userspace returns zeroed values for uptrs
to prevent leaking information of the kernel.

---

Changes from v1:

 - Rename BPF_KPTR_USER to BPF_UPTR.

 - Restrict uptr to one page.

 - Mark uptr with PTR_TO_MEM | PTR_MAY_BE_NULL and with the size of
   the target type.

 - Move uptr away from bpf_obj_memcpy() by introducing
   bpf_obj_uptrcpy() and copy_map_uptr_locked().

 - Remove the BPF_FROM_USER flag.

 - Align the meory pointed by an uptr in the test case. Remove the
   uptr of mmapped memory.

v1: https://lore.kernel.org/all/20240807235755.1435806-1-thinker.li@gmail.com/

Kui-Feng Lee (7):
  bpf: define BPF_UPTR a new enumerator of btf_field_type.
  bpf: Parse and support "uptr" tag.
  bpf: Handle BPF_UPTR in verifier.
  bpf: add helper functions of pinning and converting BPF_UPTR.
  bpf: pin, translate, and unpin __uptr from syscalls.
  libbpf: define __uptr.
  selftests/bpf: test __uptr on the value of a task storage map.

 include/linux/bpf.h                           |  36 ++++
 kernel/bpf/bpf_local_storage.c                |  23 ++-
 kernel/bpf/btf.c                              |   5 +
 kernel/bpf/helpers.c                          |  20 ++
 kernel/bpf/syscall.c                          | 174 +++++++++++++++++-
 kernel/bpf/verifier.c                         |  37 +++-
 tools/lib/bpf/bpf_helpers.h                   |   1 +
 .../bpf/prog_tests/task_local_storage.c       | 106 +++++++++++
 .../selftests/bpf/progs/task_ls_uptr.c        |  65 +++++++
 9 files changed, 458 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/task_ls_uptr.c

-- 
2.34.1


