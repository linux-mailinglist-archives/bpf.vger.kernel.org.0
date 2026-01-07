Return-Path: <bpf+bounces-78053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFE3CFC39F
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 07:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 661BC309D28F
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 06:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D342857D2;
	Wed,  7 Jan 2026 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGuPyU+d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA0F2848BA
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768302; cv=none; b=glg3h+JdqYTAe6FtrWqtcetNjtIXYccKPiwwvfZ/pc8XT8v+auEGt2goq94VIQxarN+a2N1dQRaEt8VWNWIqTIeIPanOOwMChylBbOjgs9zEwPzqtNqQL6SrHT8l1agLQAsr+VbrE40TJVY0UnVtOH0QLOXuyDW88qqcGMoSYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768302; c=relaxed/simple;
	bh=hn8W0ZkaESYLxe1GBfJWcI5Xf7fsdAugM9oC9zAf41A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GT5u/HrTw+rPK8BPfrS04+nFuNogwLzay5kBAmAhy4ah1dhaZPPYh4pQFdfoaVImQVT8N5TXT+QG/h16p3XYL/DljzZp4EMSS/dQqCuXIdXN7AlgsVIzwrmgM8eVJb53vdT4BsgGmRVPi0L6TCeOjgZ4NC7gULOyhEFCwGgPyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGuPyU+d; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-78fc520433aso19616077b3.1
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 22:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768299; x=1768373099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhltP3LSdy4mcdJDqVz74Ak7lLpTineJXeS0W1GM7yc=;
        b=YGuPyU+d1or37+3jAHRiabpqdGpFenMiJUjjwmclTLTXp5ysL39fz3F9C3yZNAjGQb
         /G+JoPEGWPbFTzRXvgU1f+DPPvvoL5eLvXJ+9aJMl7wIZhX9JTVWXo1kC6yncpv01DDc
         tG0W04Tel4nllhz6BQ1pnQ9bTefbWidmC2VnNhZl7IVURxYeX10Qv8Kdj2MtuXM30/ag
         tHKDmZBGzP5DxylZOprheBIizw6DcglWulRXfhvFwox/PpXWY3XXTqavolCM41gRdF8b
         UcwGZI+wZ0Z6B+80TwOhddsgMRbOi0kgEOCXtf9UK0DG2c+Wiie+Ty4u7wq8HuIJGjOn
         BalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768299; x=1768373099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhltP3LSdy4mcdJDqVz74Ak7lLpTineJXeS0W1GM7yc=;
        b=EeNqWnflCVGrk0dxa0eC75tg2LRptF6Sq48bA9A8KVT5/ffLSmN+UT29a4pirJQpT3
         AE2uLbHLFYRKJR4fL1reARW9t21H18erxXD9/W9Rq4Cw1uFXIvXUAJlCSmRr8HyiwLjF
         bNQM/Kr9+veo+CHnMFr9QL5Vr7xMvU4D9OV7Lz1M5IxjBRGSXWyJrNKQb+Wg/01DWcSA
         BSyW2VYFET7VtZSe2Ty9EuauXHHgXNaOiR5/oLyUSYmgqES2MA4WXvVBfkrUTcGkspdN
         AoO02kzIf+/HUgRpXiAaxjyj7J9HTZMONI49b33d8N+EJ1jzJ59haervccDAcqQL6O34
         978w==
X-Forwarded-Encrypted: i=1; AJvYcCUWXMEsrO72EKh4Vf02xvlHCMMdayubWKutVieQZKK3yRb0oL5YExWbT6E1EaXeiYtV08M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPDfZ4MUml58MoN8Q2xrjxnDVBIB0vFIawsNlKIXQ3kBMGXUH5
	6KEFh/lPVbYTffjGyKTZMfz9Rncm6UCQJvyO9qbfTrXBDk/xUBwQ7DKZ
