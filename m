Return-Path: <bpf+bounces-21737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D70085172C
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 15:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3EAB24604
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E323B2B6;
	Mon, 12 Feb 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVdSlRYS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85A3A8F2
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748734; cv=none; b=MVgVy6HQ2M+XBlYEhXsRGxbX3CIY0F1pPWFLYbvUoYV61IBWNo6dQN9N0FKCQIw0Uf6cFtgNtrAix7HydIod+JRpvjb/6O5gyKRIOYudHI0Dvj/bFUrL8wmXBTVuWrsPY/4x/qiswP3z/1N4V9EWVQFqCk83k16VsECXMMyslhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748734; c=relaxed/simple;
	bh=GaQAhanZMMlRolDaX2CeGed6nPs04m760rk4oskkVAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Trzun8M9IGo3W2W54xenLwsWZ8SYdor/eNx0QzRjQqtvWzzmVsMPSm/qZqBcWGWx4NH8opnqlG3s88JY/0o2O6o4wng/vCLoWWyQPMNyGD+0lRXhE+cUJNZafBIqDh0H6i8Ekm3kQoglZ0HYSPAltnPx4xEiz9QmykFi0NU09fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVdSlRYS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3c2efff32aso202927966b.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 06:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707748731; x=1708353531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3HFF8F8Fn8RiDSWYG6HB/9fJWdtnup1mq4NKisX8aI=;
        b=GVdSlRYSWaKiG0Da4l8inM/cz3I87ylyJEpwP0hjWeXMiouMjtCR1TmhzVrf6Jo3mb
         uEoduKDwNwGygYjYu+mgzi1ezTtNwC016vhw07NBCd2NHVwYs6UsBhJTlcSkgpUYFDk/
         WZWM30KP1b39s4VfEKSp9ParfaatSeJVr7soMA1t/ndiTy+1s15malzc11wUgi2hqsM8
         ZPK19iJs/SWvMyZg7pTJ5r0rgUcCh6pyw45QBIbpsSeGd/upqXwvJTzb6pmBjeCmZBL0
         QQKcICSA/rHUHaUNomzL02K35P3OrJMplNVmXCkJ6+Tj1pVSb/cUJ886TYQr4d9u8aYl
         2joA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707748731; x=1708353531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3HFF8F8Fn8RiDSWYG6HB/9fJWdtnup1mq4NKisX8aI=;
        b=lRF79dYiRRREY4BIEcJnMAgSBh32It1GczLxLjgRL177/9KETMmYLoWDjSEfyykf7H
         SKZDDcYKT+xUZZ/POGCUyzrs/NjDux7jPuZnfJp9bSfW3yGZ7Scpc18VHpnv1tmrKw9x
         DFTibcCWGvwqXBTOr/WhIdA5ycw1W8ObZrS1w06+w4UlDAsWT294iYJmbmEtPCMDYKsJ
         aOmbVaU32LBO9riiTHrQ7B66HPGWpXJ+FN6e6fWnQ7c3GH6YBKqcIIbya+HewOFWpOgP
         kVqfx0oxMVKmZmJz18XD5BAgJ0LSOhVTjIiVtxfdaio2G070Xy8QClFEDg3tzF3g0oij
         Fk8w==
X-Gm-Message-State: AOJu0YxFZ5SuKT9rMQoRyaY4uORFjTGhRBGK4S+aH4FcTDEgqpPICD/k
	Waixu4Sf2oajZIf7Xdea+YNHj24rvrBFuueU5BmqvW/3YQEoadWCgk+fmlWj
X-Google-Smtp-Source: AGHT+IFNsVaLUjB0rkHaUCaAZ9afhXfyKKFs5AY2oTy3NWkQA7/7Kqtf/87CFkmRaEO1o3zqscao1A==
X-Received: by 2002:a17:906:cd01:b0:a3c:ce4b:58fa with SMTP id oz1-20020a170906cd0100b00a3cce4b58famr1059586ejb.51.1707748730589;
        Mon, 12 Feb 2024 06:38:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVN9Ly9w+gARq8unLJYn5iq8emVvQzcZW0ynfVfacOlfYiQcpG25FM97t1MhvK6jjODtIMdOWaw3C6sFn+czw6mjbdN+JFMy8xvGMiDpd+qH4CtpSj/9/b3tC+o108itOltgNoWzz+pxxeutomuuFrjBgrARw63jwC3ARD9eAceMjr9LmY75IGcMKz6bnDWxNeAlwnQq5PVY5cDrMaP3eVnM0Bz2AYf46aKO1NWKgo/UtW37LZsAiXrpeDVXEY=
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k3-20020a1709061c0300b00a360ba43173sm266918ejg.99.2024.02.12.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:38:50 -0800 (PST)
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
Subject: [PATCH bpf-next 2/3] bpf: check bpf_func_state->callback_depth when pruning states
Date: Mon, 12 Feb 2024 16:38:31 +0200
Message-ID: <20240212143832.28838-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212143832.28838-1-eddyz87@gmail.com>
References: <20240212143832.28838-1-eddyz87@gmail.com>
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
this example (notation: `(code point #) {<ctx->a>,<ctx->b>,<ctx->c>}`):

- (0) {7P,7,7}
  - (3) {7P,7,7}
    - (0) {7P,7,42} (checkpoint #1):
      - (3) {7P,7,42}
        - (0) {7P,7,42}   -> to end
      - (2) {7P,7,42}
        - (0) {7P,42,42}  -> to end
      - (1) {7P,7,42} (checkpoint #2)
        - (0) {42P,7P,42} -> to end
  - (2) {7P,7,7}
    - (0) {7P,42,7} safe (checkpoint #1)
  - (1) {7,7,7} safe (checkpoint #2)

Here checkpoint #2 has callback_depth of 1, meaning that it would
never reach state {42,42,7}.
While the last branch of the tree has callback_depth of 0, and thus
could yet explore the state {42,42,7} if not pruned prematurely.
This commit makes disallows such premature pruning.

[0] https://lore.kernel.org/bpf/9b251840-7cb8-4d17-bd23-1fc8071d8eef@linux.dev/

Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ddaf09db1175..df99fcdbaa05 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16715,6 +16715,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
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


