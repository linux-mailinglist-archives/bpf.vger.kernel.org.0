Return-Path: <bpf+bounces-53826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B11A5C388
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610613B06A2
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0429A25D537;
	Tue, 11 Mar 2025 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="BUAbQ4Ow"
X-Original-To: bpf@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46A25D1FF;
	Tue, 11 Mar 2025 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702421; cv=none; b=bWv8BYuWpbAl1Uin2ExnMNptfUNwNegNNLzyXFcB0zOLGydkXI31A0+SIeDSdEKwcwF7uXntP6RMzpvLZ1tZUtdUi2QFtg88NMhS4opcY/bxKNKroU+xBzOcybZQhw1vU0CAeUlsSvklxpg4eQU/09CGNdzlsauZwiii3/7GJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702421; c=relaxed/simple;
	bh=vf16/qFwjfGhuFg3ZWDp9bGUwboOaXnEeg66qrvdbUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+MDtevNgEjfq/Pvi428VrjrArwqLWSXMld/3Yq+17KeE6sxA8wUvVgYFvYputrMYzkq5HW/ZqlOhK1XYED4faRxt1AHFb2GrOIqtCSxMv2+hpFnAi1CZfo3/yyRY2ymT7IjRcVEbUmS/7HnjtFvFrHaE2ONr5F0zXNqNWxp3CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=BUAbQ4Ow; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (unknown [195.29.54.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 972E2200E1C8;
	Tue, 11 Mar 2025 15:13:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 972E2200E1C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741702418;
	bh=r8rPpTSOcA1huiswnu5JjPS6zX5wkv78jle2Vr8cPU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUAbQ4OwU1WwC4/G6olr2BaA3oHuj5S79nvOSyy7GJHAmiHJWub30lulsW417ytW4
	 5X5goBSRfAJUSSq6dD2awwKcpTDwi8vIFLAgvsPoi4qa0wjFWtdjNBiTSa6wyTPVUk
	 Fd8iw4juYsJj/zgjyZXiLoipQBKLVGGAmdc7YTXtuG4G1sCKrzMXreAIAb8Vq3hcC1
	 yInombnxO358BEeLDMG0e4bQiw3wiEl/CEqRW4EitOki+DMrf5d1EHT/m/6YODMRnS
	 UxgJD56v1paA+RMUSNI2xzc+QYDvAH5uWSfCoxghZiJBIM7J9d/Vh7syTcEhv0uzsq
	 KEOUlFJNwvhBw==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	bpf@vger.kernel.org,
	Guillaume Nault <gnault@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Peter Oskolkov <posk@google.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 6/7] net: core: bpf: fix lwtunnel_input/xmit loop
Date: Tue, 11 Mar 2025 15:12:37 +0100
Message-Id: <20250311141238.19862-7-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311141238.19862-1-justin.iurman@uliege.be>
References: <20250311141238.19862-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the lwtunnel_input() reentry loop and the lwtunnel_xmit() loop when
the destination is the same after transformation. For xmit, we refuse
BPF_LWT_REROUTE when dst_entry remains unchanged, since it's considered
a buggy configuration and there is no other easy way to prevent the
issue.

Fixes: 3bd0b15281af ("bpf: add handling of BPF_LWT_REROUTE to lwt_bpf.c")
Cc: bpf@vger.kernel.org
Cc: Guillaume Nault <gnault@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Menglong Dong <menglong8.dong@gmail.com>
Cc: Peter Oskolkov <posk@google.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/core/lwt_bpf.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index ae74634310a3..5ed849a0b23d 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -88,6 +88,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 
 static int bpf_lwt_input_reroute(struct sk_buff *skb)
 {
+	struct lwtunnel_state *lwtst = skb_dst(skb)->lwtstate;
 	enum skb_drop_reason reason;
 	int err = -EINVAL;
 
@@ -110,6 +111,13 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
 
 	if (err)
 		goto err;
+
+	/* avoid lwtunnel_input() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (lwtst == skb_dst(skb)->lwtstate)
+		return lwtst->orig_input(skb);
+
 	return dst_input(skb);
 
 err:
@@ -180,6 +188,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 	struct net_device *l3mdev = l3mdev_master_dev_rcu(skb_dst(skb)->dev);
 	int oif = l3mdev ? l3mdev->ifindex : 0;
 	struct dst_entry *dst = NULL;
+	struct dst_entry *orig_dst;
 	int err = -EAFNOSUPPORT;
 	struct sock *sk;
 	struct net *net;
@@ -201,6 +210,8 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 		net = dev_net(skb_dst(skb)->dev);
 	}
 
+	orig_dst = skb_dst(skb);
+
 	if (ipv4) {
 		struct iphdr *iph = ip_hdr(skb);
 		struct flowi4 fl4 = {};
@@ -254,6 +265,16 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 	if (unlikely(err))
 		goto err;
 
+	/* avoid lwtunnel_xmit() reentry loop when destination is the same
+	 * after transformation (i.e., disallow BPF_LWT_REROUTE when dst_entry
+	 * remains the same).
+	 */
+	if (orig_dst->lwtstate == dst->lwtstate) {
+		dst_release(dst);
+		err = -EINVAL;
+		goto err;
+	}
+
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 
-- 
2.34.1


