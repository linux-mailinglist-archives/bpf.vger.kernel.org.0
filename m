Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8781665DDDC
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 21:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjADUuN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 15:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjADUuM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 15:50:12 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB5813EB1
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 12:50:10 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id qb7so9471533qvb.5
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 12:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6QqkUq4GQihek04SBCcwO9lFAoRn3CAw0zYWzhFXOE=;
        b=kdtw03zQWIZbbIt5lrn5tAY5bzlbCGqH1tTlrrdmBQ51gUCd3BxdbrCMsiCAMKVQfB
         jx84UIJGV6GbfRpQtIqS5evr2ecHIE8AYLMButnrzQnYO26Yu+6ASB6nfVTPzpU9jLsq
         e8kXsLkuxE0Xt8IqlLU0bOE+GAAghVYJPxo5apCjVUCx5Mc86uJYeSpMPjQNYJBkxsqE
         onA0i0ZQMrvlHR6niUt8m9DuGuT9KtWwvnQiPS9mGg8wG94YTit5FdP5/EhDQol2C9u2
         CjuYJwTC52MgC5F0h/0ttJwvHBdEIQ85z2u06uhkCQLY+hOKU6MuPRSnfA/SJ7gytl6A
         cWhg==
X-Gm-Message-State: AFqh2kqpsVc8oYwW8YMJpaLM1eltrgMoAcdSvjRs1ooABNJWhJ37OXU7
        kOijpjjzo8MEHBjImB6/K1E=
X-Google-Smtp-Source: AMrXdXv88cKkbMwutmlMpSjchpoPH8sU5hQEV1CoapM4q3/OdN7AD20RCAW8GgW2weqUux3waJ1Z6Q==
X-Received: by 2002:a05:6214:37c6:b0:4c7:6454:5b1b with SMTP id nj6-20020a05621437c600b004c764545b1bmr68914684qvb.6.1672865408987;
        Wed, 04 Jan 2023 12:50:08 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:7c6c])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a0bd500b006fa4ac86bfbsm24395457qki.55.2023.01.04.12.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 12:50:08 -0800 (PST)
Date:   Wed, 4 Jan 2023 14:50:08 -0600
From:   David Vernet <void@manifault.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Message-ID: <Y7XmgFrxqoWJA1sV@maniforge.lan>
References: <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
 <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan>
 <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
 <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net>
 <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
 <43406cdf-19c1-b80e-0f10-39a1afbf4b8b@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43406cdf-19c1-b80e-0f10-39a1afbf4b8b@iogearbox.net>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 04, 2023 at 03:25:00PM +0100, Daniel Borkmann wrote:
> On 1/4/23 12:51 AM, Alexei Starovoitov wrote:
> > On Tue, Jan 03, 2023 at 12:43:58PM +0100, Daniel Borkmann wrote:
> > > On 12/31/22 1:42 AM, Alexei Starovoitov wrote:
> > > > On Fri, Dec 30, 2022 at 03:00:21PM -0600, David Vernet wrote:
> > > > > > > 
> > > > > > > Taking bpf_get_current_task() as an example, I think it's better to have
> > > > > > > the debate be "should we keep supporting this / are users still using
> > > > > > > it?" rather than, "it's UAPI, there's nothing to even discuss". The
> > > > > > > point being that even if bpf_get_current_task() is still used, there may
> > > > > > > (and inevitably will) be other UAPI helpers that are useless and that we
> > > > > > > just can't remove.
> > > > 
> > > > Sorry, missed this question in the previous reply.
> > > > The answer is "it's UAPI, there's nothing to even discuss".
> > > > It doesn't matter whether bpf_get_current_task() is used heavily or not used at all.
> > > > The chance of breaking user space is what paralyzes the changes.
> > > > Any change to uapi header file is looked at with a magnifying glass.
> > > > There is no deprecation story for uapi.
> > > > The definition and semantics of bpf helpers are frozen _forever_.
> > > > And our uapi/bpf.h is not in a good company:
> > > > ls -Sla include/uapi/linux/|head
> > > > -rw-r--r-- 1 ast users 331159 Nov  3 08:32 nl80211.h
> > > > -rw-r--r-- 1 ast users 265312 Dec 25 13:51 bpf.h
> > > > -rw-r--r-- 1 ast users 118621 Dec 25 13:51 v4l2-controls.h
> > > > -rw-r--r-- 1 ast users  99533 Dec 25 13:51 videodev2.h
> > > > -rw-r--r-- 1 ast users  86460 Nov 29 11:15 ethtool.h
> > > > 
> > > > "Freeze bpf helpers now" is a minimum we should do right now.
> > > > We need to take aggressive steps to freeze the growth of the whole uapi/bpf.h
> > > 
> > > Imho, freezing BPF helpers now is way too aggressive step. One aspect which was
> > > not discussed here is that unstable kfuncs will be a pain for user experience
> > > compared to BPF helpers. Probably not for FB or G who maintain they own limited
> > > set of kernels, but for all others. If there is valid reason that kfuncs will have
> > > to change one way or another, then BPF applications using them will have to carry
> > > the maintenance burden on their side to be able to support a variety of kernel
> > > versions with working around the kfunc quirks. So you're essentially outsourcing
> > > the problem from kernel to users, which will suck from a user experience (and add
> > > to development cost on their side).
> > 
> > It's actually the opposite.
> > A small company that wants to use BPF needs to have a workaround/plan B for
> > different kernels and different distros.
> > That's why cilium and others have to detect availability of helpers and bpf features.
> > One bpf prog for newer kernel and potentially completely different solution
> > for older kernels.
> > That's the biggest obstacle in bpf adoption: the required features are in
> > the latest kernels, but companies have to support older kernels too.
> > Now look at the problem from different angle:
> > Detecting kfuncs is no different than detecting helpers.
> > The bpf users has to have a workaround when helper/kfunc is not available.
> > In that sense stability of the helpers vs instability of kfuncs is irrelevant.
> > Both might not exist in a particular kernel.
> > So if cilium starts to use kfunc it won't be extra development cost and
> > bpf program writer experience using kfuncs vs using helpers is the same as well.
> 
> But that was not the point I was making. What you describe above is the baseline
> cost which is there regardless of BPF helper vs kfunc.. detecting availability
> and having a workaround for older kernel if needed. The added cost is if kfunc
> changes over time for whichever valid reason, then you are essentially pushing

