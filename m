Return-Path: <bpf+bounces-79023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4170D24290
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 12:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 592D1306CA52
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 11:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F084F379975;
	Thu, 15 Jan 2026 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8vHIxeC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A146374171
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476232; cv=none; b=W9D2MIJ+RUr2xwaO2JEnQWqh1FMe9qBLpVuT8WShtbElGWRPwO4rTzjlG8/CHhDTUjJDTYoDeWCCiZG13KkdGexC8jIjSI24ZHyzNveThxLGZxZBYvZMAkakyczzgb9ccqWHsEqhRLLjb9JF+413RdQr+HkwGfyf+LISZb7dmGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476232; c=relaxed/simple;
	bh=70uxJsBQdJTCq6o5pWVjXSAUli/F59boJa8Lmi5oQQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEU6OdFs0oGLDbY/7ulvrpEXNDqDviXpvKPgaNg+Ya1PAIoI9oet1UAtG9DYddyg8wSRwktj9z8pJdEMLPBn1KElN6G54n9x8vMFyixboA+jl3LSqb9m6AIx1wIt9F7D5ICY1HRa7AMk3YNZYB/J+3mTGppfEURlLBMMIKYDBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8vHIxeC; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0d52768ccso5110655ad.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 03:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476230; x=1769081030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/SVBFySwYnFgzCd+lOHdFqf2Vleur+xFZa5r+xY3I4=;
        b=M8vHIxeChXY7mp+UQdkoBlbjwbWelvJcygTzGlPVoZvJwMBZ3sQeiAp69m4YoLAvKm
         9CQ8N8GlmynHYSED0PPVXpEsOfA70kLoQMIlAzI1R8Bz0QRVJZN6tocxbm/l6wndiO0f
         Fr2xj2bKkUGy8X4+BOYbaO0bEBRXiR1td4UX0FzbTJc5WvCvdk7Q7C9Sdb0hXcXO6RhV
         +3hKmsRFlW8nzZnRwErP61QT1gfK49YguHXywvwVWunJow0hUvX+YE2QYyAiF7MNqWTO
         5eqoytd0r2LFDqIumZTHHczDSIENMyfvYuuXWfanrSeZO8OZcJs1h5dCDD7YH07odUJZ
         wp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476230; x=1769081030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O/SVBFySwYnFgzCd+lOHdFqf2Vleur+xFZa5r+xY3I4=;
        b=ChDPye/kQFa+Yv6437DqX4BZ8/UbmnfvXiPcQM5IHi2WzWfZbsyvwV+tZOsdFB90LT
         OndAq36WdDecrakdxnP/k5itP7Ptm83bJstda9oRrmi6slsI+cDGQ/2NhvS+pbACHw8z
         HomCQtLtlbr0xH6nM7fp1UirTFm25CxFQO8pMnVQdpsXP9mM262RXHVgSR6gX+W7OOK4
         EmU0Xgf5Q9Uwlzce6mJHbi/jvlzRVT1DiYqZ4J+ueD9wAy23g7tpi4psY1gzxKhPBdfz
         0bblN6wFqfwRIeZNXd5gnDPVGMfbXY20TJGlcpH5NqDmtdd8pteSOBr5M047FWjrGRrg
         rqPg==
X-Forwarded-Encrypted: i=1; AJvYcCXbSABA8VAKAX6twll1u6619u4lGNifu2qs0nGecfANGxj+mwoAHMgP5tpR4F6P5kI15w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySNmiY3/ImD3x9HuvURDk0MvQrSfXypZrhAWFyoKT0lzvkxIoC
	XfKMgoN8J8FfonJCMuR/iFBDXkbyh1NzL7rNglz9nlZV+15yqEmjDIRmjnfrErZxBpM=
