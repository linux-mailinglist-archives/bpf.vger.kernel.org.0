Return-Path: <bpf+bounces-73241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEC7C27F34
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 14:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D82189791C
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 13:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9852F532C;
	Sat,  1 Nov 2025 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXkxOZQL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219F19258E
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003610; cv=none; b=foUxeyhfGdEGmwSbHc6k8DXrJ2t0pGoNK9uWYGaiN93dGdSPZklliBUBQHhkZK409yzw6YSS3LM22qcVjsIjonV5iW3/iLooGmMW+CiZa304ms071pH28Y0TUKqRqGjQKUq1UG4hxpQIhCiFtfEeawEz7FuQsqHICreDp/IZY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003610; c=relaxed/simple;
	bh=Mgp89QAtrTjRgM6jWQFTc0jn1YY1UmGe8KsPam+6Ssk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MioDCKfwaD2mUmmxnxcaIorn1XQy+mJVnpNZn903zv5BUt2jsAgmabdN6dS2WsdHnnHUDPFzRnpBtlpK2G4O/UahUKO7qn6KcCtm9KW8HNr6KOZ/aetZnu38IEFJpnaq1P0oljZSE0mkFmUrGXg8q3oAsUPIfcLG+m39TPwTo2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mXkxOZQL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429b72691b4so2852308f8f.3
        for <bpf@vger.kernel.org>; Sat, 01 Nov 2025 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762003607; x=1762608407; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eg53ujn5W1DedX1Vyep0yhtifcPEiIbNUDg4dfuJiow=;
        b=mXkxOZQLOo/7v+JkoergXHoljqy4zc1MzpCWRuTLPEdmhjfiTLmQPKSUbxOZA+LCI3
         Lijpx/r4nzNmIBuLh6ZtW17pykbV9+EZ1rR2r5X/OGbpiq0tYgpdTUNb9+p3tyaHmDQj
         zeZ3RyvnM+2ek/MHXY6aQVkwPXdlGB12Lbv+BjJyAkeHWU/NqicXcn/vpYHSSKSDS15N
         DWYG571c8l2HiMiXlzFU0P5FmtO6lFhn3EcRLOI0XJZJaYk83w/vljsx9Mnb/qhkCq30
         dwVDf+gxSikJiNxKpSwAu3pGRtnuK4HCWv8Af6oCjBVpJEYdA5rfh1H+1Zw/MbiuNs5O
         sY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003607; x=1762608407;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eg53ujn5W1DedX1Vyep0yhtifcPEiIbNUDg4dfuJiow=;
        b=YbTn/xC8t7Q60cP0d1L/1ML86QquHt4+1XP29pyk9iKvbTe6o4O74XENLKuKs41/JK
         oQlLIMWfeLCYSi7bBy3/d7tIKtrLTuFPzdK0UXDImZZVYs/rGsYbhNIym+IieUT1u3gR
         7JvYLlEEsJkzadTQD2DCedSfb7gjM8+equbQx5ClYNi7z/4Ip/MKVA4Un4c+LugWNn49
         WRFTfMr4s+tFSa5nUNOxdQwKigrz9fxiSTom8y+y4bxPYxNE/k8+c5DPmlVJZHn5R5ll
         J6NBTCDJ8YqGCROQbZVhHj1E7mJ2zIqiUpO3utvt6g+Hx1SN1xZVW1VAbPbaP8Qlc87u
         FLJw==
X-Forwarded-Encrypted: i=1; AJvYcCUhHXZLNi0xFT+R9EWPfmBQooi3ZrD+0IIjgyGaAAVYjn/DLMewbKeZklVxvtjLcqeBKsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCrd1UmPqTG8J7dKkXJkrlczivLWXKcZ06NarcZCVgOYmM6GKo
	FSAfvydBFYvUmeVfyqUlSHgbF/FD5EdvuR8ZK7WTCDKWcfOgB01T4AuUVUbJ/Nd58f0=
X-Gm-Gg: ASbGncsm3hMXW1CJMtcWLuqP4lAJ9kdCqOhxvPPYgvk/uUVQf76GDTcekxXK3qptdZm
	yfa4jOGkdItzQhSmu/wLcQeCMUrlqHxYVs/Dyyob6hYhu+X9MKDZk9i9w/57W8/QDGisIKTDPSr
	IkbQrqOsusHEfWBtQwtAJhyjwRTfc2lZVV/wvrg+qWKkHODQ4cD5GXNS+E2aPCy4JZHJTbyPG47
	1AL61ko4bFd/dRiRgx2Ua5eak/9r8EOu4FMrh390JJFMeylKxYC+EuDYHAjHc7yKDHampR+uzWg
	35K24Enb4uEWRtKBg8boR8wKdvRTB3SBKPT5lPKfcZTgkYYuknvHAXA6xfobVPoI3WNb6To6k7N
	M1EEnYdjj1qqdwgvpwn9nK9kFKjYshMG39+Ut5aZ8exdljm+hmcrGcdySVedEAU0vTPxWL0KUD6
	3e04C31TCJySZE6PbG
X-Google-Smtp-Source: AGHT+IHWklOzm9hRp2MshFHHpjAPX4YwiYbf/S/L+tv28vs/jH3gOqeBv6O9b8sMd6VBVbyb1K/+5A==
X-Received: by 2002:a5d:5888:0:b0:425:7c2f:8f98 with SMTP id ffacd0b85a97d-429bd675fc0mr5343738f8f.1.1762003606366;
        Sat, 01 Nov 2025 06:26:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c54498dfsm5711594f8f.34.2025.11.01.06.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:26:45 -0700 (PDT)
Date: Sat, 1 Nov 2025 16:26:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] octeontx2-pf: Fix devm_kcalloc() error checking
Message-ID: <aQYKkrGA12REb2sj@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_kcalloc() function never return error pointers, it returns NULL
on failure.  Also delete the netdev_err() printk.  These allocation
functions already have debug output built-in some the extra error message
is not required.

Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 3378be87a473..75ebb17419c4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1530,10 +1530,8 @@ int otx2_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
 		pool->xdp_cnt = numptrs;
 		pool->xdp = devm_kcalloc(pfvf->dev,
 					 numptrs, sizeof(struct xdp_buff *), GFP_KERNEL);
-		if (IS_ERR(pool->xdp)) {
-			netdev_err(pfvf->netdev, "Creation of xsk pool failed\n");
-			return PTR_ERR(pool->xdp);
-		}
+		if (!pool->xdp)
+			return -ENOMEM;
 	}
 
 	return 0;
-- 
2.51.0


