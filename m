Return-Path: <bpf+bounces-70327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55944BB7E34
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 20:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E353BC2BE
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 18:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F6E2DCF43;
	Fri,  3 Oct 2025 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC76yR+1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56AB79EA
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759516187; cv=none; b=geGl+7dWKqhpApD9uaGpmCpkFPPVJBSSBnwaMlxIvbxGGnxkugmdFd0+K+YNQ+MwYs+O4QTOSS7tSKGR5+L+4bwythnA0jL9b0eGb8WhKyOsryToo6Qga1y52gun2XLKwcf80qW/re9wUk6T3tI0zxM3uRYh4KZQ2PYa/jCbaIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759516187; c=relaxed/simple;
	bh=/PrvXlX2KfGzjPLKqv8oLFDWREiuUI1Kn/ZxFLeWh0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+oblkPTk9xS1+1n5jHlNkd+yLG+uf1ZHSbj8Rx0FjWb1rEuDN3hq1ihZKh9xTXVuPa7CZwUgcsCLAiFOVytz36dj/ectRfaWFgCj2e/gDCk9DjqAexLm2j6tYdc8o2QSM6VRB5g22hfu8GavB90ofP2JiKeab3chaPJnTVjohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RC76yR+1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e430494ccso15445765e9.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759516184; x=1760120984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1UID+OAvGqa7bvNYGBKLxiWSLHku/FaEwOUxhrgB+c=;
        b=RC76yR+1InUa5eCzgtJUvgX5KB1y2vbUHhI/iMfeev9MKi3bXDL4jmfqvud7WBvTlb
         Zqg9hy7oSRYoP69M38khQTbE+1UbP667aR/vgjxgPhm165m0XDiRNIMJIRgfZR+mA2Bh
         geroh+ohF8Z8X0vj4aM7Q/+NWhENpv3WOY1nNFsz53mp64Ui+0SpTmRlTYL6+o7Ckvbp
         wXark4RiKN6OWsd+SxJjZpfZtkJH7WIloRFadwohLVlkTLRxIPovV/PLh09hcUcIbtMW
         h9tFnvEL/WASyF4ur09b4KeWIJcgGEjr9un0Ass3b579dTYsZRuxcDMcnbkyotdZyxRD
         j4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759516184; x=1760120984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1UID+OAvGqa7bvNYGBKLxiWSLHku/FaEwOUxhrgB+c=;
        b=EE4MDogU1D22lvqRSKRtw3L9r8kXibTZUn9GmT0phqukyDf6GeKhlxzQhoB51RcBlZ
         R7iW3PpwhReoLWFV5/YMyZouMnXG1ezJHsHwHsCKtNACH6SXn2n6RKjb3YKSRJ2tsutj
         HWSs+YVY94cCWdDQssZui6U2Py1t8mAMXdxKPdyoG1ChcqSwQaeHFfOr88nD0WrPKInL
         Typb2lynTkzi6HVmcg1F1Q5g5YMjnhs5tElurJ4xYT/ocARTiM44Rs7uqEKzb0ZbM+k5
         4Xvmg3J+/iAUtYeDO08qtJ9NI63vOHb2cwHCTuFxQ4FnJk1tHFHKlmg6BJCLr2C0uS37
         Ytbw==
X-Gm-Message-State: AOJu0YyfaaDwQgx4DO/UaYzG/gMPP3G1rffVADB/GNk3c1xJaBownDoZ
	gjFHVEg9tyct1G44HWkL1o3osTqeL2rhI/8iy5deXM+kE4v7GeW7bFHR
X-Gm-Gg: ASbGncuxpFLZ+y9sCK6z5d2D87hVip3PJO7Azdqfks7q1K43C5jSWnsy03tvAA5ctWq
	f8uwKYSjP1Jqso1pM8woe+Vkl1GA09+VgoVh6ATXC/KJ/a0vJmIv28cpyq6+IOUMQJrWvQ/lC18
	P4GYChd2oNNnzoAGYu+qIkVKZevMqlKCg8dU/XLhFmHlwMS5W7HiZyVC7II4zv4HSye38i9p4xF
	Jnv0m/QTHM/GV3JWiUTiCmxl/QRdqD3hxrVgQKcqZGDROXLiijaHJ60jtRpvr2TVOXyHgKKLt2x
	pQmcOhl5g9FmYrbi3fumKEkk28Dqr7ppqWRUPoEtW7iHb+Jhq/yhJQVw7vQVxo1a438DNhwqE3f
	6R/Geg/hv2Nx/nFY0Yxa9RCj8OpSAvVwrfn8dLMDNuioigGALr7ix8YFf2PrYvAs0BZSrY3w=
X-Google-Smtp-Source: AGHT+IHh/rC1be+Pqsz7pymnuntyeOh3kCZnPg3Go7qDFDZi0EIQxagVGIf5iWReXcMxP53QmXhmOA==
X-Received: by 2002:a05:600c:4fd3:b0:46d:d6f0:76d8 with SMTP id 5b1f17b1804b1-46e7115c338mr27428315e9.35.1759516183933;
        Fri, 03 Oct 2025 11:29:43 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0c3:1130::123d? ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619c3a58sm137962285e9.6.2025.10.03.11.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 11:29:43 -0700 (PDT)
Message-ID: <aea8063e-a7f6-4d25-a88e-01e4a55ee130@gmail.com>
Date: Fri, 3 Oct 2025 19:29:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 04/10] lib/freader: support reading more than 2
 folios
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
 <20251003160416.585080-5-mykyta.yatsenko5@gmail.com>
 <CAEf4BzZLvt1kqFsVjG2oC6yf980Y_p8zW0QXu18EWWi8-S4KjA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzZLvt1kqFsVjG2oC6yf980Y_p8zW0QXu18EWWi8-S4KjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/25 19:16, Andrii Nakryiko wrote:
> On Fri, Oct 3, 2025 at 9:04 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> freader_fetch currently reads from at most two folios. When a read spans
>> into a third folio, the overflow bytes are copied adjacent to the second
>> folio’s data instead of being handled as a separate folio.
>> This patch modifies fetch algorithm to support reading from many folios.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   lib/freader.c | 27 ++++++++++++++++-----------
>>   1 file changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/lib/freader.c b/lib/freader.c
>> index 32a17d137b32..f73b594a137d 100644
>> --- a/lib/freader.c
>> +++ b/lib/freader.c
>> @@ -105,17 +105,22 @@ const void *freader_fetch(struct freader *r, loff_t file_off, size_t sz)
>>          folio_sz = folio_size(r->folio);
>>          if (file_off + sz > r->folio_off + folio_sz) {
>>                  int part_sz = r->folio_off + folio_sz - file_off;
> AI suggests this should be size_t or u64, it's not strictly necessary,
> probably better to have all the offsets and sizes of the same bitness
>
>> -
>> -               /* copy the part that resides in the current folio */
>> -               memcpy(r->buf, r->addr + (file_off - r->folio_off), part_sz);
>> -
>> -               /* fetch next folio */
>> -               r->err = freader_get_folio(r, r->folio_off + folio_sz);
>> -               if (r->err)
>> -                       return NULL;
>> -
>> -               /* copy the rest of requested data */
>> -               memcpy(r->buf + part_sz, r->addr, sz - part_sz);
>> +               size_t dst_off = 0, src_off = file_off - r->folio_off;
>> +
>> +               do {
>> +                       memcpy(r->buf + dst_off, r->addr + src_off, part_sz);
>> +                       sz -= part_sz;
>> +                       if (sz == 0)
>> +                               break;
>> +                       /* fetch next folio */
>> +                       r->err = freader_get_folio(r, r->folio_off + folio_sz);
>> +                       if (r->err)
>> +                               return NULL;
>> +                       folio_sz = folio_size(r->folio);
>> +                       src_off = 0; /* read from the beginning, starting second folio */
>> +                       dst_off += part_sz;
>> +                       part_sz = min_t(u64, sz, folio_sz);
>> +               } while (sz);
> it's a bit sloppy that we have sz check twice, what if we rewrite it a bit
>
> u64 part_sz = r->folio_off + folio_size(r->folio) - file_off, off;
>
> /* copy the part that resides in the first folio */
> memcpy(r->buf, r->addr + (file_off - r->folio_off), part_sz);
> off = part_sz;
>
> while (off < sz) {
>      /* fetch next folio */
>      r->err = freader_get_folio(r, file_off + off);
>      if (r->err)
>          return NULL;
>
>      part_sz = min(u64, file_off + sz - r->folio_off, folio_ssize(r->folio));
>      memcpy(r->buf + off, r->addr, part_sz);
>
>      off += part_sz;
> }
That'll do, the choice is to check size twice or memcpy twice.
Let's do as you suggest, also helps dropping src_off variable.
>
>>                  return r->buf;
>>          }
>> --
>> 2.51.0
>>


