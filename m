Return-Path: <bpf+bounces-19751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6DD830EDF
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 22:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771941C216A8
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 21:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883A9286B6;
	Wed, 17 Jan 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh+PkmMA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36E2562B;
	Wed, 17 Jan 2024 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528590; cv=none; b=Q2CYI2LGbajXXDmjNaWsmHsIb+2Vpz8K98x1tADFZsP3UaAutcCf/TK8XHUbkK7yFOH0hNhh1s0zBvwCCJOqqEyzBH0iht1Y/HjSFx+lMgBMaNdtXcfxv/L2len4PPAq4ExaVNXW6qAeSJG2AYZQzHgwhLhVWxYF7YYWzngJ9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528590; c=relaxed/simple;
	bh=PS35uwKUUOYbFtfV4djPNxakwFL36YGy5n1JSjA0rvQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=jL1g6JPgO4+moBCXvyuVKNEbVtAhpFbhqsTAAIItyao1cYjIDEP/jl04DjH2PJ+yBS1cehM1ljmJnXlV6GG8E5hsLArLwVYsEqy23jKcfEoc069O4l5+7qE+7SMxjy5Hkw6CSBdgWq8Rx0y/Q532eesbwqcK7YdYRVIqQ+qMqDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh+PkmMA; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-429fc7a1eacso21838881cf.2;
        Wed, 17 Jan 2024 13:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705528587; x=1706133387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQM2ylX/O5EIXXAsKxWvTLMgB+Lb4fb3EVYiX33BjKY=;
        b=fh+PkmMAZSqBdAUZcAnyv5G8kFa+qMrXEgJxgyy1n8WNoZlchfqH0QKidq3SDbn2g/
         Wum+2ZHsxEVYGDBMq8Vns4pHR1TzAHJB446NeRM4RFzmXZerlbmDPaFiVDbte/nZmYWn
         rDBmDZVhZqg6exCfIjc+jv5UtE05zkSokiu1ONTYdH6lo19PO/ifv9EpZCkP9LN2+gPW
         gdmSd+e8HKNtDUEG6/Wrr9hYrsdRNMqMo9FIhmaDC0b3bVu0KHDyl31RwqxSGlPBR8pI
         cNdUAxHqlv0EscvAS/zwSTNFua0/eqh+S2IBgC/CU+4hLpVoZbJeLuw6WT6qpFqCDrFY
         9deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705528587; x=1706133387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQM2ylX/O5EIXXAsKxWvTLMgB+Lb4fb3EVYiX33BjKY=;
        b=Sxk75y8hkZk/dpOc8fKPsQTH32zaOSyxL7gq8vDWYEmdwCkdkaLdbnze/2TbbeVaO7
         IvunWrEffebwjVxL4Iz0m+qQ0PB2xdJzUoYrSzfs81+VwuRMxl8Qi/cM7eicrqcPj9jw
         0GCV5vOtzf5OOY4foAOYTkV8ADe8b/CuR2Vv2ehZ7nb8Vc2+Xpy63f2ilvq9gAQnvUH5
         BqAsknq/cH3V2YNUvzVWgoeTuJHbmtxAtyGvuoRXoIGY+yNQJKttkbM2GCn7emIoO39j
         sTiksRwIjrM7oY4okAI0YHLWFYe4cyKcovmOnErQb/d/3DIyA1T93pECCNQiQMJ+beSj
         sAeQ==
X-Gm-Message-State: AOJu0Yw3e/vY2qJgdaCfkOZm3nBOP4Bsp3GbgtNCsM3qtlR0n+JJXOuj
	Xe/EPiZ2c59GhSsrCYsxTqNEeBLY20U=
X-Google-Smtp-Source: AGHT+IEi4hnjhSA0AuKZ6RCksU+Uv/5I4C2UbDc/UxC7jAeItwoHZngJ68v7OWkPAz+nmwfeQqfsEA==
X-Received: by 2002:a05:622a:2284:b0:42a:2b2:df24 with SMTP id ay4-20020a05622a228400b0042a02b2df24mr4003174qtb.23.1705528587440;
        Wed, 17 Jan 2024 13:56:27 -0800 (PST)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id hj11-20020a05622a620b00b00428346b88bfsm6105263qtb.65.2024.01.17.13.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:56:27 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com
