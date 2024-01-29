Return-Path: <bpf+bounces-20559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA728840281
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 11:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A322A1C20852
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6070D55E68;
	Mon, 29 Jan 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBBtYqv4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAFD5C8E8
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522955; cv=none; b=PVUmB5PE9sgtPnvJIY2ddbAufrwByKeRA2rqAKhwVjLS0Zd37hIFQm8KO+LlS8cWGl80gfqi4xLjLsRuWE5IPc5lbEyih7K3eeGAgjjukw9W0CbEsQxM7XqsHsc7+cbuTDvcRnuYb5CJxoYlOVTbC+UhnLL6LsnpGpjs5o0N4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522955; c=relaxed/simple;
	bh=AovuKEfLyCYwuNkt/RkXEceoH5Wx/UbmM6ln7vuqEaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5aNJo+xaD/TvnQDbyQJsrCq/iHSI4TRIGgWz4M6A6iXvbaKZhfejfsKBb+DcKnhdsVZoHPQSvlWWJ7PtX6GDmdZm4lyv7TOGpYa3d2XhJ44GoebwfLef15V11T7yTokqPWPfQ/KNXyScIi0zAasbljHu5CZO53/yg9jtSPwweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBBtYqv4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706522952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYHen2oi+BFbFain7oay0ac3PoX7CtGlQvTKIJWDOMY=;
	b=TBBtYqv4J6wGl6oRJ6bMMBDQxolZlqalXHOGlZFWxavS6Eg3SR20dEqnYH4YEi4fI1uCay
	0ShH1uVxde2JIvZi8pYF3YsfUtnzLuU9XmAYSEiUP8yRVFEt46hRu9C1cZmnaAp4vT/yOr
	EofU3/8au3ICwEaT86Juaqsx/NCWPSo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-qLpq9wh5OgyaaAtaETdsJw-1; Mon, 29 Jan 2024 05:09:11 -0500
X-MC-Unique: qLpq9wh5OgyaaAtaETdsJw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e86ddcee5so16688315e9.2
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 02:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706522950; x=1707127750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYHen2oi+BFbFain7oay0ac3PoX7CtGlQvTKIJWDOMY=;
        b=Yu6tLNpY23iJHH0Vo2r96AbVh77Hdn/v4/ru3RYCeipxFVCXC0WmKaY+mwuJlv6BHx
         OPYlb07MSIbGKHZDaPUAglbZ16gzH5qDMdRURfH9eaZjYdDPFpDBHdZb3zJzGI6E0KVZ
         h1A4QG17y+PmSEwuFFV3f1z2d2uLN1MT8QZBZi/nXPdFWBFoP11/ZeSF5xDqLXhC1XDn
         RxhbpgSUWXeXSe17y7qaDoSu9WX+2ydCPztmdsxZm4bbHXBM0A89h2IszTeyKC5pDF5d
         iCC/SGsMEE6MruraQlIEtUAc2OKloKzVPfJWBMY2XqcDk4+We196kIO3PD1bkkCXPDMo
         WAXg==
X-Gm-Message-State: AOJu0Yzd/EFl2AnXJ7umpru4Vp0xwPORZUJrcSrz5Rftfc6Tus1R7hdL
	tl1ZF6UfMH8cKXq5Kzz/+IZSIJu2uqcgEpGOyjKSpplkfxY7OeBjzl1adjW7SYLBdx46Mu9+cuS
	pxN1jU6u+YywBdZ568XqjX6tlVC9CdtuAFsUBiEoVr5h50QcG
X-Received: by 2002:a05:600c:3b82:b0:40e:6eef:9d46 with SMTP id n2-20020a05600c3b8200b0040e6eef9d46mr5808876wms.20.1706522950233;
        Mon, 29 Jan 2024 02:09:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvxewqxVjJRiRcwyXAxcOPDsiEoVfqC3bN3Y/nws8d/R3mQUBXRmg4dzmEcoNBZDnSlkp+Ow==
X-Received: by 2002:a05:600c:3b82:b0:40e:6eef:9d46 with SMTP id n2-20020a05600c3b8200b0040e6eef9d46mr5808842wms.20.1706522949876;
        Mon, 29 Jan 2024 02:09:09 -0800 (PST)
