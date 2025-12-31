Return-Path: <bpf+bounces-77567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 449F9CEB4D1
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 06:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC823302D5CF
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 05:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43231E5B63;
	Wed, 31 Dec 2025 05:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhNy727T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817E1A9B24
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 05:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767159384; cv=none; b=mByHqvwXQvjv1rdj+ra/d0mCxvyUA+Tm8P9otUJKOqWEBBWo0rC+2LNlmkGNEAqQBYBVBFTPd2DwJsROJ89ZRq+ZjPNRnPg8pQrnwzmK+WtDcjSE/zGpFUh6Tk/GQt/CZWLq+uvB9MNCbXq/p+U1RmFqsburDWGjqSWHB40AB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767159384; c=relaxed/simple;
	bh=ipIph66zkVaqjHR7FE7+cnxPIyYwlpBZlSAbcx9tdYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lydEWzdrsumSlkn0lZptMkUPHcXkS7auZ392q36MmAZNLSksatLly9z0cOiZlJtdax1zqyXae7wmy/F4oc67syg5j2Di0KljlzcGT7JlWIJ6NaFFx4l+6BBLERM5wc4ijibfFGFDeCCVCxgHMkbJ1ix+JWLz8DMJQVkSwCiY1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhNy727T; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so11979666b3a.1
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 21:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767159382; x=1767764182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3HfXYTtUXtnjeepnJaHVF+Qkg/QIdrQP1GD+2mjsFA=;
        b=nhNy727T/ns0UkXktjp7msu9CbSNGOFx6wAvS0uWSQ+YuDTpDjoc/jN31buNwPkind
         U+607NwN+vz1zj5l/NyralwyRU+yK5PiQMqxIKG8sPFt0yeO3X+pQc+yOCFTAc591HYm
         bFVEtZPD44o1uJjYA7CNs8uPGqZlCF/zQnWik1QYrQCRsO/0j+Sx98ubrSn7AWLfe3HT
         szhBpOGFeP9oH6giR4JhefA3wolDp03do2YyywQkAaxuPKSi37abZOh3OB1piPNYG5cx
         uU6DSASYOc7wW6sBqxENrZHA7mMDcIwWVq5kHccDS8EXdd2cdjzUpFZSbsdi3R7KU1yd
         0Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767159382; x=1767764182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3HfXYTtUXtnjeepnJaHVF+Qkg/QIdrQP1GD+2mjsFA=;
        b=Wdvnnb5dEaP0MTQROtQVJmbgWZDz6jV2RTEpmr20R+nUgpBKEhGeeHFEhhpvZfByFV
         /Qjp/r+qEdeFb7oRVbj09rKkIHuNhmHpb7hKUTZms1iy0DyRDrBrmvB1B3hrxkdfbENE
         38HnUHPjElPAcPmRKU2LIlxeM68B/eQUU0LzLV4ZThrr88k2c4VNzamVPSW/VrIDSHka
         RysmbY++jyvU8M/6QKffDQmVmNevqgOqTdf+zVmGyyAQj8NVCfxtn+fCuVDILvWocAtj
         ecfYuUjrzopCG0GH1d7ABzoHy763q51kjh2JpkKJul6zH3/kpMGqneo4+5rkfxvFFovW
         JPlg==
X-Gm-Message-State: AOJu0YzwF564UnAdo6XieSzMxribADxDavP/ATMZ9djz+COb5UoE01Kn
	j3pmvI7vCYFc8JXvkN7Q+UXNDWxKyU1wpzCxZ8oHkpgbkg7iGOVhqyhK+CPf4EPI
