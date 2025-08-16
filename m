Return-Path: <bpf+bounces-65817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F581B28FF8
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 20:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEFCE7B4489
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98F11E5B88;
	Sat, 16 Aug 2025 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKJ5/0XL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B309433AD
	for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755367321; cv=none; b=O3t5ZRN+S2u3NPfO0wKkO6eorK5K7gUvn9WyWfrWmWqwhhOIN3vLJrvF6xZtWBFAVeJqyOv/KuDEbTOMqIUSK8fazlkVNhgImsjYphRIZmPYNmZbsVkZH3arXa53xSswzSZyWEEY57zAOmdwuPa7XB7vLO4UGedirMRbSbusCSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755367321; c=relaxed/simple;
	bh=b1EAvRU+MupRES4mgjcHLXzXg1wX/U8NYsRQf0hu43Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bsAIXt8mFvuLtUuCaJG3VUafdUzPgZ2mt2b3mgsBAT4XzpbuqJrOdZ99WGrNsQOhYL5do2RanfkpIJuKjJ5RoVAB0PiSRBu7mMVtnwZfkBybY69Y+2vUSFMAn077sOQdvpXAe1p8ItmDADeY1RXSnUTUdwo6Gmm+iUqmyNKmnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKJ5/0XL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b0d224dso13850575e9.3
        for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755367317; x=1755972117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gWfPRxcsjFMIfGqvWQfkZ95upO6LUL76PX1LU0qMFb4=;
        b=dKJ5/0XLq0WLk5brRZ66essdRJ2TxfKMiEJ7wCk7610AVBSQvC2Fuqw9HPb328Fdf5
         vov+GoA+E7vc+f6UObtTRAG629SHlRkTkswKWxKU2lY8zbSZA48BEHKkF0XyDSDqxsWj
         5icFtwfPrm1XZIf9ybWoA0bkDAfLdVQIRwLtsDlMFrEZaz0QzYr/z9Gakam57OcEfqBS
         i+hJfU62bFDDp6xLD5tXEbC3Vszvy1oKgbuuUL6q1U1Uqr1/6PnpRqfKR+xn2BLpTlhj
         nomix2xt5EZ9I78mWmUo+DOdf+TDtbkPoNOIDi3DxmsIzSz7gtPIa1ZBbOdoelBbivk2
         sEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755367317; x=1755972117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWfPRxcsjFMIfGqvWQfkZ95upO6LUL76PX1LU0qMFb4=;
        b=V9+AKYewcUfHLHSPzcPhYYvdJnRqDBb1X6ethveoQ6EgeX7UiOb038xta5U4gR+FKv
         BnjZ7RJVUW0JorWV7a1D8//usE8cPPCBNN5kpCd8haW1tHGMYQyzQk37ldr5p9Af0Q24
         Akf5hsASmqHsiWJkhQSMMy+LC9Egb7h3J9vjPr6kjJ5+wv9V9715sBaR0rL25HEEaYrA
         ELDXBkvbfq9cIZzR1shEXW5/zFqI0DxYz49d2OEDG/yvU+V7lDGSgRACyHXRBhs9MHpX
         ddOwcLN/p9fpFTgX/84URkoNsdS77fgvWMiwblG9lNS2L8RwU0kLlbJigJI+vkU2KNkx
         s1VQ==
X-Gm-Message-State: AOJu0YxNDjVUH0Pi6q/m/P9/cOpAEc8EJvopNHpEfEGxEhI6FzAL0t7f
	lrd7E5uCCMOR5B3GDT3UWM2CiXXZVdmjems0MwN2D2j5umbkHg0feCz05XNeOg==
X-Gm-Gg: ASbGncvm1b1FGQOvP9zcRSopxRRHC2SWuGJLOH5z206ata3OCG9co1CDqXsYJRP6pmb
	lKYnb8eN+hjPr1gPLCFdOGfdsntTMqNy+gvYSJZDy1qxCYP/Msdcz++Hg7A+LENFU1x859IBtrL
	pi8+X/jEvKxJTFPDnDx2sefWR0hYNQfreZ1rLcHsgKOmd1MfHIz5R3viGMNzhaZRBbpYcluM4xV
	NiPx7gcBkFF2ZCRMT+V1xmY47HCC0bj6wmlTHbZ98FAk7CF7zbpHKa1vma03vbMigjOgYSQvs0a
	Sl28+adTn0tRQFcZn8ZTj12dyse9ZrN2ZHsFfhXM5XkUvUEQK1NAmsxBqsZfMmkrLv4RJhhpTmD
	8MdJErcw93QSWWoBvfVjtyq4kWaCgwjHKRKJq/amtHVo=
X-Google-Smtp-Source: AGHT+IH5nfuwhhQY96rcRRE+mx3DUDRiqqkZKiU07yhslQDtVJkUW6qRkb9SO/Q4PesrI34PpKd8dw==
X-Received: by 2002:a05:600c:4fc5:b0:456:21d2:c6f7 with SMTP id 5b1f17b1804b1-45a21854d32mr39640785e9.23.1755367316928;
        Sat, 16 Aug 2025 11:01:56 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bd736b88besm1080193f8f.67.2025.08.16.11.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 11:01:56 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 00/11] BPF indirect jumps
