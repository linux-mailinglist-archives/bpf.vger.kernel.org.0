Return-Path: <bpf+bounces-40734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FC598CCF5
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 08:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F96B21770
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 06:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52C283A06;
	Wed,  2 Oct 2024 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2PVItNu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E111F93E
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 06:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727849532; cv=none; b=ihb146KLCLLLIooaa3E4UwgmlJywn7qIXZYE1zhh+hMBIh5XaOzuBqSlX7PQn+2cPdhL/Ra0vOu1r5WFurO2kSvQCIvKDHwJwAfEHvh8i9324/S2BC8VxHutFRw4knKnXjbwUHg7O++MUi3QwCyT0ZGyFImVJjAXxcdSPQL88Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727849532; c=relaxed/simple;
	bh=0jzohQSuTQQjAIXeCqTGYlHEmlU8a/fP8g1CVlQi48k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dbgblr7bazsswj/gzJAIVwWakz62u1lL1VgVnb0BeGupMRPQxbSsQdt3gM4hvDoNWLa5iLhPMIW20ZaJldaKC69Gkg4jdpPIPtO6YUR+hadcDXPids7bHRjet6dOjXq94aeaWZHMOE8Q0onvErEnK6AkILxACNH+rC8Ms/wQdP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2PVItNu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727849529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9J+MkZnqVn4PCVBLtkAGb5yev779UnAGvym9VWdz2E=;
	b=f2PVItNurm6m2jLQS/zDUwXkXbnKe5N0m16gNCyYgCJDEWHK4hlctWEOhd47VosptbeQji
	QPXIflT9xo8FfgS/aB/ByPqgw2u6YwWdww3WqUm8Fh4F2o4L8O7J82x7kcfAvu1+GNlLge
	FzegmnPyzmcLg3mOF9IN/cN5gkE4Bms=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-XeOVMZH1MKWk4a8eOwW16w-1; Wed, 02 Oct 2024 02:12:08 -0400
X-MC-Unique: XeOVMZH1MKWk4a8eOwW16w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8a9094c973so464442766b.2
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 23:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727849526; x=1728454326;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9J+MkZnqVn4PCVBLtkAGb5yev779UnAGvym9VWdz2E=;
        b=Ff01yOqWc3fTuIy8I8e2smeRkFZgtPqgrrKGX5i7lvy/9fd5EvspHbPhDti7wkcIBF
         aQo6ckvMA/ByC7IrGgIiwY+032AyNAgLfYaJmAFJF0qO13v7HlC/vh1hz2JAzFilaaCg
         hzlqrNowJsIb+myEFJhl63Dkt8bz9E8EuYn+gHDfpcTLtqM5LPSxr+uto1cfnqzSp+Sp
         UoeHzfrOHfRSrwb4pCm3pCukNYtF6ztqi5JWOJ+1EBabjIkukrE+HHjSglVWGaAvcMH+
         m+lHah4EoM727Lp+2NeRgaxLwA3kvlZPblQEOFCUIwH8XfdSef8IxYLIvfx+Tl/yBdhU
         5Nxg==
X-Forwarded-Encrypted: i=1; AJvYcCXyQ6WcqsI5Thf2A6/GgqSY5UA7y8PkwtfwsgZ7qo/rlyyA/Im6SbcUKMv/L0U3lsiuJi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrDA6dHYo+a0Al2isC4FPyRaQVPrK7BTmih5apejsCN33JmRrf
	SYXRGSdwEksYq87lWY9Dpr6SRwZtSGuvvQxqBIf4UDVsHQfnTgjH74Rq6UDzJ3x1lSFdKSYmpp3
	5zD57Pd58l5WybchFkhI/YervwX6beHYkbD7swa/EI9FBC1mI
