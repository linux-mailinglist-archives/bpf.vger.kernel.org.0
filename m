Return-Path: <bpf+bounces-17802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8648129BE
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 08:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEF528218F
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 07:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381FC14A9C;
	Thu, 14 Dec 2023 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="U6GGRGsM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8310EA7;
	Wed, 13 Dec 2023 23:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702540215; x=1734076215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QnjOi8Ua0IYqOlrIRZ8rzIAdtwGZv4c9tt7NJaUKfu4=;
  b=U6GGRGsMB96vQGeXWEAAzZqTJzoo/zrWwUw6zlG1YSoDxWnNQtdD1xS0
   /stBWNChc4KSx+pl9gOOi+ogCk5RIQ+OJjZxeY6f1j2qYf9D9UGuDSFrE
   RWCTNHyQguaZsuTXhvOLGsnOmvOdXjGT1QFQMWIg3OZ/MBpR1FYqGSta/
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,274,1695686400"; 
   d="scan'208";a="259645934"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 07:50:12 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id A9E99805A3;
	Thu, 14 Dec 2023 07:50:09 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:43142]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.95:2525] with esmtp (Farcaster)
 id 52d88965-49d3-48a2-a891-7ae61d45b2bc; Thu, 14 Dec 2023 07:50:08 +0000 (UTC)
