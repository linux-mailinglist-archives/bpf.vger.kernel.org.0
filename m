Return-Path: <bpf+bounces-55590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1112A8339A
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5471B63B12
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 21:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F76421A95D;
	Wed,  9 Apr 2025 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJc1SjD2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA05218E92;
	Wed,  9 Apr 2025 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235174; cv=none; b=rlmBZwVJDysuKjP/EvDHIX5YojQT6wc5+Itr3WrhPQkVAhwM69Q8o2PXl0XBDtYGujYMuXpJ9l7XGhk2NZZVu+8tjnc1gDIMzjt8JumhHh07c5ZSSCm3Pdce6hFOg28k6aU0/C4op35iqDcKMy/8LRZ+trixBQLGy1IBctC4zRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235174; c=relaxed/simple;
	bh=HtpmPOfCekbXG4UayHfNUkrx4xFGghDA7+xcxJ/7hSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGBMlApGBL1fTl5eFOfU+b6ybwtx0gpsTitqgIf5AAPoTB9z/BztwA42ySoGgU76zZMkhYL4sn2Elmlrljm55/WLme4y2AX+4C9l1b7Amb/Ys/k48wbr6AZ+X9YOhgZ1ylsC3l/qnWSaumykUg39JCN6zw24WAOjzSl35JgD4Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJc1SjD2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2264aefc45dso1893545ad.0;
        Wed, 09 Apr 2025 14:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744235171; x=1744839971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhvff8xITZZMdar9HZn0Dny8IHdsn0Mdqy7WvvccQvQ=;
        b=DJc1SjD2U18rFsKZv+S8ZdkCqOWETwAYT+eSh6S7ALby0tB/SH1Mj6xkkIrIhd5CZR
         a0sQHGtpL5tVAHgfXHS0NFkUCAQ60bq2WEln3vSEzv/S2nkZTURsp8gwrAhojT+0hNIt
         sjcD/9mQnzoEIwe7l5YduM8Yh5Cy4fXtlWJv522ItffNzdpapjROAwiPy4Jqz6Qlj7ef
         KdJ08wj+eooV8y49Wd2rJFXhAIPwWZdOAjdWsz42lOouc5JjKAzsbF8Y8cKQhGetNKTl
         SOcrofaC5RixqrhoEBnuPNLwoaFGkxCt/1vqugGj4bUxGz8qZJ70GnRLsZGy5XZ3yB+C
         Nhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744235171; x=1744839971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhvff8xITZZMdar9HZn0Dny8IHdsn0Mdqy7WvvccQvQ=;
        b=JvR138+qkA2fcD5e4EzOP0gQ6prEKJKSSJknChfXUUszyZDfJSShF5ldUkNl0KnE5C
         5HBOTOupn0Y8FEO+r1z400e1MO6JHNJpk073OhSR9RsIIwDzthnET0BqG4Tcv7p1HoKq
         4f75CMMz3wKHeQpc3RpfGycEIwK7uU28+78XoD4eFOjTwr5dJVSduso1JuxktTkUnQzX
         JeqcseF4Wt+aOjP8K8V7xaaGIqe2peOcjp28nT5FFPt8RBryQg+t2ZPaJ2DiSVxxUZmk
         YXZtROpfuiT0EUDdLoYMFph4GcDz92m4eR+66FAXaRTLVHEx1wubHg61O9bHL1D1y0Cv
         FPXw==
X-Gm-Message-State: AOJu0YzxAYIHM/U0KIr46uQ989v5YVNFEVdmVezLzOCFobIx7WTd9PSu
	q3DnDy1S0T5ET9cy2whTXpFFYgLIZq0E6S7jBSzfiUzo4VMOq3vKSuxeewBS
X-Gm-Gg: ASbGncsaLBVZmv15JlhKCBH/ml69gLKP+6ieXIzUcaMjiC1cWb/AUJ0h+TN65Q7mmtr
	q/9cNdP667/tWtlPGSSIPPzi5lbU7Fz5rocKy9L97vuaFYOMKiNxipt0AWJi+VCki6u0ulI98J2
	H1qZg91azRBN2nGM55OECasCMXSneWW1sSY9GewLm7sPa9DQ/iKQIIpJPRw7H+L/BiRi6YTccpB
	VAwCbmGmkvWGwywPRnv2mgI6aqeZzschjbxOA1tYD18pMdOYOoKhNHlEdzNfNlzXGrrUhUlyCFQ
	pwX+pajRmak9Zrfl0FklKm2BP7ps
X-Google-Smtp-Source: AGHT+IFmXKyOzdXQn1H9izB+vFA1ys1tHlNVWFdP2LA+S9r8mEbbN0QueMdEZFJdepNGyfohrV8Nsw==
X-Received: by 2002:a17:902:d48f:b0:224:376:7a21 with SMTP id d9443c01a7336-22b42ca8b8fmr4598645ad.42.1744235171562;
        Wed, 09 Apr 2025 14:46:11 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d465d7sm1866589b3a.47.2025.04.09.14.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 14:46:11 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	edumazet@google.com,
	kuba@kernel.org,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	martin.lau@kernel.org,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	toke@redhat.com,
	sinquersw@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 03/10] bpf: net_sched: Add basic bpf qdisc kfuncs
