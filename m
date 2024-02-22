Return-Path: <bpf+bounces-22475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0F685EE4A
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 01:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE582823E1
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF1510A1D;
	Thu, 22 Feb 2024 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aH8X3vYc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A192528EF
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708563028; cv=none; b=n+tmNt0hhF8ynRbmfVyFxPybPW02mbx90JWeBtlFEnTpTyPc6ytb9AfR1A9D4zcuLhY/7ryd7dSndaLYsDPg05gQ4NHPboQwAaFssjuAV6Xj00veHgVIfI06bv4TTi77iXjMcJ3oAjSuq52BB15ryXpwn4SrtA/SiJZShrvHqSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708563028; c=relaxed/simple;
	bh=W3jdvn7O+rVSxbGkfeHCXVFg2BMRRfMkyNF5Ijxc190=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GyecNojU54ErBhxrNiZ6KL8Ywmxzi9VHBuCtKgQ4/e6aC2XKl3blRuKO0IFvIvl9T8UGRRoLq0iKPE1YgRdRvnOjSHAwLW5rS9tsmwbbfvstQG/6mxEYbTpPyAHuLBiTQz7bYP8/1OkoilkLtwgVa801F/huI/Po/YO4nDv1xYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aH8X3vYc; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d09cf00214so82509091fa.0
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 16:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708563024; x=1709167824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rDhZJJbqKRL4ZBnD3IZkskY16wdnIAQP25dHPAq3bu0=;
        b=aH8X3vYc9UXtQ/3h0nwctuZ6fs/35B4W2TRNpBVQjiW2/Lk31PCiGwj8s2OE+0Z2Ab
         LCiVZNyDK53bHn7kvNZ/C3DwyK6WmAPrCHh75YfU4lq0WYMQLO8U8Hi7J7GPicTmOzJ1
         4wuqnwCqrm5WmD10k7+ZMtCRqTgu3NqQjA55YT55A3fRnW5Bdm/2ZUNJHTjjcg9oAlkH
         hu39kzru+kbL7kZJXZKXT8aNw/woU3eEPHngZpZzPifQrmpNypVNoAJky3w5oJ/c0YjI
         cDD6qKENQKbofCvb8XYOPvcf+pCIp4TrOQ5Ick0GlsYlro56RMKUk0tWeQUhi0sb1B0Z
         959Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708563024; x=1709167824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDhZJJbqKRL4ZBnD3IZkskY16wdnIAQP25dHPAq3bu0=;
        b=QNKOxJfHcK2kZdVea5G/CnmtCfNWOKoWihtEeNkZBx2qT0VYnhkRFaYuRGnXp6Qflt
         z9HlrxCj2yNfiSOM++sONhcW2WpVgzg9G9lRmq7XKOScObMleOM4TNAPRiRj+TV/seX2
         zrGyj3NnMauXNCek26HzW743e5MnoAhahQ3eyyNXhqtsYycJ9cNjbf1qrj+qKdndApa4
         XQM/biM4f64B3LkG623shXX/P40HHzJWmmCUlrDrIf2FpI4j6FGSsHfrSfIuwurEDN3l
         3Bi4OPvmbxBig7MCLbhlSjByzo/DKaB7zf4Ye0wgcmREkEmebG9gQnOVj9c+Ubu7o/fV
         F67w==
X-Gm-Message-State: AOJu0YyyoOxNmNwPLEu0uFlqAyO/Ib5937sXcsN1aPUxpovMuSO4OL7a
	HCYWUdmam10u0X3M7ejajchs8fkbeJ8RV072MipUB8N7lEEgDAjroC2N3xKu
X-Google-Smtp-Source: AGHT+IHQcCogtH9V2IBwM/FULU7CMxtbZFBlJP/go5KJdS2IYxNFoF/3vp7pC7y9OR9J3nh/BBgSkg==
X-Received: by 2002:a2e:8290:0:b0:2d2:1fed:8029 with SMTP id y16-20020a2e8290000000b002d21fed8029mr10075495ljg.28.1708563024109;
        Wed, 21 Feb 2024 16:50:24 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600c355100b0041279ac13adsm2031992wmq.36.2024.02.21.16.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:50:23 -0800 (PST)
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
Subject: [PATCH bpf-next 0/4] bpf: track find_equal_scalars history on per-instruction level
Date: Thu, 22 Feb 2024 02:50:01 +0200
Message-ID: <20240222005005.31784-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
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

File                      Program                   Insns    (DIFF)  States (DIFF)
------------------------  ------------------------  ---------------  -------------
bpf_host.o                tail_handle_nat_fwd_ipv4     -75 (-0.61%)    -3 (-0.39%)
pyperf180.bpf.o           on_event                     -24 (-0.02%)    -8 (-0.09%)
pyperf600_nounroll.bpf.o  on_event                  -11498 (-2.12%)  +551 (+1.64%)

Note:
  patch #1 is a small refactoring which is not really used by
  subsequent patches, but it fixes a surprising behavior that I hit
  while exploring solutions for the issue at hand,
  thus I decided to keep it.

[0] https://lore.kernel.org/bpf/CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com/
[1] 904e6ddf4133 ("bpf: Use scalar ids in mark_chain_precision()")
[2] https://github.com/eddyz87/bpf/tree/find-equal-scalars-in-jump-history-with-stats
[3] https://github.com/anakryiko/cilium

Eduard Zingerman (4):
  bpf: replace env->cur_hist_ent with a getter function
  bpf: track find_equal_scalars history on per-instruction level
  bpf: remove mark_precise_scalar_ids()
  selftests/bpf: tests for per-insn find_equal_scalars() precision
    tracking

 include/linux/bpf_verifier.h                  |   2 +-
 kernel/bpf/verifier.c                         | 356 ++++++++++--------
 .../selftests/bpf/progs/verifier_scalar_ids.c | 256 +++++++++----
 .../bpf/progs/verifier_subprog_precision.c    |   2 +-
 .../testing/selftests/bpf/verifier/precise.c  |  10 +-
 5 files changed, 395 insertions(+), 231 deletions(-)

--
2.43.0

