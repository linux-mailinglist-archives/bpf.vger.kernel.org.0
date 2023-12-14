Return-Path: <bpf+bounces-17775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E668125D7
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 04:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2924C282B0B
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 03:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E0517F0;
	Thu, 14 Dec 2023 03:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PWAbJhjI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D461F2;
	Wed, 13 Dec 2023 19:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702523918; x=1734059918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q3GxQVQ83igwdUeoDEPp3rCJLWJePuCTOinx/ponSu8=;
  b=PWAbJhjIk8oczO4xJQun8tFJzZgE9fniBwIQVOkhlF5T8ZUYzZVaeLPH
   feHkVrhWVAdsYtlQZqrBRkIjt63uTogGBp4PHFpVVyqtXWvZ8IBXKkv2y
   Vqgsy1zR0fk4NVNZouBdVhPMmGxQCuQwp8m6ZlLrIhRIeVFvzDzSa48Rs
   A=;
X-IronPort-AV: E=Sophos;i="6.04,274,1695686400"; 
   d="scan'208";a="376024089"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-14781fa4.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:18:35 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2b-m6i4x-14781fa4.us-west-2.amazon.com (Postfix) with ESMTPS id DF66616006D;
	Thu, 14 Dec 2023 03:18:33 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:41821]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 7ae6c683-c30b-440b-8a86-8aebb63243fe; Thu, 14 Dec 2023 03:18:33 +0000 (UTC)
