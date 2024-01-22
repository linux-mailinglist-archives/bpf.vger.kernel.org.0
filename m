Return-Path: <bpf+bounces-20028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5BC837315
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 20:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF021C29567
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 19:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8E24122F;
	Mon, 22 Jan 2024 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="UcSb2YEP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E7840BFC
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952895; cv=none; b=Q9jFDYFU8cQzuBXFjXYdEDBrvg8ye32eaJzUhWJNqvwQgrKIzIdyvwP5IgusMusa8MIBddris/qBPTV6qtfrY2YYvo8m+v35+Wd0BKFIjYcK/ih/PKhhzxPdMNlbCsj2Pwhd5j9Ulo3ZtCen1MBBBy6GC4ZEiiTgrflGQ1SvAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952895; c=relaxed/simple;
	bh=JKkWEMInMFi+hM3RqBHWFVycJbeh+r3nIdnfdkvYnuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MozRwSgd+sxkH11/aLaRno3QGoWBNgy9v2grG8pLmogvewnzF5NUECHY/va/L/FKZpt0u5CBiSXDsEWZVu1T251tHGuMzAi0mYHhqb/5vUi1+RT9hhVNxsSmt9WqTgZUH1BmHCF4go6DS1tvTiix2aQ4mKgooYLhVKu0fT8/o30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=UcSb2YEP; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67fe0264dd2so24035716d6.0
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 11:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705952893; x=1706557693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2dbTO9ihBHJw5+PpbUOe/AqkF1JFPFW8RPaydE5Pls=;
        b=UcSb2YEPZKjzkdZWu/SfaOuetR47Cbj4zBCRaX2IqjE1d9rFs1h629fH8CD7yDra/+
         rMvbdH1SL/5bZMofHUAdK3/FlNVzgUEOZqX4c3uawfl+8Gi03kglhCxY6ZW63WbtFNln
         8w/llsxXZbpnKNGtm1nuYJvq4qxsacOK4hHETh8b/NDMsCxS96q7vCZLKn8rM1eulOQz
         xElIyi+C/QHtHPZZN55R/kW7pNomOWKRK+7e/J9B+AS7SWGRH3bZwTzcijtwiEGQK5BV
         vUW45YfS+qdy1RGwgBMhTAaluyHpPyxkSbaSFdcXm8VhUPbC6QSqYbeHqyUkyJgiSZBo
         H28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952893; x=1706557693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2dbTO9ihBHJw5+PpbUOe/AqkF1JFPFW8RPaydE5Pls=;
        b=k9ES9lIWVoPi8nWN+DYYUEJp4dsGZBtc+IXxPlGWk9wquPqBPdUz6ok64UDX49bwE6
         d7ulw+rIx0Efkr9XSsbzhKvLvice+cpNPYExaatHt/+RA1HUriWJM4I/pDTqL+Lb9VaF
         V9/ORwkfyBgMLtITQAtbHGw7hRKvN+DdWcyKcXgEKxTHsQahc0NlXky/8MQ3snsWLHv1
         KhD5h8YV02WQ5Oi3QWdSV8prpp/9qdshX/eol8TyrtRUhXN3qmZCyig9sa+2CQbErFI0
         dkHylkvRBnTe+pFlCGoSsZj24JJ7Buev7d6bV9G9ZxC0UGAJnX6R7j7O3fpx25FSydw6
         eh3w==
X-Gm-Message-State: AOJu0YzEl6J5OLROlPsEgf7gs40bil4UUUX1kcmhglZv3YvYyjKakOUC
	uZwox7oyfa16CbMmrQpE6rrYBOLn2Rwx/KBWOnkyvFOhGy7p+SdbE/eHGzPQvA==
X-Google-Smtp-Source: AGHT+IHttjoA/P/DpxaW0QQvblJ4IOLPQHOvuoarZ6WsjdVUR7JpsN/aqJGlSAQDLuJJUKWguUoFYA==
X-Received: by 2002:ad4:4ee1:0:b0:686:3a43:131c with SMTP id dv1-20020ad44ee1000000b006863a43131cmr5344230qvb.102.1705952892777;
        Mon, 22 Jan 2024 11:48:12 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id pf9-20020a056214498900b006818be28820sm1288601qvb.24.2024.01.22.11.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:48:12 -0800 (PST)
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
Subject: [PATCH v10 net-next 04/15] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Mon, 22 Jan 2024 14:47:50 -0500
Message-Id: <20240122194801.152658-5-jhs@mojatatu.com>
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

For P4 actions, we require information from struct tc_action_ops,
specifically the action kind, to find and locate the P4 action information
for the lookup operation.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index bfded7ec6..c60f3ccf2 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -116,7 +116,8 @@ struct tc_action_ops {
 		       struct tcf_result *); /* called under RCU BH lock*/
 	int     (*dump)(struct sk_buff *, struct tc_action *, int, int);
 	void	(*cleanup)(struct tc_action *);
-	int     (*lookup)(struct net *net, struct tc_action **a, u32 index);
+	int     (*lookup)(struct net *net, const struct tc_action_ops *ops,
+			  struct tc_action **a, u32 index);
 	int     (*init)(struct net *net, struct nlattr *nla,
 			struct nlattr *est, struct tc_action **act,
 			struct tcf_proto *tp,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index c6a783a71..869a38570 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -726,7 +726,7 @@ static int __tcf_idr_search(struct net *net,
 	struct tc_action_net *tn = net_generic(net, ops->net_id);
 
 	if (unlikely(ops->lookup))
-		return ops->lookup(net, a, index);
+		return ops->lookup(net, ops, a, index);
 
 	return tcf_idr_search(tn, a, index);
 }
-- 
2.34.1


