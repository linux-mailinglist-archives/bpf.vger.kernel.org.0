Return-Path: <bpf+bounces-34506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A34CA92DF68
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 07:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50867281705
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 05:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8395C5F3;
	Thu, 11 Jul 2024 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arctic-alpaca.de header.i=@arctic-alpaca.de header.b="w4l+n0Lm"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF911C3D;
	Thu, 11 Jul 2024 05:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675398; cv=none; b=MLdeETwAqXwDbKFK2033k91/exBbIYXFq5MgdaHWvAQLjJ2sMTDMmiC8DsWyLZyVhnxWNQeKigFqi3mVB2FeIUpt6m71NY03480mGPDupMwO6XYRULNWHcKK8QzReWk7vMz4imYYgk/3U2mnn8p5IVTGuu1B9zOoX0KEnqmtJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675398; c=relaxed/simple;
	bh=/BAq8GeYl0f8uRjyRxKchiS4fHmoZyohGvOCnZLqUpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xt401i20xuGYxWsiWORtIizdGrAU3GFBjgMa7JbacETUOfaaGAzWhWayJLCcP0Z0W96NJeLleJXM2z7bTZYeLE5/ucTzzLV+w/1bLRn+iZ0N2xrnes1pHjFT7iH4TxL5utBc+K0rK32tFaR3KjztYV1qVf/N5IynOmKAvyAm74E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arctic-alpaca.de; spf=pass smtp.mailfrom=arctic-alpaca.de; dkim=pass (2048-bit key) header.d=arctic-alpaca.de header.i=@arctic-alpaca.de header.b=w4l+n0Lm; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arctic-alpaca.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arctic-alpaca.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WKNRB56fnz9sdP;
	Thu, 11 Jul 2024 07:23:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arctic-alpaca.de;
	s=MBO0001; t=1720675382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vxdp8bD7n13IR48G3OzaEyi5Mam7ihLD4sdP+q1Ew2w=;
	b=w4l+n0LmLn9ahUSGYqaB/lcc/hwGxt+Q042pa1I+e3lpFRtyW5rEqgYsY7bht6Imj+qYF2
	Fpu2eZQq26T3DBpgBRuIw/OpjB0+1+q89gx7JtVQyF/6zoUAMrsV3NB0vmY/33z7zQg+N9
	GMtmnAfG0rRmKygDjhNjgE2AIGbr4KVku2Khw1KnPl81zvFS956MDHc+1tcJRlR9KYUHg7
	PmDbJEd1/3CFAiTxu/VDzPRk9OqAhypta0ZPNJbQ2089SpRak2Fx1ryldNZ74Rm5wbvNx8
	aDgXwJ/qsKcYY+Q7kde8g/VWLQGDFpmcjzKufwbYJfboWHXpLZ4MWmluLsw7bA==
Message-ID: <8a527e65-8677-43be-8c8d-ffc5d351f8fb@arctic-alpaca.de>
Date: Thu, 11 Jul 2024 07:23:00 +0200
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
 <9f464c87-b211-4aa6-a77f-c0d6ea1c025f@arctic-alpaca.de>
 <Zo9WCnMFSs775MSd@mini-arch>
Content-Language: de-DE, en-US
From: Julian Schindel <mail@arctic-alpaca.de>
In-Reply-To: <Zo9WCnMFSs775MSd@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WKNRB56fnz9sdP

