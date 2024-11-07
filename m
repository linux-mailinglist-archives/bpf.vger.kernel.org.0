Return-Path: <bpf+bounces-44235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0419C06A8
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 14:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2431C21D21
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECC4215C7E;
	Thu,  7 Nov 2024 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwJvvdyG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E9215C46;
	Thu,  7 Nov 2024 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984241; cv=none; b=DtW07a+Cdo5oB4HR/6BZgdnpsJ7HZgtIAWnWW3wUewPboRJwL6Pd5uKx6T7uzRvabc98ijNAa8tt1ZLURJG/ufWEv53zeD8/5HJKS2XgSTKygkxxCcSSjHtjsz6THkZJ/VqsUg9vxM/5C5ngLHKM/DEanIW6O40omOnLIh1jx3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984241; c=relaxed/simple;
	bh=A/n+tA2LV99QwIElK+AO6/wgstFiziRfCh0zEBgGADk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZJe2OD2igKX65ip3qAqdavp/49kbQyxfiVu14iRAoNIlx1Kg4sszKfA6KMEDbKyeAMgXfDLPqjeRlp7NaMcjsIjxIMaUOz0SJPXrkk5ZOroqVAPOXzYzmOEFcKrhzOhSnVq4hBa87PI/L1cpc7YNPvSmgyDNdXugYWxLQHMvF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwJvvdyG; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7eda47b7343so676723a12.0;
        Thu, 07 Nov 2024 04:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984238; x=1731589038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsqFsNdo4NVKbN05C2RYi/RSEJVp+Ni3JWGZTDWcFI8=;
        b=mwJvvdyGdNFoYQZYHaoQ1e35WLm9wf2LZ9gXAhH/lx4rI2OoLTsc9dCi+M5nmvpE4V
         o5Wbjz/S5vvCUnqcQ0GE+Qc/DOZJwNJtLhBHwAi8yNjTY51fIifq5kolz8YVKDSbUv0H
         h/mtYX8RpRGgGlZ+PwqwlE3DWrYh1/acJdmLmK6MS/+Dum5hfhU+NKwMYLJYCpXMpHMC
         rM7OtdApnglYZRtE6fQ2txC2v/ZkqO8GQCnoFu79HIq9LPNAKEo8AmuNDoG4iumEc7TV
         HjifRpREGiiZjBxhLR6cMb2WQM6eJAjFAS4M7OXtdSy+t163cGYDhkig37VQFy41iNah
         GcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984238; x=1731589038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsqFsNdo4NVKbN05C2RYi/RSEJVp+Ni3JWGZTDWcFI8=;
        b=t+WlS3h5OcJ5MCMZVlpd2fp4u5xKqp6MdfaW/SKuL9AwJSdHYqwOb/27vYi5ZD6cfj
         FBRsV8xprhp6Q4Er4JbgWPCHbba0sR3tLGuUeMQWhQFTS8EJsSKczXZVMvk/0KvvrpwP
         my02ttNm8AgNvM/E3wzH3gGrHXdERsMnGkELsS9s2SyQSNQb45F/TTWjesmVRaf+vbEV
         NJmUeiPNC/+wngUhbys9ft08jMtOI/PXR57J9uHtQa3GrlJv9T2rr8XkH6Wkpj7e9uMU
         c+uuFrxKakg3V8jrXXCM/FO1lYO7WnH5t8w0HWLok7HLOwTvipOWX9ReS9hwJSLM9yEF
         zVmA==
