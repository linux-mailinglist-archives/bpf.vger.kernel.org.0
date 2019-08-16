Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3AD9069D
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2019 19:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfHPRSq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Aug 2019 13:18:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35956 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfHPRSo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Aug 2019 13:18:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so4657960wme.1
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2019 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VEpvMr6ivcf9WYnfA07psMPftiHLyAntmf06aiMMcGc=;
        b=pVDHlYdLtNZXqDuB8Fncscb1bTg2fD/EaFej91GPpvS+Wd1Agb9cBAeB3ilrtJhq/5
         0MoGPSA8ZMtXOvcKDhWypyLBiwBcuQf8SLjR9F2rsEP6/gzarKIFgSoJenrAU5/jtmK5
         xGNPhnCQft6lHRmwRRGiXRx3ynPijTtKYZIUumJOTYyYplSjXauIKL86JaKzyPwUYX3w
         3SJD9a2vzUD7ZuuaOk364SskcDRMbreN5alhDXoPhbBh5xk1K2WZfgbiqb1OUob54Eaj
         alAnsFgkE2hsYXLJ2CxCXOWte/Bcwz+BZh1FrZXwxiRPnkERJ4yIGF5dYVIdz88bvD+v
         7u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VEpvMr6ivcf9WYnfA07psMPftiHLyAntmf06aiMMcGc=;
        b=AkbGTxD7LUfKvJI+JLcQRA2DfQwtj3UI8oIsCDJzSkRmt4900M1T0NIIK05ek5Xqmz
         7Dm8itZSdluCnyjZwLTOpNsLaum8VIB2h8Odth+DGW/T2aVpYraCG6ecJztPo8weVoyB
         EocvHCn3bdTZk//bNPdkepkxwQ26fS5ByxUuEcRvtlnw/OJE4mqVdLJNIucDunVsB1Cq
         m1WntuYocfVKBjSQGGXWeeWWhAv4rHfWs63KatW5xqIAD+Cg9exZcvoTfl8dKfkLJEHY
         NdmPqh87jQTIZQb+B5VmuVoLEDuhFlMZZRDAUygfvfp7QaS+EFHMdFuOh3QgW8IISUDw
         ll3w==
X-Gm-Message-State: APjAAAWJWo94BclPrt5+ldKYP2HkqAGC6oc4jXh/fuDlEaz7HmkSN48y
        TFlFY4fvWU22sZX5c1uvUvnqAQ==
X-Google-Smtp-Source: APXvYqyiUe1A/SXrSgtpg9pIW6xotblDwEltLj/uXPj0+cvP2Rs4MuyRZR1EMckBVoRCRBPl34Iufg==
X-Received: by 2002:a05:600c:d2:: with SMTP id u18mr8252966wmm.11.1565975922501;
        Fri, 16 Aug 2019 10:18:42 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.47])
        by smtp.gmail.com with ESMTPSA id f7sm10847854wrf.8.2019.08.16.10.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 10:18:41 -0700 (PDT)
Subject: Re: [PATCH bpf 0/6] tools: bpftool: fix printf()-like functions
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        oss-drivers@netronome.com
References: <20190815143220.4199-1-quentin.monnet@netronome.com>
 <CAADnVQKpPaZ3wJJwSn=JPML9pWzwy_8G9c0H=ToaaxZEJ8isnQ@mail.gmail.com>
 <10602447-213f-fce5-54c7-7952eb3e8712@netronome.com>
 <CAADnVQLPg8jEsUbKOxzQc5Q1BKrB=urSWiniGwsJhcm=UM7oKA@mail.gmail.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <e4947abc-3c09-ce67-9ea2-54b7abc1b53a@netronome.com>
Date:   Fri, 16 Aug 2019 18:18:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQLPg8jEsUbKOxzQc5Q1BKrB=urSWiniGwsJhcm=UM7oKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-08-16 10:11 UTC-0700 ~ Alexei Starovoitov
<alexei.starovoitov@gmail.com>
> On Fri, Aug 16, 2019 at 9:41 AM Quentin Monnet
> <quentin.monnet@netronome.com> wrote:
>>
>> 2019-08-15 22:08 UTC-0700 ~ Alexei Starovoitov
>> <alexei.starovoitov@gmail.com>
>>> On Thu, Aug 15, 2019 at 7:32 AM Quentin Monnet
>>> <quentin.monnet@netronome.com> wrote:
>>>>
>>>> Hi,
>>>> Because the "__printf()" attributes were used only where the functions are
>>>> implemented, and not in header files, the checks have not been enforced on
>>>> all the calls to printf()-like functions, and a number of errors slipped in
>>>> bpftool over time.
>>>>
>>>> This set cleans up such errors, and then moves the "__printf()" attributes
>>>> to header files, so that the checks are performed at all locations.
>>>
>>> Applied. Thanks
>>>
>>
>> Thanks Alexei!
>>
>> I noticed the set was applied to the bpf-next tree, and not bpf. Just
>> checking if this is intentional?
> 
> Yes. I don't see the _fix_ part in there.
> Looks like cleanup to me.
> I've also considered to push
> commit d34b044038bf ("tools: bpftool: close prog FD before exit on
> showing a single program")
> to bpf-next as well.
> That fd leak didn't feel that necessary to push to bpf tree
> and risk merge conflicts... but I pushed it to bpf at the end.
> 

Ok, thanks for explaining. I'll consider submitting this kind of patches
to bpf-next instead in the future.

Quentin
