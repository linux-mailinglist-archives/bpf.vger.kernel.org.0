Return-Path: <bpf+bounces-61030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC132ADFC9C
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 06:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A8A1893E44
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 04:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3C51E5705;
	Thu, 19 Jun 2025 04:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnphbpY6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6543085A6
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 04:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750308722; cv=none; b=A4NOLf4UhitMIIUg8/fnnyK4FWyw6SXpIX189hz7qKhBaChCAaP7AbfVRzHjaiuV6FAdloce0Zl5gUS5xdUrpxn8WyHli9Pue12Uuzf49XVzfEwJu5j14EZaLbFg8YJohRUXKxWbu4fchfGqZU94cloU+1B89bkEjLTSJ70gfZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750308722; c=relaxed/simple;
	bh=rW4oZshW6G+3AmBYWnBj3FOfRVhTzqufEOv7tXJ7a1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfXB9SxUkxW3ooL0FJzTYA61WTluTrVSK+3Adg1FnobNKm53CorUbX3Yyf9zvmEqqqqQPI0lYJOxiG280WX96HDe091BmRRCAU15mu8p/nPyKd3edOEcUBKxiFida/ndAlT/ldO2Alpiu58oebwm/BcFPNcv91nY25L3YGrYdz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LnphbpY6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750308719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tve6FBUawv/YAROi2GF4aPEwAS6O85r63LLFPRTTQw=;
	b=LnphbpY6+1jMyzlNf3yye86Df8LpML4OBox75ceo2tqlRg6Fn3VmSsEZQwyu/5doY60oaA
	ptgkAQN79idmQXfWyhIoyFsXI2OlTLa7zeNEE6TMK+CIvBD4oG4XLHKea0GriVUC5rqGzP
	NAL1+hD0CQtn4D+lnA2QpB74tas0s14=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-xbbtPfaNNsaOxMjZcfHQ_w-1; Thu, 19 Jun 2025 00:51:56 -0400
X-MC-Unique: xbbtPfaNNsaOxMjZcfHQ_w-1
X-Mimecast-MFC-AGG-ID: xbbtPfaNNsaOxMjZcfHQ_w_1750308716
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-addfe17eb89so30994266b.3
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 21:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750308716; x=1750913516;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tve6FBUawv/YAROi2GF4aPEwAS6O85r63LLFPRTTQw=;
        b=dp/TCo73nT50UCh5MiYvh34LeOMYTWoZPTtmlNGNgRS06Ghd0hq2yghkEVsj2AyLbB
         jmoZhIaC7kpnFX6VxNlIvwlCIseSPZKHZmL7P3E8O7fY1sXMUFg/JlXUOc09bF9mDkY8
         +COF07i/WzfpOemLE7ht4q2CjwulFNlO8O8Q+aAOYAMX5eTB9LgiUUTjuyIHm1xlYsDa
         rGdqiC3NgJauzNPPfBW5ivHVicccQsSMePFtQUMgVB7emZF2r8+qWzvG2UXoQUaBOR0c
         Lp2t7MtoN0qIBrH66HnRs5OaE2nDONbcfpNzUbr54vQzcDC0UHepTOABijhWuVFnucbc
         r3DA==
X-Gm-Message-State: AOJu0YzZWe/N4oShcIS/8qHqNUlUpSE5TPd+kh2BLdeifJe8KAqH3306
	o9Ml8iu8iD+4kzxSfhiJYSh8HG5CpN795QrPNR3Yi4hQBas2h8DsOfGS+TNLuEWyd/38bqXfZYI
	F5xpD3CXQzKDbMv3BrHvif4zAP5hCF5eK3hR9mGAftUEyWbh3bqOk
X-Gm-Gg: ASbGnct0/oh7st2o1CVgRDaAwqWEfoCuNU4vhU+dRY6u1LghdN7rMfWHTkqKfvxbeOz
	dJxWxd02qwKSGItl6FkU8XeItj1/XdQ8lYXZ7aBs6UaTPg4qmj9Hi4hYFQxkp6BbNdLSQbJIj4z
	8nAKVFcUJzAau7V14Kf5YdEZo2ctBlKc3Jzc/9pePHGaJStCpySbXRdtNIuwxEkOmqW/lqf2jRM
	X6tgMc46HbVkMHPkhFUyAeBE94gA61FJg5bMRqHvJx9DyXKm+uUuetsyy5e9RbYMz3Z7ARMp+g/
	Kv1b0/Q4TvgYoSmW0g8vhldnR1nOFziy+tUkIDyZpDzpM0k4KtFwynBS
X-Received: by 2002:a17:907:1303:b0:adf:f883:aa78 with SMTP id a640c23a62f3a-adff883b86emr731793166b.10.1750308715681;
        Wed, 18 Jun 2025 21:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdEn0Wo+RLYoeR+ihwg4R37wpQDwU5C7/VJ/bROpEEZpL1uoSKguerema7syHnY7wAyssBMA==
