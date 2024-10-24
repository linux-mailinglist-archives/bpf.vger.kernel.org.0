Return-Path: <bpf+bounces-43030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D73A9AE0E5
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DA8282E6C
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D95B1B3925;
	Thu, 24 Oct 2024 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMha6eFG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581EC1B6CE4;
	Thu, 24 Oct 2024 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762489; cv=none; b=nZR+BjWvAq0FQdtRXwRfvS+LmChXcbcyFj6kZZBbGk8qTYn+Uxm5beRG44C7IPpjdgXCHmny9UaiXGN1cj7dKZEHKNTIBfyCqd4XwkCyXVVMQ+vABSreGsL0/LcVqJnSnkDcmLtjGUmFyyS5dZAUR+O1KSID2EB83Wd2LNZvanA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762489; c=relaxed/simple;
	bh=y2FaqBJ1dgItkKU95lOixnUvt8qQFhy2BOspmoTjK1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fZWz7pdJP3k8t9UcKRdw0zHS44kWdQPDatrpBYqQ6yHPR/FTQqlpB/e1ljTf0zMtxqIvfoKdyizpB5k1Lj7C6Pzfq92syB5uAwB/ZfG4GRcflbz6XUSN9Wic4UENm7gY6pZrnRD05DgVUbgUMeNxamPc8AgWG5pKDOuHZr2ALno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMha6eFG; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so441823a12.1;
        Thu, 24 Oct 2024 02:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762487; x=1730367287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prmHa2Jv4moizPfRKfdWmdtiFsKQEgjm40Ey0Wfd4hM=;
        b=hMha6eFGeEk0xrYHeGADqk7+DnEkAu/Mn2s0xfKqeC2CxecA/xC4H8GCUeQgrkokRd
         qBeRN7Srmb6+SHvTcmwPvrQcXtn7CXJdN1/kGL1C4+ukFLjlyP3u9gHh9/PpIkDBEIVR
         HFFXhjvMhZs6Ka2mNJEJ1JYNCL9o3jK4F1gInwz8eTc7s9EXnhXfsLt+BgufDwS4rICr
         LzA1yuufZJKBPRY7eDouGR6S7iV29V6L8UTha21KmOUw42J90LZxZAfMOrA3mXXpqju3
         d0RrhJiIgld47zd9xCwXI2lWSMNG8NS9knhjKV31XPAFwKg+LtRrFEMzYoAnqulf4FYn
         GHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762487; x=1730367287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prmHa2Jv4moizPfRKfdWmdtiFsKQEgjm40Ey0Wfd4hM=;
        b=sJbd36qvHVJqnZr7Ixr6VWORmWDGzymG7/JfDK5Rkmq3JCxmLOTV0vdsGlcPntZPeT
         2CPNDjaZylNjnMkyYeRariDvnXTPplJc2ds1axLpG9tRxDVkkh5kbJpVrEU1FDXIlEvQ
         aBbsi8Q7qIJvTuS+GGG2FwMWECGmcQjs0bvyoxP/3fCHDRrJUUnBJRrV0LZ/SjpfaX5P
         1FkPkWyX1Sabo9wDpVCqYXaXf9PxUzeFTDuw6s62JnqoOeyd0mtSSyShOSCbLCKJwSCZ
         rp6e1FpxPbOQqZ8s6Iz3grD28twtCc3fp5wwJOHGlqiQ/lrHBBnLlJcXq/iSO/otfRoc
         0PTA==
X-Forwarded-Encrypted: i=1; AJvYcCW4bOyYVYGutfelfzzdI+HapuQnIFu3oHKbyb8TvNWRCAVVcbE6rEE5JT16UyjtdyUUICdg8MTDZJyLfBekboAC@vger.kernel.org, AJvYcCW5UrtspPTIJelelgmPdPYmO2gVQUIbOw9tUtw96dXm4fsFRuDEQbyfZGJwNvY3BtSgSMnqHQQv@vger.kernel.org, AJvYcCWXvVcW0Cv0Ees8Eu+iVEbObNM8HOZZEPdIzbQbNddqo8FHH9zIwIyl4Y3ex3vfN4y62Ett/X9g8HcKRYbv@vger.kernel.org, AJvYcCXb2I7/AkRwsye4CgYSGAaLODQLYyBiTMiXL9VBZ2OT8/iqK80TzQWjd7lpNAzy78L2oUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYF4ys9yyV7xKsYQCYa/KzGb56NKg6FjAbNQHZkOtjROGBF7qY
	2ZN4FLKFQcQXMuXXY9CpYkGZ9tMyyNZjnXsJAiwsFryYzcglDGXkOKKXNtPL
