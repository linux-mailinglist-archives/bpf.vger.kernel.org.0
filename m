Return-Path: <bpf+bounces-43473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEE69B5963
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B20E1F232AA
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E87F1C4616;
	Wed, 30 Oct 2024 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPZWKhWl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347BB1C3F04;
	Wed, 30 Oct 2024 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252607; cv=none; b=WMtmFq7/ZRC/Il5qAaSxDAuoEY1rrYVOWk/EH2eLb98kOB+hC7f2DOqAESpsuN3c3anAgff7SnSXTLfdMl1CFjS3V15Mb7TGtE0HGp3tNnE34iVvc891qvmCf/naZKyNPpsT4ICqF45rY9k1CLY0900UX7QujzPGetgu9kM84KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252607; c=relaxed/simple;
	bh=A/n+tA2LV99QwIElK+AO6/wgstFiziRfCh0zEBgGADk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JieyU+U7z5tgcLAPm58Rnpy9DLYWbQgR1mIoLjx1rVo8z34xh35v0sruBx/hukuSodBdf2MLl0hZ5ZmGq2EGmyxHtnSBB/VD+3bD/IilGx9XiXGC+JjtspZXbo1uHlIbfhncZgCIRPICC8ZrMFq2cV69BE1FpnWCVk9RDsCr93A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPZWKhWl; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-3e5f86e59f1so3187936b6e.1;
        Tue, 29 Oct 2024 18:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252604; x=1730857404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsqFsNdo4NVKbN05C2RYi/RSEJVp+Ni3JWGZTDWcFI8=;
        b=KPZWKhWlqrHGkmq6qP3OHWG1eqiOSkGBWpfmll5MRfElOzuIR4WlvQdOXhi8v0T3fY
         ESQWvCswq38LAgZUSNZJ46lh+wHXFAwT+xhG6u7oEXE9VACOKaghm6YKNLXjkfmD00X3
         RftUmzqNsXCPlPgwVbXUUVBX3YWiUpysJ/XHZo89fVfj1cosXJ959HXNw911uD4memkg
         m9jpdkfBE4UsktG6QV9cUP0uvlaqb3o4ezuq1XuHMvXJwI9KjxQVuwUu/+jOSccqqhQ9
         bu3ITcvLd9vXcguis2HrwD6jrf5W87pyFJffUg+nqj4YmVbtgjSyTqlf406vxw/cWPza
         37dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252604; x=1730857404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsqFsNdo4NVKbN05C2RYi/RSEJVp+Ni3JWGZTDWcFI8=;
        b=c/e/O068y3BPLb2OUvrwapqSDOk/ruOd2Xa41QlfT1LSJA4UttOtGBd3SGMqIwDTf3
         Xb9sH9NkOJvgOFovdDs7kw0cO8nce4p/74jqyafbw8xMylbNN2N809g0prHZFuIT2AOo
         dtTl6vNfsbHQvuXLbcwk+1hlXj/1X04Gudw7UxejhZCkXLcORwGvxZItj+4xdFjV4/Fg
         nyKnLqxZK37F7EzSWCJw3d25I3xImbxBVkTPJuYrU+oBixD+HmGO065SSsNy6zX4TnIy
         UGV70Sq1ICKgyLwj3XDgKZXHBXSEYkQjohReB6bpclM98sLhkM6C2TpcBFaPbdLEngKZ
         H7KA==
X-Forwarded-Encrypted: i=1; AJvYcCUPozgSmk4Dm4X+4SWKVYG1l/WgyX5uocc22haLEIIMi+Y8uVLIpp080pghdYiGKGjWlL3LVTl5@vger.kernel.org, AJvYcCUtDwEHuH/CzVRH/KMu/WDMNlpXIymzROONV8fav/rmUEAH8mHdI5fJTmMCbAYf7/iH3PM=@vger.kernel.org, AJvYcCVf+2BaKun45MQd1QUBfyqmOJxpcp0qssIzT+VEN8N0rUdc7wF4HEIP901b46YJ6g9DDBZR3SspkPCD7Eo0@vger.kernel.org, AJvYcCVqJnv5H090ehSOaems2XbKHGijEYxnTDKs0d0DcTWLW+JrVb4p0pgVaX9P+9XRMBIORKFuwGzZ49D6ca1wap7R@vger.kernel.org
X-Gm-Message-State: AOJu0YzaffljxezuJlTmE+JUUwlx7MT+QebSAekY1m8HyBamgPVRRr0w
	TP9rpBTOTMlzIGTNPcSx1PUcIJKWSUJfN2fN/a8vRyNsH5TusjwO
X-Google-Smtp-Source: AGHT+IFRqo3e3L4yXTv3rX5bR7Hg6ifzhHqEYCt+WbgiCc4zN+xOObjiqS/gASg+PXrO7UKBKJyK+A==
X-Received: by 2002:a05:6808:1649:b0:3e6:4d87:8f02 with SMTP id 5614622812f47-3e64d879ac9mr5753123b6e.12.1730252604097;
        Tue, 29 Oct 2024 18:43:24 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc866906dsm8138407a12.10.2024.10.29.18.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:43:23 -0700 (PDT)
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
Subject: [PATCH RESEND net-next v4 5/9] net: ip: make ip_route_input_rcu() return drop reasons
Date: Wed, 30 Oct 2024 09:41:41 +0800
Message-Id: <20241030014145.1409628-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
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


