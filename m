Return-Path: <bpf+bounces-12608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D487CEA34
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 23:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17658B20F11
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 21:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5613FB1E;
	Wed, 18 Oct 2023 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhOtcnRu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5287A335B1;
	Wed, 18 Oct 2023 21:47:48 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1368FE;
	Wed, 18 Oct 2023 14:47:46 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7b91faf40so89283687b3.1;
        Wed, 18 Oct 2023 14:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697665666; x=1698270466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IauKMSr3rTbLZMLKRdVJth+GWH6uHwoa0fXMf9VnAo=;
        b=IhOtcnRuAo38n2/29xnvm205O5c2YJQ+qifs+WMt+y1hfzr7x6Z4NYYa0gMEGZ4QeD
         THkWoL7j96TlW527xyTUSVJa/tpOZJAVL0t/04zPazozeoy8rBtL0DEvegtEb7teGJJ2
         zWZxI8PtLjad4KTbYNK/pvK+igHoH88y8/wkzibcQ6Rdc4FRe5+9St+PwlsSMO9ZaPVZ
         WFWLe5fs/HKibLuLFPEpGP+a3a61e/9lCYTah0AcC9wfiJxlb/pp0pjf9VUbY69FDuY9
         Jlr1klwH29FsvGXSGpZ+OgDaEeChbwvicV/rSwGe9Z6tb55GjnOVDr4qabFA3pdqbeTA
         UPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697665666; x=1698270466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IauKMSr3rTbLZMLKRdVJth+GWH6uHwoa0fXMf9VnAo=;
        b=LSHUH5Ku353EGdTA3B2ipRagPZU1QGnd5lPoFgEtht3MMuxO5Ci7QSvEfL9VVVRm1u
         2VY3458VM9kmRbYTaeJqtqmpfY8qOjJgK9noRQxwdOo+b2debcQu3t4j7HXq5c8gP1IP
         Yhd9kLjcRtWiDrz5I4SX5FIENq7Az7qGxZ8Anqv/fWcG8jW3whQY0f3RooItsaUq4Wfm
         fW0N5iYtfT8aH9Wm9AQaLK0YfMrhWyFFCIrpeFfviLRSvwBobJU/Anay0BHZhLFJ1EGv
         qC7saB6Wmrbupv+UK3wrWiexwOSo065R1NVjAJcbRtYf1XfpLPdzuFtW120ODueESLSq
         yfeQ==
X-Gm-Message-State: AOJu0YwTrn5IwiYptCN0ykN4HAmDcittlinGEnx/Ea5s6/uoagR5pm/R
	CC/SYSRj9vCg6huOpFjcV3o=
X-Google-Smtp-Source: AGHT+IH1vVi5koft4vHMX93mSqwvGxKuLtvk0n5sCSsrWiZTSlJi24QvnPDg5pwIbibJWpZHa3XxEQ==
X-Received: by 2002:a05:690c:1d:b0:59b:dbb7:5c74 with SMTP id bc29-20020a05690c001d00b0059bdbb75c74mr706779ywb.32.1697665666110;
        Wed, 18 Oct 2023 14:47:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:bc1b:4929:64c8:fdbf? ([2600:1700:6cf8:1240:bc1b:4929:64c8:fdbf])
        by smtp.gmail.com with ESMTPSA id i78-20020a819151000000b0059be6a5fcffsm1842353ywg.44.2023.10.18.14.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 14:47:45 -0700 (PDT)
Message-ID: <7aac6512-c1f9-42ce-b8ca-07980f90714e@gmail.com>
Date: Wed, 18 Oct 2023 14:47:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie
 generation/validation SOCK_OPS hooks.
To: Kuniyuki Iwashima <kuniyu@amazon.com>, edumazet@google.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, kuba@kernel.org, kuni1840@gmail.com,
 martin.lau@linux.dev, mykolal@fb.com, netdev@vger.kernel.org,
 pabeni@redhat.com, sdf@google.com, song@kernel.org, yonghong.song@linux.dev
