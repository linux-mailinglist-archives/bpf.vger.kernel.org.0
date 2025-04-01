Return-Path: <bpf+bounces-55075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3316DA77B4E
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 14:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1263AF8AA
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 12:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463272036EB;
	Tue,  1 Apr 2025 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AraMp1NA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84CD202F9C
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511718; cv=none; b=BxgHQzyJufWLtRO9qnUeKM6gF28fwuhDqF+7ew3pH5iYQ9+fONwiyQa0F6NonPKhnm2KFqBb7V5Oa+SG+7dp9eVqqB9m+80HyXHe1W7SVaoLqf4H1YkJh834Bahs+Vh2T16Vx9FGcFRdcErRf07fDoEs6+sk8LI1F4ulvnuG9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511718; c=relaxed/simple;
	bh=EAKRwdn4+FM9XnoM9eGcIFUMa50DI0YwcOPL64j5vpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQO+UT0wqKLFp7aGyE/dAczX+q6cBZMKyt3HkAhBFF9inAq8ML67h/SaeaAQrlmWYAHad4qFyniBbafiSjs+stl08x4sZAqQQ+237fSgbW/kmU8k5dthxJUQs2v6E1p4SeE0Hnv69isw4Yj7GcPjeV2QeXin2JR+TggjTFsibY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AraMp1NA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743511715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7HmGPHcPB/PhAE+BkrpQ0uQP7q8tlgRmANLq4k6DPc=;
	b=AraMp1NA6kfKVXC/odrgxs2GuGiT4lhab9AfVL82cOxGnM6SOgPvI6MwRgpv3zuRu2Dl2L
	r0llUa8g0+MMbjbOf2koHemlFGP12DPSyXqf9rR3V4/bbiVD9KnVHuEB5+zRLbm1OiLRO7
	hwQsqJYXNfwFkTh3sCN8MzytXYLGPwo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-MhR14alUOlmThzxORUbh6g-1; Tue, 01 Apr 2025 08:48:34 -0400
X-MC-Unique: MhR14alUOlmThzxORUbh6g-1
X-Mimecast-MFC-AGG-ID: MhR14alUOlmThzxORUbh6g_1743511713
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac6a0443bafso509831966b.2
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 05:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743511713; x=1744116513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7HmGPHcPB/PhAE+BkrpQ0uQP7q8tlgRmANLq4k6DPc=;
        b=jHHUsxwXap8Ke8mL7IlNmqh5qvOSqbd5qsuOuPtL/+EJ6q6mqUnMMb6Cr7T5eitKBi
         SYeMdpgTRi/3eMdd5bsVhDsN7B5SQIxdS8tR9SQlxpmxEUvMYS+rh5r9T4TAn9ZJXvG9
         nF6xZH/Cm3XJYdaz/0M7ncg/i3jGmtBSsCT56XUON2HynJMIxjiA2QlK6GJbrEiYSla7
         2homHql9XF242MULLxSs/XSIKjEpgqkNcFvLDW8oqx0bHJ50j5uGuVMlLdOxyg9/vtah
         lryKIP2Y3kssz7Ncvx9b21Z+KTOFDG5g79AhuBfFDBS/+4omlkv7wQp2iBLpRlAktcK/
         U+Ig==
X-Gm-Message-State: AOJu0YxrrVV78AHnc1s86SFqv015pyCwbd3QF5Ft6cQmEofjZJwaoa2z
	IPTCZYAdYtbXt7nWogZd8eowPcs42zuexehApm1cbTX7rnPTd1MzXMubKoEfDLpovVilwXfwDqT
	Xd/cqeAEeL0OcPQkubfPQx+i7oUFaIFEwPhsXeKNbFX4T8biA
