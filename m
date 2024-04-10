Return-Path: <bpf+bounces-26427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A6489F94C
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 16:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AB11C22FB8
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAB915F41E;
	Wed, 10 Apr 2024 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="dNTy91mH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00515EFBA
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757711; cv=none; b=c2U6tckQ6+BxlQqiCFqyD6ltubFGTgqKVjwL49nfZ16e5K/cgh6GrgjZdAfMSN0uOI6F5rUnAIXQ0UhM513O5rymGiWdLDR812k++hNngfW09yEBgPtvz/IxPaRgHitz+7lRcOK3jhFix6PbaGyka8asquX36p+S77rgjHtS+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757711; c=relaxed/simple;
	bh=ifcSdb7ZEEThqZyw6HdHYOZW+Vf6pRSm5gv8TRyUtes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJBiyyNFwh0Sx3d5/NahAZ0xkLCe+hGl3G1Xh8MmSNMbQnJsNMmuX8plrpi676DpBkidrYkP48LRu6UI9wmC1JUl967de0xdunuoFpRx3NgE4f3bNAtRfcgVbk3KufSgt99zuxGTQIoLVQUAiYhS9BeWMUgr9LugGliWhJNXp4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=dNTy91mH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78ebcfcd3abso11693385a.1
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712757708; x=1713362508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6T2dDeyGUMMk89YGyG0QosQkphpXt8l//KZOPZKRIh8=;
        b=dNTy91mH7+MGq4FyNyj+7imrxKV4GSY6ZbxSBA5lCD7czKnD9FDzlw8GmVvjOptMmu
         5DxKinJkgOLREVckaQ335Yg+Hd47YM98KAGLR+Rjcjt4Z7dcCZ9QIVH68n9uJEmH6zIi
         nizbfq6//M6uV/dgSctaa/3+2I6VUcFBsZeC0Usswz7BJH5x9bVvQmebZMi2NnjY1GL2
         SL/i6fdFLkXQX7G53Mas4rnvAIzyAqiziou+KuDOS4D9fPPQMHdCjxoWr0yUDM4gFF6t
         lnRQJS1pDRw/sNXSUq8sPSmyU+VvX7InSmqH0uVsAZBWrHTpRP+0WUmY4wAxwuspBgC7
         0JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757708; x=1713362508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6T2dDeyGUMMk89YGyG0QosQkphpXt8l//KZOPZKRIh8=;
        b=CUFswbZYWqHVJcJ3Gfsi3lI6hnYkmdagdt54qJGV3qfcop4YWkecgjgO0qzAL1Gt2z
         STakA7WUK0FauIFdHagAnOrV3DfHvGoDYwEIdavADB7PUeYI/93xFEEWxgUl8ta6UDNH
         71Rg6AMz9+cmftKHIKCNFwN6rI2rpDzwAmibGFI/sN2zlMWfXBQ8EmLItBm2jsz5aufI
         OpqFrOpZQtcFHUdS1d9KyS9mW4z7ALOyMH4A4Tt8BRnNPTKiqe9K6qcW4opdcyTfQWB/
         ahkqCzgJ9i7NXjfHTrqqxmjmzLWNL2axWGLJue/QM559Uw7dOcXQxSL40nN/wFNE6Nda
         1RBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwhEABDs8S2o0fOSe7cKGZr/4NMaPRL/Szm6so36zp8l7NvY+HX2MsHGAWrmvA09FnIOWFCIxcC6fe9pujpCgV8fAt
X-Gm-Message-State: AOJu0YwPVtnJFjmO5tPDQuXXCbRFZYbkESMzleThhL11JrEUDS+JoyoB
	WOO/gtbiB2iwFSEPE6Kq0r9/rayN0JZro1uYcEPez9YzbGa8eqUF91sCIYI8Jw==
X-Google-Smtp-Source: AGHT+IHSDsL9FaLt5DgvjiSlGHtBeDI0kzxiwOZmyOs5OlM9/gPg7SGjAVuu/liBOkYqvVOZtUUQjQ==
X-Received: by 2002:a05:620a:135a:b0:78d:6a12:e78c with SMTP id c26-20020a05620a135a00b0078d6a12e78cmr2606567qkl.76.1712757707773;
        Wed, 10 Apr 2024 07:01:47 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id t30-20020a05620a035e00b0078d74f1d3c8sm1345173qkm.110.2024.04.10.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:01:47 -0700 (PDT)
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
Subject: [PATCH net-next v16  03/15] net/sched: act_api: Update tc_action_ops to account for P4 actions
Date: Wed, 10 Apr 2024 10:01:29 -0400
Message-Id: <20240410140141.495384-4-jhs@mojatatu.com>
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
index c839ff57c1a8..59f62c2a6ef2 100644
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
index 87eb09121ca4..c094a57ab7df 100644
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