X-Google-Smtp-Source: AGHT+IFLPx9hvlqmrBOsaIDs3+bQY1hhD7xh2c0lYFAEkwiNwsAf3IDanQ3V5nYzAaMdFJsEQMQNfg==
X-Received: by 2002:a05:6a20:d528:b0:1d9:1f7a:a44f with SMTP id adf61e73a8af0-1d978af3c41mr6796637637.12.1729762486527;
        Thu, 24 Oct 2024 02:34:46 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:34:46 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/9] net: ip: make fib_validate_source() support drop reasons
Date: Thu, 24 Oct 2024 17:33:40 +0800
Message-Id: <20241024093348.353245-2-dongml2@chinatelecom.cn>
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

In this commit, we make fib_validate_source() and __fib_validate_source()
return -reason instead of errno on error.

The return value of fib_validate_source can be -errno, 0, and 1. It's hard
to make fib_validate_source() return drop reasons directly.

The fib_validate_source() will return 1 if the scope of the source(revert)
route is HOST. And the __mkroute_input() will mark the skb with
IPSKB_DOREDIRECT in this case (combine with some other conditions). And
then, a REDIRECT ICMP will be sent in ip_forward() if this flag exists. We
can't pass this information to __mkroute_input if we make
fib_validate_source() return drop reasons.

Therefore, we introduce the wrapper fib_validate_source_reason() for
fib_validate_source(), which will return the drop reasons on error.

In the origin logic, LINUX_MIB_IPRPFILTER will be counted if
fib_validate_source() return -EXDEV. And now, we need to adjust it by
checking "reason == SKB_DROP_REASON_IP_RPFILTER". However, this will take
effect only after the patch "net: ip: make ip_route_input_noref() return
drop reasons", as we can't pass the drop reasons from
fib_validate_source() to ip_rcv_finish_core() in this patch.

Following new drop reasons are added in this patch:

  SKB_DROP_REASON_IP_LOCAL_SOURCE
  SKB_DROP_REASON_IP_INVALID_SOURCE

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- don't refactor fib_validate_source/__fib_validate_source, and introduce
  a wrapper for fib_validate_source() instead.
v2:
- make fib_validate_source() return drop reasons, instead of -reason.
---
 include/net/dropreason-core.h | 10 ++++++++++
 include/net/ip_fib.h          | 12 ++++++++++++
 net/ipv4/fib_frontend.c       | 17 ++++++++++++-----
 net/ipv4/ip_input.c           |  4 +---
 net/ipv4/route.c              | 33 +++++++++++++++++++--------------
 5 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index d59bb96c5a02..62a60be1db84 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -76,6 +76,8 @@
 	FN(INVALID_PROTO)		\
 	FN(IP_INADDRERRORS)		\
 	FN(IP_INNOROUTES)		\
+	FN(IP_LOCAL_SOURCE)		\
+	FN(IP_INVALID_SOURCE)		\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -373,6 +375,14 @@ enum skb_drop_reason {
 	 * IPSTATS_MIB_INADDRERRORS
 	 */
 	SKB_DROP_REASON_IP_INNOROUTES,
+	/** @SKB_DROP_REASON_IP_LOCAL_SOURCE: the source ip is local */
+	SKB_DROP_REASON_IP_LOCAL_SOURCE,
+	/**
+	 * @SKB_DROP_REASON_IP_INVALID_SOURCE: the source ip is invalid:
+	 * 1) source ip is multicast or limited broadcast
+	 * 2) source ip is zero and not IGMP
+	 */
+	SKB_DROP_REASON_IP_INVALID_SOURCE,
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index b6e44f4eaa4c..a113c11ab56b 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -452,6 +452,18 @@ int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 			dscp_t dscp, int oif, struct net_device *dev,
 			struct in_device *idev, u32 *itag);
 
