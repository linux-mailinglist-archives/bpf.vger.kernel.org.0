Return-Path: <bpf+bounces-1681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D1672021B
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 14:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DE81C20F84
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 12:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC00101DA;
	Fri,  2 Jun 2023 12:33:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE2533F5
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 12:33:49 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E2B180;
	Fri,  2 Jun 2023 05:33:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d18d772bdso2322279b3a.3;
        Fri, 02 Jun 2023 05:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685709227; x=1688301227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEa4HtLCvaR58X6qDLIInuWWrd49EKwYFvmbNgQxP+Y=;
        b=hPya3AXoo2gk76iraAbuEMCLTv7EJfS+R9Vww94gkSTVHG/8AvYKcRkQuMMs65OJz9
         6eDmn+mMH5qZdxcCxqGxRP+YHToOoxYzbIhFej/97J3X47KnEQlC2DFx+KYEMNtlhl36
         tAEkDz7hu5q4wHDBhnPfwE2kYsiyuiy3h4dC3PtL8fmHiGrU8gRjk2xfSF1IxJlIDb0W
         Bg68vUGheQZ37mILcP96Q53rng5EEnMIq9EVeBWcLK15vECN6tUxP/gZardPvM8CXgWs
         gV03cNwlkru8QYO9Zvuf7usR+L80Oaf8h/nDnuVqCKCUpOUPlNq7yJsodQ5MD2RqeNvv
         CUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685709227; x=1688301227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEa4HtLCvaR58X6qDLIInuWWrd49EKwYFvmbNgQxP+Y=;
        b=UqoGYl80SEKkegMma8Bxun0wqQ7NA6UD2GEZn4tWF4UV7VxCKvrdCiuPrpCfqLeqeQ
         qyd1iMBk40EY4Q5eKrxbSY+k1rCjuZKggt1wpAS1Etx8ijLFo0l7ZWZy/SAqtK4kbIo0
         MLteaO8hmmHA+BQC3jYt3ZVWPc4qrIAk92qVIfvE1CnfLtphjyJg650W95OnhOwMBECX
         Uri0UD6BBLOerAogFdLlCsnUZTiHKW5YzTFWLsoc0PieC95lGDtHe5V2QlA15ARlHSLx
         yLZoedoJxj0c1lfVv9Fo41LtaUAEDCUHyF1zTZfJ1AyvOfQZAbFRFRlZ4hBvdwIBpcV6
         H3YQ==
X-Gm-Message-State: AC+VfDzuSIa6hdW8kK15Vz+qjkWSoRdSqqXP+fQO/KpWGSs77ETJVefP
	nkEKTa890R/q7947IBn17KA=
X-Google-Smtp-Source: ACHHUZ7chbBawGs+gJXSh0pchi5h/0LICNEsARTw9zPK6gBA/gL7y1Ko0aQFguAtK1BUAXUfVit0gg==
X-Received: by 2002:a05:6a00:a8f:b0:64d:2ea4:937a with SMTP id b15-20020a056a000a8f00b0064d2ea4937amr17109892pfl.7.1685709226632;
        Fri, 02 Jun 2023 05:33:46 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-67.three.co.id. [180.214.233.67])
        by smtp.gmail.com with ESMTPSA id i8-20020aa78b48000000b0063b6cccd5dfsm903574pfd.195.2023.06.02.05.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 05:33:46 -0700 (PDT)
Message-ID: <1f66d945-4f3f-6f8e-2d14-38167c0a0759@gmail.com>
Date: Fri, 2 Jun 2023 19:33:42 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3] Documentation: subsystem-apis: Categorize remaining
 subsystems
To: Jonathan Corbet <corbet@lwn.net>, Costa Shulyupin
 <costa.shul@redhat.com>, linux-doc@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux BPF <bpf@vger.kernel.org>
References: <ZHgM0qKWP3OusjUW@debian.me>
 <20230601145556.3927838-1-costa.shul@redhat.com> <ZHm_s7kQP6kilBtO@debian.me>
 <87ilc6yxnl.fsf@meer.lwn.net>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87ilc6yxnl.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/2/23 17:19, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> As you're still newbie here, I'd recommend you to try contributing to
>> drivers/staging/ first in order to gain experience on kernel developement
>> workflow. Also, you use your RedHat address, so I expect you have been
>> given kernel development training from your company (and doesn't make
>> trivial errors like these ones).
> 
> Bagas, please.  I'll ask you directly: please don't go telling
> documentation contributors how to comport themselves; you have plenty
> enough to learn yourself on that front.  It's hard enough to get
> contributors to the documentation as it is without random people showing
> up and giving orders.
> 

Hi jon, thanks for another tip. I also learn contributing patches the
hard way by being rejected (honestly sometimes I learn, sometimes I
don't).

Let me clarify the situation. Previously in v2, I reviewed Costa's patch
by replying with proposing my own version, keeping patch author intact.
There, I categorized a few more items while sorting all of them. I
treated it as minor fixup that was attributed by brackets in the
SoB area (I could also use Co-developed-by: for this purpose too).
Then, Costa rerolled v3 using my version, but the From: address
in the patch message is mine without corresponding SoB, hence when you
apply his v3, there would be author mismatch (commit author is me
yet different SoB from him). I expected that my proposal in v2 is
carried by him (and also have SoB from both me and him as the sender
who carried my patch).

> I have distractions that are increasing my (already less than stellar)
> latency, but I'll get to this stuff.
> 

I'm too, because I'm AuDHD and I can (and do) easily distracted; living
in a paradox between routine fixation and desire for quick action :).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara


