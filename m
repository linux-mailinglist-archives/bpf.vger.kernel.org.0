Return-Path: <bpf+bounces-22161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98196858012
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 16:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E929282F50
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 15:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2514C12F5AE;
	Fri, 16 Feb 2024 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCWxQqCl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED50312F388
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095832; cv=none; b=TQMi4IPFqNpfLJcf7COwYH3EQAnDatB+IGNim4TfgOQkBg2yT2eNSyOpBKMF2avVzObfnRXqp6VReoR7QOl2h1kz+LPE8U1uuhOwL7KlnofN/inFTDKnLRXh/96RtpNSQP85YJyWGeCbwp0EsNc3CsjhoS4/5E0GVMovhz/nxxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095832; c=relaxed/simple;
	bh=nAJLrNeDIk+AzI92zeZXbt5cyvDRwN0FuHKNfLufySk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFCelG6Q/dpLrsXeyDW2rSgeOrhd/nX35q5aaj4IToAP7samGAwnL4WVWbqgWrrgQOWHe/+2eim1pK0mgtVgpwBe5Qgw0/SiHh9NNJXDBTEfwyoCXt237NA9oe/5ygsqBu3v9c05SOwGKreT0bkIL+BaoA5gdcoLFNYG4XRb1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCWxQqCl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563cc707c7cso2624679a12.1
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 07:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708095829; x=1708700629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7B+AEL2My8XcQ8DkTnvszcHoUUs6Fwt8t+hT7QGhDVg=;
        b=QCWxQqClDPu05rTPFDvYlxGfMfjqM/xEb4+xZvwxe6DuPBIMcTwUWMuxf7rwbyvpyJ
         rcmZqyyj11pUU0KH7fNjsQne9TgYde2kawDIhMiPh/sn8Gq3TY+XvvoPY1OHD8vEg8Pg
         UAJQCDwBehz1anyrR+S91d6yEzK2u0QjkKVyMkjUX23W4nCjcDHD75rkfZpnbYIVgfmC
         GwHKxiUyucORMfMyyfu0WhoA5hOnpsrpCQ9PvidfajwWdB1gbEbaPptMMDCHqQurVawB
         Ut4I2gLVdCiB9d5OvCC1MrPYkVAMzV4Lkum4KRHjvs82K1an2Ggcp8PpPaxMgq7b2A5g
         CpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708095829; x=1708700629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7B+AEL2My8XcQ8DkTnvszcHoUUs6Fwt8t+hT7QGhDVg=;
        b=FKYK+08U82XvPxdtVftjv6GlsrKhBanSX+H12zK5hSqqUDtqXjnoRlTWz8TGM05d9j
         0DUEEPgUth1ZfcbrQaYfoc6tF5VO4OgKo5im3voG0QDooA9HG/dzeQLl+535aZxLqgtY
         EUQDb/mnZWzXFyzxwQbv/uG7b99MOKWOCOiGyIR5k31jla+DF+dF6xEmouJCNTfq/I/F
         UJwUeQMD4XDCFTtF5Y/k1BsuhjpTX67eKooLTPvd0myYnk4BAiYh13JOPmbPbcyOIdCf
         GsP8wulmf6HBzwvzLt4ibbKV0Lq08H1MXxIveVs+VdCrLxWgBNs/YmOian2Txo2nozuu
         SBow==
X-Gm-Message-State: AOJu0YzyzCeDHOgYzYhIcZjhpwm9VOcZARQywbCcKMV5tt8AngPlcXqg
	I5RI+4lxXGPTHqKzXVCy6+q9oniUEi+acWHNKYL5UTS6cs36SmdLYCxVtoQy
X-Google-Smtp-Source: AGHT+IEGx3TjtLOqWp071HK2Qtap+jOR9AN2BqN0+X59IgArka/9PbwVh/wxNIsRmMw5AjOH43kXtg==
X-Received: by 2002:a17:907:b9ca:b0:a3d:6637:48be with SMTP id xa10-20020a170907b9ca00b00a3d663748bemr4300976ejc.29.1708095828947;
        Fri, 16 Feb 2024 07:03:48 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id fj16-20020a1709069c9000b00a3d07f3ac61sm14209ejc.101.2024.02.16.07.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 07:03:48 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	kuniyu@amazon.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/3] bpf: check bpf_func_state->callback_depth when pruning states
