Return-Path: <bpf+bounces-15180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0697EE399
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD821C20A5C
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F6F34CF2;
	Thu, 16 Nov 2023 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="r5/LzOp1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F3DD5C
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 06:59:57 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7789aed0e46so52110785a.0
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 06:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700146796; x=1700751596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FemrncLN+Qf8bzgtCx4ISXH/Ibru17sI3duiUE1r3rM=;
        b=r5/LzOp14HO7wExhpwV+Ele8XiFM49NHwOGXFZ/++239UwH4mWXxILsRGWbf6uPl3a
         IITFPxohfukqpvr48HGm1UaLIEk+EzemMzQ0GWeOGvpwAjEgKU2eNLnXrRoX/WHi0XBa
         0/6ZpTXuq1lVXRUif5Q0e7Dloo2n7lH71Rg4e03DYYtpYA1BL34R2UwQ6ITfCyQ6ZHkn
         sbEsCA7RlejW44hV9KEY7+ONI+HUQnQl+E0JplZbwcmDttqQaD4fYo3WokStyPsva9Qj
         oy2JxPs6mXg0UfuyrYqtKJCgHheWS/4brWtN6zyh/RZyzGoyvnRFm+LJpkZaj2P3qf1W
         /SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146796; x=1700751596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FemrncLN+Qf8bzgtCx4ISXH/Ibru17sI3duiUE1r3rM=;
        b=lPRGN2jUJcWNOAPqc0ee8SW0Gfat67AraIvCbBlSZI2tTurtYaQGtiEpH4oA1tRHtm
         ANHvd66ez06GosEn91bUDXITcaHg35Iz0tQQGOrnovTXPLyi9++CIDOaSwPIo4KbmSDa
         0BvQ3/h+JmUAS0W6wqw0iLCiABDULtpg4RU75599AJoFqb7BqpCcqDVWAJbvt0CI2sXM
         97tz83PEdR5orMGD5wJ6EvXXuDpIJqosfD68BaJYUTjkVBOHmaOo2gRT5uWdbj+z3VAq
         BBCveV9HwsSyqEkMh6qQ+4Rc5YIM1pz638Ebsp2JJZdw/5kCpXX+/7g7Kq4RH5AlgQDe
         Uu2Q==
X-Gm-Message-State: AOJu0YyjgM/NJM8rqedXAcvGoHN/qaiU/ksMHzGexSvSzuqd4eQ3dV1R
	ZQp5J4pF2JYCURyOaD4Ahd7uUw==
X-Google-Smtp-Source: AGHT+IGedgAXznUy3qrAshpwpIS0WEpvFRVfFjzHUPoWToQ6Ev+LwaSE7ZThUxj1XH3uSM8sK4veaw==
X-Received: by 2002:a05:620a:4881:b0:767:8e6:f46f with SMTP id ea1-20020a05620a488100b0076708e6f46fmr9694455qkb.19.1700146796453;
        Thu, 16 Nov 2023 06:59:56 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a241500b00774376e6475sm1059688qkn.6.2023.11.16.06.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:59:55 -0800 (PST)
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
Subject: [PATCH net-next v8 02/15] net/sched: act_api: increase action kind string length
Date: Thu, 16 Nov 2023 09:59:35 -0500
Message-Id: <20231116145948.203001-3-jhs@mojatatu.com>
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

Increase action kind string length from IFNAMSIZ to 64

The new P4TC dynamic actions, created via templates, will have longer names
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
index 3d40adef1..b38a7029a 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -106,7 +106,7 @@ typedef void (*tc_action_priv_destructor)(void *priv);
 struct tc_action_ops {
 	struct list_head head;
 	struct list_head dyn_head;
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
index 443c49116..641e14df3 100644
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


