Return-Path: <bpf+bounces-28289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FD28B8028
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 20:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25C0284075
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 18:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5509194C8B;
	Tue, 30 Apr 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fHqmNmfo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02C31836C8
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714503313; cv=none; b=pDjD9MgSZTgmRxLDBKoLhRTVcHKm67hzoVldwNNzrOEvi2PndhlECpLNxCWYT22khS+P2CSQ7cm3v3p7QA6JJ/BzQCYdc3lQ714W4vSNaSoEWs/Tx0K4+cqw8KO/13umxVl1qdUT2K+ITU6frC4YhjW2WCX4KWm310W6eKSF99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714503313; c=relaxed/simple;
	bh=Y4zEuuEidL9HuzJO4epGfanxTN6QUEoob6ZCDJEvDGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+s9XgNP7iuVdsUTgeQM8DG38+nWPV1PIRBypHHUr2qBwS1u5+fN8CKgvJEfiStByS+SlP6JMSC7D3oWvvKRkmGVsdChWPc8E2oC6X97vJcMQ6+YXjYKvqm09YUI1L9wPaKS7IsDSqpTGkLu9MUHTmYioTE2iiRXbXayl+jGa+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fHqmNmfo; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7dee034225eso7960539f.2
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714503310; x=1715108110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHR3RGRuxJEH/dBiKYgawHqY9Lnlphnx76oS7XwiA+c=;
        b=fHqmNmfo5j3nkc0/YlfKBue3Uo54rLdcUx3usEOkU3PR8LAWsZB5mGsa98YQUIEP4O
         NfUPjz2sWBba6nJMHrkxHT8QwnynajW9W7oimNjlrdurIiXHuFMKS+ogeCkHTkMcTGi7
         ybm0qpbIpPiQ5fH2XMF3wNU4cc4faT7DKHnj/N8BdAgA+3uUeb/d/sWMrtIZK8qNSkpR
         yFkNOapl3EP94cWGzjMPhyJrZgbJococGHKTUZXHyVcAV52JpSZfzYfQQZVcQMov3CY8
         mPRPS8dXdQeJYqKis1T/ZT/M8f3n/u4wLvIrlX6JCtuXTIi0mOo/gsQ6UgRSV8MmS+zS
         Gslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714503310; x=1715108110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHR3RGRuxJEH/dBiKYgawHqY9Lnlphnx76oS7XwiA+c=;
        b=YwpgBk+n1GX0yVcSXuWELEuoNhPe6GEO3N2q8JQSigxPE6eaDEo5e+5S5gyYZytxNu
         maVRAHsTemN4hw2SHNL2mhpbe203xCdKdTckvB8xzBGaIFdgpEWQnCb8yX8ZmbnYcZgU
         B4bCUaWpyN53A/S7O57nG0nnYPqriw1urJ1c5Hq1yCM6PhrapEYz2kuiyQVyuaPX2VLq
         e3WKiaoMUeuINtRYmDL9FRDj7U1MzOpFB7Y7bYm0Dr02wY4l0jxiZuDf4dR3sVLuGjoz
         GHc2RrrEOrDGbwVdfnRkHlZPAFlZdM1H1CHyB2cxYUvL9/mvuPKzV0UjnrGNVddTCPFf
         NJAA==
X-Forwarded-Encrypted: i=1; AJvYcCVcOFrqgBLlgQ9g17xL23dgewW/de9EvZgudOMhOrfnOLdP5lPL2x+/kkSue6YuyA3e/8HyBTksxBcw0juh+kdpxLWr
X-Gm-Message-State: AOJu0Yz5Ijscw7i+E3F3Bp+EzccPeN/LqDA3tCrM6Kl/DAKcOHJmdPeg
	bN1JWuyz2XkcKfRJ2dTGvCJmAX7HCSLmotl5jrQg4KLpCmSXeRUrbKiX5guw7iU=
