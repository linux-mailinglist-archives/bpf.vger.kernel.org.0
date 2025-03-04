Return-Path: <bpf+bounces-53230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CBFA4EDE2
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 20:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3F57A8CAB
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 19:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E2D277001;
	Tue,  4 Mar 2025 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afsExNiT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D427264F87
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117849; cv=none; b=KYhSxmvzfB+OBTBxxkaifI1lC8U+QWd3HonSrYsk7e1L6gGugT6AaSkLOwI5pOstaC72Q0JsXiYbOZ18EBmXxzLrkfDHIgfzhdql5yxpbT69qNSOx5ZDctz33q5ahrb0FPbNaqva6ul7ttdu/FTEEZskxTyYmqSHsdG8NSHPcyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117849; c=relaxed/simple;
	bh=G9kwgp1XYHzwS4zv9hmeFHnK+OlbyYCUY0IKzyg1f9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dd8WbrduHZdSYTS7gIXJ4j0T202Tof1ptbD6SK3irSABjbeSzgSh3MebqXExNemLHSyx6jmkJmWJX87TCx0yjvIOt5xFHyxTjvQsyiew0qPlFue3LK+PMa0Nw0TqZLDUlyOM4m5o9GeG3CP1IZmyxp72MUbDu8ejms449wEtuMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afsExNiT; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so9749611a91.2
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 11:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741117846; x=1741722646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUKUKmhVLNzAt9Oxo2/kipJeEcV/Mmy5AU+trlWFn+c=;
        b=afsExNiTZoun/NH/Z5ctbCnQV122Niv8KOWlM6rvaYhdS4cgq6IT6tV6Elrf/HpQsD
         8mzdEVwuHsmeN2ckqFacwsY/kEYJE+rJgDZWTuKqd+pKrH3zH5TQUXGeeo3BH12FJy5L
         wmz8GyU+MrXftgjqtlhyni+ntYD5qMRcpVEQ/D06Tjj58veHlq0iOtVHPTEVqY1/CqqU
         1xX6DwNwgZFz5Rp5mkqp16FenOrgO1UirpEihaWI+BG32+jdfhDpqYg5yWmF8wOU+O9J
         vJ0s1mHLM+6KokVqgU2zIstwJBRKe2uQgqO5WPzLiM3fDvZ7fIP2DtNo5zMCsIqNEV3M
         3hYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117846; x=1741722646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUKUKmhVLNzAt9Oxo2/kipJeEcV/Mmy5AU+trlWFn+c=;
        b=E1iPl6crIIRG57JxDoDmmQW+AJeyPfTYOscbc5BRLERwmD7mSGQyDlj7xIIkxJoLoV
         omQfxrax8Uz2R+C5WkHOEfJd2FWHNvD3L2HIaO1g6viW6YPNFhrGEE7lIOuo6AHvQcnV
         9grBEVBBjSJmydChMryXyRYtRLyLY/KgdmXzq5PspX7B6Jtj7LLIImo4i9E/kHtS8Adx
         ILcK3KnPPdV+NYx+DmCfJwkoboOLKJ+rP88VVvLKigBFuSLnyti1eyqSvBtdIwyA9nFV
         ZLRK3GOR87KRE3f30EtjD/s2PtYSmdYeK+069r+dk2E7jJ4r3XhL34MAOgwAhlrlwpwz
         3iUg==
X-Gm-Message-State: AOJu0YwGYRFE+ehUCEl/VI43anCf90pn3M8ZSWhGuPdZOaS7Gbd03DY9
	wqwl5WVfMI7+i7cs8bVgD33b23QFK/SsAz93ut+2OHPxUrMkjyI1OJRVsg==
X-Gm-Gg: ASbGncuCpcEDtKSzbSUwUxy0FBgpLPOclg7rdX7wdU4+rnoSvYyMbYOI1xgi0OovLC2
	5mRWtxdHV23UGKjLApDxkGI70RcZWp/BMt2Sk856AnexcFEY6nQLxl8llFMrhvj0dr5qv7J02vS
	PCfNLuz0Ll5XdLE5snEJJBfPIdsc1VaB6ynNpHHiitHIU4LgBLzoq5zP3Y8LEzW+xlQ8W3DYMcE
	O/jZt/Xmh0gaZXXMyIg1gumjzMHJoGKYfldAz/aZw+GbfwCkccmIDoHiCA8xszkv12yVLMUHKQw
	xaMeq1HazatStpk0UcR2rCI0Q6ZRm9Z5Itfzlt4C
