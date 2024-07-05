Return-Path: <bpf+bounces-33968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F1928E67
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 22:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F101C247AA
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 20:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933D714534C;
	Fri,  5 Jul 2024 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ylaxe9yg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B859414431C
	for <bpf@vger.kernel.org>; Fri,  5 Jul 2024 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213147; cv=none; b=NUebCdjlQKWX3HXgszjyqRzWm44/fbDDxgTjSybEoKAtMLZRWUehFt81GZfMtvJDKd+ruSo9X5Do2bYKTJH6uebXy8sSTQtR3k38r2DcJ1dzEaGqR3h3yS3F9VkY2zlUBRjKrV0yzu63Lbj+4bEBTwbVDPMdXSCL4VOlnjgW1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213147; c=relaxed/simple;
	bh=4HwOafE9/4NeCgdsh0OA1b4erLGk1V7tFcVPlv1tJDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZ/AXFGOD997fEixdQgb2c4xP6ZipJD+CsHFeSTeO9juXQ0Is+W7rXa/DfYJCe+xBeilpGVLO2GEp9ZKU1spDsWS4ArZgyaZtb1f3gl6siyTks4//4FBiaLEDUpJTsWfI3hq5syR6gokYlpcnbx8DRQVkQZvcAnbjuhPK0hXHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ylaxe9yg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6a837e9a3so11612905ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2024 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720213145; x=1720817945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gw3vwTDooCHSM2O1zunBfUxPYXTuw/vHoGvjPzSZz34=;
        b=Ylaxe9ygSSVOi1zMgNP+PrAToLni8FYVjvKukn1ov/+ZICmbPYACC5FiBgjGWB87LR
         lwtvjzRIQPe3ShG8gWtNwJx3izN+02JzahbvsvrmdtA7FeFVwTk/prLH9oKtHZepV8Tv
         kEGvvGWtW2I2J0OJnaAW+9jWNxedxtNJe6sX+kCj7KiGfsf04KnGjPEekf62zmu5er6C
         hpIIPJawR97/tqf+EIlpU8p3DzcSsrjv9DBbqcm1/Vmgq2yCzr9Id5me+TbT0E4G/99o
         FB8SJkZ0N4zeaeEhvKvhOME2ERZ/3uDSsPJ5ZmqaM9QjQERp2Dtzbhyz1QsY005RDwaH
         +Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720213145; x=1720817945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gw3vwTDooCHSM2O1zunBfUxPYXTuw/vHoGvjPzSZz34=;
        b=Pahg7nJ7z6Pq15UnlpIdC1KOlBvJ2wdDlsUrZFvyhA1R4W9vFbJ29VJn+vBGAvTPSr
         LlAqCu1Nxz3iiPZ4hZxg5r4ltea39UQJRdXtvESyx1zEkjvl585baNNzQ7EJ6nKMTqFh
         HOen5TAst8DEFC8eRPO2p/MlDYdiHk81ekKeXM16X5rmdHJ9yAr3nPW6SLLhBA/GtuKx
         gdjYHGoNZ9p3vAWUAQIVQFvy4AltikltdYeMgXRnUtSnkTd3Cck20MAwbbdw3tlEGBKW
         tE2IlbrdCIbae7T5ubG0p8p4nGiYuYEDZ7vD0tee6tCtMh4pV7tRQV+biesyozoD12+0
         Mg/Q==
X-Gm-Message-State: AOJu0YzXGlE6Vyd4T/JeGtKCwfQRRd35Hck60WpkDIM/+OlLPSXJzzw+
	2lQmXqeiBruZJGPDlNxxPLonTDnTw6hICxh0szKZDEB4E+ZqpwQIUicPDPXG
X-Google-Smtp-Source: AGHT+IFcHzEo6YD2gsPfdP6R9PqDo22I7Ji+dPT+9YuZRVR/T1QGJ7rcpzGn65URhy/u/ZANncZjJw==
X-Received: by 2002:a17:902:e5ca:b0:1f7:2bfe:87a2 with SMTP id d9443c01a7336-1fb33f31a8amr46471285ad.62.1720213144502;
        Fri, 05 Jul 2024 13:59:04 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d8c52sm144767705ad.112.2024.07.05.13.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 13:59:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	sunhao.th@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/3] bpf: track find_equal_scalars history on per-instruction level
