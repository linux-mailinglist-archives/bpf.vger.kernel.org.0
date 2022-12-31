Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46003659FD7
	for <lists+bpf@lfdr.de>; Sat, 31 Dec 2022 01:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbiLaAmU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Dec 2022 19:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiLaAmT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Dec 2022 19:42:19 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29C91DDE2
        for <bpf@vger.kernel.org>; Fri, 30 Dec 2022 16:42:17 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9so6660995pll.9
        for <bpf@vger.kernel.org>; Fri, 30 Dec 2022 16:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZO9i6cWEEXz8tNBn+j7ydzS2IZbLja1g3ha6d1L8VSM=;
        b=TOXxMiq5TDQE/EYnnGRHKCy1ZkH+Z/2lZkTC+o7jC5zM3mpACtxyiyvGQs6Va4saXw
         q8GVXsOAkVfpIDx0gDZPQ4QhMqPcoQzN5OPZS+/ACWnbuGkfE7QwyjBvgiYPKN2aZEtr
         be3ZveXUrvU2G+gLH1OBv0XdRDG41+hfSMCCbMCiywbBTgIk6RXEBPohDZB80qij5gbH
         hSJuNHHbN7GDYVUpZ6hEL8C4/WcwNgzjslbs8i2i5Hre3A9k3yOJrnZSeiWj4uKCAVsi
         UDrVeojv/UJEkF0WbO/v0br0iQI04/uJKosaBx8DUy9fdcq7y4Y5zzb8l8UgSsYs/Ci2
         pt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO9i6cWEEXz8tNBn+j7ydzS2IZbLja1g3ha6d1L8VSM=;
        b=NJ1gOhpa3YDEXne5EBtrOSeV3MHmq14bUP9xrF71o8pDsgpfQMVc4u1q5MwKIjZSAs
         /UxsaqzkPBk28fWiCjh0xdEWVso3SmcLhlpgvzhhrScBENos4GaZn5xwldpiDEKXiveq
         50iEX3vUxeSLRLRa6q3b+CRVKMNVhDcjx8xgNCyyTM8emJlo30S6jUgLYj95zAcn3B6E
         dTgKnkoHECjv88CA2GzfFj69vLFjLDw0zQhPBad1PcYm9OP68IUWVRcQ7lITxb7FQl8r
         0sq9kN3KgGRhIEGJ0+RL35YQmsdnufh/oVZegT6GecC+RXfJ2iJuWzfmFBplI4OjbIpl
         IV2w==
X-Gm-Message-State: AFqh2ko6trz++n6XAOuYmTxawn6X0HRkZXP4hAc3X96/U3lRK0F19Bun
        1Er+E00J3ieXWcH4+zQqOfg=
X-Google-Smtp-Source: AMrXdXvpRexXyIYbJZcD8itP6j58MmxE9w6LeyLqlKz4Q5dpafyqfG0d1oAwmkm2HRz8rOryiqKP6g==
X-Received: by 2002:a17:90a:8986:b0:221:4258:4e8f with SMTP id v6-20020a17090a898600b0022142584e8fmr36829108pjn.29.1672447337149;
        Fri, 30 Dec 2022 16:42:17 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:1385])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a8d0200b0020a11217682sm13498256pjo.27.2022.12.30.16.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 16:42:16 -0800 (PST)
Date:   Fri, 30 Dec 2022 16:42:13 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Message-ID: <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
References: <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
 <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y69RZeEvP2dXO7to@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 30, 2022 at 03:00:21PM -0600, David Vernet wrote:
> > > 
> > > Taking bpf_get_current_task() as an example, I think it's better to have
> > > the debate be "should we keep supporting this / are users still using
> > > it?" rather than, "it's UAPI, there's nothing to even discuss". The
> > > point being that even if bpf_get_current_task() is still used, there may
> > > (and inevitably will) be other UAPI helpers that are useless and that we
> > > just can't remove.

