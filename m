Return-Path: <bpf+bounces-62213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1203AF674D
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 03:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36DF1C42C14
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 01:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7196D16D9BF;
	Thu,  3 Jul 2025 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZJ07GuGQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976F4A00
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507324; cv=none; b=FNcWDrq4iJhtlTHvGpw8nFRIg0mtw3ED0++aj/MgF/TOFgCAw7HoMowyI8qX20zuLj1AXR9N2upbhVhYoYpqIAQ08CPouFLf9RKB5rIfItms4aYhxpyKUe1ZwxbAu+bjm1o/NbT6T/Gy8RVRyQajuEiB31LWHYQ+ajswTbvuX60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507324; c=relaxed/simple;
	bh=fwOvME9gHOk4vPa8/hrH22eILHc1rHglmmIdIqFHmjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYZb3TDoKiLxABUlC7SGGE77hg+Rivdx5gFfrIcR+2r6ak7+PDIcrYl6UtZ0K8i3XyYDq2925OqAF0GgmvCOQl2jxxTU+H44OTcEBnUSI+ZNpqT8HCTHZ0hzbxw+a9duhOsf2PKzwBJ+q8AB2wUqUjyGiznFycSGtnWxMIbwcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZJ07GuGQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234b9dfb842so48007125ad.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 18:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751507321; x=1752112121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ONCuaSmgTNGrqKsx9op+wo8f1iPov70krXh+LuYKBk=;
        b=ZJ07GuGQ/wPH/12jDt2+r4rnNl6bfOpkwxxvJKJOnhnVxduoh1gzusYvxqLmftx9lK
         7t0/9lqJyCJTRseBIuUrgxx1et/YsLeS/0pHpQ9Jtm0ITPAK4zBbeo6vHXDVgrLgDjT+
         r9WIK94K3GwMkbHIuWOcvOk2tJdPziq7UadnpON+VHtjgxbbXDFyiK7LraBla+y7hZqZ
         Sox9w3Cpl2CVEfbmtM1L05ilmV+JJRFYWN+lQIWiu3G2v7xo5Nij/5XYUO4jgBLhjfCn
         P9fKDz2++1LNumDuMpjaJ0NDB41wITMZ6giWUUJFnTVd2ewdEqUWXuRxqIsZQ5ImiM7k
         QksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751507321; x=1752112121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ONCuaSmgTNGrqKsx9op+wo8f1iPov70krXh+LuYKBk=;
        b=OYKR0j2zhkJS5Wg//zfzMXnAX0Z9jvmaR+5eOz8OBcrOv4nr26+ZcHijp6uzQ5lqrh
         KZKdVBvzmAoTLFE0laICt7oPj566px2pFiErTNigYzgZpgvpyv70UM81q+pltKUSO/X6
         solMp8sA3bcohiojLnJaCYFUDmngGj1OH6G9R9lwHdCwZBQLy/+T2hPbVG5It1CZrW5W
         nZqbnLfbCC992+RaiNeM0BFXY67MsffNv+ff85Az5DzhN/E9Hu0BHSaCiLz/08R1C/1k
         k5XmY7ntTdHGQ7oPuWdHdOhxl8Mx1CF1DYcRRO1wTr8yc0rm5ShxGUzSUkcpyO2pLcRF
         Beig==
X-Forwarded-Encrypted: i=1; AJvYcCXPCJ322JG8tXimXIkmrGBRD/ttgNU4Mjm6v3tudgX4eVXheoZNOJJfchRwPstbSVGMdmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIfRlB+T41lje3JCPB+fItYWfusU/EobutfVvFaenHpkeEk0B
	oxbUXjy2AaCQxN8ieObDRitZBmXE/KJ5vonbUsBktESRgKRRSW9m8lJ+Q5/Icj5mFvg=
X-Gm-Gg: ASbGncsP7/6kvLCTp/lB3zWRUSpJqodcRnXAge174GE9hc/e6YaRHcp7lJga5WaxSfB
	lNAklNa70sgUq2myi5buODBbPSzuI4tAsoOQshDkuFrNUHSaFDUDcKwZvlACEHPvpZLRYQiuaO/
	n/BExXvVWfcONzzwWG+t71iEdB40tN2ceD4gy6e09s1VUK3nm2+prpm8fg4H0d1BCO0p/4y5AzD
	q/MBvj3V7nUPhT/aFkpZEAQs73LmJ5G6KTDWTTucYuNTv9jLboxtBHwNnKCRytliAGosJqPPyAE
	p+IJg8UnxU8Hs9gLjRqVvAXEj85c008MWSxurzlVQZJnhAowAGo8F7QYJIOwyIV1xLht2DVWz/W
	m8V8wWg==
X-Google-Smtp-Source: AGHT+IHm6wYEI8D2E1XwvbLpl0mDe0XXxKcwDxcc/lYByPI7G+4Dcsy3TVt+BnBnSmzsGK+yDKJNIA==
X-Received: by 2002:a17:903:b8f:b0:234:b735:dca8 with SMTP id d9443c01a7336-23c6e4dbe0bmr73390605ad.6.1751507321454;
        Wed, 02 Jul 2025 18:48:41 -0700 (PDT)
