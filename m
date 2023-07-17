Return-Path: <bpf+bounces-5112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F37BE7568D4
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3521B28105E
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57767BE48;
	Mon, 17 Jul 2023 16:15:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CEBA58
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 16:15:43 +0000 (UTC)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4BC10C8
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:15:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1bb119be881so30694945ad.3
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689610540; x=1692202540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQ8NSB2G45OwY3HLwNNmgR/S5booL8je0m5EfIGrRO4=;
        b=qRXQKNM4d7ivrKJWNK9J9oBzPBP/palpM0vTUU6MZRxrnAwR1uYAdn7sc7HNGbY+8n
         mfo/4bZpFAzLhP6M0ztvSrWz0qOkjVq9KHfqfqvNJGsrOL9aJjFcOtArNG0CnYZcQLIP
         WCizLLNuUFJwhhjGdkqDPDTBCDh7ht6yngbmvt3zyH5d5Rwbb3rj8jQqVmzOiVrhSWEy
         xfdXTamYC+uaMdkdlwC5NDdn9X6kMF7ZOMS0lT3PTox7DHQ07/fJPzD6KVszl2FMn5Kn
         swIwb3EwKX4u6i6Q2eT4LqdN/DxxfU8Z4uaggN2vb6zi+gJB6uiBOd5utVGgYTxbzTnE
         LsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689610540; x=1692202540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ8NSB2G45OwY3HLwNNmgR/S5booL8je0m5EfIGrRO4=;
        b=RqUmutB6UV04jzZ0G9kRZWQ0d9b5KieVgR45Y/Qhmo00l/46gfKEK65PoVJlfEtCGF
         kEDMk7jriOJLTNFNLRXQv/R4G5Yp+wirOYBA+DDrUZyloWdn3FmJW0uy7erpFooH4vop
         SiUUPzBQPp4W+uzdjMY9PwBhmTutP0fHEBNxgGeTgoCtXtLf7UlvYXYiVdgUmLn4u9Qr
         nRo1FweTcExRBHCNohI+Dan46YQ7y14fluBl5YI9XPX9z9peN5/m26nPTrgzZ1wFXXdx
         xtdUr5fwjQ3zDt+SYb1T5EMYrE/HshrNSqUe6cg3ejI417s86YtWES6k1kvmhaI2eqQM
         M4Vw==
X-Gm-Message-State: ABy/qLbYcecFJUD+yLneBu8CR0a5dgxHLWvN4LGa9z87sET/a5iW0LBV
	yk5oQ4n4SJXWFHYtMUyJlJHTY7wuZKbutg==
X-Google-Smtp-Source: APBJJlGyj4JnSzvUBr1Mq+qEmqfccwS7rECMCLLQWZUrB3ivdPtABlCipi4fwHWO+fQAfTyrFpqxcg==
X-Received: by 2002:a17:903:230e:b0:1b9:e97f:3846 with SMTP id d14-20020a170903230e00b001b9e97f3846mr16886653plh.15.1689610540413;
        Mon, 17 Jul 2023 09:15:40 -0700 (PDT)
Received: from localhost ([49.36.211.25])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709028f8f00b001b889df671bsm57165plo.297.2023.07.17.09.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 09:15:39 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf v2 1/3] bpf: Fix subprog idx logic in check_max_stack_depth
Date: Mon, 17 Jul 2023 21:45:28 +0530
Message-Id: <20230717161530.1238-2-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717161530.1238-1-memxor@gmail.com>
References: <20230717161530.1238-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2368; i=memxor@gmail.com; h=from:subject; bh=6qecsnL6zGkoFbqycGe72zut9wJdLqettZ2hasHeZyA=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBktWjfQeMyYMjwsADPOADQmm91Q4s56xn+bHYZL xw+FLuev/2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZLVo3wAKCRBM4MiGSL8R ykTmEACVfCXHja21qyDqQwAh/NWd5DTgVWiXdQAkjxYLTugJPYhqWsZoNflPTmsvENGp2UIPrUH w8F5BmRPMl8vP1RcBdZ0sIqL/vKxgWWhmVR4v+jMr2jMF2/6FKDDr42zq6/7w2jdrPZEsbw6KFG CsJK/qTqwChVK9tBczbIVfC4Jway9KscYDPK57v2DOuKKSRhwAn7ECrC/k3eBviST/jtSsFcOu2 OIk7kvHJ0boEFO+2LhK/QWurhEI2+2p4hks3I7s8m/A3lapsguyLjGeaY06zLrt45qSrAY/pWHw 6BMbMpgKnjp9rvIQzzPojn8Emub/wfq1OEiV0RimYxMj8tjcADxgAUTW0Eh4Laf4b+pfJ6//NnT tXyrjAUFUp+bp9TkJKvX2isEgy/IHmw779HahDj5uI+tXNLMwjj92WSzH/zzJsK1L9gl7z5VUOa UvrMbXa9R3ZRXSBP6UGxoaa5vDLqvF6LW7Go1naW0P7AKIEBtaGW48z7075+kaf5mXggmTfdMHL pbvlCXJZGna1BiDxWjh8vLOXAg3cC8vStt12HcNPKaJXhbm2pL7rN4pEPJrTAITQV8+H1dTROwU ypZwaR+pzuU5hrieUe1sa4n1RFfkrj5DVIUDZ99jcsmwyniQd0NDqrXZhSuHef4R1iOIhvvhCRQ eugyQbqPR6p3EAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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


