Return-Path: <bpf+bounces-73466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1822C3254D
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 18:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674EF3A7A03
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E6533971D;
	Tue,  4 Nov 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zax35KqU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286BD2E2DC1
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277218; cv=none; b=hMMRwaSyFvmvqvoIrqcJXzsr9FonhzvKS+v+WKq1ZhCNP5lKqd1lekZfcyOxpk7sQo/DULBi9b/7pk+sOOAtoq6ktWHTmgih0IoUOYycw+aWQZcNENP5Jo1N3Y/J+FRNVHzx036vU0Jm6fFdO7ov8QWW17soIJ3wHT2cM1md5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277218; c=relaxed/simple;
	bh=Wevo2Y4OmrLXFTmuAJOHd+4d+3TkpCLlFEfPIh3FzEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pcw56H0keQRr0f7KEBV9kYbTZdgan6iSCumaNUs9cY6beFBe7g598/9NT8shfVvWpglfn+TkWx8g+2BTEN5Eueiujf3mVLk291zjyGQQM3sVdcgrVKjLLoFVRXMPbfSLzBM5p6RgeATu7h5/4uZRu7L2gmazOW/QvgYUmSvnSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zax35KqU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso5583876a91.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 09:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762277216; x=1762882016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSh4mlRZT0Y24WMccxIDboDo6bfkByxubsl31YznsC4=;
        b=Zax35KqUsSCTmAmObdHYRkgYSP9cY6kqOEb7JSdAV7XHi6GITegAyLr1cSSbt2SfFG
         rHBwWXhWBTwhfOs6DZRr10ZOldPXQffeQT4VGeRASWhxjxFNGIKf5jOvUGIOgVuzibgg
         pTUhEtSoxE3hVLKGJGXY/965Z7b5+/9SA8yk09g726v/srpD11ifot9MkKO2ybRvuPRi
         u7c8OvqmJW4oba2dRAYI13Kh5juI8ajPlJxc4px55vMem96CP4vd8Lpp944GEhHkX11l
         MFrZLOCy7/IN1xMxDQWGqTc1WHIk5uCW6n/uVCv2VjdKVoivhdWFyVqVh5iSdjjAhvxk
         mZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277216; x=1762882016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSh4mlRZT0Y24WMccxIDboDo6bfkByxubsl31YznsC4=;
        b=H097jDYW4BVSVtRZXIfniasgslnxSjFinGwUBT/VoLufkOqa1VFCp7OSZCarGaDGkK
         HpGD6AI+dvsfAtl6iSqYzxDy2rGZtmjHi6rwnoFokUBh5Q/mQpbaDESQuf5KCRyf/J0n
         Rxh10QL/72NLccP2cAkUmOcK3D2FahxYyAouPEwIjtMiW04yKuPaTpir1NIoXkJGWGgL
         Z2iWwF+wVZFK2K1IKvdfcnTp/jugga/bMQ635Ikmv27POqOKOWPhA9IhNXo/SMfRNO6H
         tGNbswVcn3qUuDSJgBPGyBVOrg4PpTH+L1m69iuDuERzl30VKA4JisSNSgLn/AwJHiee
         GLLA==
X-Gm-Message-State: AOJu0YwVPH5Hw5nj7fPrtyDcM7qtEmn4xgttG0rgCux8WqeL7XA2ts96
	Cp3r0iKeK6kFwcZbt5qqq2MBn0u5XXVFeI3DCubhBO43f+mYvZjzYg/8dGIyAA==
X-Gm-Gg: ASbGncucuIWvSTtZrGznX5lsM+Hdq0laBJ4NqcF+EL1T6g7/zeaw1neO4KEA4n7/MQX
	sh6vNoVKo8a3Ysz0My9YWU9/FQTd8+Awqc4aBNdRG718z8qQxo+AaAYVemNIvgakR8+uDtG+64f
	+7FPe4t7sI481qvHXYP9X76y4RS0krLcvZPTmsDKV3LcArUH/37i6KvPm2pCtiuhckY9a+BGrYe
	HvPnfmuoO+wpPiJcRPhbdMJKvr0oFEtDzBJ3NtA6C4XrTYhqVVtqt0ztSbomRnS0t5QhcdGJeYt
	cG6uBfk8RF6hoG33uiyMQ8nNcdX8QyVPO6GsLM/ITawJVeJFiQjmljJFtFG7TneVzCxEViuRq4B
	conGcp/XODYVDm462LdMfl+OHAG0E8PcbbNC6xP+mT+cRWF4MuTq0kLexyq3lZwmE7zA=
X-Google-Smtp-Source: AGHT+IFw2guSVLHKtwMI2ykXFRrbGXDUlz5eJAzpQePpdyOsYuNehk5p+cRdkY2/ZbSoIywZBVXbbA==
X-Received: by 2002:a17:903:1ce:b0:292:dca8:c140 with SMTP id d9443c01a7336-2962adb9205mr5441665ad.44.1762277215727;
        Tue, 04 Nov 2025 09:26:55 -0800 (PST)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a3a80esm33281995ad.73.2025.11.04.09.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:26:55 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 0/7] Support associating BPF programs with struct_ops
