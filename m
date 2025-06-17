Return-Path: <bpf+bounces-60785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78050ADBE14
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 02:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8940A188ECBB
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 00:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B451662E7;
	Tue, 17 Jun 2025 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms3AZYzF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F507081C;
	Tue, 17 Jun 2025 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750119774; cv=none; b=AEFL1eRz0WXH59LXD9PZIs8fiOKn21dSrJQ8pItwqzaRseHV83FJH7QA4bUSf2IMQvlv/kBye9eIbiPd/nVZjitNum0eHN4N0eFi+Mbm52RoiGLPWAyk9JJ0hjhFsFb364dN1MSEG1OBIypm0YY+n70N4pkx6SUiGZosYQs6M24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750119774; c=relaxed/simple;
	bh=LjmFIvbIx/X2HSNLxsHAjRGijhoUvfvaPQ45w2lI0Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L85xGSC01UWeg91iHAvad+4MUq1Yzvv//z1iF2qIpBp948Ri/Qvnkii68MHfBZm6I5Cimu3qpQI0iukBNgZE8oLGcYpv/3t7qWGHtQ5UrOZIvc3dSxlQMMV5GbCQIsrtUO20Cw5/X3aVgrQaom+4se0NTkcFN6s1KPEB8/wVJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ms3AZYzF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748582445cfso3240704b3a.2;
        Mon, 16 Jun 2025 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750119772; x=1750724572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GqxNk2hsS3kZerb8KyOXxCHPthV5aOceCEJLElO9+g=;
        b=ms3AZYzFdjkb2Yf4XjmkJdJ7aVswJm++D5shqJGrgphpOOgvn5VKHMJXqdd7J+m1Ix
         cWjLD60UOG9lMJgptdmf07in5irzBlyHN3iGg3wSMenAxletoVagV9Oc3NvVC48Ws9tV
         7lEtOH+vOUuRXhVzeihWOrcwp9ZolDLFa5mIf64lfqIjEavQNyibhPEcQ/ADViaqtgyv
         ga/Z2nVNGNKD6+4rPP9kM2rZscXaQA/QF12avEZyCon5raRPaTzvM52tTfHg/Eu+BP/A
         TMU5Zvnzoiv2knWBaG7aOBprypkfctIOQ3dkjJBeknv/Jq2vhSc/zcOHaDfEp8fW1tTp
         mkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750119772; x=1750724572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GqxNk2hsS3kZerb8KyOXxCHPthV5aOceCEJLElO9+g=;
        b=CGQOmgIcXVxxDIJ25fWPcpxsEPTG7OCYNRA4rmSMf+lt9Eq6IMqhLiPX7FL+ojBwoG
         cz9m+CdDV6Lfry+ZQ96zfv+b55sL9mzvE8gX7xx8n/Tc68iIGa8UPw5hcHfSD5hl/Yrb
         oEKqGX3KkAOdOAK0OwtmWEv4B+50eoifcvekRxKhdbljF3Py2jvqpbLUgru88KUsXRmV
         Acer7DBm7eQH+H+5U9m6u9cUhmJE58J15u8XDW/y1ZEys1a6JFZ3RSDo/j6b0V90M7x1
         dl1MjDKAT9rMioMWrSYS2W/cc0A1EsATOtYC43JhCA/+2y9urSCiDetVYybWl5ya3Cv6
         xJTA==
X-Forwarded-Encrypted: i=1; AJvYcCXSuzWwDZPMigqVSxuhOxAl7AIYZG4mDBDt7V1xT1M2Pjy8pK3ztOaGCoeR5+Bn/VE4AzbhgEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgFfq+HgHtWHwv7YnJGUYKz9gQG381vDwt6qm+SHAu2sY3E6Ly
	Yt0L+L5lgdoVjmG9ji4xm3Y22BmXpUiFMdNkFWnNi6xlrKFK8W8jPWuI
