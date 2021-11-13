Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4293E44F236
	for <lists+bpf@lfdr.de>; Sat, 13 Nov 2021 09:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhKMIs7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 13 Nov 2021 03:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhKMIs7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 13 Nov 2021 03:48:59 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118BAC061767
        for <bpf@vger.kernel.org>; Sat, 13 Nov 2021 00:46:07 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w29so19693643wra.12
        for <bpf@vger.kernel.org>; Sat, 13 Nov 2021 00:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZtDnCZ/w/psJS2PRIihRoZb3eaeTQIwGDkZv2udShjk=;
        b=li607doaPUCb/xWMTz67AL9GZ9Pb3MRIpM7Nw+vkpA6TVMXwAwH8herBsCby7Q591x
         YDu522PWnbNiiQv160pBddkTsiC1+K8+ZWgsb6AhQKeFPTjFhSYLqcFzoKGtLigEuREw
         8DmvXcZI4YVT7kmxEU4myncpmY2OYZyDrRQ3ZHMTcA2ETAbZuSkK3EiPIUdQPz0LUCeu
         40QKhHdNfdCrpi8z8sz0DYjgZaJ+dPNqKc9WRH+rvJ+lOUrepLgmQc5VIEn0fABJ3gTQ
         IZ2J05SlDJpOlGkVDkd9VuTNIiASVG1RD6dI35WR72/pvipKffRI2JDl8SCLCoF766g4
         4rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZtDnCZ/w/psJS2PRIihRoZb3eaeTQIwGDkZv2udShjk=;
        b=6mbdNY3gjEIrYQVUcec6t+lz6e2ngmUHjBjQLGJpiMe+55EHy3cwsEMsspuKf4dKYW
         XfQHgrkgiFGTnJbroEpCyJps/5D9SFMkW4mB/kxg8hQZRvWX6Ht0C9j/izN8V2FSpq5s
         3GQvgjbMB6x+drn4Etb/re5j6vL3bKdt83jTfWwUfqAliuY5c5lEP5/DTOb8VrC1acw6
         6YW48x11PVHOx00TGGxqyuVE56TCVH+r/2VeR9sYLf5Zp0uQWPeLSceKUkHKUhY/8GtD
         wfgzWnM9pYYOQ0bQgWlq2CmA7fDtaMnWzttF38hOKbdRFEd+ZKDzkfS/RqsPOc40fpwi
         IxSQ==
X-Gm-Message-State: AOAM532o7C00fImB74+dE+J2ABjIaeLw95JVyObauex6Y6v7HyX3fWXw
        TJcnfANSTEMAWOtW6rGdvWEbuQ==
X-Google-Smtp-Source: ABdhPJzfL02HdsRzG4Og/K2JWrEAxZfcZ6YSER9KY6jul7/fUwjNjtVbk7TR191IUwRViXJNdLACrQ==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr27250298wrj.325.1636793165247;
        Sat, 13 Nov 2021 00:46:05 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:90b:17fa:42f:1e9c? ([2a01:e34:ed2f:f020:90b:17fa:42f:1e9c])
        by smtp.googlemail.com with ESMTPSA id y6sm8480147wrh.18.2021.11.13.00.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 00:46:04 -0800 (PST)
Subject: Re: 32bit x86 build broken (was: Re: [GIT PULL] Networking for
 5.16-rc1)
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        linux-can@vger.kernel.org
References: <20211111163301.1930617-1-kuba@kernel.org>
 <163667214755.13198.7575893429746378949.pr-tracker-bot@kernel.org>
 <20211111174654.3d1f83e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAHk-=wiNEdrLirAbHwJvmp_s2Kjjd5eV680hTZnbBT2gXK4QbQ@mail.gmail.com>
 <20211112063355.16cb9d3b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <9999b559abecea2eeb72b0b6973a31fcd39087c1.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <be9c603b-26a6-fb33-07d9-7aae8f9bf644@linaro.org>
Date:   Sat, 13 Nov 2021 09:46:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9999b559abecea2eeb72b0b6973a31fcd39087c1.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/11/2021 16:04, Srinivas Pandruvada wrote:
> On Fri, 2021-11-12 at 06:33 -0800, Jakub Kicinski wrote:
>> On Thu, 11 Nov 2021 18:48:43 -0800 Linus Torvalds wrote:
>>> On Thu, Nov 11, 2021 at 5:46 PM Jakub Kicinski <kuba@kernel.org>
>>> wrote:
>>>> Rafael, Srinivas, we're getting 32 bit build failures after pulling
>>>> back
>>>> from Linus today.
>>>>
>>>> make[1]: *** [/home/nipa/net/Makefile:1850: drivers] Error 2
>>>> make: *** [Makefile:219: __sub-make] Error 2
>>>> ../drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c:
>>>> In function ‘send_mbox_cmd’:
>>>> ../drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c:7
>>>> 9:37: error: implicit declaration of function ‘readq’; did you mean
>>>> ‘readl’? [-Werror=implicit-function-declaration]
>>>>    79 |                         *cmd_resp = readq((void __iomem *)
>>>> (proc_priv->mmio_base + MBOX_OFFSET_DATA));
>>>>       |                                     ^~~~~
>>>>       |                                     readl  
>>>
>>> Gaah.
>>>
>>> The trivial fix is *probably* just a simple
>>
>> To be sure - are you planning to wait for the fix to come via 
>> the usual path?  We can hold applying new patches to net on the 
>> off chance that you'd apply the fix directly and we can fast 
>> forward again :) 
>>
>> Not that 32bit x86 matters all that much in practice, it's just 
>> for preventing new errors (64b divs, mostly) from sneaking in.
>>
>> I'm guessing Rafeal may be AFK for the independence day weekend.
> He was off, but not sure if he is back. I requested Daniel to send PULL
> request for
> https://lore.kernel.org/lkml/a22a1eeb-c7a0-74c1-46e2-0a7bada73520@infradead.org/T/

FYI

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d9c8e52ff9e84ff1a406330f9ea4de7c5eb40282


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
