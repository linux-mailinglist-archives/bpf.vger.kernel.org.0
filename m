Return-Path: <bpf+bounces-22692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47EE862C0C
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 17:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A62B21374
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 16:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238EF1B959;
	Sun, 25 Feb 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="p0i0N8Oy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A1134A5
	for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880104; cv=none; b=kJZkg4zAHL6ajDwadfl6Emv7RimKCU2hHITZ/NjkhMYTyzOgFg3hgRSNpzKfCriPlL7yRlxReEkt+GPmrHCUZ/vjpTKzMkQYTtw5F3xjOkJw0WVSo36K1nmPhi6e6kpSwO5jL+BahZhTtzV3wh1RhFqkZP5D4bwb3wGsuQYcxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880104; c=relaxed/simple;
	bh=M4If/UOYvi0X5ofyVN5k561/nL5KTpuzPE6SiFq38Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JPhfPMq+D8oU9o/2DDwaTEqDyFFje7iyxtRyxbWfeZBhTLt9Rs9Eq3jUcJRPoLvJ/kvDIl1hMcqtfKjCYGhcwckvZOQqGnT+t+wgQ2Nx6SVIoJy7jos1Pglo+HXmCf9oQ+6E/sgCFUC2M7yjbtvz0Y05IX503WevkdT9Lq0BkiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=p0i0N8Oy; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-787bb0d85eeso156449085a.0
        for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 08:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708880102; x=1709484902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKOnDKEjrpcKuEtJ9C4jK4dD7Y3mugzMjgQ2qo2O6Vc=;
        b=p0i0N8OyqdFKAud5VkZV/Xi3bvDstierVD/I/y4uEFclWsRX1KCu2nIkXjLngEaljy
         9wgkK2YFNz35qH1afjPdpVHae91luZf3mVOV5Q66xIOjsoq3PUFgv3N8PmwonNCqBt87
         9AazTMaNRoH8Z/CnIoIFyDlKq4TwZUPHvIKHKfa7TDaxPfOQXxtRFUcIOnT2wCJqQdW6
         4xGUfez54AVxTUtsMKD+ncAW4PwZ68dioeKyOWy+iI7w3i6z2+0FrQd/2Mqa2pK9GbO7
         qf91sHFcBjE6hcdGgb4jfUnklMzM3l7mKL88+eIjnbPajJ3Oc/5tEgZMJQ9y2SkQhzcL
         1nqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708880102; x=1709484902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKOnDKEjrpcKuEtJ9C4jK4dD7Y3mugzMjgQ2qo2O6Vc=;
        b=UmmDPE7cRy+d1xlA+dRunVRgHEjuYhghEGdIfaKyiuKRvKPghc38x82kiXg+R9rwBa
         2no/KyHacluAl3fCSIVyeD81nLYCWjg7utLsvHJ46rK2Wl5WJfVs4M4Z9QBLCP8d8sQ3
         glW/DRcM87AtSemnDvZwfxLOhVjUtV8X3UDbMyydEIycINqRAa+xKwCy53WHIJ0DWUKU
         4zKJMiaU6bEIlPCLlWFI2pwAcgYDlf6TqX+ULJP/zf5qfCXy1wKEbpo+o4+wRxDeJjF7
         nmI706s8XLTDw0KahiZ61K94F1zJ2izfNI3Dr4Bp5odhhJf/fp107j9a413sy1YaEaGC
         cnBw==
X-Forwarded-Encrypted: i=1; AJvYcCX46/2pwQQqYuJ/xpVET7DeqLNIUkxLl8cnhGgya9Dx25hyDKTvKwOJtKeVAmBcGUmGvahY4YrL3kumKL4pjMI2ttzz
X-Gm-Message-State: AOJu0YzSUwBPjXGc9Iz+2IhXrgbw9/18obfMAHoNIOnV9xzU38B5sexn
	29e/XOAGf2H6cYFdEqWBF40zt0aAyviVoVHNuysGFKsVtsFfZF05ytOe6MY7lA==
X-Google-Smtp-Source: AGHT+IGHRw2NjIkhgFYbjG8mzTCuZ9gArNfc9ivFrZ6UZW7V3Ac9Vbj2ldSfZhCiWC5YMjZPkQ3LEA==
X-Received: by 2002:a05:620a:172c:b0:787:d190:ae81 with SMTP id az44-20020a05620a172c00b00787d190ae81mr1072128qkb.2.1708880101817;
        Sun, 25 Feb 2024 08:55:01 -0800 (PST)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a14b500b00787ba78da02sm1620698qkj.93.2024.02.25.08.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:55:01 -0800 (PST)
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
	daniel@iogearbox.net,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next v12  03/15] net/sched: act_api: Update tc_action_ops to account for P4 actions
Date: Sun, 25 Feb 2024 11:54:34 -0500
Message-Id: <20240225165447.156954-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240225165447.156954-1-jhs@mojatatu.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
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