Sorry, missed this question in the previous reply.
The answer is "it's UAPI, there's nothing to even discuss".
It doesn't matter whether bpf_get_current_task() is used heavily or not used at all.
The chance of breaking user space is what paralyzes the changes.
Any change to uapi header file is looked at with a magnifying glass.
There is no deprecation story for uapi.
The definition and semantics of bpf helpers are frozen _forever_.
And our uapi/bpf.h is not in a good company:
ls -Sla include/uapi/linux/|head
-rw-r--r-- 1 ast users 331159 Nov  3 08:32 nl80211.h
-rw-r--r-- 1 ast users 265312 Dec 25 13:51 bpf.h
-rw-r--r-- 1 ast users 118621 Dec 25 13:51 v4l2-controls.h
-rw-r--r-- 1 ast users  99533 Dec 25 13:51 videodev2.h
-rw-r--r-- 1 ast users  86460 Nov 29 11:15 ethtool.h

"Freeze bpf helpers now" is a minimum we should do right now.
We need to take aggressive steps to freeze the growth of the whole uapi/bpf.h

Support for kfuncs was added in March 2021 in
commit e6ac2450d6de ("bpf: Support bpf program calling kernel function")
In almost 2 years we've learned a lot on how to verify them, how to use and extend them.
The way they're defined in the kernel was refactored ~3 times.
Right now do:
git grep 'BTF_ID_FLAGS(func'
to find all kfuncs.
Including Documentation/bpf/kfuncs.rst that you've made great contribution to :)

When I mentioned 91 kfunc in my previous reply I forgot to count another dozen kfuncs
in sched-ext and another dozen in hid-bpf that are not in mainline yet.
fuse-bpf will likely add their own kfuncs and so on.

Your 'todo list' for kfuncs is absolutely correct. Are kfuncs a perfect substitute
for helpers? No. They have downsides and we need to work on addressing downsides
instead of growing bpf.h further.
Are we ready to freeze bpf helpers? Absolutely yes.
"please use kfuncs instead of helpers" was our recommendation for 9 month or so
and now we need to make it an official rule.
For bpf noobs it's certainly easier to add new prog type, new map type, new helper,
but that gotta stop.
Last prog type we added in May 2021 and we should try hard not to add one anymore.
hid-bpf managed to do everything without new prog type.
sched-ext is not adding new prog type either.
This is great. We're breaking free from uapi constraints.

With map types we are not doing so well:
9330986c03006 (Joanne Koong            2021-10-27 16:45:00 -0700  943)  BPF_MAP_TYPE_BLOOM_FILTER,
583c1f420173f (David Vernet            2022-09-19 19:00:57 -0500  944)  BPF_MAP_TYPE_USER_RINGBUF,
c4bcfb38a95ed (Yonghong Song           2022-10-25 21:28:50 -0700  945)  BPF_MAP_TYPE_CGRP_STORAGE,
99c55f7d47c0d (Alexei Starovoitov      2014-09-26 00:16:57 -0700  946) };

I wish these last three were not added as stable uapi.
Right now we're getting close on defining new map types in unstable way.
The bpf link lists and bpf rbtree are added through kfuncs
(aka new generation data structures, aka graph apis).
They don't have uapi values in 'enum bpf_map_type' and that's
the most important part about them.
Are we ready to freeze map prog types already? Probably not.
Upcoming qp-trie comes to mind that looks very hard to do without new map type.
I hope it will be the last stable map type.

> > > I think Michael Kerrisk's classic "Once upon an API" talk [1] provides a
> > > compelling, real-world example of this point:
> > > 
> > > [1]: https://kernel-recipes.org/en/2022/once-upon-an-api/

This is great analogy. We need to learn from the "uapi pain" of others before us
instead of learning it the hard way through our own mistakes.

> I also don't want to hijack the larger conversation here to discuss
> documentation. I think we all agree that documentation is important. We
> already have a pretty good kfuncs docs page [0] anyways. In my
> subjective opinion, _the_ platform for documenting public / exported BPF
> symbols should have a well-defined documentation story, but yes, arguing
> for it to be a blocker is maybe a stretch.
...
> That being said, I really would hope that we could at least get some of
> the documentation story figured out. Even if it's just something as
> simple as spelling out a formal policy on our kfuncs docs page
> stipulating that you have to add a doxygen header and link it from a
> docs page, it would be nice to have some policy that puts kfuncs on a
> road to being as well documented as helpers.