X-Gm-Gg: ASbGncv/98lpVqJ/Sb+UlxJ1t5DrPRzdn/gHOAHZyJCsCUcyWzr1t1SU83aQrTuEj8A
	1gz8SvdnTFAADVr3ydUIPaCvxvNS26/0+QRcXPynvZrRqwVQKozSNO6EkdryURn16K6Yc99PnqK
	DrAPZu81UcUpp5EO7JkJXoTERZ/3JU1OUGyYgAzDIEzog26NF3Hcw1SdEnF73fN/VwbodzRBq9b
	g3syy0MHHCh3ojWVDk1d2uoIHXpeqEBwsvHoMNSSXG6IOq6YqTycqk9VIQjlqewqZtmYM1cIg3o
	YEKAws2H/Bc/BYaCArM=
X-Received: by 2002:a17:907:2d25:b0:ac4:2ae:c970 with SMTP id a640c23a62f3a-ac782b64cd9mr257184766b.21.1743511712813;
        Tue, 01 Apr 2025 05:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPYJZbsgfzwyfQQ27s4XSxIo8scA0udRwHCxZpgjv3vPpznjsH4UyUS39Ci4nosjzxNgVuwQ==
X-Received: by 2002:a17:907:2d25:b0:ac4:2ae:c970 with SMTP id a640c23a62f3a-ac782b64cd9mr257178966b.21.1743511712189;
        Tue, 01 Apr 2025 05:48:32 -0700 (PDT)
Received: from ?IPV6:2001:67c:1220:a14::1019? ([2001:67c:1220:a14::1019])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7192e7d6dsm755314066b.74.2025.04.01.05.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 05:48:31 -0700 (PDT)
Message-ID: <317d7c59-a8aa-45ca-a6ab-3b602ac360ed@redhat.com>
Date: Tue, 1 Apr 2025 14:48:30 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Add kfuncs for read-only string
 operations
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>
References: <cover.1741874348.git.vmalik@redhat.com>
 <4e26ca57634db305a622b010b0d86dbb36b09c37.1741874348.git.vmalik@redhat.com>
 <CAEf4BzYTJh06kqR9hL=TvfBTRNskZMCPTAmcD7=nMFJrqR1OSA@mail.gmail.com>
Content-Language: en-US
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <CAEf4BzYTJh06kqR9hL=TvfBTRNskZMCPTAmcD7=nMFJrqR1OSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/28/25 23:48, Andrii Nakryiko wrote:
> On Mon, Mar 24, 2025 at 5:04 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> String operations are commonly used so this exposes the most common ones
>> to BPF programs. For now, we limit ourselves to operations which do not
>> copy memory around.
>>
>> Unfortunately, most in-kernel implementations assume that strings are
>> %NUL-terminated, which is not necessarily true, and therefore we cannot
>> use them directly in BPF context. So, we use distinct approaches for
>> bounded and unbounded variants of string operations:
>>
>> - Unbounded variants are open-coded with using __get_kernel_nofault
>>   instead of plain dereference to make them safe.
>>
>> - Bounded variants use params with the __sz suffix so safety is assured
>>   by the verifier and we can use the in-kernel (potentially optimized)
>>   functions.
>>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  kernel/bpf/helpers.c | 299 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 299 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 5449756ba102..6f6af4289cd0 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0-only
>>  /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
>>   */
>> +#include "linux/uaccess.h"
> 
> <> should be used?

Yes.

