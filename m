Return-Path: <bpf+bounces-15181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F23427EE39B
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3981F24C1A
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9376134CFA;
	Thu, 16 Nov 2023 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="XH40GGss"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88364D6A
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 06:59:59 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77bcbc14899so51980785a.1
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 06:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700146798; x=1700751598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CxgBtAeoCOzrQq9o2MeONnc4kUEw++dQ/IsevO5EGk=;
        b=XH40GGssbxAuVOyn8PAkjBmzF5v8YAVDPT2K0hxk8CtLOdSVfnIyML8uy3xZu3BVSY
         yA6mt9Tkz4pQ/CujV+uSyd9nSmnH8lXaEnHZf2ifafbnzhvoE61d1V+oye0xUYCbk1CC
         E9Jh3/3pPAmp5bvHja4QtV5LDV1PG8jkVb1IAPTJUmn75vq0IduR4CPBdS1ZooXYm/Rp
         Nc0K6dTAXPzXoLCegIYJ0jqoV1akjUWeAY8Mdm8hoeSA7NLm4lWJ6KPR+vQCs9aDPADH
         5umrbNVfCs3WwV1iEyrxp5xY8CI94myKXBLlIfbNKDdrWczt3GMIHygvrc/LHcZ9QcRN
         Ld7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146798; x=1700751598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CxgBtAeoCOzrQq9o2MeONnc4kUEw++dQ/IsevO5EGk=;
        b=cyZ25PC6sSdlJEcSyCh7m2JnHTa1fl/htXlY5NVN8qnf1XdO/KR4Z0VXs7eG0qcA9n
         e2NlOq5QcWelaIRYk8RSaa61IM1arjRrU//oNKc1iowmr9of4BL8iv4rQtbQsFmKbq/n
         akQOpbZESnXZ/4zSEH0RGb/LwMmi3yvOxoJCFORr0mjOiHWKyiw7ch/X8xeQuNIZwoGX
         BKLfxAWRuo6ejXfxQJGfzmSUM25IAEjkr05pDAteJH9RG9AumUhLJSZFvPOEgOagNpqw
         lfcco54s6zdGtd1G6NHnerjZp6SEChkd8rdZ4ZKHp0vxhkUvGQfbpjp6QOpvW+jCHyaw
         ewCQ==
X-Gm-Message-State: AOJu0Yynu3K/UzJ1YO1ZhGQgNxvCUyXHuFbxg2LehTGTz7nyZKOQd/CN
	amZDgSdmnl3M7IIFiqjoPzivmA==
X-Google-Smtp-Source: AGHT+IE8W+k45NG7cuBfPFa42eH+Kk/SuNmGyABEZ7rXKQH+JPM4er/co/yvFcJhoC5fvqQUlw+T3w==
X-Received: by 2002:a05:620a:4722:b0:779:d406:c0e3 with SMTP id bs34-20020a05620a472200b00779d406c0e3mr10416186qkb.62.1700146798687;
        Thu, 16 Nov 2023 06:59:58 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a241500b00774376e6475sm1059688qkn.6.2023.11.16.06.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:59:58 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
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
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH net-next v8 04/15] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Thu, 16 Nov 2023 09:59:37 -0500
Message-Id: <20231116145948.203001-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116145948.203001-1-jhs@mojatatu.com>
References: <20231116145948.203001-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For P4TC dynamic actions, we require information from struct tc_action_ops,
specifically the action kind, to find and locate the dynamic action
information for the lookup operation.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 1fdf502a5..90e215f10 100644
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
index 41cd84146..b277accc3 100644
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


