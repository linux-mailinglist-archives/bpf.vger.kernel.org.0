Return-Path: <bpf+bounces-50245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDEBA24553
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 23:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5EE7A2E17
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 22:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8041F3FCE;
	Fri, 31 Jan 2025 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FKI9qBaV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967722F56;
	Fri, 31 Jan 2025 22:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738363138; cv=none; b=saS6eGRq7n7CqIgzOb/7yWZElUJygo3ze2ifs1R6COIt03uPkNGDxrMXZZS8YC8uUF4xbSW0xI6f8ssqiNnf5bW0bhBzLE7K52Jc8G9ana8UT89lYBITj+DFBw6Q7e0IpKkn7vHBLoPUsbpm1KrlbtxvYM7iFhy0Z/r6H5Z1Xi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738363138; c=relaxed/simple;
	bh=on9c8ZIKCIYXMHvT99XJiVB21v3JZtcClqSqdI4Z4Xk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YfjhZ+MFJj6CBLsVPHjizhk27qqvTptQ5cA7Ae4v1UlD5S2xabiMiYUOr+CF8tRjpVxfwldSrnSWfZzlgVEQyS+qdOG/anKNXEzempqDAYerRJ7EyMVDMLxPGxP2yYMa1GZouXXsJqqhu++MY+A/A86cL/CFJTfN4+YGdcQDUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FKI9qBaV; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738363136; x=1769899136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/HhvaKZtNI14lBek9raXqdcHJe1cZHixlkDfhk23d6c=;
  b=FKI9qBaVIwL+aI4njgNCP46n12jQoog2qKys3mK1nn3aUwq+GtyLgXg3
   MVgvSVeUbHGHRl+e4rTUKUPco1QH9xS35NXqtxPZx5n3bkCHjbOAnm0/+
   o+CUzrN2upGoEDlnZS1YukMwqZzk3/FftTq/F5QcKGX2aMTfBFJAzNA69
   w=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="795241822"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 22:38:50 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:34935]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.45:2525] with esmtp (Farcaster)
 id bbd88e31-7c83-4ff4-9d3e-090f9419ffe8; Fri, 31 Jan 2025 22:38:49 +0000 (UTC)
X-Farcaster-Flow-ID: bbd88e31-7c83-4ff4-9d3e-090f9419ffe8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 22:38:49 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 22:38:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <yan@cloudflare.com>
CC: <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: Unchecked sock pointer causes panic in RAW_TP
Date: Fri, 31 Jan 2025 14:38:38 -0800
Message-ID: <20250131223838.31897-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <Z50zebTRzI962e6X@debian.debian>
References: <Z50zebTRzI962e6X@debian.debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 31 Jan 2025 12:32:57 -0800
> Hello,
> 
> We encountered a panic when tracing kfree_skb with RAW_TP. The problematic
> argument was introduced in commit ba8de796baf4 ("net: introduce
> sk_skb_reason_drop function"). It turns out that the verifier still accepted
> the program despite it didn't test sk == NULL. And this caused kernel panic. I
> attached a small reproducer and panic trace at the end. It's stably
> reproducible when packets are dropped without a receiver (e.g. run iperf2 UDP
> test toward localhost), in both 6.12.11 release and a recent bpf-next master
> snapshot (I was using commit c03320a6768c).
> 
> As a contrast, for another tracepoint like tcp_send_reset, if sk is not checked
> before dereferencing, the verifier will complain and reject the program as
> expected. So this feels like some annotation is missing? Appreciate if someone
> could help me figure out.

Maybe __nullable is missing given we annotated skb for tcp_send_reset ?
https://lore.kernel.org/netdev/20240911033719.91468-4-lulie@linux.alibaba.com/

completely untested:

---8<---
diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index b877133cd93a..34accc5929d6 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -24,14 +24,14 @@ DEFINE_DROP_REASON(FN, FN)
 TRACE_EVENT(kfree_skb,
 
 	TP_PROTO(struct sk_buff *skb, void *location,
-		 enum skb_drop_reason reason, struct sock *rx_sk),
+		 enum skb_drop_reason reason, struct sock *rx_sk__nullable),
 
-	TP_ARGS(skb, location, reason, rx_sk),
+	TP_ARGS(skb, location, reason, rx_sk__nullable),
 
 	TP_STRUCT__entry(
 		__field(void *,		skbaddr)
 		__field(void *,		location)
-		__field(void *,		rx_sk)
+		__field(void *,		rx_sk__nullable)
 		__field(unsigned short,	protocol)
 		__field(enum skb_drop_reason,	reason)
 	),
@@ -39,7 +39,7 @@ TRACE_EVENT(kfree_skb,
 	TP_fast_assign(
 		__entry->skbaddr = skb;
 		__entry->location = location;
-		__entry->rx_sk = rx_sk;
+		__entry->rx_sk = rx_sk__nullable;
 		__entry->protocol = ntohs(skb->protocol);
 		__entry->reason = reason;
 	),
---8<---

