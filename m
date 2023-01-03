Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB2565CA93
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 00:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjACXvO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 18:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjACXvM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 18:51:12 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B158311805
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 15:51:11 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 6so18979162pfz.4
        for <bpf@vger.kernel.org>; Tue, 03 Jan 2023 15:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3vclEQWbp6wG6QMfHIkMLz8vSC1zPM4OFdAnE9dabfc=;
        b=XdBP+7RKA2bVvqrPdzkLtCjBdqpfhMbq13pEW9kUudW+lwrl32saSeMFWfp3Z0inkN
         5BTUu8iDN9iZMnyKvLLsUspWAHI65dnrdkruEF1bbP21UxumYKefofZ5tCBACzlALrww
         YdP3VJuXdWJtVwzbncsioIh+nJM0IkVs2PViaTSVz0Ao1mgGJnme1gCTgXcCJkALBvE2
         xYkw4q7MKRea9lFxRF/oQ2usIRaE++aKg005US9D+i4RaSoBEOyx3asNLFmfnfFgGEKk
         znnlSuzCLiJBUBYqvBVMvwszVX1DtnME1DQjWBngg2IB1FD6XEN+wBMApi5KZo+H1e5j
         q2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vclEQWbp6wG6QMfHIkMLz8vSC1zPM4OFdAnE9dabfc=;
        b=ZXhyw1A8gT7bWAIXz7bbFd0oENoboavj1EKLdXEWKFlSCawMT3EmVpgpkKeXs7JvwD
         S8VEQZSlmGGLOxdtTMFarY32Fzg8YQabWO4fofV+biMrTKaxW6qa3sHvBS+P5yrBeetV
         wALz+HHt0+10JbR+32Fhs/ohy82KRR21qpgwe4aHSdCKwIgJw7jo8kfhIq+JBV/DPEL4
         0rx1ivGx6R8CQUAeGY/PEjxgI9Gpxzsf1DHcVC7a5oO2BoYJywquVq0NTkUL5ZLyO8tX
         CyIiWjp0sCkHBaWgA1z+4r8hjGBL0YtfDBUFitM3Fqh76+TXh3my7FajfZHet5cd7eQb
         U+lg==
X-Gm-Message-State: AFqh2kovZtN3xSAUyc664PWawWraPyBkjBD1n6zqFy9o3uBU1bn921ht
        0lq3G24OqmFDsBYo1ceGU7k=
X-Google-Smtp-Source: AMrXdXuCwCwEr2JzKOSAvOPsNyOIJhSxZ/4rUAWCldxOue7RRE1D7leN8+e0xxDvNzhQgYekKkClgQ==
X-Received: by 2002:aa7:9e05:0:b0:582:7905:3030 with SMTP id y5-20020aa79e05000000b0058279053030mr9772442pfq.3.1672789870941;
        Tue, 03 Jan 2023 15:51:10 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:1385])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79691000000b005825b8e0540sm5350509pfk.204.2023.01.03.15.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 15:51:10 -0800 (PST)
Date:   Tue, 3 Jan 2023 15:51:07 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     David Vernet <void@manifault.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Message-ID: <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
References: <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
 <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan>
 <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
 <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 03, 2023 at 12:43:58PM +0100, Daniel Borkmann wrote:
> On 12/31/22 1:42 AM, Alexei Starovoitov wrote:
> > On Fri, Dec 30, 2022 at 03:00:21PM -0600, David Vernet wrote:
> > > > > 
> > > > > Taking bpf_get_current_task() as an example, I think it's better to have
> > > > > the debate be "should we keep supporting this / are users still using
> > > > > it?" rather than, "it's UAPI, there's nothing to even discuss". The
> > > > > point being that even if bpf_get_current_task() is still used, there may
> > > > > (and inevitably will) be other UAPI helpers that are useless and that we
> > > > > just can't remove.
> > 
> > Sorry, missed this question in the previous reply.
> > The answer is "it's UAPI, there's nothing to even discuss".
> > It doesn't matter whether bpf_get_current_task() is used heavily or not used at all.
> > The chance of breaking user space is what paralyzes the changes.
> > Any change to uapi header file is looked at with a magnifying glass.
> > There is no deprecation story for uapi.
> > The definition and semantics of bpf helpers are frozen _forever_.
> > And our uapi/bpf.h is not in a good company:
> > ls -Sla include/uapi/linux/|head
> > -rw-r--r-- 1 ast users 331159 Nov  3 08:32 nl80211.h
> > -rw-r--r-- 1 ast users 265312 Dec 25 13:51 bpf.h
> > -rw-r--r-- 1 ast users 118621 Dec 25 13:51 v4l2-controls.h
> > -rw-r--r-- 1 ast users  99533 Dec 25 13:51 videodev2.h
> > -rw-r--r-- 1 ast users  86460 Nov 29 11:15 ethtool.h
> > 
> > "Freeze bpf helpers now" is a minimum we should do right now.
> > We need to take aggressive steps to freeze the growth of the whole uapi/bpf.h
> 
> Imho, freezing BPF helpers now is way too aggressive step. One aspect which was
> not discussed here is that unstable kfuncs will be a pain for user experience
> compared to BPF helpers. Probably not for FB or G who maintain they own limited
> set of kernels, but for all others. If there is valid reason that kfuncs will have
> to change one way or another, then BPF applications using them will have to carry
> the maintenance burden on their side to be able to support a variety of kernel
> versions with working around the kfunc quirks. So you're essentially outsourcing
> the problem from kernel to users, which will suck from a user experience (and add
> to development cost on their side). 

