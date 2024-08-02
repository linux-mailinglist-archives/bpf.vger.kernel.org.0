Return-Path: <bpf+bounces-36258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAA8945720
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 06:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C672B21671
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 04:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31A91C693;
	Fri,  2 Aug 2024 04:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAl4FLcU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C03256D
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 04:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722573360; cv=none; b=mVzHbURMsmyVreybQWmHM3iluvBK9EF90CB8d7kmI7KXqUaVqR/82on/yoezclgsd0dxhrD4OqsrH0Hr7dI4z0lKpkbsiklkCieMo6btOBtnkVeOA6wqYHgZGdkE4z0yGxdChwYkDaaImyFFkAPseYlftUUtgRD1F2hGnl2CL4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722573360; c=relaxed/simple;
	bh=T5oDgObw25UdtQjNpb5Hod3frRpk6y332yCo3uSnmUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C00azGjMtMMfQwFIObs/0Fvns0CjfpIsB0rGNmKMbC1wAeYfltd9FjvuvO+LHgQfji1myIuTqhQmb0lzsL1Rol8E8Bb5qnNRtwBG5XlvEKX7d1okJStH8/Ni+wkUi4JC5as7Jpv1Po4H1H0Zdp2yolbGyUEiuttxmrQq8C2eOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAl4FLcU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-68aa9c894c7so1197127b3.1
        for <bpf@vger.kernel.org>; Thu, 01 Aug 2024 21:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722573358; x=1723178158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/GCLnU6eTyNqR8BH89pRZ3N+j3NtATHM40poI7tGG6o=;
        b=iAl4FLcU4Z/rvZv9EsKLRn9RleOqHZQmBJGR/4raZsRueoscYh5ZhLcAg8vwV/cbPh
         tnTcedjPmyjOh7Hi8T80+vknBrBZ5AMiYmjrBVitfK2qsfJURC+n5WimVWqIsIKTOWBy
         Pxnc3Yum8tTGqQGSad4aDXjrHaomJaISsG8eahh15ZcH0kCY9TH0GSL6zYYdJb/3ix+7
         7MVAextYwGoxlD6AM7pBKfablVyPtL8UJvS8Lc1yWsDiNEQp97uPyeDjmWV/Gqvarceh
         cDAC4S/JZvV0YtDBS2GlhJjlNZt1aqD+vHnl5qILzuehuXqSc9+y2arzMgOw7tsIRljo
         0oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722573358; x=1723178158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GCLnU6eTyNqR8BH89pRZ3N+j3NtATHM40poI7tGG6o=;
        b=FswTej7Y5neAz5IAf6tJIdJrdoc8MnFGmh5TVPczuew7VM/7zQ6yc1TbR1JmGSc2rX
         Hl/RnfcnTfH/8VMwdJAZD8w46dp33MAk5MpJ9c3KhpSc6EGZ+Pd25GLGpjibVlGLMZ+s
         2cVjRr/ATASBmdz5udjD7V1unN+j59qg50knnjORR/Tqiu7t/q96DtcWX7qhksZl2cZ3
         UgXlW//tqz7VN7nGQNmp9NWbKdC9xvblwj7cM/wsZdvO5w0bdFlrB3C/qQ3QgrBp1wx9
         aK1H+QURCjFV8nwqxxS+PJPtttuXijUyKy5E3vZJrLLTnP1H5AtetUCjoTtvQIH2Krxi
         VC4g==
X-Gm-Message-State: AOJu0YwDxYxYVmM7hBmjwvB1bQXpZSmdwj50Qty/KuS2JWlAWC3mqJNZ
	fzk+WKrnaGX2YpKwZ+Xn3OyNDOeKj9Y5TnvDiWeSiTY2zO8rAsnN
X-Google-Smtp-Source: AGHT+IGD9SHaUJrRbi+prTrLo0cBdQX7cQ8CYZHFwFh5R1XAN1FC/2RlZlpuJmKBuBIL0sBmQVAYkA==
X-Received: by 2002:a81:a508:0:b0:64b:7e17:b347 with SMTP id 00721157ae682-689601aef72mr25721047b3.15.1722573357803;
        Thu, 01 Aug 2024 21:35:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:10ed:40b:8a2e:9686? ([2600:1700:6cf8:1240:10ed:40b:8a2e:9686])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a12d0ffcasm1324097b3.77.2024.08.01.21.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 21:35:57 -0700 (PDT)
Message-ID: <283a022a-6764-4b66-8897-b8a307733e07@gmail.com>
Date: Thu, 1 Aug 2024 21:35:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/6] selftests/bpf: Add traffic monitor
 functions.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, kuifeng@meta.com
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-2-thinker.li@gmail.com>
 <feab44ce-8218-4e9d-a3f8-8d7109ef32e6@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <feab44ce-8218-4e9d-a3f8-8d7109ef32e6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/1/24 20:43, Martin KaFai Lau wrote:
> On 7/31/24 12:31 PM, Kui-Feng Lee wrote:
>> diff --git a/tools/testing/selftests/bpf/test_progs.h 
>> b/tools/testing/selftests/bpf/test_progs.h
>> index cb9d6d46826b..5d4e61fa26a1 100644
>> --- a/tools/testing/selftests/bpf/test_progs.h
>> +++ b/tools/testing/selftests/bpf/test_progs.h
>> @@ -473,4 +473,20 @@ extern void test_loader_fini(struct test_loader 
>> *tester);
>>       test_loader_fini(&tester);                           \
>>   })
>> +struct tmonitor_ctx;
>> +
>> +#ifdef TRAFFIC_MONITOR
>> +struct tmonitor_ctx *traffic_monitor_start(const char *netns);
>> +void traffic_monitor_stop(struct tmonitor_ctx *ctx);
>> +#else
>> +static inline struct tmonitor_ctx *traffic_monitor_start(const char 
>> *netns)
>> +{
>> +    return (struct tmonitor_ctx *)-1;
> 
> hmm... from peeking patch 3, only NULL is checked.
> 
> While at it, if there is no libpcap during make, is the "-m" option 
> available or the test_progs will error out if "-m" is used?

"-m" is still available so CI can always pass "-m" without consider
the configuration of the binary. But, it would be good idea to
print a warning message for this situation.

> 
>> +}
>> +
>> +static inline void traffic_monitor_stop(struct tmonitor_ctx *ctx)
>> +{
>> +}
>> +#endif
>> +
>>   #endif /* __TEST_PROGS_H */
> 

