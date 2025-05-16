Return-Path: <bpf+bounces-58377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD99AB95B8
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 07:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4504A37F9
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 05:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABAD221F16;
	Fri, 16 May 2025 05:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5b5hXYQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4AB139E
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 05:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747375180; cv=none; b=ik9Dqs+HqaQOCyP2bmzX8ag42Rj9oyxThTjysh0OV7qjjqB4VhsHJydQuG0CbGaG8Kt79DjZzD22H2Fqs6fgmhaI2kTv5ghGfgJlXBF7cQq5KvgYHv9bg16Qxr4P/7Q8K33NZkt+wZX0kKHgcybbM0cEkdb2Qzf7l9VwdKiNwD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747375180; c=relaxed/simple;
	bh=2mlNLAfn4pv5oLYRYUstb6dLBa694b5ssU3KHtvqvMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXXA2gt5haYUVywOfZJXmNmsAfwk74rRy4pq+GgnNetTMMx0dDJKC9/DhqtK4bO+IMpiarbP8oPdrUW5ittl6ZYlByS1dukOhuda+CPrDw/gak+Xexev/ckhwe1DIHHdMAFkX5Msi/bKnz/kSsY9q+Hbh8n3G2Tg2cwtDAXwh48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5b5hXYQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747375177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nlnj4yTXVUJBFOfUId8uG6BaIAm8qQej/HKzwAKfdM=;
	b=Y5b5hXYQPPs7FDkTaE1srQECxg80ZPbM/Qt1EzWiM3rPc5cStirqVggbOK6wzcn3DQgUUB
	yKO1DCYQC97pFEzk5PLbyKIxJeXcBBO8vxh/n7ok8BD39yx0oTgj8IeDGUTkTeDSNorWLA
	YAUGKpnMAZ3R1JvO0YFcvoSyi6pmCwE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-XitueB3vPOK0PQx-kTMnBw-1; Fri, 16 May 2025 01:59:35 -0400
X-MC-Unique: XitueB3vPOK0PQx-kTMnBw-1
X-Mimecast-MFC-AGG-ID: XitueB3vPOK0PQx-kTMnBw_1747375174
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43eed325461so9321435e9.3
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 22:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747375174; x=1747979974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nlnj4yTXVUJBFOfUId8uG6BaIAm8qQej/HKzwAKfdM=;
        b=K+wjvfEhnlN18rxulY7pzEKQyry4bAD6t7dOd+O3NAyFMz590HkoTo68IdRl9kVn5s
         XfwlYRXIvu1mLU4I+t4V9DgCD0OEzC+AhlGGE1+uU0WvYydbHIOtKd5UftZLcJbnM9+1
         GdXTnT5eTWlGDxrMvjLOqCTPqs76zx/UN1tqquOoDJY6EBC6fVerBx1EJ1gmmWGGDJgC
         UUeCtbPeBwBHS5MOe7ldTCjsxWGoGVT2Rdlnzc25/T5nF9NDMJYUGRNRDMYe5UNkGr93
         1CQ8HAwxtMoxlR2Uf1qs5F7xjrAL3RjLbEaMLWhSym7y5ryV1oklT5scXLtggdrAQ+FK
         u/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVjJVA0aYdAwgSDFrE02nFScP+GtA7ELSaOJxVRIa+/yhLp5e8f4Bd4kRW7n8C7yn9XRfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtCtTnUfeeQSsK5EFX+kifkByZOIHjWRreo7kGmpmP6guH1nWf
	dTcD9jNLXyMVRC2Nkkxc854f0rF+0wBam1Ldnj/Er7UPoHh8iI/bw1CoW+WbXrLSfbeadmSixNo
	S1Dbwzs1APNN2/uhJGi3+/WyBQOasImMenBDnFWE04F4Ulotj3YAJ
X-Gm-Gg: ASbGnctOFfBn4vKw4Qg2DOQ95illxX1bC6URuRZ+Kh/dLh7FIIVu4Hyx1/VL+WUjNZF
	/1JP6GYpwEWy8FKoA8zRbB6xGO+EUymkupq06dY4w7wEhmgon4xHzMiM+1OFKOdcxZZnodirKlp
	CZwye02g1vfunBlXMjlFh9heKOLOMGw8l3DJcbQn+G3z7bGNBHOhnaI7LyIyHE9qxL4XDlkOqCf
	nTZQpSlt6AlvlEQ6ns95WMVHMii/K7yohgosdRtDNz3vP8cQrrPiAX5Fe6VEXiSwp5DSLKiyB0o
	b8knROh1JD5vix+fF4Xb6keGnPaW6SlVM1JMFaTJNvpejg==
