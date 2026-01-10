Return-Path: <bpf+bounces-78464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E56BD0D708
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 15:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CABC3037893
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52370346A0C;
	Sat, 10 Jan 2026 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajndF/ju"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EAB34679C
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054313; cv=none; b=WYzSur2HzWzzN3LDe2WOidodYce52En9Rg4P5FimcrxMnPFvhOU/b3PAUrlJrBSqqoRB1AeDAZts9+xnOxU4vNoKoT7Ydgr36tSJ7G9eEOnTJoMBVZfhjwkcM2JnHhwDeXGKWsw71Zwt41LWNGldsrSMClQ1xkaOpWQs5u93HCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054313; c=relaxed/simple;
	bh=VhBBi66SFeKXbV7OJrrw4WoyPdDGNe3BKHOh9sdreXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAvsK9ByA6sKOeRNGLnaGNlYHqox01N1NEiM0Hibet24AbqvOwoi/OHJ1ik6iZpKo5XS2tbfucndMnc4JAi/KO7jsKPN9OEgM7whrzd2IXSTmlKvYCagPPOJRV7yaGqFOjtCN+rnR8kKRzhQPaepD4+naNqgChMcq45bP2DksUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajndF/ju; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-81f39438187so316959b3a.2
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 06:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054312; x=1768659112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjkgpIcKhjQZAa0EelYk21O9foZl8TfKrOJc4gFivFo=;
        b=ajndF/juubjoXgwPw1K/ojOEDD0b+S/fG1O6tRtBcbyT2GoMRVvgCZwVkVlrD7xeCj
         Vol8PTdD13a+ZR5VE3wjMQ2b8H+qGVpJw+gx5O0ooLNmg8/d90atIunlRyOQ0RYpq3dA
         KDu01ut0hybmtRbKy3knnl4NgfqpGz3cbvKc9C/5Uw1ezeQe1Oy5zwdmh9PqiuTl3Tqa
         xg3bUqI6nTh1dwNfTdg9M5Z41dPNUgEBKl/zv7OzJ4qrmSwI0UQjeaz0BHiS5feKEcPK
         AIHArv0dnkviIflK/1UlRZu+e1IJB02MxG29wVXPcvSWV4tOyfrXQ2YU1N91AeXG2/w9
         /06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054312; x=1768659112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rjkgpIcKhjQZAa0EelYk21O9foZl8TfKrOJc4gFivFo=;
        b=tOKj2yNYIUnZaZ/6BTce1CEF/f8RxU3KUGOfnJyiWJMutnC1yHqBI//c8RX3xPLs8n
         hbWvY/VGcR50CBscqXEeUpQKYkyyg0xpUSRb1U49bv1CNAidS//AqwRhzCGXgikQJosU
         XV+BfKCyoEt29iR8676MHG5AWk1XZ8CV62rZFOi+BBAaNhPUHqw3UgWqZpIx9M+xaRX5
         fywK/UjHtzqO9+xj2Xt4w8r8+Vj2sn0ZCEKi1kDpeIcMQXjORazKuvHKz38MU/R1EgEy
         cjs1soJprv4KJqPzwZB04OEn2FOzcs6tsurImuWpzoVXdux1fcSZwooUOjYLz4xrqWud
         KT6A==
X-Forwarded-Encrypted: i=1; AJvYcCVa4w70JypNINrKGuQ9hgFfVQOiN1sV/KQIUFmtJdYOZaN7Mu//pVhh023PUG6I4JDJP4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze2u82TS5r/uY5b/mgEhHsBT0W9LBD8wuY3l9XQLEDJv1V0XyF
	hqVU0TkbEn44qqj/3klrPY9VtPJSIzxvh2jIA9qG7LhQ1xSPGlrSnb0XgSoPTAlT/zfhrA==
X-Gm-Gg: AY/fxX7qjETzlGUgHNsydNGkeovY21zr5hfQsaI56rYI1UkiF/QmJFg6/ADJjSvNCV6
	D8nAQKMDrUMVK9D66K7u9RWDvsl086vKV7tGWSx/oWttSWox0vOFCjs9rG9mJDsSueJ02TZVNOX
	JCJ7N3lldSqanfT0WmbsErF4DrDF5u3jeTOAJzcm1gXmQ8jG8yEgtu/BPYteytRN4jsUnYur6np
	1XWUjVpCr0T0rbdN8FYe8FYTydqwjs1A85R6WvcHcjmhEWQdcvAZyfkWGZqgK1oq0UgS0I88zxX
	DW0rw5v6747We/kKYI9PVem0OcUikUX8v5Tj6gHd2vhpZ2f/KW6+EvOikbztHQCr+uXHKIPDiou
	y2/MuFdoNQH2T4xEJi8zo34t+hbVyMdCU8q6kByjTrU4l72LG29vHh17Hie9H5IMImI8inPDjjY
	EMv/pkT9I=