References: <CANn89iLZDvqrGy9UJ39a49O3NLT74r+5FXfh7u3SxSSm60BJmA@mail.gmail.com>
 <20231018172027.9936-1-kuniyu@amazon.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20231018172027.9936-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/18/23 10:20, Kuniyuki Iwashima wrote:
> From: Eric Dumazet <edumazet@google.com>
> Date: Wed, 18 Oct 2023 10:02:51 +0200
>> On Wed, Oct 18, 2023 at 8:19 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>
>>> On 10/17/23 9:48 AM, Kuniyuki Iwashima wrote:
>>>> From: Martin KaFai Lau <martin.lau@linux.dev>
>>>> Date: Mon, 16 Oct 2023 22:53:15 -0700
>>>>> On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
>>>>>> Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
>>>>>> After 3WHS, the proxy restores SYN and forwards it and ACK to the backend
>>>>>> server.  Our kernel module works at Netfilter input/output hooks and first
>>>>>> feeds SYN to the TCP stack to initiate 3WHS.  When the module is triggered
>>>>>> for SYN+ACK, it looks up the corresponding request socket and overwrites
>>>>>> tcp_rsk(req)->snt_isn with the proxy's cookie.  Then, the module can
>>>>>> complete 3WHS with the original ACK as is.
>>>>>
>>>>> Does the current kernel module also use the timestamp bits differently?
>>>>> (something like patch 8 and patch 10 trying to do)
>>>>
>>>> Our SYN Proxy uses TS as is.  The proxy nodes generate a random number
>>>> if TS is in SYN.
>>>>
>>>> But I thought someone would suggest making TS available so that we can
>>>> mock the default behaviour at least, and it would be more acceptable.
>>>>
>>>> The selftest uses TS just to strengthen security by validating 32-bits
>>>> hash.  Dropping a part of hash makes collision easier to happen, but
>>>> 24-bits were sufficient for us to reduce SYN flood to the managable
>>>> level at the backend.
>>>
>>> While enabling bpf to customize the syncookie (and timestamp), I want to explore
>>> where can this also be done other than at the tcp layer.
>>>
>>> Have you thought about directly sending the SYNACK back at a lower layer like
>>> tc/xdp after receiving the SYN?
> 
> Yes.  Actually, at netconf I mentioned the cookie generation hook will not
> be necessary and should be replaced with XDP.
> 
> 
>>> There are already bpf_tcp_{gen,check}_syncookie
>>> helper that allows to do this for the performance reason to absorb synflood. It
>>> will be natural to extend it to handle the customized syncookie also.
> 
> Maybe we even need not extend it and can use XDP as said below.
> 
> 
>>>
>>> I think it should already be doable to send a SYNACK back with customized
>>> syncookie (and timestamp) at tc/xdp today.
>>>
>>> When ack is received, the prog@tc/xdp can verify the cookie. It will probably
>>> need some new kfuncs to create the ireq and queue the child socket. The bpf prog
>>> can change the ireq->{snd_wscale, sack_ok...} if needed. The details of the
>>> kfuncs need some more thoughts. I think most of the bpf-side infra is ready,
>>> e.g. acquire/release/ref-tracking...etc.
>>>
>>
>> I think I mostly agree with this.
> 
> I didn't come up with kfunc to create ireq and queue it to listener, so
> cookie_v[46]_check() were best place for me to extend easily, but now it
> sounds like kfunc would be the way to go.
> 
> Maybe we can move the core part of cookie_v[46]_check() except for kernel
> cookie's validation to __cookie_v[46]_check() and expose a wrapper of it
> as kfunc ?
> 
> Then, we can look up sk and pass the listener, skb, and flags (for sack_ok,
> etc) to the kfunc.  (It could still introduce some conflicts with Eric's
> patch though...)

Does that mean the packets handled in this way (in XDP) will skip all 
netfilter at all?


> 
> 
>>
>> I am rebasing  a patch adding usec resolution to TCP TS,
>> that we used for about 10 years at Google, because it is time to upstream it.
>>
>> I am worried about more changes/conflicts caused by Kuniyuki patch set...
> 

