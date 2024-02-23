Return-Path: <bpf+bounces-22584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5010E861283
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 14:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBB4285D66
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 13:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD4F7F49A;
	Fri, 23 Feb 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="h2bot8A9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1387E579
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694266; cv=none; b=sdJWPOLUrtJ3RRCrNjFW3D8hpoKh5/D1eqx5FrXOk4szr4wW3/o1GeWe1SS78xTqmHyhzwz9+F70qhBj/XxrY5MgBio1d7oVfJAgi9/PRtUADghFAW999gMdyG0hVLEY9R/I1+w02DoWE6MAdWoTr1m4VecRaVKT7Rn+tyxATTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694266; c=relaxed/simple;
	bh=YXSQQ0uQGokFV2UfiJU2Y96Z22+5kUS1rG2wL0NsELU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q0ISEI8XxmgU8R9TCk5OS5DoZrFbjKGAionZh+sjJaaPE2NjLCILbU0L6tTcs84YO2Z6po0HHXAqPRB6oekjcJGBgn5sWHFGt9RVjSThx6fPmC0/jA6/DnvDGbj8+rRpFBQTw7agLKb2Lxw6cj7v6np7i/dI7MyF8+qabB+9cLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=h2bot8A9; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-787b958b3f8so15829885a.0
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 05:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708694264; x=1709299064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGymPU1YTSNaMGYDgceX+N7ZQ90LxxvlYMbgFPW1GZA=;
        b=h2bot8A9NhMV8XHowOVt3RT3K1nBy5B1CureMlGrmKE9JQC0i5jFXktd+6psmm60P8
         FeQlZUnRCRUK5WkU6fFCSVyzr+ZphOrw5/UdZXNMN5P5Nld0VNK7tvY8YKdzldsVoGSH
         W+JmXCc3Zg865ziiALiripA0tL8IDKWGtFiXr4HCtd7w4PQUpE1E25Bhm19eubzjgC4F
         xFD4s2v9WEVNOevkaq7uKbk3nblnGgclCtdPrlFhhvT2S/qtadR5p1aqD80D5nZKmi+h
         iO4FnuxbTStmvuUZkRjt7N3TKOa/aJzYSgQaid66lECjCD/nCb3CMHfIaJyyJxgRjQ4g
         hhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708694264; x=1709299064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGymPU1YTSNaMGYDgceX+N7ZQ90LxxvlYMbgFPW1GZA=;
        b=fRNZm3hAT9qlXw7E2Ln5kSJCDr+IUEtF7eAwDAYJhSX5hXpkY89YOD8WDdfzDOkY5x
         CpF0TZROveCgQsVX2u1JVrdLMLrly7Y3yNUH8bHP3gnAMKB686TVERhg8jH3AdQbryii
         yzMB+gEMoGSC+Hl97Tjain7H+ZYWNqMCvUWyOkxqUKExKsAptfZqaDMvGvT4/3TdXor/
         7m3N040kuQL/WjphA+W71TN+htRKB4LIiVvDY2PSdPJw9IpXYQ/J3/E/klvn/cm4bc5Q
         3omtBHf/BQrfPcJBn0cNfq+elVnYcWhgo2s0Z3gokSgB3ioiXxgTDoKmlUOyWbEN/YtI
         8nKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoXo0uYj5QWDWA9ZXjN4shV/cgUqss6Z+r6jWY0qZiPbQGf1MUADUg0WA4waW4qNYdIP3q3IE3R2nig19qoxQkdqv0
X-Gm-Message-State: AOJu0YxdWQ1mss/8WvjeFC4bobbwxD04+4o53WZwXoZFR/cbv+o6Ob/a
	j1zcvZLz6EcaDs0bpHlRmFL2Xz6811PYWH1gyaqO1X8q7RnlayS56azKxQayvg==
X-Google-Smtp-Source: AGHT+IE3mheVfugS1y89UaawYfATltZItVLyh0DP4+H4+xt0zPasHl0WfRp7fhmyF+KJeC2VJcqdfQ==
X-Received: by 2002:a05:620a:2881:b0:787:2b5a:31b0 with SMTP id j1-20020a05620a288100b007872b5a31b0mr1961353qkp.71.1708694264419;
        Fri, 23 Feb 2024 05:17:44 -0800 (PST)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id f3-20020a05620a15a300b00787ae919d02sm844869qkk.17.2024.02.23.05.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:17:44 -0800 (PST)
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
	mattyk@nvidia.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next v11 4/5] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Fri, 23 Feb 2024 08:17:27 -0500
Message-Id: <20240223131728.116717-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223131728.116717-1-jhs@mojatatu.com>
References: <20240223131728.116717-1-jhs@mojatatu.com>
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

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 69be5ed83..49f471c58 100644
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
index 3d1fb8da1..835ead746 100644
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


