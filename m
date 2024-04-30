Return-Path: <bpf+bounces-28267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC17F8B7783
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 15:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA711C2214B
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB84171E71;
	Tue, 30 Apr 2024 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TrbWzzUJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83DD171E6E
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484765; cv=none; b=cFN8VKVBbUAXV9KHaSJpaFsM5zfkHSZwer1vQK/lA+t9t+QXDDp1N4WD/eUVUsC+0Z9MjK/cIYgJi+9HVRyuneEvzShXsxlnVHxQxJmFbQTEq4+3Qx2s3Ehqc5hkY6T+ctBSknETkg2kTG2d+jDaJekFWuju4LtsJvLF4fyrRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484765; c=relaxed/simple;
	bh=T1pCeAqcp0hagoseX+NBrv4VuqjeZqvX4PDGNfjpbho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBTPMMrCqWx5jMnvh0PffBuPLFelFS0vVjgLI1S3ekmo/wu3ovcYpzMTj+Z3LUgpzzKjxp9Fs5cZLd/0hWckHrMEHZIM1fEVBxUXUYsx/fjd5xqhqqQ4z/6+0TWskcuI6PK3PqNitCIC7LXcgJX4EBMQLeNTMsTK/dLC8n68gjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TrbWzzUJ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b2aab2d46dso116256a91.0
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714484761; x=1715089561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JjNR4wPlgvb/NrdAvCR/ceifiIGObytGntMYaBKjRCU=;
        b=TrbWzzUJm4ACtdJyO8oibE6KYZmSqfTX2Jp4Q0yG9JcxctyXvP+CDWGCRkRrVsuMY5
         iMVNVsN3muXq+fKDdYw5GJRGGzLAyrSmaV0eEKQRnVARtWliWdQoTqQ1FD1RUlHU5m3U
         gDdLu5C5HjkqWAIpLZ4ayF0asn66ueCZTz0j8eCPMTI0Z8v/bSHAT2v+b0W4MSZMvrlE
         oROpvzBoqEz7hAfm06s0TLcuLfyELeqxigNRtGhSdBSBaHmYeXwgI8qUnuKDsSwX9Nh2
         5g8SyL48LiJV6qg+w5MFs+9pri8thZKS40PTXmP8hzxdCZM8eyX9NKg32HgQ9RPA9Rcw
         IC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714484761; x=1715089561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JjNR4wPlgvb/NrdAvCR/ceifiIGObytGntMYaBKjRCU=;
        b=HeumfF6i4dU6SVhlTfPYQo+YLCYF5jopOxHf6euT9AEw98R2t3ZKnMtqsD7kQrJJ2F
         t2OdFWQTnbXnsoPBIDi1Gu0V9QhHEA84Er0uZu9eAGCaO/sG3xJi2jkF4D/4/s9Gc7cS
         6rrIcKXfdz3Rpj7A3h2WtWOXxGVFvpzNVU9WYPx1qM9kbjgdabEpaL4OMemUK2MTvP8/
         G2biVEZwtT1cD5j+tQ5/7ieSJEz4wbFDDTUkJlgK5uzLElApUm1nk3/PMMMsYbxd2KcD
         74WoFkYB8shpprxGfGR1AZKUCmOxjzcfTsXDy3cNMLLNUGIPnl4wpNPpiveiv4L5/s2W
         e6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVMgXyIv65kHqS2s/ksA82eLrEk5o6X/JY2QA9IYEdAE9IlMWh9ShH79V5mmaq8pqTcNIZkTuSDkbB2O2hhSPLwgPNZ
X-Gm-Message-State: AOJu0YyxzoBlzJLOY8wp35jvSmd15DBhXFIxI3XmdspDJPlhU6FYTzzT
	PW12YX/E9NtyR93/jKwllpxcW4ngrpjFrvRzzfzNT69BCjUa2GKu4TqI7tGktuw=
X-Google-Smtp-Source: AGHT+IH9R1bNbi/b5An2t0YujuKFT91RDi4jOUG3j3R9m2Jy6nNwhLv9ihFj9tl7tQbksDchw49Kdw==
X-Received: by 2002:a05:6a00:1d22:b0:6ed:cc50:36cd with SMTP id a34-20020a056a001d2200b006edcc5036cdmr14955130pfx.2.1714484761068;
        Tue, 30 Apr 2024 06:46:01 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id fe8-20020a056a002f0800b006ed00ea504asm21108186pfb.159.2024.04.30.06.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 06:46:00 -0700 (PDT)
Message-ID: <aafbbf09-a33d-4e73-99c8-9ddab5910657@kernel.dk>
Date: Tue, 30 Apr 2024 07:45:52 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 07/14] page_pool: devmem support
To: Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Amritha Nambiar <amritha.nambiar@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Christian Brauner <brauner@kernel.org>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Florian Westphal <fw@strlen.de>, Yunsheng Lin <linyunsheng@huawei.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Aleksander Lobakin <aleksander.lobakin@intel.com>,
 Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Richard Gobert <richardbgobert@gmail.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>,
 Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-8-almasrymina@google.com>
 <8357256a-f0e9-4640-8fec-23341fc607db@davidwei.uk>
 <CAHS8izPeYryoLdCAQdGQU-wn7YVdtuofVKNvRFjFjhqTDsT7zA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHS8izPeYryoLdCAQdGQU-wn7YVdtuofVKNvRFjFjhqTDsT7zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/24 8:11 PM, Mina Almasry wrote:
> On Fri, Apr 26, 2024 at 5:18?PM David Wei <dw@davidwei.uk> wrote:
>>
>> On 2024-04-02 5:20 pm, Mina Almasry wrote:
>>> @@ -69,20 +106,26 @@ net_iov_binding(const struct net_iov *niov)
>>>   */
>>>  typedef unsigned long __bitwise netmem_ref;
>>>
>>> +static inline bool netmem_is_net_iov(const netmem_ref netmem)
>>> +{
>>> +#if defined(CONFIG_PAGE_POOL) && defined(CONFIG_DMA_SHARED_BUFFER)
>>
>> I am guessing you added this to try and speed up the fast path? It's
>> overly restrictive for us since we do not need dmabuf necessarily. I
>> spent a bit too much time wondering why things aren't working only to
>> find this :(
> 
> My apologies, I'll try to put the changelog somewhere prominent, or
> notify you when I do something that I think breaks you.
> 
> Yes, this is a by-product of a discussion with regards to the
> page_pool benchmark regressions due to adding devmem. There is some
> background on why this was added and the impact on the
> bench_page_pool_simple tests in the cover letter.
> 
> For you, I imagine you want to change this to something like:
> 
> #if defined(CONFIG_PAGE_POOL)
> #if defined(CONFIG_DMA_SHARED_BUFFER) || defined(CONFIG_IOURING)
> 
> or something like that, right? Not sure if this is something I should
> do here or if something more appropriate to be in the patches you
> apply on top.

In general, attempting to hide overhead behind config options is always
a losing proposition. It merely serves to say "look, if these things
aren't enabled, the overhead isn't there", while distros blindly enable
pretty much everything and then you're back where you started.

-- 
Jens Axboe


