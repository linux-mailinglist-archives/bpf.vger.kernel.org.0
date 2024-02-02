Return-Path: <bpf+bounces-21065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF3E8474DB
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B3F1C23885
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 16:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1AD1487DF;
	Fri,  2 Feb 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="BaImCMZb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4321482E6
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891661; cv=none; b=n0qb494tBaoQHkgrMBlIqnvxkW497vY5VzKFIGNf/xv5UATlaBKsQ4wZIOqbC0tF/JsjSs1USY0DUuQu2VlvCKgavPDN5rvIlgFxwqqrm/e4hH/u0b1IGi1KXJlOwH3/JNtnad2VHjN4HptR8BYUz0xYx8ImLtFKfLp2SDYve1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891661; c=relaxed/simple;
	bh=7+em6DoYmRGuiKAXLxyc0UcnJzl5hs+CzUrGjrA4QGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KkxRUteZhPazXCNOulZ+ySApKaFRMP1krYRcw8jpvN+WdYKGhjkyLjT4St3oDeQkbxH3xYc+A8UWWpgKJLTXdzALZ2JAUU3kkmLRKh9ADYNvHuvY/CcQT1nLzPZMosxVoI8AQOal7XvDGC6aPbqAWqYjlZAIcfXFEgVXOy/Ks4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=BaImCMZb; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d090c83d45so2987501fa.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1706891654; x=1707496454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kZdHVL6JgM9a9altZEM3N4KaO3gljSI5+G+8uoFPE9g=;
        b=BaImCMZbAGlrYpxTmyu71uaQ6zKZyTa2xQtUUEWgJBfdW1jbFYgiq7QzgwlRe7ncj8
         xYfREt5CfvD40FS45pKjmDXnCGobq1GscZ3Q++49rGJaEspjRfar8VdK3ujWibSF0vg7
         JAqdF8w8VzIs0ChZqEKInTGHRv0a0vB+YBH0xJyl8iZf+zBFUbcJ4ksYolV2hooe5MMf
         rs+KhvzdJ3Q9w+gtwkxFRbMzg1QZkcHNW4rI4ZhQIQJ91Tb0oJkDZHKAB2xlq30UKnVT
         Dspj3zriMUFExUzQnl+sSSISVGpTyfiRtAzyoMLh5psAYFJX3WDFNu9crHuYoK4Zk5wo
         znhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891654; x=1707496454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZdHVL6JgM9a9altZEM3N4KaO3gljSI5+G+8uoFPE9g=;
        b=JAc4+86olOAcd00SdvDy0uhSWFfYGzb+bSzlYB7J9H3/mInhmzX6hE9SDMqsukI+20
         t3tu69q8eZxgvfXTLQTBqBMvxjTBa7yLpehqqxekZ/iJfOjflhrVyNf1o829ar6tzlYP
         4duEQPeR12uUjbcLRk3si4QnyUZ2yEV1OWVWunT8EqARTp7rfBUvRgvN5e980XndPcBx
         y/qM/wCu8xL6vHB97Qg8+lQRXCAuG4g7Sf0PZZ0uCoROeXLF0RAkpyo1ehfiIKOZxweE
         d7tPj++SeZPN215G8GABc2JdGmaKDCunOl+zyY7qATQvzllHYXucEB0VEaDv9Pa+FqEY
         ktRQ==
X-Gm-Message-State: AOJu0Yxr09IIY4YEY/eOed3e32G1/HaaYx9HMke1+4MD82n31vuVqzQm
	cfS9wuY/8MS/YHv1pdMzaO06ITFLMYqyMNKt3J6hwwK/Magig2fEWCGxtD5zjNk=
