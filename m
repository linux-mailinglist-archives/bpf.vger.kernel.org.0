Return-Path: <bpf+bounces-52513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CCDA4435E
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 15:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B4219C61CF
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 14:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5258721ABCC;
	Tue, 25 Feb 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R1wzgBf9"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17F21ABBB
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494425; cv=none; b=EZoGX04GRPhuY6O4YTPPLF8wE+ixhDEkgf06LFQUnoMHdvkITv2pNl9F+PL4PbSIlhIC8DHwGyAEHzDN5NZJ20kk8yV9s2k2SnRygNn33+7i56/50baLjNw1QuwURBFb6sKm68KzvCD5kbsOoxAKwWnaC0bJ9V1B8GII5wSRZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494425; c=relaxed/simple;
	bh=OZfTVkvVnd2ATJnLV7c72Ww8Jh0nTmUH+7NVTIMLuw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQMpcRXKM4Us7AJKd0GYmFzHI6VZv4anVAh9tCUvEPcnK5J5oeR85i27GyuboTiB8eeGzNKKd4+6WN6eczUMxG9xOwO1RNX1TrVP2B83i222Kd+O5dPB6ll7PXQ9eJl1pNNEj5rDaOAkaJd6XZ+3mQSqkLFXmp1DbZWS7AjoNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R1wzgBf9; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740494421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXSrSpLtmLGLsFjhz36tFMFjVePBC+E+1caV/MkW3ZE=;
	b=R1wzgBf9KhfmXUVxIwII1Ps62lITvnwbgacq8liUe72/AkKQQ1r+PJWhdoPhFt++XDJbnp
	nmUrhWZ7dx7AWygL3LMJQr5oWPMJDz6YwRLqSkyo2WqX/pq6lebv89jmiwsICCnzPtvn3L
	5/7soBWw+7Wcq68PNtwkc7SFmD7TgrU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: horms@kernel.org,
	kuba@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	ricardo@marliere.net,
	viro@zeniv.linux.org.uk,
	dmantipov@yandex.ru,
	aleksander.lobakin@intel.com,
	linux-ppp@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Subject: [PATCH net-next 1/1] ppp: Fix KMSAN warning by initializing 2-byte header
Date: Tue, 25 Feb 2025 22:40:04 +0800
Message-ID: <20250225144004.277169-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250225144004.277169-1-jiayuan.chen@linux.dev>
References: <20250225144004.277169-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The PPP driver adds an extra 2-byte header to enable socket filters to run
correctly. However, the driver only initializes the first byte, which
indicates the direction. For normal BPF programs, this is not a problem
since they only read the first byte.

Nevertheless, for carefully crafted BPF programs, if they read the second
byte, this will trigger a KMSAN warning for reading uninitialized data.

Reported-by: syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/000000000000dea025060d6bc3bc@google.com/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 drivers/net/ppp/ppp_generic.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 4583e15ad03a..4019bc959a2a 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -72,6 +72,10 @@
 #define PPP_PROTO_LEN	2
 #define PPP_LCP_HDRLEN	4
 
+/* These are fields recognized by libpcap */
+#define PPP_FILTER_OUTBOUND_TAG 0x0100
+#define PPP_FILTER_INBOUND_TAG  0x0000
+
 /*
  * An instance of /dev/ppp can be associated with either a ppp
  * interface unit or a ppp channel.  In both cases, file->private_data
@@ -1762,10 +1766,15 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 
 	if (proto < 0x8000) {
 #ifdef CONFIG_PPP_FILTER
-		/* check if we should pass this packet */
-		/* the filter instructions are constructed assuming
-		   a four-byte PPP header on each packet */
-		*(u8 *)skb_push(skb, 2) = 1;
+		/* Check if we should pass this packet.
+		 * The filter instructions are constructed assuming
+		 * a four-byte PPP header on each packet. The first byte
+		 * indicates the direction, and the second byte is meaningless,
+		 * but we still need to initialize it to prevent crafted BPF
+		 * programs from reading them which would cause reading of
+		 * uninitialized data.
+		 */
+		*(u16 *)skb_push(skb, 2) = htons(PPP_FILTER_OUTBOUND_TAG);
 		if (ppp->pass_filter &&
 		    bpf_prog_run(ppp->pass_filter, skb) == 0) {
 			if (ppp->debug & 1)
-- 
2.47.1


