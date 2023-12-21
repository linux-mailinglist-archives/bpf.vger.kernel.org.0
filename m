Return-Path: <bpf+bounces-18510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD6381B081
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 09:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329C92867EE
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A4617743;
	Thu, 21 Dec 2023 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tFNmCAe4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E38D171A4;
	Thu, 21 Dec 2023 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703148231; x=1734684231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Z0GX+7uv/sLnLPaDYt0IYinAk1hhGwTjf3POoo3T8k=;
  b=tFNmCAe4iv+u82hnB004VmCENiHEkxYuUu/i+h0BApBf+F4BlwDkl9v7
   2li6PdzdC5srCPcFi2A5fgdO/sBxybLtDNU/+jHeGR6ySUsi7McElZsFN
   l0DoLUAwkUJ+vGk29eNDEmvHkzE808pVdcmzaUe+G17Zgb+xeeL+8GVdR
   0=;
X-IronPort-AV: E=Sophos;i="6.04,293,1695686400"; 
   d="scan'208";a="692362979"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:43:26 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com (Postfix) with ESMTPS id 1694C807C9;
	Thu, 21 Dec 2023 08:43:23 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:52540]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.220:2525] with esmtp (Farcaster)
 id 814705f6-82be-4f1f-98f2-f02d986b747a; Thu, 21 Dec 2023 08:43:22 +0000 (UTC)
X-Farcaster-Flow-ID: 814705f6-82be-4f1f-98f2-f02d986b747a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 08:43:21 +0000
Received: from 88665a182662.ant.amazon.com.com (10.143.88.82) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 08:43:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <edumazet@google.com>, <kuni1840@gmail.com>,
	<martin.lau@linux.dev>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH v7 bpf-next 6/6] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