X-Gm-Gg: AY/fxX6OOsufulHaT4GU3VB6xdoTQRkjahgMbSJ42ZcV+rx70c9NnRk51G3tkuxM2dJ
	63SDtVVszxSkAfA7dbHMgZTV0VmS9FX+/81UdYw7TBhWdGnmnYPvYWJfod4XZkzkZhjgBq7ix4n
	hABLIPqcylDdmePH7C2wXo7hutOGKb14u96VcsD8fsY9IJE0hl4HULvaL4o+szdMKNS2a8D3Ww0
	ycYWa4ScNrSjEdiAKHazjqHTpKHu47sjvCWMFAPTvTT8YTJgCmlfcXpNT0rEGxLiUPHcmZvX8Yf
	eE8OMLahwSyYl5XuI2cjKFCVteDGOgt9nP9etH9EgVXUCCVetPkaMCmNH8TiY0zczwfP9mAlOHs
	yigbFTVCdZWuKI4wOkiewcwcCv4vLYE2MAUCEOIZn4lxitkPa+BkPjdf4BemNJKAaZZaiEfrQlo
	quVLA4jxo=
X-Received: by 2002:a17:902:cf06:b0:298:3aa6:c03d with SMTP id d9443c01a7336-2a59bc61e10mr49446395ad.57.1768476230265;
        Thu, 15 Jan 2026 03:23:50 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:23:49 -0800 (PST)
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
Subject: [PATCH bpf-next v10 05/12] bpf: support fsession for bpf_session_cookie
Date: Thu, 15 Jan 2026 19:22:39 +0800
Message-ID: <20260115112246.221082-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115112246.221082-1-dongml2@chinatelecom.cn>
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement session cookie for fsession. The session cookies will be stored
in the stack, and the layout of the stack will look like this:
  return value	-> 8 bytes
  argN		-> 8 bytes
  ...
  arg1		-> 8 bytes
  nr_args	-> 8 bytes
  ip (optional)	-> 8 bytes
  cookie2	-> 8 bytes
  cookie1	-> 8 bytes

The offset of the cookie for the current bpf program, which is in 8-byte
units, is stored in the "(((u64 *)ctx)[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF".
Therefore, we can get the session cookie with ((u64 *)ctx)[-offset].

Implement and inline the bpf_session_cookie() for the fsession in the
verifier.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v10:
- describe the offset of the session cookie more explicit
- make 8 as the bit shift of session cookie
- remove the session cookie count limitation

v9:
- remove the definition of bpf_fsession_cookie()

v7:
- reuse bpf_session_cookie() instead of introduce new kfunc

v5:
- remove "cookie_cnt" in struct bpf_trampoline

v4:
- limit the maximum of the cookie count to 4
- store the session cookies before nr_regs in stack
---
 include/linux/bpf.h   | 15 +++++++++++++++
 kernel/bpf/verifier.c | 20 ++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f72d553f52b..551d2cb0ec7d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1229,6 +1229,7 @@ enum {
 #endif
 };
 
+#define BPF_TRAMP_SHIFT_COOKIE		8
 #define BPF_TRAMP_SHIFT_IS_RETURN	63
 
 struct bpf_tramp_links {
@@ -1782,6 +1783,7 @@ struct bpf_prog {
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
+				call_session_cookie:1, /* Do we call bpf_session_cookie() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
 				sleepable:1;	/* BPF program is sleepable */
 	enum bpf_prog_type	type;		/* Type of BPF program */
@@ -2190,6 +2192,19 @@ static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
 	return cnt;
 }
 
+static inline int bpf_fsession_cookie_cnt(struct bpf_tramp_links *links)
+{
+	struct bpf_tramp_links fentries = links[BPF_TRAMP_FENTRY];
+	int cnt = 0;
+
+	for (int i = 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
+		if (fentries.links[i]->link.prog->call_session_cookie)
+			cnt++;
+	}
+
+	return cnt;
+}
+
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 			       const struct bpf_ctx_arg_aux *info, u32 cnt);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2efe458f9bad..3ab2da5f8165 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14303,6 +14303,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie])
+		env->prog->call_session_cookie = true;
+
 	return 0;
 }
 
@@ -22617,6 +22620,23 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_SHIFT_IS_RETURN);
 		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
 		*cnt = 3;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_cookie] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		/*
+		 * inline bpf_session_cookie() for fsession:
+		 *   __u64 *bpf_session_cookie(void *ctx)
+		 *   {
+		 *       u64 off = (((u64 *)ctx)[-1] >> BPF_TRAMP_SHIFT_COOKIE) & 0xFF;
+		 *       return &((u64 *)ctx)[-off];
+		 *   }
+		 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_SHIFT_COOKIE);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+		insn_buf[3] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
+		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
+		*cnt = 6;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.52.0


