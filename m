Return-Path: <bpf+bounces-71148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07407BE5669
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 22:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE205E55C8
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274302DF14C;
	Thu, 16 Oct 2025 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5pWjFNo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AE914F112
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646500; cv=none; b=b6A8+NOMSkB6UidPO7xP56vA6PHowKQ55Q6BLvqVH/G6pBEeqBMLW6uq1hr6g2IRM1gqnDxvH7FS+9NMFzZC8AmNCSaoP9yD2snxcu9iub5YAt++xPWM0LqkxGqOq233HSuFzAAcaHMHfZ5Gr/PXmU1xx8TeKgxCg5NyJPVqMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646500; c=relaxed/simple;
	bh=st8CE9lSuHr+S9UOZSYikJT8QbGSDyWDzzQM1KcjVRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcSj2h7H9cwmivtQcx//e3BDAPe7hNhFQ0i2z7+/VGDtjfnsvs7Vxi0jUTgNCfgrH9TFDrH/0P1Ci7s3AQ7Cr1W30xefIf0nGOycTe8UVd/cWEQYUsyER0yBMvRtjUMqET3MSyiVTY4wCs5s4Y2I7woYshfCLNCUEzqgrk2tWRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5pWjFNo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-78118e163e5so2117992b3a.0
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760646499; x=1761251299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jY39mXgVcMN9xXBrEeHr/JB2nDeThDXcp+1mm32IdM=;
        b=Y5pWjFNoMFuga+piOB20DKpQqJSOgtBUvga9OwP/+NdW1PyKmFNIE5b1ajws+2AVe1
         K6yFsKzxjO8OpiCoaYUSG6XCWrOGDkzIJGNH0Z5dyV5D4cDey1Eegc6Sos/RlztDOXLz
         M/x9ZvO67bjp+DXLtUN/R0I3YeYW/k9Xh6pLJgWyyam0qUYRBz+TkOLFqrLjCUVzBWih
         LgLtvg4qG2eSZtMpCJy2YzWkRvPTXV0wZKF7SsW5J+ZNw5Zynd6mNJP++i9DxwD7oemi
         /XZ9kSL6jy/B9ikPgaBlF0nLIWZcbg1wvYpjyuqAHsdlzuIlzLvWN+kKawIZKdyQdY9d
         OjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646499; x=1761251299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jY39mXgVcMN9xXBrEeHr/JB2nDeThDXcp+1mm32IdM=;
        b=irgEvbtD09UcgjszHVnDB9pVKW/K26A9Sl9aT3fSbB3U0qLqgWBn40sJigT7Hihnc1
         QCsmWFgJdEhqIlk4QcGMMxQDSrHL88WGtWOx/u1YyXiAFCaJKJ8FfFSVDiT5WQbJnryx
         2O3CYyc9RGgz3rm1E1B+NzS0tF+4b+BJUlFklLXvyed9LATsVxzU3vinDkx8OwlTnhDw
         9AKYECh1e0RSHssopWT14twsZ739MTdTrlbaBAn16DscAQWNt01rd3ibWRkZk6pHU9c0
         Y8aY4tekblLSRE9/OMD2tVgHlkvmxKEn5czKCuiTzzr4ORom2jkPh+nyRzlI47mBfMU+
         VomA==
X-Forwarded-Encrypted: i=1; AJvYcCWcnQCDaWSZ6RbV4eSGU88RbXpP3YtpeRRNy6jeUYTMcZT6xbQiTZWGEZtiG692rrvS73M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKg4zz7wG91lSA0hNDGlQiRL4YDisT/jUK3x7tSv0Becwl9hhW
	bk0VGZo3gY9GDRDrSp5rM35Avb56YbUtY3H0zhRnp4Z5lvJIP0P8FxKW
