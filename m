Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B659A5804D8
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 21:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbiGYTxB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 15:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbiGYTw7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 15:52:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D85620BED;
        Mon, 25 Jul 2022 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=xhDv8lrZ7JZzktF72+HO7I2n3HoF061cSX25xeglrIQ=; b=IhdonFyhiRYeek1iAdVHNM7qgV
        SLvK7TXbLNUjNVYNBraWW7BNnrnh2nDadm7ssG+dCYioo1V2JQgJZ4u5j5pLDSQ1XYFpBDUVqJxNQ
        AmLfEr7HbT25DXEx5/3+fxlustfm37IEVlF8Kmw86flU2LcQoEwBI3AhEZ43P1CqzmGKtZ/0oZcvr
        1plqfBklFjB+TIA8Sx6loIlUUlx1oIU/1t0rO3sFoMk/Ygbn+LD8nK4bvKdVcV2rX0/M5nRdANaaU
        MmMuU1hJiYBVdz1+uXUPtKA4OZbYi+VSAxV3RDQVd+77iXmo+AaG99OlCv1upU6eYnnjG/2xE3QVe
        6Zs4WItg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oG47s-001ATt-W2; Mon, 25 Jul 2022 19:52:25 +0000
Message-ID: <d146f3d6-9b2a-5b54-4ae3-733047ef210e@infradead.org>
Date:   Mon, 25 Jul 2022 12:52:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] docs: Fix typo in comment
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>,
        Joe Perches <joe@perches.com>
Cc:     Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Slark Xiao <slark_xiao@163.com>, kafai <kafai@fb.com>,
        vgoyal <vgoyal@redhat.com>, dyoung <dyoung@redhat.com>,
        ast <ast@kernel.org>, daniel <daniel@iogearbox.net>,
        andrii <andrii@kernel.org>, "martin.lau" <martin.lau@linux.dev>,
        song <song@kernel.org>, yhs <yhs@fb.com>,
        "john.fastabend" <john.fastabend@gmail.com>,
        kpsingh <kpsingh@kernel.org>, sdf <sdf@google.com>,
        haoluo <haoluo@google.com>, jolsa <jolsa@kernel.org>,
        dhowells <dhowells@redhat.com>, peterz <peterz@infradead.org>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        longman <longman@redhat.com>,
        "boqun.feng" <boqun.feng@gmail.com>, tglx <tglx@linutronix.de>,
        bigeasy <bigeasy@linutronix.de>,
        kexec <kexec@lists.infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
References: <20220721015605.20651-1-slark_xiao@163.com>
 <20220721154110.fqp7n6f7ij22vayp@kafai-mbp.dhcp.thefacebook.com>
 <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com>
 <874jzamhxe.fsf@meer.lwn.net>
 <6ca59494-cc64-d85c-98e8-e9bef2a04c15@infradead.org>
 <YtnlAg6Qhf7fwXXW@MiWiFi-R3L-srv>
 <5bd85a7241e6ccac7fe5647cb9cf7ef22b228943.camel@perches.com>
 <Yt6hMD+HIaERgrqg@fedora>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Yt6hMD+HIaERgrqg@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/25/22 06:57, William Breathitt Gray wrote:
> On Mon, Jul 25, 2022 at 06:52:15AM -0700, Joe Perches wrote:
>> On Fri, 2022-07-22 at 07:45 +0800, Baoquan He wrote:
>>> On 07/21/22 at 11:40am, Randy Dunlap wrote:
>>>> On 7/21/22 11:36, Jonathan Corbet wrote:
>>>>> "Slark Xiao" <slark_xiao@163.com> writes:
>>>>>> May I know the maintainer of one subsystem could merge the changes
>>>>>> contains lots of subsystem?  I also know this could be filtered by
>>>>>> grep and sed command, but that patch would have dozens of maintainers
>>>>>> and reviewers.
>>>>>
>>>>> Certainly I don't think I can merge a patch touching 166 files across
>>>>> the tree.  This will need to be broken down by subsystem, and you may
>>>>> well find that there are some maintainers who don't want to deal with
>>>>> this type of minor fix.
>>>>
>>>> We have also seen cases where "the the" should be replaced by "then the"
>>>> or some other pair of words, so some of these changes could fall into
>>>> that category.
>>>
>>> It's possible. I searched in Documentation and went through each place,
>>> seems no typo of "then the". Below patch should clean up all the 'the the'
>>> typo under Documentation.
>> []
>>> The fix is done with below command:
>>> sed -i "s/the the /the /g" `git grep -l "the the " Documentation`
>>
>> This command misses entries at EOL:
>>
>> Documentation/trace/histogram.rst:  Here's an example where we use a compound key composed of the the
>>
>> Perhaps a better conversion would be 's/\bthe the\b/the/g'
> 
> It would be good to check for instances that cross newlines as well;
> i.e. "the" at the end of a line followed by "the" at the start of the
> next line. However, this would require some thought to properly account
> for comment blocks ("*") and other similar prefixes that should be
> ignored.

Yeah, the script that I posted last year (?) does that, but it's noisy --
results need to be hand-checked.

It's not clear how people are finding these repeated words, other than
something like
$ grep "the the" *


-- 
~Randy
