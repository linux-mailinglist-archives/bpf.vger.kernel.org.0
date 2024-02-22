Return-Path: <bpf+bounces-22503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6DD85FCDC
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 16:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C53B2573F
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 15:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF257157E7C;
	Thu, 22 Feb 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiDSZ8LB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B19156981
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616515; cv=none; b=IBT8aoNX5G9r/5AlURdIO+YaYgEJjG98QLIa28rdL7nXmDIKz8OXUrmDuwhTOtKFn3zIG85ffhPcIxD9QsupQ5Pe6RrJUYOMLpunR6RnLXk1aI+kzEGYEA4bz/uurEIbCcahjqAUirHeffxNGCQXh8EZ7ri7aFVlQ+OAXpGwNeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616515; c=relaxed/simple;
	bh=eWERnZ4O2P1MAnr2O2Nc/Vg2BFWgkCHIIuvFJ0ML5Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzNWNMSNMMmVhMo5N/grNP2IxBJsX6c3Ju+z4Y2sNzc5xPExaQuLXy97fTCmhyRLu7KNm9EqkEohMy/XGiPqDs+ZuAnvgJQMNXgHnQp0rn0MTRTFh6T13mLP/WfmKs+uIDQvFVIbm/bo3xZvtKYipNznLNVRtO6zTEvbQPOlZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiDSZ8LB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3f3d0d2787so282808366b.3
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 07:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708616511; x=1709221311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtBZWMuNmOCn1H0B1IrCDf+7iRL2yIDiVQd+BqYqEe8=;
        b=GiDSZ8LBedo2ZFennu3ZJ4AbzU2E5NomgMJFyAWttHDvyoLD55ruoOXuWzAz9uPCbl
         IYIrQ8vL3hVYt0naCvqIpEdQx7YSWQXErnyf5gXR7ZE4Hvt4Ajx/kUvp1AUfuOzdMMAR
         uWEU6X5RBgv7lLCD1dJrjA120hqYdpIMmceKd+dG7LnZI18hh84IhxTZsz4kOIdMeKA8
         At/PorYaqYyNPXXMYWAQVz0QTIK+wKXZ91l9GUJ5W93o2Dmoj5ZSrrnrhyyqzK6cF8MZ
         gq0LNzZGDy1+KUaGm8A5h3jyasnjzPmPQsw3Uud4XewKV/lsZq0AmsBSK3Q/jI+7tMZa
         OdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616511; x=1709221311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtBZWMuNmOCn1H0B1IrCDf+7iRL2yIDiVQd+BqYqEe8=;
        b=RM1r9B50sJLs84i8YQo+htOrniuwVapTTZgQYUJUauUUyU58E77ua9JDmYn8kn7HGl
         rTMxZSBR92x2SzbaceE/QLRPOKCzmMVci4+KSzAUR6ENBdBNUrCP1IoLsZTI45Ifl0Lv
         m8Nj1Azo8ctxBN/ZZqn/Do3Kx1I4Aj8FMz/BIyhIlf31/EIs3LZSu0ASGGIyh4RwMkiO
         3p05AezfgtsZXUNRh3B3kCky55lg+4r1d3/z8T9deD9HEibUOe1ih6eFznmrs3bfxFoU
         Ayq+FWZnoKBG8smLa+AbNXZVv3CnNmyRinNrU0MbeCgIEl4NRVmIb+dAPN/2QrkQpYW4
         q7ZA==
X-Gm-Message-State: AOJu0Yzu3GYqhaD/HwWYJJDiX1HgIX4rc/BQ+dRJV9NorzilC/2uJPjH
	VVR/t9wzpfT+KIbXRaUyDwUzxh2BBtfq5PTUQUslBLn3tr3hYgX95qqQyUTv
X-Google-Smtp-Source: AGHT+IGwFNP4lGc5/8GCVdp7ygenAGwaxvUNKTDhhXRxNybC9iMU2a8FoU+h+lTXwVKPgTIP2RXPYw==
X-Received: by 2002:a17:906:f196:b0:a3f:6717:37ae with SMTP id gs22-20020a170906f19600b00a3f671737aemr2454735ejb.69.1708616511185;
        Thu, 22 Feb 2024 07:41:51 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id sn24-20020a170906629800b00a3e1939b23bsm5725090ejc.127.2024.02.22.07.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:41:50 -0800 (PST)
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
Subject: [PATCH bpf v3 1/2] bpf: check bpf_func_state->callback_depth when pruning states
Date: Thu, 22 Feb 2024 17:41:20 +0200
Message-ID: <20240222154121.6991-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222154121.6991-1-eddyz87@gmail.com>
References: <20240222154121.6991-1-eddyz87@gmail.com>
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
discussion [0] (assume that BPF_F_TEST_STATE_FREQ is set).
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
(a)      - (2) {7P,7,42},depth=2
           - (0) {7P,42,42},depth=2     loop terminates because of depth limit
             - (4) {7P,42,42},depth=0   predicted false, ctx.a marked precise
             - (6) exit
(b)      - (1) {7P,7P,42},depth=2
           - (0) {42P,7P,42},depth=2    loop terminates because of depth limit
             - (4) {42P,7P,42},depth=0  predicted false, ctx.{a,b} marked precise
             - (6) exit
     - (2) {7P,7,7},depth=1             considered safe, pruned using checkpoint (a)
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

Fixes: bb124da69c47 ("bpf: keep track of max number of bpf_loop callback iterations")
Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b263f093ee76..ddea9567f755 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16602,6 +16602,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
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