X-Forwarded-Encrypted: i=1; AJvYcCU35v6Q9Ho9s0CiCljr7L27GmL1shMdop2LQhAowPPAHyHgJ3J/QC9iVdyPAPMIHZbXV48mcOht@vger.kernel.org, AJvYcCU4UsvURRJ+YY0+6eqCddaUzp9+wmCzq4lpGh7sGsIvRU3QR6jGcOSfI0sx9NX6R5qIS6M=@vger.kernel.org, AJvYcCUNnJpClVS7i3kl1y3miofSn6b9FKDSKKNinxdw8bQ1TWi/kvHcFqNdUlcHS4CbHNSunyzN/vr+UxEyREZl@vger.kernel.org, AJvYcCXkRwM78xm6g5HdUFMbSUZi68CzsuGqtFu89Jj/J30oooG3NazQd1QMg4mpfftdBtCOTI/aujTk0ZJONALw7muL@vger.kernel.org
X-Gm-Message-State: AOJu0YxmsPqa1DMfOUhAGJ/vVr8UG6iB77PVGpEyOAQNb+8dUSVM1Xux
	0vxu96HRGb77zz4hTM0XQRkNCjvyytyYYG2AI8LcHsU5feTXZ7YC
X-Google-Smtp-Source: AGHT+IEM0orGjnsXZ39bCCPI3eXWNBAkK3qH9tMOnfcMoHpor7kACaDKwRqanDDKMEb4STUHWrZx4Q==
X-Received: by 2002:a05:6a20:b925:b0:1d9:6a6b:faf4 with SMTP id adf61e73a8af0-1d9a83d6639mr43154191637.15.1730984238019;
        Thu, 07 Nov 2024 04:57:18 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:57:17 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	gnault@redhat.com,
	bigeasy@linutronix.de,
	hawk@kernel.org,
	idosch@nvidia.com,
	dongml2@chinatelecom.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v5 5/9] net: ip: make ip_route_input_rcu() return drop reasons
Date: Thu,  7 Nov 2024 20:55:57 +0800
Message-Id: <20241107125601.1076814-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241107125601.1076814-1-dongml2@chinatelecom.cn>
References: <20241107125601.1076814-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we make ip_route_input_rcu() return drop reasons, which
come from ip_route_input_mc() and ip_route_input_slow().

The only caller of ip_route_input_rcu() is ip_route_input_noref(). We
adjust it by making it return -EINVAL on error and ignore the reasons that
ip_route_input_rcu() returns. In the following patch, we will make
ip_route_input_noref() returns the drop reasons.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- collapse the 2 lines that we modify in inet_rtm_getroute()
---
 net/ipv4/route.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 1c4727504909..1926a8a1a83a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2435,9 +2435,10 @@ ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 }
 
 /* called with rcu_read_lock held */
-static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			      dscp_t dscp, struct net_device *dev,
-			      struct fib_result *res)
+static enum skb_drop_reason
+ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		   dscp_t dscp, struct net_device *dev,
+		   struct fib_result *res)
 {
 	/* Multicast recognition logic is moved from route cache to here.
 	 * The problem was that too many Ethernet cards have broken/missing
@@ -2480,23 +2481,23 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			reason = ip_route_input_mc(skb, daddr, saddr, dscp,
 						   dev, our);
 		}
-		return reason ? -EINVAL : 0;
+		return reason;
 	}
 
-	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res) ? -EINVAL : 0;
+	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			 dscp_t dscp, struct net_device *dev)
 {
+	enum skb_drop_reason reason;
 	struct fib_result res;
-	int err;
 
 	rcu_read_lock();
-	err = ip_route_input_rcu(skb, daddr, saddr, dscp, dev, &res);
+	reason = ip_route_input_rcu(skb, daddr, saddr, dscp, dev, &res);
 	rcu_read_unlock();
 
-	return err;
+	return reason ? -EINVAL : 0;
 }
 EXPORT_SYMBOL(ip_route_input_noref);
 
@@ -3308,7 +3309,7 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		skb->mark	= mark;
 		err = ip_route_input_rcu(skb, dst, src,
 					 inet_dsfield_to_dscp(rtm->rtm_tos),
-					 dev, &res);
+					 dev, &res) ? -EINVAL : 0;
 
 		rt = skb_rtable(skb);
 		if (err == 0 && rt->dst.error)
-- 
2.39.5


