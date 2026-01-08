Return-Path: <bpf+bounces-78178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C77D00A77
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 03:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3E6D3009263
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 02:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C19271476;
	Thu,  8 Jan 2026 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnXpZC+t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641A230BE9
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839130; cv=none; b=ecYCuOrKbaI3BDo5k+i1MG4I2MTfYda8Dm/r64rNwT+wRSstlVVfGZMuCunmv8/P4lOU7naPpHKNQMJ/1zbnD+rbXGGnLpvYN025vCGX6sOIT3Xi2sXG2XlbC77MDvQDU9w4rBMy+sCwRgsEhPbH5lRUpu83MoJhqu+8vX/drDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839130; c=relaxed/simple;
	bh=VhBBi66SFeKXbV7OJrrw4WoyPdDGNe3BKHOh9sdreXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHzE/Cbsjvghsf8xiStEE3gZjGnBNPiJfcDgHtteyGAtfGTSOkoE3ERVHd6NF1FDznyP/+6BC+bCfzWryaxzDvhoGjMc+X7y4MXUc1fUH/3QnIobqEEB0QdcDydrT813pL5mFIt7TkVKPITsB+aFZzYndaNp35x6s2OBDzznNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnXpZC+t; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78fc520433aso30480607b3.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 18:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839127; x=1768443927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjkgpIcKhjQZAa0EelYk21O9foZl8TfKrOJc4gFivFo=;
        b=EnXpZC+tZWVJVIn6TyUS+mZD4Xyrsdah7+b/PL/ss/eaCKfyEu6HOnhT+K5mM5vf9C
         gdFjmSs5/y6GJiPwqp1RK1gSN8oYsYaH0RIHcQDZNexcR9bz93F3UXuGUWhqNnVPTZZN
         GAQapJeE8z7QmX3YHyvvxhzL+YeupiocPTav3KKvMmtpOznLdi2GFjq2kXEFATl6/eaE
         SjZ6xhY8D3+Q9YzX/DLmnJy272MX8cWoxqpIiQnXHdPLZnPVEg81ygk3Cn4VuDp6VUR8
         0KJQOtEX969+POO9qIXckycUMFHk3JHy0OyyLc/P61Wum073pH0wv6DtsumYOCchEnUi
         KuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839127; x=1768443927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rjkgpIcKhjQZAa0EelYk21O9foZl8TfKrOJc4gFivFo=;
        b=DZJ3gKFZdTTHjW4DPMur+E0oa0ObFTLcu8+qYC37nys3AhPzBnmb8UxD3u4cjm+uC2
         wzRYAhA2VORCcuUi+9w7u67rsMJsR9MPjOFs9uR0/XaJdvGy19whjlAjCN7lgEwQdSti
         dqkKIL1iYwYcPDNSm/jOh62IuGB/rm6/NlIRPH2QBB2WYZmIpvtCi8BDpe3ApGp+6iur
         xKf6XhQHQhhnQJA9JgQcuGc70rOXHrj4kBbneB1s3IZ7s3vexYJa0akJ7iN6NdVMww19
         L17Ne1I8IOmmoQJ7KpQt0wTSstK5gW+pRud/6/YhuXAWW7fkAMVkHc/VUXZICXLnF8Pi
         HuWg==
X-Forwarded-Encrypted: i=1; AJvYcCWl/kbR461XH+m+hlhAQ+aifbfH/zf8KvOwJccNwMiJ/vXWZxeFBTebdbxtmLINoHEuo14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7w0VRm8Q19DDBxlB3vYUAj+62/wsrApIrJCFvH01zpSiR7mT
	SjrmleY+0Ymzy1glQK2nV07fj9f0Evuua2OctDHnlJha1T202z31wWDtPZfWMVbFzjc=
X-Gm-Gg: AY/fxX5JYqvoOjT22ys4m85jE2MRicbXaCXj9JNqD1Qcjv7bdLmE6gN3myKtR0hGqEd
	gLf44KF5kV3DCxGebB9PFA6irrEQ1+2ztoSCNPcb4sEcpN9aJj3XMyF5vHMFaYo7BV+Dw501V1g
	qVn+LFr3s6HhlKr6Rv3n2+z3l+F0cZs9jSNMcgUggh2ld7ucGhzPkOuDSh4FSh/WHTRMhb+YbUT
	JC65SYJbk/aCdLLS011ZHtboW3GAT7rzlTCiVX9GY58T/CTUaOARQo/zlkOYRZWBbu9o/FryS+w
	YsB1SgUpbVaShLCd2GjRzhy53frR3bO6el4zJvgepwuZwARL1IsZW+ZSMb8ohqTAR4cnL0opV93
	PKh3jCU7cNp6lSgG6EDfnt6bi1vnshXzp7sOvGn+KfV9E5M5muhJJoMgexkCEPLOgIXfKjstyAf
	rVQsl4/j0=
X-Google-Smtp-Source: AGHT+IF6oe+CNyD8YMJskeioT2pg3/Psy/o0qTkXNquKhbC5SDD6nywKNBGuaI6KxZg9JJ5rrEbQ8Q==
X-Received: by 2002:a05:690c:64c4:b0:78d:6f35:bdb9 with SMTP id 00721157ae682-790b58250d6mr40899167b3.51.1767839127164;
        Wed, 07 Jan 2026 18:25:27 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:25:26 -0800 (PST)
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
Subject: [PATCH bpf-next v8 02/11] bpf: use last 8-bits for the nr_args in trampoline
Date: Thu,  8 Jan 2026 10:24:41 +0800
Message-ID: <20260108022450.88086-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108022450.88086-1-dongml2@chinatelecom.cn>
References: <20260108022450.88086-1-dongml2@chinatelecom.cn>
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