But if there is a "valid reason" to change something, then it's better
to have the _option_ to change it, no? IMHO that's the key point here.
With kfuncs, "reasons" are allowed to be part of the discussion. With
UAPI, there is nothing to discuss.

And that's the fundamental problem with having things in UAPI. Forever
is a very long time. Do we really not want to have the option of
changing or removing something after (e.g.) 20 years? 40 years? 60
years? I agree with you that it's unambiguous that using kfuncs instead
of helpers does shift some maintenance cost from the kernel to users,
but IMO the point is that with kfuncs we at least have the ability to
control that cost. Taking an extreme example, we could decide to support
a kfunc for 30 years, and then deprecate it for 10 years, and then and
then finally remove it. With UAPI our childrens' childrens' children
will have to support it. I don't think guaranteed stability is worth
that cost. Not for symbols exported by the kernel, used by other kernel
programs, which is fundamentally what BPF programs are.

Another way to look at it would be: do we expect tooling to support all
kernel versions and features indefinitely? When we're on Linux 50.15, do
we expect that there will be tooling that requires us to support
bpf_get_current_task() instead of bpf_get_current_task_btf()? And even
if there is a tool that needs it, is it worth the cost of keeping it
around? With kfuncs the question would matter, even if it's "yes it's
worth it". With UAPI, the question is meaningless.

I realize that I'm being a bit hyperbolic here, and it is not my
intention to misrepresent any points made in favor of not freezing UAPI.
I just think it's necessary to be hyperbolic when it comes to UAPI to
really underscore the implications of using it.  There are very good
reasons for having UAPI in general, but IMHO, those reasons don't apply
to kernel programs, which is really what we're talking about here.

> the maintenance cost _from kernel to users_ when they need to keep track of that
> and implement workarounds specifically to make the kfunc work in their program
> for a set of kernels they plan to support, which they otherwise would /not/ have
> if it was a BPF helper. It raises the barrier from user side. Similarly, if users
> started out with using kfunc from a base kernel, and in future it might get
> removed given its not stable, then a workaround (if possible) needs to be
> implemented for newer kernels - probably rare occasion but not impossible or
> something that can be ruled out entirely. So the stability of the helpers vs
> instability of kfuncs is relevant in that case, not for the case you describe
> above, and that is extra development cost on user side. Generally, what I'm saying
> is, there needs to be a path forward where we are still open for both instead of
> completely freezing the former.

Curious what you envision as the policy long term (i.e. after the path
forward)?

The reason I ask is that on the one hand we're claiming that kfuncs work
for some things, while on the other we seem to be claiming that UAPI is
_necessary_ for users to have guaranteed stability and adopt the
platform (and I will preemptively apologize if I'm unintentionally
misrepresenting your view by saying that).

If we operate under the assumption that helpers are necessary for
certain things due to its stability guarantees, whereas kfuncs are
appropriate in some cases, I think that begs the question: what criteria
are we using to decide when stability is really necessary? We could say
"for core functionality", but how do we know that there aren't other
users out there who are using "non-core-functionality" kfuncs instead of
helpers? Why do we give stability to some users but not others? The fact
that we don't have a crystal ball seems to be the central argument
around why we need UAPI, but I think it's a fallacy to have that view at
the same time as also supporting the existence of kfuncs.

[...]

