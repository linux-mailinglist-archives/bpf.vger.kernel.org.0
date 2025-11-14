Return-Path: <bpf+bounces-74576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D068C5F7A0
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB2A3BC496
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817E233710D;
	Fri, 14 Nov 2025 22:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj4Y1tHg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9712FDC50
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158444; cv=none; b=XkakORYCzQlbzz65LRLR7TSKOQFRbbtKORf0Jc8PVvvad5rA67MLZsauJnyAUdQ2p5smljUuyxZdGFPX40lpxNza+GtQ8gBpG0Ettq28hWOWNgQLcqVZmOPPvUUfecjN+JkyUnZSDAlGVL8y/Sqi2qpPDXj2fmovnI381TMZgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158444; c=relaxed/simple;
	bh=Owby5H7jdngP852ftk9fRAmiepxGeMpEc0LbSSSgKWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uN9CZouJdlTSOgtrrv9YXSuUBAPIzYDBCuNv7JftGV9jKbUrJBrf662O5Vr6WARsToa+Qdg2ue0h9RQoMi9phQ8Vifxo8IAVzgvtlfgO4GK856r4uz9CiBLVXD0feFmJs4jOXdHTapxiiY6sbznDI8l0mq7EP+snRSUM2C0Cb9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj4Y1tHg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-298250d7769so16216885ad.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 14:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763158442; x=1763763242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fbJf7s0/EWM//OleC4de+kmb2AQITT3NnIaKxfa60oc=;
        b=Uj4Y1tHgWEeX17l7piy/iEO4e1Qey0/H32dm1Kd24WlII4dIZcK8Qi/pKzVCXpGevM
         a1xWkb/+KT9h/8ymK5mSkSqQmKMp9gNP5WIesQMM9QE/DTLKDS54XFKf/CeWGBquhSaA
         v0y+GO3fw7D54TM+xxfeslt0xS3E+ua3Ke21z62xihfbCjCdJsj71r8WgBKraZ7xSVei
         r6q6XqJg8L78gU/Xhl3Z79m5KqCV1XSbko0SuUYWbHMZ51wO2dLDMjdyrt8eYs6O4SVS
         dt24YUyvX5i/BEQqbqoFikn8vbMMEBAfMO0LtfNorVzU1Ej/n9EKQARoqYdYoFmOd4xY
         0EZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158442; x=1763763242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbJf7s0/EWM//OleC4de+kmb2AQITT3NnIaKxfa60oc=;
        b=kcCo/yn8uEF2GO70YYnPMySpqT5n2aJF5Uv+q8z8YaWi5dflrvxbwm6Icj+96BrqoN
         iaYGzrC9VnSzZDTSgE8BSpuF4jeEeIl0B++gDJ5v+mXklJMilj9y+3tVtwzy9GtTIrpB
         YhAUWxNdVNI4FQoDzakfxPskPB80CQqttSVpDYJcDyCXoF7/Peu/y3qDzWLlQh0/TqgW
         zYDiEJdSECaIenvheY66qd1el499jQuGp5HINu37QVGBrvDlXHImdj1SDJjNa4sVAOKX
         jISufwzQo2mnLFsv4pVDSTYAT8wgXpSjAOm+yhW88afeVFpuxEVG+TIrpT/dHQ6lkSGh
         ObNw==
X-Gm-Message-State: AOJu0YxbFSgVyzxtyOCNpMPrUgvUunK+vELXD+K9P5kiEQRZjKpyiiR1
	kguRi8Wq6zcnGsdrYowX1UAkvjqvuCsKp5rvqPC87YOQduPOpXcW5idn
X-Gm-Gg: ASbGncvoEvSWxl5LhZrxaRIa799iBjQJbrDuxJUvmgcSVzN9SXjlK6bef/ksMajATAd
	0tmKNm2rI6dSCH0qsl+LAgXZeA6ol3x9SXYQSfH8xISlf/ER6jGkmZ46LRI0G6fbcYB8g0jB1T5
	WXFicii57YZeCpdEFwJ4aj5npCWxW0swlZpR1k1pP0nLxPRrj0VJ2e4VkaFzAYj3jhQRIpPbIrt
	JYkYo+GK7viI8k9nL/v9CA5Kuiz6anxgYugjFO/jsi7yzESC4UMygooga9hNNaEcjRPQON9RDuu
	wWEYk7UCNfDS82MjKgEl7dk0bA88sFPZqp3dExrE1OPeUREiH1EDmk3PhQSBHeu6VN1VIiK56QT
	l51vOpbKgLw7XhcxQw1DJgXd1P+JcuJNIGKIpHtOHBRou06Jl+7mZeyUYd0YqnyWTRHh/oOSBdt
	NALGZbyDanD3OuXlk0hRs6x8Xxpl+nLd18OzPT/miDLYPA48b7Js+qJM0=
