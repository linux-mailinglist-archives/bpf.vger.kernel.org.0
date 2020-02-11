Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18519159A49
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 21:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgBKUKo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 15:10:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46353 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgBKUKo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 15:10:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so4690998pll.13;
        Tue, 11 Feb 2020 12:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1oEvbdFtLufiZz4t/nbIM1lANTm4jXV+SpoFUW68lYI=;
        b=SBPWwTaE80nhJiDXQ29A5acyY2ngiIVTaLi9MbuLKsZekU3hnHjRJ4Hej+HqdQOin4
         fURStl1i0c9a18eE2Mhv+qeGU5aNvo8Hdc87Z5K3ONwFEusQ1POJ9FPB5V+y4wDEkQex
         vBpXGqvcRc+ybJs3wMaq0ayvUcmSCjcLPZKp+wfh8YBNe2mbsx0Hg2XpCRwliBA0azmX
         Eh5KrV12pUN+tQI1dK37BoS2rhp9+R020CishRLe8x2nthh7WXiDMTjkCatkcvxezC+9
         hjGCTC5/BgF0NdYj8WLbi3gk3DfgvXEnH74EpkOaMhw8aFl4s7/K1WxUUaEpzkqvmKr8
         Eqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1oEvbdFtLufiZz4t/nbIM1lANTm4jXV+SpoFUW68lYI=;
        b=j3AXJRLzg7B+OYuKPSqXG/iGYicTi5rqpJ66h5G+7NdsybZw4+sPF3nkWE6HjNi/IL
         bTmcJlurIUd4gU+ywxVPG4BO4H976kYjzFoDqqgbaPPkgNC7hX30vAEdlB02bo1cqUbF
         IHYp3KWANq2PM52y64dy44OsBZu0nNjAr20U/xNo430bm9/jvmGY74yTPh2SJTn2xFYa
         AP6RAT0a/sreOsQOUnAsYLvC2NhOAfodZ2B7pIo3nsKsoi3V4M+spv/11W8optpFCkKU
         Ukt7RAl6FQ1KmiDLdXUIq5I66oqKMB4Ofs2ZVCs2ihla/Ch80i07OWS1+spbDh71Eqhw
         R/Rw==
X-Gm-Message-State: APjAAAWt4oszM0ef4/orUzjVTglUSg1XOF1NuH0j0D4yj5GyVJYPcSJe
        KU8On9+rEy7m4G8HCryK1RQ=
X-Google-Smtp-Source: APXvYqxPW4yttOEQAI9jATnCc+pSiM5iFBUOnm92337gW+mY7muunUfEN8SGmNFBqr5HLxl7J5PzxQ==
X-Received: by 2002:a17:902:8d91:: with SMTP id v17mr18874782plo.53.1581451843582;
        Tue, 11 Feb 2020 12:10:43 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::1:aeb4])
        by smtp.gmail.com with ESMTPSA id v7sm5204431pfn.61.2020.02.11.12.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 12:10:42 -0800 (PST)
Date:   Tue, 11 Feb 2020 12:10:40 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
Message-ID: <20200211201039.om6xqoscfle7bguz@ast-mbp>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-5-kpsingh@chromium.org>
 <20200211031208.e6osrcathampoog7@ast-mbp>
 <20200211124334.GA96694@google.com>
 <20200211175825.szxaqaepqfbd2wmg@ast-mbp>
 <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
 <20200211190943.sysdbz2zuz5666nq@ast-mbp>
 <CAG48ez2gvo1dA4P1L=ASz7TRfbH-cgLZLmOPmr0NweayL-efLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2gvo1dA4P1L=ASz7TRfbH-cgLZLmOPmr0NweayL-efLw@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 11, 2020 at 08:36:18PM +0100, Jann Horn wrote:
> On Tue, Feb 11, 2020 at 8:09 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Tue, Feb 11, 2020 at 07:44:05PM +0100, Jann Horn wrote:
> > > On Tue, Feb 11, 2020 at 6:58 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > > On Tue, Feb 11, 2020 at 01:43:34PM +0100, KP Singh wrote:
> > > [...]
> > > > > * When using the semantic provided by fexit, the BPF LSM program will
> > > > >   always be executed and will be able to override / clobber the
> > > > >   decision of LSMs which appear before it in the ordered list. This
> > > > >   semantic is very different from what we currently have (i.e. the BPF
> > > > >   LSM hook is only called if all the other LSMs allow the action) and
> > > > >   seems to be bypassing the LSM framework.
> > > >
> > > > It that's a concern it's trivial to add 'if (RC == 0)' check to fexit
> > > > trampoline generator specific to lsm progs.
> > > [...]
> > > > Using fexit mechanism and bpf_sk_storage generalization is
> > > > all that is needed. None of it should touch security/*.
> > >
> > > If I understand your suggestion correctly, that seems like a terrible
> > > idea to me from the perspective of inspectability and debuggability.
> > > If at runtime, a function can branch off elsewhere to modify its
> > > decision, I want to see that in the source code. If someone e.g.
> > > changes the parameters or the locking rules around a security hook,
> > > how are they supposed to understand the implications if that happens
> > > through some magic fexit trampoline that is injected at runtime?
> >
> > I'm not following the concern. There is error injection facility that is
> > heavily used with and without bpf. In this case there is really no difference
> > whether trampoline is used with direct call or indirect callback via function
> > pointer. Both will jump to bpf prog. The _source code_ of bpf program will
> > _always_ be available for humans to examine via "bpftool prog dump" since BTF
> > is required. So from inspectability and debuggability point of view lsm+bpf
> > stuff is way more visible than any builtin LSM. At any time people will be able
> > to see what exactly is running on the system. Assuming folks can read C code.
> 
> You said that you want to use fexit without touching security/, which
> AFAIU means that the branch from security_*() to the BPF LSM will be
> invisible in the *kernel's* source code unless the reader already
> knows about the BPF LSM. But maybe I'm just misunderstanding your
> idea.
> 
> If a random developer is trying to change the locking rules around
> security_blah(), and wants to e.g. figure out whether it's okay to
> call that thing with a spinlock held, or whether one of the arguments
> is actually used, or stuff like that, the obvious way to verify that
> is to follow all the direct and indirect calls made from
> security_blah(). It's tedious, but it works, unless something is
> hooked up to it in a way that is visible in no way in the source code.
> 
> I agree that the way in which the call happens behind the scenes
> doesn't matter all that much - I don't really care all that much
> whether it's an indirect call, a runtime-patched direct call in inline
> assembly, or an fexit hook. What I do care about is that someone
> reading through any affected function can immediately see that the
> branch exists - in other words, ideally, I'd like it to be something
> happening in the method body, but if you think that's unacceptable, I
> think there should at least be a function attribute that makes it very
> clear what's going on.

Got it. Then let's whitelist them ?
All error injection points are marked with ALLOW_ERROR_INJECTION().
We can do something similar here, but let's do it via BTF and avoid
abusing yet another elf section for this mark.
I think BTF_TYPE_EMIT() should work. Just need to pick explicit enough
name and extensive comment about what is going on.
Locking rules and cleanup around security_blah() shouldn't change though.
Like security_task_alloc() should be paired with security_task_free().
And so on. With bpf_sk_storage like logic the alloc/free of scratch
space will be similar to the way socket and bpf progs deal with it.

Some of the lsm hooks are in critical path. Like security_socket_sendmsg().
retpoline hurts. If we go with indirect calls right now it will be harder to
optimize later. It took us long time to come up with bpf trampoline and build
bpf dispatcher on top of it to remove single indirect call from XDP runtime.
For bpf+lsm would be good to avoid it from the start.
