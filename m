Return-Path: <bpf+bounces-26425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BDF89F96A
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 16:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B8EB33D10
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 14:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FBC15F3F1;
	Wed, 10 Apr 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="EVmMqImq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D615ECF7
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757709; cv=none; b=GvR5j3N9vpBSI4bOfEb3Z435ZShQgNosycEDOicyxFPyLw856GMxIfyleZUp6aXeQNJtXlEyKs5cE1HuwWMK5gq7AqPed2jIr/DJ/eSHM2xG7nCxK0vvp6B+B180U0EgNRl1yw3b+VWv3l491yl06e6z7CEVnjSXxBCAg7pTGJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757709; c=relaxed/simple;
	bh=JL27iICh89ltKE4GuIncUDr6GVz3MY3L/eSRyHifscA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2sB+DrDw3ipOS0WnXdPJtz6M3M3MWQwI1NdBFyMEzYH/FDKgxn+49iSVbFyrbPShBf5bCsYLj/AkVfjiD6Pe2yMRqUAAMNrkw6Ezts9jI4zlEg5lNcmePO6reTBbFVMii5CpFis7tVK3YhIT0HTUxoOyXT2veVUAFOvmUZsE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=EVmMqImq; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78a2290b48eso427923185a.3
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712757706; x=1713362506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q39ntDDoAul7qBpI1vQp2pR/Nao9RjIcwM/Dv3z1jAE=;
        b=EVmMqImqivFvj8naeklRy324+SEh80olntfVsBNfgOiczpx9J931L+5RoRVgwQCUXA
         sBGxX2fBuOPbYvZGGHZJh0twxM7qoo1nwhgD7BAiPilQ1hkZC2/6hJxVkRZRWiQVukYj
         ns0Z7OG6Z7FonQpql3WAX1G6lPZ5+VpnwkPoD21w+HlM5XMFW5Igisy2AwFbaLkJQZcI
         sP2MSrufX9IMVR+gddTgRfRyR7S/XB/AMQZc/bjiueht2suDObvvUzs4XyAcimsle+/s
         5coNbxOz5jFNNNv+usqtBZa1j9PEErZlx/v7yOalU8fYANr+G5D4jcmWyq6/pg1YpKU4
         wClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757706; x=1713362506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q39ntDDoAul7qBpI1vQp2pR/Nao9RjIcwM/Dv3z1jAE=;
        b=Df/WJztSjm3TH1yUSIGV02S4Jvo1eE/wyuHhjttZdYqiu34ed2cCFSgk11tkoIW8dL
         wLyDWHsyDR8vOTfrz7kxBwTeT29YmZ9nzUwkc5mO/sHZouOsdDLjMOLZP102WpjTIWXr
         kY18RcTAzeh6kiSDLlEl/Rkn7fbpcEI9Yya4lmbI7mWWK1Onf7IoT7oooCh7c1bKt3fR
         rv1oKReSknnQr7oJvpBIAawYi6cxVNy6SX/J3Hr0ZQAVvXy6MBxKFY3UCnQM9OlUEdo5
         7PSiBRojh7+G/qA/7JEMvpB9dw6P5klzSx/uGRJqUGopUCSYVfyE0fdoqdaXSQSb6vCK
         06gw==
X-Forwarded-Encrypted: i=1; AJvYcCUkshydAwZ4rMCNLFaX5wY2/9nc8Qm85iIXMHLWkbUE4zS+pAO7bWaoDhNe9O5cWoP2m2Eyh5IjcP/Ds74Iw13u5TKw
X-Gm-Message-State: AOJu0Yzvmo/YlyyomB1MxzjoVwn1Y813rlztewDXHhe/E3coLTjamCCX
	2t6//serUDqz81ObBUIT2fbK9UDxRNDXRKifxe5LpwfJ9rJqtmPqlLQRm05Zfg==
X-Google-Smtp-Source: AGHT+IHxrlqyTfTMkHdDHxdBLds2/E0+VI/7F+K59r4KB++ZnhDCe4Oc2h+x3Gf63f5RIZlMkgO80g==
X-Received: by 2002:ae9:e305:0:b0:78d:60e8:fc2d with SMTP id v5-20020ae9e305000000b0078d60e8fc2dmr2718951qkf.78.1712757706315;
        Wed, 10 Apr 2024 07:01:46 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id t30-20020a05620a035e00b0078d74f1d3c8sm1345173qkm.110.2024.04.10.07.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:01:45 -0700 (PDT)
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
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next v16  02/15] net/sched: act_api: increase action kind string length
Date: Wed, 10 Apr 2024 10:01:28 -0400
Message-Id: <20240410140141.495384-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410140141.495384-1-jhs@mojatatu.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Increase action kind string length from IFNAMSIZ to 64

The new P4 actions, created via templates, will have longer names
of format: "pipeline_name/act_name". IFNAMSIZ is currently 16 and is most
of the times undersized for the above format.
So, to conform to this new format, we increase the maximum name length
and change its definition from IFNAMSIZ to ACTNAMSIZ to account for this
extra string (pipeline name) and the '/' character.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/act_api.h        | 2 +-
 include/uapi/linux/pkt_cls.h | 1 +
 net/sched/act_api.c          | 8 ++++----
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index f22be14bba64..c839ff57c1a8 100644
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
index 229fc925ec3a..898f6a05ecf5 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -6,6 +6,7 @@
 #include <linux/pkt_sched.h>
 
 #define TC_COOKIE_MAX_SIZE 16
+#define ACTNAMSIZ 64
 
 /* Action attributes */
 enum {
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index be78df3345cf..87eb09121ca4 100644
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
@@ -1424,7 +1424,7 @@ tc_action_load_ops(struct net *net, struct nlattr *nla,
 	bool police = flags & TCA_ACT_FLAGS_POLICE;
 	struct nlattr *tb[TCA_ACT_MAX + 1];
 	struct tc_action_ops *a_o;
-	char act_name[IFNAMSIZ];
+	char act_name[ACTNAMSIZ];
 	struct nlattr *kind;
 	int err;
 
@@ -1439,12 +1439,12 @@ tc_action_load_ops(struct net *net, struct nlattr *nla,
 			NL_SET_ERR_MSG(extack, "TC action kind must be specified");
 			return ERR_PTR(err);
 		}
-		if (nla_strscpy(act_name, kind, IFNAMSIZ) < 0) {
+		if (nla_strscpy(act_name, kind, ACTNAMSIZ) < 0) {
 			NL_SET_ERR_MSG(extack, "TC action name too long");
 			return ERR_PTR(err);
 		}
 	} else {
-		if (strscpy(act_name, "police", IFNAMSIZ) < 0) {
+		if (strscpy(act_name, "police", ACTNAMSIZ) < 0) {
 			NL_SET_ERR_MSG(extack, "TC action name too long");
 			return ERR_PTR(-EINVAL);
 		}
-- 
2.34.1


