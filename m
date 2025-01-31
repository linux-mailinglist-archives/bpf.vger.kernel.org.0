Return-Path: <bpf+bounces-50252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6257EA245AA
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 00:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16651676CC
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 23:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CC01BBBE5;
	Fri, 31 Jan 2025 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="issIAdkQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FF22AD20;
	Fri, 31 Jan 2025 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738366152; cv=none; b=XBsJSTqGdg6SClyJWFVIETDcU+plt3My7p39eCSGUkFbI5H+Hf2BoIP80V4SBVcUz8m1D4VPVBxaWTUUccB+KOBaSLOKVk0Xy3WkF98EYJR2WUU97jZShEt6v0L5R0u1qjd2oruTSxpUQPYb/VbXiLHXsQwetNkTce8bWj1/e/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738366152; c=relaxed/simple;
	bh=uiOp4G47AeZjkzC/gn8Hcf7Hl1aY4KA+2idNS8Te5Lg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5HSSgcyfyotXCWsF/EcfEmIbHRyHEbc8tHuKv/O0MghJlolqi3hi3bwYeiCxkaEIZHQoS3s4d+zSPoY/df83OjVO1ypDBqFUnWkuH7oqqPVeAl/hUbRjnCejcrAVgfvGccmCeWYsA6JnmiAkAGkeqeg52ZiG79FrI5X5XLQKXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=issIAdkQ; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738366150; x=1769902150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BPlxeN2a6p67PdZJ63v0E0a9k68rmC7oM2q4wvHCJfo=;
  b=issIAdkQ3f6bLdX5dFzci6eLDhTJD8iTjXI3dRz4zZFuXvhnHrkrjCEw
   SXvC29bQeNzr5uEWuFgTpNznXvv+yUtAEnBButro3l1ms3Yz/2Z/4Pk8N
   kxH5VADac20zK4wHB0ZUkl1eQgofdISPn0pUoiXEkbRNPFjY4zlWlQVRm
   s=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="267474509"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 23:29:07 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:4326]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.45:2525] with esmtp (Farcaster)
 id 7bede0e9-74b1-4730-b4b4-98444a52781e; Fri, 31 Jan 2025 23:29:07 +0000 (UTC)
X-Farcaster-Flow-ID: 7bede0e9-74b1-4730-b4b4-98444a52781e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 23:29:01 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 23:28:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<yan@cloudflare.com>
Subject: Re: Unchecked sock pointer causes panic in RAW_TP
Date: Fri, 31 Jan 2025 15:28:51 -0800
Message-ID: <20250131232851.36345-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131223838.31897-1-kuniyu@amazon.com>
References: <20250131223838.31897-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Fri, 31 Jan 2025 14:38:38 -0800
> From: Yan Zhai <yan@cloudflare.com>
> Date: Fri, 31 Jan 2025 12:32:57 -0800
> > Hello,
> > 
> > We encountered a panic when tracing kfree_skb with RAW_TP. The problematic
> > argument was introduced in commit ba8de796baf4 ("net: introduce
> > sk_skb_reason_drop function"). It turns out that the verifier still accepted
> > the program despite it didn't test sk == NULL. And this caused kernel panic. I
> > attached a small reproducer and panic trace at the end. It's stably
> > reproducible when packets are dropped without a receiver (e.g. run iperf2 UDP
> > test toward localhost), in both 6.12.11 release and a recent bpf-next master
> > snapshot (I was using commit c03320a6768c).
> > 
> > As a contrast, for another tracepoint like tcp_send_reset, if sk is not checked
> > before dereferencing, the verifier will complain and reject the program as
> > expected. So this feels like some annotation is missing? Appreciate if someone
> > could help me figure out.
> 
> Maybe __nullable is missing given we annotated skb for tcp_send_reset ?
> https://lore.kernel.org/netdev/20240911033719.91468-4-lulie@linux.alibaba.com/
> 
> completely untested:
> 
> ---8<---
> diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> index b877133cd93a..34accc5929d6 100644
> --- a/include/trace/events/skb.h
> +++ b/include/trace/events/skb.h
> @@ -24,14 +24,14 @@ DEFINE_DROP_REASON(FN, FN)
>  TRACE_EVENT(kfree_skb,
>  
>  	TP_PROTO(struct sk_buff *skb, void *location,
> -		 enum skb_drop_reason reason, struct sock *rx_sk),
> +		 enum skb_drop_reason reason, struct sock *rx_sk__nullable),
>  
> -	TP_ARGS(skb, location, reason, rx_sk),
> +	TP_ARGS(skb, location, reason, rx_sk__nullable),
>  
>  	TP_STRUCT__entry(
>  		__field(void *,		skbaddr)
>  		__field(void *,		location)
> -		__field(void *,		rx_sk)
> +		__field(void *,		rx_sk__nullable)

This part is unnecessary.


>  		__field(unsigned short,	protocol)
>  		__field(enum skb_drop_reason,	reason)
>  	),
> @@ -39,7 +39,7 @@ TRACE_EVENT(kfree_skb,
>  	TP_fast_assign(
>  		__entry->skbaddr = skb;
>  		__entry->location = location;
> -		__entry->rx_sk = rx_sk;
> +		__entry->rx_sk = rx_sk__nullable;
>  		__entry->protocol = ntohs(skb->protocol);
>  		__entry->reason = reason;
>  	),
> ---8<---
> 

