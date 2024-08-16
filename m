Return-Path: <bpf+bounces-37390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B19D95513C
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 21:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F0B1F23428
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 19:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D041C37B2;
	Fri, 16 Aug 2024 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2rAiy34"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36080145A17
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835540; cv=none; b=Pi6lSQ8Nl/pzdmTUv439gWJFUiaffCelh4snwbpm5PoIHlhLxtNyrVvqrLjF5go5ouwNO654qiyXxkxwn5Ro1dNYahPuyTaEKxgktFbsvOar+oIVQIjl754as/CgHEZDJm3XRDkYjMdZRHAGY7qe3iSidrKxlAgsXUeLK/wuxF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835540; c=relaxed/simple;
	bh=nyifl6RZwBGIY6bskg+aVIamNRPTL9gc9dsZU/VvQkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vrr/ZewPwEqEZJiPc/RDEO9HF7H17zc0aH8XEyj/m3dfmU1ghZFBBQKAAi4HE/76OsF2a237dfcogEySjOczOSAMpm937HBSTsgwOaIB1M95X2aW9qr48ssJLH7HwaaaOygx0/LZMWioFPIbiK1BCfyFsNorGHrsiNUroQdVAjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2rAiy34; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfef5980a69so2399360276.3
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723835538; x=1724440338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4K7h2XVRmrOkxv+i828p+HD+Aa9aOWNIYj0rcTt5q+o=;
        b=T2rAiy34owfJYmeSdSxpncTJHVl1vQTh22UpGYWheUu1bjgczdAUkiwegWyPVhL0e9
         mdDVnfDAxMQIRFq2gRd+GlEO/LXXxVeVM5SmRDElifba90a3FvkkcjSS5C+yoc14+d6p
         ZUdOsXtNzSPzCONRwoKZutKEwn98cA5dV/xXIdPttnnaKvB4IHTZcfvCT85YNZNQAdNf
         ZYQXHQqRWd2lfTTeG6IfSj7sqe8hWxY/6Mnp6SsntNV7O2KYEgvsX0AiiW6/90MfzF7K
         vU+ocomTXiy98wCz77EHTyP2doB+aw6TOei1eAYeKg95L7XuPQjko8TKfapTdZUmo3Dd
         Wk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723835538; x=1724440338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4K7h2XVRmrOkxv+i828p+HD+Aa9aOWNIYj0rcTt5q+o=;
        b=ROOr8Kxjrahf2+kNLwCrq4PEUWEGM9cUThznvdta7/EeuDqb2DdoyUk/IE8Wk+X3Xf
         dsKDojmH/4Cxx01kxDw/2AnGiPzVP8XahJhZf0DzHXqXOZlwKTEWrXtIQkAtxj213kdQ
         MWvXJhERfo2N9ElCatuHX2V+uYlor9NGGZTsx2w/pyvwgAyaeWu0BmIiqy+K3tkJN8KY
         IkCgqACq1cotOc51eAjAr/rsv0Mz3SmM0La3b0rqCncLRRc8OXVRFPNECvJz7FsKhD/j
         ngRZ3kNrY/qQ/n6vK52rWVbIVeYZeUxvWfafT+eQBTy9BsG7ejYZx+g5muUZs0YB3Rcc
         xymg==
X-Gm-Message-State: AOJu0Yy9c2D0En8heh2zoZXeMENPaO7BQqaNS60BZ6JAL+L6js4Pdr3q
	FjgZ1UeaCwZ7LpyJv1TyuSdK5KMXejrF4NKg5UXmUnXbIKLyt8E5AQTpmpnl
X-Google-Smtp-Source: AGHT+IFPft6dbEm43wk9iqazfLUPr0yF3yjnkbVv0iLPOwWzjQTj0hizflOctMchaT0qdbqVz7dhIg==
X-Received: by 2002:a05:690c:5092:b0:6b0:9947:c13a with SMTP id 00721157ae682-6b1bb28eea8mr45989717b3.33.1723835537830;
        Fri, 16 Aug 2024 12:12:17 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ca12:c8db:5571:aa13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9cd7a50dsm7233327b3.94.2024.08.16.12.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:12:17 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v4 0/6] Share user memory to BPF program through task storage map.
Date: Fri, 16 Aug 2024 12:12:07 -0700
Message-Id: <20240816191213.35573-1-thinker.li@gmail.com>
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

Changes from v3:

 - Merge part 4 and 5 as the new part 4 in order to cease the warning
   of unused functions from CI.

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

v3: https://lore.kernel.org/all/20240814033010.2980635-1-thinker.li@gmail.com/
v1: https://lore.kernel.org/all/20240807235755.1435806-1-thinker.li@gmail.com/

Kui-Feng Lee (6):
  bpf: define BPF_UPTR a new enumerator of btf_field_type.
  bpf: Parse and support "uptr" tag.
  bpf: Handle BPF_UPTR in verifier.
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