Date: Sat, 16 Aug 2025 18:06:20 +0000
Message-Id: <20250816180631.952085-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset implements a new type of map, instruction set, and uses
it to build support for indirect branches in BPF (on x86). (The same
map will be later used to provide support for indirect calls and static
keys.) See [1], [2] for more context.

This patch set is a follow-up on the initial RFC [3], now converted to
normal version to trigger CI. Note that GCC and non-x86 archs are not
supposed to work.

Short table of contents:

  * Patches 1-6 implement the new map of type
    BPF_MAP_TYPE_INSN_SET and corresponding selftests. This map can
    be used to track the "original -> xlated -> jitted mapping" for
    a given program. Patches 5,6 add support for "blinded" variant.

  * Patches 7,8,9 implement the support for indirect jumps

  * Patches 10,11 add support for LLVM-compiled programs containing
    indirect jumps.

A special LLVM should be used for that, see [4] for the details and
some related discussions. Due to this fact, selftests for indirect
jumps which directly use `goto *rX` are commented out (such that
CI can run).

There is a list of TBDs (mostly, more selftests + some limitations
like maximal map size), however, all the selftests which compile 
to contain an indirect jump work with this patchset.

See individual patches for more details on implementation details.

Changes since RFC:

  * I've tried to address all the comments provided by Alexei and
    Eduard in RFC. Will try to list the most important of them below.

  * One big change: move from older LLVM version [5] to newer [4].
    Now LLVM generates jump tables as symbols in the new special
    section ".jumptables". Another part of this change is that
    libbpf now doesn't try to link map load and goto *rX, as
    1) this is absolutely not reliable 2) for some use cases this
    is impossible (namely, when more than one jump table can be used
    in the same gotox instruction).

  * Added insn_successors() support (Alexei, Eduard). This includes
    getting rid of the ugly bpf_insn_set_iter_xlated_offset()
    interface (Eduard).

  * Removed hack for the unreachable instruction, as new LLVM thank to
    Eduard doesn't generate it.

  * Set mem_size for direct map access properly instead of hacking.
    Remove off>0 check. (Alexei)

  * Do not allocate new memory for min_index/max_index (Alexei, Eduard)

  * Information required during check_cfg is now cached to be reused
    later (Alexei + general logic for supporting multiple JT per jump)

  * Properly compare registers in regsafe (Alexei, Eduard)

  * Remove support for JMP32 (Eduard)

  * Better checks in adjust_ptr_min_max_vals (Eduard)

  * More selftests were added (but still there's room for more) which
    directly use gotox (Alexei)

  * More checks and verbose messages added

  * "unique pointers" are no more in the map

Links:
  1. https://lpc.events/event/18/contributions/1941/
  2. https://lwn.net/Articles/1017439/
  3. https://lore.kernel.org/bpf/20250615085943.3871208-1-a.s.protopopov@gmail.com/
  4. https://github.com/llvm/llvm-project/pull/149715

Anton Protopopov (11):
  bpf: fix the return value of push_stack
  bpf: save the start of functions in bpf_prog_aux
  bpf, x86: add new map type: instructions array
  selftests/bpf: add selftests for new insn_array map
  bpf: support instructions arrays with constants blinding
  selftests/bpf: test instructions arrays with blinding
  bpf, x86: allow indirect jumps to r8...r15
  bpf, x86: add support for indirect jumps
  bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
  libbpf: support llvm-generated indirect jumps
  selftests/bpf: add selftests for indirect jumps

 arch/x86/net/bpf_jit_comp.c                   |  39 +-
 include/linux/bpf.h                           |  30 +
 include/linux/bpf_types.h                     |   1 +
 include/linux/bpf_verifier.h                  |  20 +-
 include/uapi/linux/bpf.h                      |  11 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bpf_insn_array.c                   | 350 ++++++++++
 kernel/bpf/core.c                             |  20 +
 kernel/bpf/disasm.c                           |   9 +
 kernel/bpf/syscall.c                          |  22 +
 kernel/bpf/verifier.c                         | 603 ++++++++++++++++--
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/map.c                       |   2 +-
 tools/include/uapi/linux/bpf.h                |  11 +
 tools/lib/bpf/libbpf.c                        | 159 ++++-
 tools/lib/bpf/libbpf_probes.c                 |   4 +
 tools/lib/bpf/linker.c                        |  12 +-
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/prog_tests/bpf_goto_x.c     | 132 ++++
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 498 +++++++++++++++
 .../testing/selftests/bpf/progs/bpf_goto_x.c  | 384 +++++++++++
 21 files changed, 2230 insertions(+), 85 deletions(-)
 create mode 100644 kernel/bpf/bpf_insn_array.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_goto_x.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_goto_x.c

-- 
2.34.1


