Return-Path: <bpf+bounces-26428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE68989F94D
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 16:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5CF1C278B7
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFF615EFC8;
	Wed, 10 Apr 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="mceoMnci"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E71515DBAF
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757712; cv=none; b=FdYFV9VrpdWvER5zgRSz0xIpygmKYoGMkyTpmdCBwBM3it20nqxdtEBXg+dTUKsg54/uYm4ckssbFlV55J5z+vNMhzTGrLN5aMM3JHSwI9Y4niORTSGQtteIm85a6axp1LmiMySxJ9yQ2MPAV6bVmaMJB3sJvt7Ms7KRvQEJJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757712; c=relaxed/simple;
	bh=2km0V9HnCQbf8zo/za3O9ZgF67XPts5WxlU4j6WbOt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpiV8518hN3dhei6LOnLsfpMAL11GYdxfKkH5gGjfdXll4ZwS3G/yDwwmos+lTorctmUkEpVs4ME+bNfXbEde7JvboNaB5pN5Q8b6r9A8Hhg0Gm2m1sN2iu1rYau/nA79yrz+K8Ny/4cE0pyZvJDfjxC2hgA2ckKOfzzlTLumHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=mceoMnci; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78d7558bf10so92697785a.1
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712757709; x=1713362509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgewKpp8TcG1YQy9DnNv0g3DLdhpZiUIwdeoQaIfYUg=;
        b=mceoMncirbPoJbYNl0ai3uap9GHUbWZ3K139BuG3CH+Yt/A6i2iAqloINJy6QrLF+0
         1QQmY/XEjPgviqJJ0wbwABSEDnNCl7HMQFGhmgcSITQKj4UOvmzwTwf0J1P8dcVSZipS
         RvLE4A4OD7DqQyFhwXJIHJ0DWqtpwRN8Hvvnc4SLTKDZTWKgaGcb0S99YuRmsgjOGFXa
         cztTxa+iSzshLNQ7VAj/Emy/4KfrQ3wR8ijFaHSScJdXKP+n6jOTKrMSAQl8uUZ/DZhO
         S8fW7T7YdyO/b88n4ozzKS0ceIutoTjX2zc6++iVzeIlwA1/Fh+l+vgGIeQqlFwNHuQL
         gwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757709; x=1713362509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgewKpp8TcG1YQy9DnNv0g3DLdhpZiUIwdeoQaIfYUg=;
        b=Q0N7sHq/I0oRicVbh8ouf+14+Sax9L7DYkmaCPM9+jk7lzUhPBcNajD/8Oy3pVyj8j
         7acGMPy4MVDwASqisVwM9ybf2k5Ne5iI78RmzebxbfEoRadLifG200MCRYG2NyidcfFH
         MncF8VMisqe7SlLLDn81yS1XLGDcC5rzLNGazAyMzpS0vBIT0E6mvKQZEIzxMDhJdsOi
         cBaysZOKa7GGx07I0xJZiJB86bmUmHJ6qRu4EOh9IwwM7SNAeXbwDhPIy+VFKeY5TBsX
         UP2M1oZJJ5NX9R8Yb6x3D+ztqmhBv52EW7LRET+ik27N7lWjXwqDAQwvKgChKB4Q+SRO
         vAAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIvVCohKWGBunsJjG4QlQVQs0Bf6xkJI1xSLhv0OcPpN3gkZgzOjJU04HmZ2D3B4hSnJLq9tn57FreILYNh8KjTNOh
X-Gm-Message-State: AOJu0YzqWwceRnAWpT3xSVGeTm23ivh5EdKLWFYnxs00HBDvVGLdx6XY
	Et4LTMMtT6WJdiu8pvmEYOCnpi/CNT6ArxwLJ5J9QmMUIDAohkc18hS4HJLXow==
X-Google-Smtp-Source: AGHT+IETZE5l1y2+86RTJFoR8pMDdfpO/ybLXLK0dY7GAse2jZlEDipXRoNAURac2ic8nmZq2MgFBQ==
X-Received: by 2002:a05:620a:3cf:b0:78d:5a03:2595 with SMTP id r15-20020a05620a03cf00b0078d5a032595mr2790965qkm.24.1712757709186;
        Wed, 10 Apr 2024 07:01:49 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id t30-20020a05620a035e00b0078d74f1d3c8sm1345173qkm.110.2024.04.10.07.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:01:48 -0700 (PDT)
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
Subject: [PATCH net-next v16  04/15] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Wed, 10 Apr 2024 10:01:30 -0400
Message-Id: <20240410140141.495384-5-jhs@mojatatu.com>
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
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 59f62c2a6ef2..52aab6dd8a8e 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -115,7 +115,8 @@ struct tc_action_ops {
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
index c094a57ab7df..87b6d300778d 100644
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


