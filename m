Return-Path: <bpf+bounces-58310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E31AB8659
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268AB188A162
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 12:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9DC2989A0;
	Thu, 15 May 2025 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCbbWT4F"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7B9205AA8
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312057; cv=none; b=Jr64w3KySoSjXsaEz9Ikaz6FXDhTtK/CSDtyfOPC/1BnOKMI4l7tW8rQEGeczGQXblWJPE7YaQIebM3NH3DOm9O8O3kBUkr8lr9RlZcKTgmkyNNgHIuO3Um78cK634KPdQyCEIjTrCGawHP+IbCVpigTYz/sSGCpyjVdiETOw3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312057; c=relaxed/simple;
	bh=jDpkiNujAx1RziVYWcYWyYLExxjXoHObVqzxux3907U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zl5TxK8c1HpjxC8REJWWXEvA/LeFCYwSACO8pCjs8yiIwtb+vcAN3sNItpYR534fdSRY3QUrSGUKFlfK2QatJFAV6+XKifUgcmWXOvAL/ySySd/UNlnlwCbiGqAFv+PuMAkOCNwraAuQbhubt96EKWgGGvPvd7z7AfmSYika+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCbbWT4F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747312053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zIQ/UpQ6bpjB3xafAd+xZBstExpuagaVTgaWYliFwgI=;
	b=HCbbWT4FgKazaGvSWmAFsCAZICeK30h02uV7aokMsRBfZaZBu2+1/6CQ5WoDID0G89Ou4g
	wESPrBEiDauLxQkp7bVmDdyNSz5Kcpj0kRtcB6KbrRVJJlUixYMaYO/SePBtqrfsF66jpw
	+DwK0spf+oELA5pF4RT3MtU0EHhVe+k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-EFPWOtuwMPmNfJ9xw4Rztg-1; Thu, 15 May 2025 08:27:32 -0400
X-MC-Unique: EFPWOtuwMPmNfJ9xw4Rztg-1
X-Mimecast-MFC-AGG-ID: EFPWOtuwMPmNfJ9xw4Rztg_1747312051
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-442fa43e018so2639405e9.0
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 05:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747312051; x=1747916851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIQ/UpQ6bpjB3xafAd+xZBstExpuagaVTgaWYliFwgI=;
        b=Qhp50x5mq9cY3nVd7WPkbKsunEMh8MJFGN9BaUan+vEznHmPxKcHgBIEe7RxJSDcH5
         RTpNTCcMsHT7MlffP769U4fJlBjL4nHy6hr3W9w3XUGISCyr9RQK2SieSNTjqmA5rTSK
         HQqwjVm5k/+QJunim4LxBdQBhlXgoEOJk0V/FOqDFvSrl6XXla211Ldz2N/3mVFKeHHd
         zIfv2KetWvMeZzJtvCduWdQSm1U4r0IGUMrkAgNoTkpcidZ8Isrbmf19C6DNq+31J7id
         QtRIgA3F+Pcjm7YbTmEty3TpL2/IHQSKyG9PPd2x5D/MjR3RPxyNkEEq5HzE5ByRs0Vk
         1wHg==
X-Gm-Message-State: AOJu0YwTrYem/3wCMH+aIk+chaSDKs9djSMDfgnaHodHpOWRimkebsZx
	/lASyrT+5TYzq/tYxVvcZcdTpcj9e4zTH0F+6GMt3eymTLvwCVITvNmDN5AFzulQUzziXHlmEtx
	oGnHNxVcKwXLnRNH76K8lKthUc5y1VhlkRCdpBwZ7SlapTKb+
X-Gm-Gg: ASbGnct1ltAqx1nXTWQRQnTh4HGRz7AKwzlAWNrdbQfCODXDIO5RRPtuGMDeeM6mlM2
	J/CKcg45lzFcLlhZskZ5QR87fgKB0QZ209rBYfecwK1rdQySKuTsZlIpUFclM2Lp1z5C1ZPYGel
	ioEE1VuiPyrf1pmlXUiCOdhfrOR0rypsaea9TtM5Se3bd3jx2ryIz/GlP37XivCRWHsSphflOd1
	50+mXNsfASI3wjkrndntVXIwy/aIObEbNZLWwbInO/QlSfLsWqC+NrqqAg6J+GLEiSJzzJU1+03
	Qaz0L+a9VR7k/ljrQS87vKiAofDsMf5mIUPnvHRv6faC5w==
X-Received: by 2002:a5d:4851:0:b0:3a1:f724:eb15 with SMTP id ffacd0b85a97d-3a3511bbbf4mr2192501f8f.2.1747312050872;
        Thu, 15 May 2025 05:27:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFiGhjq9vP4eo0PFPpdYiM6fjDRoIlD4MLVlC1Xj2x0Phk1QBI3tG7lR0oRWdKL5ehLpLWXQ==
X-Received: by 2002:a5d:4851:0:b0:3a1:f724:eb15 with SMTP id ffacd0b85a97d-3a3511bbbf4mr2192462f8f.2.1747312050362;
        Thu, 15 May 2025 05:27:30 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3598fc192sm945000f8f.20.2025.05.15.05.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 05:27:29 -0700 (PDT)
