Return-Path: <bpf+bounces-78050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14545CFC372
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 07:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F3CD3065205
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 06:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B77527CB0A;
	Wed,  7 Jan 2026 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh7mszrr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A262765D2
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768272; cv=none; b=Ri2b9dFmemRdvIn1rhui8O0F9ZO5/CPhJ1jE0JYYPtvvFFFf4bU/z/mKgMB+qUY2ISXv/2xGSK7i5qaU8S9ul5LY6E1t+Ijk1blWbHH0O3DvpLxdsabe7iiam2dEOwhJcvDTPsCSgTSIVA8VCrwQS6vdm1AETgae/D9DOnHamLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768272; c=relaxed/simple;
	bh=EbBBNk9kjzjCpCFyzUPhaLcaT7PWrk79L08m4td2Oks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3+ghJdPcOF+XMhKpfNIlU0WTehOjeCXGy/VKzBcI2VRKpB4OrmdO9NzW3RDdOCcp9VMfIZUqOkQ5Y6ZCvDWhSoJofbqmAK0Qj56GW59YnBXwljfnLCfYhahP7FlvnJ7ZuPQrLcSQg2DhN01ZWTpH8BFSM2S2gtn6elaR+wALrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh7mszrr; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78fc3572431so20153337b3.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 22:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768269; x=1768373069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdnjA0JVYs9aBHZi1/ucW5h0zOp5BIw2WPSjcDUoa+M=;
        b=Uh7mszrriQxUn8Yx/NxY3n9dQFSmDeCRYIkMWATq67ENHU5HEExsTI+LTYHhrpD0ap
         X6AWNbkcwmuoworqrKB+wfXbTC/iqZPveiIGyBPgfWVB+niH5VKww6aFoaWgCikjBxR/
         zg3hlbzTat1XEK3PPJdPE8Qdlnk726gOVopnZukEyVolzz/Ii27wFeu+l7rcJocke78F
         Z2oi2tE03ApIdGa61EyuYiLR07LHGEB29NCikM39nPzAHTckUgAMSTV70ID80SzAXVUu
         1fa4eBObDq1K9j/T+9p8ydVq8n47bgsD30wvsgbjbP67JKstHEKixBw0KteTfBVDj+7G
         z6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768269; x=1768373069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HdnjA0JVYs9aBHZi1/ucW5h0zOp5BIw2WPSjcDUoa+M=;
        b=ieyXgRIyLL7KBfzE6cl5/PKeZ3e9arWYp1atcpcdYF0PPIJge/++oqePmPlk6XQGfo
         adVTDRvvYDyb+FJ87lMlMZpEY9Ks4b/zyfZ0WinhoWnCyZ/hXZ+dRwXeT2DT87chXkNU
         qikPpBvDYuLZHhRncS6JCABoqr6m8BWzJLfGfbdyMiRu5bqxX+o/tq9DGeAzEHYVWcDL
         I88BKCr+1XQlCa0n0tuQM12hzq7HljMe1Z2ogyxv4/1IjWdYtgQaaZkdOv+XsFMp6FG8
         cbIt6y1v9z8ZxeBA7sWXFk3+gLJmQ1D5Q/w/oRAHFFQ3AC+hdDrrUO11ERvPpjnwTMaU
         lrxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNFwZ5KVa2QAL2HwrQ4lLut2yKGuiSb9Nm7Et3KQTO/sJu1RoPbvnQ1F7G/zPcCIKUz1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjVqu3SGoCw5xMHhEGkk0/QkiDWPkZ6hMvZLZNgJ+RQPzL1EuR
	uHxaCkuxO5JlcM2EzK7cfIbFZ6oNsHq8PYaJ7sHZ65BlogYej9ubp+Ez
X-Gm-Gg: AY/fxX7FldzhR//ABHQ3ualKPmoH8vUb9fhXshQUYMNwKN4sFhh/DgClgVHVHkqbA+U
	6dIDfZ7ueVQZaCj9mZa9hO/zKUZAGRojVe12DLYPlt70pZvvRnfQjaUKQe5F6yZweA4IcAhskt3
	yjaEBKvs5h3sNLM5XBK5lRTLOeyuoSa9TTA/whUZ3bI48KF/T0x88x805iS85bwz15x2j0qsR3e
	KgXbUx0+xFkkQRNTtFD1iPoCL1Cv2CWueV+kyLPGXqHpc439Sq854CW6VBlE5togIdXtAovl+DC
	/SV8GU2bI2rET3F04b3HQf3MSPOUKtQNxS1tGUPrKmHxc9a9r4oxpYS1ssJNsQ7GmU5tIrPCw3Z
	OLvEOVZVfmZIb5XW6nD/Bftfmm885ktBmeKAWwmYi6HBMmJp6byI9H8f78Axyr+D852uNp73Ae/
	dI3xw082ztT0D6N6P2XA==
X-Google-Smtp-Source: AGHT+IGtpLcWrRf9dEL5zYfpkSx+azOFZX2qkU4sjke7yCn5rtEe2Z4uRMyu0OG3M8BUwRrkEfL/TA==
X-Received: by 2002:a05:690c:60c4:b0:786:6b92:b201 with SMTP id 00721157ae682-790b56bdffdmr16764597b3.13.1767768268814;
        Tue, 06 Jan 2026 22:44:28 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm9635047b3.47.2026.01.06.22.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:44:28 -0800 (PST)
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
Subject: [PATCH bpf-next v7 02/11] bpf: use last 8-bits for the nr_args in trampoline
Date: Wed,  7 Jan 2026 14:43:43 +0800
Message-ID: <20260107064352.291069-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107064352.291069-1-dongml2@chinatelecom.cn>
References: <20260107064352.291069-1-dongml2@chinatelecom.cn>
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