X-Google-Smtp-Source: AGHT+IGuxdj+fzFRvUVpJ7iYQV1JoWBB3KHH+LT2fxfC8hIV1ONVxBgHeL2VgTF68P8xAO8jeo7NRg==
X-Received: by 2002:a17:902:ce01:b0:269:4759:904b with SMTP id d9443c01a7336-2986a7569f4mr47611075ad.58.1763158441682;
        Fri, 14 Nov 2025 14:14:01 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2348afsm66154105ad.3.2025.11.14.14.13.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Nov 2025 14:14:00 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	rostedt@goodmis.org
Subject: [GIT PULL] BPF fixes for 6.18-rc6
Date: Fri, 14 Nov 2025 14:13:58 -0800
Message-ID: <20251114221358.71656-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 6c762611fed7365790000925f3d14f20037d0061:

  selftests/bpf: Test widen_imprecise_scalars() with different stack depth (2025-11-14 09:26:28 -0800)

----------------------------------------------------------------
- Fix interaction between livepatch and BPF fexit programs (Song Liu)
  With Steven and Masami acks.

- Fix stack ORC unwind from BPF kprobe_multi (Jiri Olsa)
  With Steven and Masami acks.

- Fix out of bounds access in widen_imprecise_scalars() in the verifier
  (Eduard Zingerman)

- Fix conflicts between MPTCP and BPF sockmap (Jiayuan Chen)

- Fix net_sched storage collision with BPF data_meta/data_end (Eric Dumazet)

- Add _impl suffix to BPF kfuncs with implicit args to avoid
  breaking them in bpf-next when KF_IMPLICIT_ARGS is added (Mykyta Yatsenko)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (3):
      Merge branch 'fix-ftrace-for-livepatch-bpf-fexit-programs'
      Merge branch 'bpf-add-_impl-suffix-for-kfuncs-with-implicit-args'
      Merge branch 'x86-fgraph-bpf-fix-orc-stack-unwind-from-return-probe'

Eduard Zingerman (2):
      bpf: account for current allocated stack depth in widen_imprecise_scalars()
      selftests/bpf: Test widen_imprecise_scalars() with different stack depth

Eric Dumazet (1):
      bpf: Add bpf_prog_run_data_pointers()

Jiayuan Chen (3):
      mptcp: Disallow MPTCP subflows from sockmap
      mptcp: Fix proto fallback detection with BPF
      selftests/bpf: Add mptcp test with sockmap

Jiri Olsa (4):
      Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
      x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe
      selftests/bpf: Add stacktrace ips test for kprobe_multi/kretprobe_multi
      selftests/bpf: Add stacktrace ips test for raw_tp

Martin KaFai Lau (1):
      Merge branch 'mptcp-fix-conflicts-between-mptcp-and-sockmap'

Mykyta Yatsenko (2):
      bpf:add _impl suffix for bpf_task_work_schedule* kfuncs
      bpf: add _impl suffix for bpf_stream_vprintk() kfunc

Song Liu (3):
      ftrace: Fix BPF fexit with livepatch
      ftrace: bpf: Fix IPMODIFY + DIRECT in modify_ftrace_direct()
      selftests/bpf: Add tests for livepatch + bpf trampoline

 arch/x86/events/core.c                             |  10 +-
 arch/x86/include/asm/ftrace.h                      |   5 +
 arch/x86/kernel/ftrace_64.S                        |   8 +-
 include/linux/filter.h                             |  20 +++
 include/linux/ftrace.h                             |  10 +-
 kernel/bpf/helpers.c                               |  26 ++--
 kernel/bpf/stream.c                                |   3 +-
 kernel/bpf/trampoline.c                            |   5 -
 kernel/bpf/verifier.c                              |  18 +--
 kernel/trace/ftrace.c                              |  60 ++++++---
 net/mptcp/protocol.c                               |   6 +-
 net/mptcp/subflow.c                                |   8 ++
 net/sched/act_bpf.c                                |   6 +-
 net/sched/cls_bpf.c                                |   6 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |   2 +-
 tools/lib/bpf/bpf_helpers.h                        |  28 ++--
 tools/testing/selftests/bpf/config                 |   3 +
 .../bpf/prog_tests/livepatch_trampoline.c          | 107 +++++++++++++++
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 140 +++++++++++++++++++
 .../selftests/bpf/prog_tests/stacktrace_ips.c      | 150 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/iters_looping.c  |  53 ++++++++
 .../selftests/bpf/progs/livepatch_trampoline.c     |  30 +++++
 tools/testing/selftests/bpf/progs/mptcp_sockmap.c  |  43 ++++++
 tools/testing/selftests/bpf/progs/stacktrace_ips.c |  49 +++++++
 tools/testing/selftests/bpf/progs/stream_fail.c    |   6 +-
 tools/testing/selftests/bpf/progs/task_work.c      |   6 +-
 tools/testing/selftests/bpf/progs/task_work_fail.c |   8 +-
 .../testing/selftests/bpf/progs/task_work_stress.c |   4 +-
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  26 ++++
 29 files changed, 762 insertions(+), 84 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
 create mode 100644 tools/testing/selftests/bpf/progs/livepatch_trampoline.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sockmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/stacktrace_ips.c

