Return-Path: <bpf+bounces-70763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBADBCE276
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 19:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C5719A3240
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595FE2EDD76;
	Fri, 10 Oct 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGxNgNJc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A026C3BE
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118597; cv=none; b=XrMBYlTTupLkZ8W7Xr6/kM63OEaFTpw43kZOe1av1dnHUOh0QbTZJPX9akkJGBPnZq7EmNJsRlZlY35+5Fb0xCQLSFUadJxwyXAtq80uqhpCBakaGciluzGgUP8r/P++R4kVtXfohruODManJ1UwfBCV8Pvodm641FOiNHab6Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118597; c=relaxed/simple;
	bh=eBp2ssxwsF1pZwgDQ9cLPLnXL+8ZI1Iu0jA8ietJkBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KgQuk1lC9G0DlFoXWe8CU9mCZxfLOftJv5f3hH0UoHKZZV6mnlQBZ667GNro1kOb745WDWmHhpZQQouCJg2y3SJ5XpcBmbDad6l+2rqaHlqEUBjrrkKXt0OKFHHt+s/HAOCYp14Toft14LQ98YngUYt4tlSKCnknmyMiv+7ItuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGxNgNJc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-28a5b8b12a1so22594485ad.0
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760118594; x=1760723394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qMo5V/Vxbx71O095m+8nAL8clgVCoteS7dV1qcc7Luw=;
        b=SGxNgNJcJplIIzfrznChYfM06bte0NvJAnssx+olLyxWuCAUqkFCSafxS7ZrXDQK92
         gml3RKXPRwry091hfKUL7+xrO8gmXvOWTIJEo8ZClm7klXyZim1RhMPAbY674SL1ktxU
         elxBSiqLZqeH5ySbeqS8gC+aGJcfZWSePKjJTulnehfYWeTJdfu/4oona9A9kVJIxMzv
         TdfBa7vzZfn5l2VcWPvK0YNsrwARqYEP0CY8Q6+GLqIqQs9mB9FnTp4ErZqjHVAYyZq8
         umU5vS9WbnNb3Ct41v3EzG97cks/HkWLI4HCGX4d3bMmO8STofJTcYTOA7vCue8shUTu
         UjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118594; x=1760723394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMo5V/Vxbx71O095m+8nAL8clgVCoteS7dV1qcc7Luw=;
        b=rcbh9njAzUVs6gStFbgyHKrNAGjpjK74MFqTFRjWCqfbeAhTLyopnUKCyvU13nutYP
         Ed6uoUu324ZjlBj4buTjHFibpm7lb5dUyDo2vPe06g8tW/ETwc88MXlHrPUpe6D8B+d8
         2MsBNmlRPaiwC1RGSPlgBbhzpNiShIXHc6u/m4MN282Mdey545U4HwHqdqMnm6p8tZTP
         tF5CK6wogzFb7S56Zrq2/Cgld3QhxdxLn+F3SJdDsKHzn0cHDaFvL3/k54Qo65fcMI+z
         HIdN8pYx/fz5SiAeEnmP/hUUX+7WpwhTujdvh+QOtaXhKYREHsWB3FW8Ciu62mdCiSaO
         cbJg==
X-Gm-Message-State: AOJu0YzPe6WdIStTjkf4R0KzaMjSpsI4y2zesnOVkLtixt1VrcHtKs80
	Wavsi4QN2q7GcSVHLuPgPPm8Z2VHnVoHBLlN2mbY+na8VGWrgnVyjSiAf40iXg==
X-Gm-Gg: ASbGnctX8Rk5e7qupiDSjQ0V7Cs2Qxsyj0RXOQs1X1gq1IBOZUWEuSz+/jHDWQWyHjN
	62BMg7qidyICLJReUDDiCdjPqVIW8yf3Bs9v/734LVp82GA4iUNkzULBOpPcIqD755YeOBynNjp
	Yy+hJs7I9QWhwL1cMMaa+G9ogP6asw9yYFqmrxJ0rxISvkc0gTARPoCANbLD3mUJGdX/5AdXaY9
	8uFAP1xYDXaMDAfTZP0TGUBB0D2DB36opWLXAUF1VQWDSfHfpknAJgyeUy75795OJh1yzJW6oms
	4GWunIrQpUPHkbT3Ne7BgdK1eKQDt4LuA6FSXjALKzDMRU/CDVGgynGADNk1y5/FsLJ2trwfjFa
	M2suueo+L+c7lvLHFu2+Mi+NQZe5Fyl0Tx0kCHNFUsg==
X-Google-Smtp-Source: AGHT+IGsK2HfpVGy7KMPx41unTLhbLvJuGTfgRaNkTG6p/BSSP+IjJqbe7jRAMthiqnHS25/SgiOgQ==
X-Received: by 2002:a17:902:f64a:b0:277:9193:f2da with SMTP id d9443c01a7336-29027356c8emr164710415ad.5.1760118594125;
        Fri, 10 Oct 2025 10:49:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e4930esm62384125ad.54.2025.10.10.10.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:49:53 -0700 (PDT)
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
Subject: [RFC PATCH v1 bpf-next 0/4] Support associating BPF programs with struct_ops
Date: Fri, 10 Oct 2025 10:49:49 -0700
Message-ID: <20251010174953.2884682-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds a new BPF command BPF_STRUCT_OPS_ASSOCIATE_PROG to
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
struct (i.e., kdata). struct_ops kfuncs can then get the associated
struct_ops by adding a "__prog" argument. The value of the speical
argument will be fixed up by the verifier during verification.

The command conceptually associates the implementation of BPF programs
with struct_ops map, not the attachment. A program associated with the
map will take a refcount of it so that st_ops_assoc always points to a
valid struct_ops struct. However, the struct_ops can be in an
uninitialized or unattached state. The struct_ops implementer will be
responsible to maintain and check the state of the associated
struct_ops before accessing it.

We can also consider support associating struct_ops link with BPF
programs, which on one hand make struct_ops implementer's job easier,
but might complicate libbpf workflow and does not apply to legacy
struct_ops attachment.

[0] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/src/bpf/main.bpf.c#L557
[1] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/src/bpf/main.bpf.c#L754

Amery Hung (4):
  bpf: Allow verifier to fixup kernel module kfuncs
  bpf: Support associating BPF program with struct_ops
  libbpf: Add bpf_struct_ops_associate_prog() API
  selftests/bpf: Test BPF_STRUCT_OPS_ASSOCIATE_PROG command

 include/linux/bpf.h                           |  11 ++
 include/uapi/linux/bpf.h                      |  16 +++
 kernel/bpf/bpf_struct_ops.c                   |  32 ++++++
 kernel/bpf/core.c                             |   6 +
 kernel/bpf/syscall.c                          |  38 +++++++
 kernel/bpf/verifier.c                         |   3 +-
 tools/include/uapi/linux/bpf.h                |  16 +++
 tools/lib/bpf/bpf.c                           |  18 +++
 tools/lib/bpf/bpf.h                           |  19 ++++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../bpf/prog_tests/test_struct_ops_assoc.c    |  76 +++++++++++++
 .../selftests/bpf/progs/struct_ops_assoc.c    | 105 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  17 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
 14 files changed, 357 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.c

-- 
2.47.3


