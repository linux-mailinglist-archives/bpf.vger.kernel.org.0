Return-Path: <bpf+bounces-16414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D018012A3
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B421C20DFF
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F8E4F8BC;
	Fri,  1 Dec 2023 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="UA8VG79G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2640193
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 10:29:11 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-58cdc801f69so1446040eaf.3
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 10:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701455351; x=1702060151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7sOjzOE8nfzRaYjLNL4s14LmsOqYy+4iQOHktEsKVU=;
        b=UA8VG79GVAL1LqaVxIoUB0jhaU8ZFwNgnJ8t71dTDaTtfcgh9nNV27sP8dOnBYmfvt
         lcvm2PfABetsH6lUNP8idLxbsfHPW83KF6Lv3ofUrGpEuYsM1OeUesGClGkLVnIxhk+C
         T6+oRaG4XMceFoYU1zua7gVu7W25Vf9ofrhO3HDceoPR9Lu5jrFbrcPzDTKsM+jZlZNW
         +8EDyU/hhhV3KecHFwx/i5r+duMY6XHqA6fmO+Or5pcYPih4Qt4PBFqvNKvZiRzxUe6K
         Ne64ceZsCuX+7ton3SOpc6lZ010KMY52Y4OtwfBQOz7gF6gxrQSVmq0BF31iP9KdMDMa
         anXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455351; x=1702060151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7sOjzOE8nfzRaYjLNL4s14LmsOqYy+4iQOHktEsKVU=;
        b=YvGqxtGyhe28BZP/0+xTfHPNUWVuN/wjw0CGd+asdHdT/gpsxdveETs7xMNFRPoJIJ
         mUsaYT8gNj6kJc+I+NmIwtF69etUCw85jS8bY+os20ydzf8tFwTswE4Qw/AFNooC8ZUe
         9r1y4gZiw34AfSAR0HJflR8Pnej1DJQVvvI0LuRSMZqEeNr6HnLExBtVpOpVGkttZ/Bn
         O85nwypiJeBJ4O4q4SU8Zi+4GgcEDRaDwjHsXb+UxOkinz7oOqDHL/k88E6GX4tD95n+
         ddk8xgBxWWknUalJAHe7+VsM/4reOVs9cwmRMMifrTIh3TNy1o62rmqnmPB0TCj4WZPa
         kzvw==
X-Gm-Message-State: AOJu0Yy+lymgfjMEb2UMQGJh1P0nop1Jjzk816Knu2NE18CTxPXyCqnr
	R1QCH+7ABEM9Q4AbKWrLVSBVuA==
X-Google-Smtp-Source: AGHT+IH+9qhFhPnRpPwoOBwgU6EtmVVTVJtMmhXl5aVpIbmcuQQ48AsrsJjd93Fg3cUBQoiZKxGFsw==
X-Received: by 2002:a05:6358:260c:b0:16d:edaa:921c with SMTP id l12-20020a056358260c00b0016dedaa921cmr28798999rwc.12.1701455351089;
        Fri, 01 Dec 2023 10:29:11 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id s28-20020a0cb31c000000b0067a364eea86sm1702536qve.142.2023.12.01.10.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:29:10 -0800 (PST)
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
Subject: [PATCH net-next v9 03/15] net/sched: act_api: Update tc_action_ops to account for P4 actions
Date: Fri,  1 Dec 2023 13:28:52 -0500
Message-Id: <20231201182904.532825-4-jhs@mojatatu.com>
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

The initialisation of P4TC action instances require access to a struct
p4tc_act (which appears in later patches) to help us to retrieve
information like the P4 action parameters etc. In order to retrieve
struct p4tc_act we need the pipeline name or id and the action name or id.
Also recall that P4TC action IDs are P4 and are net namespace specific.
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
---
 include/net/act_api.h |  6 ++++++
 net/sched/act_api.c   | 14 +++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 4bccc9c59..baba63d02 100644
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
index e6792495e..5ab1c75ce 100644
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


