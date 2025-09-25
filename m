Return-Path: <bpf+bounces-69708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF74B9EDB5
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 13:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55B374E1091
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 11:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB12F6170;
	Thu, 25 Sep 2025 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObxWacTp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E7B266EEA
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798198; cv=none; b=m3ssddxgUZ9vZIe7QqUHcQCeHCA6y7bBM3WAxicUy3dtiloJ1gQqTj4HAV0Qp3XMLd4eOpTCsYLA7MJbQyBOHwoimzU7inly8YtNHtzUwz+xS6WMB3dUbnl7WRyGGHQv1U+1Pbl+r1BlVGdlmvHNh5Zlcf/7fr3HxzalKF+4VZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798198; c=relaxed/simple;
	bh=5f5jzmY/8z4+Z/yXxNdh/MioRwPbuZwA+8mB7aWl2NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtgG8y6miTZrkAe7JF/grQNNBc/Ndp8XCULUeRWPwxMR0RNI5iHqNpOT6M/Sf+ulFPn3gzn13G2ArduUa7Br/bTG/cRbd3eDoVVn0iEkd+NMdl/KtGh+iMsN+TQBv3w7cj77QGdBVxFdnBhjsBO2G/wJt30y4MSJg7UowBEoGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObxWacTp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b2ad83fe986so14387966b.3
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 04:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758798195; x=1759402995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kbayy13shJENppb8XOVzKg697zuEvFkUeRfz0DCdeZk=;
        b=ObxWacTpU7Po3m5cDA2rCo7GRT5kKJHL3jxsWrtdYiMkwiGoMhZxEEmboziMo9JJFh
         OWlXBt6dh4pUWNLU+RNNPGRI0gJBnvlLOuOOG8oM0xIhGVohcCUErFBFV+9Hhq9jL5fK
         Hd2G9Hk3f/ZXgVp/McpZwVl5YO99Ook1E6onuuJ/rPxWkk2iVwQdYcAHZ4qTBKV0HHf9
         ki7wvGfeiMUMuxXkWBdnFolxs0+xSydebIfhcfPBzH6Qbko5/mNRaVadckYwdNrJ3dSe
         DHRj6jVf3qcgIEVaFQKVLgxGAGXFf3X/yehHOLmJlFP5B82RZiawoPsGsLw8YsHbuH+T
         ptzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758798195; x=1759402995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kbayy13shJENppb8XOVzKg697zuEvFkUeRfz0DCdeZk=;
        b=koGg1f7x3VkgKWniiVp62bdWBo6Ssk44uUt0sbkXsIc8rCm3Y5LlSs3WAq3r9JZFFp
         5IafLQpYFJZsphPcM5Mi8cyy+v5gQMNdTTpdWy4OG67R6NIPkaAagFqqjDb935OCcQXO
         MLoDmpER2J0v6B5gN2TGfFk+HgXqYt1WUc82qlPrb863CMLndLyfu9ei2Bq8r82TSYFx
         X7/LSFEv43qeTGQZNFPjEnauPuZdqrE5SYg4i65lt968HcwdCd4PF6GYo6jXAG1Ujj9O
         A3dJ6N+Fj4UDna72TU05XHlI+W5shq/F0+40P28zFwdEGdk26YLZ4DgZbtdE/xp9CJDG
         UbRg==
X-Forwarded-Encrypted: i=1; AJvYcCXXgUpwzJPKTDGifabTCnxTZsQRtdXBTrqd/nr9hhxw3r/T0LqTYSUq5MtZteFNfGsd+WA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6a6KCp7V0pINoFpwQvjylgUxSxStWBtNJovAHwIHo/eb7dLnf
	lrHCDNTPGTXF4Hfgk3DFtM349MAPu1FdcxYdgWfk8G3rzPZ+P4B2OPfo
X-Gm-Gg: ASbGnctCUWj05enLSyqGY1Z4PmdRvHKXeMceItf8A+6Vg4E39f5O24uZ+ftQhbIREI0
	JyiI/yfiNS3+t/IhkmNcR6nQTRoMS07NPfuWDjnXdhSiC37UqR3lQgKvcohV3Tj/XtBxbdQurwh
	pJ61BLwuo+Td5ZGTEWnqt2nZbFD14B05CxuwATCwPzCBI8eVbWG9p7jF4fLA/sqXdGLbmb4qds6
	xaBNkJqGQFnxtjvWNUeWSSSAE9ARqtFQ3HJr1Jz6ej/4jZWkQHwXDbJZaGrNGpxV/qstd7ucCM3
	a2uZK+B78SQqSyFgcmaWxQM5hF/+77n1YPlCTEQEop5YoJ0Uq/54IHiEdD8Nx2epEmmI+JmwkpA
	EsceGn3ZgCQ8AVxJu7AUdTkEqMs8J1uMctDHIGaMg2mgOpexWGKMPlZEz7ZjQIQ==
