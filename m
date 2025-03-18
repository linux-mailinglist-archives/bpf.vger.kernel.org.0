Return-Path: <bpf+bounces-54310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5F6A67666
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608C34212EA
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9354F20E018;
	Tue, 18 Mar 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="OWibtz5E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEAF46426
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308190; cv=none; b=KsPOT5ii0HgFhp9KA/EOeK71Xp5cSM4ezNpf2EecdqZqTfi11BAqJp6/h2dsMqRDbbn4PpN4ilfzawjd0kLysYEhJbyJZUPfAJXV/K8hHsFqG8xc2gTtFuBYW0KIddhevZgda226wZccE1M9bjjlmomHqs1yqWaxy3vrW7KuRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308190; c=relaxed/simple;
	bh=1+4o1BkENLBhoR/QzHpAPOiO84dJVYUVjqLyBu08e4g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ITOrKgCAaEvKglT8T9kCE58wZ8lufEGOj6rlldMG1BBSUji62/OD2Hog/d60SjPeajblCWOAM72jZrYg/biMT+EavHhYkJ5GsrWrqhSshzsVvkVswVOe0b3CP+PzjEIv4R782AvsQoFk4ryVLYVUcn2EPKBID/SVZe4P9PGNFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=OWibtz5E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso32516125e9.0
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308186; x=1742912986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NeuCDfKxZWrVakjrdlM7kP2Iw0D00OmhRo50sqqzZjM=;
        b=OWibtz5EnPatzIFbaqIsB4nNJUghb2G1CBltsPXo6UQfuqmVOIzG7/BGutpPImv7h1
         GSQLv7boRfdBWkxpyzMID7CWA7s/h3P5e5Nyo1a5jF7ebctrS+J3pctI8Jnidlz07LQX
         aLFpwktLGbo5FBV8a19DNgV3XNmZDwsR0+jgWQtm2d9cjeX2oakzWW1QS5ObCb+zV6pT
         k1UtqQXCwNK0HJrfTo4LDTU+/0+I3B9EUTlBOeILUGYcmYZAj3XxXGiUcJIQcrtHZFxc
         YdGfwGkhJ5qd3yOqUPq86UkqAy16Kul0vfUaxC1+IDd54mdLzkonU4YyORgIVW0+k3Je
         cMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308186; x=1742912986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeuCDfKxZWrVakjrdlM7kP2Iw0D00OmhRo50sqqzZjM=;
        b=IoaOx7y2HQmel60VizjrgEzzA3u3HuZOLwoGIN+tCNDv41Xc2GRX85CalotNPj8MMf
         5cdTSamAc20jgx6S21BxekCRo48O0xMkNd5l3N6OOXa4Q/sUT0la5QOR06uViOtXKhE4
         dzJoDMGuED9seaQHZbt4Y+6o9iE2UYi3Tg2KMCq9FiH6NfAfL1Lxi2oQn5J/teqecSZG
         CzSy4HVJT3hNoG04qJiG/X8F9eI70vLGnhyiU9OpVSOGMt2u6ik550tuDlRhs2HDCfHO
         U0dWn7yZ87tdiXRlDJ62RCJ6X8OPEPGQYuv3VLT0vDL5XMl6HuQ9McFjx5reWw2To+0h
         g5TA==
X-Gm-Message-State: AOJu0Yzmm/7co9pnLyWTEY7tWOLEI+ayhvtVRNS6CfboiS2HQYmK13r7
	fOyWVyqUo+aJbdl41WGSQp+F1sRfZPSdWVKH3fRivJ/c86r0q6rXxonkVKRhq6RA7iH71BJicto
	y
X-Gm-Gg: ASbGncvEsdJMCZwuv+9XDBJ5XSK+pR9+MkU2NBGTYTvO+a9YbVuLOHkLN7M4fM+42hL
	8kSVUMTe2QmFYWR0kKhGw8fUqiBI6JAhpZgIh2RcEZ/hXHghQRd7L3KdqacrrX8Op7ua+wyIIIZ
	QXDrf5ycAfUD/koy8FqiRWTV8c56/+7r5lfiln27JQvcQG+CjL/Ll/cq0InKP+858NkPsbFvsAh
	4GMq3xiS1v8uCsbbA4Q/6UrYPkJ6I5X0d+ce57tOtRQ8TpnquF6/sx8tv1Uyc6bHQVI3FV4U+Aq
	7LXAOqJutzIDySM3GF7IoX/I858btV246x1l2yzVVU1T8lMsCCqkdHEKUNC4pGV3mWBn
X-Google-Smtp-Source: AGHT+IGSaYZQGsHu+uaxD7EqD1eCDdURJl/Teqp95I+Rql2XJ10xPjUUoMH+9bm9BG2kFbP1tG7AqQ==
X-Received: by 2002:a5d:47c5:0:b0:390:ee01:68fa with SMTP id ffacd0b85a97d-3971daebb31mr16784225f8f.24.1742308186152;
        Tue, 18 Mar 2025 07:29:46 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:45 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 00/14] instruction sets and static keys