> 
>>  #include <linux/bpf.h>
>>  #include <linux/btf.h>
>>  #include <linux/bpf-cgroup.h>
>> @@ -3193,6 +3194,291 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
>>         local_irq_restore(*flags__irq_flag);
>>  }
>>
>> +/* Kfuncs for string operations.
>> + *
>> + * Since strings are not necessarily %NUL-terminated, we cannot directly call
>> + * in-kernel implementations. Instead, unbounded variants are open-coded with
>> + * using __get_kernel_nofault instead of plain dereference to make them safe.
>> + * Bounded variants use params with the __sz suffix so safety is assured by the
>> + * verifier and we can use the in-kernel (potentially optimized) functions.
>> + */
>> +
>> +/**
>> + * bpf_strcmp - Compare two strings
>> + * @cs: One string
>> + * @ct: Another string
>> + */
>> +__bpf_kfunc int bpf_strcmp(const char *cs, const char *ct)
>> +{
>> +       int i = 0, ret = 0;
>> +       char c1, c2;
>> +
>> +       pagefault_disable();
>> +       while (i++ < XATTR_SIZE_MAX) {
>> +               __get_kernel_nofault(&c1, cs++, char, cs_out);
>> +               __get_kernel_nofault(&c2, ct++, char, ct_out);
> 
> nit: should we avoid passing increment statements into macro? It's
> succinct and all, but we lose nothing by having cs++; ct++; at the end
> of while loop, no?

That's probably a good idea. It shouldn't be a problem having those
increments at the end of the loop so let me update it.

> 
>> +               if (c1 != c2) {
>> +                       ret = c1 < c2 ? -1 : 1;
>> +                       goto out;
>> +               }
>> +               if (!c1)
>> +                       goto out;
>> +       }
>> +cs_out:
>> +       ret = -1;
>> +       goto out;
>> +ct_out:
>> +       ret = 1;
>> +out:
>> +       pagefault_enable();
>> +       return ret;
>> +}
> 
> Given valid values are only -1, 0, and 1, should we return -EFAULT
> when one or the other string can't be fetched?
> 
> Yes, users that don't care will treat -EFAULT as the first string is
> smaller than the second, but that's what you have anyways. But having
> -EFAULT is still useful, IMO. We can also return -E2BIG if we reach i
> == XATTR_SIZE_MAX situation, no?

I was a bit hesitant to make the semantics of bpf_strcmp different from
strcmp. But the truth is that returning errors here may bring some value
so if people are ok with that, I have no problem implementing your
proposal.

But in such a case, I'd suggest that we do the same for the rest of the
string kfuncs, too. That is, return -EINVAL if __get_kernel_nofault
fails and -E2BIG if the string is longer than XATTR_SIZE_MAX, possibly
wrapped in PTR_ERR when the kfunc returns a pointer. What do you think?

> 
>> +
>> +/**
>> + * bpf_strchr - Find the first occurrence of a character in a string
>> + * @s: The string to be searched
>> + * @c: The character to search for
>> + *
>> + * Note that the %NUL-terminator is considered part of the string, and can
>> + * be searched for.
>> + */
>> +__bpf_kfunc char *bpf_strchr(const char *s, int c)
> 
> if we do int -> char here, something breaks?

No, it shouldn't. IIUC the int comes from the original prototype of libc
strchr and it's there solely for legacy purposes. Let's change it to
char.

> 
>> +{
>> +       char *ret = NULL;
>> +       int i = 0;
>> +       char sc;
>> +
>> +       pagefault_disable();
>> +       while (i++ < XATTR_SIZE_MAX) {
>> +               __get_kernel_nofault(&sc, s, char, out);
>> +               if (sc == (char)c) {
>> +                       ret = (char *)s;
>> +                       break;
>> +               }
>> +               if (sc == '\0')
> 
> not very consistent with bpf_strcmp() implementation where you just
> did `!c1` for the same. FWIW, when dealing with string characters I
> like `sc == '\0'` better, but regardless let's be consistent, at
> least.
> 
>> +                       break;
>> +               s++;
> 
> It's like bpf_strcmp and bpf_strchr were written by two different
> people, stylistically :)

Yeah, the main reason here is that I've taken the implementations from
lib/string.c so that's where these differences come from. But the truth
is that the BPF kfuncs required quite a lot of changes so it's better to
rewrite them even further and make them consistent among themselves.
I'll have a look into it.

> 
>> +       }
>> +out:
>> +       pagefault_enable();
> 
> how about we
> 
> DEFINE_LOCK_GUARD_0(pagefault, pagefault_disable(), pagefault_enable())
> 
> like we do for preempt_{disable,enable}() and simplify all the
> implementations significantly?

