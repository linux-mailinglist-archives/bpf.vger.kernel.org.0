Return-Path: <bpf+bounces-63807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E771B0B06A
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 16:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1AD51AA3584
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6445287518;
	Sat, 19 Jul 2025 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfMSSK2N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA81DC9A3
	for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752935020; cv=none; b=kssJulxGohBJCt9lDsQ6imq4ZtITNX3qnvkIyaDRKAxqYi4fdAmpy29oU/0juTvm5vYKr43LXFvYTt9qaeNLCtgS4fqyjLM6IHhuEMw+rJBDIU9NykNuKJ4Sr2nB4c9feEt4OYv1vGRvhdruXm10pm9xmnNWym661UxhuBoy4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752935020; c=relaxed/simple;
	bh=eG9d5bfqXYxomq7C1nKHVIG+A7sAG2tzT5nwSi3ThXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdpVJzXp5YZaQdiu1NWg/DACTXCV0XAjpiscc/77yhwIsxZe+ChOMPXEbbDKRQsxnQtketm9jn0t2dvFg+QvIJBQTYHm14Fy7muFu34uw+/0UEuvQ/mlEVXVkH/ax8CtblvhjpcFc7GCPrDDtQgB8BFrC0EvK6F6kYQq8okHBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfMSSK2N; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45600581226so31489085e9.1
        for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752935017; x=1753539817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQFjuP+iNtIoDi0XYtE812lJHTSk6/Ekvg1U6UOhf+8=;
        b=hfMSSK2NUwOtTly+0HPig+rZ+ccg6o3OGlODWMa3J9tsbIzlM2jg/Y9l/TR+Os1MAK
         jLZobMf0t/SC0OFjK3LQW+LcXjuaQ+4xFOW0mUW1HPF+awnQLVV+7zw0t+7RZVebzJqZ
         qSBBkbJqW+4ej0Z0Co0pR/b+dQkA4TZvHNxEiz9S8o36oPAGtwtcNQrrFqCb64I+rqpx
         pks5wfiqmzD5JwV2c68m0FNS2W4zENDk3zArk8wtnqSyIL/O8v1uoNUc0y+2rY0Mujg8
         1EH4xrtyQ/+quLEV93Kl58ijXdO/htjHxJOa3Wv/F/q6lY07s/q4kY+TGB1yUIjrwO4P
         n2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752935017; x=1753539817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQFjuP+iNtIoDi0XYtE812lJHTSk6/Ekvg1U6UOhf+8=;
        b=dkouxRwINJy3TJ+eGmfMj0j88ldBuFfhvoarEC36ldxmbCL5pYa3ynQLi+G7fQj2vo
         U6JBdLL4idM4v+42qayY5qS6nt6aNIit1gLx7kVKgmvSle9+J27MfbSrKmfKUUfXORNh
         x4NVay4tDRlqcxiOjSJ4dpK2g9oNka5uM+jVtH3JHEmQjQr5no8RBdBBWUUdIUDh8sUO
         TCDQKSq5uWB9tza9qsZfkDv/Wv0KnAxb8c2cbARNXXQ+nhrW3Rxs5XE18fT9btFTSyFa
         dpfkJWZK/th/rdkzwI44PHHo12bqf09MEVb4Q10UkxXu6+WJVrNMJ3SV36eCVacbguzJ
         /Fww==
X-Gm-Message-State: AOJu0YzzWTrAZHftYfo97eUCnTjVkcKXgSVNRxZqLrnOIFHQL89s2BQv
	43R+tbwRh7AUvolbpzTSmcOgetsUyUDqpyLkS5K3BcUthqCV+oiZ+sAjwbVa93P9
X-Gm-Gg: ASbGnctzSHocLGO8l7jCT2Wve5KByyLnoUTu4jZhI1JVR3psH12sN007ILkDF5PICi1
	Eyk2K70DD1mcdv3l6VuZdupFdkfI5Di1+3o9pqowHgem7njSdUwbS5oB5FE3TBbbfQWVTruLQzC
	bR/mqhrxVz0Gqps1RuCwI0gXzm7ZStFAfItPCc7aTaLxY/jv6u/QPoRFmzd2ULEV6ni3W+8DjV+
	cQKidhupTKVvu2OIRtGI0/Io96WBHz14LlvdmPRLLbOGoc8W8l1GvNCel/810tDgfIO2kEeb3hh
	CaksQrp0FxiVYSsXa26HGfLlnV6OTqeZrvsAN2qadyFC+LKoaC4x244HvlPWxSd5duqIi5vOG42
	JXT+xRX+t6+yC7g7z7MGIib9lX6/Al7ztyUYsnUGFMyrtC89kLMEJB06KhyDBK1Enzu1xPwvzz1
	u/xo5zZ6r+HLAmqGFjiwRJ
