Return-Path: <bpf+bounces-29533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B138C2A96
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA9E2824FD
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95835A4CD;
	Fri, 10 May 2024 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bImthb92"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37851C33;
	Fri, 10 May 2024 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369066; cv=none; b=bd3HNw4wG/L3FipsNdsOKTg3zYBQXSGXs0xP9kFcNnXL38MqA4adkqhC8UOjxGGCL9PNccVmzmpsww6O1TZPasOPm5GpOhUlsz5X4R7yEHRppHcVpvRS1/I1XAyBJw2/0ZqL8vrMNt9i8LH07iVNfjZ6RbfKKQanyUkWZ6zpyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369066; c=relaxed/simple;
	bh=JcgJgP4QF+fBtYObSbzOevCEnALGEv+7UrUjbVZ4I14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V3dVyoxoxtUlkkims6BhDiqSxuofBvrLxD8/gB4r9nDFxgGswfcH7M5KAwhnn9QnoteVahw4Nx7EAdTV822V838oCjOZvfN5nzGWc5vcidvmkxg3CSqN4yUIZMceKarJJuVKNMW9ngeUyeBi4GegeRGHQKXM7zA6R4eYR9Zbk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bImthb92; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6202ad4cae3so20561777b3.2;
        Fri, 10 May 2024 12:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369062; x=1715973862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCCMzj6W98Sbdlylo//bYfzGNMOyUb2ACdHxeYhqLCA=;
        b=bImthb92M5ZMekXwDiDwNiDKk1WHYcIjFho3iiS49AJNQLsg7rNWGa8BRttkiyi1lX
         mgW6IwJ32GaaonJakYVQOkWbYKR03L1Xvg0HFD+2S4aL9ohCU787EL+T0/9S232zlbQR
         eoBmR6y3bzc7HjywFUAko36PuVQv2Y75JbVc4L3XWMnWs1vKyf/WoNY5WZ2llaGosyUu
         71rVMi2pHQc2rRAKuTqEnZL27SWrySwg6DvRb+wOjZeBUeswZdkxwIMcUI4rA7K9oOBS
         ctyROdXqZgOyMWn/tzPswuN9DXNS8xz5UGiJFDckVnAzJRRePHyCQS/9gVQ/gl50c1S6
         Swxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369062; x=1715973862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCCMzj6W98Sbdlylo//bYfzGNMOyUb2ACdHxeYhqLCA=;
        b=cbt1xUlIBk/kzu0XIpBsH8faqcmsCZvr9BzQuo/ojkSR3StYtbAGhXh8ZLBo8M/fG/
         4Ois1IPibNv0OvDIE5q1JZeWoNRImFnF4w+veFmemiF8cFH/cXrTeKgrkwHpTklBEOvE
         AFrdjDQJX0TPgQinNwvHDPhUAG7vDjo4gnFMp91XskW6QPNTJ4wLpoIPmYy/uor4Y4lW
         xRaMiAKqyQxDvkcVKhIia/pXO6QnS3A4UdumrM53HzaFQ1lt5R8C6+WSvA/ulbjARcJu
         mjw4tfxDt/P9AWOeISeNhmzopJaur2cbpBFXylfysNdniolJMH8v0LQ0GDrDabTPE+k3
         Is9w==
X-Gm-Message-State: AOJu0YyYZX7q5AuH8hfGnhVgv9X5aW695jkzuKGeDawDQRj0MiMN/kS8
	TA7fbDtV/agdLPKKFsBDgew8/rliWEprZOl+6A1cVHHS/mIddBsv6k6UTw==
X-Google-Smtp-Source: AGHT+IF4cHcApfaBFcLRBGm4PboNiYvgYqfewUBAjHoXJ6K6I4epC0SoyY7JAOCeXr+vxGrxSvb7Tg==
X-Received: by 2002:a81:7602:0:b0:620:3c10:527a with SMTP id 00721157ae682-622aff64a28mr32228007b3.15.1715369062135;
        Fri, 10 May 2024 12:24:22 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:21 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 14/20] bpf: net_sched: Add bpf qdisc kfuncs
Date: Fri, 10 May 2024 19:24:06 +0000
Message-Id: <20240510192412.3297104-15-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds kfuncs for working on skb and manipulating child
class/qdisc.

Both bpf_qdisc_skb_drop() and bpf_skb_release() can be used to release
a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
in .enqueue where a to_free skb list is available from kernel to defer
the release. Otherwise, bpf_skb_release() should be used elsewhere. It
is also used in bpf_obj_free_fields() when cleaning up skb in maps and
collections.

