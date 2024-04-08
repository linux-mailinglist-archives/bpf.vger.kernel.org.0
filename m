Return-Path: <bpf+bounces-26169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C8189BEC1
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 14:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B41C283728
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5385B6D1A9;
	Mon,  8 Apr 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="nYBtxEb7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03B6A340
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578817; cv=none; b=hD1Omb4Nrcg7vCTaXh632awXlHgVXgZ44cgrsykzsiS+Q9CpjDlY9kQxtZ9/ZATbjVmyhtA2pOn0dx/pa4ZtWzT4KY66xwhU89Y0a5uZAUrPPcr/5UBhG7wpRZlhTFQHhFxiz5GCLPz/tONRyv3YbmIILpVyBHRi7mICPoAooOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578817; c=relaxed/simple;
	bh=KfGNjAUtb+mZ/8Mo8TWcHVtUWPxugUbcvST0KOlyvec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdGlauHeuXNb0o2YiOtGSi3Zn5ZSOCFh7xmmqwZd+N9/3C7g3TZeFrJBTfs+iqh59znUt8NqxJxzs7N+kOEPdqRAzu8DR8di3X9d5WbOaytAkbiqshBeiO8yDHGLCSsAt1hkqbypNPzlt2l5WWDTPpNIF2T7R4seLQPAss5b/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=nYBtxEb7; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78a16114b69so345001385a.0
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712578815; x=1713183615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/8OW6GFQ8bSxY2ye3MTKJIlWkM6Q2//Y6JjwJfiICo=;
        b=nYBtxEb70ZvLCBnhevJixZcrR5cZQ4yUi4A0lIKAjEUW1CzoYhzIvrNBt2pPWmjXIM
         elh37AYgrbXQ5TRnraIF0O4b7tXnPAZPYTwYaOUhjDQBWj5EyaCJlyVMWoDAXJD/C/vu
         99ukfO5BmrPbDRDjf+XzYrxnF0PoXXBwtgIxD9//qbCn/17MqrVCGGUUVxAcnGOuT0gZ
         Jfod04jqeClcJ8m15xUbPJcdFuxljD2ZtT3xvw7jRv/lNkJCpR1ylZqrSdmSsLOMFA/v
         LStWgApMLahcyE7r5JHQF7P057uC8kraBM1uDyyQRojqPEs6DzlVCx8sfTC/nxHsmbCq
         IpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712578815; x=1713183615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/8OW6GFQ8bSxY2ye3MTKJIlWkM6Q2//Y6JjwJfiICo=;
        b=bS8SYCxwdgZ1sDcDbuDm4Y24SMW2r10pvDAD46UVnI6+6duv24yJD6AWp/n9p0BBEu
         kDi74Y4YXP4d1MqAx4XAxx/sKJPKM2D2kpzckzPRgsyKzq/rlL3Zth1bvuRR4R6jUrWo
         LkzuxzmFORrjDxxN69HjA7fDlwPU5t4a9VNUmsJpsxlqy//VI2dto//Iwuh5bx4JJOeG
         2aSSGnkTPS+VOpEbhK8B/p91UM/7n1CRLz5bLEJ2RFTjGTmoxUFaV1SOIyHxmYV2pyyy
         QjZ5bcXuQcoMK/TfjouRpfIQpqQnHmymzvbDQjirugjV4etbt5O4uJW7c05NRYDp85eB
         uV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfZDk0hySteRHKM5sWIhzC8RfXzHeqPkViTdGh3NwfMBd+AZtl4oVYVKWOYmbdssdqZeqy/uk76PZw6JHy9fNgkUL/
X-Gm-Message-State: AOJu0YwqtyXzrMC9lrmdUrWe2mHCYtH45pHjXQL6V9JgdCV2i1DodAMA
	wQSpnV9VZQ3gpI0a1DqMP/gHrm0fG+oYc0KoRhjFgdlNFHjqfFB9BaXsyp86eA==
X-Google-Smtp-Source: AGHT+IFpUIr/eRMOpAdRCVD/8AVTOc3m9ghEcUX8GuEVlBJnTqSsEUG+bMimjFAZKo29pInbWQG9gQ==
X-Received: by 2002:a05:620a:d86:b0:78b:eac4:a03a with SMTP id q6-20020a05620a0d8600b0078beac4a03amr13323662qkl.35.1712578815292;
        Mon, 08 Apr 2024 05:20:15 -0700 (PDT)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a148a00b0078d5d81d65fsm1936142qkj.32.2024.04.08.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 05:20:14 -0700 (PDT)
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
Subject: [PATCH net-next v15  02/15] net/sched: act_api: increase action kind string length
Date: Mon,  8 Apr 2024 08:19:47 -0400
Message-Id: <20240408122000.449238-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408122000.449238-1-jhs@mojatatu.com>
References: <20240408122000.449238-1-jhs@mojatatu.com>
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
index f22be14bba..c839ff57c1 100644
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
index 229fc925ec..898f6a05ec 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -6,6 +6,7 @@
 #include <linux/pkt_sched.h>
 
 #define TC_COOKIE_MAX_SIZE 16
+#define ACTNAMSIZ 64
 
 /* Action attributes */
 enum {
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index be78df3345..87eb09121c 100644
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


