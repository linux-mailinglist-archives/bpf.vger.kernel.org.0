Return-Path: <bpf+bounces-53140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDFCA4CFF1
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 01:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25F81896AE9
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 00:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F469DF5C;
	Tue,  4 Mar 2025 00:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hczcXI5U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19C847C
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 00:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048364; cv=none; b=R9L4WjZtfwY1z0minKym+6NbamSnqs4w+50qZpYzN3pARqcw8kcKJG6Vjlk3W1RDTMkgKVF4KxO2ENcfnHKi9RqPiDaqaqCZLeW0f6Xe/Tv6CeDEcmCpn0edefxntKOw7R0HF0oqjpoWR6xK5p1n4POhoYlzXnuvJtuCyjOMlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048364; c=relaxed/simple;
	bh=fKF2KnVvSFIujyVFKmr/CvkTOcXaGdgQySn32sH5SBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJbWYWok2VAy1gXBLHl6O7+hbkt1S52+zaeWqw6WrVb29ZGDs9P+dGPKgL+Iz35u8jWM4mF/FQGVFJzAMz+H90ulmmGyRL9HtTQOk06DEGcGCccn5P3yDlYFZMvAwEoEDBiNRFNoRn3QIQXK1B1eSzV7QSWBJTSMvAR29QgH1qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hczcXI5U; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43bc638686eso7698515e9.1
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 16:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741048361; x=1741653161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Aa2ZpPAS6iZfConH10UdeH1CtAx75XWJ56rJeGAtuk=;
        b=hczcXI5UVV+jqceJ71KrqgNgFxJPN8Pl0tkr0+zdeAsc/OgsV0d5qppcSYKmcEo9EB
         fZZy2pnwZT/1TYGZOXODd1CppHD48IV+RAM6S54me8bVljunZsd5Y5kqwWFv4aXby/Kb
         LdpKuuDAawxQYo+B0mW24xLUuqj2XZJJ6W2/AxBgSBwz0pgIxZrF1f2gX8CF+JvJSAEi
         Q1GPCPUHs60i//1m2hmxjaVPWEm0htg5FrcD5GXU2aA8d5nZNsDRK8dlA5i4XusblkCd
         USMmYNoApEcxDv7hUo9euKZUbZ8XEJZkzC6hTjXOF9R/nTjW6Rx5n+OXpBXRcmTCtOrZ
         Ks7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048361; x=1741653161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Aa2ZpPAS6iZfConH10UdeH1CtAx75XWJ56rJeGAtuk=;
        b=SNC6bwL1GqalfTKNtSkjY4g2ihAciGUoW+kjP2kwS58w0zNqqYrFtemFLpQVSMiGdn
         EyYsAyP8983lDY+KQv0N20Mr0UdZOqVub66KAU8SrRMadf5H4FrhgSe3Kwq4/iBvc5fe
         +v+Hy+i8IDkH7X12fBk/u39desOjaZDlIKSTxehgCfYQPYQwaeU6j6mqeCPe6rCO/vEe
         x7TY8w4Oh052zuYe4OuyZ1349VofX5liBH1XcuKUgYNFiNR44zkBNawkImn22o3Ie5Ur
         Qyqpgn5BFv+z9HOJciwQGakjpQRNL58Yv/cPyh2KAJZNUd9eGXaLF6fdAIWEMI+Ag05H
         ze/g==
X-Gm-Message-State: AOJu0YxpIlh5mZZnz8Y8cmrr9jvvPRmpoi9hfl5OA1+XQ2QA3HI2Fecm
	tdVRvTh6xbh3ZFOLbFZlYa62rT6KvVvYiQ62sIwaQfb8gXEY5ZdAZ7IRxk70K4Q=
X-Gm-Gg: ASbGnct9rC5HOGNptZxaGeBy3vp0Uy9Wt2/yObBbDwBXHj+5yX16PPQesaxiaz7UFE1
	DO5w8srHGfqUdHUOHVrEZldCHZtfMkAEKsY/fqX2VXqUrFd/Z/kaVeInlfz4B1ukO2wQV3SMksB
	8TOXo8In/JNXGP70PoTEv5LzdE/K5/bO27JjplspeJwFD37tAKX22givSbJwP7gucgflQvsjIZl
	m8/7y1p8g+g/JNtq0LmFMRUyGX45c+rvY//GbGyaeqDv99yOrmM9dbmF4lYOP+JJNCZWZTQJd8V
	h9S4euP/H7DYWUM1AkKqUcfJzhMyS4wV8g==
X-Google-Smtp-Source: AGHT+IEGHHazdSYK7mq21AEHpmPXI7Sj5FVXdnc/OhCIjg1Oa9JcqPBjSfUZbYQjJN4mD4FlmbJ2VA==
X-Received: by 2002:a05:6000:1789:b0:38d:d166:d44 with SMTP id ffacd0b85a97d-39115627f2dmr801180f8f.23.1741048360836;
        Mon, 03 Mar 2025 16:32:40 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:5::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485dcc1sm15617570f8f.87.2025.03.03.16.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:32:40 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2] Timed may_goto
