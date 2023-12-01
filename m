Return-Path: <bpf+bounces-16413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 562F88012A4
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8580B20FDC
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26F351024;
	Fri,  1 Dec 2023 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DaXgKYL1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6581106
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 10:29:10 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-423ec1b2982so14961201cf.2
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 10:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701455350; x=1702060150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5fUO27fPdxstwPfyvEmG4o87itC2tu7WDrjeySVB0k=;
        b=DaXgKYL1ir9S9oqWL2VrXxtIgYy1daalUGSOJFeXrV2SBobHZgqObbAKUJh5DRyzsF
         JwY/BCCnZSbb8jDzSK0wzaegxNugBRRtkAqACrFob2vUbsS6GyIcxQ08wSJ9TOcaYZJw
         tJVfweLw1zNxMYr9pCkm1n9LuqayORnoPU1LLHV9Rzmh74mJieF+th5CW939TkOHm97B
         4IthnyrcysS7RQgF55k8I6K+1wj6Xaj/RBby1RCRSOnCwWIL9grgAyLG+tHpw0b+uS0d
         HdMznMKskDj1dB7DAY3CNVRq/j3Mvv13jYaOVAHTIZ3A0m3y6RX5lYDMJMlmJ+fjtKIp
         oMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455350; x=1702060150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5fUO27fPdxstwPfyvEmG4o87itC2tu7WDrjeySVB0k=;
        b=VqWW/8QWgORuWxjodmEMddvp56Xc/b4K8BWINDmiYmm/9/oQiz/4fAqSrKkDK0bDK0
         D5Y4HrJ2Y/YoqbLeLJSJKreOPWVoGH9T9OTsKzXlI5a2Yal1bqKBWGoy4IYCbImi/p6E
         AFt++J4qsm+JsvYa3ouBlSQ3aj/ajkggTIyAFjYGs8P8Lc/hEcgnj+uWV0m/Y4mW2zx9
         NwKjjGdckvAm+FWknWsfkeNxFsqifKuupiJVLjAkOMMkqHsC6CJ9Z8s8hyT3OtKQCPQi
         bL3wXHDqIY5dCZUok2KsgMQClLApnwX2hLXuLHalOy2g6aM1kPJ+De4F3QwTvV1bErgr
         Xxnw==
X-Gm-Message-State: AOJu0YxX2h3RAsqG0a+Pkh0fE7UX8a/BW4MpiUvJyNnxJUSuos7mNfxp
	tfN1NF3TVWPtyjQlQKptNZnjzw==
X-Google-Smtp-Source: AGHT+IGjQXsLnRybU7XC3viNzNk5RE7kyLSgv3rBEvJmCbT6riZspqJ/oGCcHycrCYQx9qvVwsfT5g==
X-Received: by 2002:a0c:fd4c:0:b0:67a:6343:3049 with SMTP id j12-20020a0cfd4c000000b0067a63433049mr9943327qvs.45.1701455349789;
        Fri, 01 Dec 2023 10:29:09 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id s28-20020a0cb31c000000b0067a364eea86sm1702536qve.142.2023.12.01.10.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:29:09 -0800 (PST)
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
Subject: [PATCH net-next v9 02/15] net/sched: act_api: increase action kind string length
Date: Fri,  1 Dec 2023 13:28:51 -0500
Message-Id: <20231201182904.532825-3-jhs@mojatatu.com>
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

Increase action kind string length from IFNAMSIZ to 64

The new P4  actions, created via templates, will have longer names
of format: "pipeline_name/act_name". IFNAMSIZ is currently 16 and is most
of the times undersized for the above format.
So, to conform to this new format, we increase the maximum name length
to account for this extra string (pipeline name) and the '/' character.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
---
 include/net/act_api.h        | 2 +-
 include/uapi/linux/pkt_cls.h | 1 +
 net/sched/act_api.c          | 6 +++---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index bd50a50f4..4bccc9c59 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -106,7 +106,7 @@ typedef void (*tc_action_priv_destructor)(void *priv);
 struct tc_action_ops {
 	struct list_head head;
 	struct list_head p4_head;
-	char    kind[IFNAMSIZ];
+	char    kind[ACTNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
 	size_t	size;
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index c7082cc60..75bf73742 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -6,6 +6,7 @@
 #include <linux/pkt_sched.h>
 
 #define TC_COOKIE_MAX_SIZE 16
+#define ACTNAMSIZ 64
 
 /* Action attributes */
 enum {
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 52f6be39f..e6792495e 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -476,7 +476,7 @@ static size_t tcf_action_shared_attrs_size(const struct tc_action *act)
 	rcu_read_unlock();
 
 	return  nla_total_size(0) /* action number nested */
-		+ nla_total_size(IFNAMSIZ) /* TCA_ACT_KIND */
+		+ nla_total_size(ACTNAMSIZ) /* TCA_ACT_KIND */
 		+ cookie_len /* TCA_ACT_COOKIE */
 		+ nla_total_size(sizeof(struct nla_bitfield32)) /* TCA_ACT_HW_STATS */
 		+ nla_total_size(0) /* TCA_ACT_STATS nested */
@@ -1393,7 +1393,7 @@ struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
 {
 	struct nlattr *tb[TCA_ACT_MAX + 1];
 	struct tc_action_ops *a_o;
-	char act_name[IFNAMSIZ];
+	char act_name[ACTNAMSIZ];
 	struct nlattr *kind;
 	int err;
 
@@ -1408,7 +1408,7 @@ struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
 			NL_SET_ERR_MSG(extack, "TC action kind must be specified");
 			return ERR_PTR(err);
 		}
-		if (nla_strscpy(act_name, kind, IFNAMSIZ) < 0) {
+		if (nla_strscpy(act_name, kind, ACTNAMSIZ) < 0) {
 			NL_SET_ERR_MSG(extack, "TC action name too long");
 			return ERR_PTR(err);
 		}
-- 
2.34.1


