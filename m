Return-Path: <bpf+bounces-55403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AE4A7E07F
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 16:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC693A73FC
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 14:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC09C1C760D;
	Mon,  7 Apr 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jbdAoQtP"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EE1B4251
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034448; cv=none; b=GNjhfCdZkuKZITWlHoeb2ReUVZEBGU+med9uZAKpYBcb2nSdXEDiKExD+fueWnsGJCdMJ/KGMXlCRtTFB5QahFJ5QRIZRhQ7jGXyoUvG7HSX5Nu+YkqO3Yz7mlc/YpjQq7tAybjRO57i5H9LmwzTI9EiMf0O2mS5ZndN6x6UDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034448; c=relaxed/simple;
	bh=7LrK4+MSCQBQFEg2PH2/aBeSSmKtqORGYXRBnlS/6GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUtkY3KQaHoWWAqWAbd0N6inhcAPqs0MgVyy24QaqUY4W7bk6PxU40dvKdTeenM8rkQEdkWEm73DxYtWX1WtaCfC5LwHokEeeUbzgQw26a77LXYZFPgEmy/GTRAqoNQxc9THDR44IlIJyciJI+sLjs1q/iSEmyv/XBH606UyMw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jbdAoQtP; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744034443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSot3nw7CEW5EVdvYwJBj+RWIEBQWOakFzZs+Ew+PEI=;
	b=jbdAoQtPHSJIxk5w+e979vRQUoYMe/oR63p7XQQ2cNwF753extQrOGARTvodaEe+XG5tZV
	EMWjaNWeHaDYiE89ZlCul8kVp+tFMjxh+SGQ1JZ25cuUmHBOdzIQHsn1ZRJhdrNbGUVUKe
	Z0RGrrZi5hphR633A4erHlXCmGjUN7Q=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Antony Antony <antony.antony@secunet.com>,
	Christian Hopps <chopps@labn.net>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND net-next v3 2/2] tcp: add LINUX_MIB_PAWS_TW_REJECTED counter
Date: Mon,  7 Apr 2025 21:59:51 +0800
Message-ID: <20250407140001.13886-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250407140001.13886-1-jiayuan.chen@linux.dev>
References: <20250407140001.13886-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When TCP is in TIME_WAIT state, PAWS verification uses
LINUX_PAWSESTABREJECTED, which is ambiguous and cannot be distinguished
from other PAWS verification processes.

Moreover, when PAWS occurs in TIME_WAIT, we typically need to pay special
attention to upstream network devices, so we added a new counter, like the
existing PAWS_OLD_ACK one.

Also we update the doc with previously missing PAWS_OLD_ACK.

usage:
'''
nstat -az | grep PAWSTimewait
TcpExtPAWSTimewait              1                  0.0
'''

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 Documentation/networking/net_cachelines/snmp.rst | 2 ++
 include/net/dropreason-core.h                    | 1 +
 include/uapi/linux/snmp.h                        | 1 +
 net/ipv4/proc.c                                  | 1 +
 net/ipv4/tcp_minisocks.c                         | 2 +-
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/snmp.rst b/Documentation/networking/net_cachelines/snmp.rst
index bc96efc92cf5..bd44b3eebbef 100644
--- a/Documentation/networking/net_cachelines/snmp.rst
+++ b/Documentation/networking/net_cachelines/snmp.rst
@@ -37,6 +37,8 @@ unsigned_long  LINUX_MIB_TIMEWAITKILLED
 unsigned_long  LINUX_MIB_PAWSACTIVEREJECTED
 unsigned_long  LINUX_MIB_PAWSESTABREJECTED
 unsigned_long  LINUX_MIB_TSECR_REJECTED
+unsigned_long  LINUX_MIB_PAWS_OLD_ACK
+unsigned_long  LINUX_MIB_PAWS_TW_REJECTED
 unsigned_long  LINUX_MIB_DELAYEDACKLOST
 unsigned_long  LINUX_MIB_LISTENOVERFLOWS
 unsigned_long  LINUX_MIB_LISTENDROPS
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 9701d7f936f6..bea77934a235 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -287,6 +287,7 @@ enum skb_drop_reason {
 	/**
 	 * @SKB_DROP_REASON_TCP_RFC7323_TW_PAWS: PAWS check, socket is in
 	 * TIME_WAIT state.
+	 * Corresponds to LINUX_MIB_PAWS_TW_REJECTED.
 	 */
 	SKB_DROP_REASON_TCP_RFC7323_TW_PAWS,
 	/**
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index ec47f9b68a1b..1d234d7e1892 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -188,6 +188,7 @@ enum
 	LINUX_MIB_PAWSESTABREJECTED,		/* PAWSEstabRejected */
 	LINUX_MIB_TSECRREJECTED,		/* TSEcrRejected */
 	LINUX_MIB_PAWS_OLD_ACK,			/* PAWSOldAck */
+	LINUX_MIB_PAWS_TW_REJECTED,		/* PAWSTimewait */
 	LINUX_MIB_DELAYEDACKS,			/* DelayedACKs */
 	LINUX_MIB_DELAYEDACKLOCKED,		/* DelayedACKLocked */
 	LINUX_MIB_DELAYEDACKLOST,		/* DelayedACKLost */
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 10cbeb76c274..ea2f01584379 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -191,6 +191,7 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("PAWSEstab", LINUX_MIB_PAWSESTABREJECTED),
 	SNMP_MIB_ITEM("TSEcrRejected", LINUX_MIB_TSECRREJECTED),
 	SNMP_MIB_ITEM("PAWSOldAck", LINUX_MIB_PAWS_OLD_ACK),
+	SNMP_MIB_ITEM("PAWSTimewait", LINUX_MIB_PAWS_TW_REJECTED),
 	SNMP_MIB_ITEM("DelayedACKs", LINUX_MIB_DELAYEDACKS),
 	SNMP_MIB_ITEM("DelayedACKLocked", LINUX_MIB_DELAYEDACKLOCKED),
 	SNMP_MIB_ITEM("DelayedACKLost", LINUX_MIB_DELAYEDACKLOST),
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 27511bf58c0f..43d7852ce07e 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -248,7 +248,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 
 	if (paws_reject) {
 		*drop_reason = SKB_DROP_REASON_TCP_RFC7323_TW_PAWS;
-		__NET_INC_STATS(twsk_net(tw), LINUX_MIB_PAWSESTABREJECTED);
+		__NET_INC_STATS(twsk_net(tw), LINUX_MIB_PAWS_TW_REJECTED);
 	}
 
 	if (!th->rst) {
-- 
2.47.1