X-Gm-Gg: AY/fxX7mX0wvEOBVhNwZMbwpvOf9MLd2AXbhH+Axugz5+cS+XypWJzInWzeMHVhgPhx
	iS2z8WSwNLTPN7BFjwYwBnrT4FS+eaOgp985z8ePyCcE570WVyXwClNb6VhpPeoblmxv+roA24v
	uz7nli2A1VxJUUkV+GpDp1WJsNzRuAlBN1pu7Y3DzokN7/z7UnfrqCvRlsr8TPzfttiSfCsbbr6
	mjSy12oAjHKtZsys2ENBPXa0+3TcJ3KGst8kugLQTseWaFe4K8Xkl2WkDOoG3HJwPRiSdPAf9YW
	42Qeq7mYK4Z5e3Po66FF/cAhJXd+6KO1LTYppk4hOdqcXw7AdT4Mqe1mytK3jjttMf3qx0IsGOb
	HmEdm4Kx05hDayfIkJFsVuxFFzBfarcE2cuaWRDykaFq09dxup1jdX9SiqGSd0cfEaxoAc13OzF
	tPrWATutY=
X-Google-Smtp-Source: AGHT+IFkIesbmcZh8GuMCFU5dkAze0Rcy8DMlKkmb+8exYD67FY3ed9jgK/Vbt8TQxR9ep1RMh55Ng==
X-Received: by 2002:a05:690c:620e:b0:786:59d3:49c2 with SMTP id 00721157ae682-790b57fe13cmr12844387b3.35.1767768299328;
        Tue, 06 Jan 2026 22:44:59 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm9635047b3.47.2026.01.06.22.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:44:58 -0800 (PST)
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
Subject: [PATCH bpf-next v7 05/11] bpf: support fsession for bpf_session_cookie
Date: Wed,  7 Jan 2026 14:43:46 +0800
Message-ID: <20260107064352.291069-6-dongml2@chinatelecom.cn>
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

Inline the bpf_fsession_cookie() in the verifier too. The calling to
bpf_session_cookie() will be changed to bpf_fsession_cookie() in verifier
for fsession.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v7:
- reuse bpf_session_cookie() instead of introduce new kfunc

v5:
- remove "cookie_cnt" in struct bpf_trampoline

v4:
- limit the maximum of the cookie count to 4
- store the session cookies before nr_regs in stack
---
 include/linux/bpf.h      | 16 ++++++++++++++++
 kernel/bpf/trampoline.c  | 13 +++++++++++--
 kernel/bpf/verifier.c    | 19 ++++++++++++++++++-
 kernel/trace/bpf_trace.c |  8 ++++++++
 4 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d996dd390681..31e03886c864 100644
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
 
@@ -3949,5 +3964,6 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 }
 
 bool bpf_fsession_is_return(void *ctx);
+u64 *bpf_fsession_cookie(void *ctx);
 
 #endif /* _LINUX_BPF_H */
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
index d3709edd0e51..210af94e3957 100644
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
 
@@ -22446,6 +22450,9 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	} else if (func_id == special_kfunc_list[KF_bpf_session_is_return]) {
 		if (prog->expected_attach_type == BPF_TRACE_FSESSION)
 			addr = (unsigned long)bpf_fsession_is_return;
+	} else if (func_id == special_kfunc_list[KF_bpf_session_cookie]) {
+		if (prog->expected_attach_type == BPF_TRACE_FSESSION)
+			addr = (unsigned long)bpf_fsession_cookie;
 	}
 	desc->addr = addr;
 	return 0;
@@ -22571,6 +22578,16 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
 		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
 		*cnt = 3;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_cookie] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		/* Load nr_args from ctx - 8 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_COOKIE);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+		insn_buf[3] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
+		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
+		*cnt = 6;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9d3bf3bbe8f6..4960bb69cb30 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3320,6 +3320,14 @@ bool bpf_fsession_is_return(void *ctx)
 	return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
 }
 
+u64 *bpf_fsession_cookie(void *ctx)
+{
+	/* This helper call is inlined by verifier. */
+	u64 off = (((u64 *)ctx)[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF;
+
+	return &((u64 *)ctx)[-off];
+}
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc bool bpf_session_is_return(void *ctx)
-- 
2.52.0


