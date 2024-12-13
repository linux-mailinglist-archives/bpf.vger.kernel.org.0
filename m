Return-Path: <bpf+bounces-46953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9829F1A08
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E34A16B446
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203421F428A;
	Fri, 13 Dec 2024 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Htq04AlO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037C01B4F1A
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132612; cv=none; b=hj+wTXqJWFob/MO78YeGAZiDy+5yicp4vicjKRKbdM9RNafimIh4k/EL7Sjmx45sYK8jqyfy9w1ZXBRIyqdwKoT6+k/g5schwH0Iua/UYcp6aCyeDOo76urTqdnbB1cHNU8PNZ4fvFLqbnccrUFSo7NsGrkHIL99P/d877W6HBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132612; c=relaxed/simple;
	bh=u4js09ZrJprP9Ct6KS/KG66aSEf0301PiPjx92HhRYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htfR8+g/h3IQUAk9iudg8Fkq6eImKNlhVCg/bmF0pNw8rsuZqLlVtiExU8L64VVvZaJvZi5j5sw86rP5pm6oJ+obcdlpUSRYX8E/ojrJ8CI4OCDVVbW/P4yy6VVRqZMGg8+WL4PQBSjFd2oFbVA9K4lXWAXBWaOwXJc8gy2RZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Htq04AlO; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467a1ee7ff2so15649061cf.0
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 15:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132610; x=1734737410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsUHCw4T0E7XChR9WsYxTd868449t9RXx5ZWu1kInUM=;
        b=Htq04AlOlj5VkevqSqDPSSvoCiTKcpm6D8OxycxzNdf2rOBwvdi3CVGm+vHVWOhJco
         hcGd8rJJFIyd4JbBBsOdiopBHK7SY5NmXv3S5Tg2mPAdTbb3wzCKwVPdJzixgnWk/oS/
         GqqHR5B2e47DnK2zX1yexsMPvMZm3syERf0yTEVeHG9XQ+SnJT8bkX5UjT8m3gymNbS9
         6bo5K8xMzDRDKl8mgqmQMPmRppiWDqZUMuhPYx+/xw73TKhOY9WD6axBr6QjNQfubXVp
         Ir5G0vKpGJqq6dvA3wYATAgEQMrIcHaknqYePY0yLNQWcJb/v1SQwvItkvkc7gNEjOMY
         dqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132610; x=1734737410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsUHCw4T0E7XChR9WsYxTd868449t9RXx5ZWu1kInUM=;
        b=rAYfLewvu3uU2ZxV25ccXMzGTLjoK35fh3gZRfHf9hniafqK4/ppm8Z46MkqXZ+zjs
         j2nztibE4tNUWpAdPIyRzAymwQPuBVXcgu7OSCxYYZzIqpaVZqy18s/V7IhaPk83ntIC
         VxtIW6m86xlZf3LCLRK1vDkFgB0A99c2EI+J2GxavRxkoYCAl9ACeJc6GBwfI7kY2Qjs
         Z9JQKHZFniZvhbnEwBWA2JRIEOS7Kus+xSxi7tkjEyKKposFbcf0UUVFWJpCCzEB2m5W
         Fwz7V7uY+FvL6+ReUxAUAFoFBbgmnbKaWhdNZkyomF9vyDYLLSp1h6jKpFGjBTCVMek+
         VNQg==
X-Gm-Message-State: AOJu0YyrRvWfcMQ0xSJ+0ZJmhFjL0hUCQog/pQ1jQ1I7xXlbG9HJgvV7
	PjDdRyYfpIJd3wh/VVIVzVhtFfJ49NoITbK1YLaivydgYLvOJpDtHA6DBJ0dsp8=
X-Gm-Gg: ASbGncsZmnZbqViEYvrtXraCn4Iwq5HENsIxFz2lXbPRVKDlAkVg6xz7aJf/hZBi0HD
	FzAydpMSK/UCEV5KIJFVrBCyLQSMxTE7C1109gLBgW0q/QZmyEFC5e/3zGHb21kT1/+M3+FYEYl
	BpfKL36kLnWa5q1ECB7nC47YaNDmTRZWG/yofDalOdfpdZqXgF1tJKx9cBsb+fLu8OoMTAlCFQx
	2HNhgBxov7VOeAHglWwKFVpeLzmPGjqEAJsx33b8vDNdEjt5Zeo+HIa0pzMTvfS7AzyvGQNkFSH
X-Google-Smtp-Source: AGHT+IF1w0JRYjaYuWkP2HsGdMaLVD3k7SbV34NZbx2XywOZUx4L6+IKiXSlKL9dxXI81FbxYMYgIQ==
X-Received: by 2002:ac8:7dd6:0:b0:466:96ef:90c with SMTP id d75a77b69052e-467a5829a18mr66297661cf.41.1734132609973;
        Fri, 13 Dec 2024 15:30:09 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:09 -0800 (PST)
From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf-next v1 08/13] bpf: net_sched: Support updating bstats
Date: Fri, 13 Dec 2024 23:29:53 +0000
Message-Id: <20241213232958.2388301-9-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241213232958.2388301-1-amery.hung@bytedance.com>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kfunc to update Qdisc bstats when an skb is dequeued. The kfunc is
only available in .dequeue programs.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 7c155207fe1e..b5ac3b9923fb 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -176,6 +176,15 @@ __bpf_kfunc void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64
 	qdisc_watchdog_schedule_range_ns(&q->watchdog, expire, delta_ns);
 }
 
+/* bpf_qdisc_bstats_update - Update Qdisc basic statistics
+ * @sch: The qdisc from which an skb is dequeued.
+ * @skb: The skb to be dequeued.
+ */
+__bpf_kfunc void bpf_qdisc_bstats_update(struct Qdisc *sch, const struct sk_buff *skb)
+{
+	bstats_update(&sch->bstats, skb);
+}
+
 __bpf_kfunc_end_defs();
 
 #define BPF_QDISC_KFUNC_xxx \
@@ -183,6 +192,7 @@ __bpf_kfunc_end_defs();
 	BPF_QDISC_KFUNC(bpf_kfree_skb, KF_RELEASE) \
 	BPF_QDISC_KFUNC(bpf_qdisc_skb_drop, KF_RELEASE) \
 	BPF_QDISC_KFUNC(bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS) \
+	BPF_QDISC_KFUNC(bpf_qdisc_bstats_update, KF_TRUSTED_ARGS) \
 
 BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
 #define BPF_QDISC_KFUNC(name, flag) BTF_ID_FLAGS(func, name, flag)
@@ -204,6 +214,9 @@ static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 		if (strcmp(prog->aux->attach_func_name, "enqueue") &&
 		    strcmp(prog->aux->attach_func_name, "dequeue"))
 			return -EACCES;
+	} else if (kfunc_id == bpf_qdisc_bstats_update_ids[0]) {
+		if (strcmp(prog->aux->attach_func_name, "dequeue"))
+			return -EACCES;
 	}
 
 	return 0;
-- 
2.20.1


