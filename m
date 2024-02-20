Return-Path: <bpf+bounces-22285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4289885B22F
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 06:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD2DB216B9
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 05:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF54656B69;
	Tue, 20 Feb 2024 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqZNzvVD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430958200
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 05:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708406041; cv=none; b=q8jBYelEqyk0ZpKV4B8o3lRfaqNtLjxWrSYuS18R2T8skB0iPVagX9g/bJdCd55hFU98FWURUe3CYCZMsnUv4Q0P0AeZBImX8o8ZpQ2xB0g6c5BvdCnaJE14TfeNRgH2M3U6OkaEGPixBzQFKn0S414CkxBKHy7eugZ+7ZWk4p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708406041; c=relaxed/simple;
	bh=SnCquiRHG+tuOrqplLHoLxUoj7Zk3KruL/RRCf0wXAM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MQARJ+IXshau+GvtjZMCp8beqbq/KZQb4FQRjrXJH6AxNuIbTyTHH+O/oO2ejBshkMtI1/QCqaEXthZteG8jCL4SK9Y8QpGXUUlE5QgH6mIdlyJ5dhOPBCg6lPn21XbSgyxZcmLl0ZbMmUf/4PL6+pophfsj35uLQYHA51TAoVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqZNzvVD; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59cb1e24e91so1645708eaf.0
        for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 21:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708406039; x=1709010839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzrntOTnATKrmrMPqPc0IcHlRZEPZIas22xlEfiYJGs=;
        b=IqZNzvVDGLqF1/GXf2pRDpzx47TjoHlWabZi/3QmD86CyfAYQ1bbGS2kw5UpeSkE8l
         xDUvapxLea0ZXtFZU7dWxLJDnXTcsrF+FzOdFz8yFlYh/OpTb0oRcd9rnph7iGAekGB8
         ik0rimF7VoA8urNInX11vt2epJM4tc6HeLPT6mg2cb+HwbKRu0PS1GJyVQ2LKvcVUpuT
         SqVJdFnWxWbVSdTbMrVMyULZAB9vUGqaSDvrmpjJWh7ulSzpg2hQvqC0sLYaw3balgiV
         LFLfv7dr3gpj5Psge3k7mx9XE9visaWmFHQL2zU8+Ltu2DPIYwLTFP0NyP31im76Ha1I
         ufkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708406039; x=1709010839;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzrntOTnATKrmrMPqPc0IcHlRZEPZIas22xlEfiYJGs=;
        b=sfWYk9QU7DradgpyAehreTqC2HE4UoTLVP0NEi9r3lZjIwSWgDM9+fNozdxBOulSyL
         mLWuvEhXBUODjRmpZ5s1Sl7R2jWKvoNYvFT0/hXVbA5JFdemoN4v22yHjlCuu1/GrADJ
         mWU6KwtQzVC0JBibq5WgKKnpEtuvOwsFwSyhOkz4+gTSoO5xRvT6e0R1GGZgB6rTvUrt
         JD9x6DfFCo/oTR6qUBBJ6rh7RC6zwf2ULMKxZo2r+wxnZiirFL5gwWU1VeABbuOMS1RV
         wQVLsrYZTWwUzbsGxThTYdqCEV0NYEZPljp6kf7gHrpTOkXnL2+GXAgln0maAhoctWJi
         KKVA==
X-Gm-Message-State: AOJu0YzelJUkOewbQLbPef3Txc7NuK4w4Lnp4JQG0zNnNsRB2lZmK+dt
	q8LF55z7q9UJa0VGJu9+E2+aXmMcxm885b3O1ffBCzojfZEaeQaD
X-Google-Smtp-Source: AGHT+IHXufpMLfjRvQSttngGG6V4Q0kJgaj3RvMJ4bz8Q00jmFQ1K/DXx1jrJth5Eb9ZSq6q7nc5yg==
X-Received: by 2002:a05:6358:6412:b0:176:a14c:544b with SMTP id f18-20020a056358641200b00176a14c544bmr11244059rwh.11.1708406039071;
        Mon, 19 Feb 2024 21:13:59 -0800 (PST)
Received: from [192.168.11.213] (220-136-196-149.dynamic-ip.hinet.net. [220.136.196.149])
        by smtp.gmail.com with ESMTPSA id fk10-20020a056a003a8a00b006df50bbbaecsm5825371pfb.86.2024.02.19.21.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 21:13:58 -0800 (PST)
Message-ID: <d298b319-d8a0-4a34-a865-d2f1b7b28305@gmail.com>
Date: Tue, 20 Feb 2024 13:13:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
References: <20240104142226.87869-1-hffilwlqm@gmail.com>
 <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
 <7af3f9c6-d25a-4ca5-9e15-c1699adcf7ab@gmail.com>
 <CAADnVQLOswL3BY1s0B28wRZH1PU675S6_2=XknjZKNgyJ=yDxw@mail.gmail.com>
 <81607ab3-a7f5-4ad1-98c2-771c73bfb55c@gmail.com>
 <CAADnVQJVC21dh9igQ7w=iMamx-M=U2H+Vt7fJE-9tB4qR4tHsQ@mail.gmail.com>
 <98557e73-1fdf-453d-b5d0-7d0e2b471a8b@gmail.com>
In-Reply-To: <98557e73-1fdf-453d-b5d0-7d0e2b471a8b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/2/17 21:43, Leon Hwang wrote:
> 
> 
> On 2024/2/16 10:18, Alexei Starovoitov wrote:

[SNIP]

>>
>> In general that's better, but it feels we can do better
>> and avoid passing rax around.
>> Just access bpf_tail_call_cnt directly from emit_bpf_tail_call.
> Yes, we can do better to avoid passing rax around:
> 
> 1. At prologue, initialise percpu tail_call_cnt.
> 2. When tailcall, fetch and increment percpu tail_call_cnt.
> 
> As a result, we can remove pushing/popping rax at anywhere.
> 
> Finally, here's the diff against latest bpf-next with asm to handle
> percpu tail_call_cnt:
> 


Hi Alexei,

Should I send PATCH v2?

May I add "Suggested-by: Alexei Starovoitov <ast@kernel.org>" at PATCH
v2? Because the key idea, percpu tail_call_cnt, is suggested by you.

Thanks,
Leon

