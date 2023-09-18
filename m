Return-Path: <bpf+bounces-10280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA007A4B7D
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC0F1C20AD1
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D11D68C;
	Mon, 18 Sep 2023 15:16:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985A91170A
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 15:16:45 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD776107
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:16:40 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d81dd7d76e0so2565458276.1
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695050199; x=1695654999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+ba8nOonW48pFx7JDQczLkhubSZ9AQohpTMzp90x54=;
        b=3L2f5AfwN/33pSZoxV9upUim0bVlxKggLbwoK2s8WyDcsG6yYUmQbqgw/env4sozbj
         hpQwMGZo45N6nQyB9dZga81erjfIlrZcbR5WzHeycmrby5OVPT9iOH9cZZu3+4NiEhE/
         MIKTrH8JWgSaOyHALl05fpoXOXG1Oe7u/+BDxqKH+QYxGDR03/zGx7TY/iZVHcu/c58l
         3PbN63AfzBHYJ9hsmIKjA+yMsD0cjiR29be0US2QDgpw8tH/XA7ClBfVEifUhizEAnMc
         hqYlcZih2S7BKdx4qXoLnkVNjfHp7AJo5PJUMn8LfwGe6sQ3QmgXz7J4spOTW96G/1zW
         zkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050199; x=1695654999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+ba8nOonW48pFx7JDQczLkhubSZ9AQohpTMzp90x54=;
        b=QGjkPf1Rs9jJ4mdfWRtWaofg/wBCn7H1Nj0Q55KsQBgDF/8rE33Ry+EcUGhxOfygWz
         qSR3RhVuWApDtQMke94W1s3khGr0I2Vq62Al3OD2vS3knl5DkF8dgdQgJdDRYfX2EiLB
         /I4GiyAcOULzauZ8te0GSKOw2YaxUbn0j+wHdv3mtP7w1KCIXz3EEMNE1soYuFkmy7Dl
         27O4dYbOeb/87hj1QrMvUqlamUzAfyoaZaYquwHvZDP4RoUrL4+/14Ns0mQ70htUhr51
         TwA958eA3IReeSPUy2f72YIPXm0LGEoaq+65hMidrwtQRFba780XsKFwEZJWfz+CDxrP
         cpYA==
X-Gm-Message-State: AOJu0Yzv7WdD4wqPgAgefMyg1b9j47+j0FVEeJMa/TMcUcqp7qhXC95k
	LhcCqJCTVW+dLF4Wzmg/9DKeLOj1z7ZprvIz6FAEcQ==
X-Google-Smtp-Source: AGHT+IHjG3S38tK48PZ1ZKvxcW+y67RTNF+WQ4QGZuh9+NLEbx+e4VBHmEB4JWtU/da/g/d9iBb9Cg==
X-Received: by 2002:a0c:e485:0:b0:656:292:d45e with SMTP id n5-20020a0ce485000000b006560292d45emr8664335qvl.1.1695049767648;
        Mon, 18 Sep 2023 08:09:27 -0700 (PDT)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id w25-20020a0cb559000000b0064f741d2a97sm3541898qvd.40.2023.09.18.08.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 08:09:27 -0700 (PDT)
Message-ID: <5c3b16c8-63e6-4f80-8fa2-6bacb38cdcb6@google.com>
Date: Mon, 18 Sep 2023 11:09:26 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BPF memory model
Content-Language: en-US
To: paulmck@kernel.org
Cc: Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
 davemarchevsky@meta.com, Tejun Heo <tj@kernel.org>,
 David Vernet <dvernet@meta.com>, Neel Natu <neelnatu@google.com>,
 Jack Humphries <jhumphri@google.com>, bpf@vger.kernel.org, ast@kernel.org
References: <CABk29NuQ4C-w_JA-zev796Nr_vx932qC4_OcdH=gMM6HZ_r4WQ@mail.gmail.com>
 <33f06fa6-2f4d-4e50-a87e-0d6604d3c413@paulmck-laptop>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <33f06fa6-2f4d-4e50-a87e-0d6604d3c413@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/8/23 04:42, Paul E. McKenney wrote:
> But what BPF programs are you running that are seeing excessive 
> synchronization overhead? That will tell us which operations to start 
> with. (Or maybe it is time to just add the full Linux-kernel 
> atomic-operations kitchen sink, but that would not normally be the way 
> to bet.)

Here's what I use in BPF, (also for writing parallel schedulers):
- READ_ONCE/WRITE_ONCE
- compiler atomic builtins, like CAS, swap/exchange, fetch_and_add, etc.
- smp_store_release, __atomic_load_n, etc.
- at one point, i was sprinkling asm volatile ("" ::: "memory") around 
too, though not in any active code at the moment.

My mental model, right or wrong, is that I am operating under something 
like the LKMM, and that I need to convince the compiler to spit out the 
right code (sort of like writing shared memory code to talk to a device 
or userspace) and hope the JIT does the right thing.

Barret