That's neat, I didn't know it. It will a bit more tricky to use here as
__get_kernel_nofault still requires a label but we should at least be
able to get rid of pagefault_{disable,enable}() in each function.

> 
>> +       return ret;
>> +}
>> +
>> +/**
>> + * bpf_strchrnul - Find and return a character in a string, or end of string
>> + * @s: The string to be searched
>> + * @c: The character to search for
>> + *
>> + * Returns pointer to first occurrence of 'c' in s. If c is not found, then
>> + * return a pointer to the null byte at the end of s.
>> + */
>> +__bpf_kfunc char *bpf_strchrnul(const char *s, int c)
>> +{
>> +       char *ret = NULL;
>> +       int i = 0;
>> +       char sc;
>> +
>> +       pagefault_disable();
>> +       while (i++ < XATTR_SIZE_MAX) {
> 
> erm... for (i = 0; i < XATTR_SIZE_MAX; i++, s++) ?
> 
> what advantage does while() form provide? same question for lots of
> other functions. for() is meant for loops like this, no?

Yes, obviously for() is better here, I'll use it.

> 
>> +               __get_kernel_nofault(&sc, s, char, out);
>> +               if (sc == '\0' || sc == (char)c) {
>> +                       ret = (char *)s;
>> +                       break;
>> +               }
>> +               s++;
>> +       }
>> +out:
>> +       pagefault_enable();
>> +       return ret;
>> +}
>> +
>> +/**
>> + * bpf_strnchr - Find a character in a length limited string
>> + * @s: The string to be searched
>> + * @s__sz: The number of characters to be searched
>> + * @c: The character to search for
>> + *
>> + * Note that the %NUL-terminator is considered part of the string, and can
>> + * be searched for.
>> + */
>> +__bpf_kfunc char *bpf_strnchr(void *s, u32 s__sz, int c)
> 
> I'm a bit on the fence here. I can see cases where s would be some
> string somewhere (not "trusted" by verifier, because I did BPF CO-RE
> based casts, etc). Also I can see how s__sz is non-const known at
> runtime only.
> 
> I think the performance argument is much less of a priority compared
> to the ability to use the helper in a much wider set of cases. WDYT?
> Maybe let's just have __get_kernel_nofault() for everything?
> 
> If performance is truly that important, we can later have an
> optimization in which we detect constant size and "guaranteed"
> lifetime and validity of `s`, and use optimized strnchr()
> implementation?
> 
> But I'd start with a safe and generic __get_kernel_nofault() way for sure.

Ok, that makes sense. I didn't realize that with this prototype, we're
eliminating a number of uses-cases and I agree that it's more important
than performance.

Also it turned out that the bounded string functions are seldom
optimized on arches and therefore the performance benefit is minimal
(the only real case is strnlen on few arches like arm64).

So let's turn everything to generic __get_kernel_nofault variants for
now. We can think about optimization later, it would be much better if
we could detect situations when the kernel implementaion can be used
even for the unbounded functions. There, the performance gain would be
seen on much more functions.

> 
>> +{
>> +       return strnchr(s, s__sz, c);
>> +}
>> +
>> +/**
>> + * bpf_strnchrnul - Find and return a character in a length limited string,
>> + * or end of string
>> + * @s: The string to be searched
>> + * @s__sz: The number of characters to be searched
>> + * @c: The character to search for
>> + *
>> + * Returns pointer to the first occurrence of 'c' in s. If c is not found,
>> + * then return a pointer to the last character of the string.
>> + */
>> +__bpf_kfunc char *bpf_strnchrnul(void *s, u32 s__sz, int c)
>> +{
>> +       return strnchrnul(s, s__sz, c);
>> +}
>> +
>> +/**
>> + * bpf_strrchr - Find the last occurrence of a character in a string
>> + * @s: The string to be searched
>> + * @c: The character to search for
>> + */
>> +__bpf_kfunc char *bpf_strrchr(const char *s, int c)
> 
> `const char *` return? we won't (well, shouldn't!) allow writing into
> it from the BPF program.

