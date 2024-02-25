Return-Path: <bpf+bounces-22693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE92862C0E
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 17:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C042C280FF1
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249971B7FB;
	Sun, 25 Feb 2024 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1RLCYH+Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D8C1B950
	for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880105; cv=none; b=t4wBStaptThWAe0bI5hcsWMrhgnz69T2uP0lA9XcCvaWwKVNYunmVOesKsGMshSRNq+hGdls1gH30gOEpadsbJhyrdCRmpPKiDtXui3aHkQCTBynl/G+EMWQwHt1tM7uiBhvUUGPqze2X4XNpqX9hPJweLD8TOxtknMHvM/DIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880105; c=relaxed/simple;
	bh=YXSQQ0uQGokFV2UfiJU2Y96Z22+5kUS1rG2wL0NsELU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KO/Sih/iQjBWl/D9FScgRI2gWvLp8LkTJLr333xPVK1cBySnB/H5Dcbpr8Vi22FBmMNpQ5dRs2IJVgUUbiUJNqm4pKwTAQCHOR1pkkAHkEAYC3AOkhS5WGlUbWSniN9hx/LuyLgnxrRcNwZ/ZEO99oAXVepW9PgpY0WI1tLVKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=1RLCYH+Z; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c0485fc8b8so1770747b6e.3
        for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 08:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708880103; x=1709484903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGymPU1YTSNaMGYDgceX+N7ZQ90LxxvlYMbgFPW1GZA=;
        b=1RLCYH+ZizGYzN/pvKMvjq9vUzSMAzCP3Qa9HC/fSZouHou8AY9ynwBchBSw8DxLQO
         zraY4NWf+EwjFerW2NKuh6KDDBSF4bSbqTc/GrEplWocTcgNAfTIuhT6jW9VuhWjas7S
         /xjhGJNWC6S3ntmgWl35eQG+yopkuq/v/f/Nh6PU8zKjTGUP+MqxSiYdvCw1NYc7vGd6
         q2Sa5KHkW9jklX2QRCCgWTUIl6X+JWGiKEQqYQ/HlOcsjPEN62ZbR1DZAM2vAgiFFUUk
         SHO1yLZ1gqzaqcGZnM++FmDE38QukN3CIfVzuob5cx7HWkMfxgAaqtWdtoH/JTClz/6M
         jHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708880103; x=1709484903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGymPU1YTSNaMGYDgceX+N7ZQ90LxxvlYMbgFPW1GZA=;
        b=dwx/fAmvs6sqMzCEtW/pIKfSg1Inkqa5PAaHZ2Q8R87cE605qdwunyTs4Q2qN4sVc7
         oFjXFdY1eLsWNBv0VBodxW+UGj1WvkOd/lG0r1J/c7AWk+4RZYw/ubtcmRc7f91C5BD7
         OFC+GyDW9Iw5kukuna7EtpAe7RjxvCkh1IjpU/1zqVhgEHyYt0YzHm2RJ6HXsuDZ8Wfv
         2TsS6PTn7xfbWAww5jiqo2a/DcbEzByYlObHNuhdognfxUENRN3LV9KEaYeF2hloW8tH
         3I/1zZYR1fIJ5ItuvEZ13H8SN61Y1QWAQ6BzmOLBade8FUXQQjIpwKbCdPC5eY/DvNGE
         yLEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu703KpvpW3On4aCUfmXr8CVRbXRh3nFwRgGrPtsxymn5MjcdODJ0Rn4MI+av8wQE1qOtuKGHIU23h5a8QSI1ScBen
X-Gm-Message-State: AOJu0Yy+/LIN07IC0HDa9LrF2HxnTNiGjDkOZlHoGMyH+CR8bKHrfZKc
	RzyzXrktVNE2NlFc6aS5+2AMs/lpCpBLpPfqTt5MyfpqHHf0zh6z6pkcWXCNGw==
X-Google-Smtp-Source: AGHT+IEAh6ItH5blsaiJwGvreBxqFlcWdYvnI3SyoTvgkd6tmuj2rVHfdraP1+Fllb1k6edgabTClg==
X-Received: by 2002:a05:6808:3094:b0:3c0:2fd9:5158 with SMTP id bl20-20020a056808309400b003c02fd95158mr6596086oib.49.1708880103332;
        Sun, 25 Feb 2024 08:55:03 -0800 (PST)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a14b500b00787ba78da02sm1620698qkj.93.2024.02.25.08.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:55:02 -0800 (PST)
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
Subject: [PATCH net-next v12  04/15] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Sun, 25 Feb 2024 11:54:35 -0500
Message-Id: <20240225165447.156954-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240225165447.156954-1-jhs@mojatatu.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
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