Date: Mon,  3 Mar 2025 16:32:37 -0800
Message-ID: <20250304003239.2390751-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3202; h=from:subject; bh=fKF2KnVvSFIujyVFKmr/CvkTOcXaGdgQySn32sH5SBY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxklfKqSSr8/6vgcIXTQQ0v2TXu/ASxM5/Ktl1iVX d27I8qiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8ZJXwAKCRBM4MiGSL8Ryi5uEA CYGV3vb9k3IdZzL+VhS9/txCcLUGnWXqqezQg5WbDiEl0MoGs/m+2K1ndPVjx6cPfaI02GW/y5C8qb jfznVRkQI0XsqqVLQK8Zv9n4zSm71DuELKn2PNdlxxibhIcCpxaMn7Q8wG2jVI0JjG51oIz4tOGEbW hw242dC4yR1WxZpp5tFkS6H/rwpGhWIH2zZIgYfoAAnst4KRZom2qe0HV1ju06yVh0XpGlz5qzgfSr hfItQ+JkRuX2Bzdt37L4gX7HMmaznNWWzv4ZqjJDWoNmNWX3tQZIevGxX9pRTJogKvy10u+gISIsP0 ju1cba8lIt9kw7RXezIZa+M6JJltpm/s1FLPCYh898qgtlyHrq2mY/V8X1DA8TPU6k0Yvnprqn+g1p x1sth0ralxut//OFAXSdY0isPpdt2oeTpAKfK+zkH00g+nlARcBmyb3ZUnrIQWnjjWWro9qUoihFS0 CvljeuFYNQDl8FcsRWHwgUeaUVOxWgATn8MAofrQJ6nATxApQH6kfGMkPeQGyxtBlFZiVeLjch64lp n5rvFALYK2MxOoS0X6HHue53Lew8w85vXj6ZaFFWkcg5l/T/Y3hBnx2fC5LVTwPz0fTlwl9zI4t2A+ 9TI8G/5wZDjx3zqY1e1mlF6WLQb+lgeP5V31ne4YughVU1HYEhhkkJoyOLoQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This series replaces the current implementation of cond_break, which
uses the may_goto instruction, and counts 8 million iterations per stack
frame, with an implementation based on sampling time locally on the CPU.

This is done to permit a longer time for a given loop per-program
invocation. The accounting is still done per-stack frame, but the count
is used to instead amortize the cost of the logic to sample and check
the time spent since the start.

This is needed for expressing more complicated algorithms (spin locks,
waiting loops, etc.) in BPF programs without false positive expiration
of the loop. For instance, the plan is to make use of this for
implementing spin locks for BPF arena [0].

For the loop as follows:

for (int i = 0;; i++) {}

Testing on a bare-metal Sapphire Rapids Intel server yields the following
table (taking an average of 25 runs).

+-----------------------------+--------------+--------------+------------------+
| Loop type		      |	Iterations   |	Time (ms)   |	Time/iter (ns) |
+-----------------------------|--------------+--------------+------------------+
| may_goto		      |	8388608	     |	3	    |	0.36	       |
| timed_may_goto (count=65535)|	589674932    |	250	    |	0.42	       |
| bpf_for		      |	8388608	     |	10	    |	1.19	       |
+-----------------------------+--------------+--------------+------------------+

Here, count is used to amortize the time sampling and checking logic.

Obviously, this is the limit of an empty loop. Given the complexity of
the loop body, the time spent in the loop can be longer. Cancellations
will address the task of imposing an upper bound on program runtime.

For now, the implementation only supports x86.

  [0]: https://lore.kernel.org/bpf/20250118162238.2621311-1-memxor@gmail.com

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20250302201348.940234-1-memxor@gmail.com

 * Address comments from Alexei
   * Use kernel comment style for new code.
   * Remove p->count == 0 check in bpf_check_timed_may_goto.
   * Add comments on AX as argument/retval calling convention.
   * Add comments describing how the counting logic works.
   * Use BPF_EMIT_CALL instead of open-coding instruction encoding.
   * Change if ax != 1 goto pc+X condition to if ax != 0 goto pc+X.

Kumar Kartikeya Dwivedi (2):
  bpf: Add verifier support for timed may_goto
  bpf, x86: Add x86 JIT support for timed may_goto

 arch/x86/net/Makefile                         |  2 +-
 arch/x86/net/bpf_jit_comp.c                   |  5 ++
 arch/x86/net/bpf_timed_may_goto.S             | 52 ++++++++++++++
 include/linux/bpf.h                           |  1 +
 include/linux/filter.h                        |  8 +++
 kernel/bpf/core.c                             | 32 +++++++++
 kernel/bpf/verifier.c                         | 70 ++++++++++++++++---
 .../bpf/progs/verifier_bpf_fastcall.c         | 58 ++++++++++++---
 .../selftests/bpf/progs/verifier_may_goto_1.c | 34 ++++++++-
 9 files changed, 241 insertions(+), 21 deletions(-)
 create mode 100644 arch/x86/net/bpf_timed_may_goto.S


base-commit: 7586e2169c77a444d235a98ac858272d3dcec16e
-- 
2.43.5