Yes, agreed.

> 
>> +{
>> +       char *ret = NULL;
>> +       int i = 0;
>> +       char sc;
>> +
>> +       pagefault_disable();
>> +       while (i++ < XATTR_SIZE_MAX) {
>> +               __get_kernel_nofault(&sc, s, char, out);
>> +               if (sc == '\0')
>> +                       break;
>> +               if (sc == (char)c)
>> +                       ret = (char *)s;
>> +               s++;
>> +       }
>> +out:
>> +       pagefault_enable();
>> +       return (char *)ret;
>> +}
>> +
>> +__bpf_kfunc size_t bpf_strlen(const char *s)
>> +{
>> +       int i = 0;
>> +       char c;
>> +
>> +       pagefault_disable();
>> +       while (i < XATTR_SIZE_MAX) {
>> +               __get_kernel_nofault(&c, s++, char, out);
>> +               if (c == '\0')
>> +                       break;
>> +               i++;
>> +       }
>> +out:
>> +       pagefault_enable();
>> +       return i;
>> +}
>> +
>> +__bpf_kfunc size_t bpf_strnlen(void *s, u32 s__sz)
>> +{
>> +       return strnlen(s, s__sz);
>> +}
>> +
>> +/**
>> + * bpf_strspn - Calculate the length of the initial substring of @s which only contain letters in @accept
>> + * @s: The string to be searched
>> + * @accept: The string to search for
>> + */
>> +__bpf_kfunc size_t bpf_strspn(const char *s, const char *accept)
>> +{
>> +       int i = 0;
>> +       char c;
>> +
>> +       pagefault_disable();
>> +       while (i < XATTR_SIZE_MAX) {
>> +               __get_kernel_nofault(&c, s++, char, out);
>> +               if (c == '\0' || !bpf_strchr(accept, c))
> 
> hm... so `s` is untrusted/unsafe, but `accept` is? How should verifier
> make a distinction? It's `const char *` in the signature, so what
> makes one more safe than the other?

accept is untrusted as well, that's why bpf_strchr is used instead of
strchr. Or am I missing something?

> 
>> +                       break;
>> +               i++;
>> +       }
>> +out:
>> +       pagefault_enable();
>> +       return i;
>> +}
>> +
>> +/**
>> + * strcspn - Calculate the length of the initial substring of @s which does not contain letters in @reject
>> + * @s: The string to be searched
>> + * @reject: The string to avoid
>> + */
>> +__bpf_kfunc size_t bpf_strcspn(const char *s, const char *reject)
>> +{
>> +       int i = 0;
>> +       char c;
>> +
>> +       pagefault_disable();
>> +       while (i < XATTR_SIZE_MAX) {
>> +               __get_kernel_nofault(&c, s++, char, out);
>> +               if (c == '\0' || bpf_strchr(reject, c))
>> +                       break;
>> +               i++;
>> +       }
>> +out:
>> +       pagefault_enable();
>> +       return i;
>> +}
>> +
>> +/**
>> + * bpf_strpbrk - Find the first occurrence of a set of characters
>> + * @cs: The string to be searched
>> + * @ct: The characters to search for
>> + */
>> +__bpf_kfunc char *bpf_strpbrk(const char *cs, const char *ct)
> 
> wouldn't this be `cs + bpf_strcspn(cs, ct)`?

That's IMO correct, unless bpf_strcspn(cs, ct) == strlen(cs). Then it's
NULL. But it's still a nicer implementation.

