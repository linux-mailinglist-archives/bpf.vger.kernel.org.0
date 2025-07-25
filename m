Return-Path: <bpf+bounces-64413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5748B1249C
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 21:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6CB1784C8
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94636257AEE;
	Fri, 25 Jul 2025 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEQPk1Tb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680CD254877
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470543; cv=none; b=vCzn+LyOTK2JaHGQ8plUnG+DQNX39EjXxq8XHIYoMv5cuVFb1vAqf5Gt7XiY3xil9RkN8S7c0z6GhJfnoUWu7932IoZ7jlIivzmofYQ5mQiM1YScIoYQ6LDbrTiWb+Vt2d38q1RfQyddz+/UIkvFdn8xwezDxN0GStUimmRlyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470543; c=relaxed/simple;
	bh=a8PEqDKL4Rgl8Nm0BoX0eJaPqCAaKMe6gQ7Oy15e4vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAdg4YK6UNC5stAcl+wPi+cOLb83JHVbWSh8rWQe8vBCmU/vOPKbuup6ApmtahaLCLgBF7y23DrIO+uoDktpYTsULLsQcKB+gKEkYTkU19R59f4QWCf5RnhkibEg1R5rj2L5PpAaTHG0k7aGC029zNJJj37eWiOx53v0W6F/PNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEQPk1Tb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45555e3317aso14038945e9.3
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 12:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753470540; x=1754075340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cad4kKUp0ur5TMMy1iCgLbwaOudNv+VzXahwpyTYD4=;
        b=YEQPk1Tbj83Sz6fmSjAE8u12ZEkaO+rNYm04kKuKjdBnJgS0UDAKXxKEh+JHqtVMPd
         A2KOfzADb+lQP+AJAH+RWUsK6YnQaqCxE2lUJycbETsREmbCjwTSxL96F0Mb9PMB69OW
         xHqez5FhhRed1eluuzNQ48P20F42v0zuJWY7Z/PaXIFMBbo6pZJNUf1QnGVxtsZD4RdF
         DhVGIHRrpm0+ddmtkxVolY0NJ0gM7Va1eQ1dTpD9OKTk/JZLY9xSBPZJ75aqCxWvRDG/
         i16WMxWHoFUFX7SLQsnUvwWl64+95fazjEajUynr0XZFeMVWkjM2SS+1MouRnO116GRk
         6fpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753470540; x=1754075340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cad4kKUp0ur5TMMy1iCgLbwaOudNv+VzXahwpyTYD4=;
        b=s2X5LdQ1blh9s0/YW1UwqWNagL8qfhSo8GZiUYIBWxjHkckijiNYmDni7tFli5IlB1
         Z/yrvGpefU3/yE2Xlxw495rw9skH+91uu887regCh4XQ5IXrZc28ZfiUHAUuGTAGsnI6
         uAlHSG6D+c0evhfl5a16MXtjWcykHilJuNpaOMCheeVParDUb2s7lvQNgbj60+ZWLuZ1
         H8pj6pDr4wkLeQHLjFLStgrjAY10gohS+vTjGFYBFUQ4eoYkhlj9WCrYBbMTF8s+99hp
         MzpSVomwLdS/8P0vDLnFGXVivO5VqcM0fR4PDBSmZU+RsnUfLl87UtQUKAEYaE5VE6Yr
         Ia6g==
X-Gm-Message-State: AOJu0Ywff1QcYXkUEUXj1IpxOnl3HHAUM5VjPRzI19jZrD9TO27LLsrb
	IN73tKzwVEcuMjhpvYj3x798ZAVBD07dF3qdql7QwIaBmdiRbf7buJpI9Ml2Tred
X-Gm-Gg: ASbGncsItpu/GUTCLDBViFVlCjTAq+X2XCz1vfoDb/JyZUpnwF5hgcU4Ql2tI57VCRP
	a4AsIrKU1GxKRwmg8Avs3FS43oiFmFtcXiNo281ovIs0EcyHomKzGa/I8eymWRwgVYAj3YigYu1
	/M6PPC75QT2GClYI1feQGMakIm7TG5kQJjMi39uWdrcbspJubmj82UldvX2ZJp6JIrRd9atKo/5
	vbuuoXabGWmZhaPXDbKBG4pzq5D+MFiw2pxx/6o4KoYCL2CpsyJdTSwSHpcGZggjsownAIMHAQZ
	SX55BPDXJYQgNP7nt+RB0wLkvnAn/Dm0qrMaL9QExxG+uJw9suEx0X2hE8QVYkJjac/kSicBMUH
	6Z2/33zWaYpKWa0V2kVOvN80swgmYAAIbBeDnCkS9xRarQtIo0CF0HgysPj5x4GM7jYpRpfRTjy
	55G3ixwqg9mO6LaRA9+/al
