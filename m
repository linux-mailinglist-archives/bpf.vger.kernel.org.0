Return-Path: <bpf+bounces-40810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3D298E937
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 06:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B083A1C223C1
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 04:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5EC3FB31;
	Thu,  3 Oct 2024 04:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1PQcZSH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689AFBA49
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 04:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727931089; cv=none; b=UtnD1F+P8PPO66yBp39dleWPYlEmFH9h8VPPJN0+E5oYbJVHGSfB/VjMNhRn3YfnMahutHrnAnNiBu2GygE5GH8lvrS5eGS0IiFfY1iDOQws695vftgXiTKTyKx4bVW0dxZnYay78xvJF1sqnZhD+f/T1vBEvXxwtHqwQ4P6pU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727931089; c=relaxed/simple;
	bh=hPPyUccLiTCCIJr4tp3ulm/6Rz5EA/cFmioBfTPp7d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnOmr5LVAOzW9BpwNfALe5DN0XgdHWVO+e40E9r0o2fxqUyCrD7IrKRb51l4v5rLQhHl2+7AUTmdHJ8EZpWVc24ZdXYyDEvYoRmT+Ddz/tbaAxn3Z2HZzv2ne7RmJQ0EB47pEZr/8Z/ZUBtDdpWCli8BvFyGALgcG7R/vkpO2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1PQcZSH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727931086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWUNTLS92RYFrRb4mZe3jVY99KEqimrh0yZ1sGGxzBU=;
	b=W1PQcZSHk02F/msXtX+NH/6lNNQhOMm0ZTFvG+Wzgcbrt3K1UescAMA9NPkJC+3eIItNnm
	C1SgOfl40FShpK3ZxLM47FO9p81t+3H3EeGQ9PkK2ekeO5VcJWWv9FM4keC+VddGBWyTex
	DDRq+L8BeBWV6XWAXCOEM+e1zXquCtA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-fjGD6S15P9SznwghMmistw-1; Thu, 03 Oct 2024 00:51:25 -0400
X-MC-Unique: fjGD6S15P9SznwghMmistw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb2c5d634so2472815e9.0
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 21:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727931084; x=1728535884;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWUNTLS92RYFrRb4mZe3jVY99KEqimrh0yZ1sGGxzBU=;
        b=cFYxBj/K3/hE8UGl7h9EOtH92o7kpzPfJ94jrHiZkcf4Lutthxznk2YxSrp3PDAD9K
         YWpwxqyVe+dcXyFgKTJ6bVEOwlOUbjSlk7HY1XqoWjyG855lZnBte8vzhpHNP6OTQdO7
         Ne17F3AVmUEkcigxFNRKlnbqytosz/o0IVDOivsHXZm2HAG4/c2iwlWRLutbZuivrHOp
         HbQvhwpGx7IRkcObIvlT+SfrclVLgHPiB1/lJnAFUG8+bbL72dt5KJwGKJ8N54Ig2zum
         2qWkohesVYC5ISvD9obmsVMNTi1yoEsJ3bPHl7y34jqim0eMtcTGy/k5mDrkzjjRp80d
         4knQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZso+23I3s5UsX7m/ocZIj+qy5A6HJQx9n4cXialM1qSun7z4SwxhwADpCFmabxYDmMNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG83yGrWnAXnrZmtncmKZ/bMkUwUzqs1RS3OrbmBn+7wKinD/e
	j0e0UjmUluO7lyQQrjK7YriBG9kwlOk2kuCcHJt5ozPBfX31UAkiq7YUq0ffZdt/eMYKzgvmeb8
	TeWx1cP83SPNY3aPB0b8dhughWetMJJjDOYvyTzG8dZWMM/9x
X-Received: by 2002:a05:600c:1f0f:b0:42c:b22e:fbfa with SMTP id 5b1f17b1804b1-42f819ff766mr460915e9.21.1727931083857;
        Wed, 02 Oct 2024 21:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWmlfAT+WefmfbJTHZinJAa2tf2UkgSZINsY/zEk04RxX42Rr6iHbc2j4WKOBn603JwS6soA==
X-Received: by 2002:a05:600c:1f0f:b0:42c:b22e:fbfa with SMTP id 5b1f17b1804b1-42f819ff766mr460785e9.21.1727931083489;
        Wed, 02 Oct 2024 21:51:23 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d081f749asm377911f8f.9.2024.10.02.21.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 21:51:22 -0700 (PDT)