It's actually the opposite.
A small company that wants to use BPF needs to have a workaround/plan B for
different kernels and different distros.
That's why cilium and others have to detect availability of helpers and bpf features.
One bpf prog for newer kernel and potentially completely different solution
for older kernels.
That's the biggest obstacle in bpf adoption: the required features are in
the latest kernels, but companies have to support older kernels too.
Now look at the problem from different angle:
Detecting kfuncs is no different than detecting helpers.
The bpf users has to have a workaround when helper/kfunc is not available.
In that sense stability of the helpers vs instability of kfuncs is irrelevant.
Both might not exist in a particular kernel.
So if cilium starts to use kfunc it won't be extra development cost and
bpf program writer experience using kfuncs vs using helpers is the same as well.
But with kfuncs we can solve this bpf adoption issue.
The helpers are not easily backportable and cannot be added in modules,
so company's workarounds for older kernel are painful.
While kfuncs are trivially added in a module.

Let's take bpf_sock_destroy that Aditi wants to add as an example.
If it's done as a helper the cilium would need to wait for the next kernel release
and next distro release some years from now to actually use it at the customer site.
If bpf_sock_destroy is added as kfunc you can ship an extra kernel module
with just that kfunc to your customers. You can also attempt to convince a distro
that this module with kfuncs should be certified, since the same kfunc is in upstream kernel.
The customer can use cilium that relies on bpf_sock_destroy much sooner
and likely there won't be a need to develop a completely different workaround
for kernels without that kfunc.
There is no need to actually backport bpf_sock_destroy to older kernels.
As long as verifier infrastructure for kfuncs is feature rich all new kfuncs
can be shipped by distro or by cilium in a module without affecting
support contract of the main kernel.

The verification of kfuncs is still actively evolving, but in not too distant future
people will be able to ship/add kfuncs without touching the kernel.
The faster the whole bpf community switches to 'use kfuncs for everything' model
the faster the verification of them becomes solid and bpf adoption issue will be addressed.

> Ofc there is interest in keeping changes to a
> minimum, but it's not the same as BPF helpers where there is a significantly higher
> guarantee that things continue to keep working going forward. Today in Cilium we
> don't use any of the kfuncs, we might at some point when we see it necessary, but
> likely to a limited degree if sth cannot be solved as-is and only kfunc is present
> as a solution. But again, from a UX it's not great having to know that things can
> break anytime soon with newer kernels (things might already with verifier/LLVM
> upgrade and kfunc potentially adds yet another level). Generally speaking, I'm not
> against kfuncs but I suggest only making "freeze bpf helpers now" a soft freeze
> with a path forward for promoting some of the kfuncs which have been around and
> matured for a while and didn't need changes as stable BPF helpers to indicate their
> maturity level when we see it fit. So it's not a hard "no", but possible promotion
> when suitable.

The problem with 'soft' freeze that it's open to interpretation and abuse.
It feels to me you're saying that cilium is not using kfuncs and
therefore all cilium features additions are ok to be done as helpers.
That doesn't sound fair to other bpf devs.

> 
> [...]
> > When I mentioned 91 kfunc in my previous reply I forgot to count another dozen kfuncs
> > in sched-ext and another dozen in hid-bpf that are not in mainline yet.
> > fuse-bpf will likely add their own kfuncs and so on.
> 
> For the latter agree as well given from a bigger picture, they are mainly niche use
> cases at this point and in future.

I'd argue that cilium's bpf_sock_destroy is just as niche as sched-ext scheduling kfuncs.

