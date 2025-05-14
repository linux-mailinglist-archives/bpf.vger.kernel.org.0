Return-Path: <bpf+bounces-58249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F45FAB77F3
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 23:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5043A8C33
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 21:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA4296D08;
	Wed, 14 May 2025 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XkD+T8bI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C195918D620;
	Wed, 14 May 2025 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747258128; cv=none; b=TiEu9QDYmSwQFBdULuxkeWYDkRD63hLbSUruK4z2rrsM7lxBOEhbivU4nNE7HfuSZIYEgTM44eVCI+3z1TD4jUupm9zDSfrWDXUNe1wBC0RqYQa7hNCq9kqbklGwVdBlmUB0ztTZGTPErjoQwfPkKh2IO3Ut9bnA3MB8+4UH+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747258128; c=relaxed/simple;
	bh=+NpMOsl8gFhUwEUcUYo+Rcdd8+bmkT4m7GX/t3DzCmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQAOnrM17UUS/KlkBLwj4V8cSSjMF2+dZcL6JzG/WlA7t6AVaty1VMdR9c303FbkaHdsiE37jQCukSDit7Pkiio2+B32K3jhZGKWAPMFoetlE/n+tswZ5w9NhlVFv+a2MtFbRPgmJY3SHEAOJrUFUdad21Gqvh4Vt2lhCQXHSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XkD+T8bI; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747258127; x=1778794127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mRP1UNN8Wbk0PYaoLjISTVBGe+fH8Q6pNkdFOAZiakY=;
  b=XkD+T8bIN03fFvx8xxw2zcabQR4kyZGdYP+OrStPNtKsxaq7poKs81UT
   mKfemmxUqb1O4YSZ5HwEDeTy6R1HejC7Bs8Whgh/QoWOjv5hVi2rMweeh
   GmIn2UffjixoX7hOOXnw56RA9jn3kMTg8IQPQ5QM8JKf2xg7QLNm8LZnv
   n1TAboEZh50Wdx+9gUH0Psy0mrBdoVj5HVcdGFUv6EG3xyGMt0wFO8Hjz
   YlwuMkdR4GAOq7kLkncZbg/16UHqzskUZs18i7fbgT+x8wE5kRYZ+HF8k
   UR9uRZXBfeMpb/a7trGJFmmPfmZy5ZETh78x4L+K+iX2+tfBA4ucuOgji
   g==;
X-IronPort-AV: E=Sophos;i="6.15,289,1739836800"; 
   d="scan'208";a="405332557"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 21:28:44 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:23104]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.33:2525] with esmtp (Farcaster)
 id a3eb42f3-3d49-49e2-9449-bc75935f078a; Wed, 14 May 2025 21:28:43 +0000 (UTC)
X-Farcaster-Flow-ID: a3eb42f3-3d49-49e2-9449-bc75935f078a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 21:28:42 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 21:28:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<eric.dumazet@gmail.com>, <horms@kernel.org>, <jonesrick@google.com>,
	<kuniyu@amazon.com>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <weiwan@google.com>
Subject: Re: [PATCH net-next 11/11] tcp: increase tcp_rmem[2] to 32 MB
Date: Wed, 14 May 2025 14:28:27 -0700
Message-ID: <20250514212832.83713-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514142620.63937885@kernel.org>
References: <20250514142620.63937885@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 14 May 2025 14:26:20 -0700
> On Wed, 14 May 2025 14:20:05 -0700 Kuniyuki Iwashima wrote:
> > > It seems ACK was not handled by BPF at tc hook on lo.
> > > 
> > > ACK was not sent or tcp_load_headers() failed to parse it ?
> > > both sounds unlikely though.
> > > 
> > > Will try to reproduce it.  
> > 
> > I hard-coded the expected TCPOPT_WINDOW to be 7, and this
> > series bumps it to 10, so SYN was dropped as invalid.
> > 
> > This fixes the failure, and I think it's not a blocker.
> > 
> > ---8<---
> > diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> > index eb5cca1fce16..7d5293de1952 100644
> > --- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> > @@ -294,7 +294,9 @@ static int tcp_validate_sysctl(struct tcp_syncookie *ctx)
> >  	    (ctx->ipv6 && ctx->attrs.mss != MSS_LOCAL_IPV6))
> >  		goto err;
> >  
> > -	if (!ctx->attrs.wscale_ok || ctx->attrs.snd_wscale != 7)
> > +	if (!ctx->attrs.wscale_ok ||
> > +	    !ctx->attrs.snd_wscale ||
> > +	    ctx->attrs.snd_wscale >= BPF_SYNCOOKIE_WSCALE_MASK)
> >  		goto err;
> >  
> >  	if (!ctx->attrs.tstamp_ok)
> 
> Awesome, could you submit officially? As soon as your fix is in
> patchwork I can return Eric's series into the testing branch.

For sure, will post a patch shortly.

