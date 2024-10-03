Return-Path: <bpf+bounces-40862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E63798F71D
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 21:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCE91F21498
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 19:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75961AC447;
	Thu,  3 Oct 2024 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRfiBXu9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71147F5F
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984272; cv=none; b=B+tbfoAsz5L8iQsET4IXHwsQSEoyBkFAnazJ5g1GpfgKU6IJwmOX+a2PropyE8r9naF/4nCfOK9q3tAmkTF/TWgD19USLzd5sgAqiadLFWMOMLiZPmQ5k3bywqZaYaDs/BNuvNfyRB92A6N6rLQZjAf0eRqKA8mkufyojX1HcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984272; c=relaxed/simple;
	bh=2xo7SGSaVy0qaLPMhUuPEJMQkI/ZtzOb7immFpQwm88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOOUO9hjordXTVNtclB+3kRJAHFVEA/9j9p/somcDmNsIdDCLAzOQBX9miHTNcVASwAnY/UBOaUTIh6SA6f+7xFPzTP75BXkb6a0Gh7XvuaY/xtQRHFL9rBY2iszbFZgl2jR/H/WRO7NoskqzaRFVPJv+XO8arcaARZ/x4O0eQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRfiBXu9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727984269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GT3VpxFyUOM4dLFK2TgVUb5gT2teMjnfDkweDC4g/TQ=;
	b=DRfiBXu9q3QzH7TwXUCbRj/tUdtRxA/kdm6cStmx4/6oB7yWcwGYo28L5latD2bcICgGp3
	GnOAVzUaQKKM31Nf4SF31q+hwaA1fJC9BjaLTGsPDMPX4qAB5e6ZSS/n6gTlu2ny9eytWf
	0pUySJFPsNSxq/3zm4GwLTYVQ1xQzhw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-Wtp1D7mTNk6fmp1W6WPZkg-1; Thu, 03 Oct 2024 15:37:48 -0400
X-MC-Unique: Wtp1D7mTNk6fmp1W6WPZkg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8a9094c96cso81085866b.1
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2024 12:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727984267; x=1728589067;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GT3VpxFyUOM4dLFK2TgVUb5gT2teMjnfDkweDC4g/TQ=;
        b=GO2Lbui/0X0bHcr/zw4g9CxrNuvPicdNIONFxVkogZirwXOFH3XBBmHrniS+6DPO05
         Osw9XJyvcm4hN3UGY8e/K8XUImmRFMB9XFXWpxHunwL6T6JfC7ViVcU45+xl8K7w3lgM
         G/kF//CoAQIxijOp3w8/vZ1YsnF8SGDXrJF9q3JvlesGeelOLDc+ilzcCcqIHTOGMUOW
         vQfF/+jhmaSY4mIwNWKwIxzqkEIviLH8bH0w6QgQ9OvmDiW1fjoJ9g74xys9BisnePuF
         WSLS/E8aJA9EHnyxNUpEEjzRvz4lm7kK4PlZFPNb9qubp8+8eosn04dBmaE6TTt32iW5
         fRQg==
X-Forwarded-Encrypted: i=1; AJvYcCWui7FqFu8AzKO3+GCW177ZgaqmIZuQC+S+USzfN+W7ZEl5QD5rTi2lf/DoLYEhiN+VMso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4qdQp50G5x1+gTkYLxE+iubBfehHFo3VZZYZHVXSnhq5krKKY
	xCgT7MTrBTbd90Ai5n8x4hd/YFuL/0ip+gZQEg8OXzFhiH/Pfu/tSBR0MldC9zGl0eCJUzTjNNV
	dsAYjr8QwZeFWVUfZ7AXVaFxbPLVEElnbSYiSs0ZCy2acI+ah
X-Received: by 2002:a17:907:9492:b0:a8d:2ec3:94f4 with SMTP id a640c23a62f3a-a991c07445amr32881366b.54.1727984267248;
        Thu, 03 Oct 2024 12:37:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV1uw4kjyp1omnA8ZyFm+MzCkIFx6sjygDpDoBtUAn9TWB1hPx+GFvqCWPtlZQayWiZChLcQ==
