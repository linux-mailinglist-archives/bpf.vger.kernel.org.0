Return-Path: <bpf+bounces-34361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C0592CB25
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 08:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76ABA1C22036
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 06:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EA077115;
	Wed, 10 Jul 2024 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arctic-alpaca.de header.i=@arctic-alpaca.de header.b="ff0uhAB+"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C87B77F1B;
	Wed, 10 Jul 2024 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593156; cv=none; b=JMtJSWBdufTwi3rJQj8Rf+x7aWZJZmVta5ZkjlaWE7K4mK5Sga29UP/zwDKCtxTQA1CPL26RmIj24+KFQ3s6l4O7/ZlTcyujSlt7R9BaIS8whNRTX/W3eh0vepZye521bbV9C/u6EPnTc+dXvU1hrWTmw8zdTftV+mKcgL6fRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593156; c=relaxed/simple;
	bh=LQ2JpUcAC3pB6JkyF7iicHvOIHyzAj/bhmdPGKPqdL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pW7OEpSiI+reZFc2yGkbhvhO08nL6LCQBEBzRASMkNCVo9rV9r47JjbjNm4S7XvGdo06cgQc1ggq/eL+rxE5Ds37W6rF7Ysk3iQY5rtUE4x8HtjvLy603HgNtUrOvEkfFwrjNOgJCzqTotpAYMcAon+8yQ9fimsGJluDkkS0PyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arctic-alpaca.de; spf=pass smtp.mailfrom=arctic-alpaca.de; dkim=pass (2048-bit key) header.d=arctic-alpaca.de header.i=@arctic-alpaca.de header.b=ff0uhAB+; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arctic-alpaca.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arctic-alpaca.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WJp1d0jQCz9sWG;
	Wed, 10 Jul 2024 08:32:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arctic-alpaca.de;
	s=MBO0001; t=1720593141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgCGBRu/t9wGdUUXWMt25SHv2GpAThCMso2wLXxw/SY=;
	b=ff0uhAB+IOozMPSHCmOhlhh12iq/8mCYlK3EDS4cULm+ZrZ2IN6Imbbf7m8DMLa7e4N/jH
	gNJS0h/p6GUsrPilNiSlB8p0+14kpsMXtAaMeBeKF1blB6uGVoUUa3FX/7Q+0YU/OzieOd
	KRMtgH5uwq+t6/HAt1v1Kr1YG8BceDl381asnPfqSCr4yQTcQRgf9BsoNfIu3gACEwD9E2
	HNTlG6hGwH+hxMVRHI40rkhHUoyX3kk/HMU+ly+X4OK9To+eY048QsCFE4UL0kH7GOaNUG
	hoc7XyKA6SmagekH9w73GOhtPLSvILTx9gqlE5ZIIJ1dYwWGN98FapBRG7UV1A==
Message-ID: <9f464c87-b211-4aa6-a77f-c0d6ea1c025f@arctic-alpaca.de>
Date: Wed, 10 Jul 2024 08:32:18 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: xdp/xsk.c: Possible bug in xdp_umem_reg version check
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, bpf@vger.kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org
References: <2d6ff64a-5e2c-4078-a8d1-84f1ff3361ce@arctic-alpaca.de>
 <CAJ8uoz0w9RhAk2v4G-FSzjOCqitCPhEXOC6c_PcOFr7PxTjbWg@mail.gmail.com>
 <485c0bfb-8202-4520-92e9-e2bbbf6ac89b@arctic-alpaca.de>
 <Zo4R22FQeu_Ou7Gd@mini-arch>