On 11.07.24 05:48, Stanislav Fomichev wrote:
> On 07/10, Julian Schindel wrote:
>> On 10.07.24 06:45, Stanislav Fomichev wrote:
>>> On 07/09, Julian Schindel wrote:
>>>> On 09.07.24 11:23, Magnus Karlsson wrote:
>>>>> On Sun, 7 Jul 2024 at 17:06, Julian Schindel <mail@arctic-alpaca.de> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> [...]
>>>>> Thank you for reporting this Julian. This seems to be a bug. If I
>>>>> check the value of sizeof(struct xdp_umem_reg_v2), I get 32 bytes too
>>>>> on my system, compiling with gcc 11.4. I am not a compiler guy so do
>>>>> not know what the rules are for padding structs, but I read the
>>>>> following from [0]:
>>>>>
>>>>> "Pad the entire struct to a multiple of 64-bits if the structure
>>>>> contains 64-bit types - the structure size will otherwise differ on
>>>>> 32-bit versus 64-bit. Having a different structure size hurts when
>>>>> passing arrays of structures to the kernel, or if the kernel checks
>>>>> the structure size, which e.g. the drm core does."
>>>>>
>>>>> I compiled for 64-bits and I believe you did too, but we still get
>>>>> this padding. 
>>>> Yes, I did also compile for 64-bits. If I understood the resource you
>>>> linked correctly, the compiler automatically adding padding to align to
>>>> 64-bit boundaries is expected for 64-bit platforms:
>>>>
>>>> "[...] 32-bit platforms don’t necessarily align 64-bit values to 64-bit
>>>> boundaries, but 64-bit platforms do. So we always need padding to the
>>>> natural size to get this right."
>>>>> What is sizeof(struct xdp_umem_reg) for you before the
>>>>> patch that added tx_metadata_len?
>>>> I would expect this to be the same as sizeof(struct xdp_umem_reg_v2)
>>>> after the patch. I'm not sure how to check this with different kernel
>>>> versions.
>>>>
>>>> Maybe the following code helps show all the sizes
>>>> of xdp_umem_reg[_v1/_v2] on my system (compiled with "gcc test.c -o
>>>> test" using gcc 14.1.1):
>>>>
>>>> #include <stdio.h>
>>>> #include <sys/types.h>
>>>>
>>>> typedef __uint32_t __u32;
>>>> typedef __uint64_t __u64;
>>>>
>>>> struct xdp_umem_reg_v1  {
>>>>     __u64 addr; /* Start of packet data area */
>>>>     __u64 len; /* Length of packet data area */
>>>>     __u32 chunk_size;
>>>>     __u32 headroom;
>>>> };
>>>>
>>>> struct xdp_umem_reg_v2 {
>>>>     __u64 addr; /* Start of packet data area */
>>>>     __u64 len; /* Length of packet data area */
>>>>     __u32 chunk_size;
>>>>     __u32 headroom;
>>>>     __u32 flags;
>>>> };
>>>>
>>>> struct xdp_umem_reg {
>>>>     __u64 addr; /* Start of packet data area */
>>>>     __u64 len; /* Length of packet data area */
>>>>     __u32 chunk_size;
>>>>     __u32 headroom;
>>>>     __u32 flags;
>>>>     __u32 tx_metadata_len;
>>>> };
>>>>
>>>> int main() {
>>>>     printf("__u32: \t\t\t %lu\n", sizeof(__u32));
>>>>     printf("__u64: \t\t\t %lu\n", sizeof(__u64));
>>>>     printf("xdp_umem_reg_v1: \t %lu\n", sizeof(struct xdp_umem_reg_v1));
>>>>     printf("xdp_umem_reg_v2: \t %lu\n", sizeof(struct xdp_umem_reg_v2));
>>>>     printf("xdp_umem_reg: \t\t %lu\n", sizeof(struct xdp_umem_reg));
>>>> }
>>>>
>>>> Running "./test" produced this output:
>>>>
>>>> __u32:                   4
>>>> __u64:                   8
>>>> xdp_umem_reg_v1:         24
>>>> xdp_umem_reg_v2:         32
>>>> xdp_umem_reg:            32
>>>>> [0]: https://www.kernel.org/doc/html/v5.4/ioctl/botching-up-ioctls.html
>>> Hmm, true, this means our version check won't really work :-/ I don't
>>> see a good way to solve it without breaking the uapi. We can either
>>> add some new padding field to xdp_umem_reg to make it larger than _v2.
>>> Or we can add a new flag to signify the presence of tx_metadata_len
>>> and do the validation based on that.
>>>
>>> Btw, what are you using to setup umem? Looking at libxsk, it does
>>> `memset(&mr, 0, sizeof(mr));` which should clear the padding as well.
>> I'm using "setsockopt" directly with Rust bindings and the C
>> representation of Rust structs [1]. I'm guessing the compiler is not
>> zeroing the padding, which is why I encountered the issue.
>>
>> [1]:
>> https://doc.rust-lang.org/reference/type-layout.html#the-c-representation
> Awesome, thanks for confirming! I guess for now you can work it around
> by having an explicit padding field and setting it to zero?

Yes,the issue isn't blocking for me.
> For a long-term fix, I'm leaning towards adding new umem flag as
> a signal to the kernel to interpret this as a tx_metadata_len. But
> this is gonna break any existing users that set this value. Hopefully
> should not be a lot of them since it is a pretty recent functionality.
>
> I'm also gonna sprinkle some compile time asserts to make sure we can extend
> xdp_umem_reg in the future without hitting the same issue again. I'm a
> bit spoiled by sys_bpf which takes care of enforcing the padding being
> zero.

Sounds good to me, I cannot think of any non-breaking solution.
Thank you for taking care of the issue!

>
> Magnus, any better ideas?