Message-ID: <16d66553-e02d-4a13-aa54-50054aec3c98@redhat.com>
Date: Thu, 15 May 2025 14:27:28 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add kfuncs for read-only string
 operations
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1746598898.git.vmalik@redhat.com>
 <19913411da8c08170d959207e28262efc0a5d813.1746598898.git.vmalik@redhat.com>
 <CAEf4BzZBB3rD0gfxq3ZC0_RuBjXHBMqdXxw3DcEyuYhmh7n5HA@mail.gmail.com>
 <e1bb9c33b8852e1d3575f7cefe50aca266a8ff2b.camel@gmail.com>
 <CAEf4BzZ5x2JGcnZftf1KRiBziaz_On_mMtW77ArvnOyFNWh==Q@mail.gmail.com>
Content-Language: en-US
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <CAEf4BzZ5x2JGcnZftf1KRiBziaz_On_mMtW77ArvnOyFNWh==Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/10/25 00:03, Andrii Nakryiko wrote:
> On Fri, May 9, 2025 at 2:37 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> On Fri, 2025-05-09 at 11:20 -0700, Andrii Nakryiko wrote:
>>
>> [...]
>>
>>>> +/**
>>>> + * bpf_strchr - Find the first occurrence of a character in a string
>>>> + * @s: The string to be searched
>>>> + * @c: The character to search for
>>>> + *
>>>> + * Note that the %NUL-terminator is considered part of the string, and can
>>>> + * be searched for.
>>>> + *
>>>> + * Return:
>>>> + * * const char * - Pointer to the first occurrence of @c within @s
>>>> + * * %NULL        - @c not found in @s
>>>> + * * %-EFAULT     - Cannot read @s
>>>> + * * %-E2BIG      - @s too large
>>>> + */
>>>> +__bpf_kfunc const char *bpf_strchr(const char *s, char c)
>>>
>>> so let's say we found the character, we return a pointer to it, and
>>> that memory goes away (because we never owned it, so we don't really
>>> know what and when will happen with it). Question, will verifier allow
>>> BPF program to dereference this pointer? If yes, that's a problem. But
>>> if not, then I'm not sure there is much point in returning a pointer.

You are right, at the moment, the verifier marks the returned pointers
as `rdonly_mem_or_null` so an attempt to dereference them will result
into a verifier error. Which is clearly not very useful.

I'd say that, theoretically, the pointers returned from these kfuncs
should be treated by the verifier in the same way as the passed
pointers. That is, if PTR_TO_MAP_VALUE is passed,
PTR_TO_MAP_VALUE_OR_NULL should be returned, and so on.

>>> I'm just trying to imply that in BPF world integer-based APIs work
>>> better/safer, overall? For strings, we can switch any
>>> pointer-returning API to position-returning (or negative error) API
>>> and it would more or less naturally fit into BPF API surface, no?
>>
>> Integer based API solves the problem with memory access but is not
>> really ergonomic. W/o special logic in verifier the returned int would
>> be unbounded, hence the user would have to compare it with string
>> length before using.
>>
>> It looks like some verifier logic is necessary regardless of API being
>> integer or pointer based. In any case verifier needs additional rules
>> for each pointer type to adjust bounds on the return value or its refobj_id.

IMO the problem here is that we can't just say anything about the
returned pointer (or index) rather than it is within the bounds of the
original string (or within the passed size for bounded kfuncs). So, any
access to that pointer with an offset other than 0 will still need an
explicit bounds check.

> You can't safely dereference any pointer returned from these APIs,
> because the memory might not be there anymore.

You can't if the memory comes from an untrusted source. But what if the
memory is owned by the BPF program (e.g. on stack or in a map)? Then, it
should be possible to dereference it safely, shouldn't it? IMHO, this
would be quite a common use-case: read string into BPF memory using
bpf_probe_read_str -> use string kfunc to search it -> do something with
the returned pointer (dereference it). From ergonomics perspective, it
shouldn't be necessary to use bpf_probe_read or __get_kernel_nofault
again.

> For integers, same idea. If you use bpf_probe_read_{kernel,user} to
> read data, then verifier doesn't care about the value of integer.
> 
> But that's not ergonomic, so in some other thread few days ago I was
> proposing that we should add an untyped counterpart to bpf_core_cast()
> that would just make any memory accesses performed using
> __get_kernel_nofault() semantics. And so then:
> 
> 
> const char *str = <random value or we got it from somewhere untrusted>;
> int space_idx = bpf_strchr(str, ' ');
> if (space_idx < 0)
>   return -1; /* bad luck */
> 
> const char *s = bpf_mem_cast(str);
> char buf[64] = {};
> 
> bpf_for(i, 0, space_idx)
>     buf[i] = s[i]; /* MAGIC */
> 
> bpf_printk("STUFF BEFORE SPACE: %s", buf);

I can imagine that this would be a nice helper for accessing untrusted
memory in general but I don't think it's specific to string kfuncs. At
the moment, reading an untrusted string requires bpf_probe_read_str so
calling it after processing the string via a kfunc doesn't introduce any
extra call.

BTW note that at the moment, the kfuncs do not accept strings from
untrusted sources as the verifier doesn't know how to treat `char *`
kfunc args and treats them as scalars (which are incompatible with other
pointers). Here, changing also the kfunc args to ints would probably
help, although I think that it would not be ergonomic at all. So, we
still need some verifier work to handle `char *` args to kfuncs.

> Tbh, when dealing with libc string APIs, I still very frequently
> convert resulting pointers into indices, so I don't think it's
> actually an API regression to have index-based string APIs

I agree here. In addition, it looks to me that returning pointers would
require extra verifier work while returning indices would not. And we
still need to apply extra bounds checks or access helpers in a majority
of use-cases so we don't loose much ergonomics with integer-based APIs.


