Return-Path: <bpf+bounces-39710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465139765F6
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 11:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1376B220E2
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B725A19C57E;
	Thu, 12 Sep 2024 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="O/0P5xII"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8393818EFFB
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134441; cv=none; b=GXe+fRxfXeqJI8YKyPHu7V2gFf2gHtseROCmzJjs0VH2ncITfpg+D2zxMCaszqarnYk2Dg4rUivw9satR9Y/CEhvMDFB5frlbOzot1iVtjZnsQRSC8IvcG2AXP1TOOHL1uXqSBKWR16hJDkwEkNsiGwplALjMxY5cLod4zxKBl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134441; c=relaxed/simple;
	bh=lCeGm7OX+3nco+RQzEZtpn5F4CacjEo5flC5KoYXlaw=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MLBYPDQIcBe3oL4DjPsocFXFuVquMeO/sDYNCKE3IGbqYu75AaMPjDSs39hSSbADXd3DZ+ICwzPLklhN/NeqtwUOw+rngdLJwakBk55TN1EYsJ2AmLno2YVlw8AC2XDlAc2YehkbUaxhSiPBxXoHK9T8uFE7TYKobcN+T6GNI8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=O/0P5xII; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oGJX6c+Qu6lJ3yhyHfZ5X0xVRwWLDPFVZrEIW70GBNY=; b=O/0P5xIIlB69T0wshAAovNeHa+
	VEb3/qM4SssAawEcvlRaVa84ryYp02FjuHeF14HtEArZ9WIOLII3xcsU1XTkB7r2OGKsEGY5IO0Lz
	nVF4PUN39nj8QqOau4vAZ0HLzFpU0epACa+YaO9UW5WJfklVbaTw3NWcz4AfxKyPP1rxeSeXHWCjE
	jT86Ibumi8w6ykGqroKOM/CCDxgCZrVfVYzVXf8LFUnHmuE2mP7db2i1n13FXsHFAgtEdrga5hbMq
	DTnJJ81bV6XYkIP0YKN6mNGRc/MaMin1/uD6HLln3pyaUVrWKBSO1pV9IgPsK47LTa5rCzFy4XYQs
	00z6Bc8w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sogQ0-0008Ff-98; Thu, 12 Sep 2024 11:47:16 +0200
Received: from [178.197.249.55] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sogPz-000Poq-0h;
	Thu, 12 Sep 2024 11:47:15 +0200
Subject: Re: [PATCH bpf-next v4 5/8] bpf: Zero former ARG_PTR_TO_{LONG,INT}
 args in case of error
From: Daniel Borkmann <daniel@iogearbox.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 kongln9170@gmail.com
References: <20240906135608.26477-1-daniel@iogearbox.net>
 <20240906135608.26477-5-daniel@iogearbox.net>
 <CAADnVQ+GSCAPC7v787c4poFY4ku=L9q1cn1d=A3YhVRUomoVrQ@mail.gmail.com>
 <fb38bb54-c59b-ba36-821f-f7dfcaa390cc@iogearbox.net>
Message-ID: <a86eb76d-f52f-dee4-e5d2-87e45de3e16f@iogearbox.net>
Date: Thu, 12 Sep 2024 11:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fb38bb54-c59b-ba36-821f-f7dfcaa390cc@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27395/Wed Sep 11 10:32:20 2024)

On 9/9/24 2:16 PM, Daniel Borkmann wrote:
> On 9/7/24 12:35 AM, Alexei Starovoitov wrote:
>> On Fri, Sep 6, 2024 at 6:56 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>
>>> -       if (unlikely(flags & ~(BPF_MTU_CHK_SEGS)))
>>> -               return -EINVAL;
>>> -
>>> -       if (unlikely(flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len)))
>>> +       if (unlikely((flags & ~(BPF_MTU_CHK_SEGS)) ||
>>> +                    (flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len)))) {
>>> +               *mtu_len = 0;
>>>                  return -EINVAL;
>>> +       }
>>>
>>>          dev = __dev_via_ifindex(dev, ifindex);
>>> -       if (unlikely(!dev))
>>> +       if (unlikely(!dev)) {
>>> +               *mtu_len = 0;
>>>                  return -ENODEV;
>>> +       }
>>
>> I don't understand this mtu_len clearing.
>>
>> My earlier comment was that mtu is in&out argument.
>> The program has to set it to something. It cannot be uninit.
>> So zeroing it on error looks very odd.
>>
>> In that sense the patch 3 looks wrong. Instead of:
>>
>> @@ -6346,7 +6346,9 @@ static const struct bpf_func_proto
>> bpf_skb_check_mtu_proto = {
>>          .ret_type       = RET_INTEGER,
>>          .arg1_type      = ARG_PTR_TO_CTX,
>>          .arg2_type      = ARG_ANYTHING,
>> -       .arg3_type      = ARG_PTR_TO_INT,
>> +       .arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM |
>> +                         MEM_UNINIT | MEM_ALIGNED,
>> +       .arg3_size      = sizeof(u32),
>>
>> MEM_UNINIT should be removed, because
>> bpf_xdp_check_mtu, bpf_skb_check_mtu will read it.
>>
>> If there is a program out there that calls this helper without
>> initializing mtu_len it will be rejected after we fix it,
>> but I think that's a good thing.
>> Passing random mtu_len and let helper do:
>>
>> skb_len = *mtu_len ? *mtu_len + dev->hard_header_len : skb->len;
>>
>> is just bad.
> 
> Ok, fair. Removing MEM_UNINIT sounds reasonable, was mostly thinking
> that even if its garbage MTU being passed in, mtu_len gets filled in
> either case (BPF_MTU_CHK_RET_{SUCCESS,FRAG_NEEDED}) assuming no invalid
> ifindex e.g.:
> 
>    __u32 mtu_len;
>    bpf_skb_check_mtu(skb, skb->ifindex, &mtu_len, 0, 0);

Getting back at this, removing MEM_UNINIT needs more verifier rework:
MEM_UNINIT right now implies two things actually: i) write into memory,
ii) memory does not have to be initialized. If we lift MEM_UNINIT, it
then becomes: i) read into memory, ii) memory must be initialized.

This means that for bpf_*_check_mtu() we're readding the issue we're
trying to fix, that is, it would then be able to write back into things
like .rodata maps.

My suggestion is for this series is to go with MEM_UNINIT tag and
clearing on error case to avoid leaking, and then in a subsequent
series to break up MEM_UNINIT in the verifier into two properties:
MEM_WRITE and MEM_UNINIT to better declare intent of the helpers. Then
the bpf_*_check_mtu() will have MEM_WRITE but not MEM_UNINIT.

Thoughts? (If preference is to further extend this series, I can also
look into that ofc.)

Thanks,
Daniel

