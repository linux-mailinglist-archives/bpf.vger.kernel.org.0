Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC2E1E6A1E
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 21:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406150AbgE1TJK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 15:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406147AbgE1TJI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 15:09:08 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4B2C08C5C7
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 12:09:08 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id i22so158646oik.10
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R1miPeFxlEwY+xa1vHbyy5ZFTUIV4sByz1KFasPvaMo=;
        b=J/w44VXcuQwVzhDejQed3zs4vp1LHMgN7CuoIIpC+RzHwUC0pojnD40cPYLaT3gRTw
         uhIUxj+WX5IA8XU3NY3RTwC6uonE3JI6oExue/f4VgCSRXaCI/xnEgh/qvhYXxiCjpW5
         pTpDC5NrnfhRTiVnDHhB91P2s73OCZpNMv2Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R1miPeFxlEwY+xa1vHbyy5ZFTUIV4sByz1KFasPvaMo=;
        b=cZsRxkUf72ry7V99aGcE95R9Ya4FL/Rg5IZErnGWrCrOT6tqmpcsDtLnxJdqmHHO0d
         Q1TVOlZU0ntRqJ48lzLvfT1E+3pdTy0qQ6K9sTussNF2T69RbnFE2TrgcRTlwNIpPOOn
         cfSs6OUfRVvdq403ci2He+7Ydp/M6DeOvDU3dhD4eZ0wRr0AYeEg7Q9PlAx0/PuH76d9
         U3he3c2SiTiHydTmNNO0aPU93ykayz6X+t59K5qgt+sWU2swbEnO5AOH84XC/o84dSQU
         68EZCrK1UgTQyapU/qoXsWRSWhK/YyWGm/dKp38MYjLF3/DWFXDN3b9n25DkJf19hDCZ
         ZAkA==
X-Gm-Message-State: AOAM531Q7lWrTh7685/kd2XeIh1rgVHy5oKiQhngVL/3hV8LITA22bKQ
        aUDGXgHY6x6S/1A576j9Zfm5rQ==
X-Google-Smtp-Source: ABdhPJzeIeUYkycKOmuIkrTdoApQA1unywU2tyzVI1+rxsL25gai5MwSGXcFgSO/d+YuLo7Ym04KcA==
X-Received: by 2002:aca:5202:: with SMTP id g2mr3386666oib.80.1590692947211;
        Thu, 28 May 2020 12:09:07 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v10sm1593704oov.15.2020.05.28.12.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:09:06 -0700 (PDT)
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Benc <jbenc@redhat.com>,
        shuah <shuah@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, skhan@linuxfoundation.org
References: <xunya71uosvv.fsf@redhat.com>
 <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
 <xuny367lq1z1.fsf@redhat.com>
 <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com>
 <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org>
 <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
 <20200528100557.20489f04@redhat.com> <20200528105631.GE3115014@kroah.com>
 <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
 <CANoWswkGoJEZVcfLiNverDWyh6skSoix=JqxeJR9K8A=H8x=rw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <49931ed9-da92-4b32-ba54-aeba33166bdd@linuxfoundation.org>
Date:   Thu, 28 May 2020 13:09:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CANoWswkGoJEZVcfLiNverDWyh6skSoix=JqxeJR9K8A=H8x=rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/28/20 11:10 AM, Yauheni Kaliuta wrote:
> Hi, Alexei,
> 
> On Thu, May 28, 2020 at 7:14 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Thu, May 28, 2020 at 12:56:31PM +0200, Greg KH wrote:
>>> On Thu, May 28, 2020 at 10:05:57AM +0200, Jiri Benc wrote:
>>>> On Wed, 27 May 2020 15:23:13 -0700, Alexei Starovoitov wrote:
>>>>> I prefer to keep selftests/bpf install broken.
>>>>> This forced marriage between kselftests and selftests/bpf
>>>>> never worked well. I think it's a time to free them up from each other.
>>>>
>>>> Alexei, it would be great if you could cooperate with other people
>>>> instead of pushing your own way. The selftests infrastructure was put
>>>> to the kernel to have one place for testing. Inventing yet another way
>>>> to add tests does not help anyone. You don't own the kernel. We're
>>>> community, we should cooperate.
>>>
>>> I agree, we rely on the infrastructure of the kselftests framework so
>>> that testing systems do not have to create "custom" frameworks to handle
>>> all of the individual variants that could easily crop up here.
>>>
>>> Let's keep it easy for people to run and use these tests, to not do so
>>> is to ensure that they are not used, which is the exact opposite goal of
>>> creating tests.
>>
>> Greg,
>>
>> It is easy for people (bpf developers) to run and use the tests.
>> Every developer runs them before submitting patches.
>> New tests is a hard requirement for any new features.
>> Maintainers run them for every push.
>>
>> What I was and will push back hard is when other people (not bpf developers)
>> come back with an excuse that some CI system has a hard time running these
>> tests. It's the problem of weak CI. That CI needs to be fixed. Not the tests.
>> The example of this is that we already have github/libbpf CI that runs
>> selftests/bpf just fine. Anyone who wants to do another CI are welcome to copy
>> paste what already works instead of burdening people (bpf developers) who run
>> and use existing tests. I frankly have no sympathy to folks who put their own
>> interest of their CI development in front of bpf community of developers.
>> The main job of CI is to help developers and maintainers.
>> Where helping means to not impose new dumb rules on developers because CI
>> framework is dumb. Fix CI instead.
>>
> 
> Any good reason why bpf selftests, residing under selftests/, should
> be an exception?
> "Breakages" is not, breakages are fixable.
> 

Let's not talk about moving tests. I don't want to discuss that until
we are all on the same page on what is the problem in adding install
support to bpf Makefile.

It is possible that there is a misunderstanding that bpf maintainer
and developer workflow will change. Which is definitely not needed.
If this patch series requires it, it isn't correct and needs to be
reworked.

thanks,
-- Shuah