Message-ID: <e4bfbee4-ca5f-4496-98ed-60d24e402046@redhat.com>
Date: Thu, 3 Oct 2024 06:51:20 +0200
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
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQLhr+xOF58ppaySOjb6cMdsWEYhr_4ZLvQ-XDWXHBMgBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/2/24 18:55, Alexei Starovoitov wrote:
> On Tue, Oct 1, 2024 at 11:12 PM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> On 10/1/24 19:40, Andrii Nakryiko wrote:
>>> On Tue, Oct 1, 2024 at 10:34 AM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> On Tue, Oct 1, 2024 at 10:04 AM Andrii Nakryiko
>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>
>>>>> On Tue, Oct 1, 2024 at 7:48 AM Alexei Starovoitov
>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>
>>>>>> On Tue, Oct 1, 2024 at 4:26 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>>>>>
>>>>>>> On Mon, 2024-09-30 at 15:00 -0700, Andrii Nakryiko wrote:
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>> Right now, the only way to pass dynamically sized anything is through
>>>>>>>> dynptr, AFAIU.
>>>>>>>
>>>>>>> But we do have 'is_kfunc_arg_mem_size()' that checks for __sz suffix,
>>>>>>> e.g. used for bpf_copy_from_user_str():
>>>>>>>
>>>>>>> /**
>>>>>>>  * bpf_copy_from_user_str() - Copy a string from an unsafe user address
>>>>>>>  * @dst:             Destination address, in kernel space.  This buffer must be
>>>>>>>  *                   at least @dst__sz bytes long.
>>>>>>>  * @dst__sz:         Maximum number of bytes to copy, includes the trailing NUL.
>>>>>>>  * ...
>>>>>>>  */
>>>>>>> __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user *unsafe_ptr__ign, u64 flags)
>>>>>>>
>>>>>>> However, this suffix won't work for strnstr because of the arguments order.
>>>>>>
>>>>>> Stating the obvious... we don't need to keep the order exactly the same.
>>>>>>
>>>>>> Regarding all of these kfuncs... as Andrii pointed out 'const char *s'
>>>>>> means that the verifier will check that 's' points to a valid byte.
>>>>>> I think we can do a hybrid static + dynamic safety scheme here.
>>>>>> All of the kfunc signatures can stay the same, but we'd have to
>>>>>> open code all string helpers with __get_kernel_nofault() instead of
>>>>>> direct memory access.
>>>>>> Since the first byte is guaranteed to be valid by the verifier
>>>>>> we only need to make sure that the s+N bytes won't cause page faults
>>>>>
>>>>> You mean to just check that s[N-1] can be read? Given a large enough
>>>>> N, couldn't it be that some page between s[0] and s[N-1] still can be
>>>>> unmapped, defeating this check?
>>>>
>>>> Just checking s[0] and s[N-1] is not enough, obviously, and especially,
>>>> since the logic won't know where nul byte is, so N is unknown.
>>>> I meant to that all of str* kfuncs will be reading all bytes
>>>> via __get_kernel_nofault() until they find \0.
>>>
>>> Ah, ok, I see what you mean now.
>>>
>>>> It can be optimized to 8 byte access.
>>>> The open coding (aka copy-paste) is unfortunate, of course.
>>>
>>> Yep, this sucks.
>>
>> Yeah, that's quite annoying. I really wanted to avoid doing that. Also,
>> we won't be able to use arch-optimized versions of the functions.
>>
>> Just to make sure I understand things correctly - can we do what Eduard
>> suggested and add explicit sizes for all arguments using the __sz
>> suffix? So something like:
>>
>>     const char *bpf_strnstr(const char *s1, u32 s1__sz, const char *s2, u32 s2__sz);
> 
> That's ok-ish, but you probably want:
> 
> const char *bpf_strnstr(void *s1, u32 s1__sz, void *s2, u32 s2__sz);
> 
> and then to call strnstr() you still need to strnlen(s2, s2__sz).
> 
> But a more general question... how always passing size will work
> for bpftrace ? Does it always know the upper bound of storage where
> strings are stored?

Yes, it does. The strings must be read via the str() call (which
internally calls bpf_probe_read_str) and there's an upper bound on the
size of each string.

> I would think __get_kernel_nofault() approach is user friendlier.

That's probably true but isn't there still the problem that strings are
not necessarily null-terminated? And in such case, unbounded string
functions may not terminate which is not allowed in BPF?


