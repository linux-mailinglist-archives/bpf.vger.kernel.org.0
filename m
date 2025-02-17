Return-Path: <bpf+bounces-51715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F93A37A29
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 04:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510DC7A3559
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 03:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D05154C0D;
	Mon, 17 Feb 2025 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5xgITQe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142691465A1;
	Mon, 17 Feb 2025 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739763819; cv=none; b=CAeltrOfPreoarFPhPuBkct4TrKDHLZtG3rfCqDfcoQjcRKVesoEnTA5r4m1Q/0i67+JC5SnCM/yUVxdBvDeyE4r94wBdw94g9II3CU9XS2NGRGWeeEMk+nPS9VgeoiHzApkAh4YlsDfhLIKyTF8/2CfDHbjR3ykRwI7zeOQolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739763819; c=relaxed/simple;
	bh=bm3Fy8sl1aN8XdpnW2UjmK0bOKh0X/2BJU26n5vFYFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OXIl6x91Qbrdnsm8hCgy2O6DQQhkV2A6lMPAd3osO3jAQCZEmKgelhbPb5gd/G7tAAdX7NbhoEcM3R71mV3ULIYy0yJs1eXZNc7Ft1FDSe+hmZ3opIINB2doF3YnWT9EPwF0B3mvAHI56WjnUJy5vGn/X2Rb4H0xzhIqH3fT5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5xgITQe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220e989edb6so71547925ad.1;
        Sun, 16 Feb 2025 19:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739763817; x=1740368617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FojXSWZGABebOdYwZgu1ws1LIUxxrDs78QA+roIVn5o=;
        b=h5xgITQeOV6yjOdq7FqiAt1ciKmWsKt8Pz1/05hxem1OYRPyazC7LOgH5xIsCK2q39
         kkbV5Djb5SuvoC5dms5o2KfY81AB0xlFBrS8QLwtJRGclly1VGhIuy+Z/kOISwunpB6l
         Ovgsbaw7KHS47P3h6FgNuCY/3K6QXAVRoU9tGb3gyOYIDCRccEfsrxvMCT0uWLBOg2Tg
         IJ9KBVOENvm86YeU+47G4e6uYeyXpcJM97I91P+vDGZPbS6xEuzQfpnipaNGpD44npPl
         a+01diPSMKEChEDHZ9eGvP7Vk7SJtMaX6ob0pWhBhJYPUcpTUcjZSjVyvjzyE85IQfkM
         M7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739763817; x=1740368617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FojXSWZGABebOdYwZgu1ws1LIUxxrDs78QA+roIVn5o=;
        b=d982rFMkjcTxoz8NvH5m0wmPBcK9LVbqxqLLHAfKcjqT3bjZ5TkASc4+e19SwU79OA
         6gFJm5wf/mPWbv6PqaC7KBgdz+KxqW3E8S43+IJfYBaOSBYXbyANlDEVc6HPq7AZK6Bb
         XhIpRu0bOtFQMwTHOPXHfDquysxF8MHIUTUFSoP5gNXMnVvu9mtFhS09GVIUsTuk9LCt
         h5HGFJkE2CbZmIUnL0DA2Oh4D2BOoyGMTD5VdomXPD/IFRXEllIueTXVWIS50hl/nhJO
         F7C4G43V1UchpV39uzuetJJNHZh/cNoJWkRYA/VICx9Xc/GCQ2QHXWmwXbIril/zr8UW
         Cabg==
X-Forwarded-Encrypted: i=1; AJvYcCWoozXy3KSfDA1SLa5+Dl6PXBhogKak5BP9jZfIG9PvCqy6PCHjeoABZkXNmwk8AD2uKZiDoFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkwr0Ffqox2GAsd9f20dhum4IobY0NK3OhAYmSQPm1Jbj+H3a/
	oyCQWcrQht4ttseoKRGYx97VxImmkbs58uXE/e4P00468IyFDg33