X-Received: by 2002:a05:600c:3acf:b0:442:f4a3:9388 with SMTP id 5b1f17b1804b1-442ff000ba0mr8903665e9.19.1747375174238;
        Thu, 15 May 2025 22:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF48IsL3elvTRz1NesvE3lpATQvEyIHSSKVa9+qGhTcG4cavopU8bx743MHcLOjG/or4jMzCw==
X-Received: by 2002:a05:600c:3acf:b0:442:f4a3:9388 with SMTP id 5b1f17b1804b1-442ff000ba0mr8903495e9.19.1747375173843;
        Thu, 15 May 2025 22:59:33 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd4fdbaesm21459405e9.7.2025.05.15.22.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 22:59:33 -0700 (PDT)
Message-ID: <71eb7443-18ce-4bf6-8371-a55a0016c6c1@redhat.com>
Date: Fri, 16 May 2025 07:59:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add kfuncs for read-only string
 operations
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1746598898.git.vmalik@redhat.com>
 <19913411da8c08170d959207e28262efc0a5d813.1746598898.git.vmalik@redhat.com>
 <CAEf4BzZBB3rD0gfxq3ZC0_RuBjXHBMqdXxw3DcEyuYhmh7n5HA@mail.gmail.com>
 <e1bb9c33b8852e1d3575f7cefe50aca266a8ff2b.camel@gmail.com>
 <CAEf4BzZ5x2JGcnZftf1KRiBziaz_On_mMtW77ArvnOyFNWh==Q@mail.gmail.com>
 <16d66553-e02d-4a13-aa54-50054aec3c98@redhat.com>
 <CAEf4BzbRiwivpVY4X29aq5txGP1UtpiGkjz=J0vLyvBO-Hw8Xw@mail.gmail.com>
Content-Language: en-US
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <CAEf4BzbRiwivpVY4X29aq5txGP1UtpiGkjz=J0vLyvBO-Hw8Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/15/25 19:17, Andrii Nakryiko wrote:
> On Thu, May 15, 2025 at 5:27 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> On 5/10/25 00:03, Andrii Nakryiko wrote:
>>> On Fri, May 9, 2025 at 2:37 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>>
>>>> On Fri, 2025-05-09 at 11:20 -0700, Andrii Nakryiko wrote:
>>>>
>>>> [...]
>>>>
>>>>>> +/**
>>>>>> + * bpf_strchr - Find the first occurrence of a character in a string
>>>>>> + * @s: The string to be searched
>>>>>> + * @c: The character to search for
>>>>>> + *
>>>>>> + * Note that the %NUL-terminator is considered part of the string, and can
>>>>>> + * be searched for.
>>>>>> + *
>>>>>> + * Return:
>>>>>> + * * const char * - Pointer to the first occurrence of @c within @s
>>>>>> + * * %NULL        - @c not found in @s
>>>>>> + * * %-EFAULT     - Cannot read @s
>>>>>> + * * %-E2BIG      - @s too large
>>>>>> + */
>>>>>> +__bpf_kfunc const char *bpf_strchr(const char *s, char c)
>>>>>
>>>>> so let's say we found the character, we return a pointer to it, and
>>>>> that memory goes away (because we never owned it, so we don't really
>>>>> know what and when will happen with it). Question, will verifier allow
>>>>> BPF program to dereference this pointer? If yes, that's a problem. But
>>>>> if not, then I'm not sure there is much point in returning a pointer.
>>
>> You are right, at the moment, the verifier marks the returned pointers
>> as `rdonly_mem_or_null` so an attempt to dereference them will result
>> into a verifier error. Which is clearly not very useful.
>>
>> I'd say that, theoretically, the pointers returned from these kfuncs
>> should be treated by the verifier in the same way as the passed
>> pointers. That is, if PTR_TO_MAP_VALUE is passed,
>> PTR_TO_MAP_VALUE_OR_NULL should be returned, and so on.
>>
>>>>> I'm just trying to imply that in BPF world integer-based APIs work
>>>>> better/safer, overall? For strings, we can switch any
>>>>> pointer-returning API to position-returning (or negative error) API
>>>>> and it would more or less naturally fit into BPF API surface, no?
>>>>
>>>> Integer based API solves the problem with memory access but is not
>>>> really ergonomic. W/o special logic in verifier the returned int would
>>>> be unbounded, hence the user would have to compare it with string
>>>> length before using.
>>>>
>>>> It looks like some verifier logic is necessary regardless of API being
>>>> integer or pointer based. In any case verifier needs additional rules
>>>> for each pointer type to adjust bounds on the return value or its refobj_id.
>>
>> IMO the problem here is that we can't just say anything about the
>> returned pointer (or index) rather than it is within the bounds of the
>> original string (or within the passed size for bounded kfuncs). So, any
>> access to that pointer with an offset other than 0 will still need an
>> explicit bounds check.
> 
> Exactly.
> 
>>
>>> You can't safely dereference any pointer returned from these APIs,
>>> because the memory might not be there anymore.
>>
>> You can't if the memory comes from an untrusted source. But what if the
>> memory is owned by the BPF program (e.g. on stack or in a map)? Then, it
>> should be possible to dereference it safely, shouldn't it? IMHO, this
>> would be quite a common use-case: read string into BPF memory using
>> bpf_probe_read_str -> use string kfunc to search it -> do something with
>> the returned pointer (dereference it). From ergonomics perspective, it
>> shouldn't be necessary to use bpf_probe_read or __get_kernel_nofault
>> again.
> 
> For bpf_probe_read_str -> use kfunc scenario, I thought the main
> *goal* is to avoid the bpf_probe_read_str operation altogether. That's
> why we allow unsafe pointers passed into those kfuncs you are adding
> and why we use __get_kernel_nofault internally.

