Return-Path: <bpf+bounces-20027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F1837312
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 20:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57A11F295F9
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 19:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A9140C10;
	Mon, 22 Jan 2024 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QNI3DvZf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DC2405D6
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952894; cv=none; b=q/fC0oggVeCsagkAWRtHurF8ME2erbEnktEl7i4QSIG4GFeHvsdw4FSS3EeJPY4i6JhOOpUQv6EB2W6WaWEDICMAYFWrQqXANVKHE1RSbYLq6ajZNEaryRJ/CnB2VDM6yVegtAr67mDadDRY2RXRk6LIMAbDTcZrVPkwJsaYdvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952894; c=relaxed/simple;
	bh=qPgU1raJt5M+By+0iKa5iAmhHHXZUrTVbCSGDTBMM90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gAFuRcpa1YZxtUWWiugN1iThsmOkudKdT2g0biOWihnQQK09c1E28INRao/M0EBKJrtXRIPzXDG0NNSElFXleJ3Ahqqjto25FaXlERa/Ues0GBfNxzVtFVztm7yMCnPVvst8cUG1PK+61pyfMyLkF+FDWzvImWwAgzZteyqyL5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QNI3DvZf; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6851dd6b3c3so19387156d6.0
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 11:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705952891; x=1706557691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIizuJMriUpVqsDUBVE82AZKNEwW2eJ1h4ZfGtYcEOY=;
        b=QNI3DvZfNDhVJdhQUPl833dv6i5xqrcYTs6ZwytKBNpc6vwY88ULD1HCXxuervzvjU
         kHj2lG0BJUbzaiFDfKPUtu4lOcZjVNVEZR4aop+4L23yXX1PQo4PVOxYq9USkVlU6zbg
         1c013UFBWfK55U1eo22voparULhXNWE6yrbztKWa+XSyKeKDne79wJBHUYwbwtHbAweO
         YgKsoJwEcvnoBzirDSapEfOTM7KeIVBoDwWe1jjo8Jt4t8t2dpXoPR1/1T4UFNxOdbsA
         fjmPnNv87zMRQ0un4gSU831iUTkXIuUEICkDaHh8A0gy/kW+2l23cTsVZFZ3VneaVz49
         w0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952891; x=1706557691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIizuJMriUpVqsDUBVE82AZKNEwW2eJ1h4ZfGtYcEOY=;
        b=XF6LpmvKY5tnNPRfVJuomWIgdkF+H5k18o0WI8wvoMPh0mSN7mTHgAVDWRtbphyMZv
         V1XI6IstFIrOTs2gAgDisDWK6d+aeG66gHjz7IONChC4/5I6ydTVMuQvOWrgnNN3R4YU
         R+Eaa6/R+97cFuS9YnMWFxkByT9xZ3o4kiGmoT1NLO+aQgreiJzLhkmbIq1bCE05aSsG
         LBDm/WSRvmydG5sDzae4NvUKE+W+J+y3chOcBLmTJtmNfLi83IOm6Bp67bRFFavTW6rh
         mf98GQZoy31yejyUl1nflRzbsgIzO8Rfxbclia18HqXUpzRlxfDgIvWNvBioCLOx8nXg
         +RQQ==
X-Gm-Message-State: AOJu0Yw+AQXqdpV8LXbS2m6R8a2Tuu0OpagnYMFG87vXQF6qSm/3T10K
	jR9gyEoENiv+C9cOwF+rSvcoQxhY9TPMq8jJtCIn4gx5zOY8ISFiEPqg8FHynQ==
X-Google-Smtp-Source: AGHT+IHoOGteBbAQs1aoZtppH1NCwgntwdCLsS/IxWOpiawtggw4pQTwpu0yzzZzMqcGI29o0JBJyQ==
X-Received: by 2002:a0c:9c49:0:b0:685:62a9:f2db with SMTP id w9-20020a0c9c49000000b0068562a9f2dbmr4818155qve.31.1705952891478;
        Mon, 22 Jan 2024 11:48:11 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id pf9-20020a056214498900b006818be28820sm1288601qvb.24.2024.01.22.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:48:11 -0800 (PST)
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
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH v10 net-next 03/15] net/sched: act_api: Update tc_action_ops to account for P4 actions
Date: Mon, 22 Jan 2024 14:47:49 -0500
Message-Id: <20240122194801.152658-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122194801.152658-1-jhs@mojatatu.com>
References: <20240122194801.152658-1-jhs@mojatatu.com>
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
---
 include/net/act_api.h |  6 ++++++
 net/sched/act_api.c   | 14 +++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index eb39a2101..bfded7ec6 100644
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
index 2ff61be8e..c6a783a71 100644
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


