Return-Path: <bpf+bounces-36640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB28094B3E8
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 01:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25FF0B21562
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 23:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659EA156228;
	Wed,  7 Aug 2024 23:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBu2RIX4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4DD145FF5
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 23:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075093; cv=none; b=DUsm4DMBlXATfAgxeYeoGN9KRNEUWjlfwFIss3d38FQtNfl7vGm87X4uTBQef2GqwhFdruYlIDgj3Qu2NXEOcLdhYBV5zgoJVps1v9DpK4KtKG0nsKZgZ0hyWEwgZ9sdJKKR02HQ4lqSjHRQwN4djv7QfqRSELZgxwBFT6tOr4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075093; c=relaxed/simple;
	bh=g2jW8YhYt65X+zGdHV+kO5j/P8Smz7dldbAvKyyqOUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dp1DnnO0M8d9lXvgXXwHEWtimDjfsZP53ZAZKtkAcatQ6tqJwc7BRM0HolPcAxhVgFJuv6Tl0S/dYexlqNeQbDSshGrjyFc8yn8yMi/kvnJqTcnSUeYD+nRNGXM2xIgwJiZwr862+FCQE0y0eUsCpnq0b129E61Xu2lfLxA7q48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBu2RIX4; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-65fdfd7b3deso3705647b3.0
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 16:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723075090; x=1723679890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=28gjb2Btl8rnSjlOyyU2qv733lBOUY95pVdaE+9rFf4=;
        b=XBu2RIX4q/vls2lVG3ln1PGQqujXLLE+W2lblnFdnbRyWwSQvm2+TM0scfeepby81h
         mX5B/+soPWQRy0/lr+ZTs9kjXqgDj6AKT3ART1pyv8kSTjDsGYUpbATkjbx6xGaT189m
         sRrNSUgVnIoM22CmPENWiNp/357GwBwu8qFiwjo46VWEHXJc4o+QGJ8h6VgRe5BP1Mdv
         yB3LbkKfaga7PXAt6vDNVH467ONE1Qro9Fj2YjYbxwJx8jlmhpUlETn6zMln9ZVjkkFq
         3x1GXx68CEn6sC60WdKzh++kdFwAej8L3sMXFZ6EvWrlll3lcJZ+rK122flyHQxwzXJV
         I5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723075090; x=1723679890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28gjb2Btl8rnSjlOyyU2qv733lBOUY95pVdaE+9rFf4=;
        b=AETdbUNqG2klReauDQ16eVC8aHPrxEQz0IT9c8pG7xO8HE2VmUuujbHhYbTpaoGXWi
         swO4FsWqqcWTipZRnw+PPnvyJAdsbj2QGXzMeoGbVjgBfT1lzrJ5WDN3NeIoxZ28B61o
         0MBr1F1uFE1h0haC0oj73Vw8JpJFmbiw7apqEbFMdgF+604PQNDT9PfJgCiLTzFvjofA
         32vT9GneAXXaYRMkt7C0nqQD0yJe+6XwD5bFB4kkoChtPCEJlWZeQF+tCNz27PeDurcx
         orwxx11xPhQSOYoAixV1564NQS71KG7jnCfdPLC+i1Vs2qH93Ozi4MvnW3O6MZH14TUj
         uAvA==
X-Gm-Message-State: AOJu0YwArbA6I/ATePiVizyxjCntq1vHi3STMsUotFSBk6G63h0ImUo7
	pWNngSe2eSuxPk0p9101gQ5b+dzS9sJNxDjrinLlA+hU6OJ+dFRWcWDhKDEQ
X-Google-Smtp-Source: AGHT+IFt1CtZSgBaAGSsbOJwx/9B2wvqs5G0LbmADIOwkemYyL4GoptscJjJANlumF4plF9R3jubdQ==
X-Received: by 2002:a05:690c:290a:b0:64b:630f:9f85 with SMTP id 00721157ae682-69bf77305f1mr1158247b3.12.1723075090046;
        Wed, 07 Aug 2024 16:58:10 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f419358sm21092477b3.26.2024.08.07.16.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:58:09 -0700 (PDT)
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
Subject: [RFC bpf-next 0/5] Share user memory to BPF program through task storage map.
Date: Wed,  7 Aug 2024 16:57:50 -0700
Message-Id: <20240807235755.1435806-1-thinker.li@gmail.com>
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

This patchset tries to let every task in every process can share a
small chunk of memory of it's own with a BPF scheduler. So, they can
update the hints without expensive overhead of syscalls. It also wants
every task sees only the data/memory belong to the task/or the task's
process.

== DESIGN ==