> > > Discoverability plus being able to know semantics from a user PoV to figure out when
> > > workarounds for older/newer kernels are required to be able to support both kernels.
> > 
> > Sounds like your concern is that there could be a kfunc that changed it semantics,
> > but kept exact same name and arguments? Yeah. That would be bad, but we should prevent
> > such patches from landing. It's up to us to define sane and user friendly deprecation of kfuncs.
> 
> Yes, that is a concern. New kfunc and deprecation with eventual removal of the old
> one might be better in such case, agree.

Agreed. With kfuncs, say that the scenario described comes to pass. We
could have a hypothetical deprecation policy like the following:

1. Add the new kfunc with the changed semantics, arguments, etc, under a
different name.
2. Deprecate the old kfunc for X years / releases, where X is whatever
conservative deprecation value we deem appropriate (and one which we
could always extend if need be).
3. Once we feel we're ready to remove the old kfunc, we remove it,
rename the new (now old) kfunc from (1) to that name, and then keep the
temporary name from the new-old kfunc in (1) as a wrapper / alias around
it. That temporary alias can itself then be deprecated and removed after
X years.

All of this is carefully orchestrated, and we have the flexibility to be
as conservative as we'd like in support of users. Maybe we decide that
we can never stop supporting the original kfunc because it's too
ubiquitous. It will surely depend on the policy we end up crafting for
kfuncs, and will probably sometimes require a case-by-case
determination, but at least we'll have the flexibility to choose.

> 
> [...]
> > > is imho repeating the same story as BPF helpers vs kfuncs. Saying a kfunc is 'pretty
> > > stable' is kind of hinting to users that it's close to UAPI, but yet it's unstable.
> > 
> > correct.
> > 
> > > It'll confuse even more. I'd rather have a path forward where those kfuncs get promoted
> > 
> > why confuse more? There are EXPORT_SYMBOL like kmalloc that are quite stable,
> > yet they can change.
> > EXPORT_SYMBOL_GPL is exact analogy to kfunc.
> 
> They are quite stable because they are used in lots of places in-tree and changing
> would cause a ton of needless churn and merge conflicts for everyone, etc. You might
> not always have this kind of visibility on usage of kfuncs. The data you have is
> from your internal code base and what's in some of the larger OSS projects, but
> certainly a more limited/biased view. So as with 'soft' freeze this is just as well open
> to interpretation. "confuse more" because you declare it quite stable, yet not stable.
> Why is there fear to make them proper uapi then with the given known guarantees? From
> user side this guarantee is a good thing, not a bad thing. Mistakes were/are made all
> the time and learned from. Imagine syscall API is not stable anymore. Would you invest
> the cost to develop an application against it? Imho, it's one of BPF's strengths and
> we should keep the door open, not close it.

But we're talking about _kernel_ programs here, not user programs. And
from that perspective, one could argue that having kfuncs actually
promotes more upstreaming of BPF programs for the exact reasons you're
spelling out here, just as EXPORT_SYMBOL_GPL promotes the upstreaming of
modules. Of course, it won't be the exact same as EXPORT_SYMBOL_GPL
because we'll still come up with a well documented, reliable deprecation
story, but the benefits of upstreaming the BPF program still apply.

In general, I think BPF programs and the syscall layer is really an
apples and oranges comparison. The kernel has internally never had a
stable interface as Greg describes in [0]. I don't see why we'd frame
BPF programs differently than any other kernel program in that regard.

[0]: https://www.kernel.org/doc/Documentation/process/stable-api-nonsense.rst

> > > to actual BPF helpers by then where we go and say, that kfunc has proven itself in production
> > > and from an API PoV that it is ready to be a proper BPF helper, and until this point
> > 
> > "Proper BPF helper" model is broken.
> > static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
> > 
> > is a hack that works only when compiler optimizes the code.
> > See gcc's attr(kernel_helper) workaround.
> > This 'proper helper' hack is the reason we cannot compile bpf programs with -O0.
> > And because it's uapi we cannot even fix this
> > With kfuncs we will be able to compile with -O0 and debug bpf programs with better tools.
> > These tools don't exist yet, but we have a way forward whereas with helpers
> > we are stuck with -O2.
> 
> Better debugging tools are needed either way, independent of -O0 or -O2. I don't
> think -O0 is a requirement or barrier for that. It may open up possibilities for

I personally disagree that not being able to support -O0 is sane for a
debugging tool, but IMHO that's not the main point. Rather, it's that
what we have now is kind of a mess (I think we're all in agreement on
that?), and we can never fix it because of UAPI. IMO, that is a sign
that things need to change.

> new tools, but production is still running with -O2. Proper BPF helper model is
> broken, but everyone relies on it, and will be for a very very long time to come,
> whether we like it or not. There is a larger ecosystem around BPF devs outside of
> kernel, and developers will use the existing means today. There are recommendations /
> guidelines that we can provide but we also don't have control over what developers
> are doing. Yet we should make their life easier, not harder. Better debugging
> possibilities should cater to everyone.
> 
> Thanks,
> Daniel
