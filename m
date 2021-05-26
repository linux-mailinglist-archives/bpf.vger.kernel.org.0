Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF73391EFE
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 20:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhEZS1D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 14:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhEZS1D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 14:27:03 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7193CC061574
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 11:25:31 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id v18so1236717qvx.10
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YZP3JsPwgqjrQNdOcs+V1lvUEQFeQP7DeA3ibzoYnFI=;
        b=UbrQ99N6aM/qzXDjud5HaYEmIt3CuMIHsEumZ3aO3sLfXUaNselCC/GRERLQxD+9dR
         JI5XgrprTNIcTmDiG8mpCAuwf0zYNCTdoSdCvNaY/LbqHsGVsQnzNSVEjZU8BPKJ9szw
         w+4d3GDPi1ojj7syNuY4PSkkp1tL/agnM1ZuWXdfQx5TueRt/7ITu7dcJcx7/feTeLtl
         iFSAoHOkmT4h1tTPc6n4whhWHCh94drd2Ogn7T0osehfK+ofr5/ECBtZEGcbDTAPEIxz
         +Bj/ehayAnSWBEjFifPg8Dl9VfqVfT0nfScCXG7Vygs1CpQw4dIzw6GbWgHccm7OSYma
         Cluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YZP3JsPwgqjrQNdOcs+V1lvUEQFeQP7DeA3ibzoYnFI=;
        b=ZTeEpSe6cqVI/YKki3LihTgLTfv/webOS/bJNje0ATF+WQZ8KbWIk3ec4cC5xL1KgH
         BcwBCwIKBtd14mOVvSrw9cAN8VLnTL2JisB9F8uNhyEeAO33hMgysmi5/5xbip2uDHh9
         z0GmVKg9ocetNUNXYiPZ5V68+tdTQT4Szh61EI/b6593hNv88O33h8aWXCP5FgTFSYMq
         J8pVrtDg6ZgAUShxhAAs3gHG+wQh5x7oBQprPod65OP2Ofv2UMxgQRCIbBMJuB0FHSL3
         eggba8sBIw3el4IjlljWaDBHDcB4z8DmZwEQIC97naoNfpB/yOvVWdN1/Xt5lTbARQFo
         zo5Q==
X-Gm-Message-State: AOAM531y21bwRFQy/MGTfdrECU6cGvqncvrsblx/uaP30FN1DkJI7TWv
        U4q9NzDzK+iwFnR7aRPnJ4UX7Q==
X-Google-Smtp-Source: ABdhPJwRnGoz/YhqYW0RWKHD7+wOUenpRS4IsiTOY8T3+2HksYbIG7cdJl4L3tn5KB31j+0sra6LiA==
X-Received: by 2002:a0c:9e24:: with SMTP id p36mr44263772qve.60.1622053530574;
        Wed, 26 May 2021 11:25:30 -0700 (PDT)
Received: from [192.168.1.79] (bras-base-kntaon1617w-grc-28-184-148-47-211.dsl.bell.ca. [184.148.47.211])
        by smtp.googlemail.com with ESMTPSA id h6sm1953725qta.74.2021.05.26.11.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 11:25:29 -0700 (PDT)
Subject: Re: [RFC PATCH bpf-next] bpf: Introduce bpf_timer
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@fb.com>,
        Pedro Tammela <pctammela@gmail.com>