X-Google-Smtp-Source: AGHT+IHENqze9mYdBqpTg2oxtDmwiL/wHPw898mSTg/3YwVr1cJfOFtqWzTiZsoIM2RBzl6B4GKApQ==
X-Received: by 2002:a05:600c:1ca9:b0:450:b240:aaab with SMTP id 5b1f17b1804b1-4562e044fd0mr149790725e9.8.1752935016633;
        Sat, 19 Jul 2025 07:23:36 -0700 (PDT)
Received: from Tunnel (2a01cb089436c000eab97b50918e1e74.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:eab9:7b50:918e:1e74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75de26sm48244125e9.33.2025.07.19.07.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 07:23:35 -0700 (PDT)
Date: Sat, 19 Jul 2025 16:23:34 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 3/4] selftests/bpf: Test cross-sign 64bits range
 refinement
Message-ID: <7cf24829f55fac6eee2b43e09e78fc03f443c8e5.1752934170.git.paul.chaignon@gmail.com>
References: <cover.1752934170.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752934170.git.paul.chaignon@gmail.com>

This test is a simplified version of a BPF program generated by
syzkaller that caused an invariant violation [1]. It looks like
syzkaller could not extract the reproducer itself (and therefore didn't
report it to the mailing list), but I was able to extract it from the
console logs of a crash.

  0: call bpf_get_prandom_u32#7    ; R0_w=scalar()
  1: w3 = w0                       ; R3_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
  2: w6 = (s8)w0                   ; R6_w=scalar(smin=0,smax=umax=0xffffffff,smin32=-128,smax32=127,var_off=(0x0; 0xffffffff))
  3: r0 = (s8)r0                   ; R0_w=scalar(smin=smin32=-128,smax=smax32=127)
  4: if w6 >= 0xf0000000 goto pc+4 ; R6_w=scalar(smin=0,smax=umax=umax32=0xefffffff,smin32=-128,smax32=127,var_off=(0x0; 0xffffffff))
  5: r0 += r6                      ; R0_w=scalar(smin=-128,smax=0xf000007e,smin32=-256,smax32=254)
  6: r6 += 400                     ; R6_w=scalar(smin=umin=smin32=umin32=400,smax=umax=smax32=umax32=527,var_off=(0x0; 0x3ff))
  7: r0 -= r6                      ; R0=scalar(smin=-655,smax=0xeffffeee,umin=umin32=0xfffffcf1,umax=0xffffffffffffff6e,smin32=-783,smax32=-146,umax32=0xffffff6e,var_off=(0xfffffc00; 0xffffffff000003ff))
  8: if r3 < r0 goto pc+0
  REG INVARIANTS VIOLATION (false_reg2): range bounds violation u64=[0xfffffcf1, 0xffffff6e] s64=[0xfffffcf1, 0xeffffeee] u32=[0xfffffcf1, 0xffffff6e] s32=[0xfffffcf1, 0xffffff6e] var_off=(0xfffffc00, 0x3ff)

The principle is similar to the invariant violation described in
6279846b9b25 ("bpf: Forget ranges when refining tnum after JSET"): the
verifier walks a dead branch, uses the condition to refine ranges, and
ends up with inconsistent ranges. In this case, the dead branch is when
we fallthrough on both jumps.

At the second fallthrough, the verifier concludes that R0's umax is
bounded by R3's umax so R0_u64=[0xfffffcf1; 0xffffffff]. That refinement
allows __reg64_deduce_bounds to further refine R0's smin value to
0xfffffcf1. It ends up with R0_s64=[0xfffffcf1; 0xeffffeee], which
doesn't make any sense.

The first patch in this series ("bpf: Improve bounds when s64 crosses
sign boundary") fixes this by refining ranges before we reach the
condition, such that the verifier can detect the jump is always taken.
Indeed, at instruction 7, the ranges look as follows:

    0          umin=0xfffffcf1                 umax=0xff..ff6e  U64_MAX
    |                [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]        |
    |----------------------------|------------------------------|
    |xxxxxxxxxx]                                   [xxxxxxxxxxxx|
    0    smax=0xeffffeee                       smin=-655        -1

The updated __reg64_deduce_bounds can therefore improve the ranges to
s64=[-655; -146] (and the u64 equivalent). With this new range, it's
clear that the condition at instruction 8 is always true: R3's umax is
0xffffffff and R0's umin is 0xfffffffffffffd71 ((u64)-655). We avoid the
dead branch and don't end up with an invariant violation.

Link: https://syzkaller.appspot.com/bug?extid=c711ce17dd78e5d4fdcf [1]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 63b533ca4933..d104d43ff911 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1550,4 +1550,27 @@ l0_%=:	r0 = 0;				\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("bounds deduction sync cross sign boundary")
+__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
+__retval(0)
+__naked void test_invariants(void)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	w3 = w0;			\
+	w6 = (s8)w0;			\
+	r0 = (s8)r0;			\
+	if w6 >= 0xf0000000 goto l0_%=;	\
+	r0 += r6;			\
+	r6 += 400;			\
+	r0 -= r6;			\
+	if r3 < r0 goto l0_%=;		\
+l0_%=:	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