Date: Fri, 16 Feb 2024 17:03:33 +0200
Message-ID: <20240216150334.31937-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216150334.31937-1-eddyz87@gmail.com>
References: <20240216150334.31937-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When comparing current and cached states verifier should consider
bpf_func_state->callback_depth. Current state cannot be pruned against
cached state, when current states has more iterations left compared to
cached state. Current state has more iterations left when it's
callback_depth is smaller.

Below is an example illustrating this bug, minimized from mailing list
discussion [0].
The example is not a safe program: if loop_cb point (1) is followed by
loop_cb point (2), then division by zero is possible at point (4).

    struct ctx {
    	__u64 a;
    	__u64 b;
    	__u64 c;
    };

    static void loop_cb(int i, struct ctx *ctx)
    {
    	/* assume that generated code is "fallthrough-first":
    	 * if ... == 1 goto
    	 * if ... == 2 goto
    	 * <default>
    	 */
    	switch (bpf_get_prandom_u32()) {
    	case 1:  /* 1 */ ctx->a = 42; return 0; break;
    	case 2:  /* 2 */ ctx->b = 42; return 0; break;
    	default: /* 3 */ ctx->c = 42; return 0; break;
    	}
    }

    SEC("tc")
    __failure
    __flag(BPF_F_TEST_STATE_FREQ)
    int test(struct __sk_buff *skb)
    {
    	struct ctx ctx = { 7, 7, 7 };

    	bpf_loop(2, loop_cb, &ctx, 0);              /* 0 */
    	/* assume generated checks are in-order: .a first */
    	if (ctx.a == 42 && ctx.b == 42 && ctx.c == 7)
    		asm volatile("r0 /= 0;":::"r0");    /* 4 */
    	return 0;
    }

Prior to this commit verifier built the following checkpoint tree for
this example:

 .------------------------------------- Checkpoint / State name
 |    .-------------------------------- Code point number
 |    |   .---------------------------- Stack state {ctx.a,ctx.b,ctx.c}
 |    |   |        .------------------- Callback depth in frame #0
 v    v   v        v
   - (0) {7P,7P,7},depth=0
     - (3) {7P,7P,7},depth=1
       - (0) {7P,7P,42},depth=1
         - (3) {7P,7,42},depth=2
           - (0) {7P,7,42},depth=2      loop terminates because of depth limit
             - (4) {7P,7,42},depth=0    predicted false, ctx.a marked precise
             - (6) exit
         - (2) {7P,7,42},depth=2
(a)        - (0) {7P,42,42},depth=2     loop terminates because of depth limit
             - (4) {7P,42,42},depth=0   predicted false, ctx.a marked precise
             - (6) exit
(b)      - (1) {7P,7P,42},depth=2
           - (0) {42P,7P,42},depth=2    loop terminates because of depth limit
             - (4) {42P,7P,42},depth=0  predicted false, ctx.{a,b} marked precise
             - (6) exit
     - (2) {7P,7,7},depth=1
       - (0) {7P,42,7},depth=1          considered safe, pruned using checkpoint (a)
(c)  - (1) {7P,7P,7},depth=1            considered safe, pruned using checkpoint (b)

Here checkpoint (b) has callback_depth of 2, meaning that it would
never reach state {42,42,7}.
While checkpoint (c) has callback_depth of 1, and thus
could yet explore the state {42,42,7} if not pruned prematurely.
This commit makes forbids such premature pruning,
allowing verifier to explore states sub-tree starting at (c):

(c)  - (1) {7,7,7P},depth=1
       - (0) {42P,7,7P},depth=1
         ...
         - (2) {42,7,7},depth=2
           - (0) {42,42,7},depth=2      loop terminates because of depth limit
             - (4) {42,42,7},depth=0    predicted true, ctx.{a,b,c} marked precise
               - (5) division by zero

[0] https://lore.kernel.org/bpf/9b251840-7cb8-4d17-bd23-1fc8071d8eef@linux.dev/

Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 011d54a1dc53..c1fa1de590dc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16705,6 +16705,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 {
 	int i;
 
+	if (old->callback_depth > cur->callback_depth)
+		return false;
+
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (!regsafe(env, &old->regs[i], &cur->regs[i],
 			     &env->idmap_scratch, exact))
-- 
2.43.0