X-Google-Smtp-Source: AGHT+IG3mbLj+0oiX3T9ZEV7/Vm7Antx5pFfTehY4RojotdavNn3S/VcT95ApOd5lEz0cfOQgWiAug==
X-Received: by 2002:a17:90b:1f88:b0:2fe:9783:afd3 with SMTP id 98e67ed59e1d1-2ff49717547mr913944a91.2.1741117844743;
        Tue, 04 Mar 2025 11:50:44 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bc6sm98560925ad.126.2025.03.04.11.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:50:44 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 1/5] bpf: jmp_offset() and verbose_insn() utility functions
Date: Tue,  4 Mar 2025 11:50:20 -0800
Message-ID: <20250304195024.2478889-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304195024.2478889-1-eddyz87@gmail.com>
References: <20250304195024.2478889-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract two utility functions:
- One BPF jump instruction uses .imm field to encode jump offset,
  while the rest use .off. Encapsulate this detail as jmp_offset()
  function.
- Avoid duplicating instruction printing callback definitions by
  defining a verbose_insn() function, which disassembles an
  instruction into the verifier log while hiding this detail.

These functions will be used in the next patch.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b6664d0f6914..25910b740bbc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3360,6 +3360,15 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static int jmp_offset(struct bpf_insn *insn)
+{
+	u8 code = insn->code;
+
+	if (code == (BPF_JMP32 | BPF_JA))
+		return insn->imm;
+	return insn->off;
+}
+
 static int check_subprogs(struct bpf_verifier_env *env)
 {
 	int i, subprog_start, subprog_end, off, cur_subprog = 0;
@@ -3386,10 +3395,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			goto next;
 		if (BPF_OP(code) == BPF_EXIT || BPF_OP(code) == BPF_CALL)
 			goto next;
-		if (code == (BPF_JMP32 | BPF_JA))
-			off = i + insn[i].imm + 1;
-		else
-			off = i + insn[i].off + 1;
+		off = i + jmp_offset(&insn[i]) + 1;
 		if (off < subprog_start || off >= subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
 			return -EINVAL;
@@ -3919,6 +3925,17 @@ static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 	return btf_name_by_offset(desc_btf, func->name_off);
 }
 
+static void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	const struct bpf_insn_cbs cbs = {
+		.cb_call	= disasm_kfunc_name,
+		.cb_print	= verbose,
+		.private_data	= env,
+	};
+
+	print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
+}
+
 static inline void bt_init(struct backtrack_state *bt, u32 frame)
 {
 	bt->frame = frame;
@@ -4119,11 +4136,6 @@ static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
 static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			  struct bpf_insn_hist_entry *hist, struct backtrack_state *bt)
 {
-	const struct bpf_insn_cbs cbs = {
-		.cb_call	= disasm_kfunc_name,
-		.cb_print	= verbose,
-		.private_data	= env,
-	};
 	struct bpf_insn *insn = env->prog->insnsi + idx;
 	u8 class = BPF_CLASS(insn->code);
 	u8 opcode = BPF_OP(insn->code);
@@ -4141,7 +4153,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
 		verbose(env, "stack=%s before ", env->tmp_str_buf);
 		verbose(env, "%d: ", idx);
-		print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
+		verbose_insn(env, insn);
 	}
 
 	/* If there is a history record that some registers gained range at this insn,
@@ -19273,19 +19285,13 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		if (env->log.level & BPF_LOG_LEVEL) {
-			const struct bpf_insn_cbs cbs = {
-				.cb_call	= disasm_kfunc_name,
-				.cb_print	= verbose,
-				.private_data	= env,
-			};
-
 			if (verifier_state_scratched(env))
 				print_insn_state(env, state, state->curframe);
 
 			verbose_linfo(env, env->insn_idx, "; ");
 			env->prev_log_pos = env->log.end_pos;
 			verbose(env, "%d: ", env->insn_idx);
-			print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
+			verbose_insn(env, insn);
 			env->prev_insn_print_pos = env->log.end_pos - env->prev_log_pos;
 			env->prev_log_pos = env->log.end_pos;
 		}
-- 
2.48.1