Date: Thu, 21 Dec 2023 17:43:07 +0900
Message-ID: <20231221084307.77438-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231221070443.68167-1-kuniyu@amazon.com>
References: <20231221070443.68167-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Thu, 21 Dec 2023 16:04:43 +0900
> From: Martin KaFai Lau <martin.lau@linux.dev>
> Date: Wed, 20 Dec 2023 22:35:26 -0800
> > On 12/20/23 5:28 PM, Kuniyuki Iwashima wrote:
> > > +static int tcp_validate_header(struct tcp_syncookie *ctx)
> > > +{
> > > +	s64 csum;
> > > +
> > > +	if (tcp_reload_headers(ctx))
> > > +		goto err;
> > > +
> > > +	csum = bpf_csum_diff(0, 0, (void *)ctx->tcp, ctx->tcp->doff * 4, 0);
> > > +	if (csum < 0)
> > > +		goto err;
> > > +
> > > +	if (ctx->ipv4) {
> > > +		/* check tcp_v4_csum(csum) is 0 if not on lo. */
> > > +
> > > +		csum = bpf_csum_diff(0, 0, (void *)ctx->ipv4, ctx->ipv4->ihl * 4, 0);
> > > +		if (csum < 0)
> > > +			goto err;
> > > +
> > > +		if (csum_fold(csum) != 0)
> > > +			goto err;
> > > +	} else if (ctx->ipv6) {
> > > +		/* check tcp_v6_csum(csum) is 0 if not on lo. */
> > > +	}
> > > +
> > > +	return 0;
> > > +err:
> > > +	return -1;
> > > +}
> > > +
> > > +static int tcp_parse_option(__u32 index, struct tcp_syncookie *ctx)
> > > +{
> > > +	char opcode, opsize;
> > > +
> > > +	if (ctx->ptr + 1 > ctx->data_end)
> > > +		goto stop;
> > > +
> > > +	opcode = *ctx->ptr++;
> > > +
> > > +	if (opcode == TCPOPT_EOL)
> > > +		goto stop;
> > > +
> > > +	if (opcode == TCPOPT_NOP)
> > > +		goto next;
> > > +
> > > +	if (ctx->ptr + 1 > ctx->data_end)
> > > +		goto stop;
> > > +
> > > +	opsize = *ctx->ptr++;
> > > +
> > > +	if (opsize < 2)
> > > +		goto stop;
> > > +
> > > +	switch (opcode) {
> > > +	case TCPOPT_MSS:
> > > +		if (opsize == TCPOLEN_MSS && ctx->tcp->syn &&
> > > +		    ctx->ptr + (TCPOLEN_MSS - 2) < ctx->data_end)
> > > +			ctx->attrs.mss = get_unaligned_be16(ctx->ptr);
> > > +		break;
> > > +	case TCPOPT_WINDOW:
> > > +		if (opsize == TCPOLEN_WINDOW && ctx->tcp->syn &&
> > > +		    ctx->ptr + (TCPOLEN_WINDOW - 2) < ctx->data_end) {
> > > +			ctx->attrs.wscale_ok = 1;
> > > +			ctx->attrs.snd_wscale = *ctx->ptr;
> > > +		}
> > > +		break;
> > > +	case TCPOPT_TIMESTAMP:
> > > +		if (opsize == TCPOLEN_TIMESTAMP &&
> > > +		    ctx->ptr + (TCPOLEN_TIMESTAMP - 2) < ctx->data_end) {
> > > +			ctx->attrs.rcv_tsval = get_unaligned_be32(ctx->ptr);
> > > +			ctx->attrs.rcv_tsecr = get_unaligned_be32(ctx->ptr + 4);
> > > +
> > > +			if (ctx->tcp->syn && ctx->attrs.rcv_tsecr)
> > > +				ctx->attrs.tstamp_ok = 0;
> > > +			else
> > > +				ctx->attrs.tstamp_ok = 1;
> > > +		}
> > > +		break;
> > > +	case TCPOPT_SACK_PERM:
> > > +		if (opsize == TCPOLEN_SACK_PERM && ctx->tcp->syn &&
> > > +		    ctx->ptr + (TCPOLEN_SACK_PERM - 2) < ctx->data_end)
> > > +			ctx->attrs.sack_ok = 1;
> > > +		break;
> > > +	}
> > > +
> > > +	ctx->ptr += opsize - 2;
> > > +next:
> > > +	return 0;
> > > +stop:
> > > +	return 1;
> > > +}
> > > +
> > > +static void tcp_parse_options(struct tcp_syncookie *ctx)
> > > +{
> > > +	ctx->ptr = (char *)(ctx->tcp + 1);
> > > +
> > > +	bpf_loop(40, tcp_parse_option, ctx, 0);
> > > +}
> > > +
> > > +static int tcp_validate_sysctl(struct tcp_syncookie *ctx)
> > > +{
> > > +	if ((ctx->ipv4 && ctx->attrs.mss != MSS_LOCAL_IPV4) ||
> > > +	    (ctx->ipv6 && ctx->attrs.mss != MSS_LOCAL_IPV6))
> > > +		goto err;
> > > +
> > > +	if (!ctx->attrs.wscale_ok || ctx->attrs.snd_wscale != 7)
> > > +		goto err;
> > > +
> > > +	if (!ctx->attrs.tstamp_ok)
> > 
> > The bpf-ci reported error in cpuv4. The email from bot+bpf-ci@kernel.org has the 
> > link.
> 
> I like the mail from the bot, it's useful, but it seems that
> it's sent to the patch author only when the CI passes ?
> 
> But yeah, I found the failed test.
> https://github.com/kernel-patches/bpf/actions/runs/7284164398/job/19849657597
> 
> 
> > 
> > I tried the following:
> > 
> > 	if (!ctx->attrs.tstamp_ok) {
> > 		bpf_printk("ctx->attrs.tstamp_ok %u",
> > 			ctx->attrs.tstamp_ok);
> > 		goto err;
> > 	}
> > 
> > 
> > The above prints tstamp_ok as 1 while there is a "if (!ctx->attrs.tstamp_ok)" 
> > test before it.
> > 
> > Yonghong and I debugged it quite a bit. verifier concluded the 
> > ctx->attrs.tstamp_ok is 0. We knew some red herring like cpuv4 has fewer 
> > register spilling but not able to root cause it yet.
> > 
> > In the mean time, there are existing selftests parsing the tcp header. For 
> > example, the test_parse_tcp_hdr_opt[_dynptr].c. Not as complete as your 
> > tcp_parse_option() but should be pretty close. It does not use bpf_loop. It uses 
> > a bounded loop + a subprog (the parse_hdr_opt in the selftests) instead. You can 
> > consider a similar construct to see if it works around the cpuv4 CI issue for 
> > the time being.
> 
> Sure, I'll install the latest clang/llvm and check if the test
> passes without bpf_loop().

I've tested a simple diff below and some more different patterns, but
the prog cannot be loaded.  Without bpf_loop(), the parser can loop
only 4 times (s/40/4/), but then, it does not fully parse the necessary
options, so the packet is dropped due to tcp_validate_sysctl(), and the
test fails.

So it seems that tcp_parse_option() cannot work around the issue even
without bpf_loop() and this series needs to wait the cpuv4 fix..

---8<---
@@ -259,9 +260,13 @@ static int tcp_parse_option(__u32 index, struct tcp_syncookie *ctx)
 
 static void tcp_parse_options(struct tcp_syncookie *ctx)
 {
+	int i;
+
 	ctx->ptr = (char *)(ctx->tcp + 1);
 
-	bpf_loop(40, tcp_parse_option, ctx, 0);
+	for (i = 0; i < 40; i++)
+		if (tcp_parse_option(i, ctx))
+			break;
 }
 
 static int tcp_validate_sysctl(struct tcp_syncookie *ctx)
---8<---

---8<---
BPF program is too large. Processed 1000001 insn
processed 1000001 insns (limit 1000000) max_states_per_insn 30 total_states 41159 peak_states 344 mark_read 55
-- END PROG LOAD LOG --
libbpf: prog 'tcp_custom_syncookie': failed to load: -7
---8<---