Date: Fri,  5 Jul 2024 13:58:47 -0700
Message-ID: <20240705205851.2635794-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a fix for precision tracking bug reported in [0].
It supersedes my previous attempt to fix similar issue in commit [1].
Here is a minimized test case from [0]:

    0:  call bpf_get_prandom_u32;
    1:  r7 = r0;
    2:  r8 = r0;
    3:  call bpf_get_prandom_u32;
    4:  if r0 > 1 goto +0;
    /* --- checkpoint #1: r7.id=1, r8.id=1 --- */
    5:  if r8 >= r0 goto 9f;
    6:  r8 += r8;
    /* --- checkpoint #2: r7.id=1, r8.id=0 --- */
    7:  if r7 == 0 goto 9f;
    8:  r0 /= 0;
    /* --- checkpoint #3 --- */
    9:  r0 = 42;
    10: exit;

W/o this fix verifier incorrectly assumes that instruction at label
(8) is unreachable. The issue is caused by failure to infer
precision mark for r0 at checkpoint #1:
- first verification path is:
  - (0-4): r0 range [0,1];
  - (5): r8 range [0,0], propagated to r7;
  - (6): r8.id is reset;
  - (7): jump is predicted to happen;
  - (9-10): safe exit.
- when jump at (7) is predicted mark_chain_precision() for r7 is
  called and backtrack_insn() proceeds as follows:
  - at (7) r7 is marked as precise;
  - at (5) r8 is not currently tracked and thus r0 is not marked;
  - at (4-5) boundary logic from [1] is triggered and r7,r8 are marked
    as precise;
  - => r0 precision mark is missed.
- when second branch of (4) is considered, verifier prunes the state
  because r0 is not marked as precise in the visited state.

Basically, backtracking logic fails to notice that at (5)
range information is gained for both r7 and r8, and thus both
r8 and r0 have to be marked as precise.
This happens because [1] can only account for such range
transfers at parent/child state boundaries.

The solution suggested by Andrii Nakryiko in [0] is to use jump
history to remember which registers gained range as a result of
find_equal_scalars() and use this information in backtrack_insn().
Which is what this patch-set does.

The patch-set uses u64 value as a vector of 10-bit values that
identify registers gaining range in find_equal_scalars().
This amounts to maximum of 6 possible values.
To check if such capacity is sufficient I've instrumented kernel
to track a histogram for maximal amount of registers that gain range
in find_equal_scalars per program verification [2].
Measurements done for verifier selftests and Cilium bpf object files
from [3] show that number of such registers is *always* <= 4 and
in 98% of cases it is <= 2.

When tested on a subset of selftests identified by
selftests/bpf/veristat.cfg and Cilium bpf object files from [3]
this patch-set has minimal verification performance impact:

File                      Program                   Insns   (DIFF)  States (DIFF)
------------------------  ------------------------  --------------  -------------
bpf_host.o                tail_handle_nat_fwd_ipv4    -75 (-0.61%)    -3 (-0.39%)
pyperf600_nounroll.bpf.o  on_event                  +1673 (+0.33%)    +3 (+0.01%)


[0] https://lore.kernel.org/bpf/CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com/
[1] commit 904e6ddf4133 ("bpf: Use scalar ids in mark_chain_precision()")
[2] https://github.com/eddyz87/bpf/tree/find-equal-scalars-in-jump-history-with-stats
[3] https://github.com/anakryiko/cilium

Changes:
- v1 -> v2:
  - patch "bpf: replace env->cur_hist_ent with a getter function" is
    dropped (Andrii);
  - added structure linked_regs and helper functions to [de]serialize
    u64 value as such structure (Andrii);
  - bt_set_equal_scalars() renamed to bt_sync_linked_regs(), moved to
    start and end of backtrack_insn() in order to untie linked
    register logic from conditional jumps backtracking.
    Andrii requested a more radical change of moving linked registers
    processing to bt_set_xxx() functions, I did an experiment in this
    direction:
    https://github.com/eddyz87/bpf/tree/find-equal-scalars-in-jump-history--linked-regs-in-bt-set-reg
    the end result of the experiment seems much uglier than version
    presented in v2.

Revisions:
- v1: https://lore.kernel.org/bpf/20240222005005.31784-1-eddyz87@gmail.com/

Eduard Zingerman (3):
  bpf: track find_equal_scalars history on per-instruction level
  bpf: remove mark_precise_scalar_ids()
  selftests/bpf: tests for per-insn find_equal_scalars() precision
    tracking

 include/linux/bpf_verifier.h                  |   4 +
 kernel/bpf/verifier.c                         | 346 +++++++++++-------
 .../selftests/bpf/progs/verifier_scalar_ids.c | 256 +++++++++----
 .../bpf/progs/verifier_subprog_precision.c    |   2 +-
 .../testing/selftests/bpf/verifier/precise.c  |  28 +-
 5 files changed, 416 insertions(+), 220 deletions(-)

-- 
2.45.2