X-Google-Smtp-Source: AGHT+IFtf+wSV3MsQDY8kH1lbfF76eo7FuUDr/3x1d33gkfYgxzUOO8lZB4OHFgKKuLwCBSXBvT5jw==
X-Received: by 2002:a6b:f110:0:b0:7de:e04b:42c3 with SMTP id e16-20020a6bf110000000b007dee04b42c3mr828170iog.0.1714503309571;
        Tue, 30 Apr 2024 11:55:09 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a05663812d500b00487f9ec16b9sm389802jas.173.2024.04.30.11.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 11:55:08 -0700 (PDT)
Message-ID: <11f52113-7b67-4b45-ba1d-29b070050cec@kernel.dk>
Date: Tue, 30 Apr 2024 12:55:05 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 07/14] page_pool: devmem support
To: Mina Almasry <almasrymina@google.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
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
 <aafbbf09-a33d-4e73-99c8-9ddab5910657@kernel.dk>
 <CAHS8izMKLYATo6g3xkj_thFo3whCfq6LSoex5s0m5XZd-U7SVQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHS8izMKLYATo6g3xkj_thFo3whCfq6LSoex5s0m5XZd-U7SVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/24 12:29 PM, Mina Almasry wrote:
> On Tue, Apr 30, 2024 at 6:46?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 4/26/24 8:11 PM, Mina Almasry wrote:
>>> On Fri, Apr 26, 2024 at 5:18?PM David Wei <dw@davidwei.uk> wrote:
>>>>
>>>> On 2024-04-02 5:20 pm, Mina Almasry wrote:
>>>>> @@ -69,20 +106,26 @@ net_iov_binding(const struct net_iov *niov)
>>>>>   */
>>>>>  typedef unsigned long __bitwise netmem_ref;
>>>>>
>>>>> +static inline bool netmem_is_net_iov(const netmem_ref netmem)
>>>>> +{
>>>>> +#if defined(CONFIG_PAGE_POOL) && defined(CONFIG_DMA_SHARED_BUFFER)
>>>>
>>>> I am guessing you added this to try and speed up the fast path? It's
>>>> overly restrictive for us since we do not need dmabuf necessarily. I
>>>> spent a bit too much time wondering why things aren't working only to
>>>> find this :(
>>>
>>> My apologies, I'll try to put the changelog somewhere prominent, or
>>> notify you when I do something that I think breaks you.
>>>
>>> Yes, this is a by-product of a discussion with regards to the
>>> page_pool benchmark regressions due to adding devmem. There is some
>>> background on why this was added and the impact on the
>>> bench_page_pool_simple tests in the cover letter.
>>>
>>> For you, I imagine you want to change this to something like:
>>>
>>> #if defined(CONFIG_PAGE_POOL)
>>> #if defined(CONFIG_DMA_SHARED_BUFFER) || defined(CONFIG_IOURING)
>>>
>>> or something like that, right? Not sure if this is something I should
>>> do here or if something more appropriate to be in the patches you
>>> apply on top.
>>
>> In general, attempting to hide overhead behind config options is always
>> a losing proposition. It merely serves to say "look, if these things
>> aren't enabled, the overhead isn't there", while distros blindly enable
>> pretty much everything and then you're back where you started.
>>
> 
> The history there is that this check adds 1 cycle regression to the
> page_pool fast path benchmark. The regression last I measured is 8->9
> cycles, so in % wise it's a quite significant 12.5% (more details in
> the cover letter[1]). I doubt I can do much better than that to be
> honest.

I'm all for cycle counting, and do it myself too, but is that even
measurable in anything that isn't a super targeted microbenchmark? Or
even in that? 

> There was a desire not to pay this overhead in setups that will likely
> not care about devmem, like embedded devices maybe, or setups without
> GPUs. Adding a CONFIG check here seemed like very low hanging fruit,
> but yes it just hides the overhead in some configs, not really removes
> it.
> 
> There was a discussion about adding this entire netmem/devmem work
> under a new CONFIG. There was pushback particularly from Willem that
> at the end of the day what is enabled on most distros is what matters
> and we added code churn and CONFIG churn for little value.
> 
> If there is significant pushback to the CONFIG check I can remove it.
> I don't feel like it's critical, it just mirco-optimizes some setups
> that doesn't really care about this work area.

That is true, but in practice it'll be enabled anyway. Seems like it's
not really worth it in this scenario.

-- 
Jens Axboe


