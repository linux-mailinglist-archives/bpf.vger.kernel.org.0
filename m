Return-Path: <bpf+bounces-40055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C81897B8AC
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 09:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0D71C21333
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6DB175562;
	Wed, 18 Sep 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ARRtXAqB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E76516DEBD
	for <bpf@vger.kernel.org>; Wed, 18 Sep 2024 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726645548; cv=none; b=fUY+pEpLD9lTA2To7i10uLVwdvCX5HwV/jofBhw6zTiIYeMw0w9q6b3ogMykxcpb0pTI4PhbVxRAKB1QOEpiUkZ+gAW9qWpeBlMY52MmaW7B5SShQHGnEFd2djpDbbQEMZWo5X6fOH3BIB4wg5JJRh5r5wNWfaZvp5K5iKLo19Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726645548; c=relaxed/simple;
	bh=DydfF8Pc439Wt1w5M+gW9vt8fw8CSe77hlZ+Dv3Cw6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T47pKGQhX3tketdDHjqdAXCMqFEAo7HbPsQ6XKP+KsKT7kTFuLwJuU0kfGDWAVs/b9xa+BJSg8fywUxYj4tb5DwBcCr0+fviEn3o4ddCyFLllzcQopPFijvUIUeFbE4W+Oip1ZGdspYppMQ3xNQ7eRBoNcE264iY4fRSYX/I1WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ARRtXAqB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2054e22ce3fso70522225ad.2
        for <bpf@vger.kernel.org>; Wed, 18 Sep 2024 00:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726645546; x=1727250346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWqoVAK5c9pomygUoi1VenHzK4hkTh05ICoLnHqqtLI=;
        b=ARRtXAqBLB5lln5zEU7CA/T2/PCbYoMNvcefdCEVN7b3giGTdjP+X7ysrq8y+Ay1cc
         lfljyn2Ft/rK9KyWEjztTTw0nlcWWC34Gqsul0llDGtFrqnX97QiNAx03w4cLRvXwxkx
         1eRnNxFcxWvRDfR7d5oWrSs7bij97KjQle4VyNHp20uCNtzEOTE0h92yjJ4bDAHTZKYl
         +qN70KdIg1HWJtxVFSx7QMXKMMAeiq7aHB44UZSnYyLUK8vgC/Cifs5anPAjQSvCcodb
         sIfrZci0VzyGcrK6ZD/smD5j3jeVdeUSiWfrVDrVbn1m1vQzRnpRa3SwBZaAmyYEL6O/
         NTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726645546; x=1727250346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWqoVAK5c9pomygUoi1VenHzK4hkTh05ICoLnHqqtLI=;
        b=IaXFbSrxfRoWjwc6Bt6JOhfYe7UAMGsvum/FVrNRm3YnL01lkLgXUhuo2eDfBEwKZH
         3mxrbCcLRhIMUbhts/P7HeHkv1YHTh4TKhoPgO6gZP8/8pKqVXV6dQp9cQWIju+UuTCj
         /73DTWblXJQ/mAZnE9O7az/keCRCG2RhcG3m4tdjOayfqV8wg80O0PRsL5JKML4bNgDz
         DNo2YW6PZTuHaDAdbh0c/B9ZkMWqLNKEE+DcU1m+14B/YdNkUuR1FjQERnomGDx/UgA7
         uw5GVeVjCDx48t1JLdTIGJuTbHGW6TvSxLctJ9dK4J7BUUUv88rGZJysjTQ0axrquLGr
         tePw==
X-Forwarded-Encrypted: i=1; AJvYcCUUL9daZyYgsmaKb0Y1gnQ3n5U5uTySVU8NPe33UVA1paJSTsXeC3X/zoqmLP4MrL1eB0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxubGGkntGi9b2NK70/E2i2asHisPVbyjm+aEGQNjfFEmo66kFP
	Nu8AWAyzaV9Y7q5S0OFl6iEuhZHCWmtQCPpmWsJvm2lFI6AUEjEBG/oFRguEszg=
X-Google-Smtp-Source: AGHT+IGVPp2n40PuG/8KbAxshSN8LnfmvU7GlDwe9HJB5DsmANQ6cspxjCvOOmjG4ThxTHfHWIy/5A==
X-Received: by 2002:a17:903:26ce:b0:206:d66d:a30d with SMTP id d9443c01a7336-2076e3155bdmr241941755ad.6.1726645546538;
        Wed, 18 Sep 2024 00:45:46 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794747379sm60412995ad.288.2024.09.18.00.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 00:45:46 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	geliang@kernel.org,
	laoar.shao@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v2 1/2] bpf: cg_skb add get classid helper
Date: Wed, 18 Sep 2024 15:45:14 +0800
Message-Id: <20240918074516.5697-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240918074516.5697-1-zhoufeng.zf@bytedance.com>
References: <20240918074516.5697-1-zhoufeng.zf@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

At cg_skb hook point, can get classid for v1 or v2, allowing
users to do more functions such as acl.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index e4a4454df5f9..a4aa39b6dbba 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8115,6 +8115,10 @@ cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_listener_sock_proto;
 	case BPF_FUNC_skb_ecn_set_ce:
 		return &bpf_skb_ecn_set_ce_proto;
+#endif
+#ifdef CONFIG_CGROUP_NET_CLASSID
+	case BPF_FUNC_skb_cgroup_classid:
+		return &bpf_skb_cgroup_classid_proto;
 #endif
 	default:
 		return sk_filter_func_proto(func_id, prog);
-- 
2.30.2


