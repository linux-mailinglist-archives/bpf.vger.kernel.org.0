Return-Path: <bpf+bounces-53953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE06A5F438
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 13:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A4219C2148
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 12:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880C9266F09;
	Thu, 13 Mar 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkV83qLN"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC8335BA
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868687; cv=none; b=eoELy/HBEknhd5pGuY4yyoURTYEhwONHTbbF+BXgrODUu8Nd+pwKIEhDrvLZObe6ni769n6qmpm3LKEKiO4XRbtlGhNpCHJ80Bqqr5t54iEkF94CtQiByJrSa306E0z9Cza6Am/LVcHi+P5Lvz740ZNjy8LRNd84rAqd8ttzoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868687; c=relaxed/simple;
	bh=MkbBa7rf+sqS6uMkDiyWBHQXVzducBP4yB3q8bcRpT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTIBVBdnq+ljgfoBmil7EpMcSidaYs6oPq6/KKjrkuui/AxwCCJbwK2z5vVqlpi6KgvKoqbSaP6Q9YYx+DXIerNUtx32Zs8mOm0TvDEQrduJQd5wx1tKzUeRedkAr/TVHixGGdMvJBHoRdbqqXqSY+/G+J9cgVHsaMwyvMa9sPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkV83qLN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741868684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TI+8IZpYhDUUiY9X08Th4KU7UbR+72JfZoQX/qRa20g=;
	b=KkV83qLNlE1+Wih9ON/Nhu/ooEbj70eiPAiKe7Tj+lr6MHE8AYE/7rlcDGFS4az6+i/Tlq
	FYedPNBkKwyrobYKy84ze6PvgtOfcACkEw3NPh43uWqzxHsBjFr7+ZvOYawERKVh0Udk/1
	bv5xZWv/FwfjDplxF+1wMY846S8SOqo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-T9UVNFbuP0OqwAV_DZ3X5w-1; Thu, 13 Mar 2025 08:24:43 -0400
X-MC-Unique: T9UVNFbuP0OqwAV_DZ3X5w-1
X-Mimecast-MFC-AGG-ID: T9UVNFbuP0OqwAV_DZ3X5w_1741868682
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913f546dfdso507152f8f.1
        for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 05:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741868682; x=1742473482;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TI+8IZpYhDUUiY9X08Th4KU7UbR+72JfZoQX/qRa20g=;
        b=vHHh+jbNsfnWMBE4Wsu4B4FEht52we3fg7ZFjRAj/9j0LjHgEjneXF/XD02SvG+VJN
         ciQT+yVD+wtf3HkFIPqvsyLlDYOXg25th2EP378dAtTSGtCaSWCA2qJ2ydL0E30M66DQ
         ptJIPOmVZ3PrrXnt2pGJt7d3bG4uOEOErw3uq2mFC4DnnVb7swtKHHqgIQbj9r4I0j9n
         dtCfl19H3YxXVT7wZgfrgSCRervtc4+eJBo3AYeIbv9l1mxXxnnZSXYwWT7BvxbUqCw/
         4mB7SozFXcpdE74FOYj1hrCW96B5xUvUE0x1m+ay704jeyK8iUTQrcQ4dmMU3HKlecqd
         IYUg==
X-Gm-Message-State: AOJu0YxHS0e5k3HNBokPdiYALC9hdT7VVmuiuLzb02z8K40S6rKHMTfj
	z/u0000pBdG/O4Bkt4ni9N4OThv9aK9RiejyVvgP2ebBp4SeWDvZbXCFqSaRoSZTnsfmERy/Hne
	+n8SuBcaJlr5+f+GZO7DUSBRp2HSDBgNzFx72v1NKv5jc9JQP
X-Gm-Gg: ASbGnctyCANzA3CZHqWz6rDIJwbOxNTDhFQD9Vlw4siEbLYEhs4+3WOiezumu1Cgd/1
	MfNKuB/lV55aUkdq7TwOJT4001TS8H/QE0RofS7DTa8IeMEcUrqh5pwp809g4gQR8ekzrXpZwKc
	VKxgfXK0jso5Kn+ASAMPUK1oqzs5bN0lTAzTmw9PncPhiNP+P/0GhmMhZz+BGc9PUtljUhOtyrg
	lC7IfB/K9tYKGbMFllz6tX41lWFhIGOUb6IUHeQHYDF/ADmJF/SMCYw4iuT0zWJzaZaCBJ0adl3
	ndO4t/8m9GW7Z6p05/EojdQjbfaqopEskyk0x5YmrunhL8DEuw==
X-Received: by 2002:a5d:47c3:0:b0:38d:d69e:1326 with SMTP id ffacd0b85a97d-39263ceba3emr10688213f8f.9.1741868681698;
        Thu, 13 Mar 2025 05:24:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0JTDf3uBsfr3KOzdprJI9C23NRF+JGkqAb2+r4bSRdqWATX+Xoe5bYC+xdiT2umqnXpyo7A==
X-Received: by 2002:a5d:47c3:0:b0:38d:d69e:1326 with SMTP id ffacd0b85a97d-39263ceba3emr10688185f8f.9.1741868681227;
        Thu, 13 Mar 2025 05:24:41 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8881544sm1929667f8f.43.2025.03.13.05.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 05:24:40 -0700 (PDT)
Message-ID: <09924293-15fd-4fd1-ac94-9f714c42ae96@redhat.com>
Date: Thu, 13 Mar 2025 13:24:39 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix string read in strncmp
 benchmark
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20250312083859.1019635-1-vmalik@redhat.com>
 <CAEf4BzY38E5LW0KudDF5OC5v72k6QTYkpRdZWjMUUzUTW2TQuw@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzY38E5LW0KudDF5OC5v72k6QTYkpRdZWjMUUzUTW2TQuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/13/25 00:45, Andrii Nakryiko wrote:
