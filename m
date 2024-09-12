Return-Path: <bpf+bounces-39776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 312A8977483
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 00:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CBF1C23C0E
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89771C32F7;
	Thu, 12 Sep 2024 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JwPDhcEi"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76CD1C2DC2
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181275; cv=none; b=mUwap6FVLoPQoWS1O50046soOQRklevrAizyT3soT6R6LXjnyQ24noK0Fks30zyTuLksFDWeA2edOqBZ0Uw7O74ltbcJpjdVfPGm3DumVhM1eZf8eQHfLFMfOzgJCxj+00o/R6azV41p/pOLLckgQf+Vyn5NZKcRljqEmfpaS8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181275; c=relaxed/simple;
	bh=0D5Ci3CYysSnJUEdENhFL2SrEf7jESs6oZBEBGuVPzQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K/43sZ9a0MchCxR9IRCy/oOylw36SVdFSS0XjEp22sd2E5zitw+3Sf8aVwZBiyYwxsCpyI3N5v8A/Egllp7jgi6hGI3bYsawaxgPugRzqWkR2X10oEu5eRnE/Da0TuKeEjuNz6nriOD/FBZPlgZzyHKo1TAdKy14kN6O2mBsPqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=JwPDhcEi; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZieezgjAmojIONiGW3w4WQPgW8MFgW7VSmG9Kb3o2gE=; b=JwPDhcEiyNqfqyzrS9zW0Dxfc7
	ZtYmZIIKsCbUI3EPCXiOLP9Y1HxOUaJGuhMi/rGXe87LFmXkJs1ywmf2nykHpmCVX6GTeW3McyyNq
	tOey+YnMJ6X5O8KqigYGgCohAeBh6/vNhCMK3nmx6tXXfGMm/akRAritMEOlLbhmVFxWoUJ8OTrk8
	oXMWNFN5jOxTB7lmVXtCnmnKwhwnvma0/x/AQS1NCKPJyqj6Zja4pi04Ug7cd+8tRGBPQvjQ2UMb4
	z8Qf4Q6jAnG+5eB5Y2DbQuf3p5W5u1Mthmih9OpBUK/I2QPyFOymyI3wsoo4gl/VPdxbaiSby2P7D
	sxZL7CnA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sosbO-000L7L-IY; Fri, 13 Sep 2024 00:47:50 +0200
Received: from [178.197.249.55] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sosbN-000Cdc-1U;
	Fri, 13 Sep 2024 00:47:49 +0200
Subject: Re: [PATCH bpf-next v4 5/8] bpf: Zero former ARG_PTR_TO_{LONG,INT}
 args in case of error
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 kongln9170@gmail.com
References: <20240906135608.26477-1-daniel@iogearbox.net>
 <20240906135608.26477-5-daniel@iogearbox.net>
 <CAADnVQ+GSCAPC7v787c4poFY4ku=L9q1cn1d=A3YhVRUomoVrQ@mail.gmail.com>
 <fb38bb54-c59b-ba36-821f-f7dfcaa390cc@iogearbox.net>
 <a86eb76d-f52f-dee4-e5d2-87e45de3e16f@iogearbox.net>
 <CAEf4BzbYwfEaoG8TQrncjeG6RSD5TO04baAM=t9aqShVnbn8vg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e5edd241-59e7-5e39-0ee5-a51e31b6840a@iogearbox.net>
Date: Fri, 13 Sep 2024 00:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbYwfEaoG8TQrncjeG6RSD5TO04baAM=t9aqShVnbn8vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27396/Thu Sep 12 10:46:40 2024)

