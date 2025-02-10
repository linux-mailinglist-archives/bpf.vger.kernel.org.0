Return-Path: <bpf+bounces-51016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73195A2F591
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3137166E44
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4D82586CF;
	Mon, 10 Feb 2025 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SffADZwH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A768255E4B;
	Mon, 10 Feb 2025 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209439; cv=none; b=k/Koc36RCvz35oTTtBbYoA1ArDPTpksHOL2zn1XTfOsrCsXebSQxR865yW8NxbmoMIB+fjS27RBYKdwAeUlvHQQiQ9deIbgnH/bjF7PzEI+QT415+fDeL+LPEy/gG3v7mVqJrTMen04XQc0wGp7FwxAllZdZnHdDI1z65L0+cHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209439; c=relaxed/simple;
	bh=RuzPRB79q27As0dh0HE5sZbuWOGTdkpmJkVJecz8KTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8LCJ4AyYgpWYwRBWJWRJ89uOY07x75b4PCebkPSMOJlyxXL0NEqs6uwnrcfrvWwH+aNg8vkZFntHd3NOsmG50KflzVWynocNZSk+12w+HPCUGtNRnnNL0jkOWxK8WiJlFGL5SPs/XIHU3jgIDCUJd1wm134SDqeAJUiKYj2q1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SffADZwH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f74c4e586so38375075ad.0;
        Mon, 10 Feb 2025 09:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209437; x=1739814237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxfmY9SNILHvegwiEoTc4oD1Zqu0Ti6wlb2uVVZCDRI=;
        b=SffADZwH7RAoWCuiU6o24miU/6sttjZSiiq2ezOuu7hwl+lput8dXL32G5vIlPB6Zw
         Knwf1pTrRiPKfi9TYtrGtcSFk8hJ+BEEps8KnN7MBSX1kzkYZvIlkrjXT7k3/IlJ6wix
         XGhxGqxLXshEw1xyBPrUg/OkstKF4zN9Et23lDjJ56R7YWwLUJ5qZf6hoAsk4jTcYRkJ
         sLlPjF65bScWt1PJ8D74XANdQ/52wsoH2knHkyBUUVPF27UQA+jB62YGAQlo62gqNnvp
         OXuvArHqlJBAdrVvBFWvbpDzqNPapEM7FoTXV6vqBmV0mPYgbILXmC0IsLZ/FqPs+ew3
         zziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209437; x=1739814237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxfmY9SNILHvegwiEoTc4oD1Zqu0Ti6wlb2uVVZCDRI=;
        b=XGYeUxfY/OO4l4Y6Pzs8QjpKHT1pH9AvWndQcr3AhSBzWh6O+TC2zhg75++PY1n9yo
         Bd8jY7oM1LYeAYaPv0rpEYRVQI7OCz7vXdED49XJQVcfSdgj3XUyeKmqlcIiT1qDpktz
         t2SLSr7pTGVw5FoWqbonETd8fBeTPrIghTSPjXlU7coMNG3Vy4q0KAw9HTggBRBssx7l
         bGodCZZTs4vPYTMbMDXh0/ylEgsbRcO0OkUis5q6raazFZw30lkXswTn2BvH4B/QZ/4k
         A2MFJftVc5Qtnctx2C8bCalGT7kdPL/GxTZl4vFuQkcenKYHvP/H4Lj5K/FshH7rB9Xp
         B1cA==
X-Gm-Message-State: AOJu0YymqFSS/kWLMAeHVSEXiTEcs7tu4V3ADlXRP2Q3qP9z5eKqQAtY
	8vyePCX/pE5ybBeMy+bWySe+XpJhgpow9hsCmJdFD/1w1xw4OBVh+2No9KqQ
X-Gm-Gg: ASbGncseD/tBfvKbyc+ACnJY5NUjsFD5i91xiyW7FqOgyenHp7Omv5wUBrMaKej+e4D
	VVtxBIg356TJUeKXIqYWoBnbjb1aflB8SKvtkxUpQrHnVgxYB9XFvoLp3Ogcl/9RKUua8CzPyW1
	5mB4TJsAxWT4wvn4WCjpktTJEcYr6Oe40IAbwOJxP6wkmeG2ZNmOyaeZnigKdLDNU6I4KwM+bmA
	q0SkRPmKQ4Gws4vNa9PeKIKTZ0vJo2hOO3jtIU/p/xsrokLNwXalF36wHqLHJImQ68AwgDeLWc1
	gDKBvMSQYBSvAdn094TCAhYyDK0uOuqO+mCoqsOQqBg9YCDEN3/J80R77TvEIey3/g==
X-Google-Smtp-Source: AGHT+IEELJeYcLfqQVDuOdZPgKfl+WGDAcwyy+plD26K3rgg+owJS8Of2YwaRDUfcPiDv841hMv7mA==
X-Received: by 2002:a17:90b:264a:b0:2fa:157e:c78e with SMTP id 98e67ed59e1d1-2fa9ed5d43fmr608648a91.7.1739209437371;
        Mon, 10 Feb 2025 09:43:57 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:43:56 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 09/19] bpf: net_sched: Add basic bpf qdisc kfuncs
Date: Mon, 10 Feb 2025 09:43:23 -0800
Message-ID: <20250210174336.2024258-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210174336.2024258-1-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c |  2 +
 net/sched/bpf_qdisc.c       | 93 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6003ba36f6c5..bbca7b537cf8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1810,6 +1810,7 @@ struct bpf_struct_ops {
 	void *cfi_stubs;
 	struct module *owner;
 	const char *name;
+	const struct btf_type *type;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index d3a76f0c5a82..1ee6d41d4948 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -460,6 +460,8 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		goto errout;
 	}
 
+	st_ops->type = t;
+
 	return 0;
 
 errout:
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 00f3232f4a98..69a1d547390c 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -111,6 +111,80 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
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
+static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (bpf_Qdisc_ops.type != btf_type_by_id(prog->aux->attach_btf,
+						 prog->aux->attach_btf_id))
+		return 0;
+
+	/* Skip the check when prog->attach_func_name is not yet available
+	 * during check_cfg().
+	 */
+	if (!btf_id_set8_contains(&qdisc_kfunc_ids, kfunc_id) ||
+	    !prog->aux->attach_func_name)
+		return 0;
+
+	if (bpf_struct_ops_prog_moff(prog) == offsetof(struct Qdisc_ops, enqueue)) {
+		if (btf_id_set_contains(&qdisc_enqueue_kfunc_set, kfunc_id))
+			return 0;
+	}
+
+	return btf_id_set_contains(&qdisc_common_kfunc_set, kfunc_id) ? 0 : -EACCES;
+}
+
+static const struct btf_kfunc_id_set bpf_qdisc_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &qdisc_kfunc_ids,
+	.filter = bpf_qdisc_kfunc_filter,
+};
+
 static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
 	.get_func_proto		= bpf_qdisc_get_func_proto,
 	.is_valid_access	= bpf_qdisc_is_valid_access,
@@ -203,8 +277,25 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
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