> On Wed, Mar 12, 2025 at 1:39 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> The strncmp benchmark uses the bpf_strncmp helper and a hand-written
>> loop to compare two strings. The values of the strings are filled from
>> userspace. One of the strings is non-const (in .bss) while the other is
>> const (in .rodata) since that is the requirement of bpf_strncmp.
>>
>> The problem is that in the hand-written loop, Clang optimizes the reads
>> from the const string to always return 0 which breaks the benchmark.
>>
>> Mark the const string as volatile to avoid that.
>>
>> The effect can be seen on the strncmp-no-helper variant.
>>
>> Before this change:
>>
>>     # ./bench strncmp-no-helper
>>     Setting up benchmark 'strncmp-no-helper'...
>>     Benchmark 'strncmp-no-helper' started.
>>     Iter   0 (8440.107us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>>     Iter   1 (73909.374us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>>     Iter   2 (-8140.994us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>>     Iter   3 (3094.474us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>>     Iter   4 (-2828.468us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>>     Iter   5 (2635.595us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>>     Iter   6 (-306.478us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>>     Summary: hits    0.000 ± 0.000M/s (  0.000M/prod), drops    0.000 ± 0.000M/s, total operations    0.000 ± 0.000M/s
>>
>> After this change:
>>
>>     # ./bench strncmp-no-helper
>>     Setting up benchmark 'strncmp-no-helper'...
>>     Benchmark 'strncmp-no-helper' started.
>>     Iter   0 (21180.011us): hits    5.320M/s (  5.320M/prod), drops    0.000M/s, total operations    5.320M/s
>>     Iter   1 (-692.499us): hits    5.246M/s (  5.246M/prod), drops    0.000M/s, total operations    5.246M/s
>>     Iter   2 (-704.751us): hits    5.332M/s (  5.332M/prod), drops    0.000M/s, total operations    5.332M/s
>>     Iter   3 (62057.929us): hits    5.299M/s (  5.299M/prod), drops    0.000M/s, total operations    5.299M/s
>>     Iter   4 (-7981.421us): hits    5.303M/s (  5.303M/prod), drops    0.000M/s, total operations    5.303M/s
>>     Iter   5 (3500.341us): hits    5.306M/s (  5.306M/prod), drops    0.000M/s, total operations    5.306M/s
>>     Iter   6 (-3851.046us): hits    5.264M/s (  5.264M/prod), drops    0.000M/s, total operations    5.264M/s
>>     Summary: hits    5.338 ± 0.147M/s (  5.338M/prod), drops    0.000 ± 0.000M/s, total operations    5.338 ± 0.147M/s
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  tools/testing/selftests/bpf/progs/strncmp_bench.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/strncmp_bench.c b/tools/testing/selftests/bpf/progs/strncmp_bench.c
>> index 18373a7df76e..92a828a1ebea 100644
>> --- a/tools/testing/selftests/bpf/progs/strncmp_bench.c
>> +++ b/tools/testing/selftests/bpf/progs/strncmp_bench.c
>> @@ -9,7 +9,7 @@
>>
>>  /* Will be updated by benchmark before program loading */
>>  const volatile unsigned int cmp_str_len = 1;
>> -const char target[STRNCMP_STR_SZ];
>> +const volatile char target[STRNCMP_STR_SZ];
>>
>>  long hits = 0;
>>  char str[STRNCMP_STR_SZ];
>> @@ -17,7 +17,7 @@ char str[STRNCMP_STR_SZ];
>>  char _license[] SEC("license") = "GPL";
>>
>>  static __always_inline int local_strncmp(const char *s1, unsigned int sz,
>> -                                        const char *s2)
>> +                                        const volatile char *s2)
> 
> this will be a bit unfair to local_strncmp(), as now you'll be forcing
> the compiler to re-read s1[i] twice, right? What if we do:

Ah, right, I didn't realize s1[i] was used twice there.

> 
> 
> diff --git a/tools/testing/selftests/bpf/progs/strncmp_bench.c
> b/tools/testing/selftests/bpf/progs/strncmp_bench.c
> index 18373a7df76e..f47bf88f8d2a 100644
> --- a/tools/testing/selftests/bpf/progs/strncmp_bench.c
> +++ b/tools/testing/selftests/bpf/progs/strncmp_bench.c
> @@ -35,7 +35,10 @@ static __always_inline int local_strncmp(const char
> *s1, unsigned int sz,
>  SEC("tp/syscalls/sys_enter_getpgid")
>  int strncmp_no_helper(void *ctx)
>  {
> -       if (local_strncmp(str, cmp_str_len + 1, target) < 0)
> +       const char *target_str = target;
> +
> +       barrier_var(target_str);
> +       if (local_strncmp(str, cmp_str_len + 1, target_str) < 0)
>                 __sync_add_and_fetch(&hits, 1);
>         return 0;
>  }
> 
> 
> that will prevent compiler optimization as well and won't force us to
> do all those casts?

Yeah, that works, I'll send v2.

Thanks!

> 
> pw-bot: cr
> 
> 
>>  {
>>         int ret = 0;
>>         unsigned int i;
>> @@ -43,7 +43,7 @@ int strncmp_no_helper(void *ctx)
>>  SEC("tp/syscalls/sys_enter_getpgid")
>>  int strncmp_helper(void *ctx)
>>  {
>> -       if (bpf_strncmp(str, cmp_str_len + 1, target) < 0)
>> +       if (bpf_strncmp(str, cmp_str_len + 1, (const char *)target) < 0)
>>                 __sync_add_and_fetch(&hits, 1);
>>         return 0;
>>  }
>> --
>> 2.48.1
>>
> 


