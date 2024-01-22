Return-Path: <bpf+bounces-20026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74D6837310
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 20:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD9A1F2AC30
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 19:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B28B405F7;
	Mon, 22 Jan 2024 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="NiVZHjVo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC33FB26
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952892; cv=none; b=f6O9aNE98KejEMVzm2sMat8XXMF9nsfTaXCY1UzRHVibzK9YvUkpev+B/LonOW0gsPxc30csF/yrhw0EfUBMdO/MxNbb6h91rqndkQcNMpdXWDIo3pCRsTooRkNRHY2OTOduZOGq8gasCv0/9h3UkX2PkMOsHn4rvPGJ/bRQOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952892; c=relaxed/simple;
	bh=3PjHbL8oR/3vRZlg6DcjfyhtoGP2cXL9kZHo0RHTocU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sDYOw91Ir6yCaMfMc79dtaUa6pk4+xQZw8YfXwZmAVtcGPEr76zZVnmMGTt0m7j3s7csYK61kFuGapF986xOWqgdzPJ78WKCw+MX4AlQWK38oSUVP3L4YgH+gEOMLJ5WqkU45d2NVwF/lfnw9g8GhnXrg0n05N15eyexc9DQy68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=NiVZHjVo; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6860ff3951aso13126516d6.1
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 11:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705952890; x=1706557690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTBm0NeoruCwj/Wtv4lvKgIyiqdv3VQtuDA83602EvY=;
        b=NiVZHjVoqGtRAEc/8DrXDPbnwLdmggJh7p0M3ZigrvqXVgmDi7HCAoDwkgpQl0YOKY
         q+oz2rtD1nMhYMwA5MMdpQv4GWYYoe07ZtEGQ3G8JTek5V6dVcz1xjtWqNN4pSLtl0/2
         XDUyeF7sP9nHeRQOada8uAjGeziI4K31cSTMofvHUKG+LdghRRjV30vIm+ec8x2B7OzK
         qzmxljYXpyr4M/Kc5yEBIsvYoPzmlYaFqCIkcImAS8onYfQYo3Vcl44HPGtMH1QtulWP
         85EM/bnr71HHsGOrZ2AT1YvRdsW5/h3qCQUrqvYbRq4TKDvMyNkPt2GXzLdO5HGjUZBh
         Sd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952890; x=1706557690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTBm0NeoruCwj/Wtv4lvKgIyiqdv3VQtuDA83602EvY=;
        b=JbQO9zqlOnA96LC7DPyfPbJF37o58wj+HB8p+c51tTnD0627iuTpZp/DvnGyRivgci
         OI3mHIJ5u1UjNcQ3JSZLZchfjKRsejqEFnzs+j3zMhYvM3sTMWlPPNNzhUGuOKSxOEbB
         H1fr0wUk/s6nl6OJ3bOXF/2t5DHtXk6CCmtd6T75gNY3GTD0RsZG2VJVjosLtKQJS91H
         IcEaCQUz0BkSmzNoZ7jnEs+DJGEt77cSSF9X71uGLMfhc2YQ9RjahmuRytj+yWHdAb3E
         kEvEP0CeLpynUmmuxatm5jvkXghHsHuV+5W/AySvP2WEt+omheJqV00u+UFQCNpB3+sg
         qpVQ==
X-Gm-Message-State: AOJu0Yyd6De5/cGUkfExdQ3aUh1f7QykYX/tvzsuSNYw03Jeb0p8wBT7
	D6CIWgqEY/Ln+gVEwGN+ykhIJzfPEHO1R10TmvJRqPylAwqU0Y/bPSPja0w6/Q==
X-Google-Smtp-Source: AGHT+IE1Y0vAzzO9GIpicWLIIzHsVeFckxqDeud3FglCmA0vGd9oPkzkRmn7s/ZT2BU+EA9fjsNeAw==
X-Received: by 2002:a05:6214:2483:b0:686:1c06:4436 with SMTP id gi3-20020a056214248300b006861c064436mr5168378qvb.48.1705952890146;
        Mon, 22 Jan 2024 11:48:10 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id pf9-20020a056214498900b006818be28820sm1288601qvb.24.2024.01.22.11.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:48:09 -0800 (PST)
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
Subject: [PATCH v10 net-next 02/15] net/sched: act_api: increase action kind string length
Date: Mon, 22 Jan 2024 14:47:48 -0500
Message-Id: <20240122194801.152658-3-jhs@mojatatu.com>
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

Increase action kind string length from IFNAMSIZ to 64

The new P4 actions, created via templates, will have longer names
of format: "pipeline_name/act_name". IFNAMSIZ is currently 16 and is most
of the times undersized for the above format.
So, to conform to this new format, we increase the maximum name length
and change its definition from IFNAMSIZ to ACTNAMSIZ to account for this extra
string (pipeline name) and the '/' character.

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
index ab28c2254..eb39a2101 100644
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
index ea277039f..dd313a727 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -6,6 +6,7 @@
 #include <linux/pkt_sched.h>
 
 #define TC_COOKIE_MAX_SIZE 16
+#define ACTNAMSIZ 64
 
 /* Action attributes */
 enum {
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index e4a1b8f5a..2ff61be8e 100644
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
 
@@ -1439,7 +1439,7 @@ tc_action_load_ops(struct net *net, struct nlattr *nla,
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