X-Received: by 2002:a17:907:9492:b0:a8d:2ec3:94f4 with SMTP id a640c23a62f3a-a991c07445amr32878966b.54.1727984266780;
        Thu, 03 Oct 2024 12:37:46 -0700 (PDT)
Received: from [192.168.1.108] (ip73.213-181-144.pegonet.sk. [213.181.144.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99104c427esm122077566b.190.2024.10.03.12.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 12:37:46 -0700 (PDT)
Message-ID: <ce2f1357-7e89-4caa-8027-559b0d7ebf43@redhat.com>
Date: Thu, 3 Oct 2024 21:37:41 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfuncs for read-only string
 operations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1727329823.git.vmalik@redhat.com>
 <bc06e1f4bef09ba3d431d7a7236303746a7adb57.1727329823.git.vmalik@redhat.com>
 <CAEf4Bzas4ZxiyJp7h7N5OGmPSMRfZDgPUgEAdTmir3n-4cx-xg@mail.gmail.com>
 <adaa47618f2b71c2803195749cedd4a5b468cffa.camel@gmail.com>
 <CAADnVQLCk+VNpN8WfCbSbT-FBcHBuMXpk-hBOLB7HX3BrURp8w@mail.gmail.com>
 <CAEf4BzZSFuXyUbwN8_VvbR6Uk_qHAKWNLkCZfdo-58WC_RYYag@mail.gmail.com>
 <CAADnVQLsnhsL2i_RnOBUSebO--yx_5Az1Ydr9QPb5WZCkmYQJg@mail.gmail.com>
 <CAEf4BzYt42A73kmg5=HWRiHj0H1Dr0WPQosmQLkBhgkkiw0HQA@mail.gmail.com>
 <c831b42e-30ba-4a19-bc0d-5346c8388892@redhat.com>
 <CAADnVQLhr+xOF58ppaySOjb6cMdsWEYhr_4ZLvQ-XDWXHBMgBA@mail.gmail.com>
 <e4bfbee4-ca5f-4496-98ed-60d24e402046@redhat.com>
 <CAADnVQKmEOLp+7p+YV0gS1z8ed+cLHK+BjMgt+rvhdUdJxPRGg@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQKmEOLp+7p+YV0gS1z8ed+cLHK+BjMgt+rvhdUdJxPRGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/3/24 19:02, Alexei Starovoitov wrote:
> On Wed, Oct 2, 2024 at 9:51 PM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> On 10/2/24 18:55, Alexei Starovoitov wrote:
>>> On Tue, Oct 1, 2024 at 11:12 PM Viktor Malik <vmalik@redhat.com> wrote:
>>>>
>>>> On 10/1/24 19:40, Andrii Nakryiko wrote:
>>>>> On Tue, Oct 1, 2024 at 10:34 AM Alexei Starovoitov
>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>
>>>>>> On Tue, Oct 1, 2024 at 10:04 AM Andrii Nakryiko
>>>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>>>
>>>>>>> On Tue, Oct 1, 2024 at 7:48 AM Alexei Starovoitov
>>>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Tue, Oct 1, 2024 at 4:26 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> On Mon, 2024-09-30 at 15:00 -0700, Andrii Nakryiko wrote:
>>>>>>>>>
>>>>>>>>> [...]
>>>>>>>>>
>>>>>>>>>> Right now, the only way to pass dynamically sized anything is through
>>>>>>>>>> dynptr, AFAIU.
>>>>>>>>>
>>>>>>>>> But we do have 'is_kfunc_arg_mem_size()' that checks for __sz suffix,
>>>>>>>>> e.g. used for bpf_copy_from_user_str():
>>>>>>>>>
>>>>>>>>> /**
>>>>>>>>>  * bpf_copy_from_user_str() - Copy a string from an unsafe user address
>>>>>>>>>  * @dst:             Destination address, in kernel space.  This buffer must be
>>>>>>>>>  *                   at least @dst__sz bytes long.
>>>>>>>>>  * @dst__sz:         Maximum number of bytes to copy, includes the trailing NUL.
>>>>>>>>>  * ...
>>>>>>>>>  */
>>>>>>>>> __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user *unsafe_ptr__ign, u64 flags)
>>>>>>>>>
>>>>>>>>> However, this suffix won't work for strnstr because of the arguments order.
>>>>>>>>
>>>>>>>> Stating the obvious... we don't need to keep the order exactly the same.
>>>>>>>>
>>>>>>>> Regarding all of these kfuncs... as Andrii pointed out 'const char *s'
>>>>>>>> means that the verifier will check that 's' points to a valid byte.
>>>>>>>> I think we can do a hybrid static + dynamic safety scheme here.
>>>>>>>> All of the kfunc signatures can stay the same, but we'd have to
>>>>>>>> open code all string helpers with __get_kernel_nofault() instead of
>>>>>>>> direct memory access.
>>>>>>>> Since the first byte is guaranteed to be valid by the verifier
>>>>>>>> we only need to make sure that the s+N bytes won't cause page faults
>>>>>>>
>>>>>>> You mean to just check that s[N-1] can be read? Given a large enough
>>>>>>> N, couldn't it be that some page between s[0] and s[N-1] still can be
>>>>>>> unmapped, defeating this check?
>>>>>>
>>>>>> Just checking s[0] and s[N-1] is not enough, obviously, and especially,
>>>>>> since the logic won't know where nul byte is, so N is unknown.
>>>>>> I meant to that all of str* kfuncs will be reading all bytes
>>>>>> via __get_kernel_nofault() until they find \0.
>>>>>
>>>>> Ah, ok, I see what you mean now.
>>>>>
>>>>>> It can be optimized to 8 byte access.
>>>>>> The open coding (aka copy-paste) is unfortunate, of course.
>>>>>
>>>>> Yep, this sucks.
>>>>
>>>> Yeah, that's quite annoying. I really wanted to avoid doing that. Also,
>>>> we won't be able to use arch-optimized versions of the functions.
>>>>
>>>> Just to make sure I understand things correctly - can we do what Eduard
>>>> suggested and add explicit sizes for all arguments using the __sz
>>>> suffix? So something like:
>>>>
>>>>     const char *bpf_strnstr(const char *s1, u32 s1__sz, const char *s2, u32 s2__sz);
>>>
>>> That's ok-ish, but you probably want:
>>>
>>> const char *bpf_strnstr(void *s1, u32 s1__sz, void *s2, u32 s2__sz);
>>>
>>> and then to call strnstr() you still need to strnlen(s2, s2__sz).
>>>
>>> But a more general question... how always passing size will work
>>> for bpftrace ? Does it always know the upper bound of storage where
>>> strings are stored?
>>
>> Yes, it does. The strings must be read via the str() call (which
>> internally calls bpf_probe_read_str) and there's an upper bound on the
>> size of each string.
> 
> which sounds like a bpftrace current limitation and not something to
> depend on from kfunc design pov.
> Wouldn't you want strings to be arbitrary length?

Sure, there's just a lot of work to be done on that front...

But I agree, it shouldn't be a limitation for the kfuncs. I just wanted
to point out that if we agreed to only create kfuncs for bounded
functions, bpftrace use-case would be (at least for the moment) covered.

Anyways, it seems to me that both the bounded and the unbounded versions
have their place. Would it be ok with you to open-code just the
unbounded ones and call in-kernel implementations for the bounded ones?
Or would you prefer to have everything unified (i.e. open-coded)?

Also, just out of curiosity, what are the ways to create/obtain strings
of unbounded length in BPF programs? Arguments of BTF-enabled program
types (like fentry)? Any other examples? Because IIUC, when you read
strings from kernel/userspace memory using bpf_probe_read_str, you
always need to specify the size.

> 
>>> I would think __get_kernel_nofault() approach is user friendlier.
>>
>> That's probably true but isn't there still the problem that strings are
>> not necessarily null-terminated? And in such case, unbounded string
>> functions may not terminate which is not allowed in BPF?
> 
> kfuncs that are searching for nul via loop with __get_kernel_nofault()
> would certainly need an upper bound.
> Something like PATH_MAX (4k) or XATTR_SIZE_MAX (64k)
> would cover 99.99% of use cases.

Right, makes sense.

Thanks!
Viktor

> 


