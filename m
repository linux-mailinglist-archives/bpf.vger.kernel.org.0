Return-Path: <bpf+bounces-65993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B53B2BF34
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 12:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A63D7A5BCB
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 10:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499E1322C84;
	Tue, 19 Aug 2025 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ0BtviM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FB8224B1B
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600298; cv=none; b=EY+uJSTBZb91ZXq0UjZHxE74nM+MdAWFAgAKDGL6TUdgH41JOSbnfv4jrOyOoL0zu9hEfQW9oT7b8RB4jh2MXnjwm5Ov5VChpEZUuQCNiqedYBFmAvIVAK0LXGecMN9LubGNN/tXh5tOPuqGQTlu2QGHxbJ1XZ7Fy+8iDSrRS6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600298; c=relaxed/simple;
	bh=AWaSFBGzsVBGHMUEwoh4kn4DPt9GNn+Sl9obPW9o+Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akGqKTk3N+679paseeBASba5qNR+Pa5Rqg61QUp8jqn/DwfdwCRde+rNwjZuI1QeCi7+UigN1/PkB9zZmJTs914yHPPwImQRMhTsDnNWYAiMQaoFX/AMHC8Z8ejU17Uj+aaIAHwyErnd/darvOheALEj+808Eqa1QuNuFbXQJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ0BtviM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3bea24519c0so1108769f8f.1
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 03:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755600295; x=1756205095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMaZ3A2hVT9tVgIVgNmHrlX+dceLWmSqJc0nzB1+rP8=;
        b=dJ0BtviMGaoDds3pVgvTiJDTAQFysnT1A/3GbRpFdgQUSwylfvWO0O/IZWQiw/+P4x
         gg/wvMmjR/VyHCfnnYwbrLVYJYI1d9haHRcnCm1EQ1tPRnsVPXSQT6u3zUJW0PKLPG9+
         HecUym2hAKY/0qpymr4kGqTYcB6LVfZnaJh8qvctezAJ8FdLWMYwspoHOH2uVFAvvheD
         iwX4D2TJfKP7e40E1JVbHYl3U/+bDoI7mxbzkUyH3Ftfjf3N4AfEb03wCEsIkKPwwLlu
         VSmx8KP8J3tsdmNK4o9Y6nLAyM0ioJw5hZ1CqmUcPjbY2Q/A1SsrGF4aziBKm7EwqYMq
         zgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600295; x=1756205095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMaZ3A2hVT9tVgIVgNmHrlX+dceLWmSqJc0nzB1+rP8=;
        b=nrgaA4x84OEwUoCvWjuiyqoDuiFY49zON0S3ry8rDaJKF5PAC/S+64ycnhRfOAzQA1
         Bpy8qr7dq80Ff5Hv1y7IzPWnxyg/2n8n3UQm6PICkGXT9Bg2a4TMBmAt0U0AhDERSWph
         yQZXOd265K/67md6abdfoggW/mRmSN4Rqij3RfyqpXiH4k8P4IpIQCy9n+33NgTvkjbg
         ZTR2FcJUZ11idVclTqms9LfZNYlDBr7MUdB4oq4VDu4J8o4KsrtQrHcHyaXcopNKTjGd
         oneMBuN7wqo5AQxmOhHOaT9cP8DrGSNg34H8C6YySqQYti38vlxpYipofZGEk+SnBvj4
         67xw==
X-Forwarded-Encrypted: i=1; AJvYcCXiEYTd4KbHtNQtTQftfg0ttKg4LqfPeLd9JCXyUoJJZvhJUrCzjuFG5V9laawRsuXX3aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbO707FOIfseqWAc/IM0A7mSqG7en7qGwt0gh0QxX5NrU5oaR8
	+w5MjMqtyAs3hHNyhdJeJACOHxzJvbZO1FswxZrmSAjw1+QyY0zLeOPn
X-Gm-Gg: ASbGncuSnFj2v5MRHHj9jIzmD31ngucW3fRhATCFBurWODh7DeehdxSq9eWnAbwsexf
	b0GxvhqTDkX6A7z1xdHhi5yg68oAWlLsc0j6R1htFAiUpdRfceHEB+SmcAz7yP2VQQx9eHPeB1y
	uzIeqtBginexTQn9xN7zXXHpPUWlSQA+QK34YAzSLDiBSyf84uDT6Lqdr+sMa7Xye5hsCkYZA3I
	br/QVDarhWwrWElimcEZFugZbaHWl0ryr/ZcBujTdE6vRDldH1lNeiivp3QBgAjf8fTI4WF4/iX
	MqP6l8A3zsQUNLfCx2S9+Vqqq8WAVn2fZU9vcH6NVCXvOoKQQuPHsuL88Deiu3SgyTXjHeqPHQT
	BrHdmpujwymz0OGESSzVgVZkYX0XgGotTpYEZh+aCfBxscyNmZdvGDocd7l32ZhsTJi0lFc0=
X-Google-Smtp-Source: AGHT+IHdKswvM0sTBgUmTLXm9h0m3Bc+fhe+XtbKt+QKbkIQIKsCxnlYFb6o6RmzK4zKcJOPeYGaGw==
X-Received: by 2002:a05:6000:2dc3:b0:3a5:8991:64b7 with SMTP id ffacd0b85a97d-3c133c6de96mr1675962f8f.26.1755600294982;
        Tue, 19 Aug 2025 03:44:54 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::4:ba2b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6cd044sm220915995e9.9.2025.08.19.03.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 03:44:54 -0700 (PDT)
