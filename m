Return-Path: <bpf+bounces-78467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B705AD0D72A
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3587230640CB
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B620346A08;
	Sat, 10 Jan 2026 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6aaWgtt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C513446B9
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054344; cv=none; b=KNBe+Q3P/grMknIOgn91ur0J65Skug8o0EUi7qPA34THMmnPBhllZocrDiaxkkrnCnVpiCiB8Lc+yUUy+Swjk6OaPFEwD5amiVO9/H/wWCmm2p/qHlchah2y24fpM3lO8RjPmKiS/gBZvxlV+yYuhct4TIV+JMpNedz4FIgDJfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054344; c=relaxed/simple;
	bh=7CI1fk3TYCP047X1bCPgKC9owVKrRj9F5Z1yX731DHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fv+K2F5iovcBpQojy1ggiPRTtZWSsGXoL1vgMP/mBrpkr7vbXMxH5YVszE25Ai6KiV+/Y11deJ7PU57TPt5X6IyNBcykWLg1iieOlnfGPqPhG6B+4QZgLJyI6uQ7QJg3DwuMYGzlBSQo7JQDXM9H8HKXUMm3ouBBcIQ1BC/9J/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6aaWgtt; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-81f223c70d8so694402b3a.1
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 06:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054342; x=1768659142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNf2fCgeJYWw76i+2OmkMmdqYk7qfGL3S+zuHB6a7CY=;
        b=g6aaWgttX8cMKXQW7Sk4O1TicaSColsnUdu7ClxR+kL/OVXaZfbQA4924hGXnhb3q4
         d9ykcYCNCipyh3QUEhBX7Rh0FbB5PEXI3PmYibwVZ3P0NMUy5lgZjnIyPplghIkJsUl2
         I9aJGVB7cl4YYdpugeIJZnSdpTEHdGRWYxnSyhw6STV46dCefZjMgd8FRhMWq6qTA+/r
         AlLPttl76H7t5hBc408c68T94L0F9tLkUneQnc/1AQiGZCPtHpDlnqYNZgArSZuAkf4k
         lbJgGuEH5p/YAmTL8qvGQfzl6pVrnwoATFiAT6ctmAKVL5A1O7ORag4dk9lzwZVDK+U2
         YhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054342; x=1768659142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VNf2fCgeJYWw76i+2OmkMmdqYk7qfGL3S+zuHB6a7CY=;
        b=fi7eqDcaVeH205UuEMR5cI9Tl4sEh9syXbi7TfncLXcHF0pudBMvPchSRqoprFKjTB
         23OiC+vHkNd6mPV4Sx/MNUpARxN6Y6WxUweG7ZjDaObX6eGOZuaREyebLoLmV+9W9H3C
         /Rrc93yYPaYWOMtZ8Q3KHwIvny9yFVlCedU3eKjFAaE0QU44iO0zS/tYqvwHd9dNdh59
         ithzdDvRlS889jPamsG7gms5XfzI+lcG5162u4Q5K49zSN0/6c/LCbTKKvA+tufMaCws
         +fnPGRB3QddGsW3ToMJSmZ+pOxDIFwRw7GC0VSUpYapEpCSdIXpeIPlF8xaIcw7Dn9gB
         fZHg==
X-Forwarded-Encrypted: i=1; AJvYcCUfAGY7nzAKxouX9nCXCj3JEhWfon7wVhLi7ET4++dNRaVWLNsEKpXsQDHhMdEdo23LW4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDT9tmSbX59n7MaNjm9Eju4RBFZlCsCLLe+Z2qv4Y7Qbvq/bRO
	lt4umiU4mHGNrcs5lAJFpzz3gsYYbgWhYsFmNOlnqw++fA2FyCG1dnu3
X-Gm-Gg: AY/fxX7g/rOFh8vYkf+LiyJ7CJebuI8O5GovpgEnELgVkM/2tFr2/L26lkBtHnsWcx7
	XE3yrMGMYlbgJ0XZIypcmGVrgEaFPlJffIqQwTohCOn9GOUakC0jr15w/4ZOjIKhZX9YR8U46rm
	cMUmqQ9uAagTrCnxdyNO4S6Kl5rT9gNGzdL8PP51B0XFHiRRo72VuSvROtFqFHYXQ6RS0N3yhW1
	eNTobRRE9NSZXrHGSy7nLkQVxqV4IyXISSG83QzU27OM5VUEvmLcvFGJ+05EhD8yxUNUcs2p85i
	3+oKVJ9TMYR53EsjDJsswAS8hcEFWwoeEfRa+Rq3P+ijWXNqYObTO6qJAp6nIRldl2fm3SzZFrH
	CsdG7ATGVl5IduW5oiehqjpRsDsezfWjFTu8fWlMbZE6ZU29GKvx8J3xPiKwxRiXYn79PPbYzdd
	oQX5q6p8E=
