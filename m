Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B5B309EF7
	for <lists+bpf@lfdr.de>; Sun, 31 Jan 2021 21:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhAaUgP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jan 2021 15:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhAaUgD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jan 2021 15:36:03 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D225C061573
        for <bpf@vger.kernel.org>; Sun, 31 Jan 2021 12:35:20 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id a1so7204479qvd.13
        for <bpf@vger.kernel.org>; Sun, 31 Jan 2021 12:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dZVoYvBEbjdRi+n/vXfZg27E1gnXAg6WXs8ZSgaW7tA=;
        b=TQ/fqoaUzgKgBg60lA0W4GROZWokCHwnNKxb1Hz4xdbgxOYBE9D0/gWgV4HdYcnFOS
         Y3Ois1Hw4PpwTRnIDx1/3/lVtbRA6I8+SHjomy8WA5aHZXg3pooVwwoG2Msr3FQNXU7T
         iYNZtG8+LdJDh4E/HTVfc1zAdV8b+elGCTwcKtat+gtWOgppOp9QQujpLHCzz3S2pZFe
         BXX4HXphOOlYrQEMPgm6UJOqet00SJVuSIElmuPNyqc8PIhBgQ1V4+z75j7KQJ0PsAJG
         eytTMqlcGjmogVjVAZEbjNc0BWwC9JH7CBfIBydatGFnk912cocIUxjrZmDQG4w++NLX
         dOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dZVoYvBEbjdRi+n/vXfZg27E1gnXAg6WXs8ZSgaW7tA=;
        b=rjqTI76vIAzwmukSS2QyMSed5ocqj6MucCW/LvceAXcz9d4Hh5vgm55fPfcfDmoixR
         dcutqcCSxRXUWYsaox6QFRbT5UbGCgnpyJHv5ALsdVKW9PYaXal/JEtp9eMPTK55O8Aj
         bNbgjdsKCpdgokB4e/UOs85D8aoEKdzPIJaWdb5a0zyK62r56FfKR2KNxuQJAiV/vwIZ
         5Pvi5hd4zqVv2myjlpLqIreMGi/712rznicCc38n9K94Kax7LqBtCD54oPIbRa1d4O+v
         l3GjXCQd8CDqPXXUVkwjng5Jlij3jx8J1PXSNY+adXiRioyT/wdhnlWRmG3ekVwBjtAd
         JqJg==
X-Gm-Message-State: AOAM532b3h/ZPoZxKhNA2m2wtcxV+/zdVY0Z/NnPT/W3R91CLH3LLv4b
        2EKwP70DZG//I9nw5uoplCSeRQ==
X-Google-Smtp-Source: ABdhPJw2ZPKML7GsFPQxA7G4z5QWK/N1CqAbyDPUNbJq6K35dtWCQZo2G94ZUj3vZNOHzwt9yKfSrw==
X-Received: by 2002:a05:6214:1110:: with SMTP id e16mr12585884qvs.62.1612125319251;
        Sun, 31 Jan 2021 12:35:19 -0800 (PST)
Received: from [192.168.2.48] (bras-base-kntaon1617w-grc-10-184-147-165-106.dsl.bell.ca. [184.147.165.106])
        by smtp.googlemail.com with ESMTPSA id d1sm5149128qtn.30.2021.01.31.12.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 12:35:18 -0800 (PST)
Subject: Re: [Patch bpf-next v5 1/3] bpf: introduce timeout hash map
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Dongdong Wang <wangdongdong.6@bytedance.com>
References: <20210122205415.113822-1-xiyou.wangcong@gmail.com>
 <20210122205415.113822-2-xiyou.wangcong@gmail.com>
 <d69d44ca-206c-d818-1177-c8f14d8be8d1@iogearbox.net>
 <CAM_iQpW8aeh190G=KVA9UEZ_6+UfenQxgPXuw784oxCaMfXjng@mail.gmail.com>
 <CAADnVQKmNiHj8qy1yqbOrf-OMyhnn8fKm87w6YMfkiDHkBpJVg@mail.gmail.com>
 <CAM_iQpXAQ7AMz34=o5E=81RFGFsQB5jCDTCCaVdHokU6kaJQsQ@mail.gmail.com>
 <20210129025435.a34ydsgmwzrnwjlg@ast-mbp.dhcp.thefacebook.com>
 <f7bc5873-7722-e359-b450-4db7dc3656d6@mojatatu.com>
 <dc5ddf32-2d65-15a9-9448-5f2d3a10d227@mojatatu.com>
 <CAADnVQJafr__W+oPvBjqisvh2vCRye8QkT9TQTFXH=wsDGtKqA@mail.gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <c4c6d889-d8ec-efe5-7fcb-aed9f5efa318@mojatatu.com>
Date:   Sun, 31 Jan 2021 15:35:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAADnVQJafr__W+oPvBjqisvh2vCRye8QkT9TQTFXH=wsDGtKqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-01-29 10:14 p.m., Alexei Starovoitov wrote:
> On Fri, Jan 29, 2021 at 6:14 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>
>> On 2021-01-29 9:06 a.m., Jamal Hadi Salim wrote:
>>
>>> Which leads to:
>>> Why not extend the general feature so one can register for optional
>>> callbacks not just for expire but also add/del/update on specific
>>> entries or table?
>>> add/del/update could be sourced from other kernel programs or user space
>>> and the callback would be invoked before an entry is added/deleted etc.
>>> (just like it is here for expiry).
>>
>> Sorry - shouldve read the rest of the thread:
>> Agree with Cong that you want per-map but there are use cases where you
>> want it per entry (eg the add/del/update case).
> 
> That was my point as well.
> bpf_timer api should be generic, so that users can do both.
> The program could use bpf_timer one for each flow and bpf_timer for each map.
> And timers without maps.

I like it. Sensible to also have callback invocations for map
changes i.e entry create/update/delete (maybe map create/destroy).

cheers,
jamal