The challenge of requiring the doc with a kfunc is that it can make kfunc
look stable.
We need the whole spectrum of kfuncs from pretty stable (like bpf_obj_new)
to something very unstable (like bpf_kfunc_call_test_mem_len_fail2).
We cannot require a doc with automatic .h for every kfunc.
Therefore right now all kfuncs are completely unstable and
stability story (including good doc and discoverability) is yet to be figured out.

> > 
> > > 5. Ideally we could improve the story for _defining_ kfuncs as well,
> > > though IMO it's already far less painful than defining helpers. It would
> > > be nice if you could just tag a kfunc with something like a __bpf_kfunc
> > > macro and it would do the following:
> > > 
> > > - Automatically disable the -Wmissing-prototypes warning. I doubt this
> > >   is possible without adding some compiler features that let you do
> > >   something like __attribute__(__nowarn__("Wmissing-prototypes")), so
> > >   maybe this isn't a hard blocker, but more of a medium / long-term
> > >   goal.
> > > - Add whatever other attributes we need for the kfuncs to be safe. For
> > >   example, 'noinline' and '__used'. Even if the symbols are global,
> > >   we'll probably need '__used' for LTO.
> > 
> > would be nice, but that didn't stop existing 91 kfuncs to appear
> > and already used in production.
> > Yes. kfuncs are already used in production.
> 
> This is something that would literally only take like 1-2 patches
> anyways. I'm happy to do it so we don't have to waste cycles thinking
> about it as a blocker for anything.

Yeah. __bpf_kfunc tag would be nice to avoid this boilerplate.

In addition to your 'kfunc todo list' I can add:
6. introduce polymorphic kfuncs
We have helpers that have different implementation depending on prog type.
All kfuncs have one-to-one match so far.
We need kfuncs that would work differently depending on bpf prog context.

7. fine grained kfunc scope
Right now a set of available kfuncs is determined by prog type.
Same thing we do for helpers, but kfuncs already outpaced helpers.
We need to be able to define a set of kfuncs for a pair (prog type, attach location)
or something like that. hid-bpf and sched-ext folks asked for it.
That would be similar to EXPORT_SYMBOL namespaces, but with strict
enforcement for safety.

> Another counterpoint to my initial claim that not having per-arg flags
> could be problematic is that there are certain things that are global in
> kfuncs that are also global in helpers despite having per-arg modifiers.
> For example, the fact that you can only have one OBJ_RELEASE argument.
> And yet another is the fact that none of the helpers we've added in the
> last year relied on having per-arg modifiers, so in practice it hasn't
> been a problem.

Right. Right now we have OBJ_RELEASE flag for args of helpers,
but that refactoring happened recently. Not that long ago
all helpers with release semantic were hard coded in verifier.c.
We're making progress in both helper and kfunc verification.
We should be able to combine the code eventually.

> Part of me was trying to find a compromise here to move forward, but
> honestly, I do agree with you that we should aggressively make
> everything a kfunc unless we have a good reason not to, dynptr functions
> included. So I'm willing to walk this suggestion back as well -- let's
> just make these kfuncs.

Agree that any hard policy like 'only kfuncs from now on' gotta have its limits.
Maybe there will be a strong reason to add a new helper one day,
so we can keep the door open a tiny bit for an exception,
but for dynptr...
There are kfuncs with dynptr already (bpf_verify_pkcs7_signature)
So precedent is already made.

> Also a reasonable point. My point above was really just a response to
> your claim in [0] that dynptrs are flawed. It wasn't related to kfuncs
> vs. helpers.
> 
> [0]: https://lore.kernel.org/all/20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local/

The flawed part of dynptr I was explaining here:
https://lore.kernel.org/all/20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com/

It's not that the whole concept of dynptr is flawed,
but using it as an abstraction on top of skb/xdp.
I don't believe that the extreme performance demands of xdp users are
compatible with 'lets verify in runtime' philosophy of dynptr.
I could be wrong. That's why I'm fine adding dynptr_on_top_of_xdp as kfuncs
and seeing it playing out, but certainly not as a stable helper.
iirc Martin and Kuba had concerns about bits of dynptr(skb | xdp) too.
With kfuncs we can iron out the issues while trying to use it whereas
with helpers we will be stuck for long time in endless mailing list arguments.
It's a win-win for everyone to switch everything to kfuncs.