X-Google-Smtp-Source: AGHT+IHvijOn+AVM4DEWsKjCWx0EyWcN+T7+lYBawoPBdq2YSqCcVqk2/nBn3ab67rucNzjDc3jn4g==
X-Received: by 2002:a05:6a00:a113:b0:81c:717b:9d36 with SMTP id d2e1a72fcca58-81c717ba5d1mr8037609b3a.33.1768054342206;
        Sat, 10 Jan 2026 06:12:22 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:12:21 -0800 (PST)
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
Subject: [PATCH bpf-next v9 05/11] bpf: support fsession for bpf_session_cookie
Date: Sat, 10 Jan 2026 22:11:09 +0800
Message-ID: <20260110141115.537055-6-dongml2@chinatelecom.cn>
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

Implement session cookie for fsession. In order to limit the stack usage,
we make 4 as the maximum of the cookie count.

The offset of the current cookie is stored in the
"(ctx[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF". Therefore, we can get the
session cookie with ctx[-offset].

The stack will look like this:

  return value	-> 8 bytes
  argN		-> 8 bytes
  ...
  arg1		-> 8 bytes
  nr_args	-> 8 bytes
  ip (optional)	-> 8 bytes
  cookie2	-> 8 bytes
  cookie1	-> 8 bytes

Implement and inline the bpf_session_cookie() for the fsession in the
verifier.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
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
 include/linux/bpf.h     | 15 +++++++++++++++
 kernel/bpf/trampoline.c | 13 +++++++++++--
 kernel/bpf/verifier.c   | 22 +++++++++++++++++++++-
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2640ec2157e1..a416050e0dd2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1231,6 +1231,7 @@ enum {
 
 #define BPF_TRAMP_M_NR_ARGS	0
 #define BPF_TRAMP_M_IS_RETURN	8
+#define BPF_TRAMP_M_COOKIE	9
 
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
@@ -1783,6 +1784,7 @@ struct bpf_prog {
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
+				call_session_cookie:1, /* Do we call bpf_session_cookie() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
 				sleepable:1;	/* BPF program is sleepable */
 	enum bpf_prog_type	type;		/* Type of BPF program */
@@ -2191,6 +2193,19 @@ static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
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
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 11e043049d68..29b4e00d860c 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -592,6 +592,8 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
 	return 0;
 }
 
+#define BPF_TRAMP_MAX_COOKIES 4
+
 static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 				      struct bpf_trampoline *tr,
 				      struct bpf_prog *tgt_prog)
@@ -600,7 +602,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 	struct bpf_tramp_link *link_exiting;
 	struct bpf_fsession_link *fslink;
 	struct hlist_head *prog_list;
-	int err = 0;
+	int err = 0, cookie_cnt = 0;
 	int cnt = 0, i;
 
 	kind = bpf_attach_type_to_tramp(link->link.prog);
@@ -637,11 +639,18 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 		/* prog already linked */
 		return -EBUSY;
 	hlist_for_each_entry(link_exiting, prog_list, tramp_hlist) {
-		if (link_exiting->link.prog != link->link.prog)
+		if (link_exiting->link.prog != link->link.prog) {
+			if (kind == BPF_TRAMP_FSESSION &&
+			    link_exiting->link.prog->call_session_cookie)
+				cookie_cnt++;
 			continue;
+		}
 		/* prog already linked */
 		return -EBUSY;
 	}
+	if (link->link.prog->call_session_cookie &&
+	    cookie_cnt >= BPF_TRAMP_MAX_COOKIES)
+		return -E2BIG;
 
 	hlist_add_head(&link->tramp_hlist, prog_list);
 	if (kind == BPF_TRAMP_FSESSION) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1b0292a03186..b91fd8af2393 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12508,7 +12508,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	bool arg_mem_size = false;
 
 	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
-	    meta->func_id == special_kfunc_list[KF_bpf_session_is_return])
+	    meta->func_id == special_kfunc_list[KF_bpf_session_is_return] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_session_cookie])
 		return KF_ARG_PTR_TO_CTX;
 
 	if (argno + 1 < nargs &&
@@ -14294,6 +14295,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie])
+		env->prog->call_session_cookie = true;
+
 	return 0;
 }
 
@@ -22571,6 +22575,22 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
 		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
 		*cnt = 3;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_cookie] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		/* inline bpf_session_cookie() for fsession:
+		 *   __u64 *bpf_session_cookie(void *ctx)
+		 *   {
+		 *       u64 off = (((u64 *)ctx)[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF;
+		 *       return &((u64 *)ctx)[-off];
+		 *   }
+		 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_COOKIE);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+		insn_buf[3] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
+		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
+		*cnt = 6;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.52.0


