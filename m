Return-Path: <bpf+bounces-41867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C67FF99CB73
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 15:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31015B24978
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEF81AA7AE;
	Mon, 14 Oct 2024 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W1vTctHx"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E31AAE19
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911850; cv=none; b=HE6bOdidStBp+6xfC+7ji9QEOrhAD3IuSoQYAKGieuric4MoPgvV2cWLg5aLeeTWf+UG24Rp5Zj1c+TnYxqGOtGEHuzdFJuDUB4I2hab9YmcCX/n/wK6dtsUt6p14bw9IUeQRyLHYWvfbRoPOMEhaoIIZX+GTaAZYjHll/NMlzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911850; c=relaxed/simple;
	bh=/t0H+Ir4Au0T68gv0m4nAUEyIT15FceyJ6naZERQUgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3fFde1Edpw0ASHm7QPmT3tKq8zmPHv1jdp87ZDsRrLbjgigke45HS9qY5QnazYGQ6iIWTl3zEpQC8iiUg0uNkm4YtKqxS/g9B/DvbtdV/r2aZX4EECGYneUe5+wtkvjo6E5GqO1tIUlOCVv3mVIgJ9F+QJSA2yNzCiXs0CPzgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W1vTctHx; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0c7a9153-a04c-40c9-be86-878cb415b1c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728911844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YG1Wz75nV7/A67lJS94kttfyRt0MF6FLDKyZM+EbLE=;
	b=W1vTctHxWI6GXRn0otvsglIqbGjEBfszhqHkDvUmPFMJCGHNfcPnj8Mo/J+1QHHrydBTnA
	0+ADu4CAEhhd/y/P5Bu78HKQ3uHK3EFjWZTC606lEolL+ANzNNZA2TG691hM7Mio/Ro4bj
	Rq4M/pV3xUYmLw02LVY4OYKs/+5CHtw=
Date: Mon, 14 Oct 2024 21:17:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Prevent tailcall infinite loop
 caused by freplace
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Eddy Z <eddyz87@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 kernel-patches-bot@fb.com
References: <20241010153835.26984-1-leon.hwang@linux.dev>
 <20241010153835.26984-2-leon.hwang@linux.dev>
 <CAADnVQL8ie=xxCXt7td=ZhQwyY_hKtig-y9kHwWYwBG9MdfRQA@mail.gmail.com>
 <c7e49c48-7644-40c3-a4a2-664cc16a702c@linux.dev>
 <CAADnVQLh9nBHvkS40gg+PynmfMmPvwuYrcdMh9j2DqoL=9dqqw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLh9nBHvkS40gg+PynmfMmPvwuYrcdMh9j2DqoL=9dqqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2024/10/11 23:50, Alexei Starovoitov wrote:
> On Thu, Oct 10, 2024 at 8:27 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 11/10/24 01:09, Alexei Starovoitov wrote:
>>> On Thu, Oct 10, 2024 at 8:39 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>> Also Xu's suggestion makes sense to me.
>>> "extension prog should not be tailcalled independently"
>>>
>>> So I would disable such case as a part of this patch as well.
>>>
>>
>> I’m fine with adding this restriction.
>>
>> However, it will break a use case that works on the 5.15 kernel:
>>
>> libxdp XDP dispatcher --> subprog --> freplace A --tailcall-> freplace B.
>>
>> With this limitation, the chain 'freplace A --tailcall-> freplace B'
>> will no longer work.
>>
>> To comply with the new restriction, the use case would need to be
>> updated to:
>>
>> libxdp XDP dispatcher --> subprog --> freplace A --tailcall-> XDP B.
> 
> I don't believe libxdp is doing anything like this.
> It makes no sense to load PROG_TYPE_EXT that is supposed to freplace
> another subprog and _not_ proceed with the actual replacement.
> 

Without the new restriction, it’s difficult to prevent such a use case,
even if it’s not aligned with the intended design of freplace.

> tail_call-ing into EXT prog directly is likely very broken.
> EXT prog doesn't have to have ctx.
> Its arguments match the target global subprog which may not have ctx at all.
> 

Let me share a simple example of the use case in question:

In the XDP program:

__noinline int
int subprog_xdp(struct xdp_md *xdp)
{
 	return xdp ? XDP_PASS : XDP_ABORTED;
}

SEC("xdp")
int entry_xdp(struct xdp_md *xdp)
{
	return subprog_xdp(xdp);
}

In the freplace entry:

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

SEC("freplace")
int entry_freplace(struct xdp_md *xdp)
{
	int ret = XDP_PASS;

	bpf_tail_call_static(xdp, &jmp_table, 0);
	__sink(ret);
	return ret;
}

In the freplace tail callee:

SEC("freplace")
int entry_tailcallee(struct xdp_md *xdp)
{
	return XDP_PASS;
}

In this case, the attach target of entry_freplace is subprog_xdp, and
the tail call target of entry_freplace is entry_tailcallee. The attach
target of entry_tailcallee is entry_xdp, but it doesn't proceed with the
actual replacement. As a result, the call chain becomes:

entry_xdp -> subprog_xdp -> entry_freplace --tailcall-> entry_tailcallee.

> So it's not about disabling, it's fixing the bug.

Indeed, let us proceed with implementing the change.

Thanks,
Leon