X-Received: by 2002:a17:907:1303:b0:adf:f883:aa78 with SMTP id a640c23a62f3a-adff883b86emr731791966b.10.1750308715242;
        Wed, 18 Jun 2025 21:51:55 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88fed41sm1139457766b.81.2025.06.18.21.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 21:51:54 -0700 (PDT)
Message-ID: <095ccb13-7970-456b-9176-7f0c30a8b35c@redhat.com>
Date: Thu, 19 Jun 2025 06:51:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/4] selftests/bpf: Allow macros in __retval
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1750252029.git.vmalik@redhat.com>
 <04a320f8a9405caee87c59807a4192e2b5e14bed.1750252029.git.vmalik@redhat.com>
 <CAADnVQLwxwLo5RqBPy=-Rr30nni5ZL8X5on-LenFMHqArZ6XFg@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQLwxwLo5RqBPy=-Rr30nni5ZL8X5on-LenFMHqArZ6XFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/18/25 16:40, Alexei Starovoitov wrote:
> On Wed, Jun 18, 2025 at 6:32 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> Allow macro expansion for values passed to the `__retval` and
>> `__retval_unpriv` attributes. This is especially useful for testing
>> programs which return various error codes.
>>
>> With this change, the code for parsing special literals is made
>> redundant (as the literals are defined via macros) so drop it.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  tools/testing/selftests/bpf/progs/bpf_misc.h | 11 ++++++-----
>>  tools/testing/selftests/bpf/test_loader.c    | 17 -----------------
>>  2 files changed, 6 insertions(+), 22 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
>> index a678463e972c..1758265f5905 100644
>> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
>> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
>> @@ -83,9 +83,10 @@
>>   *                   expect return value to match passed parameter:
>>   *                   - a decimal number
>>   *                   - a hexadecimal number, when starts from 0x
>> - *                   - literal INT_MIN
>> - *                   - literal POINTER_VALUE (see definition below)
>> - *                   - literal TEST_DATA_LEN (see definition below)
>> + *                   - a macro which expands to one of the above
>> + *                   In addition, two special macros are defined:
>> + *                   - POINTER_VALUE (see definition below)
>> + *                   - TEST_DATA_LEN (see definition below)
>>   * __retval_unpriv   Same, but load program in unprivileged mode.
>>   *
>>   * __description     Text to be used instead of a program name for display
>> @@ -125,8 +126,8 @@
>>  #define __success_unpriv       __attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
>>  #define __log_level(lvl)       __attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
>>  #define __flag(flag)           __attribute__((btf_decl_tag("comment:test_prog_flags="#flag)))
>> -#define __retval(val)          __attribute__((btf_decl_tag("comment:test_retval="#val)))
>> -#define __retval_unpriv(val)   __attribute__((btf_decl_tag("comment:test_retval_unpriv="#val)))
>> +#define __retval(val)          __attribute__((btf_decl_tag("comment:test_retval="XSTR(val))))
>> +#define __retval_unpriv(val)   __attribute__((btf_decl_tag("comment:test_retval_unpriv="XSTR(val))))
>>  #define __auxiliary            __attribute__((btf_decl_tag("comment:test_auxiliary")))
>>  #define __auxiliary_unpriv     __attribute__((btf_decl_tag("comment:test_auxiliary_unpriv")))
>>  #define __btf_path(path)       __attribute__((btf_decl_tag("comment:test_btf_path=" path)))
>> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
>> index 9551d8d5f8f9..28d2d366a8ae 100644
>> --- a/tools/testing/selftests/bpf/test_loader.c
>> +++ b/tools/testing/selftests/bpf/test_loader.c
>> @@ -318,23 +318,6 @@ static int parse_caps(const char *str, __u64 *val, const char *name)
>>
>>  static int parse_retval(const char *str, int *val, const char *name)
>>  {
>> -       struct {
>> -               char *name;
>> -               int val;
>> -       } named_values[] = {
>> -               { "INT_MIN"      , INT_MIN },
>> -               { "POINTER_VALUE", POINTER_VALUE },
>> -               { "TEST_DATA_LEN", TEST_DATA_LEN },
>> -       };
>> -       int i;
>> -
>> -       for (i = 0; i < ARRAY_SIZE(named_values); ++i) {
>> -               if (strcmp(str, named_values[i].name) != 0)
>> -                       continue;
>> -               *val = named_values[i].val;
>> -               return 0;
>> -       }
>> -
> 
> and this broke a bunch of tests.

Right, sorry about that. I'll fix it and send v6 shortly.

Viktor

> 
> pw-bot: cr
> 