X-Google-Smtp-Source: AGHT+IEl4RH1L7gVq7zkzE6D8qPkHu/+CMdwtJkFoW6My0UyPxe8YGTiy2UQfFbYx3i1qcmFuy4xrg==
X-Received: by 2002:a05:600c:529a:b0:456:c48:491f with SMTP id 5b1f17b1804b1-458763117f3mr33607835e9.10.1753470539286;
        Fri, 25 Jul 2025 12:08:59 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e008dd2b4234fb07c80.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8dd2:b423:4fb0:7c80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac584d8sm6086685e9.21.2025.07.25.12.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 12:08:58 -0700 (PDT)
Date: Fri, 25 Jul 2025 21:08:57 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 5/5] bpf: Add third round of bounds deduction
Message-ID: <b0cd5dc5ac6abb84f09b253dea5dd5c61126e83c.1753468667.git.paul.chaignon@gmail.com>
References: <cover.1753468667.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753468667.git.paul.chaignon@gmail.com>

Commit d7f008738171 ("bpf: try harder to deduce register bounds from
different numeric domains") added a second call to __reg_deduce_bounds
in reg_bounds_sync because a single call wasn't enough to converge to a
fixed point in terms of register bounds.

With patch "bpf: Improve bounds when s64 crosses sign boundary" from
this series, Eduard noticed that calling __reg_deduce_bounds twice isn't
enough anymore to converge. The first selftest added in "selftests/bpf:
Test cross-sign 64bits range refinement" highlights the need for a third
call to __reg_deduce_bounds. After instruction 7, reg_bounds_sync
performs the following bounds deduction:

  reg_bounds_sync entry:          scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146)
  __update_reg_bounds:            scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146)
  __reg_deduce_bounds:
      __reg32_deduce_bounds:      scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146,umin32=0xfffffcf1,umax32=0xffffff6e)
      __reg64_deduce_bounds:      scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146,umin32=0xfffffcf1,umax32=0xffffff6e)
      __reg_deduce_mixed_bounds:  scalar(smin=-655,smax=0xeffffeee,umin=umin32=0xfffffcf1,umax=0xffffffffffffff6e,smin32=-783,smax32=-146,umax32=0xffffff6e)
  __reg_deduce_bounds:
      __reg32_deduce_bounds:      scalar(smin=-655,smax=0xeffffeee,umin=umin32=0xfffffcf1,umax=0xffffffffffffff6e,smin32=-783,smax32=-146,umax32=0xffffff6e)
      __reg64_deduce_bounds:      scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e)
      __reg_deduce_mixed_bounds:  scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e)
  __reg_bound_offset:             scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))
  __update_reg_bounds:            scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))

In particular, notice how:
1. In the first call to __reg_deduce_bounds, __reg32_deduce_bounds
   learns new u32 bounds.
2. __reg64_deduce_bounds is unable to improve bounds at this point.
3. __reg_deduce_mixed_bounds derives new u64 bounds from the u32 bounds.
4. In the second call to __reg_deduce_bounds, __reg64_deduce_bounds
   improves the smax and umin bounds thanks to patch "bpf: Improve
   bounds when s64 crosses sign boundary" from this series.
5. Subsequent functions are unable to improve the ranges further (only
   tnums). Yet, a better smin32 bound could be learned from the smin
   bound.

__reg32_deduce_bounds is able to improve smin32 from smin, but for that
we need a third call to __reg_deduce_bounds.

As discussed in [1], there may be a better way to organize the deduction
rules to learn the same information with less calls to the same
functions. Such an optimization requires further analysis and is
orthogonal to the present patchset.

Link: https://lore.kernel.org/bpf/aIKtSK9LjQXB8FLY@mail.gmail.com/ [1]
Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c                               | 1 +
 tools/testing/selftests/bpf/progs/verifier_bounds.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2de429f69ef4..8cf7b4b6d98b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2686,6 +2686,7 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 	/* We might have learned something about the sign bit. */
 	__reg_deduce_bounds(reg);
 	__reg_deduce_bounds(reg);
+	__reg_deduce_bounds(reg);
 	/* We might have learned some bits from the bounds. */
 	__reg_bound_offset(reg);
 	/* Intersecting with the old var_off might have improved our bounds
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 85e488b27756..7dcbc1042c64 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1573,7 +1573,7 @@ l0_%=:	r0 = 0;				\
 SEC("socket")
 __description("bounds deduction cross sign boundary, negative overlap")
 __success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
-__msg("7: (1f) r0 -= r6 {{.*}} R0=scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))")
+__msg("7: (1f) r0 -= r6 {{.*}} R0=scalar(smin=smin32=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,umin32=0xfffffd71,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))")
 __retval(0)
 __naked void bounds_deduct_negative_overlap(void)
 {
-- 
2.43.0