Date: Tue,  4 Nov 2025 09:26:45 -0800
Message-ID: <20251104172652.1746988-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4 -> v5
   - Simplify the API for getting associated struct_ops and dont't
     expose struct_ops map lifecycle management (Andrii, Alexei)
   Link: https://lore.kernel.org/bpf/20251024212914.1474337-1-ameryhung@gmail.com/

v3 -> v4
   - Fix potential dangling pointer in timer callback. Protect
     st_ops_assoc with RCU. The get helper now needs to be paired with
     bpf_struct_ops_put()
   - The command should only increase refcount once for a program
     (Andrii)
   - Test a struct_ops program reused in two struct_ops maps
   - Test getting associated struct_ops in timer callback
   Link: https://lore.kernel.org/bpf/20251017215627.722338-1-ameryhung@gmail.com/

v2 -> v3
   - Change the type of st_ops_assoc from void* (i.e., kdata) to bpf_map
     (Andrii)
   - Fix a bug that clears BPF_PTR_POISON when a struct_ops map is freed
     (Andrii)
   - Return NULL if the map is not fully initialized (Martin)
   - Move struct_ops map refcount inc/dec into internal helpers (Martin)
   - Add libbpf API, bpf_program__assoc_struct_ops (Andrii)
   Link: https://lore.kernel.org/bpf/20251016204503.3203690-1-ameryhung@gmail.com/

v1 -> v2
   - Poison st_ops_assoc when reusing the program in more than one
     struct_ops maps and add a helper to access the pointer (Andrii)
   - Minor style and naming changes (Andrii)
   Link: https://lore.kernel.org/bpf/20251010174953.2884682-1-ameryhung@gmail.com/

---

Hi,

This patchset adds a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to
the bpf() syscall to allow associating a BPF program with a struct_ops.
The command is introduced to address a emerging need from struct_ops
users. As the number of subsystems adopting struct_ops grows, more
users are building their struct_ops-based solution with some help from
other BPF programs. For exmample, scx_layer uses a syscall program as
a user space trigger to refresh layers [0]. It also uses tracing program
to infer whether a task is using GPU and needs to be prioritized [1]. In
these use cases, when there are multiple struct_ops instances, the
struct_ops kfuncs called from different BPF programs, whether struct_ops
or not needs to be able to refer to a specific one, which currently is
not possible.

The new BPF command will allow users to explicitly associate a BPF
program with a struct_ops map. The libbpf wrapper can be called after
loading programs and before attaching programs and struct_ops.

Internally, it will set prog->aux->st_ops_assoc to the struct_ops
map. struct_ops kfuncs can then get the associated struct_ops struct
by calling bpf_prog_get_assoc_struct_ops() with prog->aux, which can
be acquired from a "__prog" argument. The value of the speical
argument will be fixed up by the verifier during verification.

The command conceptually associates the implementation of BPF programs
with struct_ops map, not the attachment. A program associated with the
map will take a refcount of it so that st_ops_assoc always points to a
valid struct_ops struct. struct_ops implementers can use the helper,
bpf_prog_get_assoc_struct_ops to get the pointer. The returned
struct_ops if not NULL is guaranteed to be valid and initialized.
However, it is not guarantted that the struct_ops is attached. The
struct_ops implementer still need to take stepis to track and check the
state of the struct_ops in kdata, if the use case demand the struct_ops
to be attached.

We can also consider support associating struct_ops link with BPF
programs, which on one hand make struct_ops implementer's job easier,
but might complicate libbpf workflow and does not apply to legacy
struct_ops attachment.

[0] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/src/bpf/main.bpf.c#L557
[1] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/src/bpf/main.bpf.c#L754

---

Amery Hung (7):
  bpf: Allow verifier to fixup kernel module kfuncs
  bpf: Support associating BPF program with struct_ops
  bpf: Pin associated struct_ops when registering async callback
  libbpf: Add support for associating BPF program with struct_ops
  selftests/bpf: Test BPF_PROG_ASSOC_STRUCT_OPS command
  selftests/bpf: Test ambiguous associated struct_ops
  selftests/bpf: Test getting associated struct_ops in timer callback

 include/linux/bpf.h                           |  16 ++
 include/uapi/linux/bpf.h                      |  17 ++
 kernel/bpf/bpf_struct_ops.c                   |  90 ++++++++
 kernel/bpf/core.c                             |   3 +
 kernel/bpf/helpers.c                          | 105 +++++++---
 kernel/bpf/syscall.c                          |  46 +++++
 kernel/bpf/verifier.c                         |   3 +-
 tools/include/uapi/linux/bpf.h                |  17 ++
 tools/lib/bpf/bpf.c                           |  19 ++
 tools/lib/bpf/bpf.h                           |  21 ++
 tools/lib/bpf/libbpf.c                        |  30 +++
 tools/lib/bpf/libbpf.h                        |  16 ++
 tools/lib/bpf/libbpf.map                      |   2 +
 .../bpf/prog_tests/test_struct_ops_assoc.c    | 194 ++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_assoc.c    | 105 ++++++++++
 .../bpf/progs/struct_ops_assoc_in_timer.c     |  77 +++++++
 .../bpf/progs/struct_ops_assoc_reuse.c        |  75 +++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  17 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
 19 files changed, 819 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c

-- 
2.47.3


