Return-Path: <bpf+bounces-18501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BF381AF0F
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 08:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C661F246F1
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 07:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EC0C139;
	Thu, 21 Dec 2023 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Xk0Tc1Jd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80102BA33;
	Thu, 21 Dec 2023 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703142304; x=1734678304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pSSf6YfEkI/G5MSolcsXuueZnr34EfrXqIHSzGNN4Dg=;
  b=Xk0Tc1JdZL3k+FpTu/bQFv3EK5UFdl9d2O8emhO4oiYg2Y1zSBp8iKHe
   Y6oKQTNAqF1oc/tkQiDhvQ57rceoXH06pxVFPa0dokOJoCdIzGWp+oitk
   1lEMHUkNZzGY1F5jY29joKZlPfB0yNtvTGzj2MvmARQSL9+Me4Y3QGjAt
   A=;
X-IronPort-AV: E=Sophos;i="6.04,293,1695686400"; 
   d="scan'208";a="377868137"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:05:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id 2E85C40E6D;
	Thu, 21 Dec 2023 07:04:59 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:18773]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.218:2525] with esmtp (Farcaster)
 id 475f4d02-2202-4e06-889b-24000d3373ac; Thu, 21 Dec 2023 07:04:58 +0000 (UTC)
X-Farcaster-Flow-ID: 475f4d02-2202-4e06-889b-24000d3373ac
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 07:04:58 +0000
Received: from 88665a182662.ant.amazon.com.com (10.143.88.82) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 07:04:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <edumazet@google.com>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH v7 bpf-next 6/6] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
Date: Thu, 21 Dec 2023 16:04:43 +0900
Message-ID: <20231221070443.68167-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <bd21939e-c6c8-4fb2-a4b6-e085a2230c8e@linux.dev>
References: <bd21939e-c6c8-4fb2-a4b6-e085a2230c8e@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Wed, 20 Dec 2023 22:35:26 -0800
> On 12/20/23 5:28 PM, Kuniyuki Iwashima wrote:
> > +static int tcp_validate_header(struct tcp_syncookie *ctx)
> > +{
> > +	s64 csum;
> > +
> > +	if (tcp_reload_headers(ctx))
> > +		goto err;
> > +
> > +	csum = bpf_csum_diff(0, 0, (void *)ctx->tcp, ctx->tcp->doff * 4, 0);
> > +	if (csum < 0)
> > +		goto err;
> > +
> > +	if (ctx->ipv4) {
> > +		/* check tcp_v4_csum(csum) is 0 if not on lo. */
> > +
> > +		csum = bpf_csum_diff(0, 0, (void *)ctx->ipv4, ctx->ipv4->ihl * 4, 0);
> > +		if (csum < 0)
> > +			goto err;
> > +
> > +		if (csum_fold(csum) != 0)
> > +			goto err;
> > +	} else if (ctx->ipv6) {
> > +		/* check tcp_v6_csum(csum) is 0 if not on lo. */
> > +	}
> > +
> > +	return 0;
> > +err:
> > +	return -1;
> > +}
> > +
> > +static int tcp_parse_option(__u32 index, struct tcp_syncookie *ctx)
> > +{
> > +	char opcode, opsize;
> > +
> > +	if (ctx->ptr + 1 > ctx->data_end)
> > +		goto stop;
> > +
> > +	opcode = *ctx->ptr++;
> > +
> > +	if (opcode == TCPOPT_EOL)
> > +		goto stop;
> > +
> > +	if (opcode == TCPOPT_NOP)
> > +		goto next;
> > +
> > +	if (ctx->ptr + 1 > ctx->data_end)
> > +		goto stop;
> > +
> > +	opsize = *ctx->ptr++;
> > +
> > +	if (opsize < 2)
> > +		goto stop;
> > +
> > +	switch (opcode) {
> > +	case TCPOPT_MSS:
> > +		if (opsize == TCPOLEN_MSS && ctx->tcp->syn &&
> > +		    ctx->ptr + (TCPOLEN_MSS - 2) < ctx->data_end)
> > +			ctx->attrs.mss = get_unaligned_be16(ctx->ptr);
> > +		break;
> > +	case TCPOPT_WINDOW:
> > +		if (opsize == TCPOLEN_WINDOW && ctx->tcp->syn &&
> > +		    ctx->ptr + (TCPOLEN_WINDOW - 2) < ctx->data_end) {
> > +			ctx->attrs.wscale_ok = 1;
> > +			ctx->attrs.snd_wscale = *ctx->ptr;
> > +		}
> > +		break;
> > +	case TCPOPT_TIMESTAMP:
> > +		if (opsize == TCPOLEN_TIMESTAMP &&
> > +		    ctx->ptr + (TCPOLEN_TIMESTAMP - 2) < ctx->data_end) {
> > +			ctx->attrs.rcv_tsval = get_unaligned_be32(ctx->ptr);
> > +			ctx->attrs.rcv_tsecr = get_unaligned_be32(ctx->ptr + 4);
> > +
> > +			if (ctx->tcp->syn && ctx->attrs.rcv_tsecr)
> > +				ctx->attrs.tstamp_ok = 0;
> > +			else
> > +				ctx->attrs.tstamp_ok = 1;
> > +		}
> > +		break;
> > +	case TCPOPT_SACK_PERM:
> > +		if (opsize == TCPOLEN_SACK_PERM && ctx->tcp->syn &&
> > +		    ctx->ptr + (TCPOLEN_SACK_PERM - 2) < ctx->data_end)
> > +			ctx->attrs.sack_ok = 1;
> > +		break;
> > +	}
> > +
> > +	ctx->ptr += opsize - 2;
> > +next:
> > +	return 0;
> > +stop:
> > +	return 1;
> > +}
> > +
> > +static void tcp_parse_options(struct tcp_syncookie *ctx)
> > +{
> > +	ctx->ptr = (char *)(ctx->tcp + 1);
> > +
> > +	bpf_loop(40, tcp_parse_option, ctx, 0);
> > +}
> > +
> > +static int tcp_validate_sysctl(struct tcp_syncookie *ctx)
> > +{
> > +	if ((ctx->ipv4 && ctx->attrs.mss != MSS_LOCAL_IPV4) ||
> > +	    (ctx->ipv6 && ctx->attrs.mss != MSS_LOCAL_IPV6))
> > +		goto err;
> > +
> > +	if (!ctx->attrs.wscale_ok || ctx->attrs.snd_wscale != 7)
> > +		goto err;
> > +
> > +	if (!ctx->attrs.tstamp_ok)
> 
> The bpf-ci reported error in cpuv4. The email from bot+bpf-ci@kernel.org has the 
> link.

I like the mail from the bot, it's useful, but it seems that
it's sent to the patch author only when the CI passes ?

But yeah, I found the failed test.
https://github.com/kernel-patches/bpf/actions/runs/7284164398/job/19849657597


> 
> I tried the following:
> 
> 	if (!ctx->attrs.tstamp_ok) {
> 		bpf_printk("ctx->attrs.tstamp_ok %u",
> 			ctx->attrs.tstamp_ok);
> 		goto err;
> 	}
> 
> 
> The above prints tstamp_ok as 1 while there is a "if (!ctx->attrs.tstamp_ok)" 
> test before it.
> 
> Yonghong and I debugged it quite a bit. verifier concluded the 
> ctx->attrs.tstamp_ok is 0. We knew some red herring like cpuv4 has fewer 
> register spilling but not able to root cause it yet.
> 
> In the mean time, there are existing selftests parsing the tcp header. For 
> example, the test_parse_tcp_hdr_opt[_dynptr].c. Not as complete as your 
> tcp_parse_option() but should be pretty close. It does not use bpf_loop. It uses 
> a bounded loop + a subprog (the parse_hdr_opt in the selftests) instead. You can 
> consider a similar construct to see if it works around the cpuv4 CI issue for 
> the time being.

Sure, I'll install the latest clang/llvm and check if the test
passes without bpf_loop().

Thanks!


