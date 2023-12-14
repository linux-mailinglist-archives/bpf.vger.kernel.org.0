Return-Path: <bpf+bounces-17796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B069812868
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 07:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E853A282573
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 06:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB93D2EF;
	Thu, 14 Dec 2023 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qfA9ztx8"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDACB9;
	Wed, 13 Dec 2023 22:46:21 -0800 (PST)
Message-ID: <3186bf18-a8fd-4b30-a080-61beb13f19f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702536379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7V8e+jyiil5rWZA6frN0TI83nM5JUOA/KWZ7I2m1ICg=;
	b=qfA9ztx8p+wG4cjDb6Gl8erqRuFZDdRdoJUDXNLI4YMY45H6Gnx1ka71f2JORCf+R7UDIM
	gkRfqtejJ967bwekYjiByattWoxf1IEd0dhET3o4bpodxn5Bc2YBjh6LcMXLtIKLbdMZ7y
	49YGOUbxNORlqG8USZQbCSp08wZht9g=
Date: Wed, 13 Dec 2023 22:46:11 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 6/6] selftest: bpf: Test
 bpf_sk_assign_tcp_reqsk().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, dxu@dxuuu.xyz, edumazet@google.com,
 kuni1840@gmail.com, netdev@vger.kernel.org,
 Yonghong Song <yonghong.song@linux.dev>
References: <8fccb066-6d17-4fa8-ba67-287042046ea4@linux.dev>
 <20231214031819.83105-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231214031819.83105-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/13/23 7:18 PM, Kuniyuki Iwashima wrote:
>>> +static int tcp_parse_option(__u32 index, struct tcp_syncookie *ctx)
>>> +{
>>> +	struct tcp_options_received *tcp_opt = &ctx->attr.tcp_opt;
>>> +	char opcode, opsize;
>>> +
>>> +	if (ctx->ptr + 1 > ctx->data_end)
>>> +		goto stop;
>>> +
>>> +	opcode = *ctx->ptr++;
>>> +
>>> +	if (opcode == TCPOPT_EOL)
>>> +		goto stop;
>>> +
>>> +	if (opcode == TCPOPT_NOP)
>>> +		goto next;
>>> +
>>> +	if (ctx->ptr + 1 > ctx->data_end)
>>> +		goto stop;
>>> +
>>> +	opsize = *ctx->ptr++;
>>> +
>>> +	if (opsize < 2)
>>> +		goto stop;
>>> +
>>> +	switch (opcode) {
>>> +	case TCPOPT_MSS:
>>> +		if (opsize == TCPOLEN_MSS && ctx->tcp->syn &&
>>> +		    ctx->ptr + (TCPOLEN_MSS - 2) < ctx->data_end)
>>> +			tcp_opt->mss_clamp = get_unaligned_be16(ctx->ptr);
>>> +		break;
>>> +	case TCPOPT_WINDOW:
>>> +		if (opsize == TCPOLEN_WINDOW && ctx->tcp->syn &&
>>> +		    ctx->ptr + (TCPOLEN_WINDOW - 2) < ctx->data_end) {
>>> +			tcp_opt->wscale_ok = 1;
>>> +			tcp_opt->snd_wscale = *ctx->ptr;
>> When writing to a bitfield of "struct tcp_options_received" which is a kernel
>> struct, it needs to use the CO-RE api. The BPF_CORE_WRITE_BITFIELD has not been
>> landed yet:
>> https://lore.kernel.org/bpf/4d3dd215a4fd57d980733886f9c11a45e1a9adf3.1702325874.git.dxu@dxuuu.xyz/
>>
>> The same for reading bitfield but BPF_CORE_READ_BITFIELD() has already been
>> implemented in bpf_core_read.h
>>
>> Once the BPF_CORE_WRITE_BITFIELD is landed, this test needs to be changed to use
>> the BPF_CORE_{READ,WRITE}_BITFIELD.
> IIUC, the CO-RE api assumes that the offset of bitfields could be changed.
> 
> If the size of struct tcp_cookie_attributes is changed, kfunc will not work
> in this test.  So, BPF_CORE_WRITE_BITFIELD() works only when the size of
> tcp_cookie_attributes is unchanged but fields in tcp_options_received are
> rearranged or expanded to use the unused@ bits ?

Right, CO-RE helps to figure out the offset of a member in the running kernel.

> 
> Also, do we need to use BPF_CORE_READ() for other non-bitfields in
> strcut tcp_options_received (and ecn_ok in struct tcp_cookie_attributes
> just in case other fields are added to tcp_cookie_attributes and ecn_ok
> is rearranged) ?

BPF_CORE_READ is a CO-RE friendly macro for using bpf_probe_read_kernel(). 
bpf_probe_read_kernel() is mostly for the tracing use case where the ptr is not 
safe to read directly.

It is not the case for the tcp_options_received ptr in this tc-bpf use case or 
other stack allocated objects. In general, no need to use BPF_CORE_READ. The 
relocation will be done by the libbpf for tcp_opt->mss_clamp (e.g.).

Going back to bitfield, it needs BPF_CORE_*_BITFIELD because the offset may not 
be right after __attribute__((preserve_access_index)), cc: Yonghong and Andrii 
who know more details than I do.

A verifier error has been reported: 
https://lore.kernel.org/bpf/391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz/.

I also hit an error earlier in 
https://lore.kernel.org/all/20220817061847.4182339-1-kafai@fb.com/ when not 
using BPF_CORE_READ_BITFIELD. I don't exactly remember how the instruction looks 
like but it was reading a wrong value instead of verifier error.

================

Going back to this patch set here.

After sleeping on it longer, I am thinking it is better not to reuse 'struct 
tcp_options_received' (meaning no bitfield) in the bpf_sk_assign_tcp_reqsk() 
kfunc API.

There is not much benefit in reusing 'tcp_options_received'. When new tcp option 
was ever added to tcp_options_received, it is not like bpf_sk_assign_tcp_reqsk 
will support it automatically. It needs to relay this new option back to the 
allocated req. Unlike tcp_sock or req which may have a lot of them such that it 
is useful to have a compact tcp_options_received, the tc-bpf use case here is to 
allocate it once in the stack. Also, not all the members in tcp_options_received 
is useful, e.g. num_sacks, ts_recent_stamp, and user_mss are not used. Leaving 
it there being ignored by bpf_sk_assign_tcp_reqsk is confusing.

How about using a full u8 for each necessary member and directly add them to 
struct tcp_cookie_attributes instead of nesting them into another struct. After 
taking out the unnecessary members, the size may not end up to be much bigger.

The bpf prog can then directly access attr->tstamp_ok more naturally. The 
changes to patch 5 and 6 should be mostly mechanical changes.

I would also rename s/tcp_cookie_attributes/bpf_tcp_req_attrs/.

wdyt?



