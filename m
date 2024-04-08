Return-Path: <bpf+bounces-26171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A2D89BEC5
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 14:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9469D1F23C3D
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A26FB9D;
	Mon,  8 Apr 2024 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wvjwbxo5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22E6EB62
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578821; cv=none; b=ht3eWvz1wU78siK5orvTOod8nYKm3cOvok5UDmf/jedqq8TXB36L3+IhwHoc3UxiNxINuHlQi0uO8qhxc0UZRscifjqBg2AJ0msbOv8tn56dt5Iyp+GcwGmEb2clKN+iZ7gfZkNVywUV3NMTOiQRo5vaembLS0OUWQEV+lGovA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578821; c=relaxed/simple;
	bh=b8bptETvG84oiXi8WEQCccf8XZFYg83kzkS/2d51CA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbVgCIYZJ9rIRh49nYStyp+BGKuopLoq8mnBBmyq/V1SzWFiaxigDtvWPFCazw46p7lmbiFg7bd7I3RTDvyKGqzKw1MHW7lo/rwgNVCdK6Itc9HaxsPFRPZf+8AXsGdJ2TuGI/Y9F6fC/tCSUJh5fM09eW15jMqQrhKTZS3RPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wvjwbxo5; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-22f746c56a2so118522fac.0
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712578819; x=1713183619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ayqzmg/dq1ZxpnFUTOb8nK1tSXrGpGgrmAqxDfILoE=;
        b=wvjwbxo5damCd/0JNxSCHwxSlRC49LLI8jVShmSLNyr2WKt4QeOYWGleNwIVfYN34C
         ZIw0qbtFsuM8vzSQlT++aKO8H/rvbJAQotSFhbGdpZgpd67EbvGNQv61VXfosIP7k7s0
         BHirWHm+yhMZwcnKv/oDHmB9i9Jdn5/d6vV4SkQe4anZ2oWmd75La9gwEwg/kwsbXhp0
         p7/s6y/kQs1ih4WNy+Liyefm2WvZAs1Oxo6RjB+aoGvn3eF9+dGKyKkGlfZuEprwJDgX
         cwFOovCrASOH328VvjVY/UT1umSBnHbz3G60kXx6R+GtZqnHT+4a96TM6svD2zxifOPQ
         PC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712578819; x=1713183619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ayqzmg/dq1ZxpnFUTOb8nK1tSXrGpGgrmAqxDfILoE=;
        b=TXcak7fBtQNbzgKmbOxYlb/iFMx/5LY6IkPgc7tnfP3oPjg9FAzexUmvwT/ljQfWXE
         BAf9WHwaGhV4yVbApaBN1q1cGmpDvIXJUfjNXBQS08+OUqbaWHKkh+aN9pM/cexPvUc2
         mywMEg+VCqxA0agfD9f6yWUoeYCwgnolqJIDdNmddNccrQk8bmlAH8XcUHR6oR7cMPzZ
         HMwMAzXK8X/UjWLY8MO8eg9/rSZd3ksg95l2MKj9O8fEejoBWvLaKLNBNBv0Y6Z4T9wr
         N7ziqkhd5hzGT6UwTZ3kAhjRSiuNldyim1SJ2c9nZbOYGoRfuByM0vlUtkCzyOqz8FgL
         w3gA==
X-Forwarded-Encrypted: i=1; AJvYcCUv2Mm+mD23M1hYQ+wKRuFf7WInKsnS2acxEsae0ritAV7GKZxJrI/pqW0rg6g8eI5BgdY8VVEBPjh5j4RBC49rpTo8
X-Gm-Message-State: AOJu0YxCevDanwcPlWiBU+2NinhqLFuzcxrlK6BFg6JJS5y9MA24IV9B
	lJ7IWkSKIZWniKK//e2PjYAv2HJTOQkBKKsQvc/hhXihr6jREhqeU+4NNnJOBQ==
X-Google-Smtp-Source: AGHT+IGmIy3e7no2s4+pW7wEMrWTS5LYSv9QWlbc1ecMpjivcdifPUgAT1ROvKjwHb4YaHn0TbnuCg==
X-Received: by 2002:a05:6871:8801:b0:221:96b2:5a4e with SMTP id te1-20020a056871880100b0022196b25a4emr9343695oab.58.1712578818949;
        Mon, 08 Apr 2024 05:20:18 -0700 (PDT)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a148a00b0078d5d81d65fsm1936142qkj.32.2024.04.08.05.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 05:20:18 -0700 (PDT)
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
Subject: [PATCH net-next v15  04/15] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Mon,  8 Apr 2024 08:19:49 -0400
Message-Id: <20240408122000.449238-5-jhs@mojatatu.com>
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
index 59f62c2a6e..52aab6dd8a 100644
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
index c094a57ab7..87b6d30077 100644
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


