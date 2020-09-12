Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECD0267C35
	for <lists+bpf@lfdr.de>; Sat, 12 Sep 2020 22:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgILUCy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Sep 2020 16:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgILUCv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Sep 2020 16:02:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DEDC061573;
        Sat, 12 Sep 2020 13:02:51 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g29so8669753pgl.2;
        Sat, 12 Sep 2020 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jCctqS19HvE4LQdwQiL4Ym9XyRUXESqazdevqYADPsY=;
        b=QPZNlo3hEkkcw24e4OYy4P8aVV1HndQGaUcnZGSGYEz2FwMoVMNo8DyzcwGJ8Ax/JA
         aQnreQ4a+057HFzfj8KsLXP7+q+5/ll9QogFSRLhlvpUTDqF02CmPOuGiC+6+Qo9wusr
         ubXt2afuQeSOcveSxw8KK09/v0nGdEqXn901uOZIgaEfDWFNnS020miOwpQFlSbwuzEb
         G4r53CrDKCWQS3lghQCjsE7163YlD7RKSIdlHFCdtN48j5uJvYvRSn6bCouL2Maiives
         3na8sVhvoPVqzK2BQJ0rmR/zF9CW9KHfefHvjfutsFp6xrMmnNOfBT3eOlXggwRT9o6R
         NHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jCctqS19HvE4LQdwQiL4Ym9XyRUXESqazdevqYADPsY=;
        b=bqgX7oB6uL43Ta05LH6r7HvicPmfGQgJMC67BHF/7wtCzAC2dFrgGu/0eXM0g0X8Vo
         8TBEitPvSixErF8kjvil7sZDrzdXABZcSv+35AZE1KTEWzvriFkKiOv5xDKGXSfx7S5c
         4mqcp48Tt0t3rK/ypwQjzEr1qX7Ry/ILlHO9+jMA3KWFZ22ZJra9NgSrVIUcimFJ+KOw
         0JgREEO7T+59V6UTCthUAnI65Bq8yGjXeBGy2LMfmkQRGsFM15M75s3eBoMsBbjGpgGv
         GrNMs4819v7INzzA1Od22y2KD15Bykr3gPHXO26so2tNR49KFmQGsAL62URrJG8m8alN
         2PUg==
X-Gm-Message-State: AOAM531QR84s1qmC1wEa4Y3x5sVN+OZ7u1ZXxJaAkOYuB2t2BM0nIEoj
        NL2rAM5Z7JtVYtB12PgEFBlUwGewRfq4cJHtM2A=
X-Google-Smtp-Source: ABdhPJxzAJnBlyVisHCNXXYkf2LG/uTOIHzvGMTeuGV7xNFC6CWYyoIvzFH5oBX2yCoPL+zbI0VJEQ==
X-Received: by 2002:a63:42:: with SMTP id 63mr5920627pga.419.1599940970711;
        Sat, 12 Sep 2020 13:02:50 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.202.95])
        by smtp.gmail.com with ESMTPSA id w206sm6137334pfc.1.2020.09.12.13.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2020 13:02:50 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Subject: Re: [PATCH] Using a pointer and kzalloc in place of a struct directly
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org
References: <000000000000c82fe505aef233c6@google.com>
 <20200912113804.6465-1-anant.thazhemadam@gmail.com>
 <20200912114706.GA171774@kroah.com>
 <09477eb1-bbeb-74e8-eba9-d72cce6104db@gmail.com>
 <20200912145525.GA769913@kroah.com>
Message-ID: <45d9f933-a5c8-ddbd-c014-2bdd5d911e13@gmail.com>
Date:   Sun, 13 Sep 2020 01:32:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200912145525.GA769913@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 12/09/20 8:25 pm, Greg KH wrote:
> On Sat, Sep 12, 2020 at 05:43:38PM +0530, Anant Thazhemadam wrote:
>> On 12/09/20 5:17 pm, Greg KH wrote:
>>> Note, your "To:" line seemed corrupted, and why not cc: the bpf mailing
>>> list as well?
>> Oh, I'm sorry about that. I pulled the emails of all the people to whom
>> this mail was sent off from the header in lkml mail, and just cc-ed
>> everyone.
>>
>>> You leaked memory :(
>>>
>>> Did you test this patch?  Where do you free this memory, I don't see
>>> that happening anywhere in this patch, did I miss it?
>> Yes, I did test this patch, which didn't seem to trigger any issues.
>> It surprised me so much, that I ended up sending it in, to have
>> it checked out.
> You might not have noticed the memory leak if you were not looking for
> it.
>
> How did you test this?
Ah, that must be it. I tested this using syzbot, which wouldn't have looked
for memory leaks, but only the issue that was reported. My apologies.
>> I wasn't sure where exactly the memory allocated here was
>> supposed to be freed (might be why the current implementation
>> isn't exactly using kzalloc). I forgot to mention it in the initial mail,
>> and I was hoping that someone would point me in the right direction
>> (if this approach was actually going to be considered, that is, which in
>> retrospect I now feel might not be the best thing)
> It has to be freed somewhere, you wrote the patch  :)
>
> But back to the original question here, why do you feel this change is
> needed?  What does this do better/faster/more correct than the code that
> is currently there?  Unless you can provide that, the change should not
> be needed, right?
I was initially trying to see if allocating memory would be an appropriate
heuristic in trying to get a better sense of the bug and crash report, and
at that moment, that was my goal, and figured that I'd deal with rest
(such as freeing the memory) later on, if this was a something that could work.

I was surprised when the patch (although it caused a memory leak), seemed
to pass the test for the bug, without triggering any issues; since this patch
basically only allocates memory as compared to locally declaring variables.

I wanted some input or explanation, about how is it that doing this no longer
triggers the bug?
It felt (and still feels) extremely unlikely to me, that allocating memory also
prevents the issue, which is why I figured it might do some help asking
someone, if it does, and I just felt sending in the patch might make it at least
a little less absurd sounding.
Also, if simply allocating memory provides this security (which syzbot seems to
approve, but I still do not understand fully how), wouldn't it be a
welcome change?

Like I said, I'm trying to understand how things work, a little better here,
and I apologize for any confusion that I may have caused.

TLDR;
I tried allocating memory as a heuristic while trying to understand
the bug and the bpf-next tree a little better.
Surprisingly the bug didn't seem to get triggered.
I would like to know the reason why the bug didn't get triggered when syzbot
applied this patch to the bpf-next tree.
If the reason, and allocating memory approach seems sensible  enough,
(or provides some sort of security that I seem to oblivious to), I will try and
come up with a way to free the allocated memory, and send in a v2 as well.

(For anyone who might say that there is another commit that fixes this - yes, I
am aware.
However, if you take a look at the bug at
            https://syzkaller.appspot.com/bug?extid=976d5ecfab0c7eb43ac3
you can see that a generic test (no patch attached) to see if the bug was
still valid was issued much later, and it still turned out to trigger an issue)

