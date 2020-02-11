Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA7C159A8B
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 21:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgBKUeR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 15:34:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38941 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgBKUeQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 15:34:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so11514289oty.6
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2020 12:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q11zsssSHeKjTpfbV0UQcFcGMIVXHOWVWu3BFYxakp4=;
        b=qeozm3+R7EnJiUqxAO5WKU6Hyo8tOvNoKIv3sqG0gwJnruWChpe1RHY1CoExS/DHwK
         he5Szs4itn3GjZWTFLBu9ib1jeaKQF7I8F/J6ZCd+raCeXX8Ml8qL2LsKQzBrsvmpZWi
         LQGGl/dWBrexM2f/haFE13HCd+3IpMAZkvvGpB5n55Z5/Ag2N3RjnXl8xgLc2+1aFkTR
         UPSbLDiLCbU/Cb4J4f2WFKJTYxS11Fr3qOVTalvoCvAxRpL5kc/w5gTC8sfJ/NDgEgT6
         jeFEpLJm7a3am8dmDSuwym2sTtDNasMRQr77XiJDdvOXMmN3Pf70q/USLL7OUWvG29yX
         4aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q11zsssSHeKjTpfbV0UQcFcGMIVXHOWVWu3BFYxakp4=;
        b=UB9BGxBdsjKfQUUgQfTeTsWuuJgM1L44DJpvL3v2dW2ginynxGsfifpMYAOy52kh8K
         e1+w6JGaKtv0FuKJ+n+x3DKN1uEy/tgPkJRGmm42TcWVgOK22FiM7fEHtBZ3AR3wJVIf
         Ur6/t62r50TnWQlOLhkti8hns4dvRZ5maztg/MRe8b+ke2fUXrnkmpCySceyvkKd3Vgh
         usOIvaDNJrxlprv4Sw9dBpht27zAi8Hmtq0b/AmwDr/fOjoL3jj/d22gvOwTkgMxTT+d
         4wwiQY52lbSvnPNcGNA7l2iRQY9Erpj82Q/WpUb54YMvHRcDKJqS4P8+3cCECopi6NNF
         WmAA==
X-Gm-Message-State: APjAAAUDdk7zNsUct8kcW+pF6W3A2B2zOiglbpK8bgjZu5SmSvCisqic
        0cnnl5dsqH89nhPFoDZPD51q3KYGz9VLIZXuv1uBPw==
X-Google-Smtp-Source: APXvYqwN+vAsdRxgGOaSrJORQpfpoOK0DTUx7e2DVI860NZpm9RoWnlwAaQwqmRW/lEAu1tBxxXl1zt3MnY8gyqlm3Y=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr6936015oth.180.1581453255514;
 Tue, 11 Feb 2020 12:34:15 -0800 (PST)
MIME-Version: 1.0
References: <20200123152440.28956-1-kpsingh@chromium.org> <20200123152440.28956-5-kpsingh@chromium.org>
 <20200211031208.e6osrcathampoog7@ast-mbp> <20200211124334.GA96694@google.com>
 <20200211175825.szxaqaepqfbd2wmg@ast-mbp> <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
 <20200211190943.sysdbz2zuz5666nq@ast-mbp> <CAG48ez2gvo1dA4P1L=ASz7TRfbH-cgLZLmOPmr0NweayL-efLw@mail.gmail.com>
 <20200211201039.om6xqoscfle7bguz@ast-mbp>
In-Reply-To: <20200211201039.om6xqoscfle7bguz@ast-mbp>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 11 Feb 2020 21:33:49 +0100
Message-ID: <CAG48ez1qGqF9z7APajFyzjZh82YxFV9sHE64f5kdKBeH9J3YPg@mail.gmail.com>
Subject: Re: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