On 9/12/24 7:59 PM, Andrii Nakryiko wrote:
> On Thu, Sep 12, 2024 at 2:47 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 9/9/24 2:16 PM, Daniel Borkmann wrote:
>>> On 9/7/24 12:35 AM, Alexei Starovoitov wrote:
>>>> On Fri, Sep 6, 2024 at 6:56 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>>
>>>>> -       if (unlikely(flags & ~(BPF_MTU_CHK_SEGS)))
>>>>> -               return -EINVAL;
>>>>> -
>>>>> -       if (unlikely(flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len)))
>>>>> +       if (unlikely((flags & ~(BPF_MTU_CHK_SEGS)) ||
>>>>> +                    (flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len)))) {
>>>>> +               *mtu_len = 0;
>>>>>                   return -EINVAL;
>>>>> +       }
>>>>>
>>>>>           dev = __dev_via_ifindex(dev, ifindex);
>>>>> -       if (unlikely(!dev))
>>>>> +       if (unlikely(!dev)) {
>>>>> +               *mtu_len = 0;
>>>>>                   return -ENODEV;
>>>>> +       }
>>>>
>>>> I don't understand this mtu_len clearing.
>>>>
>>>> My earlier comment was that mtu is in&out argument.
>>>> The program has to set it to something. It cannot be uninit.
>>>> So zeroing it on error looks very odd.
>>>>
>>>> In that sense the patch 3 looks wrong. Instead of:
>>>>
>>>> @@ -6346,7 +6346,9 @@ static const struct bpf_func_proto
>>>> bpf_skb_check_mtu_proto = {
>>>>           .ret_type       = RET_INTEGER,
>>>>           .arg1_type      = ARG_PTR_TO_CTX,
>>>>           .arg2_type      = ARG_ANYTHING,
>>>> -       .arg3_type      = ARG_PTR_TO_INT,
>>>> +       .arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM |
>>>> +                         MEM_UNINIT | MEM_ALIGNED,
>>>> +       .arg3_size      = sizeof(u32),
>>>>
>>>> MEM_UNINIT should be removed, because
>>>> bpf_xdp_check_mtu, bpf_skb_check_mtu will read it.
>>>>
>>>> If there is a program out there that calls this helper without
>>>> initializing mtu_len it will be rejected after we fix it,
>>>> but I think that's a good thing.
>>>> Passing random mtu_len and let helper do:
>>>>
>>>> skb_len = *mtu_len ? *mtu_len + dev->hard_header_len : skb->len;
>>>>
>>>> is just bad.
>>>
>>> Ok, fair. Removing MEM_UNINIT sounds reasonable, was mostly thinking
>>> that even if its garbage MTU being passed in, mtu_len gets filled in
>>> either case (BPF_MTU_CHK_RET_{SUCCESS,FRAG_NEEDED}) assuming no invalid
>>> ifindex e.g.:
>>>
>>>     __u32 mtu_len;
>>>     bpf_skb_check_mtu(skb, skb->ifindex, &mtu_len, 0, 0);
>>
>> Getting back at this, removing MEM_UNINIT needs more verifier rework:
>> MEM_UNINIT right now implies two things actually: i) write into memory,
>> ii) memory does not have to be initialized. If we lift MEM_UNINIT, it
>> then becomes: i) read into memory, ii) memory must be initialized.
>>
>> This means that for bpf_*_check_mtu() we're readding the issue we're
>> trying to fix, that is, it would then be able to write back into things
>> like .rodata maps.
>>
>> My suggestion is for this series is to go with MEM_UNINIT tag and
>> clearing on error case to avoid leaking, and then in a subsequent
>> series to break up MEM_UNINIT in the verifier into two properties:
>> MEM_WRITE and MEM_UNINIT to better declare intent of the helpers. Then
>> the bpf_*_check_mtu() will have MEM_WRITE but not MEM_UNINIT.
>>
>> Thoughts? (If preference is to further extend this series, I can also
>> look into that ofc.)
> 
> We have MEM_RDONLY which literally means that memory is meant to be
> only consumed for reading. Will this solve these issues?

It doesn't help, in check_helper_mem_access() we check for writes e.g.
for map values only via BPF_WRITE when meta->raw_mode is set which is
the case for MEM_UNINIT-tagged ARG_PTR_TO_MEM, otherwise BPF_READ is
implied hence my suggestion to break this up into two properties as a
next step.

Thanks,
Daniel

