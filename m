Return-Path: <bpf+bounces-43375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F539B44F1
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 09:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FEC1F23617
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 08:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B14204016;
	Tue, 29 Oct 2024 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aqu9yBjf"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092BB202F65;
	Tue, 29 Oct 2024 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192027; cv=none; b=YIAfnEym/rQXFsYBVISfS7YV7F6u7kPmi77hbG1ADzKRKU/DJfORtLA0v3Or9tltk1ZJA8R5VUH9b2fQ0kKAEpWjxOOaBNKqPIwIJu8ajJsgWIsH9nq650ek937FTLnwbDB7gVGB90g9qo8PTTd/bX8DiPrHEGI5eBOZ/8OmoSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192027; c=relaxed/simple;
	bh=NUDfHzpgvwtFN8S/aGIOzqeUmw35b48McIqHcpnpjA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEpK95hX8QPdvjkhXR6Xex5+XjNUap9cp9f0aMPjmpa9yTfJY23vwFOg944duSXRSQ7pUFLcAuMeSilDOWM7JwWBuQqtmRXDLSeNZL/FrO6oLXn5N9cZkzoWb++gQIcEL7+3lf277g03+gPifAnPXNXRU6KIcyiHZZfVZSY4Zs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aqu9yBjf; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730192015; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=C4q6AZ5epUS0ebuNy5NrOSpGSl5KxkoPC+ENG01pkzQ=;
	b=aqu9yBjfUvfEqNLUhxmXGNW8KGvjRvQpGpm0MaSWP9KC8pd7bFTwgvfnVByFHVitVUzDRmhOIZdjDc9VOre721Etex9oWqX+/AdkQKVMzk3UXIz11r1lceKLs7Gp+y4x2qZeNsTtLMYh7TJDReVGkiduV9INA1iU7xHAVbUt97k=
Received: from 30.221.150.77(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WI9XYwI_1730192012 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Oct 2024 16:53:33 +0800
Message-ID: <8ef927a3-050b-4d5f-9298-efc58f6a57bb@linux.alibaba.com>
Date: Tue, 29 Oct 2024 16:53:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] net/smc: Introduce smc_bpf_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, dtcccc@linux.alibaba.com
References: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
 <1729737768-124596-4-git-send-email-alibuda@linux.alibaba.com>
 <74c06b43-095f-414a-b4aa-2addbe610336@linux.dev>
 <e398770a-1ab5-478b-820d-16c6060e0008@linux.alibaba.com>
 <0e5712f2-7ecc-457a-afb7-4b304eb1bffa@linux.dev>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <0e5712f2-7ecc-457a-afb7-4b304eb1bffa@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/24 2:30 AM, Martin KaFai Lau wrote:
> On 10/25/24 4:05 AM, D. Wythe wrote:
>> Our main concern is to avoid introducing kfuncs as much as possible. For our subsystem, we might 
>> need to maintain it in a way that maintains a uapi, as we certainly have user applications 
>> depending on it.
> 
> The smc_bpf_ops can read/write the tp and ireq. In patch 4, there is 'tp->syn_smc = 1'. I assume the 
> real bpf prog will read something from the tp to make the decision also. Note that tp/ireq is also 
> not in the uapi but the CO-RE can help in case the tp->syn_smc bool is moved around.
> 
>  From looking at the selftest in patch 4 again, I think all it needs is for the bpf prog (i.e. the 
> ops) to return a bool instead of allowing the bpf prog to write or call a kfunc to change the tp/ireq.
> 

Hi Martin,

At the beginning, I did modify it by returning values, but later I wanted to make this ops more 
universal, so I considered influencing the behavior by modifying the tp without returning any value. 
But considering we currently do not have any other needs, perhaps modifying it by returning a value 
would be more appropriate.

And If that's the case, we won't need to add new prog parameters to the struct_access anymore. I'll 
try this in the next series.

Thanks,
D. Wythe


