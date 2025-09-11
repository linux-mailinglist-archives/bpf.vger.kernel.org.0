Return-Path: <bpf+bounces-68066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE37FB52573
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 03:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37C07B3532
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 01:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9401C7012;
	Thu, 11 Sep 2025 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWDd08YM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808613777E
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552695; cv=none; b=mVgkaZEk6V0pxtKbhpK6Nd+yiKJ4dbeLiO8V6EM+fcjw5Ki+HEDZQCaEqOggQJ4VZ4qYgiLdBoJc7rtN0e0B4CBUmJeWmskbr70KjrZUWePqGEv4Gd0RnyBHZsK+wK0mo2jwxBcc4pPH5H7mGaRJ06QDldX3qP06EPaIGaqRm4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552695; c=relaxed/simple;
	bh=8oexrrPLziSxMjC9kJT7jcz590GKUanSErZp0nJyyBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZekrXqlpwNWsNp6GACPtYF7Kdq92BPjgfV1ruoqY/Jv1QOhM70Aa+4Ge9TcPBVmvMw7u3QbEJpXMCj1xwZbPjf66RMdoPAt/0cxEVfVMWBJ6cCB2e01jyL0HbwyHnIvSNIbtg0krF0EqjGJaZSCiwxumMSRW/er3JQm1+ivKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWDd08YM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32bae4bcd63so108349a91.2
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 18:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757552693; x=1758157493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIsx57oCMGkRnBKyJHE1gFqG1TXN/ihd2Gk3iaXVcTE=;
        b=LWDd08YMJdcpy5dAzJLxCoYyiHUZ8htG1JuK3hyAkLQ/fYMA/Yf6+S9tvBsbA6kDxr
         /wbKWTRxTz1ODZNkkiD751sKUkyyBgF19Vj97o2cmK32tpiCOHup9t8xal7c/6f/2vbz
         CXsPy4qDb/steyPvy7Ij40SFEiO8bQo4lPVsjE4gN7hjPY+QH+IXB040L+FNtB9FN4ym
         X5Z8tya1KgglbvsOTrY7+YZy9nSivlAjwpYmWjcEwAYS8Yd/Sy7xnEMXOsJvpqcT44KL
         9OR50qY1TNZMPYyK8rrIHyQe4im2/cjjefCt5zxTcfszdIpZGvWoI/ff935qtTA9g9Ix
         dG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757552693; x=1758157493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIsx57oCMGkRnBKyJHE1gFqG1TXN/ihd2Gk3iaXVcTE=;
        b=c/JzHo/9xo7/N5tVn9k3AU9kaAhsYrDMIugBrBjvsK1sSgHU1MwQlkY5F6AvES8h7v
         ONWXiUXYtWNmAriRUiyLXN63yEvi5nk9JFiP6wn/z2S5rU6MpsBeYv8C1gMBzMeel5BC
         OmsWwVp/YKSgMKyex3vUa4L+K6TaYXUR2Tws/8VTJFqaN6dZLrcFvJIKQwYlj5hhZTq3
         /tqqtN66NPoHqNSR98UkBpZgCkjBdgU4BGpGUOkXRHi3IRnDpANOUijznwKDcjJgN3rO
         sDhV69e2RqbbztL6N9vPRffA3XY6jvB9zDqEdtn+K5JEZcbcEMCOr7FcRpsE+RwM0cAU
         leKA==
X-Gm-Message-State: AOJu0YwwFk8rCwcvrpYXI4iSbt3TisVzYzga3NPATBKfsmN4VnWvN+6c
	XUt2t7Nl46Rc2muOXQK9ibqJdiDM8pJ3M0fdGCqsQ0bgIThKI2TWZvzJUQuNmw==
X-Gm-Gg: ASbGncuh9k+lHm/aRvQYGnwL7qDVboao5/d9AjCyLCiHL7dfjfJtc+GbScIljnWCOr0
	mMYmf6PkIWe/j7PJOGJ+qW+aphrx2E48J70Tf4DtOQHmKpc1p9sij8QJkC7irgF7cGkJg0oizGF
	e/R95U/9stMo3Fpi00Xvmtudho3EY03qCKWrhbIZvgZJifpHxJMPKGmXwIe78xEQVuPVZEvvoYa
	qcWwMNw4Zx/LZrzfnvZdfS3D75modPe/mdxpPjbkzrdIFsuE3gmavmzjwrYbEFrZIpnV58lKjF+
	ZaOeumqHHCnvmi+zKsxZI7Xtx7ZK3RZQl4qrggNL4uSPTZuh8F9kqoEW4d7UH5dHA+O0pLXk4X/
	ht4hCJtfUuhNvNJjMhWm9/lRUtxjIQZ33gxFQBVhrGP2X
X-Google-Smtp-Source: AGHT+IFzOE4LGpFMMPD0SWaO9KrUsetnEAFRZW0pRyqAfG4eJ9QZ9bIsDpSz/n7lD9UvNQpzxIJbGg==
X-Received: by 2002:a17:90b:2e84:b0:32b:a259:d270 with SMTP id 98e67ed59e1d1-32d43f8241dmr20910347a91.27.1757552693368;
        Wed, 10 Sep 2025 18:04:53 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa27sm545511a91.1.2025.09.10.18.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:04:52 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 02/10] bpf: use compute_live_registers() info in clean_func_state
Date: Wed, 10 Sep 2025 18:04:27 -0700
Message-ID: <20250911010437.2779173-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911010437.2779173-1-eddyz87@gmail.com>
References: <20250911010437.2779173-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for bpf_reg_state->live field removal by leveraging
insn_aux_data->live_regs_before instead of bpf_reg_state->live in
compute_live_registers(). This is similar to logic in
func_states_equal(). No changes in verification performance for
selftests or sched_ext.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 46a6d69de309..698e6a24d2a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18460,15 +18460,16 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 }
 
 static void clean_func_state(struct bpf_verifier_env *env,
-			     struct bpf_func_state *st)
+			     struct bpf_func_state *st,
+			     u32 ip)
 {
+	u16 live_regs = env->insn_aux_data[ip].live_regs_before;
 	enum bpf_reg_liveness live;
 	int i, j;
 
 	for (i = 0; i < BPF_REG_FP; i++) {
-		live = st->regs[i].live;
 		/* liveness must not touch this register anymore */
-		if (!(live & REG_LIVE_READ))
+		if (!(live_regs & BIT(i)))
 			/* since the register is unused, clear its state
 			 * to make further comparison simpler
 			 */
@@ -18489,11 +18490,13 @@ static void clean_func_state(struct bpf_verifier_env *env,
 static void clean_verifier_state(struct bpf_verifier_env *env,
 				 struct bpf_verifier_state *st)
 {
-	int i;
+	int i, ip;
 
 	st->cleaned = true;
-	for (i = 0; i <= st->curframe; i++)
-		clean_func_state(env, st->frame[i]);
+	for (i = 0; i <= st->curframe; i++) {
+		ip = frame_insn_idx(st, i);
+		clean_func_state(env, st->frame[i], ip);
+	}
 }
 
 /* the parentage chains form a tree.
-- 
2.47.3


