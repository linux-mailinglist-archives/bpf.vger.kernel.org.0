Return-Path: <bpf+bounces-75363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04704C8192D
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2659E34832E
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD05F3164B6;
	Mon, 24 Nov 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UxtsZ7nW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532031A56B
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001770; cv=none; b=Wk6cVytqJ+4M8HrP9lkyUnNvxVAnDdWWwtEPJSzrFJ2VpNKiXKmTLl5fypM2o12nNdCYcboCpk1xT9pkQV6gy+faWirmuVQWD4Px8QcqDdkepWnjt3Uw61WiBOqPZGz1tQR7exK1TZteJF6Sal1BrDm2jFB3cjib0sdsvN6BkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001770; c=relaxed/simple;
	bh=yxcTKJy7CPbrcOiVSN+4TKlBp2Yod2odaj3nQyTuSPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qvPXRJpq/nedp9fxdW0myrEFX5Gu9s014PTnLMidpJcBxzDSJ4s2F2KvfbV4Fb5KxA+kNYUr/lns1+UV9tzrSh0TisaME5B2eOeja1c1XpoOSylJB5zT1T8IBxOfwEphOwlHCsfQ1gXmJADegvPecPLI5CpmwaICeLkgQkoKZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UxtsZ7nW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7697e8b01aso330032966b.2
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001766; x=1764606566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5vmeOhBwEstqOHC3P053x88OMrGL4Po12oOlE0vrgM=;
        b=UxtsZ7nWsWA7FIec2awUsB3bGOA9MlJtCIW6Ztr8XIgpMGYggiOYfScxCa1tCUmRjl
         rI9aTV98Aa59uQjvBjm+q0JffELCTY7yxi0yVRyWD0bceCE74kG1nSn1CWqqk4AuvKF7
         QzlCSX/js91OUvs5zXGUHSvgzSCpg1EKt+3pxhLjAiZ1fewIGeBmsUEc+QhQeBh3k7cU
         z2fpjXdk9gLqmV2xEm/zV4a/ONTEWzaUsdIIykOsdlIDC61OT/tvonyCRHE+X5ZJhWi0
         ynCywuC4llO/Yjich/BmZk9UUKvVlwXF49/lMCRAKTH4Ej2bA85RfgavMvDUy1I4rr9m
         +HDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001766; x=1764606566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d5vmeOhBwEstqOHC3P053x88OMrGL4Po12oOlE0vrgM=;
        b=fJaGpl9ssQicXpkGAoMCSGfTmf2cM+cQWdTyg2OfbkQl1lKoQFUHWVGBoW6tEQC2pG
         NiNGxwp8g/aPAbe72h7OP+Lo8dmARyR5Cdny6RZGcey2dHoux/sL1VLtZ+YnmMfOs/xZ
         BUFQx/lGyrYhLTlN1uQL/khNTBnnhCas6168K1p8WJvroqor+QgjO5rie2erQtbvvwx8
         ugSA5MAmKvdApakXlEknKqe7dDZlZQJBvTBwRljUGrnlE3b1VCaXJzvlsulLX0kP37Ld
         d5uUl6Tn2wc7aIlz8m8HGyeJImkNie9dKQxy0l2hkcJWpTI0Aq+Y/HwP6VbN5xGiJyqb
         7Rqw==
X-Gm-Message-State: AOJu0YwXHhILyxGSuiBYCVAAmtclg9L/VNlgt1iz4DUnrh6XKwQcObq6
	o2yTfghe4Afdh8SrXNTpWJB9M3NB2X7/IWA4KUdcytWUQFCXWVBY1jCA7DI9ACm28UuCwYVrSTs
	GUDQe