Date: Tue, 18 Mar 2025 14:33:04 +0000
Message-Id: <20250318143318.656785-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset implements new type of map, instruction set, and uses
it to build support for BPF static keys. The same map will be later
used to provide support for indirect jumps and indirect calls. See
[1], [2] for more context.

Short table of contents:

  * patches 1, 9, 10, 11 are simple fixes (which can be sent
    independently, if acked)

  * patches 2, 3 add a new map type, BPF_MAP_TYPE_INSN_SET, and
    corresponding selftests. This map is used to track how original
    instructions were relocated into 'xlated' during the verification

  * patches 4, 5, 6, 7, 8 add support for static keys (kernel only)
    using (an extension) to that new map type. Only x86 support is
    added in this RFC

  * patches 12, 13, 14 add libbpf-side support for static keys and
    selftests

It is RFC for a few reasons:

1) The kernel side of the static keys looks clear, however, the
libbpf side is not _that_ clear. I thought that this is better to
commit to a particular userspace design, as any particular design
requires a lot of changes on the libbpf side. See patch 12 for
the details

2) The libbpf part of the series requires a patched LLVM (see [3]),
which adds support for gotol_or_nop/nop_or_gotol instructions, so
selftests would not compile in CI.

3) Patch 4 adds support for a new BPF instruction. It looks
reasonable to use an extended BPF_JMP|BPF_JA instruction, and not
may_goto. Reasons: a follow up will add support for
BPF_JMP|BPF_JA|BPF_X (indirect jumps), which also utilizes INSN_SET maps (see [2]).
Then another follow up will add support CALL|BPF_X, for which there's
no corresponding magic instruction (to be discussed at the following
LSF/MM/BPF).

Besides these reasons, there are some questions / known bugs,
which will be fixed once the general plan is confirmed:

  * bpf_jit_blind_constants will patch code, which is ignored in this
    RFC series. The solution would be either moving tracking
    instruction sets to bpf_prog from the verifier environment,
    or moving bpf_jit_blind_constants upper the stack (right now,
    this is the first thing which every jit does, so maybe it can
    be actually executed from the verifier, and provide env context)

  * gen-loader not supported, fd_array usage in libbpf should be
    re-designed (see patch 12 for more details)

  * insn_off -> insn_set map mapping should be optimized (now it is
    brute force)

Links:
  1. http://oldvger.kernel.org/bpfconf2024_material/bpf_static_keys.pdf
  2. https://lpc.events/event/18/contributions/1941/
  3. https://github.com/aspsk/llvm-project/tree/static-keys

Anton Protopopov (14):
  bpf: fix a comment describing bpf_attr
  bpf: add new map type: instructions set
  selftests/bpf: add selftests for new insn_set map
  bpf: add support for an extended JA instruction
  bpf: Add kernel/bpftool asm support for new instructions
  bpf: add BPF_STATIC_KEY_UPDATE syscall
  bpf: save the start of functions in bpf_prog_aux
  bpf, x86: implement static key support
  selftests/bpf: add guard macros around likely/unlikely
  libbpf: add likely/unlikely macros
  selftests/bpf: remove likely/unlikely definitions
  libbpf: BPF Static Keys support
  libbpf: Add bpf_static_key_update() API
  selftests/bpf: Add tests for BPF static calls

 arch/x86/net/bpf_jit_comp.c                   |  65 +-
 include/linux/bpf.h                           |  28 +
 include/linux/bpf_types.h                     |   1 +
 include/linux/bpf_verifier.h                  |   2 +
 include/uapi/linux/bpf.h                      |  40 +-
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bpf_insn_set.c                     | 400 +++++++++++
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/disasm.c                           |  33 +-
 kernel/bpf/syscall.c                          |  28 +
 kernel/bpf/verifier.c                         |  94 ++-
 tools/include/uapi/linux/bpf.h                |  40 +-
 tools/lib/bpf/bpf.c                           |  17 +
 tools/lib/bpf/bpf.h                           |  19 +
 tools/lib/bpf/bpf_helpers.h                   |  63 ++
 tools/lib/bpf/libbpf.c                        | 362 +++++++++-
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_internal.h               |   3 +
 tools/lib/bpf/linker.c                        |   6 +-
 .../selftests/bpf/bpf_arena_spin_lock.h       |   3 -
 .../selftests/bpf/prog_tests/bpf_insn_set.c   | 639 ++++++++++++++++++
 .../bpf/prog_tests/bpf_static_keys.c          | 359 ++++++++++
 .../selftests/bpf/progs/bpf_static_keys.c     | 131 ++++
 tools/testing/selftests/bpf/progs/iters.c     |   2 -
 24 files changed, 2315 insertions(+), 28 deletions(-)
 create mode 100644 kernel/bpf/bpf_insn_set.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_static_keys.c

-- 
2.34.1