Subject: [RFC PATCH v7 2/8] net_sched: Add kfuncs for working with skb
Date: Wed, 17 Jan 2024 21:56:18 +0000
Message-Id: <2d31261b245828d09d2f80e0953e911a9c38573a.1705432850.git.amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1705432850.git.amery.hung@bytedance.com>
References: <cover.1705432850.git.amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

This patch introduces four kfuncs available to developers:

struct sk_buff *bpf_skb_acquire(struct sk_buff *skb);
void bpf_skb_release(struct sk_buff *skb);
bool bpf_qdisc_set_skb_dequeue(struct sk_buff *skb);
u32 bpf_skb_get_hash(struct sk_buff *skb)

kptr is used to ensure the vailidility of skbs throughout their lifetime
in eBPF qdiscs. First, in the enqueue program, bpf_skb_acquire() can be
used to acquire a referenced kptr to an skb from ctx->skb. Then, it can
be stored in bpf maps or allocated objects serving as queues. Otherwise,
the program should call bpf_skb_release() to release the reference.
Finally, in the dequeue program, a skb kptr can be exchanged out of
queues and passed to bpf_qdisc_set_skb_dequeue() to set the skb to be
dequeued. The kfunc will also release the reference.

Since skb kptr is incompatible with helpers taking __sk_buff,
bpf_skb_get_hash() is added for now for the ease of implementing
flow-based queueing algorithms.

Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Co-developed-by: Amery Hung <amery.hung@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/sch_bpf.c | 83 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_bpf.c b/net/sched/sch_bpf.c
index 56f3ab9c6059..b0e7c3a19c30 100644
--- a/net/sched/sch_bpf.c
+++ b/net/sched/sch_bpf.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/btf_ids.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
@@ -520,9 +521,89 @@ static struct Qdisc_ops sch_bpf_qdisc_ops __read_mostly = {
 	.owner		=	THIS_MODULE,
 };
 
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+/* bpf_skb_acquire - Acquire a reference to an skb. An skb acquired by this
+ * kfunc which is not stored in a map as a kptr, must be released by calling
+ * bpf_skb_release().
+ * @skb: The skb on which a reference is being acquired.
+ */
+__bpf_kfunc struct sk_buff *bpf_skb_acquire(struct sk_buff *skb)
+{
+	return skb_get(skb);
+}
+
+/* bpf_skb_release - Release the reference acquired on an skb.
+ * @skb: The skb on which a reference is being released.
+ */
+__bpf_kfunc void bpf_skb_release(struct sk_buff *skb)
+{
+	skb_unref(skb);
+}
+
+/* bpf_skb_destroy - Release an skb reference acquired and exchanged into
+ * an allocated object or a map.
+ * @skb: The skb on which a reference is being released.
+ */
+__bpf_kfunc void bpf_skb_destroy(struct sk_buff *skb)
+{
+	skb_unref(skb);
+	consume_skb(skb);
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
+/* bpf_qdisc_set_skb_dequeue - Set the skb to be dequeued. This will also
+ * release the reference to the skb.
+ * @skb: The skb to be dequeued by the qdisc.
+ */
+__bpf_kfunc void bpf_qdisc_set_skb_dequeue(struct sk_buff *skb)
+{
+	consume_skb(skb);
+	__this_cpu_write(bpf_skb_dequeue, skb);
+}
+
+__diag_pop();
+
+BTF_SET8_START(skb_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_skb_acquire, KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_skb_get_hash)
+BTF_ID_FLAGS(func, bpf_qdisc_set_skb_dequeue, KF_RELEASE)
+BTF_SET8_END(skb_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set skb_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &skb_kfunc_btf_ids,
+};
+
+BTF_ID_LIST(skb_kfunc_dtor_ids)
+BTF_ID(struct, sk_buff)
+BTF_ID_FLAGS(func, bpf_skb_destroy, KF_RELEASE)
+
 static int __init sch_bpf_mod_init(void)
 {
-	return register_qdisc(&sch_bpf_qdisc_ops);
+	int ret;
+	const struct btf_id_dtor_kfunc skb_kfunc_dtors[] = {
+		{
+			.btf_id       = skb_kfunc_dtor_ids[0],
+			.kfunc_btf_id = skb_kfunc_dtor_ids[1]
+		},
+	};
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_QDISC, &skb_kfunc_set);
+	ret = ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
+						 ARRAY_SIZE(skb_kfunc_dtors),
+						 THIS_MODULE);
+	return ret ?: register_qdisc(&sch_bpf_qdisc_ops);
 }
 
 static void __exit sch_bpf_mod_exit(void)
-- 
2.20.1