For bpf_qdisc_enqueue() and bpf_qdisc_dequeue(), kfuncs that pass skb
between the current qdisc and a child qdisc, classid is used to refer
to a specific child qdisc instead of "srtuct Qdisc *" so that it is
impossible to recursively enqueue or dequeue skb to a qdisc itself.
More specifically, while we can make bpf_qdisc_find_class() return a
pointer to a child qdisc, and use it in enqueue or dequeue kfuncs
instead of classid, it would be hard to make sure the pointer is not
pointing to the current qdisc, causing indefinite resursive calls.

bpf_qdisc_create_child() is introduced to make the deployment easier and
more robust. It can be called in .init to populate the class hierarchy
the scheduling algorithm expect. This saves extra tc calls and prevents
user errors in creating classes. An example can be found in the bpf prio
qdisc in selftests.

bpf_skb_set_dev() is temporarily added to restore skb->dev after removing
skb from collection. Apparently, we cannot rely on the user to always
call it after every remove. This will be addressed in the next revision.

Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Co-developed-by: Amery Hung <amery.hung@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 239 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 238 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 53e9b0f1fbd8..2a40452c2c9a 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -358,6 +358,229 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 	return 0;
 }
 
+__bpf_kfunc_start_defs();
+
+/* bpf_skb_set_dev - A temporary kfunc to restore skb->dev after removing an
+ * skb from collections.
+ * @skb: The skb to get the flow hash from.
+ * @sch: The qdisc the skb belongs to.
+ */
+__bpf_kfunc void bpf_skb_set_dev(struct sk_buff *skb, struct Qdisc *sch)
+{
+	skb->dev = qdisc_dev(sch);
+}
+
+/* bpf_skb_get_hash - Get the flow hash of an skb.
+ * @skb: The skb to get the flow hash from.
+ */
+__bpf_kfunc u32 bpf_skb_get_hash(struct sk_buff *skb)
+{
+	return skb_get_hash(skb);
+}
+
+/* bpf_skb_release - Release an skb reference acquired on an skb immediately.
+ * @skb: The skb on which a reference is being released.
+ */
+__bpf_kfunc void bpf_skb_release(struct sk_buff *skb)
+{
+	consume_skb(skb);
+}
+
+/* bpf_qdisc_skb_drop - Add an skb to be dropped later to a list.
+ * @skb: The skb on which a reference is being released and dropped.
+ * @to_free_list: The list of skbs to be dropped.
+ */
+__bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
+				    struct bpf_sk_buff_ptr *to_free_list)
+{
+	__qdisc_drop(skb, (struct sk_buff **)to_free_list);
+}
+
+/* bpf_qdisc_watchdog_schedule - Schedule a qdisc to a later time using a timer.
+ * @sch: The qdisc to be scheduled.
+ * @expire: The expiry time of the timer.
+ * @delta_ns: The slack range of the timer.
+ */
+__bpf_kfunc void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 delta_ns)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_watchdog_schedule_range_ns(&q->watchdog, expire, delta_ns);
+}
+
+/* bpf_skb_tc_classify - Classify an skb using an existing filter referred
+ * to by the specified handle on the net device of index ifindex.
+ * @skb: The skb to be classified.
+ * @handle: The handle of the filter to be referenced.
+ * @ifindex: The ifindex of the net device where the filter is attached.
+ *
+ * Returns a 64-bit integer containing the tc action verdict and the classid,
+ * created as classid << 32 | action.
+ */
+__bpf_kfunc u64 bpf_skb_tc_classify(struct sk_buff *skb, int ifindex, u32 handle)
+{
+	struct net *net = dev_net(skb->dev);
+	const struct Qdisc_class_ops *cops;
+	struct tcf_result res = {};
+	struct tcf_block *block;
+	struct tcf_chain *chain;
+	struct net_device *dev;
+	int result = TC_ACT_OK;
+	unsigned long cl = 0;
+	struct Qdisc *q;
+
+	rcu_read_lock();
+	dev = dev_get_by_index_rcu(net, ifindex);
+	if (!dev)
+		goto out;
+	q = qdisc_lookup_rcu(dev, handle);
+	if (!q)
+		goto out;
+
+	cops = q->ops->cl_ops;
+	if (!cops)
+		goto out;
+	if (!cops->tcf_block)
+		goto out;
+	if (TC_H_MIN(handle)) {
+		cl = cops->find(q, handle);
+		if (cl == 0)
+			goto out;
+	}
+	block = cops->tcf_block(q, cl, NULL);
+	if (!block)
+		goto out;
+
+	for (chain = tcf_get_next_chain(block, NULL);
+	     chain;
+	     chain = tcf_get_next_chain(block, chain)) {
+		struct tcf_proto *tp;
+
+		for (tp = tcf_get_next_proto(chain, NULL);
+		     tp; tp = tcf_get_next_proto(chain, tp)) {
+
+			result = tcf_classify(skb, NULL, tp, &res, false);
+			if (result >= 0) {
+				switch (result) {
+				case TC_ACT_QUEUED:
+				case TC_ACT_STOLEN:
+				case TC_ACT_TRAP:
+					fallthrough;
+				case TC_ACT_SHOT:
+					rcu_read_unlock();
+					return result;
+				}
+			}
+		}
+	}
+out:
+	rcu_read_unlock();
+	return (res.class << 32 | result);
+}
+
+/* bpf_qdisc_create_child - Create a default child qdisc during init.
+ * A qdisc can use this kfunc to populate the desired class topology during
+ * initialization without relying on the user to do this correctly. A default
+ * pfifo will be added to the child class.
+ *
+ * @sch: The parent qdisc of the to-be-created child qdisc.
+ * @min: The minor number of the child qdisc.
+ * @extack: Netlink extended ACK report.
+ */
+__bpf_kfunc int bpf_qdisc_create_child(struct Qdisc *sch, u32 min,
+				       struct netlink_ext_ack *extack)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct sch_bpf_class *cl;
+	struct Qdisc *new_q;
+
+	cl = kzalloc(sizeof(*cl), GFP_KERNEL);
+	if (!cl)
+		return -ENOMEM;
+
+	cl->common.classid = TC_H_MAKE(sch->handle, TC_H_MIN(min));
+
+	new_q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
+				  TC_H_MAKE(sch->handle, min), extack);
+	if (!new_q)
+		return -ENOMEM;
+
+	cl->qdisc = new_q;
+
+	qdisc_class_hash_insert(&q->clhash, &cl->common);
+	qdisc_hash_add(new_q, true);
+	return 0;
+}
+
+/* bpf_qdisc_find_class - Check if a specific class exists in a qdisc.
+ * @sch: The qdisc the class belongs to.
+ * @classid: The classsid of the class.
+ */
+__bpf_kfunc bool bpf_qdisc_find_class(struct Qdisc *sch, u32 classid)
+{
+	struct sch_bpf_class *cl = sch_bpf_find(sch, classid);
+
+	if (!cl || !cl->qdisc)
+		return false;
+
+	return true;
+}
+
+/* bpf_qdisc_enqueue - Enqueue an skb into a child qdisc.
+ * @skb: The skb to be enqueued into another qdisc.
+ * @sch: The qdisc the skb currently belongs to.
+ * @classid: The handle of the child qdisc where the skb will be enqueued.
+ * @to_free_list: The list of skbs where a to-be-dropped skb will be added to.
+ */
+__bpf_kfunc int bpf_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch, u32 classid,
+				  struct bpf_sk_buff_ptr *to_free_list)
+{
+	struct sch_bpf_class *cl = sch_bpf_find(sch, classid);
+
+	if (!cl || !cl->qdisc)
+		return qdisc_drop(skb, sch, (struct sk_buff **)to_free_list);
+
+	return qdisc_enqueue(skb, cl->qdisc, (struct sk_buff **)to_free_list);
+}
+
+/* bpf_qdisc_enqueue - Dequeue an skb from a child qdisc.
+ * @sch: The parent qdisc of the child qdisc.
+ * @classid: The handle of the child qdisc where we try to dequeue an skb.
+ */
+__bpf_kfunc struct sk_buff *bpf_qdisc_dequeue(struct Qdisc *sch, u32 classid)
+{
+	struct sch_bpf_class *cl = sch_bpf_find(sch, classid);
+
+	if (!cl || !cl->qdisc)
+		return NULL;
+
+	return cl->qdisc->dequeue(cl->qdisc);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_skb_set_dev)
+BTF_ID_FLAGS(func, bpf_skb_get_hash)
+BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
+BTF_ID_FLAGS(func, bpf_skb_tc_classify)
+BTF_ID_FLAGS(func, bpf_qdisc_create_child)
+BTF_ID_FLAGS(func, bpf_qdisc_find_class)
+BTF_ID_FLAGS(func, bpf_qdisc_enqueue, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_qdisc_dequeue, KF_ACQUIRE | KF_RET_NULL)
+BTF_KFUNCS_END(bpf_qdisc_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_qdisc_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_qdisc_kfunc_ids,
+};
+
+BTF_ID_LIST(skb_kfunc_dtor_ids)
+BTF_ID(struct, sk_buff)
+BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
+
 static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
 	.get_func_proto		= bpf_qdisc_get_func_proto,
 	.is_valid_access	= bpf_qdisc_is_valid_access,
@@ -558,6 +781,20 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 
 static int __init bpf_qdisc_kfunc_init(void)
 {
-	return register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
+	int ret;
+	const struct btf_id_dtor_kfunc skb_kfunc_dtors[] = {
+		{
+			.btf_id       = skb_kfunc_dtor_ids[0],
+			.kfunc_btf_id = skb_kfunc_dtor_ids[1]
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
2.20.1


