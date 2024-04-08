Return-Path: <bpf+bounces-26170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D7589BEC2
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 14:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5E91F23C21
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 12:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA226EB7D;
	Mon,  8 Apr 2024 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="RJgq+5ST"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505036D1A6
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578819; cv=none; b=r5yuDZS9gyi6VVSWRXlp7dkbP+QlV8KAI0Kq89HXSjiEhuASVtwt9k0rew2sDknXEGb1Ods8aZ1fD1MaA4yCzFvDK2K1q7ILUJc9TGgMNX9aJDyTl+/0YPj8Q/oK2hDtS9QxBl/hK+6Lzkua4ep02odW7Nmevli/sgW6QmnTjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578819; c=relaxed/simple;
	bh=0Rqjx80lQrZE7wZ+6UaTpRU7AKiDD72DIxmJmCIh9E4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+Xx0qdVTCysx886/FPl3QknFFJw4WumiVnhlxFIBhv2NvnQl1n71J3iMit3/1oOHIot1op+GK4DeKZhkJ9hQ1sgTpOJw0E2Zoj00tUEk/JppmC2P86lFGXhRvinOpaamwKc4NZewcMB0mMXNrJ4HjuPyVp1UGyH86ydYUZnCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=RJgq+5ST; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ea163eb437so658225a34.2
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712578817; x=1713183617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWvw+VNSEb8FXhGNcVsqL23nMeH8Qk2hFaJebNGTIg0=;
        b=RJgq+5STWcd50q4LgZ6GTSx95HXmXns+rlSSGSmYxRy92vtYxteJ2gYD1T1114OA4N
         jJnyh8S4LiJz2C5bhNqUxK/ZQcNA03rOTzTbG4WYHvan6EfMWVbwLsyAy/tx1xLVDDh9
         USkFqVVZ4RQHYIwMwUYMr9+2M/P2mrLrK66egxapo5Lcdrwf/CTucnXfy4K+nA5A18ZH
         TtWdKmP9LM1VR9Zi4gqxpwM2GNIxtNn8jLfHnt/Z8kOlNcJZMPIWiN1/KsMyE75S3I6Z
         3emwDdra4jm0HN3k3poFgR3r3RZiiroMJb+/o6KmmL/Kf4xVZAGFq4WoYabbhw8KbHqH
         6Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712578817; x=1713183617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWvw+VNSEb8FXhGNcVsqL23nMeH8Qk2hFaJebNGTIg0=;
        b=gfBcbrS/DGE17d2HexwKbeqaw3nVV4nzg1EyKnxeTbfWm9fTFCFUs5mqQYi7nm4bZ1
         3/D31AMBczS/zohOaRC1uS/2F8dG13UfOCXL/9VYiXnAyXL0fj3MhOsXX1hBWG3Isc9U
         qgPDIP7A/jTql83qn2Z7e4bXOjYC2vF8a0quLdHUgqUnhHoEi4oNZEQtjsOCtlRTlZ+i
         mdA54ob2ZGhRDRvhMC3aHTapWhODofzoRsfEuY2lyTFdk6ENEY+q0IZkN+SvweAjOrzY
         CAYvFiZAAcbgISuIeP2iacPUeI0hCTD+XzLnSHHjTP2aX1k+/BAZS7+9XTTBxb3WuvMN
         pGSg==
X-Forwarded-Encrypted: i=1; AJvYcCX+ezYp9P/gLmG8R/TQ60kO93+mYGpZC8CO8Hi5xu7g3RFogJ3wU6P5kbQiI5QCLE4A5WH6CzEs/dKUlxK3+fxvdYD4
X-Gm-Message-State: AOJu0YyyejVDJRY4ORVZajpiS7ravaQ4X1eaLNgn27ORfPK9MDNkt3NV
	l07Vw4/IWsgCnWpyRpswlN5+aHh79hNdxGAJ1L52qAOTPxf28pREXxJIInN7Dw==
X-Google-Smtp-Source: AGHT+IFdNfqkjjfnGtIL4xZfGMvomNTIDKp6H49mfT2uKPwQE15l1eUPDBAevwFCH6xQgavFpwM9BA==
X-Received: by 2002:a05:6830:7110:b0:6ea:1901:fda1 with SMTP id ek16-20020a056830711000b006ea1901fda1mr3548887otb.27.1712578817330;
        Mon, 08 Apr 2024 05:20:17 -0700 (PDT)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a148a00b0078d5d81d65fsm1936142qkj.32.2024.04.08.05.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 05:20:16 -0700 (PDT)
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
Subject: [PATCH net-next v15  03/15] net/sched: act_api: Update tc_action_ops to account for P4 actions
Date: Mon,  8 Apr 2024 08:19:48 -0400
Message-Id: <20240408122000.449238-4-jhs@mojatatu.com>
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
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/act_api.h |  6 ++++++
 net/sched/act_api.c   | 14 +++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index c839ff57c1..59f62c2a6e 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -120,6 +120,12 @@ struct tc_action_ops {
 			struct nlattr *est, struct tc_action **act,
 			struct tcf_proto *tp,
 			u32 flags, struct netlink_ext_ack *extack);
+	/* This should be merged with the original init action */
+	int     (*init_ops)(struct net *net, struct nlattr *nla,
+			    struct nlattr *est, struct tc_action **act,
+			   struct tcf_proto *tp,
+			   const struct tc_action_ops *ops, u32 flags,
+			   struct netlink_ext_ack *extack);
 	int     (*walk)(struct net *, struct sk_buff *,
 			struct netlink_callback *, int,
 			const struct tc_action_ops *,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 87eb09121c..c094a57ab7 100644
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


