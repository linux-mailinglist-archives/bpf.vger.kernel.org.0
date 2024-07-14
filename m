Return-Path: <bpf+bounces-34784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B175E930B18
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 19:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D451A1C20A34
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 17:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A3C1422DD;
	Sun, 14 Jul 2024 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaMMClLv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD79813D533;
	Sun, 14 Jul 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720979498; cv=none; b=ilens5c6tx9HRJy38/aySDuX39nD56DwA6he2G/nLszWnjKPF9YL6TvcUckZ0EyUXe6GGMIl9HQY6v4or8a+8twpIIY/TBXa+vzP7cp1t5jaNPRZ9tUH+rIykn2EtsR0ypu9/XcVko8cmdMdpSFO0iFs080wDnpkM+VUkEtDJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720979498; c=relaxed/simple;
	bh=AN9wqcxf+Cnk2mtFvgspphR5J77vPVWFHbM72TABR34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rKiXpzH99oJJagTdYRVYmMDVGZYdVL8NyUZ65W5n5OJF20DZhW/DcsFHOcciYHAOH2WQQtJf7+tESLOOLR9D62z+vC2q/SkT5UyHs0oLJwWDBGOJgDk54A3S5hDLNWNRjUauAC5i5XK/zEl014pNjzkTH9V0Iyt8gsUvHsal/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaMMClLv; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79f08b01ba6so306705285a.0;
        Sun, 14 Jul 2024 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720979495; x=1721584295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UZab7fQwrfuoaKVlP492SgUXnAcCK4tkBL6m5X64RM=;
        b=HaMMClLvXe6zBxFU/a+4f1gFTeSVg4Q8lCB4EptkeCuhAo45owPRBKjH3DXdHGGn75
         4ftieyxHiOTBI4Y7xNALoy8ETQnvG/fJD08cbde3Okq8g5mLmrFcl4GTdib+rgJ9UCFI
         l72J1MxW+7LNZKTmNPshKZGN9m1xSPAcJxUp+Zu0YsjBWTRBaoyVEfg4I4bs+bwuUKZe
         CZ30M5uPfYHitrN5F3VIltGl+At6YCf1RzSDj5361O9KJMPtw2bLO0toAQZewsnQO6tg
         U7EN19MSQvWoLSB0JmHfI4dbSlVdcWjKNCF1Nfm/Pxyw5mdMAdXa2EmzvQdcBBGIPETZ
         ES2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720979495; x=1721584295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UZab7fQwrfuoaKVlP492SgUXnAcCK4tkBL6m5X64RM=;
        b=HnQOoiAGAAjuNgQ8Rn3W6xfmv3haOlTVqbC59yhr715iJszmjSaXYpSzWnVk1BTufR
         WVev6NXp1iwrEhO8OzBcmWL97iQcQZgKtbYkxzD1RyLNXO5gsbAEELvS+/eG62lc5Wd5
         3QjM6xRWAzlj+eqf2RQit5yLoR+4eOn9DXtDE72bkh2Hgyhrayu5HwAdbYNT3apy8rT2
         fpxr7Er8AQHsU0L4jTBFdS50s8ZjLF2x7pIqwjSLIX2utu0upRgMyusUFI+IoJZGDABR
         /X4UL22pc0rIubPQd6wednd66r41n340PPextC2Wk8XJhpGPtnjZrSHuJgtHH2voCBCN
         iQ6Q==
X-Gm-Message-State: AOJu0Yxj8i7av5cuE96HkEDGRl+E01OK4usygvlKAOSwuHDOcOAolMsE
	zvV9X0FBTwRVMEMunvZDCF5J034NO2SrOnbz5c/nKZ7If0Z9rbt1/EL9uA==
X-Google-Smtp-Source: AGHT+IHccMpLiY+7BpVDbwyVOyufenpMXyXZePIIUUvlKvcircESjWH9YL+atcI37ARj5kitgG+jyA==
X-Received: by 2002:a05:620a:a10:b0:79b:a8df:7829 with SMTP id af79cd13be357-7a152fe0b08mr1272247785a.14.1720979495404;
        Sun, 14 Jul 2024 10:51:35 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7e1e38sm17010481cf.25.2024.07.14.10.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 10:51:35 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v9 06/11] bpf: net_sched: Add bpf qdisc kfuncs
Date: Sun, 14 Jul 2024 17:51:25 +0000
Message-Id: <20240714175130.4051012-7-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240714175130.4051012-1-amery.hung@bytedance.com>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kfuncs for working on skb in qdisc.

Both bpf_qdisc_skb_drop() and bpf_skb_release() can be used to release
a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
in .enqueue where a to_free skb list is available from kernel to defer
the release. Otherwise, bpf_skb_release() should be used elsewhere. It
is also used in bpf_obj_free_fields() when cleaning up skb in maps and
collections.

bpf_qdisc_schedule() can be used to schedule the execution of the qdisc.
An example use case is to throttle a qdisc if the time to dequeue the
next packet is known.

bpf_skb_get_hash() returns the flow hash of an skb, which can be used
to build flow-based queueing algorithms.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 74 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index a68fc115d8f8..eff7559aa346 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -148,6 +148,64 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
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
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_skb_get_hash)
+BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
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
@@ -347,6 +405,20 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 
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


