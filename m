Return-Path: <bpf+bounces-4897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD91D751655
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D002812D2
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0EB80A;
	Thu, 13 Jul 2023 02:32:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203337C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:32:48 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94A21BF2
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:32:45 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so141409276.3
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689215564; x=1691807564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7CFuBvLEzgoeXNGKBAKHCvnxcWd+kgd7MmTjG5s2D8=;
        b=jrnC/1I0UKGSK3cPvRtyKi4QmVheYwiww6nr7QrRT1Uz13QnjxBLwsEu/1dnP9wQZH
         MBcTeKu5hr9T7VCPraZxDmhHpFHivDpEFvNrFxxiT6w9foCNNGNZtiMIhAvNGPck4dIm
         z2YEPuLERtpXBKpZ0GAdzMd2a2BpFXnReTrE58M2EfVUG2E0DyoJW43jwuRKFr28M3bS
         voGseRJ+hvv+8rbOauNHPYKwxGJfpY9JmB5n3A0n6V3QEouTGXXAbHW1pnBDdFCo5SZT
         x2nlBxPXmwQYYc4uJ0ycpm4pOxVQ61KICJHs21laQN0XXU7yXk2K8dP1CK/BFIcLus9Y
         JwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689215564; x=1691807564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7CFuBvLEzgoeXNGKBAKHCvnxcWd+kgd7MmTjG5s2D8=;
        b=lTX6vZVxxDK8TEuNY6rFxu9whQeuto4EndC8NkgYUhkNygvlTxFKv+Ou6klp/Kmg61
         paCTLdjdOovOfHeyFtk6H6YUAB9qe7BMuhDdtCtUGObOpzN+TXuIXegbxvIVWHqTMRUO
         ocxFP3/Cd4mro450ICVyJYDu1JDS0vK0AIWDmjLewCDGws3QcQtXuj7896rQDPaNj02Y
         2hal24255kIY3vJk9SaLIYTNpP5LjLBQ4E6S8LFlLbsW8wlmB1QvySjecv7Ot8azWC/f
         5YmVfUfK3xRDz61qYYzAWkRUATFWlxAYnE5vde2Crj646iJ8ZJ8x7sFocn2Z70aZ3Oj6
         bOSQ==
X-Gm-Message-State: ABy/qLYoiDR8sQpAuSc3WLlBgakIfuG8uNW9LaZFEbjm1ynLLOnSi52e
	nLuCAyzEUMIvSoHOfkjiriotP+L9Mo2l8w==
X-Google-Smtp-Source: APBJJlGtf7xhlaZerAAesjbxO4whMVFhmRi3ENXH3OU5vPepaZrTFyqXoc/0Kf3XIgV5v/BitYFvDg==
X-Received: by 2002:a81:6e88:0:b0:57a:2f01:31d7 with SMTP id j130-20020a816e88000000b0057a2f0131d7mr542991ywc.1.1689215564249;
        Wed, 12 Jul 2023 19:32:44 -0700 (PDT)
Received: from localhost ([49.36.211.37])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902ed8f00b001b7fd27144dsm4673906plj.40.2023.07.12.19.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:32:43 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 02/10] bpf: Fix subprog idx logic in check_max_stack_depth
Date: Thu, 13 Jul 2023 08:02:24 +0530
Message-Id: <20230713023232.1411523-3-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713023232.1411523-1-memxor@gmail.com>
References: <20230713023232.1411523-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2367; i=memxor@gmail.com; h=from:subject; bh=RPkTRYnhwdzuzbsqrc3s4KbQ8tewtgot4zOvkFZAyCo=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkr2HG/QMVrIOSwbINJbiW5Hz++rUG4LQCSQvau /o2z8btvQSJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZK9hxgAKCRBM4MiGSL8R ysqPD/9maZGbdpebHpLUEiC8SZzcg6Eeg2Nrk5maSdjGZIWE7WHoVab93QbMvLjb3Vy3uwEnbiS T//ulJyX5+F9WnJHy+b2kH1s6QxpeheWWfBPFiNyvFnJj0kXN77Vm7iv2AzD0MaB0qUtf1MjhNW OHIfZ0JGLuoTlrrZblvWQWg14JPoVGU8L8mLy5y1wFXe6iwqJDABI42dSSaYwwrVcl0vWlY9Kdd NeAw94+4RmDGumpzOy/fIJUDpDtMkRLfwbFrCSBiFR/EP4bdRpMpM316OZ1lyt+ajv0whpas5ps CiZxzW3cu5ZKPwgDYm5JGUBxMc8/p5apY8hJ3H9BjzMIh4DXMu2vkTqL6sxEPtiQu9a3q46Chak zQosjpZwJgkLEP1yJiziCaezmw2moFThvE0ZrWpfS6t19Bjjef7ki9H83+ujEIyUSOlsA7lyq9U Jm4I2J0bn1qq3iA4DcZ02pJjrlPUlBLdIZUtd2U6rGxRGCJmkN5LgbSdOJyO1klFQiNUwUmfT8t /Ggqk17I+YmWuzGu+PTrG+lWSh9agdKakJKBOFI7fC5/zL7wsPXP/QQp1TC1CbsgeCeGhKWTevL apely3qUB7hAIeUDWwea1xw/LPlH0ZEmwGn5ZMG7hM6G/t4/fgrNeze3TRCORo45Ojn6UvbbIjG ZjBOomsKNIR8y3A==
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
index 7a00bf69bff8..66fee45d313d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5622,7 +5622,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 continue_func:
 	subprog_end = subprog[idx + 1].start;
 	for (; i < subprog_end; i++) {
-		int next_insn;
+		int next_insn, sidx;
 
 		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
 			continue;
@@ -5632,14 +5632,14 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 
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


