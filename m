Return-Path: <bpf+bounces-15179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA17D7EE396
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719831F24592
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5234CD3;
	Thu, 16 Nov 2023 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="evL7B5a1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAF0D57
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 06:59:58 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77896da2118so51951885a.1
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 06:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700146797; x=1700751597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIV5QitfFPU0bda5paAuqKfjcm6a/cu+ASvMTADTiqQ=;
        b=evL7B5a1LHRopeVPqcN+U6p51BFBWiV9LFSzLw2tjFUZ6B47H10qJX1L2jC6fwctNv
         1Qh5bhdfhOIPx4cOJF/x4r1LkEy1YpQ3B+gcYb474P5qKKpIf1NKoRwNQRhie4SlJXMr
         Tgk/JfCGItbGx32ORRxHEoBnK8Duvrx0yrza/odFjwZ6UK+iTaIFK7zD+EVW7r88wsFI
         L0w6dMhGvnv6jhwvFXe0Mzb0iH6HTEzS0pHUuFnJjrjxpUJcAv/WkYQneby5ubWeK7XD
         gajwj1X/e6ay0j1Ckh3nG2EpDMy+1V5GB8nfr/bN1CmlBl4i5j9+EXrnNG3Cugu5sHa7
         TLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146797; x=1700751597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIV5QitfFPU0bda5paAuqKfjcm6a/cu+ASvMTADTiqQ=;
        b=nnHIeH258oXuB6N2TfPVY7vLNkQbZAEqQSRNt2h/OMdVDLiPrde1u1QrRaueOkUafp
         nJtFiDqqSHpm6s8L9wJR8TEFlRiW4nCRW+F/S3vLUnK9bcCudM/Zji0BsMa4bT4+DLPp
         XpsJvQqjcQa127CjEirMoAa8Bxqk0X2YLlA99iPwdxWnu+bMBw/NDxtIfdo0hRf+yldu
         d7WlhJDHuHmrBKNgQNedqifSkc6XW9Aom7RYncxUs6w/J85UxcNMk4Ad71S4MU80caGb
         fyJ31jNbwqXjn/K0RzHL9BA0wI2oI6MjqSMlIo3B8GZNFsz9nBw7LuJQRKVAt3xasvpC
         38Jg==
X-Gm-Message-State: AOJu0YyT3xiTQOhSx0Oe88hFt4mZfLs9VMp4A7XWGO3vowRIB76KMecj
	K2cXBwGv9/2O4j3Kr75Or2ej2w==
X-Google-Smtp-Source: AGHT+IELbxKcCD34FauDbPc6GKNzm9+VZ8zyO5Mv/03k1DG2mpip9GFQktpYI5mBq75LprPk/ksOxQ==
X-Received: by 2002:a05:620a:3951:b0:775:446b:85fa with SMTP id qs17-20020a05620a395100b00775446b85famr10530377qkn.3.1700146797590;
        Thu, 16 Nov 2023 06:59:57 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a241500b00774376e6475sm1059688qkn.6.2023.11.16.06.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:59:57 -0800 (PST)
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
Subject: [PATCH net-next v8 03/15] net/sched: act_api: Update tc_action_ops to account for dynamic actions
Date: Thu, 16 Nov 2023 09:59:36 -0500
Message-Id: <20231116145948.203001-4-jhs@mojatatu.com>
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

The initialisation of P4TC action instances require access to a struct
p4tc_act (which appears in later patches) to help us to retrieve
information like the dynamic action parameters etc. In order to retrieve
struct p4tc_act we need the pipeline name or id and the action name or id.
Also recall that P4TC action IDs are dynamic and are net namespace
specific. The init callback from tc_action_ops parameters had no way of
supplying us that information. To solve this issue, we decided to create a
new tc_action_ops callback (init_ops), that provies us with the
tc_action_ops  struct which then provides us with the pipeline and action
name. In addition we add a new refcount to struct tc_action_ops called
dyn_ref, which accounts for how many action instances we have of a specific
action.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
---
 include/net/act_api.h |  6 ++++++
 net/sched/act_api.c   | 14 +++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index b38a7029a..1fdf502a5 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -109,6 +109,7 @@ struct tc_action_ops {
 	char    kind[ACTNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
+	refcount_t dyn_ref;
 	size_t	size;
 	struct module		*owner;
 	int     (*act)(struct sk_buff *, const struct tc_action *,
@@ -120,6 +121,11 @@ struct tc_action_ops {
 			struct nlattr *est, struct tc_action **act,
 			struct tcf_proto *tp,
 			u32 flags, struct netlink_ext_ack *extack);
+	/* This should be merged with the original init action */
+	int     (*init_ops)(struct net *net, struct nlattr *nla,
+			    struct nlattr *est, struct tc_action **act,
+			   struct tcf_proto *tp, struct tc_action_ops *ops,
+			   u32 flags, struct netlink_ext_ack *extack);
 	int     (*walk)(struct net *, struct sk_buff *,
 			struct netlink_callback *, int,
 			const struct tc_action_ops *,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 641e14df3..41cd84146 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1023,7 +1023,7 @@ int tcf_register_action(struct tc_action_ops *act,
 	struct tc_action_ops *a;
 	int ret;
 
-	if (!act->act || !act->dump || !act->init)
+	if (!act->act || !act->dump || (!act->init && !act->init_ops))
 		return -EINVAL;
 
 	/* We have to register pernet ops before making the action ops visible,
@@ -1484,8 +1484,16 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 			}
 		}
 
-		err = a_o->init(net, tb[TCA_ACT_OPTIONS], est, &a, tp,
-				userflags.value | flags, extack);
+		/* When we arrive here we guarantee that a_o->init or
+		 * a_o->init_ops exist.
+		 */
+		if (a_o->init)
+			err = a_o->init(net, tb[TCA_ACT_OPTIONS], est, &a, tp,
+					userflags.value | flags, extack);
+		else
+			err = a_o->init_ops(net, tb[TCA_ACT_OPTIONS], est, &a,
+					    tp, a_o, userflags.value | flags,
+					    extack);
 	} else {
 		err = a_o->init(net, nla, est, &a, tp, userflags.value | flags,
 				extack);
-- 
2.34.1


