Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6BD1ED64A
	for <lists+bpf@lfdr.de>; Wed,  3 Jun 2020 20:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgFCSla (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jun 2020 14:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgFCSl3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jun 2020 14:41:29 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E63C08C5C1
        for <bpf@vger.kernel.org>; Wed,  3 Jun 2020 11:41:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f7so3273691ejq.6
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2020 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S0TgVRaqXvLo/zqjh6Bua71lJw4suwzv026W+P/Naw8=;
        b=C0+b3DJ7FfEDQKaieP18CwiGEkvjteY8TXKD0hCkYxGC6+7gm7AmFxZW15fIQkRLIM
         Kh5Jm7ok0fzu9poY7ZLIhZ58/u5sJAzW/bQRxIwpy3VQkbCpomTVIyqSRH154MdLzXX5
         YK/+gOw8xoGKlM2oPEYWWp+ER6BVIWaY9o4JNWbYF9snmgSbjVOjxeEIbCRpEK+ieMsn
         dNHlym5awwcmUDb/tuJ5D309AkhWFct4ouZ0rQ28LCNE2tcZduzokMTHY+TUJim9+DBc
         fQj29FDGhJlHjJsvspR0d0qb+Sk70NpBKh87gEJiND8QB+0g8SxdDuGN/LadFwZH0YLO
         wpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S0TgVRaqXvLo/zqjh6Bua71lJw4suwzv026W+P/Naw8=;
        b=fkFTLa9/lIGvC96FpsqWlIhX6GsfTl4411SALZ/4imenrOWrbuBlxW4WSh7KCxco+2
         Sw2Vjxx2cAaiTaTY/e+WxjUz0ITc2Tb/kH+JuWsRPXGEIPoUvLCMSqlXeiuiXWez2tye
         REZ+gp2ChG+6z7X7HmMw/h8ghE6y4LyvsezySf24uyEJgEi299/Aa9RWf8gBzURKuaof
         8MfKBv0zvHEEenEJi0KYmiIWZ1e2ZuS7BUU3i6KLGuES/dVSpg8e/yofmeY3hQDbX8K7
         WN2EqzoJLMkTfyvI4QPNDEV9YRA2nZch9JulxEs/P+u9A9SOany6nYGY17YBjJbvPW7H
         hgMw==
X-Gm-Message-State: AOAM5336rgdTTN0/6hFEvOc/y3XZKexGrvPeLdn/Y40MiweAyfjQnq+N
        dkRAPRzDDkBbjdPX6rb9UQsP2w==
X-Google-Smtp-Source: ABdhPJyIkqyDZdhScRe/cVgZz1DArjOSJB1ZOuF91yiG6bL5ZYJWLlB1HCb8yyyo1znlBZLda+63rg==
X-Received: by 2002:a17:907:2162:: with SMTP id rl2mr522768ejb.365.1591209687728;
        Wed, 03 Jun 2020 11:41:27 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([79.132.248.22])
        by smtp.gmail.com with ESMTPSA id l18sm196629eds.46.2020.06.03.11.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 11:41:27 -0700 (PDT)
Subject: Re: [PATCH bpf] bpf: fix unused-var without NETDEVICES
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ferenc Fejes <fejes@inf.elte.hu>, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200603081124.1627600-1-matthieu.baerts@tessares.net>
 <CAAej5NZZNg+0EbZsa-SrP0S_sOPMqdzgQ9hS8z6DYpQp9G+yhw@mail.gmail.com>
 <1cb3266c-7c8c-ebe6-0b6e-6d970e0adbd1@tessares.net>
 <20200603181455.4sajgdyat7rkxxnf@ast-mbp.dhcp.thefacebook.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <3573c0dd-baa8-5313-067a-eec6b04f0f36@tessares.net>
Date:   Wed, 3 Jun 2020 20:41:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603181455.4sajgdyat7rkxxnf@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

On 03/06/2020 20:14, Alexei Starovoitov wrote:
> On Wed, Jun 03, 2020 at 11:12:01AM +0200, Matthieu Baerts wrote:
>> Hi Ferenc,
>>
>> On 03/06/2020 10:56, Ferenc Fejes wrote:
>>> Matthieu Baerts <matthieu.baerts@tessares.net> ezt írta (időpont:
>>> 2020. jún. 3., Sze, 10:11):
>>>>
>>>> A recent commit added new variables only used if CONFIG_NETDEVICES is
>>>> set.
>>>
>>> Thank you for noticing and fixed this!
>>>
>>>> A simple fix is to only declare these variables if the same
>>>> condition is valid.
>>>>
>>>> Other solutions could be to move the code related to SO_BINDTODEVICE
>>>> option from _bpf_setsockopt() function to a dedicated one or only
>>>> declare these variables in the related "case" section.
>>>
>>> Yes thats indeed a cleaner way to approach this. I will prepare a fix for that.
>>
>> I should have maybe added that I didn't take this approach because in the
>> rest of the code, I don't see that variables are declared only in a "case"
>> section (no "{" ... "}" after "case") and code is generally not moved into a
>> dedicated function in these big switch/cases. But maybe it makes sense here
>> because of the #ifdef!
>> At the end, I took the simple approach because it is for -net.
>>
>> In other words, I don't know what maintainers would prefer here but I am
>> happy to see any another solutions implemented to remove these compiler
>> warnings :)
> 
> since CONFIG_NETDEVICES doesn't change anything in .h
> I think the best is to remove #ifdef CONFIG_NETDEVICES from net/core/filter.c
> and rely on sock_bindtoindex() returning ENOPROTOOPT
> in the extreme case of oddly configured kernels.

Good idea, thank you!
I can send a patch implementing that.

And sorry for the oddly configured kernels :)
It's just used to test the compilation of the code related to MPTCP.

Cheers,
Matt
-- 
Matthieu Baerts | R&D Engineer
matthieu.baerts@tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