Content-Language: de-DE, en-US
From: Julian Schindel <mail@arctic-alpaca.de>
In-Reply-To: <Zo4R22FQeu_Ou7Gd@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10.07.24 06:45, Stanislav Fomichev wrote:
> On 07/09, Julian Schindel wrote:
>> On 09.07.24 11:23, Magnus Karlsson wrote:
>>> On Sun, 7 Jul 2024 at 17:06, Julian Schindel <mail@arctic-alpaca.de> wrote:
>>>> Hi,
>>>>
>>>> [...]
>>> Thank you for reporting this Julian. This seems to be a bug. If I
>>> check the value of sizeof(struct xdp_umem_reg_v2), I get 32 bytes too
>>> on my system, compiling with gcc 11.4. I am not a compiler guy so do
>>> not know what the rules are for padding structs, but I read the
>>> following from [0]:
>>>
>>> "Pad the entire struct to a multiple of 64-bits if the structure
>>> contains 64-bit types - the structure size will otherwise differ on
>>> 32-bit versus 64-bit. Having a different structure size hurts when
>>> passing arrays of structures to the kernel, or if the kernel checks
>>> the structure size, which e.g. the drm core does."
>>>
>>> I compiled for 64-bits and I believe you did too, but we still get
>>> this padding. 
>> Yes, I did also compile for 64-bits. If I understood the resource you
>> linked correctly, the compiler automatically adding padding to align to
>> 64-bit boundaries is expected for 64-bit platforms:
>>
>> "[...] 32-bit platforms don’t necessarily align 64-bit values to 64-bit
>> boundaries, but 64-bit platforms do. So we always need padding to the
>> natural size to get this right."
>>> What is sizeof(struct xdp_umem_reg) for you before the
>>> patch that added tx_metadata_len?
>> I would expect this to be the same as sizeof(struct xdp_umem_reg_v2)
>> after the patch. I'm not sure how to check this with different kernel
>> versions.
>>
>> Maybe the following code helps show all the sizes
>> of xdp_umem_reg[_v1/_v2] on my system (compiled with "gcc test.c -o
>> test" using gcc 14.1.1):
>>
>> #include <stdio.h>
>> #include <sys/types.h>
>>
>> typedef __uint32_t __u32;
>> typedef __uint64_t __u64;
>>
>> struct xdp_umem_reg_v1  {
>>     __u64 addr; /* Start of packet data area */
>>     __u64 len; /* Length of packet data area */
>>     __u32 chunk_size;
>>     __u32 headroom;
>> };
>>
>> struct xdp_umem_reg_v2 {
>>     __u64 addr; /* Start of packet data area */
>>     __u64 len; /* Length of packet data area */
>>     __u32 chunk_size;
>>     __u32 headroom;
>>     __u32 flags;
>> };
>>
>> struct xdp_umem_reg {
>>     __u64 addr; /* Start of packet data area */
>>     __u64 len; /* Length of packet data area */
>>     __u32 chunk_size;
>>     __u32 headroom;
>>     __u32 flags;
>>     __u32 tx_metadata_len;
>> };
>>
>> int main() {
>>     printf("__u32: \t\t\t %lu\n", sizeof(__u32));
>>     printf("__u64: \t\t\t %lu\n", sizeof(__u64));
>>     printf("xdp_umem_reg_v1: \t %lu\n", sizeof(struct xdp_umem_reg_v1));
>>     printf("xdp_umem_reg_v2: \t %lu\n", sizeof(struct xdp_umem_reg_v2));
>>     printf("xdp_umem_reg: \t\t %lu\n", sizeof(struct xdp_umem_reg));
>> }
>>
>> Running "./test" produced this output:
>>
>> __u32:                   4
>> __u64:                   8
>> xdp_umem_reg_v1:         24
>> xdp_umem_reg_v2:         32
>> xdp_umem_reg:            32
>>> [0]: https://www.kernel.org/doc/html/v5.4/ioctl/botching-up-ioctls.html
> Hmm, true, this means our version check won't really work :-/ I don't
> see a good way to solve it without breaking the uapi. We can either
> add some new padding field to xdp_umem_reg to make it larger than _v2.
> Or we can add a new flag to signify the presence of tx_metadata_len
> and do the validation based on that.
>
> Btw, what are you using to setup umem? Looking at libxsk, it does
> `memset(&mr, 0, sizeof(mr));` which should clear the padding as well.

I'm using "setsockopt" directly with Rust bindings and the C
representation of Rust structs [1]. I'm guessing the compiler is not
zeroing the padding, which is why I encountered the issue.

[1]:
https://doc.rust-lang.org/reference/type-layout.html#the-c-representation

