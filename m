Return-Path: <bpf+bounces-22583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF8861280
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 14:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD278285426
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062337F479;
	Fri, 23 Feb 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="HoMkIe9Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC07EF00
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694265; cv=none; b=gyjoVUqOTQUK5SCq3O8oF52RN6SgitT314o54YYMBXbUYZ5ZrYP1ksQewp0OKnF6iJ1YpLT4pswfRdnmFsvxibIPHAXNgeLWv/2PjDOWaa7f/sGTLNFRiJPE2dE8NDXcsWTNrHkJ4Pk2EA/+OV80fyORWibnVZCP9mYqRxNm6qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694265; c=relaxed/simple;
	bh=M4If/UOYvi0X5ofyVN5k561/nL5KTpuzPE6SiFq38Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJTtmN4SJoWI1CZYYlVbuwApuxs99qgAsLFwrxU0Tu7iwhym5G3XkAOo/QSh5aTfmSTudLTUsHTX+CZF9Q60kRg33p3cNNEvVQdZjKIFFph3FG5pRctmQCOVDxloSUwdpKNJC7kVfC/J6bxYGQg+Si4v4Uu/pWi7qO48fk4Wjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=HoMkIe9Z; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-787bb013422so5221585a.0
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 05:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708694263; x=1709299063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKOnDKEjrpcKuEtJ9C4jK4dD7Y3mugzMjgQ2qo2O6Vc=;
        b=HoMkIe9ZvHSYpZ77ZZg/BWucghITKikQC9uSaaJ1o+hQrguy+OkJK4I4keCq2wjLmA
         2QmB11+FGBJ3w6XmBp/hnHn+KqpwFsLSzhld7LiYZl9nmvsadsR8tiR1MYFHORHd5k9K
         QpOW2pmg6lYK7gygyDSO6FmZTtEqslGVvD+wnMQNWKv1otYMPwqw/X5uKYoQsqpu3yvl
         cpIX6D/hJtCMNTwsRylSrcRE/LF77yKSvdgecqBSo4MPhvkmt2Trka9hUvk1lAWF/vfK
         4Jz9EP9B1UGYCXxWH5Z1ByH4G1pSC1823esBM1bMHgcLpbdaN7TySkHUVgH7cWY8i353
         GDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708694263; x=1709299063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKOnDKEjrpcKuEtJ9C4jK4dD7Y3mugzMjgQ2qo2O6Vc=;
        b=DfScRV+Pr3PmEt6lUsU/FsxSNfNv4G8r5puT9M39L2JOhxsiL7R9MT0W3xAK1zOuHp
         us/xMQK5+VjpnqVAk42zYWZZDqA4IHkLOFCwYl5+W/JLIyNJk1nbUw7z/BodTZX/E6o4
         SG9PDw/8dfLkP9B9NXeXj2H+T5r48mqM8RUyU+NGYVzyTvT6KvBNxiNT0bzCbcDyj1Z/
         ro8FHhrrFhIJGb7j1TfDDtYtsPPn13AqKRZ8vFq5ntyM/4b04Lah8Z6CFQ9Gc0HS1Bx6
         JU8z3Rts8fRFvH5LiBwuw8NBMFL4lmaTbUCftUHhmoAyIFbsw+TNLSwhCd7tp+q+ZH+V
         Jxyg==
X-Forwarded-Encrypted: i=1; AJvYcCXhVguFpWwUSZ8w32vQgNfyDzskZ0NPUTMpAfiKFaL8Wetkh01NtXYFVMNCzzC2q0LX5R7mulAEgT2SNk/44RTTDMwg
X-Gm-Message-State: AOJu0YzZJ/ikDazwZ4TY5zMw9Vr+pBNwJADLBIwQlnza9vC/a+6VeAtx
	QuDpOWqu/sYqX8kmXPTxh91gw7eJLR9avz3aad31atvhXkt6gw96EvzfU7iFPg==
X-Google-Smtp-Source: AGHT+IF2PKC7Pynbc1M4DjhxglVtwZtdZgWh62Cbp1FJUuX8roOXxt0B5zTj/sY+326RHFLcEgdx1Q==
X-Received: by 2002:a05:620a:12ce:b0:787:1fb5:7e61 with SMTP id e14-20020a05620a12ce00b007871fb57e61mr1833574qkl.46.1708694262935;
        Fri, 23 Feb 2024 05:17:42 -0800 (PST)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id f3-20020a05620a15a300b00787ae919d02sm844869qkk.17.2024.02.23.05.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:17:42 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
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
	mattyk@nvidia.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next v11 3/5] net/sched: act_api: Update tc_action_ops to account for P4 actions
Date: Fri, 23 Feb 2024 08:17:26 -0500
Message-Id: <20240223131728.116717-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223131728.116717-1-jhs@mojatatu.com>
References: <20240223131728.116717-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initialisation of P4TC action instances require access to a struct
p4tc_act (which appears in later patches) to help us to retrieve
information like the P4 action parameters etc. In order to retrieve
struct p4tc_act we need the pipeline name or id and the action name or id.
Also recall that P4TC action IDs are P4 and are net namespace specific and
not global like standard tc actions.
The init callback from tc_action_ops parameters had no way of
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
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 include/net/act_api.h |  6 ++++++
 net/sched/act_api.c   | 14 +++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index c839ff57c..69be5ed83 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -109,6 +109,7 @@ struct tc_action_ops {
 	char    kind[ACTNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
+	refcount_t p4_ref;
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
index ce10d2c6e..3d1fb8da1 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1044,7 +1044,7 @@ int tcf_register_action(struct tc_action_ops *act,
 	struct tc_action_ops *a;
 	int ret;
 
-	if (!act->act || !act->dump || !act->init)
+	if (!act->act || !act->dump || (!act->init && !act->init_ops))
 		return -EINVAL;
 
 	/* We have to register pernet ops before making the action ops visible,
@@ -1517,8 +1517,16 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
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