> 
> > Your 'todo list' for kfuncs is absolutely correct. Are kfuncs a perfect substitute
> > for helpers? No. They have downsides and we need to work on addressing downsides
> > instead of growing bpf.h further.
> > Are we ready to freeze bpf helpers? Absolutely yes.
> > "please use kfuncs instead of helpers" was our recommendation for 9 month or so
> > and now we need to make it an official rule.
> > For bpf noobs it's certainly easier to add new prog type, new map type, new helper,
> > but that gotta stop.
> > Last prog type we added in May 2021 and we should try hard not to add one anymore.
> > hid-bpf managed to do everything without new prog type.
> > sched-ext is not adding new prog type either.
> > This is great. We're breaking free from uapi constraints.
> [...]
> 
> > The challenge of requiring the doc with a kfunc is that it can make kfunc
> > look stable.
> > We need the whole spectrum of kfuncs from pretty stable (like bpf_obj_new)
> > to something very unstable (like bpf_kfunc_call_test_mem_len_fail2).
> > We cannot require a doc with automatic .h for every kfunc.
> > Therefore right now all kfuncs are completely unstable and
> > stability story (including good doc and discoverability) is yet to be figured out.
> [...]
> 
> Discoverability plus being able to know semantics from a user PoV to figure out when
> workarounds for older/newer kernels are required to be able to support both kernels.

Sounds like your concern is that there could be a kfunc that changed it semantics,
but kept exact same name and arguments? Yeah. That would be bad, but we should prevent
such patches from landing. It's up to us to define sane and user friendly deprecation of kfuncs.

> "something very unstable" sounds like it probably shouldn't even be merged in the
> first place, but generally speaking a spectrum from pretty stable to very unstable

See bpf_kfunc_call_test_mem_len_fail2.
It's very much 'very unstable'. It's a test function.
Currently it's in net/bpf/test_run.c. It's there only because at that time we
didn't have an ability to add kfuncs in modules. Soon we will move all test kfuncs
from the main kernel to bpf_testmod.ko

> is imho repeating the same story as BPF helpers vs kfuncs. Saying a kfunc is 'pretty
> stable' is kind of hinting to users that it's close to UAPI, but yet it's unstable.

correct.

> It'll confuse even more. I'd rather have a path forward where those kfuncs get promoted

why confuse more? There are EXPORT_SYMBOL like kmalloc that are quite stable,
yet they can change.
EXPORT_SYMBOL_GPL is exact analogy to kfunc.

> to actual BPF helpers by then where we go and say, that kfunc has proven itself in production
> and from an API PoV that it is ready to be a proper BPF helper, and until this point

"Proper BPF helper" model is broken.
static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;

is a hack that works only when compiler optimizes the code.
See gcc's attr(kernel_helper) workaround.
This 'proper helper' hack is the reason we cannot compile bpf programs with -O0.
And because it's uapi we cannot even fix this.
With kfuncs we will be able to compile with -O0 and debug bpf programs with better tools.
These tools don't exist yet, but we have a way forward whereas with helpers
we are stuck with -O2.

> it's unstable, expect things to change, period. If a kfunc actually changed for the
> kernels that users develop against, they need to go and figure out anyway as part of
> their development process (/ maintenance cost).

The stable kfuncs will still use the same kfuncs mechanics: libbpf searches BTF
and supplies kernel with btf_id of that kfunc before loading the bpf prog.
We won't be hacking stable kfuncs into '= (void *) 1;'

> > Agree that any hard policy like 'only kfuncs from now on' gotta have its limits.
> > Maybe there will be a strong reason to add a new helper one day,
> > so we can keep the door open a tiny bit for an exception,
> 
> +1
> 
> > but for dynptr...
> > There are kfuncs with dynptr already (bpf_verify_pkcs7_signature)
> > So precedent is already made.
> 
> bpf_verify_pkcs7_signature as kfunc also makes sense given wider-spread adoption (and
> ideally as part of an OSS project) is yet to be seen.
> 
> > > Also a reasonable point. My point above was really just a response to
> > > your claim in [0] that dynptrs are flawed. It wasn't related to kfuncs
> > > vs. helpers.
> > > 
> > > [0]: https://lore.kernel.org/all/20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local/
> > 
> > The flawed part of dynptr I was explaining here:
> > https://lore.kernel.org/all/20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com/
> > 
> > It's not that the whole concept of dynptr is flawed,
> > but using it as an abstraction on top of skb/xdp.
> > I don't believe that the extreme performance demands of xdp users are
> > compatible with 'lets verify in runtime' philosophy of dynptr.
> > I could be wrong. That's why I'm fine adding dynptr_on_top_of_xdp as kfuncs
> > and seeing it playing out, but certainly not as a stable helper.
> > iirc Martin and Kuba had concerns about bits of dynptr(skb | xdp) too.
> 
> (My assumption was that you're adding it because you were planning to use
> it internally?)

The bar is not that some project wants to use this new feature, but rather that
the feature looks useful and may potentially be used. We are as maintainers
making this judgement call ever single day.
When we make mistake we should be able to fix it. With uapi we cannot fix our mistakes.

> > With kfuncs we can iron out the issues while trying to use it whereas
> > with helpers we will be stuck for long time in endless mailing list arguments.
> > It's a win-win for everyone to switch everything to kfuncs.
> 
> Thanks,
> Daniel
