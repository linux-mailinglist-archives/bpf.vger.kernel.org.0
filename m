Return-Path: <bpf+bounces-77770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BA9CF0EBA
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 13:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 642D7301DBB4
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 12:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342492C2356;
	Sun,  4 Jan 2026 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+7mtTlJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8E23D7DE
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529742; cv=none; b=bBMLqtp9tT/mDyXszyS20Iy09GFMe6OV7RmSu7w2ZP7Yze9Fj+bNPaAUSf5N9rXesWLAk5x8XBECOHpFRwIqUaJhGG2HRBRU/AP90hyCEh7PTleFhrcLPvR/DhFqfy8xsQPO1alDVnI6iijlEd3qaEBXle2Yi2E4aeRtdoHbO0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529742; c=relaxed/simple;
	bh=pAETjXWpZpYYNO3eGlGRlwZoeWkTRREEUUQ8BUqcr3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIb3klFH1924fWUZ3XenZaLvkwBg06GZzjC3iP4HGUjbza0jsQihgcaWC4g39dwtlQHxaFOFB8ABzb1QFNlhS3sOpWngQbBjPKzz2nZUjWVSBUkGKgUaPXwWxPT1ZgHfL3dRggnjqJfy0W8KLSzQKgJ+W1NjHHyLL4YYzSfzIO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+7mtTlJ; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-787df0d729dso103949727b3.3
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 04:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529740; x=1768134540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAXKhyEP0882HZb20YoTIK/vIaotqaiLJ/ObnPk+VWU=;
        b=U+7mtTlJsQDj7lOOg6L2UQjye3cFt23PqQGCRDugBvM5b19QcUmf5BGSGx8XtN6+qB
         2o4ImtO0H/YnlvpB88+5qZoSweNEnzIdXORxY8KZNn1HHyGq2K+Suv7Bl+ORT9af6Xz1
         XmiW5bKYqobRf6PcR1idHdH2Gc3+MQ60jOrG9QF/VJAkuHvJbMbZnalI/f+v198DWco4
         Q2H5KY4RWqtiu9/WjWj6WV6yeFn+MECqMOTqHIrcNGlBnrpjrI65mhJNZyum3A7CySjB
         KJ9lAvoQzO3hsH1CmMMzJ6m34jLYT6pZyefWT90wRsY4gCsq0li77bBNOnhQPRR6JDZC
         ZHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529740; x=1768134540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yAXKhyEP0882HZb20YoTIK/vIaotqaiLJ/ObnPk+VWU=;
        b=h/bTgFB9GwWW0Wn6BIK+MIyoqUHIOETRl3Jr5j4RdCFzpJxxkAhLQ00yu7IiQCIbYA
         J3hLtKai69UNuozRLRyuscdgeYVfGVoKC7h7f6NBw8t22SU3hMQUL6VOraNKWvEQJuUc
         ia7ePh4KqcZju+ruxX70nusX9+4KpZLYmS+BuWTM107NXjErllqxGhCophfZ2SemcLaj
         ysx5sswyCKsS5MTGdSOvRmcyPFAo6g0Q4FOmmzqKlawCt+UhIp06EkDj2erW3FF32F57
         RdCKjlpY03NIx8vvJAM7lKzZqEU2E+CJ5HMq1RBo1d7cH++I5hxcTVXIgk9rdfwbYHqN
         Q5gA==
X-Forwarded-Encrypted: i=1; AJvYcCXM5F5RxMeSZlTMvixM0x1ftSMJUnjfFta+QrcDEGuAtf4q73hQ4eFz5lmTX0OoB7TTKPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjFnqaLapni1i3FVBxcJXcuv9AJRaBzCRoDn8+E0liMKwOBkmV
	r0cQAq1N0leAAqTGpDIxzcDHqSGmfVg9/0miFTknV3/VyEe+bxVodTNl
X-Gm-Gg: AY/fxX6Bvb5cWHJhnMB9eLJQZVdgVazzufAKllE2+qZRWHRZUQ2w81o1A7b2cqPxZwC
	amGc+HIkHki+nvRiBhzJD30PcODDW32ukeZ0c75cF/42E/Z3GkC54PRa4+mNepWSKxrgHWUJza+
	y1Thv6H6XKnv21QWnunY8sBx0dQdQ+PMvBnjklPuiYhGNe9Ln9Aw5GpW30BW2wzjud6PqNSThNG
	fiSxHU69x+kQJWg8S883TBUOWFdoDPIIhK1WM+gwrBchdTIeF+RN2whrll5mrppEQK0Z7/VnSJ0
	3b8Sfa0SldVxNrwq6ha92+Yd1tM9YemgVG/6I+1+eb2n0/i7/AsdwM7+VX8PCd1lgnUC58Ps+Uf
	yDMyBeisiwYqQcOiVWDzK3gQej0vg63HeGNeQaIdPibLbiAD8Kl6cyV4RSHfK5ApTgS0ES52WLC
	TVI9ev+4E=
X-Google-Smtp-Source: AGHT+IGEUgq48tppi2m6NPzTsxshV9CUixu/YIdrRgAr0ZCZbEOXwj8vabjB2KTFArscytze2Urwfg==
X-Received: by 2002:a05:690c:2607:b0:78a:27a9:d471 with SMTP id 00721157ae682-78fb41ddd3amr363530327b3.69.1767529740002;
        Sun, 04 Jan 2026 04:29:00 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:28:59 -0800 (PST)
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
Subject: [PATCH bpf-next v6 02/10] bpf: use last 8-bits for the nr_args in trampoline
Date: Sun,  4 Jan 2026 20:28:06 +0800
Message-ID: <20260104122814.183732-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
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
 kernel/bpf/verifier.c    | 35 +++++++++++++++++++----------------
 kernel/trace/bpf_trace.c |  4 ++--
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 73bbc614b30b..9e7dd2f0296f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23267,15 +23267,16 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -23295,12 +23296,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -23321,8 +23323,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
 			/* Load nr_args from ctx - 8 */
 			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 2);
 			if (!new_prog)
 				return -ENOMEM;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6e076485bf70..6b58f9a4dc92 100644
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
-- 
2.52.0


