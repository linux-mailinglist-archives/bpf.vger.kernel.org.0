Return-Path: <bpf+bounces-19753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BE4830EE2
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 22:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D271F23497
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 21:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C21A28DA2;
	Wed, 17 Jan 2024 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO8Nm7Ej"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D5725637;
	Wed, 17 Jan 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528590; cv=none; b=BsDd36zaDvxqEpBB0/c7+RQkIIo4z2LGIo/L1JFX0DNS5f87dBJnCfmF/zbPqA/wW6IacNYJpWx7Qbm/GxVn2nZ4gUj+sCu22LgSrQwrmNL6bLnqugeAZYAsUrb0SgtesDbLfFhti+ebfT85fe0hHoGbD7St1clpkVEVldWhS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528590; c=relaxed/simple;
	bh=1iVlF9N/CW7ESvz3Eoi/t41Ro5gcaQ18eBluQOzy5mY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=DdMW9XeXoJn4FsHpiqh3ZqbRTE3IBYqZ30kpIkQisOTwCuXM4v4RGNkB0EdegnWs2LIzeDBmji/Rb2SFUCqPqSPTPmsUmiLVVsdc9RmXEFTOr1uqeOSkCYt20a9FZDQvq186aDtAOHJdStanBYsObp2/spJxLMUp1kIvUvW1tpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO8Nm7Ej; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dde1f23060so5280225a34.2;
        Wed, 17 Jan 2024 13:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705528588; x=1706133388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPkGxkT4+R0IPK4IYArd5bblmoZ7caNjmTqGy5ddOHw=;
        b=TO8Nm7Eji6Y8/2iQceV61zYk/M4HdZho35eYSLcqUlOPV1iSZAkY1cPNAwxokhCCDj
         ETZumDdwpSMwX5QLkPxMgejS78Kmszm/NVx8LIPNgwxG8tauz1zZBKkas7aQmuAT3Wgz
         /uQPXfjoUnmn0NFgkKbYwRhbHG8SZHruU2PzwoBxUkoXJKmqnBiDXtJsML0NC6/BzRsO
         J2STAUNx1aC6teHWLfRDblpI2OBu/2UGx/9aXlYpynCzcCRJvyNCrJZPgV8Sw0ODE9U6
         gESw3TwSvBm5D3OzjMih8fbdQhclAiu+VkizpHlfFNG2ib7Xr2gunJ3Ykrh1927mhQPn
         vroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705528588; x=1706133388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPkGxkT4+R0IPK4IYArd5bblmoZ7caNjmTqGy5ddOHw=;
        b=TrXJljQWt1Zm1L+yF2AWTjoEvS3X1cIdoD0pqKE6PKymoOnL34UfeCkMB/pXXhkoCC
         qqXxc4stQ3h22ff0yb3YdDc21oErVBsoXfCFTuEeWxyXjZFfPdyQwiFNdW3ldrKxjbZb
         UMdkGCG+HRclvbzio9h5AFADnL/bwS10gJ8dfAOVYBmRHVujzniJSxjm5snf5KOcc+XN
         WBbK4qvex3w/sJ4QGBJMph+Hfu9Iij4uNPUt2x4uxDNWyv4rxZ00pqClqJvkCGIkM4GB
         RN+uE+wLUFrIExWUSELBiZ+n74dzGmENUhnMN4nFPL1PjU68k1IcQ8tXvPNOy6sfSOHG
         jU6g==
X-Gm-Message-State: AOJu0YydDT8m3ZbiUjQU8tMJkSMON5dTlYpXICKu98R1bz+kVGC1udd2
	gDMJbrTrGM1IHUQ8/gfqnUEAAYhxfJM=
X-Google-Smtp-Source: AGHT+IEb7boVBcg0A9ZDHfJT86UXu5lurfifGxrIQZhESq8BpkHgQud+w4o03eGvB5dwtrSYr2Q+Hw==
X-Received: by 2002:a9d:7dd6:0:b0:6dd:df7c:52f6 with SMTP id k22-20020a9d7dd6000000b006dddf7c52f6mr8437599otn.44.1705528588287;
        Wed, 17 Jan 2024 13:56:28 -0800 (PST)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id hj11-20020a05622a620b00b00428346b88bfsm6105263qtb.65.2024.01.17.13.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:56:28 -0800 (PST)
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
Subject: [RFC PATCH v7 3/8] net_sched: Introduce kfunc bpf_skb_tc_classify()
Date: Wed, 17 Jan 2024 21:56:19 +0000
Message-Id: <d95508d28c8e3549c975c4b67a305ecce7306878.1705432850.git.amery.hung@bytedance.com>
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

Introduce a kfunc, bpf_skb_tc_classify(), to reuse exising TC filters
on *any* Qdisc to classify the skb.

Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Co-developed-by: Amery Hung <amery.hung@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/sch_bpf.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/net/sched/sch_bpf.c b/net/sched/sch_bpf.c
index b0e7c3a19c30..1910a58a3352 100644
--- a/net/sched/sch_bpf.c
+++ b/net/sched/sch_bpf.c
@@ -571,6 +571,73 @@ __bpf_kfunc void bpf_qdisc_set_skb_dequeue(struct sk_buff *skb)
 	__this_cpu_write(bpf_skb_dequeue, skb);
 }
 
+/* bpf_skb_tc_classify - Classify an skb using an existing filter referred
+ * to by the specified handle on the net device of index ifindex.
+ * @skb: The skb to be classified.
+ * @handle: The handle of the filter to be referenced.
+ * @ifindex: The ifindex of the net device where the filter is attached.
+ *
+ * Returns a 64-bit integer containing the tc action verdict and the classid,
+ * created as classid << 32 | action.
+ */
+__bpf_kfunc u64 bpf_skb_tc_classify(struct sk_buff *skb, int ifindex,
+				    u32 handle)
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
+		result = tcf_classify(skb, NULL, tp, &res, false);
+		if (result >= 0) {
+			switch (result) {
+			case TC_ACT_QUEUED:
+			case TC_ACT_STOLEN:
+			case TC_ACT_TRAP:
+				fallthrough;
+			case TC_ACT_SHOT:
+				rcu_read_unlock();
+				return result;
+			}
+		}
+	}
+out:
+	rcu_read_unlock();
+	return (res.class << 32 | result);
+}
+
 __diag_pop();
 
 BTF_SET8_START(skb_kfunc_btf_ids)
@@ -578,6 +645,7 @@ BTF_ID_FLAGS(func, bpf_skb_acquire, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_skb_get_hash)
 BTF_ID_FLAGS(func, bpf_qdisc_set_skb_dequeue, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_skb_tc_classify)
 BTF_SET8_END(skb_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set skb_kfunc_set = {
-- 
2.20.1


