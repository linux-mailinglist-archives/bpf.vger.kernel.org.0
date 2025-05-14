Return-Path: <bpf+bounces-58246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2302DAB77CC
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 23:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B86C7A3457
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 21:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ED7296707;
	Wed, 14 May 2025 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="l+drQHj2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1508E221F0E;
	Wed, 14 May 2025 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747257751; cv=none; b=kymH6ujfMvFuZgMnC3a0/gLhW9o1g+j+nX4UjY+LPVL7HLzQ0fBXtOP4MmHp5/QvYEMLL1/gK3Ba4PdLHyjfOezXxEyAcr4v4yRyrO7N+WBjs4yRjzCWCX1wxqyXtpDSHjpAxt8XzErenzzoP1YDpY16bIeGYXvus7gqpJaeqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747257751; c=relaxed/simple;
	bh=XxnN9AI0+wYh1C3IzIH2XDW4+HjpaqR+po+ZzE3xoag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bC2NaE62wcFKMWl12nQI47nXCe5IqXfdWaMiL9MzksW0wnEHMOLpEPpzgzCpPOqmSlMubE/esVLCHa+l/UMMkuvLbu0PKUwEDIWRJq13QL9wGumBOEf3vvM62R8z6E+SfO17eoRt71Wyz2LD4TrwC2ByCj4I/+37KYVskT4Vm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=l+drQHj2; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747257747; x=1778793747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a+dE/CwXrOBwJzAwCvyptOO8W+ZUgOFfKvNqAQD+JYA=;
  b=l+drQHj24AyuU4PB64TFqVYkAy2A2GCGUtAR1IdVS4hrJhLpBVk2/aL2
   hNID1ktt+1y9k2mEHhLM0eMXBQ8VIyaOiN9vajaNxTVMwI3M3EJxgLoLk
   7cbbyCF1Yl3LkphGac/j3oz/F0i18KQLuh8HFGBWyuaw7WFAoUvJWxaz2
   Ks+2lwe4366/dtkhaL4DaX6voq37ASnnZZbK67EpHUrWBos2mfJdXOruo
   oE3s5/DFNY5aNNmqVYVISamLuwVR/+NETfK0Vu69SSuYOULAKKAim5n+2
   87AN0uSgC8p9S8VzcU7+ox9/xweFEwIgnmdV8Z/5HHS5W3ANS716N/1kg
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,289,1739836800"; 
   d="scan'208";a="744704120"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 21:22:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:64843]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.244:2525] with esmtp (Farcaster)
 id 79eb88c1-6d3a-4a49-a564-dac13deb0242; Wed, 14 May 2025 21:22:22 +0000 (UTC)
X-Farcaster-Flow-ID: 79eb88c1-6d3a-4a49-a564-dac13deb0242
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 21:22:21 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 21:22:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <bpf@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<eric.dumazet@gmail.com>, <horms@kernel.org>, <jonesrick@google.com>,
	<kuba@kernel.org>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <weiwan@google.com>
Subject: Re: [PATCH net-next 11/11] tcp: increase tcp_rmem[2] to 32 MB
Date: Wed, 14 May 2025 14:20:05 -0700
Message-ID: <20250514212210.82672-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514205348.78733-1-kuniyu@amazon.com>
References: <20250514205348.78733-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Wed, 14 May 2025 13:53:39 -0700
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Wed, 14 May 2025 13:24:22 -0700
> > On Tue, 13 May 2025 19:39:19 +0000 Eric Dumazet wrote:
> > > Last change to tcp_rmem[2] happened in 2012, in commit b49960a05e32
> > > ("tcp: change tcp_adv_win_scale and tcp_rmem[2]")
> > > 
> > > TCP performance on WAN is mostly limited by tcp_rmem[2] for receivers.
> > > 
> > > After this series improvements, it is time to increase the default.
> > 
> > I think this breaks the BPF syncookie test, Kuniyuki any idea why?
> > 
> > https://github.com/kernel-patches/bpf/actions/runs/15016644781/job/42196471693
> 
> It seems ACK was not handled by BPF at tc hook on lo.
> 
> ACK was not sent or tcp_load_headers() failed to parse it ?
> both sounds unlikely though.
> 
> Will try to reproduce it.

I hard-coded the expected TCPOPT_WINDOW to be 7, and this
series bumps it to 10, so SYN was dropped as invalid.

This fixes the failure, and I think it's not a blocker.

---8<---
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
index eb5cca1fce16..7d5293de1952 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
@@ -294,7 +294,9 @@ static int tcp_validate_sysctl(struct tcp_syncookie *ctx)
 	    (ctx->ipv6 && ctx->attrs.mss != MSS_LOCAL_IPV6))
 		goto err;
 
-	if (!ctx->attrs.wscale_ok || ctx->attrs.snd_wscale != 7)
+	if (!ctx->attrs.wscale_ok ||
+	    !ctx->attrs.snd_wscale ||
+	    ctx->attrs.snd_wscale >= BPF_SYNCOOKIE_WSCALE_MASK)
 		goto err;
 
 	if (!ctx->attrs.tstamp_ok)
---8<---