()On Tue, Feb 11, 2020 at 9:10 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Feb 11, 2020 at 08:36:18PM +0100, Jann Horn wrote:
> > On Tue, Feb 11, 2020 at 8:09 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Tue, Feb 11, 2020 at 07:44:05PM +0100, Jann Horn wrote:
> > > > On Tue, Feb 11, 2020 at 6:58 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > On Tue, Feb 11, 2020 at 01:43:34PM +0100, KP Singh wrote:
> > > > [...]
> > > > > > * When using the semantic provided by fexit, the BPF LSM program will
> > > > > >   always be executed and will be able to override / clobber the
> > > > > >   decision of LSMs which appear before it in the ordered list. This
> > > > > >   semantic is very different from what we currently have (i.e. the BPF
> > > > > >   LSM hook is only called if all the other LSMs allow the action) and
> > > > > >   seems to be bypassing the LSM framework.
> > > > >
> > > > > It that's a concern it's trivial to add 'if (RC == 0)' check to fexit
> > > > > trampoline generator specific to lsm progs.
> > > > [...]
> > > > > Using fexit mechanism and bpf_sk_storage generalization is
> > > > > all that is needed. None of it should touch security/*.
> > > >
> > > > If I understand your suggestion correctly, that seems like a terrible
> > > > idea to me from the perspective of inspectability and debuggability.
> > > > If at runtime, a function can branch off elsewhere to modify its
> > > > decision, I want to see that in the source code. If someone e.g.
> > > > changes the parameters or the locking rules around a security hook,
> > > > how are they supposed to understand the implications if that happens
> > > > through some magic fexit trampoline that is injected at runtime?
> > >
> > > I'm not following the concern. There is error injection facility that is
> > > heavily used with and without bpf. In this case there is really no difference
> > > whether trampoline is used with direct call or indirect callback via function
> > > pointer. Both will jump to bpf prog. The _source code_ of bpf program will
> > > _always_ be available for humans to examine via "bpftool prog dump" since BTF
> > > is required. So from inspectability and debuggability point of view lsm+bpf
> > > stuff is way more visible than any builtin LSM. At any time people will be able
> > > to see what exactly is running on the system. Assuming folks can read C code.
> >
> > You said that you want to use fexit without touching security/, which
> > AFAIU means that the branch from security_*() to the BPF LSM will be
> > invisible in the *kernel's* source code unless the reader already
> > knows about the BPF LSM. But maybe I'm just misunderstanding your
> > idea.
> >
> > If a random developer is trying to change the locking rules around
> > security_blah(), and wants to e.g. figure out whether it's okay to
> > call that thing with a spinlock held, or whether one of the arguments
> > is actually used, or stuff like that, the obvious way to verify that
> > is to follow all the direct and indirect calls made from
> > security_blah(). It's tedious, but it works, unless something is
> > hooked up to it in a way that is visible in no way in the source code.
> >
> > I agree that the way in which the call happens behind the scenes
> > doesn't matter all that much - I don't really care all that much
> > whether it's an indirect call, a runtime-patched direct call in inline
> > assembly, or an fexit hook. What I do care about is that someone
> > reading through any affected function can immediately see that the
> > branch exists - in other words, ideally, I'd like it to be something
> > happening in the method body, but if you think that's unacceptable, I
> > think there should at least be a function attribute that makes it very
> > clear what's going on.
>
> Got it. Then let's whitelist them ?
> All error injection points are marked with ALLOW_ERROR_INJECTION().
> We can do something similar here, but let's do it via BTF and avoid
> abusing yet another elf section for this mark.
> I think BTF_TYPE_EMIT() should work. Just need to pick explicit enough
> name and extensive comment about what is going on.

Sounds reasonable to me. :)

> Locking rules and cleanup around security_blah() shouldn't change though.
> Like security_task_alloc() should be paired with security_task_free().
> And so on. With bpf_sk_storage like logic the alloc/free of scratch
> space will be similar to the way socket and bpf progs deal with it.
>
> Some of the lsm hooks are in critical path. Like security_socket_sendmsg().
> retpoline hurts. If we go with indirect calls right now it will be harder to
> optimize later. It took us long time to come up with bpf trampoline and build
> bpf dispatcher on top of it to remove single indirect call from XDP runtime.
> For bpf+lsm would be good to avoid it from the start.

Just out of curiosity: Are fexit hooks really much cheaper than indirect calls?

AFAIK ftrace on x86-64 replaces the return pointer for fexit
instrumentation (see prepare_ftrace_return()). So when the function
returns, there is one return misprediction for branching into
return_to_handler(), and then the processor's internal return stack
will probably be misaligned so that after ftrace_return_to_handler()
is done running, all the following returns will also be mispredicted.

So I would've thought that fexit hooks would have at least roughly the
same impact as indirect calls - indirect calls via retpoline do one
mispredicted branch, fexit hooks do at least two AFAICS. But I guess
indirect calls could still be slower if fexit benefits from having all
the mispredicted pointers stored on the cache-hot stack while the
indirect branch target is too infrequently accessed to be in L1D, or
something like that?
