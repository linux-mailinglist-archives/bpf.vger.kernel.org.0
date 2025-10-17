Return-Path: <bpf+bounces-71257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F2FBEBDC7
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 23:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D0C420A71
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 21:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA05D2E6CA8;
	Fri, 17 Oct 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQwf/HkJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25712D5A16
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738191; cv=none; b=P7OnmK2A+HzOsZNBAGG7I8o2qrQ45wXD5Iek7zkSSMusvKCotp9PmP6O0CHJ1ji3hTvlL1hjuHEgkT26GZcXzEPGO5mI6tppqDCyL9dPw591sW9xgGiKAMeBOSUpYuEaTpck439LaxjpiEnPLCEC6OL86pnb7wVUDqT4pnTV+hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738191; c=relaxed/simple;
	bh=CwdBOHbnfQp54yp83Iesr/EkQSpVDG5TMVeKPc6Kg4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mJgOgoGIJIWDPgj3Y8anrNYzlkmvdM41IxPLeMZga2/y+CmEySKFrNO4476zAgGVRVrkWoxYx1MIk6QIfiVDsq4rKKQNVlCYwSIzr5h7vRiJZ67QnvXSMekPYWh3tN1gpMyraF3x4xX+oIdrJ3DUJ2vC9u0QPSBOEYnfp0oeKAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQwf/HkJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f67ba775aso3319003b3a.3
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 14:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760738189; x=1761342989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4XzmmP5uMUtzltCj1EVDEYlv3Qmwi6jWCsmvSAFdsc=;
        b=CQwf/HkJsl87FmH6InbPp0FjE6+tsFDoKoFMcIwDdHYHdGZ6cia3Q7WfYvqsYofN7n
         GEu97JZJ6ETmwHx0jGnUKS8+RN1e7Rtiyef3CMVwpEaNjkdF4EUEdjhq301mA7GMx46Q
         Il4z9XaV8AbQ7Ul2mawGhcQwhXKyFLdKtFyAwjG03MS++hKcu/N7NxJyNxsgigCe/htn
         qjdaz3xxwl9TVpZmG6QYjwI5xXw1DxqClrPQXdS+CwrpO+B9+K5SIMN4mQP/RX2ixwei
         GFrP12uRZLgdrFK0Kna4L1Z6Vkmllkzh+9dFSiOm9FN9z7tBxRupaUNbWSC6Es+Zqn9d
         vv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760738189; x=1761342989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4XzmmP5uMUtzltCj1EVDEYlv3Qmwi6jWCsmvSAFdsc=;
        b=aXJgZxaJsTv2RY9DrUE0xvE+T59AHxNy/GIdaccgA3GSpyzXGw9igrI2W3NE3Ok3lv
         YWYx+xHTuJlqFQ98bCImE2YBz7/0bqrAos1ViUa4V+deFWz0wvVksMcF9qjryGngdPc+
         oIvtRyg/+H7Ci9KGc6zCqD1Wxn39ViPDZyupfcVs/16BRsQ6Arh5awQIks9NlLAodKhl
         /rqtidVDoOmu6gJidzo1q+wW31/JoSRUDSDQ6tQiHwPydAi3HUgHnqoJ/QoaMSfMguwR
         HIwfCZTqJhSbcmpmq4Wvivlhpqld6b25T6Y1RfGUym0IKIJJH7GPfhHw2LmIdFragx1C
         6A+w==
X-Gm-Message-State: AOJu0YxJPXdiDdY7kgyQVNQ1/qnTleCbXoEI7eWUbz+lE3KCoHjasECi
	i2Yi3IUdOGHbkbKhn0hNUmZJf8w1Q0D51vauXB8HXkXzr4Iwl8y6/1lL44hcyg==
X-Gm-Gg: ASbGncs+A1SKk0onEIPecRiTJVSwT/67hP3kbJYq+KpU3iczkjxa+BNgfpoGslaTuDM
	NmbhO4QvZqkDiWofb/FPiRTixGtZVAcIlpF6aB0hDTH13AvIUnxyYQpeXXPkzmBD/R3vezHEQdn
	+Tuts0MMgvAmieDyUhUMRlCqdvi1l+qxZ3IPO5pmABU9w62Varn2ed+qr/6WtbYMF5COrM4Ap27
	t+N3CwOT2Sx/0NuQ/+dN2aTxN5Igi1BmeJlDgymKUg1HnNDmkGYQtpG7Wy5XPYuh/xPrk/QvnaE
	xj4UHnUHxJ8LAXHQYC1e0D2JMYskvFq0kQYk75y+ZG/nJChOnYyHp+NmsL6iEPmJnBtfVeoQzHu
	L5eGiHY+ULCekXIDwbHmt8/6jOwsXsl5h2Vtl5gSVEmJTM8fOLqqRd7u23boFxUqX9pg=
X-Google-Smtp-Source: AGHT+IE4NZqMADAnyuoGjyQj6J3b9zaUy12Wyelj+CeVqumNvPm9sY9/PIZU+Yw7ddHh3ds6GjADJQ==
X-Received: by 2002:a05:6a20:7351:b0:334:a72c:806a with SMTP id adf61e73a8af0-334a8616f0bmr7112232637.34.1760738188907;
        Fri, 17 Oct 2025 14:56:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673e8asm759559a12.11.2025.10.17.14.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 14:56:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/4] Support associating BPF programs with struct_ops
Date: Fri, 17 Oct 2025 14:56:23 -0700
Message-ID: <20251017215627.722338-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Amery Hung (4):
  bpf: Allow verifier to fixup kernel module kfuncs
  bpf: Support associating BPF program with struct_ops
  libbpf: Add support for associating BPF program with struct_ops
  selftests/bpf: Test BPF_PROG_ASSOC_STRUCT_OPS command

 include/linux/bpf.h                           |  16 +++
 include/uapi/linux/bpf.h                      |  17 +++
 kernel/bpf/bpf_struct_ops.c                   |  70 ++++++++++++
 kernel/bpf/core.c                             |   3 +
 kernel/bpf/syscall.c                          |  46 ++++++++
 kernel/bpf/verifier.c                         |   3 +-
 tools/include/uapi/linux/bpf.h                |  17 +++
 tools/lib/bpf/bpf.c                           |  19 ++++
 tools/lib/bpf/bpf.h                           |  21 ++++
 tools/lib/bpf/libbpf.c                        |  30 +++++
 tools/lib/bpf/libbpf.h                        |  16 +++
 tools/lib/bpf/libbpf.map                      |   2 +
 .../bpf/prog_tests/test_struct_ops_assoc.c    |  72 ++++++++++++
 .../selftests/bpf/progs/struct_ops_assoc.c    | 105 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  17 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
 16 files changed, 453 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.c

-- 
2.47.3