My original use-case (for bpftrace) was pure ergonimics - we typically
have a string on stack or in a map and instead of writing the string
operation by hand, we could use a pre-defined kfunc. But your suggested
use-case is probably even more valuable.

> So with that, you'd actually just use, say, bpf_strchr(), get back
> some pointer or index, calculate substring (prefix) length, and *then*
> maybe bpf_probe_read_str into ringbuf or local buffer, if you'd like
> to capture the data and do some post processing.

Agreed. The great strength I can see in this is that in many cases, you
don't need the follow-up bpf_probe_read_str at all - getting the length
of the (sub)string, testing for substring or character inclusion, etc.

>>
>>> For integers, same idea. If you use bpf_probe_read_{kernel,user} to
>>> read data, then verifier doesn't care about the value of integer.
>>>
>>> But that's not ergonomic, so in some other thread few days ago I was
>>> proposing that we should add an untyped counterpart to bpf_core_cast()
>>> that would just make any memory accesses performed using
>>> __get_kernel_nofault() semantics. And so then:
>>>
>>>
>>> const char *str = <random value or we got it from somewhere untrusted>;
>>> int space_idx = bpf_strchr(str, ' ');
>>> if (space_idx < 0)
>>>   return -1; /* bad luck */
>>>
>>> const char *s = bpf_mem_cast(str);
>>> char buf[64] = {};
>>>
>>> bpf_for(i, 0, space_idx)
>>>     buf[i] = s[i]; /* MAGIC */
>>>
>>> bpf_printk("STUFF BEFORE SPACE: %s", buf);
>>
>> I can imagine that this would be a nice helper for accessing untrusted
>> memory in general but I don't think it's specific to string kfuncs. At
>> the moment, reading an untrusted string requires bpf_probe_read_str so
>> calling it after processing the string via a kfunc doesn't introduce any
>> extra call.
> 
> I might be confused, see above. My impression was that with your
> functions we won't need bpf_probe_read_str() and that was the whole
> point of your __get_kernel_nofault-based reimplementation. If not for
> that, we'd use trusted memory pointers and just used internal kernel
> strings, knowing that we are working with MAP_VALUE or PTR_TO_STACK of
> well-bounded size.
> 
> Then again, see what I wrote above. I imagine that the user would not
> do bpf_probe_read_str() at all. I'll do bpf_strchr(), followed by
> bpf_memcast(), followed by iterating from 0 to the index returned from
> bpf_strchr(), if I need to process the substring.

Yeah, I can see value in that although I'm not sure what's the
difference between bpf_mem_cast and bpf_probe_read_str since they both
use __get_kernel_nofault under the hood. Just ergonomics and the fact
that bpf_mem_cast doesn't need a buffer? Also, shouldn't the
dereferences after bpf_mem_cast be called under pagefault_disable?

>> BTW note that at the moment, the kfuncs do not accept strings from
>> untrusted sources as the verifier doesn't know how to treat `char *`
>> kfunc args and treats them as scalars (which are incompatible with other
>> pointers). Here, changing also the kfunc args to ints would probably
>> help, although I think that it would not be ergonomic at all. So, we
>> still need some verifier work to handle `char *` args to kfuncs.
> 
> Ok, so that's probably the missing piece. We need to teach verifiers
> to allow such untrusted pointers. I thought that was the whole idea
> behind adding these APIs: to allow such usage.

Yes, I'll look into that. Do you want to merge everything together or
should I post the updated (likely int-based) kfuncs in the meantime as
they are useful for trusted pointers as well?

Viktor

>>
>>> Tbh, when dealing with libc string APIs, I still very frequently
>>> convert resulting pointers into indices, so I don't think it's
>>> actually an API regression to have index-based string APIs
>>
>> I agree here. In addition, it looks to me that returning pointers would
>> require extra verifier work while returning indices would not. And we
>> still need to apply extra bounds checks or access helpers in a majority
>> of use-cases so we don't loose much ergonomics with integer-based APIs.
>>
> 
> +1
> 


