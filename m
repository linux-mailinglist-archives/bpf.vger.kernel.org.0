Return-Path: <bpf+bounces-71154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C434BE56B4
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 22:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDA6E4E6DE0
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2DC2E1C56;
	Thu, 16 Oct 2025 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB+2AeCm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DCB2E06C9
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647506; cv=none; b=oo4T/wZUKUmm4vRxUls/YA6je3qdEeD8H8fYZrEqyO/vxIamBb04K8XLITrys1XbgsjuV7rTg/PdlHu9Mmx1+fmvASfh4jGBvRFJcmi70dsb2DOjK0iGfIA9h8mKyGxa3fa41ry+mgpGSy3wt+no9I++4vRXkMcuEXg6rW/Fer4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647506; c=relaxed/simple;
	bh=YZbFch1Fg3wADFsySvJs06rplnR8Y1Hyuuv59z6KYYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=biSN1Q8rc3YlBxWL34QWDx7+9TazELcyi4MX+4kSJ47sasr9USFieQldbQEbuZ/jG1VVdgscNXdO7TFNDUfi2VkBaJ2hxZwc9NBM7l0UhJiRiVufawJ3wd5EqWYUEl0r2Ef8Xh8EZqjeSaaVJHL+TDK+BehYZFetGeJKD8iAPHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eB+2AeCm; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b632a6b9effso760974a12.1
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647504; x=1761252304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UN4YSvK7auwbDkZ/GDcaHxk9CVqMCKzoJhSTS4HKR2o=;
        b=eB+2AeCm4+t/wuoN078csyX87cFj5MlWNOlihP7bpWjpJRD0+ZsEOEEkZKR6PbngHo
         HzHtyHkfsuJ24sSBiRg27VDKagPWHztA3VCHAvHjFtf5J2LyOLJq2LdVu2/tF8WYpGII
         BwVPyL/kwLtMbM5I9z1bpJ98FTQirmG0MS9qVIfFurQbz+1NtCTm4Pe1bcAJagK4/0V6
         jgV4tkeTqUoYLh71p1qcKhG8aDX03YzUmrxzAaMo5dbAVVcdm01i6BuvI/my8eHkEEkO
         GArkVD/6HTADVt5zYVwyY9bsZn0tNglnqewBOBc1f+JBS6x6nalDCLeo3PTx4odDZWYM
         iHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647504; x=1761252304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UN4YSvK7auwbDkZ/GDcaHxk9CVqMCKzoJhSTS4HKR2o=;
        b=SHDsl2vwjXMhXnEIZMaN7SGwpZER5bvsb2uHYzurhFrMcZhYg5sKN1AJyR4ndJZjEg
         /JR4AWW2Kvm7dgDgJ5XnteEF6+8J+cBuMQJtJtHc0bunmWGPqjbmgE6j0AQZG7MqM/Br
         WQBoZxtSUtsrx0SHXzyLDGFEBt11N9PETytA2iDFg56GpYuCv0G25Uq70VqoomQUkR1c
         TPaZYdyLCbqn6XVHeQYrMl4yhAsNpAGoNXZgmFGI/irehYxFXWL0GI3VNtLQq+AMe9ce
         r4mJ7cFL7njD08MJHsgnhOUggaDU8MKtbLKGXOOGPNEr7N+JIqjxhVzzuILcRaz+RPB2
         mF0A==
X-Gm-Message-State: AOJu0YyzdxmyY3sSp18BrxdPDj6Y9NVfgszQMGdtizpBROSthFl5KcdT
	kErxKSNqsu2Joe5CTLrH0/cSHT24iGErHmUOufgPLPAtKMRQMF/MXMhkYFt7QA==
X-Gm-Gg: ASbGncuc5FqD6rAz/iY6sCQAi48xDqr8I+4ETzAx+GHR7N5hCTmfrb8DySK5KcAUoHj
	OKvU7TkOLwqgNd3EPdQsmHG81i+goowx/zIUzPvruj34imx4qL/gEuTHQpAI0+tlVlOZkh6aVgG
	MKu/wbyqQZLXffRQRNU4GvVyAz3Q59zxAEsdYncA1s2GYfxoelyHr+rkfvbpAEwRcIvTLD6hdbZ
	8AEMx2DfFkbBKl5+3xJt6hZkvMIcJBGVXlQDcXgU3d8rgToSj0YrHssUMGeI25/CvUeXpXDe3qy
	wmeOahsWzebBPHhr+4zuUMXZTM4EA4iIpGPTZ1wKmMbvNKhpMNd/Z2KhzCsQTCbjk4SwG2nCLQJ
	PWnOkBZ6NW6muVZRexBW6kq91XAZTTNeBGWy1ZTD2pXSphb/U2nDFIIyhLL58IXgGP4g9M+V/iv
	M+Qg==
X-Google-Smtp-Source: AGHT+IEXsoiBFUx5fkNDPmvc2+SwEvxs8Vew7SxFhkpc1CNeRTFZHXhqFAttPmQfDOzqlAWPzkKJCg==
X-Received: by 2002:a17:903:2411:b0:26c:e270:6dad with SMTP id d9443c01a7336-290ccadb0bcmr11429005ad.60.1760647503953;
        Thu, 16 Oct 2025 13:45:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930d1c0sm40296665ad.4.2025.10.16.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:45:03 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 0/4] Support associating BPF programs with struct_ops
Date: Thu, 16 Oct 2025 13:44:59 -0700
Message-ID: <20251016204503.3203690-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 -> v2
   - Poison st_ops_assoc when reusing the program in more than one
     struct_ops maps and add a helper to access the pointer (Andrii)
   - Minor style and naming changes (Andrii)

---

Hi,

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

---

Amery Hung (4):
  bpf: Allow verifier to fixup kernel module kfuncs
  bpf: Support associating BPF program with struct_ops
  libbpf: Add bpf_prog_assoc_struct_ops() API
  selftests/bpf: Test BPF_PROG_ASSOC_STRUCT_OPS command

 include/linux/bpf.h                           |  16 +++
 include/uapi/linux/bpf.h                      |  17 +++
 kernel/bpf/bpf_struct_ops.c                   |  44 ++++++++
 kernel/bpf/core.c                             |   6 +
 kernel/bpf/syscall.c                          |  50 +++++++++
 kernel/bpf/verifier.c                         |   3 +-
 tools/include/uapi/linux/bpf.h                |  17 +++
 tools/lib/bpf/bpf.c                           |  19 ++++
 tools/lib/bpf/bpf.h                           |  20 ++++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../bpf/prog_tests/test_struct_ops_assoc.c    |  76 +++++++++++++
 .../selftests/bpf/progs/struct_ops_assoc.c    | 105 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  17 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
 14 files changed, 390 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.c

-- 
2.47.3