X-Gm-Gg: ASbGnct/FtIo/zpHuD3HW6wMkqWbBlA7jPD0DPzC+PE/mnK/qEQZMNa/MnpLsLjf/Fh
	22qEFZOAYxciTNvIyey6tkbuf4/btG4EWmgka25EneqKhH+Lgr0t1y+jBetFu/FSCoZU5cEsIYJ
	9NRxIOPcFSNcvtBNIWVgV1z5lRoTauYQB4XMRxUo352tu+lU+38kdXgGSZyDxwvhNkzlBlwdC83
	ye3rvno0QiXcRncwqFDFzgPlY4yWFiXg/GU7Jf6/FRwVYhIoHkoQlAUfpVpW/GQhp7iO4j7uxzX
	b+mZpPrp0hrJfDabA83jyxn4uP94ckFyPk+qPBLCi0A0M/SX0ZXqHoPNAJCvnU+YhL8l+jh3jN5
	ptZVa3iW9H3lzbl6/YydeWPTWbHcU00eCUiQMH31L1urq30fCSMC4SswC99R9ZidlTwTJ89Hnp8
	U8sXh/tDKB9n+C/vwzTKrV8S7qMCza4WOyQYRFIrEHe/r8
X-Google-Smtp-Source: AGHT+IGWLWyH0AABkRz6alBvUVzPFctljtKTWRYOwESGtF7UJb7utW5OdfjqyV+JPgqFQydchn8xQQ==
X-Received: by 2002:a17:90b:3f0e:b0:327:c583:add with SMTP id 98e67ed59e1d1-33b9e0a4c2dmr5398538a91.6.1760646498534;
        Thu, 16 Oct 2025 13:28:18 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:6028:a61a:a132:9634? ([2620:10d:c090:500::5:e774])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd79dda6fsm337108a91.10.2025.10.16.13.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 13:28:17 -0700 (PDT)
Message-ID: <b4418948-61ce-4cf1-a3d2-a4208e73d5b3@gmail.com>
Date: Thu, 16 Oct 2025 13:28:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] memcg: introduce kfuncs for fetching memcg stats
To: Song Liu <song@kernel.org>
Cc: shakeel.butt@linux.dev, andrii@kernel.org, ast@kernel.org,
 mkoutny@suse.com, yosryahmed@google.com, hannes@cmpxchg.org, tj@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 kernel-team@meta.com
References: <20251015190813.80163-1-inwardvessel@gmail.com>
 <20251015190813.80163-2-inwardvessel@gmail.com>
 <CAHzjS_s3L7f=Rgux_Y3NQ7tz+Jmec5T8hLyQCxseLJ9-T-9xuQ@mail.gmail.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <CAHzjS_s3L7f=Rgux_Y3NQ7tz+Jmec5T8hLyQCxseLJ9-T-9xuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/25 4:12 PM, Song Liu wrote:
> On Wed, Oct 15, 2025 at 12:08 PM JP Kobryn <inwardvessel@gmail.com> wrote:
>>
> [...]
>> ---
>>   mm/memcontrol.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 4deda33625f4..6547c27d4430 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -871,6 +871,73 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
>>   }
>>   #endif
>>
>> +static inline struct mem_cgroup *memcg_from_cgroup(struct cgroup *cgrp)
>> +{
>> +       return cgrp ? mem_cgroup_from_css(cgrp->subsys[memory_cgrp_id]) : NULL;
>> +}
>> +
> 
> We should add __bpf_kfunc_start_defs() here, and __bpf_kfunc_end_defs()
> after all the kfuncs.

Good call.

> 
>> +__bpf_kfunc static void memcg_flush_stats(struct cgroup *cgrp)
> 
> We mostly do not make kfunc static, but it seems to also work.
> 
>> +{
>> +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
>> +
>> +       if (!memcg)
>> +               return;
> 
> Maybe we can let memcg_flush_stats return int, and return -EINVAL
> on memcg == NULL cases?

Sure, I'll do that in v3.

> 
>> +
>> +       mem_cgroup_flush_stats(memcg);
>> +}
>> +
> [...]


