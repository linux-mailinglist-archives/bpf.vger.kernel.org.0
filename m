Return-Path: <bpf+bounces-35014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD621935261
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 22:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F4FB20FBA
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 20:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F77F145A0E;
	Thu, 18 Jul 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR9kkC6W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B469753E22
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721334254; cv=none; b=Z79Fb+su0cV33O1DlkSM+F/39tcPYIaxIt6GdjJlRP0LtaRX+ukV3pLdhhMbWCzf5Tfo667bVNR6teyKzSH5SPbtv0QJ9NwuCNbPEaB4JguY0K1hfypQD7BLfloPgxat1/kUc1VU9hWDMAGa72wEf0osjF9kmRv4izlZvqrWPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721334254; c=relaxed/simple;
	bh=1OGxeX47Ff8qpNh8SwJ0cnDuLceClfRm6bXUWq891mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d807WllqvOmi6edstHPMtcgDTer0FJc4+Wj+TjudEuN0ZTjb24EbsOqmSACcDYdG2NPUTJUVWbdaBlwSOtUXyQRHS/23N29Sdhfw+EDOJJaGUeWDLYcVYzzXR/CrEJptOJPeVYKr5Oa2tvcw/hC2YCzWeVWXAR27Mlt30Gu98yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR9kkC6W; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fbc09ef46aso11549935ad.3
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721334252; x=1721939052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7HyanLo+n0yN/gAxBed1P+KYqPXITBjVtYPZqiBUhlg=;
        b=YR9kkC6Wzc+HvrTcbSbVgvEd+Xq7uzVrjOs3vmpgCtE3oKPTMcudfVzw+lVXp5r2Ao
         nNx8bAyo9m1ltLPMPsG/1K6PN4C4o7kY/z+UPF4GoLiIwAsGStFbNyaGnqUsUCVrsQGQ
         9yZ/LLzN1vux47XsMc663v5uqWk+6RHeCFArlmPE6WtsQrVRfwgMIT+HV06HSKgeIAU1
         LjvugmAwiCoV2Lr8fii9dUNV9Xsdh9QhKEhdJVj+/24VmB3gZswGY4lInYOnFsrwfNY8
         ctziiVhe5U9JwNuI2k2VWN2kKFESZ/A8esXyEzX7eB+PnmceqP2b1qDdaM3yHfUQNB0k
         U48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721334252; x=1721939052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HyanLo+n0yN/gAxBed1P+KYqPXITBjVtYPZqiBUhlg=;
        b=NVyIziArcueeRIkqHy4bMFhOmfEspIAnAXKe1/KOPa75eRo0xHDgos0WpIhmAH9AKL
         M3nTC17uTrGG+ZnonCjUg2giyKtIfCLlk07IAHt/EVtpUSiVO3fQrg9c0rASb/1cxf8i
         vxYnl728yrqCSB66D4tcQdSGmNGuFMAofO5mrC8ACRmEL67LBao9B9mVGh4btCdWrdIT
         rUpWr+5aDRXgvtW1RmP8zh9OE4pK4PlRBv066BidzkIv/Ua4JKgcmD2gj8OhPLin8vrv
         LzhllcTkmmYK1PEq3SHTV/KC2ADDVXjSI8IG3Uam8vannKDSnx0e0nXgNYjzAlSms8yx
         RhiQ==
X-Gm-Message-State: AOJu0YyIO1W3MeAvpSrwXzcyrEhrzmTOtSuE0nkL6UcIR1pi3LAAia4Q
	DAwXbBMuCFhcxIAU+8O0tx3Z2YixhCocSEXu64N7/TNeCCHI1qCD2M541M+B
X-Google-Smtp-Source: AGHT+IGtZVmovMqE/rRMpbOD53KufqmyInii7XXEAyTkGZP5OkN6sT0Md6m2zxBbGnKyeLgI0DqD/w==
X-Received: by 2002:a17:902:e84d:b0:1fb:68a2:a948 with SMTP id d9443c01a7336-1fc4e1339ffmr52083185ad.15.1721334251492;
        Thu, 18 Jul 2024 13:24:11 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc505basm96888235ad.270.2024.07.18.13.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:24:10 -0700 (PDT)
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
Subject: [bpf-next v3 0/4] bpf: track find_equal_scalars history on per-instruction level
Date: Thu, 18 Jul 2024 13:23:52 -0700
Message-ID: <20240718202357.1746514-1-eddyz87@gmail.com>
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
find_equal_scalars() [renamed to sync_linked_regs()] and use
this information in backtrack_insn().
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
- v2 -> v3:
  A number of stylistic changes suggested by Andrii:
  - renamings:
    - struct reg_or_spill   -> linked_reg;
    - find_equal_scalars()  -> collect_linked_regs;
    - copy_known_reg()      -> sync_linked_regs;
  - collect_linked_regs() now returns linked regs set of
    size 2 or larger;
  - dropped usage of bit fields in struct linked_reg;
  - added a patch changing references to find_equal_scalars() in
    selftests comments.
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
- v2: https://lore.kernel.org/bpf/20240705205851.2635794-1-eddyz87@gmail.com/

Eduard Zingerman (4):
  bpf: track equal scalars history on per-instruction level
  bpf: remove mark_precise_scalar_ids()
  selftests/bpf: tests for per-insn sync_linked_regs() precision
    tracking
  selftests/bpf: update comments find_equal_scalars->sync_linked_regs

 include/linux/bpf_verifier.h                  |   4 +
 kernel/bpf/verifier.c                         | 363 +++++++++++-------
 .../selftests/bpf/progs/verifier_scalar_ids.c | 256 ++++++++----
 .../selftests/bpf/progs/verifier_spill_fill.c |  16 +-
 .../bpf/progs/verifier_subprog_precision.c    |   2 +-
 .../testing/selftests/bpf/verifier/precise.c  |  28 +-
 6 files changed, 434 insertions(+), 235 deletions(-)

-- 
2.45.2


