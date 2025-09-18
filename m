Return-Path: <bpf+bounces-68846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC01B86840
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CF117232F
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B0C2D3220;
	Thu, 18 Sep 2025 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpIaDHWv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B842D543A
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221295; cv=none; b=jopymsqy10UpGGXmaEb8SJNtxCRMmVrKr3ExssE5E84ardCEvEiN9TaJB5elMb1Ko1JXOc4ipbspQzP31FHrUDrbO7ujAosCbmYQ2FyqyLMKq9BIoP7wEVHyIt1oPBz0SqfSILni7HCPMdn+3fu+Ne8VTQSLOghcKoqT92i0+iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221295; c=relaxed/simple;
	bh=nYl3oUpagw5H+THW0gqCnuAhIUp1e3lIoz3cftkMV1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6VdlokV0vkMhFsMUpJA9oeuILYRXLhcnR8lnz/dPukD9G1gby3xS+CIpGcn8KN9+Hf8KIkPhnU2Ng/uLJEsQ8sggos60rGF7Nh2r0OOYCGgEWxVOh/8+jCxDtQyKY27DE5SWin8/FCY+mwl3jhQ4o9UMCtLgXsKhtfdqkQcPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpIaDHWv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77da29413acso944449b3a.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758221291; x=1758826091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+ldU/i6XENRWgYFMzfmVtjBrGof2U+GAMGvfwPFbGQ=;
        b=mpIaDHWv4ZV4n2jqE2p8r0VylS948+O5cSGXgluI0ZyTdrPg/0jdsW6d5AZut41A4H
         X5pEaz2jAGZ59bMeMgrAiUH59sN7czNdIE2rf9uKvXnpH0cg+6iSRHKhVJwS0cXtn1yo
         TQD4mcXPqgDmGBjo4FwvUMjZkdqT8H7YZs8HR7bW+/7QbZUgJDbbB/43N8DKKa2SlrGj
         hek64uqAyAt5IuBnis+wcOSv0m8MeY+XitiHmcZfTHJo2IPpMSLsabSLHSg1Seq3Fvcu
         7WB6f1paDv4E0RaYpJHem4IsFMfPzQlbxDrN/7U7qCCizSms9GC7xM7igikRl6coM0nR
         nRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221291; x=1758826091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+ldU/i6XENRWgYFMzfmVtjBrGof2U+GAMGvfwPFbGQ=;
        b=mvjETFXHQDzV0BDnabRvryvJ/mOpdp9E9vUeOBD/I0c1GUdRV87OH1X9Ysh7eJ3mCE
         5nmVC3xgaKEi2FUVdVKYn0XW+qP/wHVABfYV1jZr8APdcvMdZxoClIy2o06txJSLtQJ/
         63h25k4PSBaZ0IbSFLx2aWmLYxuRmBYK1x9n86YpogvAE0IXZ8HXZdGe0L1FmGQ2gghT
         ac15eQdUyqgDvYgkpnr8Owh9w6yEYRHjIr6xokYSMXHBhylI1xNZ0BjX0I1iVWheb15r
         TDJ86W4JPvh9rH6sDfjKCdeee3PbExEqAmfoZBZe62gn0q8aHJll9PwnUD9hhGyCFIRy
         3tRg==
X-Gm-Message-State: AOJu0YztX5dGl6FP254feakSs/sDB33HcwCA83GO+v3DWWfoEPNb9Oov
	7/arCclUeKwFUCJksBmD7NqBy1V5e04yLUgeNCtmfdD6XNkTQmoANR/g9ROuMn4V
X-Gm-Gg: ASbGnct/2SBGtugBvWmFQTDHgF/90x8NEx/SdRY9BuiTAK0JjnDg7y1p/auWh8CzLLt
	WEagRrgu/1T3CX2gXONshRuCH5R/ElS+2s+nCpXCOsYMZydpzpszZaJnG2g5rMjZenJ8i50jZpH
	Ib6pza78dwx1Q4GIc+ZxxboyLIU07PLprFtFOwJY3P4d/O4W3Pw0g8tNLAkVMbsnbDN8JQqJtGI
	K792RmgyD6fKN5gE2ox5nuLPlvY0pVUI5nzS/uXH6dPGh8oATeaefkhH9owscVlPGVayLRiIiq/
	DyxFYJWTmTIqMgp05hdPDVIawGn6BaAx1z/HyfPkLONmGlBuUOdF0/wOFMgTil2JHhLycLisWzX
	HVZoXCXhIMT0X6errg5uQBnHkV9YqIai7bxQ=
X-Google-Smtp-Source: AGHT+IH+7pWYlOFDsZFXnrI3ZbHApvTCWHEygcjPxx15SF0zWHYZ4uaGt+DhWNcFNA6fqY3ct6gUxg==
X-Received: by 2002:a17:903:1b2b:b0:267:b0e4:314e with SMTP id d9443c01a7336-269ba478156mr7898535ad.23.1758221291472;
        Thu, 18 Sep 2025 11:48:11 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm32361505ad.90.2025.09.18.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:48:11 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 08/12] bpf: signal error if old liveness is more conservative than new
Date: Thu, 18 Sep 2025 11:47:37 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v2-8-214ed2653eee@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
References: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Unlike the new algorithm, register chain based liveness tracking is
fully path sensitive, and thus should be strictly more accurate.
Validate the new algorithm by signaling an error whenever it considers
a stack slot dead while the old algorithm considers it alive.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/verifier.c        | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2e3bdd50e2ba46040d6806a0b6ac18124fcb6c75..dec5da3a2e59dc22ef3cb60407f82267cf5a2c61 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -852,6 +852,7 @@ struct bpf_verifier_env {
 	/* array of pointers to bpf_scc_info indexed by SCC id */
 	struct bpf_scc_info **scc_info;
 	u32 scc_cnt;
+	bool internal_error;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index af08cc94c3b053e417d59c83aec108ef2ef828ef..6b327cd25b1afcc25453bcd15a0f347658b93fcc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18551,6 +18551,11 @@ static void clean_func_state(struct bpf_verifier_env *env,
 
 	for (i = 0; i < st->allocated_stack / BPF_REG_SIZE; i++) {
 		if (!bpf_stack_slot_alive(env, st->frameno, i)) {
+			if (st->stack[i].spilled_ptr.live & REG_LIVE_READ) {
+				verifier_bug(env, "incorrect live marks #1 for insn %d frameno %d spi %d\n",
+					     env->insn_idx, st->frameno, i);
+				env->internal_error = true;
+			}
 			__mark_reg_not_init(env, &st->stack[i].spilled_ptr);
 			for (j = 0; j < BPF_REG_SIZE; j++)
 				st->stack[i].slot_type[j] = STACK_INVALID;
@@ -19521,6 +19526,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		loop = incomplete_read_marks(env, &sl->state);
 		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT)) {
 hit:
+			if (env->internal_error)
+				return -EFAULT;
 			sl->hit_cnt++;
 			/* reached equivalent register/stack state,
 			 * prune the search.
@@ -19635,6 +19642,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			return 1;
 		}
 miss:
+		if (env->internal_error)
+			return -EFAULT;
 		/* when new state is not going to be added do not increase miss count.
 		 * Otherwise several loop iterations will remove the state
 		 * recorded earlier. The goal of these heuristics is to have

-- 
2.51.0

