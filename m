Return-Path: <bpf+bounces-4886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D00175154E
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A4C1C211F3
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 00:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792A8A52;
	Thu, 13 Jul 2023 00:31:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49393812
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 00:31:29 +0000 (UTC)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4091FF0
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 17:31:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 98e67ed59e1d1-2637aa1a48dso20552a91.2
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 17:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689208287; x=1691800287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQ8NSB2G45OwY3HLwNNmgR/S5booL8je0m5EfIGrRO4=;
        b=hS/YvhnoKLuCAnM5WZ4Q4hE6jxAp/Zqoo2dlAJocZKHsGagxfNGyREMVRov+dwBbKZ
         RJtUqOyslH4v9O5CT+QLryoHJZ6KSLcnbpxqsAdiwBMAThlscOuGtWEu+bhOQcYmMoBN
         NsOSJIxMY+Ni7eb1mGgewlypU1Xg5jXazxv33Cr74n6orc4Y+2zfgcPrWVdyasqIGAjP
         eXEn2KxuK3g2nWMTtOFzVZ0d8e/SdCxwtg0o0Yc6Ummb78qdCzNoetp6NyYd+NTIdRQ8
         9y8ZJcKCPPTS6gp+uDLra/7skWM4S6pxm8A0ZcwjtWfbA6XfNjQCAeauKYlg1MuVeZ3x
         2LQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689208287; x=1691800287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ8NSB2G45OwY3HLwNNmgR/S5booL8je0m5EfIGrRO4=;
        b=Qs1LGRq8jueHT4lRckGzW8HAzwpcoo8Z00BAK0I/KMXN2t3F3x+AujTGv7vJ17T2sM
         AwR95Z9wCrQlOdzcWS1U3Yd5sWitQq4kv++Lddi+rWi8O4PUP3p8OmJjVvN3/k3ddGsi
         7JSwDl7MFschmqOiSZwoN2Jhcpp6OWCuFX6MqbrRx5JjHZkzrfiXA6chzEwZH+mNVLOU
         TMCR2xaaomZ6KRgXDQfQ7qtpoLCmiFr6HWWkd6OLB2bu1SEiW4AV3pxVrClhUE6m4T6X
         fuSxlWdsp5Ov+WMDwidzkEr0P6+SZm8p/pxfH4N543FYuc02SgYglp0WbuUsOK2T9Grf
         16QQ==
X-Gm-Message-State: ABy/qLaBMEhpm4D2QdM9VAbQ2u6AcCHqCCmyC/FCY/5PZfaQEdGjkfEk
	EjgZY2sRD+DmL10vDUqC6KnFItMvsUgq/Q==
X-Google-Smtp-Source: APBJJlGBobjDZ0SHd+LtRSTLPRmIgqjd++bjwxj0Tth5wDFx0TVs09iie/8AmKUDoUhPkoob94IR7Q==
X-Received: by 2002:a17:90a:6748:b0:263:5c6a:1956 with SMTP id c8-20020a17090a674800b002635c6a1956mr15621504pjm.25.1689208286870;
        Wed, 12 Jul 2023 17:31:26 -0700 (PDT)
Received: from localhost ([49.36.211.37])
        by smtp.gmail.com with ESMTPSA id t5-20020a17090a3b4500b0023fcece8067sm4601427pjf.2.2023.07.12.17.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 17:31:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf v1 1/3] bpf: Fix subprog idx logic in check_max_stack_depth
Date: Thu, 13 Jul 2023 06:01:16 +0530
Message-Id: <20230713003118.1327943-2-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713003118.1327943-1-memxor@gmail.com>
References: <20230713003118.1327943-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2368; i=memxor@gmail.com; h=from:subject; bh=6qecsnL6zGkoFbqycGe72zut9wJdLqettZ2hasHeZyA=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkr0XQQeMyYMjwsADPOADQmm91Q4s56xn+bHYZL xw+FLuev/2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZK9F0AAKCRBM4MiGSL8R ygwrD/9JqtElc309UFCK45PwdvFZ5dgNTCeqHLDyN2sLJ46Oduxh8Q5OCamUB5fcK1tafUNOHWK MGPUtB2jGpxBRsY4eilSTwmNDuO9ZQFdUfkuNHoFKUahUHaqcSxDt/swBcPSd+AYEXBcvk+WmiI zK4QIxB33VDxbHzt/L3EgL5C5MUFfHbQAPmZQ9qJzbGoJrtlaQVw3efSrYexXrqid9NH2RzJ1FR YSz7vroy4J9Q9lxmMmeG0n8gDRYoQvhKXTwKzsq5NWDMwloEMQ3JiMbyteLYIGhHCx10AoNxXGh xZfvctrz+9tcsrpDUpspbKSQ1q8WuXJTHsxb8Wwxs6A8zy3nuf3anIHoe0IlYaU1EToTXZ6c4lR DiUnVRDySGjHC/qRiNlyxHEsP5vQBTS3QtYQPqOLuuZ+wHzCFsp162UYnGBc7pkD7m+Fs4sF9HP UBjmKrqVuNOPhKWf6I36tfdOjHZKx1uZteXLu5rLCRjjGZnEiRNN5E4ci4DTz/eoJeGDcx/mupz rjr79nJ5yW2xHdEJtEX2SI5zcHxUKVnJ7nGJhUeoGQXnWh39Hx/FA6OQ2ll0HWg1qP94dxmSDk6 Rofxb86MlCdaiQY6j+NRPlsFMyvnOhDu8WVjdapcApdPaxaxlVE35rgmJ3W+mMwrsNFTjHArr6X nfAKnJ3tOKX72fw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The assignment to idx in check_max_stack_depth happens once we see a
bpf_pseudo_call or bpf_pseudo_func. This is not an issue as the rest of
the code performs a few checks and then pushes the frame to the frame
stack, except the case of async callbacks. If the async callback case
causes the loop iteration to be skipped, the idx assignment will be
incorrect on the next iteration of the loop. The value stored in the
frame stack (as the subprogno of the current subprog) will be incorrect.

This leads to incorrect checks and incorrect tail_call_reachable
marking. Save the target subprog in a new variable and only assign to
idx once we are done with the is_async_cb check which may skip pushing
of frame to the frame stack and subsequent stack depth checks and tail
call markings.

Fixes: 7ddc80a476c2 ("bpf: Teach stack depth check about async callbacks.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 930b5555cfd3..e682056dd144 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5621,7 +5621,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 continue_func:
 	subprog_end = subprog[idx + 1].start;
 	for (; i < subprog_end; i++) {
-		int next_insn;
+		int next_insn, sidx;
 
 		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
 			continue;
@@ -5631,14 +5631,14 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 
 		/* find the callee */
 		next_insn = i + insn[i].imm + 1;
-		idx = find_subprog(env, next_insn);
-		if (idx < 0) {
+		sidx = find_subprog(env, next_insn);
+		if (sidx < 0) {
 			WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
 				  next_insn);
 			return -EFAULT;
 		}
-		if (subprog[idx].is_async_cb) {
-			if (subprog[idx].has_tail_call) {
+		if (subprog[sidx].is_async_cb) {
+			if (subprog[sidx].has_tail_call) {
 				verbose(env, "verifier bug. subprog has tail_call and async cb\n");
 				return -EFAULT;
 			}
@@ -5647,6 +5647,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 				continue;
 		}
 		i = next_insn;
+		idx = sidx;
 
 		if (subprog[idx].has_tail_call)
 			tail_call_reachable = true;
-- 
2.40.1