X-Received: by 2002:a17:907:d29:b0:a7a:be06:d8eb with SMTP id a640c23a62f3a-a98f838781bmr195217066b.53.1727849526490;
        Tue, 01 Oct 2024 23:12:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSUaewyj5HE9D679zB0vk40H/KJ6GaMPH1tYMNv/mQoVB+bmCUzXsJhvQ/id1dZI171suNKA==
X-Received: by 2002:a17:907:d29:b0:a7a:be06:d8eb with SMTP id a640c23a62f3a-a98f838781bmr195214266b.53.1727849525976;
        Tue, 01 Oct 2024 23:12:05 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a990344ea09sm16046466b.66.2024.10.01.23.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 23:12:05 -0700 (PDT)
Message-ID: <c831b42e-30ba-4a19-bc0d-5346c8388892@redhat.com>
Date: Wed, 2 Oct 2024 08:12:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfuncs for read-only string
 operations
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
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
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzYt42A73kmg5=HWRiHj0H1Dr0WPQosmQLkBhgkkiw0HQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/1/24 19:40, Andrii Nakryiko wrote:
> On Tue, Oct 1, 2024 at 10:34 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, Oct 1, 2024 at 10:04 AM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>>
>>> On Tue, Oct 1, 2024 at 7:48 AM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> On Tue, Oct 1, 2024 at 4:26 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>>>
>>>>> On Mon, 2024-09-30 at 15:00 -0700, Andrii Nakryiko wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>> Right now, the only way to pass dynamically sized anything is through
>>>>>> dynptr, AFAIU.
>>>>>
>>>>> But we do have 'is_kfunc_arg_mem_size()' that checks for __sz suffix,
>>>>> e.g. used for bpf_copy_from_user_str():
>>>>>
>>>>> /**
>>>>>  * bpf_copy_from_user_str() - Copy a string from an unsafe user address
>>>>>  * @dst:             Destination address, in kernel space.  This buffer must be
>>>>>  *                   at least @dst__sz bytes long.
>>>>>  * @dst__sz:         Maximum number of bytes to copy, includes the trailing NUL.
>>>>>  * ...
>>>>>  */
>>>>> __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user *unsafe_ptr__ign, u64 flags)
>>>>>
>>>>> However, this suffix won't work for strnstr because of the arguments order.
>>>>
>>>> Stating the obvious... we don't need to keep the order exactly the same.
>>>>
>>>> Regarding all of these kfuncs... as Andrii pointed out 'const char *s'
>>>> means that the verifier will check that 's' points to a valid byte.
>>>> I think we can do a hybrid static + dynamic safety scheme here.
>>>> All of the kfunc signatures can stay the same, but we'd have to
>>>> open code all string helpers with __get_kernel_nofault() instead of
>>>> direct memory access.
>>>> Since the first byte is guaranteed to be valid by the verifier
>>>> we only need to make sure that the s+N bytes won't cause page faults
>>>
>>> You mean to just check that s[N-1] can be read? Given a large enough
>>> N, couldn't it be that some page between s[0] and s[N-1] still can be
>>> unmapped, defeating this check?
>>
>> Just checking s[0] and s[N-1] is not enough, obviously, and especially,
>> since the logic won't know where nul byte is, so N is unknown.
>> I meant to that all of str* kfuncs will be reading all bytes
>> via __get_kernel_nofault() until they find \0.
> 
> Ah, ok, I see what you mean now.
> 
>> It can be optimized to 8 byte access.
>> The open coding (aka copy-paste) is unfortunate, of course.
> 
> Yep, this sucks.

Yeah, that's quite annoying. I really wanted to avoid doing that. Also,
we won't be able to use arch-optimized versions of the functions.

Just to make sure I understand things correctly - can we do what Eduard
suggested and add explicit sizes for all arguments using the __sz
suffix? So something like:

    const char *bpf_strnstr(const char *s1, u32 s1__sz, const char *s2, u32 s2__sz);

Or that would still not be sufficient b/c the strings may still be
unsafe and we need an additional safety check (using
__get_kernel_nofault suggested by Alexei)?