Message-ID: <a24d632d-4b11-4c88-9ed0-26fa12a0fce4@gmail.com>
Date: Tue, 19 Aug 2025 11:44:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 mm-new 0/5] mm, bpf: BPF based THP order selection
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com,
 willy@infradead.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, ameryhung@gmail.com, rientjes@google.com,
 bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250818055510.968-1-laoar.shao@gmail.com>
 <36c97fc6-eaa9-44dd-a52f-0b6bf5a001d9@gmail.com>
 <CALOAHbAQ=51mfszBN+Bvb9z+ZDyTBuCW_s0EKi+5rDghFvRZzg@mail.gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALOAHbAQ=51mfszBN+Bvb9z+ZDyTBuCW_s0EKi+5rDghFvRZzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 19/08/2025 03:41, Yafang Shao wrote:
> On Mon, Aug 18, 2025 at 10:35 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 18/08/2025 06:55, Yafang Shao wrote:
>>> Background
>>> ----------
>>>
>>> Our production servers consistently configure THP to "never" due to
>>> historical incidents caused by its behavior. Key issues include:
>>> - Increased Memory Consumption
>>>   THP significantly raises overall memory usage, reducing available memory
>>>   for workloads.
>>>
>>> - Latency Spikes
>>>   Random latency spikes occur due to frequent memory compaction triggered
>>>   by THP.
>>>
>>> - Lack of Fine-Grained Control
>>>   THP tuning is globally configured, making it unsuitable for containerized
>>>   environments. When multiple workloads share a host, enabling THP without
>>>   per-workload control leads to unpredictable behavior.
>>>
>>> Due to these issues, administrators avoid switching to madvise or always
>>> modes—unless per-workload THP control is implemented.
>>>
>>> To address this, we propose BPF-based THP policy for flexible adjustment.
>>> Additionally, as David mentioned [0], this mechanism can also serve as a
>>> policy prototyping tool (test policies via BPF before upstreaming them).
>>
>> Hi Yafang,
>>
>> A few points:
>>
>> The link [0] is mentioned a couple of times in the coverletter, but it doesnt seem
>> to be anywhere in the coverletter.
> 
> Oops, my bad.
> 
>>
>> I am probably missing something over here, but the current version won't accomplish
>> the usecase you have described at the start of the coverletter and are aiming for, right?
>> i.e. THP global policy "never", but get hugepages on an madvise or always basis.
> 
> In "never" mode, THP allocation is entirely disabled (except via
> MADV_COLLAPSE). However, we can achieve the same behavior—and
> more—using a BPF program, even in "madvise" or "always" mode. Instead
> of introducing a new THP mode, we dynamically enforce policy via BPF.
> 
> Deployment Steps in our production servers:
> 
> 1. Initial Setup:
> - Set THP mode to "never" (disabling THP by default).
> - Attach the BPF program and pin the BPF maps and links.
> - Pinning ensures persistence (like a kernel module), preventing
> disruption under system pressure.
> - A THP whitelist map tracks allowed cgroups (initially empty → no THP
> allocations).
> 
> 2. Enable THP Control:
> - Switch THP mode to "always" or "madvise" (BPF now governs actual allocations).


Ah ok, so I was missing this part. With this solution you will still have to change
the system policy to madvise or always, and then basically disable THP for everyone apart
from the cgroups that want it?

> 
> 3. Dynamic Management:
> - To permit THP for a cgroup, add its ID to the whitelist map.
> - To revoke permission, remove the cgroup ID from the map.
> - The BPF program can be updated live (policy adjustments require no
> task interruption).
> 
>> I think there was a new THP mode introduced in some earlier revision where you can switch to it
>> from "never" and then you can use bpf programs with it, but its not in this revision?
>> It might be useful to add your specific usecase as a selftest.
>>
>> Do we have some numbers on what the overhead of calling the bpf program is in the
>> pagefault path as its a critical path?
> 
> In our current implementation, THP allocation occurs during the page
> fault path. As such, I have not yet evaluated performance for this
> specific case.
> The overhead is expected to be workload-dependent, primarily influenced by:
> - Memory availability: The presence (or absence) of higher-order free pages
> - System pressure: Contention for memory compaction, NUMA balancing,
> or direct reclaim
> 

Yes, I think might be worth seeing if perf indicates that you are spending more time
in __handle_mm_fault with this series + bpf program attached compared to without?

>>
>> I remember there was a discussion on this in the earlier revisions, and I have mentioned this in patch 1
>> as well, but I think making this feature experimental with warnings might not be a great idea.
> 
> The experimental status of this feature was requested by David and
> Lorenzo, who likely have specific technical considerations behind this
> requirement.
> 
>> It could lead to 2 paths:
>> - people don't deploy this in their fleet because its marked as experimental and they dont want
>> their machines to break once they upgrade the kernel and this is changed. We will have a difficult
>> time improving upon this as this is just going to be used for prototyping and won't be driven by
>> production data.
>> - people are careless and deploy it in on their production machines, and you get reports that this
>> has broken after kernel upgrades (despite being marked as experimental :)).
>> This is just my opinion (which can be wrong :)), but I think we should try and have this merged
>> as a stable interface that won't change. There might be bugs reported down the line, but I am hoping
>> we can get the interface of get_suggested_order right in the first implementation that gets merged?
> 
> We may eventually remove the experimental status or deprecate this
> feature entirely, depending on its adoption. However, the first
> critical step is to make it available for broader usage and
> evaluation.
> 