X-Gm-Gg: ASbGncvzpSIPnPZ1rIRX32MkcwV1huEpiQkHVupFx5Mm0haN29FACjhM11TDro1LGI7
	OJdhaEYrZyFAioxmlpVvq4dsaYtmsNnKbaOgbl+euyY798PSo4Toy7f7SE7i7VQRR0UTqBtCSCb
	+aPHCebgzLHVMd3VOAmbWHpd+xSRffpoiiqdTqfdGMGqJ0La/YMqoRlNzYrb98FKb2sokT981ao
	sM34E+biW6zg5Np3dJloVJEhqlqu1NrrUzBeNzvYWfCDlBaMt7Goj5Ja43iQBl7X4jOFnZOrsKu
	32X1X+s78wF+piWzJY83rhkjiL1IVWxZAZkiuewKZ/ASoQQjfNMhuEowN7HI+84=
X-Google-Smtp-Source: AGHT+IGEoYeF0BIeaq9N5q1kx/aHSwvh5ktWu/q92oBWnZaCSwg0+55H6xyi6ObKs++PatW9G+natQ==
X-Received: by 2002:a17:902:e5d2:b0:20c:6399:d637 with SMTP id d9443c01a7336-221040a9b2dmr135023935ad.40.1739763817289;
        Sun, 16 Feb 2025 19:43:37 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536b047sm61966585ad.101.2025.02.16.19.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 19:43:36 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v2 1/3] tcp: add TCP_RTO_MAX_MIN_SEC definition
Date: Mon, 17 Feb 2025 11:42:43 +0800
Message-Id: <20250217034245.11063-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250217034245.11063-1-kerneljasonxing@gmail.com>
References: <20250217034245.11063-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add minimum value definition as the lower bound of RTO MAX
set by users. No functional changes here.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/tcp.h          | 1 +
 net/ipv4/sysctl_net_ipv4.c | 3 ++-
 net/ipv4/tcp.c             | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7fd2d7fa4532..b6bedbe68636 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -143,6 +143,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_DELACK_MIN	4U
 #define TCP_ATO_MIN	4U
 #endif
+#define TCP_RTO_MAX_MIN_SEC 1
 #define TCP_RTO_MAX_SEC 120
 #define TCP_RTO_MAX	((unsigned)(TCP_RTO_MAX_SEC * HZ))
 #define TCP_RTO_MIN	((unsigned)(HZ / 5))
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 3a43010d726f..53942c225e0b 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -28,6 +28,7 @@ static int tcp_adv_win_scale_max = 31;
 static int tcp_app_win_max = 31;
 static int tcp_min_snd_mss_min = TCP_MIN_SND_MSS;
 static int tcp_min_snd_mss_max = 65535;
+static int tcp_rto_max_min = TCP_RTO_MAX_MIN_SEC * MSEC_PER_SEC;
 static int tcp_rto_max_max = TCP_RTO_MAX_SEC * MSEC_PER_SEC;
 static int ip_privileged_port_min;
 static int ip_privileged_port_max = 65535;
@@ -1590,7 +1591,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE_THOUSAND,
+		.extra1		= &tcp_rto_max_min,
 		.extra2		= &tcp_rto_max_max,
 	},
 };
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 992d5c9b2487..2373ab1a1d47 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3812,7 +3812,8 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 					   TCP_RTO_MAX / HZ));
 		return 0;
 	case TCP_RTO_MAX_MS:
-		if (val < MSEC_PER_SEC || val > TCP_RTO_MAX_SEC * MSEC_PER_SEC)
+		if (val < TCP_RTO_MAX_MIN_SEC * MSEC_PER_SEC ||
+		    val > TCP_RTO_MAX_SEC * MSEC_PER_SEC)
 			return -EINVAL;
 		WRITE_ONCE(inet_csk(sk)->icsk_rto_max, msecs_to_jiffies(val));
 		return 0;
-- 
2.43.5