X-Gm-Gg: ASbGncti3pRopVjqaz0IZ+jpbJLk+9Dw0Zwk+of3Sk+n1G0hPlwlapw5p262TxVYgH+
	Wm8OelWze6K4EMMOItIUamZhQh2K4dHo+PPRrpny8vGpJjbwspCBe3tszAYcKcwW6gylySzlBqi
	Z2iILn/FyMaQkObhBxz4cODc6fBnbzrK6+yhUhN+TySjN0X+CP/QFbcFw6qm/qOXbglxwnQpCVS
	JhGXjZVsLKw6hpa88zC0jKqcOcqPbw7UsbMwBxdasMoU93Y5SUfK9ffBtr6hNrNO72fmRUcjDfV
	Cgi4MiH7P7t3+KeNW92XNajU1zgtqopsahMHQTCv+u/e0l1CJw3XHzaOJV46/tXRPNmRhEMcbNz
	bD4zie08gpJzRqBKRgeSy3+JA2DCUhkmxgDnLVCXtiQC8ABsqucsG7YHy9wTo2ffjHzQSGKXH9a
	oe0Gu7KF8dmgSZXT6EzC/RO8rysmsVfWGYkkwtMTD2j6kJbyZ3hKKY+47t
X-Google-Smtp-Source: AGHT+IFqpayB2GjJE72aXyrUQTO+bcd6/VkjyzCNgXtCd8FSSedupcv2yZ9C8QAfWtOxSq0aG8yLDQ==
X-Received: by 2002:a17:907:3e1a:b0:b73:8d2e:2d3d with SMTP id a640c23a62f3a-b76715159e9mr1424047366b.4.1764001766352;
        Mon, 24 Nov 2025 08:29:26 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd43e2sm1313004766b.39.2025.11.24.08.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:25 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:49 +0100
Subject: [PATCH RFC bpf-next 13/15] bpf, verifier: Propagate packet access
 flags to gen_prologue
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-13-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Change gen_prologue() to accept the packet access flags bitmap. This allows
gen_prologue() to inspect multiple access patterns when needed.