X-Google-Smtp-Source: AGHT+IF03SXJV4ZyzcbP2okOtd6Y9ZpGDEo0yivf5cl39rEI0EE+f2l48zo7+Cf6AdRAzuVFCKfH5g==
X-Received: by 2002:a05:6a00:2f50:b0:81c:717b:9d3b with SMTP id d2e1a72fcca58-81c717ba569mr6481986b3a.47.1768054311673;
        Sat, 10 Jan 2026 06:11:51 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:11:51 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v9 02/11] bpf: use last 8-bits for the nr_args in trampoline
Date: Sat, 10 Jan 2026 22:11:06 +0800
Message-ID: <20260110141115.537055-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110141115.537055-1-dongml2@chinatelecom.cn>
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, ctx[-1] is used to store the nr_args in the trampoline. However,
1-byte is enough to store such information. Therefore, we use only the
last byte of ctx[-1] to store the nr_args, and reserve the rest for other
usages.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v8:
- fix the missed get_func_arg_cnt
---
 kernel/bpf/verifier.c    | 35 +++++++++++++++++++----------------
 kernel/trace/bpf_trace.c |  6 +++---
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 774c9b0aafa3..bfff3f84fd91 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23277,15 +23277,16 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		    insn->imm == BPF_FUNC_get_func_arg) {
 			/* Load nr_args from ctx - 8 */
 			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
-			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
-			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
-			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
-			insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
-			insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
-			insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
-			insn_buf[7] = BPF_JMP_A(1);
-			insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
-			cnt = 9;
+			insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+			insn_buf[2] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
+			insn_buf[3] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
+			insn_buf[4] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
+			insn_buf[5] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
+			insn_buf[6] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
+			insn_buf[7] = BPF_MOV64_IMM(BPF_REG_0, 0);
+			insn_buf[8] = BPF_JMP_A(1);
+			insn_buf[9] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
+			cnt = 10;
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
@@ -23305,12 +23306,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
-				insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
-				insn_buf[2] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
-				insn_buf[3] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
-				insn_buf[4] = BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0);
-				insn_buf[5] = BPF_MOV64_IMM(BPF_REG_0, 0);
-				cnt = 6;
+				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+				insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+				insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
+				insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
+				insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0);
+				insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
+				cnt = 7;
 			} else {
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, -EOPNOTSUPP);
 				cnt = 1;
@@ -23331,8 +23333,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
 			/* Load nr_args from ctx - 8 */
 			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 2);
 			if (!new_prog)
 				return -ENOMEM;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6e076485bf70..5f621f0403f8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1194,7 +1194,7 @@ const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
 BPF_CALL_3(get_func_arg, void *, ctx, u32, n, u64 *, value)
 {
 	/* This helper call is inlined by verifier. */
-	u64 nr_args = ((u64 *)ctx)[-1];
+	u64 nr_args = ((u64 *)ctx)[-1] & 0xFF;
 
 	if ((u64) n >= nr_args)
 		return -EINVAL;
@@ -1214,7 +1214,7 @@ static const struct bpf_func_proto bpf_get_func_arg_proto = {
 BPF_CALL_2(get_func_ret, void *, ctx, u64 *, value)
 {
 	/* This helper call is inlined by verifier. */
-	u64 nr_args = ((u64 *)ctx)[-1];
+	u64 nr_args = ((u64 *)ctx)[-1] & 0xFF;
 
 	*value = ((u64 *)ctx)[nr_args];
 	return 0;
@@ -1231,7 +1231,7 @@ static const struct bpf_func_proto bpf_get_func_ret_proto = {
 BPF_CALL_1(get_func_arg_cnt, void *, ctx)
 {
 	/* This helper call is inlined by verifier. */
-	return ((u64 *)ctx)[-1];
+	return ((u64 *)ctx)[-1] & 0xFF;
 }
 
 static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
-- 
2.52.0