X-Google-Smtp-Source: AGHT+IE+FDIp8REoReNlisltZxekgZurykBl8HQME4zI0tHguqI3KAp9IuApteihHX89I/9CUSSgZw==
X-Received: by 2002:a17:907:868d:b0:afe:88ac:ab9 with SMTP id a640c23a62f3a-b34bbeba6d0mr166541366b.9.1758798195396;
        Thu, 25 Sep 2025 04:03:15 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7806sm147331066b.70.2025.09.25.04.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:03:15 -0700 (PDT)
Message-ID: <941fece6-9660-4aa8-91ed-346b0c2d97c1@gmail.com>
Date: Thu, 25 Sep 2025 13:03:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, andrew+netdev@lunn.ch,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, matttbe@kernel.org, chuck.lever@oracle.com,
 jdamato@fastly.com, skhawaja@google.com, dw@davidwei.uk,
 mkarsten@uwaterloo.ca, yoong.siang.song@intel.com,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org, horms@kernel.org,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
 <87h5wq50l0.fsf@cloudflare.com>
 <0cddb596-a70b-48d4-9d8e-c6cb76abd9d2@gmail.com>
 <87348a4yyd.fsf@cloudflare.com>
 <e85e7bb2-6229-4b04-9c2a-7a7b79497c6c@gmail.com>
 <87y0q23j2w.fsf@cloudflare.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <87y0q23j2w.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/25 11:47 AM, Jakub Sitnicki wrote:
> On Thu, Sep 25, 2025 at 12:28 PM +01, Mehdi Ben Hadj Khelifa wrote:
>> On 9/25/25 11:18 AM, Jakub Sitnicki wrote:
>>> On Thu, Sep 25, 2025 at 11:54 AM +01, Mehdi Ben Hadj Khelifa wrote:
>>>> On 9/25/25 10:43 AM, Jakub Sitnicki wrote:
>>>>> On Tue, Sep 23, 2025 at 10:00 PM +01, Mehdi Ben Hadj Khelifa wrote:
>>>>>>     This patch series is intended to make a base for setting
>>>>>>     queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
>>>>>>     the right index. Although that part I still didn't figure
>>>>>>     out yet,I m searching for my guidance to do that as well
>>>>>>     as for the correctness of the patches in this series.
>>>>> What is the use case/movtivation behind this work?
>>>>
>>>> The goal of the work is to have xdp programs have the correct packet RX queue
>>>> index after being redirected through cpumap because currently the queue_index
>>>> gets unset or more accurately set to 0 as a default in xdp_rxq_info. This is my
>>>> current understanding.I still have to know how I can propogate that HW hint from
>>>> the NICs to the function where I need it.
>>> This explains what this series does, the desired end state of
>>> information passing, but not why is does it - how that information is
>>> going to be consumed? To what end?
>>
>> In my vision,The queue index propagated correctly through cpumap can help xdp
>> programs use it for things such as per queue load balancing,Adaptive RSS tuning
>> and even maybe for DDoS mitigation where they can drop traffic per queue.I mean
>> if these aren't correct intents or if they don't justify the added code, I can
>> abort working on it. Even if they weren't I need more guidance on how I can have
>> that metadata from HW hints...
> 
> Both filtering or load balancing you'd want to do early on - in the XDP
> program invoked on receive from NIC, which as Stanislav pointed out
> already has access to the RX queue index in its context. Not on the
> remote CPU after spending cycles on a redirect.
> 
> And even if you wanted to pass that information to the remote XDP
> program, to do something with it, you can already store it in custom XDP
> metadata [1].
> 
> So while perhaps there is something that you can't do today but would be
> useful, I don't know what it is. Hence my question about the use case.
> 
> [1] https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/
> 
Very clear,
I will abort working on this since it can be passed as a custom XDP 
metadata [1] until further valid use cases or when it proves to be more 
useful.
Thank you for your review and time.
Best Regards,
Mehdi

[1] https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/