X-Gm-Gg: ASbGncv5etHHSEfxLS93s4W1p+XWs+pgtHY6xc6xWyydgj5pBg5pAofvyDVjfWWxXow
	Snyud0zZ3XGiQvXRn1UBg8CfTHTdSqm4d0i6jERojYI6+HdkoZ7ZH5LxFeuVeAjYSFYbajPreb4
	DnF3xruNtolHTBLWv4mYI8Tnha8+67b15v0h6xbLmGiTHWMskoeqcTaPW+yB0vVpMexSA+JT5qW
	NGbQzOsuwvKqFnnO+x/U6Q8/B+scIEVLVdxkHHUxv5LrGvJoTwB1nnqK0NxsuEpLJTANDboFerj
	nxJ7BpG8WgUyZXX5yGTMehK2OBi6uqMwxN8VN16ATUsAvaYvopCrmy97lCydeOuDCJn+QYEflha
	YG3TbRI65VY4pG+aZ8VNyNi0i
X-Google-Smtp-Source: AGHT+IF1/WZfSbxuATFdyizLTC5WHTYRx/D/D7r/8xD37bd3xRZOPPAiR/WxRX4Xj7shNOrnImCJOw==
X-Received: by 2002:a05:6a00:2d8e:b0:72d:3b2e:fef9 with SMTP id d2e1a72fcca58-7489cfe84a0mr16812447b3a.20.1750119772231;
        Mon, 16 Jun 2025 17:22:52 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.27.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d252esm7488606b3a.163.2025.06.16.17.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 17:22:51 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/2] net: xsk: make xsk_tx_batch_size tunable
Date: Tue, 17 Jun 2025 08:22:36 +0800
Message-Id: <20250617002236.30557-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250617002236.30557-1-kerneljasonxing@gmail.com>
References: <20250617002236.30557-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In some cases, users probably expect to see xsk_generic_xmit() can
handle more desc at one time. Make it tunable and it would be similar
with how dev_tx_weight works in xsk path.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/hotdata.h      | 1 +
 net/core/hotdata.c         | 3 ++-
 net/core/sysctl_net_core.c | 8 ++++++++
 net/xdp/xsk.c              | 4 +---
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 2df1e8175a85..862bd168fdd8 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -41,6 +41,7 @@ struct net_hotdata {
 	int			sysctl_skb_defer_max;
 	int			sysctl_mem_pcpu_rsv;
 	int			sysctl_xsk_max_per_socket_budget;
+	int			sysctl_xsk_tx_batch_size;
 };
 
 #define inet_ehash_secret	net_hotdata.tcp_protocol.secret
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index 5131714eee63..e08fd0ee1b05 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -20,6 +20,7 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 	.sysctl_max_skb_frags = MAX_SKB_FRAGS,
 	.sysctl_skb_defer_max = 64,
 	.sysctl_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE,
-	.sysctl_xsk_max_per_socket_budget = 32
+	.sysctl_xsk_max_per_socket_budget = 32,
+	.sysctl_xsk_tx_batch_size = 32
 };
 EXPORT_SYMBOL(net_hotdata);
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 9f9946b7ffc0..73be2d9e6bab 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -647,6 +647,14 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
 	},
+	{
+		.procname	= "xsk_tx_batch_size",
+		.data		= &net_hotdata.sysctl_xsk_tx_batch_size,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec
+	},
+
 };
 
 static struct ctl_table netns_core_table[] = {
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 95027f964858..4215a40abb69 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -34,8 +34,6 @@
 #include "xdp_umem.h"
 #include "xsk.h"
 
-#define TX_BATCH_SIZE 32
-
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -780,8 +778,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 static int __xsk_generic_xmit(struct sock *sk)
 {
+	u32 max_batch = READ_ONCE(net_hotdata.sysctl_xsk_tx_batch_size);
 	struct xdp_sock *xs = xdp_sk(sk);
-	u32 max_batch = TX_BATCH_SIZE;
 	bool sent_frame = false;
 	struct xdp_desc desc;
 	struct sk_buff *skb;
-- 
2.43.5


