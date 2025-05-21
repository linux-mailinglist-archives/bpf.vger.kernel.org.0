Return-Path: <bpf+bounces-58699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38ACAC008A
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 01:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561B3172FB0
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC123BCFF;
	Wed, 21 May 2025 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="haLd94tY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A41239E65;
	Wed, 21 May 2025 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747869493; cv=none; b=i9qsldoqKYqaJFvckYKDTCY5R/wRSwKNoHFYW7Yvt1lPH9pUCBp66tyEQOlsE7hN3fTJFWk4vWxAvNMSq0msdX4S1MoX7+7rpamQ8fjLQ/xVHON+Ai88X7rm08Ro4FO4EnNF+YKaEBGMQM05hYJdaCO1G69HGlNHkcMBhlCZ7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747869493; c=relaxed/simple;
	bh=tc4Rc5WhaCG5eca6GJG/PxJnkROGcjQIe9XRR3o7jms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBInpIP13o4aRra++UhruWMjpIeULCM+NvXhLZ/VQoDpOfB558VZUKG126NeIedR1HoileAajSefGwlSvQ0g80NcsRjmifN4tHU+SjotByxBnyBcCbw78pgMjsCcUIqK+8K41aMK/WV1j+grfFEA7Bbxe+cBK5qhlLXo5mRdZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=haLd94tY; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747869492; x=1779405492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dAISRQHymGpSlZcgfow8gzL7H3J4aU50MP1wdq1m96U=;
  b=haLd94tY0HaBAklco8bYS+J18b39ymbMLw8D51JqGFKL2evc++XLMxY8
   kWYwcYFzLGSdACh8jJo8qGNhvhuJwy7+hkHB6ugKnBY49tVVXanKZWi50
   V8RaGeWtJ3Pn1ECdyIVEU8Ff6Y+6PiCy3OxvazHb3fAQhdghiweSuvZRB
   Y81Vdf0HmgDVlDtLGtgu+HOYZZkJP+nD2Cgt47QE8OH4ALascrVrIOy/A
   0bhLA8Eol5UyQCQBgMOWzy2hS77MozL4J19jY6agsaHI7p7E5QSHAXAA0
   8auELbQ8fBERckFPnrKAzVsDPIyK3HGzQ6VaM4ud1akUwulY2vdPb2fu+
   g==;
X-IronPort-AV: E=Sophos;i="6.15,304,1739836800"; 
   d="scan'208";a="827214693"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 23:18:06 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:39713]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.117:2525] with esmtp (Farcaster)
 id f8e2304d-e65c-44ce-99fe-0d478a97d9b6; Wed, 21 May 2025 23:18:05 +0000 (UTC)
X-Farcaster-Flow-ID: f8e2304d-e65c-44ce-99fe-0d478a97d9b6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 23:18:05 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.52.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 23:18:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <alexei.starovoitov@gmail.com>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <jordan@jrife.io>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 03/10] bpf: tcp: Get rid of st_bucket_done
Date: Wed, 21 May 2025 16:17:48 -0700
Message-ID: <20250521231755.91774-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521225800.89218-1-kuniyu@amazon.com>
References: <20250521225800.89218-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Wed, 21 May 2025 15:57:59 -0700
> From: Jordan Rife <jordan@jrife.io>
> Date: Tue, 20 May 2025 07:50:50 -0700
> > Get rid of the st_bucket_done field to simplify TCP iterator state and
> > logic. Before, st_bucket_done could be false if bpf_iter_tcp_batch
> > returned a partial batch; however, with the last patch ("bpf: tcp: Make
> > sure iter->batch always contains a full bucket snapshot"),
> > st_bucket_done == true is equivalent to iter->cur_sk == iter->end_sk.
> > 
> > Signed-off-by: Jordan Rife <jordan@jrife.io>
> > ---
> >  net/ipv4/tcp_ipv4.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 27022018194a..20730723a02c 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -3020,7 +3020,6 @@ struct bpf_tcp_iter_state {
> >  	unsigned int end_sk;
> >  	unsigned int max_sk;
> >  	struct sock **batch;
> > -	bool st_bucket_done;
> >  };
> >  
> >  struct bpf_iter__tcp {
> > @@ -3043,8 +3042,10 @@ static int tcp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
> >  
> >  static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
> >  {
> > -	while (iter->cur_sk < iter->end_sk)
> > -		sock_gen_put(iter->batch[iter->cur_sk++]);
> > +	unsigned int cur_sk = iter->cur_sk;
> > +
> > +	while (cur_sk < iter->end_sk)
> > +		sock_gen_put(iter->batch[cur_sk++]);
> 
> Why is this chunk included in this patch ?

This should be in patch 5 to keep cur_sk for find_cookie