> 
>> +{
>> +       char *ret = NULL;
>> +       int i = 0;
>> +       char c;
>> +
>> +       pagefault_disable();
>> +       while (i++ < XATTR_SIZE_MAX) {
>> +               __get_kernel_nofault(&c, cs, char, out);
>> +               if (c == '\0')
>> +                       break;
>> +               if (bpf_strchr(ct, c)) {
>> +                       ret = (char *)cs;
>> +                       break;
>> +               }
>> +               cs++;
>> +       }
>> +out:
>> +       pagefault_enable();
>> +       return ret;
>> +}
>> +
>> +/**
>> + * bpf_strstr - Find the first substring in a %NUL terminated string
>> + * @s1: The string to be searched
>> + * @s2: The string to search for
>> + */
>> +__bpf_kfunc char *bpf_strstr(const char *s1, const char *s2)
>> +{
>> +       size_t l1, l2;
>> +
>> +       l2 = bpf_strlen(s2);
>> +       if (!l2)
>> +               return (char *)s1;
>> +       l1 = bpf_strlen(s1);
>> +       while (l1 >= l2) {
>> +               l1--;
>> +               if (!memcmp(s1, s2, l2))
>> +                       return (char *)s1;
>> +               s1++;
>> +       }
>> +       return NULL;
> 
> no __get_kernel_nofault() anymore?

It's hidden inside bpf_strlen.

But I assume that the same as below applies (string possibly changing in
between the bpf_strlen and memcmp calls) so we'll need a different
implementation.

> 
>> +}
>> +
>> +/**
>> + * bpf_strnstr - Find the first substring in a length-limited string
>> + * @s1: The string to be searched
>> + * @s1__sz: The size of @s1
>> + * @s2: The string to search for
>> + * @s2__sz: The size of @s2
>> + */
>> +__bpf_kfunc char *bpf_strnstr(void *s1, u32 s1__sz, void *s2, u32 s2__sz)
>> +{
>> +       /* strnstr() uses strlen() to get the length of s2. Since this is not
>> +        * safe in BPF context for non-%NUL-terminated strings, use strnlen
>> +        * first to make it safe.
>> +        */
>> +       if (strnlen(s2, s2__sz) == s2__sz)
>> +               return NULL;
>> +       return strnstr(s1, s2, s1__sz);
>> +}
>> +
> 
> we have to assume that the string will change from under us, so any
> algorithm that does bpf_strlen/strlen/strnlen and then relies on that
> length to be true seems fishy...

Hm, that's a good point, I didn't consider that. I'll think about a
better implementation for bpf_strstr and bpf_strnstr.

Thanks a lot for the thourough review! I'll post v4 soon.

Viktor

> 
> pw-bot: cr
> 
>>  __bpf_kfunc_end_defs();
>>
>>  BTF_KFUNCS_START(generic_btf_ids)
>> @@ -3293,6 +3579,19 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
>>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>>  BTF_ID_FLAGS(func, bpf_local_irq_save)
>>  BTF_ID_FLAGS(func, bpf_local_irq_restore)
>> +BTF_ID_FLAGS(func, bpf_strcmp);
>> +BTF_ID_FLAGS(func, bpf_strchr);
>> +BTF_ID_FLAGS(func, bpf_strchrnul);
>> +BTF_ID_FLAGS(func, bpf_strnchr);
>> +BTF_ID_FLAGS(func, bpf_strnchrnul);
>> +BTF_ID_FLAGS(func, bpf_strrchr);
>> +BTF_ID_FLAGS(func, bpf_strlen);
>> +BTF_ID_FLAGS(func, bpf_strnlen);
>> +BTF_ID_FLAGS(func, bpf_strspn);
>> +BTF_ID_FLAGS(func, bpf_strcspn);
>> +BTF_ID_FLAGS(func, bpf_strpbrk);
>> +BTF_ID_FLAGS(func, bpf_strstr);
>> +BTF_ID_FLAGS(func, bpf_strnstr);
>>  BTF_KFUNCS_END(common_btf_ids)
>>
>>  static const struct btf_kfunc_id_set common_kfunc_set = {
>> --
>> 2.48.1
>>
> 