Received: from [192.168.0.159] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id az29-20020a05600c601d00b0040ee6ff86f6sm8450624wmb.0.2024.01.29.02.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 02:09:09 -0800 (PST)
Message-ID: <246afef2-9f78-479d-90f1-3c5e2cf4085e@redhat.com>
Date: Mon, 29 Jan 2024 11:09:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: fix cross-compilation to
 non-host endianness
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Ian Rogers <irogers@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20240123120759.1865189-1-vmalik@redhat.com>
 <CAEf4Bzb=eSCO=h4q1fqqGfEoo9Nf4BZL51_dYm2MHvEFzD_csw@mail.gmail.com>
 <Zba2TrYs6jRcNhH8@krava>
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <Zba2TrYs6jRcNhH8@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/28/24 21:17, Jiri Olsa wrote:
> On Fri, Jan 26, 2024 at 03:40:11PM -0800, Andrii Nakryiko wrote:
>> On Tue, Jan 23, 2024 at 4:08 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>
>>> The .BTF_ids section is pre-filled with zeroed BTF ID entries during the
>>> build and afterwards patched by resolve_btfids with correct values.
>>> Since resolve_btfids always writes in host-native endianness, it relies
>>> on libelf to do the translation when the target ELF is cross-compiled to
>>> a different endianness (this was introduced in commit 61e8aeda9398
>>> ("bpf: Fix libelf endian handling in resolv_btfids")).
>>>
>>> Unfortunately, the translation will corrupt the flags fields of SET8
>>> entries because these were written during vmlinux compilation and are in
>>> the correct endianness already. This will lead to numerous selftests
>>> failures such as:
>>>
>>>     $ sudo ./test_verifier 502 502
>>>     #502/p sleepable fentry accept FAIL
>>>     Failed to load prog 'Invalid argument'!
>>>     bpf_fentry_test1 is not sleepable
>>>     verification time 34 usec
>>>     stack depth 0
>>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>>     Summary: 0 PASSED, 0 SKIPPED, 1 FAILED
> 
> hum, I'd think we should have hit such bug long time ago.. set8 is
> there for some time already.. nice ;-)
> 
>>>
>>> Since it's not possible to instruct libelf to translate just certain
>>> values, let's manually bswap the flags in resolve_btfids when needed, so
>>> that libelf then translates everything correctly.
>>>
>>> Fixes: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF sets")
>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>> ---
>>>  tools/bpf/resolve_btfids/main.c | 35 +++++++++++++++++++++++++++++++--
>>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>>> index 27a23196d58e..440d3d066ce4 100644
>>> --- a/tools/bpf/resolve_btfids/main.c
>>> +++ b/tools/bpf/resolve_btfids/main.c
>>> @@ -646,18 +646,31 @@ static int cmp_id(const void *pa, const void *pb)
>>>         return *a - *b;
>>>  }
>>>
>>> +static int need_bswap(int elf_byte_order)
>>> +{
>>> +       return __BYTE_ORDER == __LITTLE_ENDIAN && elf_byte_order != ELFDATA2LSB ||
>>> +              __BYTE_ORDER == __BIG_ENDIAN && elf_byte_order != ELFDATA2MSB;
>>
>> return (__BYTE_ORDER == __LITTLE_ENDIAN) != (elf_byte_order == ELFDATA2LSB);
>>
>> ?
>>

It seemed to me a bit less readable this way, but sure, no problem with
this form either.

>>> +}
>>> +
>>>  static int sets_patch(struct object *obj)
>>>  {
>>>         Elf_Data *data = obj->efile.idlist;
>>>         int *ptr = data->d_buf;
>>>         struct rb_node *next;
>>> +       GElf_Ehdr ehdr;
>>> +
>>> +       if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
>>> +               pr_err("FAILED cannot get ELF header: %s\n",
>>> +                       elf_errmsg(-1));
>>> +               return -1;
>>> +       }
>>
>> calculate needs_bswap() once here?

Good idea, will do.

>>>
>>>         next = rb_first(&obj->sets);
>>>         while (next) {
>>> -               unsigned long addr, idx;
>>> +               unsigned long addr, idx, flags;
>>>                 struct btf_id *id;
>>>                 int *base;
>>> -               int cnt;
>>> +               int cnt, i;
>>>
>>>                 id   = rb_entry(next, struct btf_id, rb_node);
>>>                 addr = id->addr[0];
>>> @@ -679,6 +692,24 @@ static int sets_patch(struct object *obj)
>>>
>>>                 qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(int), cmp_id);
>>>
>>> +               /*
>>> +                * When ELF endianness does not match endianness of the host,
>>> +                * libelf will do the translation when updating the ELF. This,
>>> +                * however, corrupts SET8 flags which are already in the target
>>> +                * endianness. So, let's bswap them to the host endianness and
>>> +                * libelf will then correctly translate everything.
>>> +                */
>>> +               if (id->is_set8 && need_bswap(ehdr.e_ident[EI_DATA])) {
>>> +                       for (i = 0; i < cnt; i++) {
>>> +                               /*
>>> +                                * header and entries are 8-byte, flags is the
>>> +                                * second half of an entry
>>> +                                */
>>> +                               flags = idx + (i + 1) * 2 + 1;
>>> +                               ptr[flags] = bswap_32(ptr[flags]);
>>
>> we are dealing with struct btf_id_set8, right? Can't we #include
>> include/linux/btf_ids.h and use that type for all these offset
>> calculations?..
> 
> we could, there's tools/include/linux/btf_ids.h, which we could include
> in here, we do that in selftests.. but it needs to be updated with latest
> kernel updates (at least with set8 struct)
> 
>>
>> I have the same question for existing code, tbh, so maybe there was
>> some good reason, not sure...
> 
> I think the test came later and I did not think of it for the resolve_btfids
> itself, I guess it might make the code more readable

Agreed, let's use that. I'll also refactor the existing code using types
from btf_ids.h for v2 of this patchset.

Viktor

> 
> thanks,
> jirka
> 
>>
>>> +                       }
>>> +               }
>>> +
>>>                 next = rb_next(next);
>>>         }
>>>         return 0;
>>> --
>>> 2.43.0
>>>
>>>
> 