X-Farcaster-Flow-ID: 52d88965-49d3-48a2-a891-7ae61d45b2bc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 07:50:08 +0000
Received: from 88665a182662.ant.amazon.com (10.143.92.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 07:50:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <dxu@dxuuu.xyz>, <edumazet@google.com>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH v5 bpf-next 6/6] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
Date: Thu, 14 Dec 2023 16:49:55 +0900
Message-ID: <20231214074955.10720-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <3186bf18-a8fd-4b30-a080-61beb13f19f7@linux.dev>
References: <3186bf18-a8fd-4b30-a080-61beb13f19f7@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Wed, 13 Dec 2023 22:46:11 -0800
> On 12/13/23 7:18 PM, Kuniyuki Iwashima wrote:
> >>> +static int tcp_parse_option(__u32 index, struct tcp_syncookie *ctx)
> >>> +{
> >>> +	struct tcp_options_received *tcp_opt = &ctx->attr.tcp_opt;
> >>> +	char opcode, opsize;
> >>> +
> >>> +	if (ctx->ptr + 1 > ctx->data_end)
> >>> +		goto stop;
> >>> +
> >>> +	opcode = *ctx->ptr++;
> >>> +
> >>> +	if (opcode == TCPOPT_EOL)
> >>> +		goto stop;
> >>> +
> >>> +	if (opcode == TCPOPT_NOP)
> >>> +		goto next;
> >>> +
> >>> +	if (ctx->ptr + 1 > ctx->data_end)
> >>> +		goto stop;
> >>> +
> >>> +	opsize = *ctx->ptr++;
> >>> +
> >>> +	if (opsize < 2)
> >>> +		goto stop;
> >>> +
> >>> +	switch (opcode) {
> >>> +	case TCPOPT_MSS:
> >>> +		if (opsize == TCPOLEN_MSS && ctx->tcp->syn &&
> >>> +		    ctx->ptr + (TCPOLEN_MSS - 2) < ctx->data_end)
> >>> +			tcp_opt->mss_clamp = get_unaligned_be16(ctx->ptr);
> >>> +		break;
> >>> +	case TCPOPT_WINDOW:
> >>> +		if (opsize == TCPOLEN_WINDOW && ctx->tcp->syn &&
> >>> +		    ctx->ptr + (TCPOLEN_WINDOW - 2) < ctx->data_end) {
> >>> +			tcp_opt->wscale_ok = 1;
> >>> +			tcp_opt->snd_wscale = *ctx->ptr;
> >> When writing to a bitfield of "struct tcp_options_received" which is a kernel
> >> struct, it needs to use the CO-RE api. The BPF_CORE_WRITE_BITFIELD has not been
> >> landed yet:
> >> https://lore.kernel.org/bpf/4d3dd215a4fd57d980733886f9c11a45e1a9adf3.1702325874.git.dxu@dxuuu.xyz/
> >>
> >> The same for reading bitfield but BPF_CORE_READ_BITFIELD() has already been
> >> implemented in bpf_core_read.h
> >>
> >> Once the BPF_CORE_WRITE_BITFIELD is landed, this test needs to be changed to use
> >> the BPF_CORE_{READ,WRITE}_BITFIELD.
> > IIUC, the CO-RE api assumes that the offset of bitfields could be changed.
> > 
> > If the size of struct tcp_cookie_attributes is changed, kfunc will not work
> > in this test.  So, BPF_CORE_WRITE_BITFIELD() works only when the size of
> > tcp_cookie_attributes is unchanged but fields in tcp_options_received are
> > rearranged or expanded to use the unused@ bits ?
> 
> Right, CO-RE helps to figure out the offset of a member in the running kernel.
> 
> > 
> > Also, do we need to use BPF_CORE_READ() for other non-bitfields in
> > strcut tcp_options_received (and ecn_ok in struct tcp_cookie_attributes
> > just in case other fields are added to tcp_cookie_attributes and ecn_ok
> > is rearranged) ?
> 
> BPF_CORE_READ is a CO-RE friendly macro for using bpf_probe_read_kernel(). 
> bpf_probe_read_kernel() is mostly for the tracing use case where the ptr is not 
> safe to read directly.
> 
> It is not the case for the tcp_options_received ptr in this tc-bpf use case or 
> other stack allocated objects. In general, no need to use BPF_CORE_READ. The 
> relocation will be done by the libbpf for tcp_opt->mss_clamp (e.g.).
> 
> Going back to bitfield, it needs BPF_CORE_*_BITFIELD because the offset may not 
> be right after __attribute__((preserve_access_index)), cc: Yonghong and Andrii 
> who know more details than I do.
> 
> A verifier error has been reported: 
> https://lore.kernel.org/bpf/391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz/.
> 
> I also hit an error earlier in 
> https://lore.kernel.org/all/20220817061847.4182339-1-kafai@fb.com/ when not 
> using BPF_CORE_READ_BITFIELD. I don't exactly remember how the instruction looks 
> like but it was reading a wrong value instead of verifier error.

Thank you so much for detailed explanation!


> 
> ================
> 
> Going back to this patch set here.
> 
> After sleeping on it longer, I am thinking it is better not to reuse 'struct 
> tcp_options_received' (meaning no bitfield) in the bpf_sk_assign_tcp_reqsk() 
> kfunc API.
> 
> There is not much benefit in reusing 'tcp_options_received'. When new tcp option 
> was ever added to tcp_options_received, it is not like bpf_sk_assign_tcp_reqsk 
> will support it automatically. It needs to relay this new option back to the 
> allocated req. Unlike tcp_sock or req which may have a lot of them such that it 
> is useful to have a compact tcp_options_received, the tc-bpf use case here is to 
> allocate it once in the stack. Also, not all the members in tcp_options_received 
> is useful, e.g. num_sacks, ts_recent_stamp, and user_mss are not used. Leaving 
> it there being ignored by bpf_sk_assign_tcp_reqsk is confusing.
> 
> How about using a full u8 for each necessary member and directly add them to 
> struct tcp_cookie_attributes instead of nesting them into another struct. After 
> taking out the unnecessary members, the size may not end up to be much bigger.
> 
> The bpf prog can then directly access attr->tstamp_ok more naturally. The 
> changes to patch 5 and 6 should be mostly mechanical changes.
> 
> I would also rename s/tcp_cookie_attributes/bpf_tcp_req_attrs/.
> 
> wdyt?

Totally agree.  I reused struct tcp_options_received but had a similar
thought like unused fields, confusing fields (saw_tstamp vs tstamp_ok,
user_mss vs clamp_mss), etc.

And I like bpf_tcp_req_attrs, tcp_cookie_attributes was bit wordy :)

So probably bpf_tcp_req_attrs would look like this ?

struct bpf_tcp_req_attrs {
	u32 rcv_tsval;
	u32 rcv_tsecr;
	u16 mss;
	u8 rcv_scale;
	u8 snd_scale;
	bool ecn_ok;
	bool wscale_ok;
	bool sack_ok;
	bool tstamp_ok;
	bool usec_ts;
} __packed;

or you prefer u8 over bool and __packed ?

struct bpf_tcp_req_attrs {
	u32 rcv_tsval;
	u32 rcv_tsecr;
	u16 mss;
	u8 rcv_scale;
	u8 snd_scale;
	u8 ecn_ok;
	u8 wscale_ok;
	u8 sack_ok;
	u8 tstamp_ok;
	u8 usec_ts;
}