Date: Wed,  9 Apr 2025 14:45:59 -0700
Message-ID: <20250409214606.2000194-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250409214606.2000194-1-ameryhung@gmail.com>
References: <20250409214606.2000194-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Add basic kfuncs for working on skb in qdisc.

Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to release
a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
in .enqueue where a to_free skb list is available from kernel to defer
the release. bpf_kfree_skb() should be used elsewhere. It is also used
in bpf_obj_free_fields() when cleaning up skb in maps and collections.

bpf_skb_get_hash() returns the flow hash of an skb, which can be used
to build flow-based queueing algorithms.

Finally, allow users to create read-only dynptr via bpf_dynptr_from_skb().

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/bpf_qdisc.c | 111 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 7eca556a3782..d812a72ca032 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -8,6 +8,9 @@
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
+#define QDISC_OP_IDX(op)	(offsetof(struct Qdisc_ops, op) / sizeof(void (*)(void)))
+#define QDISC_MOFF_IDX(moff)	(moff / sizeof(void (*)(void)))
+
 static struct bpf_struct_ops bpf_Qdisc_ops;
 
 struct bpf_sk_buff_ptr {
@@ -139,6 +142,95 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 	return 0;
 }
 
+__bpf_kfunc_start_defs();
+
+/* bpf_skb_get_hash - Get the flow hash of an skb.
+ * @skb: The skb to get the flow hash from.
+ */
+__bpf_kfunc u32 bpf_skb_get_hash(struct sk_buff *skb)
+{
+	return skb_get_hash(skb);
+}
+
+/* bpf_kfree_skb - Release an skb's reference and drop it immediately.
+ * @skb: The skb whose reference to be released and dropped.
+ */
+__bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
+{
+	kfree_skb(skb);
+}
+
+/* bpf_qdisc_skb_drop - Drop an skb by adding it to a deferred free list.
+ * @skb: The skb whose reference to be released and dropped.
+ * @to_free_list: The list of skbs to be dropped.
+ */
+__bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
+				    struct bpf_sk_buff_ptr *to_free_list)
+{
+	__qdisc_drop(skb, (struct sk_buff **)to_free_list);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(qdisc_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_skb_get_hash, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(qdisc_kfunc_ids)
+
+BTF_SET_START(qdisc_common_kfunc_set)
+BTF_ID(func, bpf_skb_get_hash)
+BTF_ID(func, bpf_kfree_skb)
+BTF_ID(func, bpf_dynptr_from_skb)
+BTF_SET_END(qdisc_common_kfunc_set)
+
+BTF_SET_START(qdisc_enqueue_kfunc_set)
+BTF_ID(func, bpf_qdisc_skb_drop)
+BTF_SET_END(qdisc_enqueue_kfunc_set)
+
+enum qdisc_ops_kf_flags {
+	QDISC_OPS_KF_COMMON		= 0,
+	QDISC_OPS_KF_ENQUEUE		= 1 << 0,
+};
+
+static const u32 qdisc_ops_context_flags[] = {
+	[QDISC_OP_IDX(enqueue)]		= QDISC_OPS_KF_ENQUEUE,
+	[QDISC_OP_IDX(dequeue)]		= QDISC_OPS_KF_COMMON,
+	[QDISC_OP_IDX(init)]		= QDISC_OPS_KF_COMMON,
+	[QDISC_OP_IDX(reset)]		= QDISC_OPS_KF_COMMON,
+	[QDISC_OP_IDX(destroy)]		= QDISC_OPS_KF_COMMON,
+};
+
+static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	u32 moff, flags;
+
+	if (!btf_id_set8_contains(&qdisc_kfunc_ids, kfunc_id))
+		return 0;
+
+	if (prog->aux->st_ops != &bpf_Qdisc_ops)
+		return -EACCES;
+
+	moff = prog->aux->attach_st_ops_member_off;
+	flags = qdisc_ops_context_flags[QDISC_MOFF_IDX(moff)];
+
+	if ((flags & QDISC_OPS_KF_ENQUEUE) &&
+	    btf_id_set_contains(&qdisc_enqueue_kfunc_set, kfunc_id))
+		return 0;
+
+	if (btf_id_set_contains(&qdisc_common_kfunc_set, kfunc_id))
+		return 0;
+
+	return -EACCES;
+}
+
+static const struct btf_kfunc_id_set bpf_qdisc_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &qdisc_kfunc_ids,
+	.filter = bpf_qdisc_kfunc_filter,
+};
+
 static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
 	.get_func_proto		= bpf_base_func_proto,
 	.is_valid_access	= bpf_qdisc_is_valid_access,
@@ -225,8 +317,25 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.owner = THIS_MODULE,
 };
 
+BTF_ID_LIST(bpf_sk_buff_dtor_ids)
+BTF_ID(func, bpf_kfree_skb)
+
 static int __init bpf_qdisc_kfunc_init(void)
 {
-	return register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
+	int ret;
+	const struct btf_id_dtor_kfunc skb_kfunc_dtors[] = {
+		{
+			.btf_id       = bpf_sk_buff_ids[0],
+			.kfunc_btf_id = bpf_sk_buff_dtor_ids[0]
+		},
+	};
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_qdisc_kfunc_set);
+	ret = ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
+						 ARRAY_SIZE(skb_kfunc_dtors),
+						 THIS_MODULE);
+	ret = ret ?: register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
+
+	return ret;
 }
 late_initcall(bpf_qdisc_kfunc_init);
-- 
2.47.1


