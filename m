Return-Path: <bpf+bounces-16415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA5E8012A8
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7033281A6B
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16192524BE;
	Fri,  1 Dec 2023 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="sIsZcRA+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35814129
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 10:29:13 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58de42d0ff7so1319391eaf.0
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701455352; x=1702060152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/QxvUzYS1W8RYq6mM2bceYbwgM8SdKWnwgWEo++oLE=;
        b=sIsZcRA+fOkg14GK2PlkHx8+ztoJDFAFjPe/+KPW+oJ1aNTrjWfPt0ISlg7K0mb4ZA
         Olhlc99HZjbQ1Kr/vCNzS9EUUAa/qgI24jHl+qG2sO2OYmznBu7JQ434+F27XuMI+UnN
         D1HJBFwS5LfIDE/ZCXZQRGGcFqqHCsrZ4Tg942LN4VQo/svLpAd90pVuH/1DokSRIRR9
         0z+2+Waqlio17xv1iCPE/RSrFexc0vamTi+wPq1JzBeOpKxgu57TnDEVWrH/Y++z68D5
         6eL5FzfqpI3Cojc5W+uR1YoWRknOgc7kh6vDrqxtO340k3O5kLHg62g6lQNwHWcp0TkD
         R52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455352; x=1702060152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/QxvUzYS1W8RYq6mM2bceYbwgM8SdKWnwgWEo++oLE=;
        b=ZoNRxtsS0oykn+gHyyjTi0ghrNgcTpe5oLRjtGDuF04HnRxAqegd5CgpJXi6rWYUOr
         VJYYLVBLkqd9TFOr7sUg+EA4gGC5xISPM5VQ8e9xNo2Dc3DGwzxqIL2ScZ8V70/5pFFR
         H6FYvvvCvO1nsQAjLc95OUy/smsIkLsg0u4HU5AXLxeOFFby5p7VxOR7L535dR5EAnGS
         nbMyK6D55UMlp4nsuZOT8/mhxfM7q2Qkt+DZfHYbQU4fjlLz7brgr4tR6dAPJjqqdA54
         239mmNF+TOSHUh3dzPRoZPpbaTpJahnWnMUr3qzV9Se2f0a961W87jCjfu0ejG4eXMWg
         vONw==
X-Gm-Message-State: AOJu0YwYNTztlQe2Rpg4cdKGXBB5p5lNj1GmL9evLmxEK0v3yjXN6H2a
	lqciTcAAobJDqjwiDL6BzRhsQQ==
X-Google-Smtp-Source: AGHT+IGg5LOeHL7X7aynu+Wi3/58B0QLIG/KMb/snNl3J9F6+yAQa9qW+6MnCuabOPOktO255SARSQ==
X-Received: by 2002:a05:6358:33a6:b0:16d:e151:a7d8 with SMTP id i38-20020a05635833a600b0016de151a7d8mr29676214rwd.14.1701455352433;
        Fri, 01 Dec 2023 10:29:12 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id s28-20020a0cb31c000000b0067a364eea86sm1702536qve.142.2023.12.01.10.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:29:11 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH net-next v9 04/15] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Fri,  1 Dec 2023 13:28:53 -0500
Message-Id: <20231201182904.532825-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201182904.532825-1-jhs@mojatatu.com>
References: <20231201182904.532825-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For P4 actions, we require information from struct tc_action_ops,
specifically the action kind, to find and locate the P4 action information
for the lookup operation.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index baba63d02..c59bc8053 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -116,7 +116,8 @@ struct tc_action_ops {
 		       struct tcf_result *); /* called under RCU BH lock*/
 	int     (*dump)(struct sk_buff *, struct tc_action *, int, int);
 	void	(*cleanup)(struct tc_action *);
-	int     (*lookup)(struct net *net, struct tc_action **a, u32 index);
+	int     (*lookup)(struct net *net, const struct tc_action_ops *ops,
+			  struct tc_action **a, u32 index);
 	int     (*init)(struct net *net, struct nlattr *nla,
 			struct nlattr *est, struct tc_action **act,
 			struct tcf_proto *tp,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 5ab1c75ce..ddef91233 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -726,7 +726,7 @@ static int __tcf_idr_search(struct net *net,
 	struct tc_action_net *tn = net_generic(net, ops->net_id);
 
 	if (unlikely(ops->lookup))
-		return ops->lookup(net, a, index);
+		return ops->lookup(net, ops, a, index);
 
 	return tcf_idr_search(tn, a, index);
 }
-- 
2.34.1


