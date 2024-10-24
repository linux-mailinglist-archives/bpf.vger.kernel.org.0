Return-Path: <bpf+bounces-43034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1409AE0FF
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E866C1C23004
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EB81D049D;
	Thu, 24 Oct 2024 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht+HkOVd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE7D1B6D18;
	Thu, 24 Oct 2024 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762511; cv=none; b=SPhwto276HaKk/feiow0b7NN5OHhsCL5OfMxXR+qB0BgjCrN/jN/HKhn/rJ1UFn86q5UJszLGjLpBt3DS45X0PoodOl+t4vHiCgzU8pigzuxYxVfI0ahm2oNXnPGGc1a3gRCEe47QI8nPq7zmYM5ikCjErsnq42y5Unir7pNDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762511; c=relaxed/simple;
	bh=SMznvpM6I8IKeqpx/OkxMk7v5dBsmBPNdSI5IDb8K4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zp6e0pPKN7Q/TWEJQDARUCpgt4DRtyVqeltNg6NJkKRUzrNmptwu4ZOIEFmwdHOHbI+ftIG2u90Iarqyk326cgtQYgfGfvZvOYaFNWKNjw8uA/4ahAFYN2VItKnVgRCFx6MDBleXh77IYKVU5KTOM35xQKSGh30cITWl+fuXOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht+HkOVd; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-71e7086c231so525771b3a.0;
        Thu, 24 Oct 2024 02:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762509; x=1730367309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKF8GRab9vIGC7OVVlgdZTWcvJOyU79YNruFFlVjlr0=;
        b=Ht+HkOVdHGo0o1/DlV51SlRANnMFvsQq6mchq0SA/nf04zuTNJN/sczsjv93O5JC34
         u4h1L3G2OWWeT6eTIaeUximNfKy6MRvvN7UC6GakmggUcyHiCKCjmAID6s+AXiOJmUgI
         8zUqwviRe33HTd0KLPXqnepncM0EyiPWMfiBlswhl1Cu/kr26iyj1OtQNkC4/PMH36T6
         ZTkCzwXQMsIV1SErSxYL6BvIUrV0Vyyz/zgLkFZwa9zxYeG1q2fZG0gsF2YV+zi58Tjq
         zqnM0ZCJgAon1I0ZMng4BxObPyv4wNU5MS2gET6k8v32zSFT39sVxuiTcFKcP9CGYJqa
         ADRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762509; x=1730367309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKF8GRab9vIGC7OVVlgdZTWcvJOyU79YNruFFlVjlr0=;
        b=fdWbXwxJheAM+ShMwBUInF/MpmZ4MIfevjdfmJeLR3CwbJ3CiZAGOlUcrSHFWBaRz5
         pKS2Ts0GD0b6uB4bQdDqabp4L3yGtwczq3HNoekXi1/KEfUCJB8BCo3bfeonzNT5YIBd
         t6x3bHJKLb1uHXZOP1gWaA7/Lzgy8BpJl8eWpmamKvmlw92e5dyjIbzb1u9M2EyLp9Jo
         KGzqUlgwu3vpQphb9O45c1sh/EyTlaa+Cl0fR6b0eXc230nRjldzTKXfB1j1uH1WyXbw
         aUcZ1vpxpsJjInCEtoiiDwZ08Yzex051Xvh6QVHLtBQpfVqYUxVrE+ERq7I6+1r7RWjr
         H6+g==
X-Forwarded-Encrypted: i=1; AJvYcCU3xjFLHFuuVMEGo7EITiqBQOl91pE9fcEWj1ZbcXF5+U0UWGK6SwHCewkTrTvl/hkf5ks=@vger.kernel.org, AJvYcCV/qdNlSHCQxQm9D92vqdnjuiHoaK3HmTH4EjiP2yT1HLr0qzQR8vx9L3mbRtoBETCXNWENHz6XtYwDdkJQ@vger.kernel.org, AJvYcCVT6R1470Wdcscs+qanFVXyg7Nk0PB40Mjicp3C9YInVpKUMltcbKCpSLTd46DDPrb58vY/g3eoqWyFD0XFMkdu@vger.kernel.org, AJvYcCX3Hoz7IiP1EbG6igEjhUAmjdl78rWN281U9B/9J1gL7AQ30BTGXjINmXoAnCOR6TRqNjrq09P2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Me8GqtP3DQgWhPh3mq6zX5Y8h6ydi6q2J6f0o4Yk6/zE5Drb
	igo8zKorKOAGpPpkc2z8fzwfqnKP1cZEsx3uDSiVjzAE6/TdCCtC
X-Google-Smtp-Source: AGHT+IHJTsb9JJqJmmOmnSfNY64SPM8B2FQqgpuC1Eyu27a/9C0R/Xb6xWsHo14tMoRY2Ov75owgcg==
X-Received: by 2002:a05:6a20:db0d:b0:1d9:87e3:120c with SMTP id adf61e73a8af0-1d989ca8e6cmr1171984637.32.1729762509195;
        Thu, 24 Oct 2024 02:35:09 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:35:08 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	gnault@redhat.com,
	bigeasy@linutronix.de,
	idosch@nvidia.com,
	ast@kernel.org,
	dongml2@chinatelecom.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 5/9] net: ip: make ip_route_input_rcu() return drop reasons
Date: Thu, 24 Oct 2024 17:33:44 +0800
Message-Id: <20241024093348.353245-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024093348.353245-1-dongml2@chinatelecom.cn>
References: <20241024093348.353245-1-dongml2@chinatelecom.cn>
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
index 7976f687d039..4b0daf3510d7 100644
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