References: <CAM_iQpWDgVTCnP3xC3=z7WCH05oDUuqxrw2OjjUC69rjSQG0qQ@mail.gmail.com>
 <CAADnVQ+V5o31-h-A+eNsHvHgOJrVfP4wVbyb+jL2J=-ionV0TA@mail.gmail.com>
 <CAM_iQpU-Cvpf-+9R0ZdZY+5Dv+stfodrH0MhvSgryv_tGiX7pA@mail.gmail.com>
 <CAM_iQpVYBNkjDeo+2CzD-qMnR4-2uW+QdMSf_7ohwr0NjgipaQ@mail.gmail.com>
 <CAADnVQJUHydpLwtj9hRWWNGx3bPbdk-+cQiSe3MDFQpwkKmkSw@mail.gmail.com>
 <bcbf76c3-34d4-d550-1648-02eda587ccd7@mojatatu.com>
 <CAADnVQLWj-=B2TfJp7HEsiUY3rqmd6-YMDAGdyL6RgZ=_b2CXg@mail.gmail.com>
 <27dae780-b66b-4ee9-cff1-a3257e42070e@mojatatu.com>
 <CAADnVQJq37Xi2bHBG5L+DmMq6dJvFUCE3tt+uC-oAKX3WxcCQg@mail.gmail.com>
 <2dfc5180-40df-ae4c-7146-d64130be9ad4@mojatatu.com>
 <20210526165847.g4z5anq6ync47z4t@ast-mbp.dhcp.thefacebook.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <3a274610-c407-7a66-4acb-d5dfde0d5951@mojatatu.com>
Date:   Wed, 26 May 2021 14:25:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210526165847.g4z5anq6ync47z4t@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-05-26 12:58 p.m., Alexei Starovoitov wrote:
> On Wed, May 26, 2021 at 11:34:04AM -0400, Jamal Hadi Salim wrote:
>> On 2021-05-25 6:08 p.m., Alexei Starovoitov wrote:
>>> On Tue, May 25, 2021 at 2:09 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:


>>
>> Didnt follow why this wouldnt work in the same way for Array?
> 
> array doesn't have delete.

Ok. But even for arrays if userspace for example does update
of an existing entry we should be able to invoke callback, no?

>> One interesting concept i see come out of this is emulating
>> netlink-like event generation towards user space i.e a user
>> space app listening to changes to a map.
> 
> Folks do it already via ringbuf events. No need for update/delete
> callback to implement such notifications.
> 

Please bear with me:
I know it is trivial to do if you are in control of the kernel
side if your prog creates/updates/deletes map entries. Ive done
it many times with perf event arrays (before ringbuf existed).
But:
What i was referring to is if another entity altogether
(possibly not under your control) was to make that change
from the kernel side then you dont get to know. Same with a
user space program doing a write to the map entry.

If you say this can be done then please do me a kindness and point
me to someone already doing this or some sample code.


>> would like to hear what the proposed ideas are.
>> I see this as a tricky problem to solve - you can make LRU
>> programmable to allow the variety of LRU replacement algos out
>> there but not all encompansing for custom or other types of algos.
>> The problem remains that LRU is very specific to evicting
>> entries that are least used. I can imagine that if i wanted to
>> do a LIFO aging for example then it can be done with some acrobatics
>> as an overlay on top of LRU with all sorts of tweaking.
>> It is sort of fitting a square peg into a round hole - you can do
>> it, but why the torture when you have a flexible architecture.
> 
> Using GC to solve 'hash table is running out of memory' problem is
> exactly the square peg.
> Timers is absolutely wrong way to address memory pressure.
> 
>> We need to provide the mechanisms (I dont see a disagreement on
>> need for timers at least).
> 
> It's an explicit non-goal for timer api to be used as GC for conntrack.

Agreed.

> You'll be able to use it as such, but when it fails to scale
> (as it's going to happen with any timer implementation) don't blame
> infrastructure for that.

Agreed again. Timers are a necessary part of the toolset.
I hope i was reading as claiming that just firing random
timers equates to gc or that on its own will scale.


>> A reasonable approach is to let the policy be defined
>> from user space. I may want the timer to keep polling
>> a map that is not being updated until the next program
>> restarts and starts updating it.
>> I thought Cong's approach with timerids/maps was a good
>> way to achieve control.
> 
> No, it's not a policy, and no, it doesn't belong to user space,
> and no, Cong's approach has nothing to do with this design choice.

You listed 3 possibilities of what could happen in the use case
i described. One person's meat is another person's poison.
i.e it is about design choice. What i meant by policy is
whether intentionaly or not, Cong's approach had the user able to
control what happens to the timer.

cheers,
jamal