This patchset enables BPF prorams to embed __kptr_user; user kptr, a
new type of kptrs, in the values of task storage maps. A user kptr
field can only be set by user programs by updating map element value
through a syscall. A user kptr points to a block of memory allocated
by the user program updating the element value. The memory will be
pinned to ensure it staying in the core memory and to avoid a page
fault when the BPF program accesses it.

For example, the following code fragment is a part of a BPF program
that embeds a __kptr_user field "udata" in the value type "struct
value_type" of the task storage map "datamap". The size of the memory
pointed by a user kptr is determized by its type. Here we have "struct
user_data". The BPF program can read and write this block of memory
directly.

File task_ls_kptr_user.c:

    struct user_data {
    	int a;
    	int b;
    	int result;
    };
    
    struct value_type {
    	struct user_data __kptr_user *udata;
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
bpf_map_update_elem() to update "datamap" and point "udata" to a
mmaped memory. The memory pointed by "udata" will be shared between
the BPF program and the user program.

    static void test_kptr_user(void)
    {
    	struct task_ls_kptr_user *skel = NULL;
    	struct user_data *user_data;
    	struct value_type value;
    	int task_fd = -1;
    	int err;
    
    	user_data = mmap(NULL, sizeof(user_data), PROT_READ | PROT_WRITE,
    			 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
    	if (!ASSERT_NEQ(user_data, MAP_FAILED, "mmap"))
    		return;
    	user_data->a = 1;
    	user_data->b = 2;
    	user_data->result = 0;
    	value.udata = user_data;
    
    	task_fd = sys_pidfd_open(getpid(), 0);
    	if (!ASSERT_NEQ(task_fd, -1, "sys_pidfd_open"))
    		goto out;
    
    	skel = task_ls_kptr_user__open_and_load();
    	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
    		goto out;
    
    	err = bpf_map_update_elem(bpf_map__fd(skel->maps.datamap), &task_fd, &value, 0);
    	if (!ASSERT_OK(err, "update datamap"))
    		goto out;
    
    	skel->bss->target_pid = syscall(SYS_gettid);
    
    	err = task_ls_kptr_user__attach(skel);
    	if (!ASSERT_OK(err, "skel_attach"))
    		goto out;
    
    	syscall(SYS_gettid);
    	syscall(SYS_gettid);
    
    	ASSERT_EQ(user_data->a + user_data->b, user_data->result, "result");
    out:
    	task_ls_kptr_user__destroy(skel);
    	close(task_fd);
    	munmap(user_data, sizeof(user_data));
    }

== MEMORY ==

In order to use memory efficiently, we don't want to pin a large
number of pages. To archieve that, user programs should collect the
memory blocks pointed by user kptrs together to share memory pages if
possible. It avoid the situation that pin one page for each thread in
a process.  Instead, we can have several threads pointing their user
kptrs to the same page but with different offsets.

Although it is not necessary, avoiding the memory pointed by a user
kptr crossing the boundary of a page can prevent an additional mapping
in the kernel address space.

== RESTRICT ==

There is a limitation on the number of pinned pages for one user kptr,
KPTR_USER_MAX_PAGES(16). This is random picked number for safety. We
can remove this limitation if we don't want it.

Only task storage map have been supported at the moment.

The values of user kptrs can only be updated by user programs through
syscalls. You can not change the values of user kptrs in BPF programs.

bpf_map_lookup_elem() from userspace returns zeroed values for user
kptrs to prevent leaking information of the kernel.

Kui-Feng Lee (5):
  bpf: Parse and support "kptr_user" tag.
  bpf: Handle BPF_KPTR_USER in verifier.
  bpf: pin, translate, and unpin __kptr_user from syscalls.
  libbpf: define __kptr_user.
  selftests/bpf: test __kptr_user on the value of a task storage map.

 include/linux/bpf.h                           |  43 ++++-
 include/linux/bpf_local_storage.h             |   2 +-
 kernel/bpf/bpf_local_storage.c                |  18 +-
 kernel/bpf/btf.c                              |   5 +
 kernel/bpf/helpers.c                          |  12 +-
 kernel/bpf/local_storage.c                    |   2 +-
 kernel/bpf/syscall.c                          | 179 +++++++++++++++++-
 kernel/bpf/verifier.c                         |  11 ++
 net/core/bpf_sk_storage.c                     |   2 +-
 tools/lib/bpf/bpf_helpers.h                   |   1 +
 .../bpf/prog_tests/task_local_storage.c       | 122 ++++++++++++
 .../selftests/bpf/progs/task_ls_kptr_user.c   |  72 +++++++
 12 files changed, 447 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/task_ls_kptr_user.c

-- 
2.34.1