X-Gm-Gg: AY/fxX6LEL/IGUu3bgBC3BNiBxEdoU1CxPCC67a0Sbnblr17NzVSm8CI1FzScr234MA
	d2fIsJ0uRLyOCbhEjnZJtsTyL/1zt1fsAYd9/ZMvySxmjU2M85zk3HfzxiGeW2j5Co3CqymcNbO
	INkBqvHnwYhj/5EBsXuX3sI7qS9B7SMB81Wp6x5NwDfgaQ4nOL98vYoxcVPOxJzlGmiJWskjEZ9
	jrvfQbTrkU/U7MwerT202T+wwyzKFl+dqGsBRfIeGkzszayL8b5tHWg2u+1Wfo8J7uI3sUORZev
	AgHxenXaNNqQg0epB7K7zjJBpfqNWyC7cxblgkU97+pnOhylhqkSbW62JWw+yGJEVZ84Sma19D8
	Nmzkm8+lreuv52tgtg2Y7+M6qZCvyKE1L0hO/A47DP5BuBfcr8kl8hRClUPDfNOtIFErOron95A
	H7LFPjxaLsR/bkrVgLsmSB9zcKQ9s9vMqLWw==
X-Google-Smtp-Source: AGHT+IEfoJ7hMs9tEBFw9Y7LBGEq0/32D6gQk+0wahdOwrLgZNwcb0emkbCg0VPAUCPGraILWfKxLA==
X-Received: by 2002:a05:6a00:414b:b0:7e8:450c:61b6 with SMTP id d2e1a72fcca58-7ff6607cf9emr35362912b3a.38.1767159381826;
        Tue, 30 Dec 2025 21:36:21 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm34050165b3a.33.2025.12.30.21.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 21:36:21 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: iterator based loop and STACK_MISC states pruning
Date: Tue, 30 Dec 2025 21:36:04 -0800
Message-ID: <20251230-loop-stack-misc-pruning-v1-2-585cfd6cec51@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230-loop-stack-misc-pruning-v1-0-585cfd6cec51@gmail.com>
References: <20251230-loop-stack-misc-pruning-v1-0-585cfd6cec51@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The test case first initializes 9 stack slots as STACK_MISC,
then conditionally updates each of them to SCALAR spill inside an
iterator based loop. This leads to 2**9 combinations of MISC/SPILL
marks for these slots at the iterator next call.
The loop converges only if the verifier treats such states as
equivalent, otherwise visited states are evicted from the states cache
too quickly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/iters.c | 65 +++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 69061f0309579eada74e5f2a68640470ff94a8b3..7f27b517d5d5668a0d2204cb8f9a0632806c3959 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1997,6 +1997,71 @@ static void loop_cb4(void)
 		"goto 2b;"
 		:
 		: __imm(bpf_get_prandom_u32)
+	);
+}
+
+SEC("raw_tp")
+__success
+__naked int stack_misc_vs_scalar_in_a_loop(void)
+{
+	asm volatile(
+		"*(u8 *)(r10 - 15) = 1;" /* This marks stack slot fp[-16] as STACK_MISC. */
+		"*(u8 *)(r10 - 23) = 1;"
+		"*(u8 *)(r10 - 31) = 1;"
+		"*(u8 *)(r10 - 39) = 1;"
+		"*(u8 *)(r10 - 47) = 1;"
+		"*(u8 *)(r10 - 55) = 1;"
+		"*(u8 *)(r10 - 63) = 1;"
+		"*(u8 *)(r10 - 71) = 1;"
+		"*(u8 *)(r10 - 79) = 1;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+	"loop_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto loop_end_%=;"
+
+#define maybe_change_stack_slot(off) \
+		"call %[bpf_get_prandom_u32];"	\
+		"if r0 == 42 goto +1;"		\
+		"goto +1;"			\
+		"*(u64 *)(r10 " #off ") = r0;"
+
+		/*
+		 * When comparing verifier states fp[-16] will be
+		 * either STACK_MISC or SCALAR. Pruning logic should
+		 * consider old STACK_MISC equivalent to current SCALAR
+		 * to avoid states explosion.
+		 */
+		maybe_change_stack_slot(-16)
+		maybe_change_stack_slot(-24)
+		maybe_change_stack_slot(-32)
+		maybe_change_stack_slot(-40)
+		maybe_change_stack_slot(-48)
+		maybe_change_stack_slot(-56)
+		maybe_change_stack_slot(-64)
+		maybe_change_stack_slot(-72)
+		maybe_change_stack_slot(-80)
+
+#undef maybe_change_stack_slot
+
+		"goto loop_%=;"
+	"loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy),
+		  __imm_addr(amap)
 		: __clobber_all
 	);
 }

-- 
2.52.0

