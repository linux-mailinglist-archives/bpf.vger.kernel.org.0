Return-Path: <bpf+bounces-36508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDB8949AF3
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 00:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12441C2168F
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 22:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE97B172767;
	Tue,  6 Aug 2024 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhx06oHr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFEA16CD3A
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982038; cv=none; b=NrduHtS+h1CYRHrWAvU5jg1yc6FjezDIkXaVLoEZMC1ZtZv6GLdczVq7394LVvKE9QjslwEuiKO++tDN8vvUVrhcT5+jkF2N7xBwN4xk46kb6eMcrKRAoEb+OmwB136Wgl8acr6s0sdk/vq1gbZTrde2t8zsv9qgUKzMKkfcZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982038; c=relaxed/simple;
	bh=EX+CmKXNeeBTc9eszdGguy7rKrkgWI2cX1xI3FfD/rY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zu+H1/02iavHL1E+wZAnKsoA64TpLfYiovjsOhBJKHf7C6mIHGoBVHPEWJp0vWAPTY0REHVTbkeil0aneVpRWAFPUxy1mad+5n5qU5OIUaS+Nj1gkJ/oh58W/suKDhDfZO9Q9PfGsTa1BerceGhc/aJGu1SHjJH1Dba5nWdxaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jhx06oHr; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e04196b7603so1013877276.0
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722982036; x=1723586836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d5RZeOTPaFHjMXrTNQXtGmhbyC7NgaC30RGRH69aOro=;
        b=Jhx06oHrIEHggXEWS7i2oP+uyhybYPDhe8N/m8cwHQ2H4wRl3CcJli+eQGCaMOhFg4
         1KR7fVHd2+MhrDymEgeYUyvoiuvxdF++xivggTHMI41dQnpmOrzVXtJ4uBoa5WM2SXQH
         Y6KOhxS5BkdCobla6eGzHm+YWC0zwTPlJV7sZKlbdWRaXDnJ4F+4WU4828a6/5lAZH4S
         c0aCVbf2K0fxLP1A+cqT4Q0HdV9laCT9NMMsveqPoQUNlkpYyqTwWq1m9vz0KS82w2Bu
         GM1e9E6fVhMX5bTW8s5TB/x07LbV9AnaZBS50rGTr+ezBH5etescxgNCZHD5m9zJ/XfA
         gqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982036; x=1723586836;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5RZeOTPaFHjMXrTNQXtGmhbyC7NgaC30RGRH69aOro=;
        b=qNlsQAYkczkqCOgBkwNtXdd4LWw8w3GwG4mt/vmF6mCAJlFsp6F+9ywL6wRRA1+me6
         6PpqBHWkpLc0tiwgl5mJaFCNzGVBi3JDpCw0UeKmq0dJ0COgh6Zdf1AoPuG3fW/XPv5a
         Lj6RZSTYZxsKIlbPglP3LfcwgHTzyU/KZp8V2bxLhjskqhH0JRZbAXBO8pdlXKk4aZ3Z
         eDlADgVJy+/gWCjLWOokQazC6WvSIYarp1VAph4KUnt8CQjgHf/7waCREIDak4dFRD+b
         LnrIkXmPyIQ/8USeFlBTqopZv9V3ydJrlC631vD3pHVAMJRzXz7giJd+VR1kLKWgVOHw
         gepA==
X-Gm-Message-State: AOJu0YyUkwaAMnO3w/pYPHiNGsG6PAjTqzHMV+s3huNoplGo4TvJztzl
	pWBjgKiOsH86xSg3e/Da72Zc67OxehQkyahT5ZFKo/X4CT4A+6PVA2723Q==
X-Google-Smtp-Source: AGHT+IHH4wt9tTfgr5NMDHx2AU/JcFiyiNhDUdUEtThiBgzc6Hn1T/l/LPvqOZyC7lXZ83oHNb4gag==
X-Received: by 2002:a05:6902:2b12:b0:e0b:111d:313c with SMTP id 3f1490d57ef6-e0bdeae02b3mr16650690276.55.1722982035845;
        Tue, 06 Aug 2024 15:07:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:cfe6:adb2:c0bb:6a13? ([2600:1700:6cf8:1240:cfe6:adb2:c0bb:6a13])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0e46d119f1sm1157482276.2.2024.08.06.15.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 15:07:15 -0700 (PDT)
Message-ID: <9b76fb31-ef12-423a-b36d-30e1359a867a@gmail.com>
Date: Tue, 6 Aug 2024 15:07:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/6] selftests/bpf: Add traffic monitor
 functions.
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, kuifeng@meta.com
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-2-thinker.li@gmail.com>
 <feab44ce-8218-4e9d-a3f8-8d7109ef32e6@linux.dev>
 <283a022a-6764-4b66-8897-b8a307733e07@gmail.com>
Content-Language: en-US
In-Reply-To: <283a022a-6764-4b66-8897-b8a307733e07@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/1/24 21:35, Kui-Feng Lee wrote:
> 
> 
> On 8/1/24 20:43, Martin KaFai Lau wrote:
>> On 7/31/24 12:31 PM, Kui-Feng Lee wrote:
>>> diff --git a/tools/testing/selftests/bpf/test_progs.h 
>>> b/tools/testing/selftests/bpf/test_progs.h
>>> index cb9d6d46826b..5d4e61fa26a1 100644
>>> --- a/tools/testing/selftests/bpf/test_progs.h
>>> +++ b/tools/testing/selftests/bpf/test_progs.h
>>> @@ -473,4 +473,20 @@ extern void test_loader_fini(struct test_loader 
>>> *tester);
>>>       test_loader_fini(&tester);                           \
>>>   })
>>> +struct tmonitor_ctx;
>>> +
>>> +#ifdef TRAFFIC_MONITOR
>>> +struct tmonitor_ctx *traffic_monitor_start(const char *netns);
>>> +void traffic_monitor_stop(struct tmonitor_ctx *ctx);
>>> +#else
>>> +static inline struct tmonitor_ctx *traffic_monitor_start(const char 
>>> *netns)
>>> +{
>>> +    return (struct tmonitor_ctx *)-1;
>>
>> hmm... from peeking patch 3, only NULL is checked.

When traffic monitor is disable, these two functions are noop.
Returning -1 (not NULL) is convenient for the callers. They don't need
to tell if the error caused by a real error or by the disabled
feature.

>>
>> While at it, if there is no libpcap during make, is the "-m" option 
>> available or the test_progs will error out if "-m" is used?
> 
> "-m" is still available so CI can always pass "-m" without consider
> the configuration of the binary. But, it would be good idea to
> print a warning message for this situation.
> 
>>
>>> +}
>>> +
>>> +static inline void traffic_monitor_stop(struct tmonitor_ctx *ctx)
>>> +{
>>> +}
>>> +#endif
>>> +
>>>   #endif /* __TEST_PROGS_H */
>>