X-Farcaster-Flow-ID: 7ae6c683-c30b-440b-8a86-8aebb63243fe
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 03:18:32 +0000
Received: from 88665a182662.ant.amazon.com (10.119.13.146) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Thu, 14 Dec 2023 03:18:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <dxu@dxuuu.xyz>, <edumazet@google.com>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v5 bpf-next 6/6] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
Date: Thu, 14 Dec 2023 12:18:19 +0900
Message-ID: <20231214031819.83105-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <8fccb066-6d17-4fa8-ba67-287042046ea4@linux.dev>
References: <8fccb066-6d17-4fa8-ba67-287042046ea4@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Wed, 13 Dec 2023 12:44:42 -0800
> On 12/10/23 11:36 PM, Kuniyuki Iwashima wrote:
> > This commit adds a sample selftest to demonstrate how we can use
> > bpf_sk_assign_tcp_reqsk() as the backend of SYN Proxy.
> > 
> > The test creates IPv4/IPv6 x TCP/MPTCP connections and transfer
> > messages over them on lo with BPF tc prog attached.
> > 
> > The tc prog will process SYN and returns SYN+ACK with the following
> > ISN and TS.  In a real use case, this part will be done by other
> > hosts.
> > 
> >          MSB                                   LSB
> >    ISN:  | 31 ... 8 | 7 6 |   5 |    4 | 3 2 1 0 |
> >          |   Hash_1 | MSS | ECN | SACK |  WScale |
> > 
> >    TS:   | 31 ... 8 |          7 ... 0           |
> >          |   Random |           Hash_2           |
> > 
> >    WScale in SYN is reused in SYN+ACK.
> > 
> > The client returns ACK, and tc prog will recalculate ISN and TS
> > from ACK and validate SYN Cookie.
> > 
> > If it's valid, the prog calls kfunc to allocate a reqsk for skb and
> > configure the reqsk based on the argument created from SYN Cookie.
> > 
> > Later, the reqsk will be processed in cookie_v[46]_check() to create
> > a connection.
> 
> The patch set looks good.
> 
> One thing I just noticed is about writing/reading bits into/from "struct 
> tcp_options_received". More on this below.
> 
> [ ... ]
> 
> > +void test_tcp_custom_syncookie(void)
> > +{
> > +	struct test_tcp_custom_syncookie *skel;
> > +	int i;
> > +
> > +	if (setup_netns())
> > +		return;
> > +
> > +	skel = test_tcp_custom_syncookie__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> > +		return;
> > +
> > +	if (setup_tc(skel))
> > +		goto destroy_skel;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
> > +		skel->bss->handled_syn = false;
> > +		skel->bss->handled_ack = false;
> > +
> > +		test__start_subtest(test_cases[i].name);
> 
> 
> This should be tested with:
> 
> 	if (!test__start_subtest(test_cases[i].name))
> 		continue;
> 
> to skip the create_connection(). Probably do it at the beginning of the for loop.

Thanks for catching this!
Will fix.


> 
> > +		create_connection(&test_cases[i]);
> > +
> > +		ASSERT_EQ(skel->bss->handled_syn, true, "SYN is not handled at tc.");
> > +		ASSERT_EQ(skel->bss->handled_ack, true, "ACK is not handled at tc");
> > +	}
> > +
> > +destroy_skel:
> > +	system("tc qdisc del dev lo clsact");
> > +
> > +	test_tcp_custom_syncookie__destroy(skel);
> > +}
> 
> [ ... ]
> 
> > +static int tcp_parse_option(__u32 index, struct tcp_syncookie *ctx)
> > +{
> > +	struct tcp_options_received *tcp_opt = &ctx->attr.tcp_opt;
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
> > +			tcp_opt->mss_clamp = get_unaligned_be16(ctx->ptr);
> > +		break;
> > +	case TCPOPT_WINDOW:
> > +		if (opsize == TCPOLEN_WINDOW && ctx->tcp->syn &&
> > +		    ctx->ptr + (TCPOLEN_WINDOW - 2) < ctx->data_end) {
> > +			tcp_opt->wscale_ok = 1;
> > +			tcp_opt->snd_wscale = *ctx->ptr;
> 
> When writing to a bitfield of "struct tcp_options_received" which is a kernel 
> struct, it needs to use the CO-RE api. The BPF_CORE_WRITE_BITFIELD has not been 
> landed yet: 
> https://lore.kernel.org/bpf/4d3dd215a4fd57d980733886f9c11a45e1a9adf3.1702325874.git.dxu@dxuuu.xyz/
> 
> The same for reading bitfield but BPF_CORE_READ_BITFIELD() has already been 
> implemented in bpf_core_read.h
> 
> Once the BPF_CORE_WRITE_BITFIELD is landed, this test needs to be changed to use 
> the BPF_CORE_{READ,WRITE}_BITFIELD.

IIUC, the CO-RE api assumes that the offset of bitfields could be changed.

If the size of struct tcp_cookie_attributes is changed, kfunc will not work
in this test.  So, BPF_CORE_WRITE_BITFIELD() works only when the size of
tcp_cookie_attributes is unchanged but fields in tcp_options_received are
rearranged or expanded to use the unused@ bits ?

Also, do we need to use BPF_CORE_READ() for other non-bitfields in
strcut tcp_options_received (and ecn_ok in struct tcp_cookie_attributes
just in case other fields are added to tcp_cookie_attributes and ecn_ok
is rearranged) ?

Just trying to understand when to use CO-RE api.

Btw, thanks for merging BPF_CORE_WRITE_BITFIELD patches!


> 
> > +		}
> > +		break;
> > +	case TCPOPT_TIMESTAMP:
> > +		if (opsize == TCPOLEN_TIMESTAMP &&
> > +		    ctx->ptr + (TCPOLEN_TIMESTAMP - 2) < ctx->data_end) {
> > +			tcp_opt->saw_tstamp = 1;
> > +			tcp_opt->rcv_tsval = get_unaligned_be32(ctx->ptr);
> > +			tcp_opt->rcv_tsecr = get_unaligned_be32(ctx->ptr + 4);
> > +
> > +			if (ctx->tcp->syn && tcp_opt->rcv_tsecr)
> > +				tcp_opt->tstamp_ok = 0;
> > +			else
> > +				tcp_opt->tstamp_ok = 1;
> > +		}
> > +		break;
> > +	case TCPOPT_SACK_PERM:
> > +		if (opsize == TCPOLEN_SACK_PERM && ctx->tcp->syn &&
> > +		    ctx->ptr + (TCPOLEN_SACK_PERM - 2) < ctx->data_end)
> > +			tcp_opt->sack_ok = 1;
> > +		break;
> > +	}
> > +
> > +	ctx->ptr += opsize - 2;
> > +next:
> > +	return 0;
> > +stop:
> > +	return 1;
> > +}

