Return-Path: <bpf+bounces-54407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1EFA69B96
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 22:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD543982EE2
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 21:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79F621CFF7;
	Wed, 19 Mar 2025 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lx2cphLG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22E21CA18;
	Wed, 19 Mar 2025 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421255; cv=none; b=qldBxYJYObZcJjFVrBBJe964CNF7AYS8wVguqyYU+XibjGVNlnU13gBv9+275NoMJ21uC7cCrl+Jp1PweKezCyVYZ4GtAq6Wekor5ZMIC2Vtsat//OPICv96ZlOBJ4zM8B0vr4XYzhTbKqqsebx1JwWd/vMsrKr6kJN6DnRvQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421255; c=relaxed/simple;
	bh=HtpmPOfCekbXG4UayHfNUkrx4xFGghDA7+xcxJ/7hSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rsv1BiT545Qiw9UzoSLbV+FEm2JOpS07wuzuKOek/VYcqk7+uAP/AVpVYt+txrQwgMYiGrrwLu+ZDLNwptTYUzpd7e4WqnkF8JmdEkukhJgZ+fJiItJvKWgBW2fWtJXMuqtkj2aQWOMM9/cf+8dsHSwkmZajPaNTMIjTVsjJwo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lx2cphLG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224019ad9edso1037265ad.1;
        Wed, 19 Mar 2025 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742421253; x=1743026053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhvff8xITZZMdar9HZn0Dny8IHdsn0Mdqy7WvvccQvQ=;
        b=Lx2cphLGWJO3sXF8fjJBk/g5ZVIhCkV7xDOAlB6AXKMK2b/kDqVSzb0nCxJc2GT7P2
         ioL+eZemV+5ov7D1n0yNiZK7LugY2yDgwusTHAYf0YfCG0iird5VPhJVQqVMybzQG+Ra
         O1mb1z6w5GPdhYmKnWm0lhlXOsEPNX3gqngpmpFGsMJtRU5yKAVtpRBP+255T+Hf8nGv
         BaRBJBCj41KmQxgzW8+/HI6Kn3mnXci1w4XF7qQLedhnFa2z87MvukDSU7kXzMluNp3g
         fXfUmPlmGF0DXqhLIL1yS1XQWuxej6S0WxXoq+BFucp7IKU3385qiB5Dlk/H+mtg2mW1
         K7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421253; x=1743026053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhvff8xITZZMdar9HZn0Dny8IHdsn0Mdqy7WvvccQvQ=;
        b=SBMRj9xN8XcwUuc0KSVJ5Wr1CbfxNOftWFoN938mpXYKmCMYv5xyvzPBgeAgA1slHa
         2CY8yJrO1zOO9CrFXhvT2zOSuxVFu20K2BOxOYbt7zgoIBBnXVBvCI9WM5QmNJdYrsnn
         k9ckdjK1+MeSIsT3HSlWJAUNQqdcrk5NDfmdWZMI7QwjBj6MtfLoYb6rJei4AmhiQb+7
         Bt1TCOKOa8PxiSRm1XrTNoMM5iPIdpdgshI2AySvNAoJDGIgYliE+5103gWHYL9Ohf+J
         ayZUhvXvYXLc8QQXWqOcnqEj4KHWXKctQYAzGgHYlEJRF4Z0jEKn7BfN1DewkvRwEmVU
         DGHA==
X-Gm-Message-State: AOJu0Yza0VCgeCqd3z8Gt61kIiaTkEA7fwAAfRT5KfFtDKgRSZfV7Qbl
	XxRzlVHdyUdu590lksVJEcpWyRKNzeX7CfjteVb1GewOwFsAjk3a7pyUElvDvBI=
X-Gm-Gg: ASbGncuDwMtMO6Nx5pNkDOUFzPRAqeTzxqiwuQ9huP+nouGWCWkq8HW20FVvD4MJ0BQ
	oIOoJ2UUq2xAH5FY/sPB12j3nz+yzVHrOxNLt23TQdsrrvBO3Xo5oozHMkPDJbgar7ea5sxlzFh
	iIO+i6plxm7cQt0MU3pntakeGtJ0LetCLtrraXREEwspDrCRsywyWANw18p2j2DmcnFlieuF7cs
	3lxKzSXRlxq5qndaYjNBFDROFKTOzlrg5jui1lXqMwy2+1e8fDqcTWFUWs1QLP/XUhYojDELkGs
	Y2ifqq760H1QNpt4r1LlJuGO0Qyaax7OfoG0VRSJuHgP3uSMYrMv4XEDG6H87oLTODwMawSjp3b
	tCL4tYs6L3thcQ1jvi4Y=
X-Google-Smtp-Source: AGHT+IEpYG+sO24ltPABTJgvHEiBIBel0SKKVWBC7giLHZhMKaqWr/MRv6XTDzdh3f+t/rboS5mEEg==
X-Received: by 2002:a17:903:2301:b0:224:76f:9e44 with SMTP id d9443c01a7336-22649828e20mr51270295ad.8.1742421252987;
        Wed, 19 Mar 2025 14:54:12 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b0e8asm12175596b3a.158.2025.03.19.14.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:54:12 -0700 (PDT)
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
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	juntong.deng@outlook.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 04/11] bpf: net_sched: Add basic bpf qdisc kfuncs
Date: Wed, 19 Mar 2025 14:53:51 -0700
Message-ID: <20250319215358.2287371-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319215358.2287371-1-ameryhung@gmail.com>
References: <20250319215358.2287371-1-ameryhung@gmail.com>
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


