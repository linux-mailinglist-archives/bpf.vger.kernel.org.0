Return-Path: <bpf+bounces-37664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F6695922A
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 03:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7151F23845
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 01:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE492B9B7;
	Wed, 21 Aug 2024 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KWwx/al/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776E4687
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724203720; cv=none; b=YLgTpsEhEUm4Yzxj/7vjgHEF6D/aJxey53rm2UcRW1SXGhLtQOVQfqEVH1cwhbnoSCevbPn3Ia8M0dvN3yasLFocXuaLv3Ld5Kk8HmltljMWAVXmrNNQbfvPZQSEQq+b6Z8I59hzitoOxwwlnrK3RphCgT9uYP9OTZak49ZBkgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724203720; c=relaxed/simple;
	bh=gDPh1ZQ4xnVbelIFvyznoxRcDuI/75d54TwFF6mSNXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGPibLWAC2fEbD1GKimcB1gNVLq5ZK/C16mwGg+/Py14WzQlmJ9Qmslxk23AxrUyn0DZdo5LZLTYC8D5TBrhe5QU9WGADZCxbWz6GROHYFTHvFhk2YvzauTWjAbFd+a2Z3R/HD2WS9TKVGOzBLPt2P8kU7KGOhgYY98hz/nlXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KWwx/al/; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724203718; x=1755739718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O6ka5CMdox9io/7+wPQdbXmN3xF13MnmBwiWtRe13Pk=;
  b=KWwx/al/4i4sDC8l1yd28QYphIf4e2GuXTWcwIp53W0TIb5p9ne0bNMu
   wKMxwTdw+lD/8QAtcIEgsaHEMqnBg/hUbG0ATX5inqHiz3Qs7OWHf3jwl
   mgAGXsYJXv2lmgpUQ2JSCn2QnZPx8gQCQwaTMhevPInaLH59kWFqLN7FW
   o=;
X-IronPort-AV: E=Sophos;i="6.10,163,1719878400"; 
   d="scan'208";a="117198576"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 01:28:35 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:24387]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.61:2525] with esmtp (Farcaster)
 id dbe83698-7bfb-4451-a2d1-6d15ca320a3f; Wed, 21 Aug 2024 01:28:35 +0000 (UTC)
X-Farcaster-Flow-ID: dbe83698-7bfb-4451-a2d1-6d15ca320a3f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 21 Aug 2024 01:28:35 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 21 Aug 2024 01:28:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<dan.carpenter@linaro.org>, <daniel@iogearbox.net>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <mykolal@fb.com>
Subject: Re: [PATCH v1 bpf-next] selftest: bpf: Correct mssind comparison in test_tcp_custom_syncookie.c.
Date: Tue, 20 Aug 2024 18:28:22 -0700
Message-ID: <20240821012822.48799-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <823a9e15-ec42-4c6c-a0e9-56ec63b8936b@linux.dev>
References: <823a9e15-ec42-4c6c-a0e9-56ec63b8936b@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Tue, 20 Aug 2024 17:11:48 -0700
> On 8/19/24 12:42 PM, Kuniyuki Iwashima wrote:
> > Smatch reported a possible off-by-one in tcp_validate_cookie().
> > 
> > However, it's false positive because the possible range of mssind is
> > limited from 0 to 3 by the preceding calculation.
> > 
> >    mssind = (cookie & (3 << 6)) >> 6;
> > 
> > There's no real issue, but let's make Smatch happy to suppress the same
> > reports.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/bpf/6ae12487-d3f1-488b-9514-af0dac96608f@stanley.mountain/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >   tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> > index 44ee0d037f95..36b842133033 100644
> > --- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> > @@ -487,12 +487,12 @@ static int tcp_validate_cookie(struct tcp_syncookie *ctx)
> >   
> >   	mssind = (cookie & (3 << 6)) >> 6;
> 
> This should have bound the mssind.
> 
> >   	if (ctx->ipv4) {
> > -		if (mssind > ARRAY_SIZE(msstab4))
> > +		if (mssind >= ARRAY_SIZE(msstab4))
> 
> Does the verifier complain without this if check?

It didn't :)

I'll remove the checks in v2.

Thanks!