Received: from [10.3.202.172] ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c94b3sm138117085ad.245.2025.07.02.18.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 18:48:41 -0700 (PDT)
Message-ID: <7b657a5d-0a79-49da-89fa-2d5e06e0cabb@bytedance.com>
Date: Thu, 3 Jul 2025 09:48:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch bpf-next v4 0/4] tcp_bpf: improve ingress redirection
 performance with message corking
To: Jakub Sitnicki <jakub@cloudflare.com>,
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com,
 zhoufeng.zf@bytedance.com
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
 <87v7oanb8d.fsf@cloudflare.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <87v7oanb8d.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/2/25 6:22 PM, Jakub Sitnicki wrote:
> On Mon, Jun 30, 2025 at 06:11 PM -07, Cong Wang wrote:
>> This patchset improves skmsg ingress redirection performance by a)
>> sophisticated batching with kworker; b) skmsg allocation caching with
>> kmem cache.
>>
>> As a result, our patches significantly outperforms the vanilla kernel
>> in terms of throughput for almost all packet sizes. The percentage
>> improvement in throughput ranges from 3.13% to 160.92%, with smaller
>> packets showing the highest improvements.
>>
>> For latency, it induces slightly higher latency across most packet sizes
>> compared to the vanilla, which is also expected since this is a natural
>> side effect of batching.
>>
>> Here are the detailed benchmarks:
>>
>> +-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
>> | Throughput  | 64     | 128    | 256    | 512    | 1k     | 4k     | 16k    | 32k    | 64k    | 128k   | 256k   |
>> +-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
>> | Vanilla     | 0.17±0.02 | 0.36±0.01 | 0.72±0.02 | 1.37±0.05 | 2.60±0.12 | 8.24±0.44 | 22.38±2.02 | 25.49±1.28 | 43.07±1.36 | 66.87±4.14 | 73.70±7.15 |
>> | Patched     | 0.41±0.01 | 0.82±0.02 | 1.62±0.05 | 3.33±0.01 | 6.45±0.02 | 21.50±0.08 | 46.22±0.31 | 50.20±1.12 | 45.39±1.29 | 68.96±1.12 | 78.35±1.49 |
>> | Percentage  | 141.18%   | 127.78%   | 125.00%   | 143.07%   | 148.08%   | 160.92%   | 106.52%    | 97.00%     | 5.38%      | 3.13%      | 6.32%      |
>> +-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
> 
> That's a bit easier to read when aligned:
> 
> | Throughput |    64     |    128    |    256    |    512    |    1k     |     4k     |    16k     |    32k     |    64k     |    128k    |    256k    |
> |------------+-----------+-----------+-----------+-----------+-----------+------------+------------+------------+------------+------------+------------|
> |    Vanilla | 0.17±0.02 | 0.36±0.01 | 0.72±0.02 | 1.37±0.05 | 2.60±0.12 | 8.24±0.44  | 22.38±2.02 | 25.49±1.28 | 43.07±1.36 | 66.87±4.14 | 73.70±7.15 |
> |    Patched | 0.41±0.01 | 0.82±0.02 | 1.62±0.05 | 3.33±0.01 | 6.45±0.02 | 21.50±0.08 | 46.22±0.31 | 50.20±1.12 | 45.39±1.29 | 68.96±1.12 | 78.35±1.49 |
> | Percentage |  141.18%  |  127.78%  |  125.00%  |  143.07%  |  148.08%  |  160.92%   |  106.52%   |   97.00%   |   5.38%    |   3.13%    |   6.32%    |
> 

Thanks for the suggestion!

>>
>> +-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
>> | Latency     | 64        | 128       | 256       | 512       | 1k        | 4k        | 16k       | 32k       | 63k       |
>> +-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
>> | Vanilla     | 5.80±4.02 | 5.83±3.61 | 5.86±4.10 | 5.91±4.19 | 5.98±4.14 | 6.61±4.47 | 8.60±2.59 | 10.96±5.50| 15.02±6.78|
>> | Patched     | 6.18±3.03 | 6.23±4.38 | 6.25±4.44 | 6.13±4.35 | 6.32±4.23 | 6.94±4.61 | 8.90±5.49 | 11.12±6.10| 14.88±6.55|
>> | Percentage  | 6.55%     | 6.87%     | 6.66%     | 3.72%     | 5.68%     | 4.99%     | 3.49%     | 1.46%     |-0.93%     |
>> +-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
> 
> What are throughput and latency units here?
> 
> Which microbenchmark was used?

Let me add some details here,

# Tput Test: iperf 3.18 (cJSON 1.7.15)
# unit is Gbits/sec
iperf3 -4 -s
iperf3 -4 -c $local_host -l $buffer_length

During this process, some meta data will be exchanged between server
and client via TCP, it also verifies the data integrity of our patched
code.

# Latency Test: sockperf, version 3.10-31
# unit is us
sockperf server -i $local_host --tcp --daemonize
sockperf ping-pong -i $local_host --tcp --time 10 --sender-affinity 0 
--receiver-affinity 1