No functional change.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf.h                                  |  2 +-
 kernel/bpf/cgroup.c                                  |  2 +-
 kernel/bpf/verifier.c                                |  6 ++----
 net/core/filter.c                                    | 15 ++++++++-------
 net/sched/bpf_qdisc.c                                |  3 ++-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c |  6 +++---
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d808253f2e94..d16987e94d98 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1076,7 +1076,7 @@ struct bpf_verifier_ops {
 	bool (*is_valid_access)(int off, int size, enum bpf_access_type type,
 				const struct bpf_prog *prog,
 				struct bpf_insn_access_aux *info);
-	int (*gen_prologue)(struct bpf_insn *insn, bool direct_write,
+	int (*gen_prologue)(struct bpf_insn *insn, u32 pkt_access_flags,
 			    const struct bpf_prog *prog);
 	int (*gen_epilogue)(struct bpf_insn *insn, const struct bpf_prog *prog,
 			    s16 ctx_stack_off);
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 69988af44b37..d96465cd7d43 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2694,7 +2694,7 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
 }
 
 static int cg_sockopt_get_prologue(struct bpf_insn *insn_buf,
-				   bool direct_write,
+				   u32 pkt_access_flags,
 				   const struct bpf_prog *prog)
 {
 	/* Nothing to do for sockopt argument. The data is kzalloc'ated.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4c84b0cd399e..bb4e70913ab4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21200,7 +21200,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
-	bool seen_direct_write;
 	int epilogue_idx = 0;
 
 	if (ops->gen_epilogue) {
@@ -21228,13 +21227,12 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 	}
 
-	seen_direct_write = env->seen_packet_access & PA_F_DIRECT_WRITE;
-	if (ops->gen_prologue || seen_direct_write) {
+	if (ops->gen_prologue || (env->seen_packet_access & PA_F_DIRECT_WRITE)) {
 		if (!ops->gen_prologue) {
 			verifier_bug(env, "gen_prologue is null");
 			return -EFAULT;
 		}
-		cnt = ops->gen_prologue(insn_buf, seen_direct_write, env->prog);
+		cnt = ops->gen_prologue(insn_buf, env->seen_packet_access, env->prog);
 		if (cnt >= INSN_BUF_SIZE) {
 			verifier_bug(env, "prologue is too long");
 			return -EFAULT;
diff --git a/net/core/filter.c b/net/core/filter.c
index 4124becf8604..334421910107 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9042,7 +9042,7 @@ static bool sock_filter_is_valid_access(int off, int size,
 					       prog->expected_attach_type);
 }
 
-static int bpf_noop_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int bpf_noop_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 			     const struct bpf_prog *prog)
 {
 	/* Neither direct read nor direct write requires any preliminary
@@ -9051,12 +9051,12 @@ static int bpf_noop_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	return 0;
 }
 
-static int bpf_unclone_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int bpf_unclone_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 				const struct bpf_prog *prog, int drop_verdict)
 {
 	struct bpf_insn *insn = insn_buf;
 
-	if (!direct_write)
+	if (!(pkt_access_flags & PA_F_DIRECT_WRITE))
 		return 0;
 
 	/* if (!skb->cloned)
@@ -9125,10 +9125,11 @@ static int bpf_gen_ld_abs(const struct bpf_insn *orig,
 	return insn - insn_buf;
 }
 
-static int tc_cls_act_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 			       const struct bpf_prog *prog)
 {
-	return bpf_unclone_prologue(insn_buf, direct_write, prog, TC_ACT_SHOT);
+	return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
+				    TC_ACT_SHOT);
 }
 
 static bool tc_cls_act_is_valid_access(int off, int size,
@@ -9466,10 +9467,10 @@ static bool sock_ops_is_valid_access(int off, int size,
 	return true;
 }
 
-static int sk_skb_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int sk_skb_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 			   const struct bpf_prog *prog)
 {
-	return bpf_unclone_prologue(insn_buf, direct_write, prog, SK_DROP);
+	return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog, SK_DROP);
 }
 
 static bool sk_skb_is_valid_access(int off, int size,
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index adcb618a2bfc..ae44d0dab073 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -132,7 +132,8 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 
 BTF_ID_LIST_SINGLE(bpf_qdisc_init_prologue_ids, func, bpf_qdisc_init_prologue)
 
-static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf,
+				  u32 direct_access_flags,
 				  const struct bpf_prog *prog)
 {
 	struct bpf_insn *insn = insn_buf;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 8eeebaa951f0..286cbb8c5623 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1369,7 +1369,7 @@ static int bpf_test_mod_st_ops__test_pro_epilogue(struct st_ops_args *args)
 static int bpf_cgroup_from_id_id;
 static int bpf_cgroup_release_id;
 
-static int st_ops_gen_prologue_with_kfunc(struct bpf_insn *insn_buf, bool direct_write,
+static int st_ops_gen_prologue_with_kfunc(struct bpf_insn *insn_buf,
 					  const struct bpf_prog *prog)
 {
 	struct bpf_insn *insn = insn_buf;
@@ -1445,7 +1445,7 @@ static int st_ops_gen_epilogue_with_kfunc(struct bpf_insn *insn_buf, const struc
 }
 
 #define KFUNC_PRO_EPI_PREFIX "test_kfunc_"
-static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int st_ops_gen_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 			       const struct bpf_prog *prog)
 {
 	struct bpf_insn *insn = insn_buf;
@@ -1455,7 +1455,7 @@ static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 		return 0;
 
 	if (!strncmp(prog->aux->name, KFUNC_PRO_EPI_PREFIX, strlen(KFUNC_PRO_EPI_PREFIX)))
-		return st_ops_gen_prologue_with_kfunc(insn_buf, direct_write, prog);
+		return st_ops_gen_prologue_with_kfunc(insn_buf, prog);
 
 	/* r6 = r1[0]; // r6 will be "struct st_ops *args". r1 is "u64 *ctx".
 	 * r7 = r6->a;

-- 
2.43.0