+static inline enum skb_drop_reason
+fib_validate_source_reason(struct sk_buff *skb, __be32 src, __be32 dst,
+			   dscp_t dscp, int oif, struct net_device *dev,
+			   struct in_device *idev, u32 *itag)
+{
+	int err = fib_validate_source(skb, src, dst, dscp, oif, dev, idev,
+				      itag);
+	if (err < 0)
+		return -err;
+	return SKB_NOT_DROPPED_YET;
+}
+
 #ifdef CONFIG_IP_ROUTE_CLASSID
 static inline int fib_num_tclassid_users(struct net *net)
 {
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 53bd26315df5..99dddfab95b9 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -346,6 +346,7 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 				 int rpf, struct in_device *idev, u32 *itag)
 {
 	struct net *net = dev_net(dev);
+	enum skb_drop_reason reason;
 	struct flow_keys flkeys;
 	int ret, no_addr;
 	struct fib_result res;
@@ -377,9 +378,15 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 
 	if (fib_lookup(net, &fl4, &res, 0))
 		goto last_resort;
-	if (res.type != RTN_UNICAST &&
-	    (res.type != RTN_LOCAL || !IN_DEV_ACCEPT_LOCAL(idev)))
-		goto e_inval;
+	if (res.type != RTN_UNICAST) {
+		if (res.type != RTN_LOCAL) {
+			reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
+			goto e_inval;
+		} else if (!IN_DEV_ACCEPT_LOCAL(idev)) {
+			reason = SKB_DROP_REASON_IP_LOCAL_SOURCE;
+			goto e_inval;
+		}
+	}
 	fib_combine_itag(itag, &res);
 
 	dev_match = fib_info_nh_uses_dev(res.fi, dev);
@@ -412,9 +419,9 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	return 0;
 
 e_inval:
-	return -EINVAL;
+	return -reason;
 e_rpf:
-	return -EXDEV;
+	return -SKB_DROP_REASON_IP_RPFILTER;
 }
 
 /* Ignore rp_filter for packets protected by IPsec. */
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 89bb63da6852..c40a26972884 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -425,10 +425,8 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	return NET_RX_DROP;
 
 drop_error:
-	if (err == -EXDEV) {
-		drop_reason = SKB_DROP_REASON_IP_RPFILTER;
+	if (drop_reason == SKB_DROP_REASON_IP_RPFILTER)
 		__NET_INC_STATS(net, LINUX_MIB_IPRPFILTER);
-	}
 	goto drop;
 }
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 18a08b4f4a5a..3e7a3e947b7d 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1669,7 +1669,7 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			  dscp_t dscp, struct net_device *dev,
 			  struct in_device *in_dev, u32 *itag)
 {
-	int err;
+	enum skb_drop_reason reason;
 
 	/* Primary sanity checks. */
 	if (!in_dev)
@@ -1687,10 +1687,10 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		    ip_hdr(skb)->protocol != IPPROTO_IGMP)
 			return -EINVAL;
 	} else {
-		err = fib_validate_source(skb, saddr, 0, dscp, 0, dev, in_dev,
-					  itag);
-		if (err < 0)
-			return err;
+		reason = fib_validate_source_reason(skb, saddr, 0, dscp, 0,
+						    dev, in_dev, itag);
+		if (reason)
+			return -EINVAL;
 	}
 	return 0;
 }
@@ -1788,6 +1788,7 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	err = fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
 				  in_dev->dev, in_dev, &itag);
 	if (err < 0) {
+		err = -EINVAL;
 		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
 					 saddr);
 
@@ -2140,6 +2141,7 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct rtable *rt = skb_rtable(hint);
 	struct net *net = dev_net(dev);
+	enum skb_drop_reason reason;
 	int err = -EINVAL;
 	u32 tag = 0;
 
@@ -2158,9 +2160,9 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	if (rt->rt_type != RTN_LOCAL)
 		goto skip_validate_source;
 
-	err = fib_validate_source(skb, saddr, daddr, dscp, 0, dev, in_dev,
-				  &tag);
-	if (err < 0)
+	reason = fib_validate_source_reason(skb, saddr, daddr, dscp, 0, dev,
+					    in_dev, &tag);
+	if (reason)
 		goto martian_source;
 
 skip_validate_source:
@@ -2202,6 +2204,7 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			       dscp_t dscp, struct net_device *dev,
 			       struct fib_result *res)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct flow_keys *flkeys = NULL, _flkeys;
 	struct net    *net = dev_net(dev);
@@ -2296,10 +2299,11 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		goto brd_input;
 	}
 
+	err = -EINVAL;
 	if (res->type == RTN_LOCAL) {
-		err = fib_validate_source(skb, saddr, daddr, dscp, 0, dev,
-					  in_dev, &itag);
-		if (err < 0)
+		reason = fib_validate_source_reason(skb, saddr, daddr, dscp,
+						    0, dev, in_dev, &itag);
+		if (reason)
 			goto martian_source;
 		goto local_input;
 	}
@@ -2320,9 +2324,10 @@ out:	return err;
 		goto e_inval;
 
 	if (!ipv4_is_zeronet(saddr)) {
-		err = fib_validate_source(skb, saddr, 0, dscp, 0, dev, in_dev,
-					  &itag);
-		if (err < 0)
+		err = -EINVAL;
+		reason = fib_validate_source_reason(skb, saddr, 0, dscp, 0,
+						    dev, in_dev, &itag);
+		if (reason)
 			goto martian_source;
 	}
 	flags |= RTCF_BROADCAST;
-- 
2.39.5