X-Google-Smtp-Source: AGHT+IFEryfPaRXucBCB5ihk6nqeSAQ3b1UKy/F577G04pHQxnytyIexTq/NtwnC7TKiWYxK9NhJtw==
X-Received: by 2002:a2e:7303:0:b0:2d0:5101:2bbb with SMTP id o3-20020a2e7303000000b002d051012bbbmr1335524ljc.23.1706891653711;
        Fri, 02 Feb 2024 08:34:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWkuJ3EXAAbXq9LODdeulbsbXfcm0fj8TVZv7nR090ERxikdzTilfDhTSCEfrY7y4BOh7SjRuiwaxRgoCg2tvQ5Kg/2aZpfeDeAE5pyMpqRWNUSlEzcb7zel3CKehzKVyjjZo+uV9HpwHfviMS5xTU4COdIjHvAhbB5+HE9JhF2mGaiLslkMhE1BrW1XlRiokdapqY6iOCt2qTnEdMrNbA5g4/Y6Q28E7XzvSc3lOaI/fURdOl/NFKybYrGSvy6aM5xvEPNQiMEcFZ1cLDmzv3tvSvfeTmSKNgNALwlZUhgFQsYPC53Sn0=
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id l19-20020aa7c313000000b0055edbe94b34sm952544edq.54.2024.02.02.08.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:13 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v1 bpf-next 0/9] BPF static branches
Date: Fri,  2 Feb 2024 16:28:04 +0000
Message-Id: <20240202162813.4184616-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for mapping between xlated and original
instructions offsets, mapping between xlated and jitted instructions
offsets (x86), support for two new BPF instruction JA[SRC=1]
(goto[l]_or_nop) and JA[SRC=3] (nop_or_goto[l]), and a new syscall to
configure the jitted values of such instructions.

This a follow up to the previous attempt to add static keys support
(see [1], [2]) which implements lower-level functionality than what
was proposed before.

The first patch .
The second patch adds xlated -> original mapping.
The third patch adds .

The fourth patch adds support for new instructions.
And the fifth patch adds support for new syscall.

The following patches are included:
  Patch 1 is a formal bug fix
  Patch 2 adds the xlated -> original mapping
  Patch 3 adds the xlated -> jitted mapping
  Patch 4 adds tests for instructions mappings
  Patch 5 adds bpftool support for printing new instructions
  Patch 6 add support for an extended JA instruction
  Patch 7 add support for kernel/bpftool to display new instructions
  Patch 8 adds a new BPF_STATIC_BRANCH_UPDATE syscall
  Patch 9 adds tests for the new ja* instructions and the new syscall

Altogether this provides enough functionality to dynamically patch
programs and support simple static keys.

rfc -> v1:
- converted to v1 based on the feedback (there was none)
- bpftool support was added to dump new instructions
- self-tests were added
- minor fixes & checkpatch warnings

  [1] https://lpc.events/event/17/contributions/1608/attachments/1278/2578/bpf-static-keys.pdf
  [2] https://lore.kernel.org/bpf/20231206141030.1478753-1-aspsk@isovalent.com/
  [3] https://github.com/llvm/llvm-project/pull/75110

Anton Protopopov (9):
  bpf: fix potential error return
  bpf: keep track of and expose xlated insn offsets
  bpf: expose how xlated insns map to jitted insns
  selftests/bpf: Add tests for instructions mappings
  bpftool: dump new fields of bpf prog info
  bpf: add support for an extended JA instruction
  bpf: Add kernel/bpftool asm support for new instructions
  bpf: add BPF_STATIC_BRANCH_UPDATE syscall
  selftests/bpf: Add tests for new ja* instructions

 arch/x86/net/bpf_jit_comp.c                   |  73 ++++-
 include/linux/bpf.h                           |  11 +
 include/linux/bpf_verifier.h                  |   1 -
 include/linux/filter.h                        |   1 +
 include/uapi/linux/bpf.h                      |  26 ++
 kernel/bpf/core.c                             |  67 ++++-
 kernel/bpf/disasm.c                           |  33 ++-
 kernel/bpf/syscall.c                          | 115 ++++++++
 kernel/bpf/verifier.c                         |  58 +++-
 tools/bpf/bpftool/prog.c                      |  14 +
 tools/bpf/bpftool/xlated_dumper.c             |  18 ++
 tools/bpf/bpftool/xlated_dumper.h             |   2 +
 tools/include/uapi/linux/bpf.h                |  26 ++
 .../bpf/prog_tests/bpf_insns_mappings.c       | 156 ++++++++++
 .../bpf/prog_tests/bpf_static_branches.c      | 269 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_insns_mappings.c  | 155 ++++++++++
 16 files changed, 1002 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insns_mappings.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_static_branches.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_insns_mappings.c

-- 
2.34.1


