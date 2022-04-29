Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1D3515162
	for <lists+bpf@lfdr.de>; Fri, 29 Apr 2022 19:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiD2RNc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Apr 2022 13:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379037AbiD2RNb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Apr 2022 13:13:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8866060C0
        for <bpf@vger.kernel.org>; Fri, 29 Apr 2022 10:10:12 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h12so7649751plf.12
        for <bpf@vger.kernel.org>; Fri, 29 Apr 2022 10:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYukit63wa1ZSojvQNZCWwWM8lgsGYY8hht/JeNW2KI=;
        b=iJvJNdRJR6d2+h0lJX+jNfNTX2j7Fot1BMWn+PbkpN/5PJIRce9xq+bWRT7JY7gTyL
         lck3KKiRu6k/7gbq02MEwRANyyT/MJj6tatbwJ4iBkRpI2od+plJtg28Rr6a/4hKuG+Z
         g2RVsF+x9qI4V0aXezpxU2LeR1UXBbRucOg0AsYzm02mAEKQjiSgrbcWHexFxkJVUHWg
         Rg9YqH2XtxY6Ksoo3P7cERl3rNh856Y2cCWCETepANPhQBlGV/bOAk5UlBVI+bem2RXp
         o/Hlt46Dl10kYWDXNCPoolxWxK3B5YOapzZeuGiPgV/jhoyCPdN/rGPgC71yx/j/KdPb
         CTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYukit63wa1ZSojvQNZCWwWM8lgsGYY8hht/JeNW2KI=;
        b=HtFsLe0U5zI+YvGTXrG6Z7TPvIpD5jUWMt9Ki1J06xeCREEy7ZOLcBKFVbEGX+44Zv
         4dfxr/p5cm7XAexfSn73sX9D8+wVJsUBlpcaD5zSb1LwgXVELa38m2AF8yiBTp9Hj40v
         3jWAk0oCwCp634sDeHY8RsPYkBzCWjNhhFDzpZEdaYJFRxSbqp0I8iAY2vFnhmxgFoJ5
         LBbd98DvLeNkoUEd1RduHzdwFe9vDqunz7XwkPfZ+iVIgYw9F/OtY/Rq98TggF4nVUXi
         llAXAl04PrkptUV54z6Wc9meJnZslWrtbSornmr0+dfKF5rohVrfe5KCEHnrfpWJbLni
         SVRA==
X-Gm-Message-State: AOAM531G9oNnSpFOmx3CLxC9xBmgsZ+xUMTbSy1oaFhIkHQ73SkaeGSN
        4knkxHf++lJI0r0spaFERiTziD8YQLoB4GmBBvE=
X-Google-Smtp-Source: ABdhPJwG0wPDTVtrfqHy9bvRmliHjRDVbEm0VYtRo9uCIHsB53zMbZtcd/2NvCWQKGlMUSi18A+TQVU7iiyjknrLW8s=
X-Received: by 2002:a17:902:b189:b0:14d:6f87:7c25 with SMTP id
 s9-20020a170902b18900b0014d6f877c25mr385802plr.31.1651252211972; Fri, 29 Apr
 2022 10:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <586a6288-704a-f7a7-b256-e18a675927df@oracle.com>
 <Yi7qQW+GIz+iOdYZ@syu-laptop> <f6f4a548-8e50-f676-8482-0ca541652cc6@fb.com>
 <8735jjw4rp.fsf@brennan.io> <YjDT498PfzFT+kT4@kernel.org> <878rt9hogh.fsf@brennan.io>
 <CAEf4BzbiFNnsu9pji5ifzj4nVEyAYYdqP=QVZ3XFwzL48prP3A@mail.gmail.com> <87r15iv0yd.fsf@stepbren-lnx.us.oracle.com>
In-Reply-To: <87r15iv0yd.fsf@stepbren-lnx.us.oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 29 Apr 2022 10:10:01 -0700
Message-ID: <CAADnVQ+YuxB8gZGjx+RP=04z4SgYEmPjEjDa_=Q6HmUecxK8QQ@mail.gmail.com>
Subject: Re: Question: missing vmlinux BTF variable declarations
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        bpf <bpf@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 27, 2022 at 11:43 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
> >
> > I think this quirk of using kallsyms strings is a no-go. But we should
> > experiment and see how much bigger BTF becomes when including all the
> > variables. Can you try to prototype pahole's support for this?
>
> Hi Andrii,
>
> Sorry for such a delay here. I tried to prototype this last month but
> encountered some issues I couldn't resolve. But recently I picked it up
> and I've created a prototype [1] which outputs all variables. (It's a
> quite bad prototype, it strips out some useful logic regarding the
> BTF_VAR_DATASEC for percpu variables. But I think it's good enough).
>
> On my 5.4-based kernel I saw an increase in BTF section size from 3.8
> MiB all the way to 6.1 MiB, or more precisely:
>
> BTF section before: 3905938 bytes
> BTF section after:  6391989 bytes (+2486051, +63.6%)
>
> So almost a 2.5 MiB increase. My prototype doesn't output the
> btf_var_secinfo structs for percpu variables anymore, which probably
> breaks some BPF and reduces BTF slightly. But it also is outputting
> a few thousand "dwarf variables" which were correctly filtered before,
> so I think it's a wash and it's a pretty good comparison.
>
> Clearly it can't be added without a configuration option, as 2.5 MiB is
> pretty huge for a kernel memory addition. But I don't think it's so huge
> that nobody would enable it. I know I would :)
>
> [1]: https://github.com/brenns10/dwarves/tree/remove_percpu_restriction_1
>
> > As you
> > said, we can guard this extra information with KConfig and pahole
> > flags, so distros can always opt-out of bigger BTF if that's too
> > prohibitive. As it is right now, without firm understanding how big
> > the final BTF is it's hard to make a good decision about go or no-go
> > for this.
>
> Hopefully this comparison sheds some light on that now!
>
> >
> > As for including source code itself, it going to be prohibitively
> > huge, so it's probably out of the question for now as well.
>
> Yeah, I wouldn't advocate for that.
>
> Now, to share some of the cool possibilities that this enables. I have:
> - prototype pahole [1] used for the kernel build,
> - a prototype drgn with BTF+kallsyms support [2],
> - some small kernel patches which add symbols to vmcoreinfo, so that
>   drgn can find the kallsyms section. I'm happy to share these, I just
>   haven't sent them anywhere yet.
>
> [2]: https://github.com/brenns10/drgn/tree/kallsyms_plus_btf
>
> Combining these three things, I've got a debugger which can open up a
> vmcore _without DWARF debuginfo_ and allow you to print out typed
> variable values. It just relies on BTF + kallsyms.
>
> So the proof of concept is proven, and I'm quite excited about it!

Exciting indeed. This is pretty cool.

I'm afraid we cannot justify 2.5 Mb kernel memory increase
for pure debugging. The existing vmlinux BTF is used
by the kernel itself to validate bpf prog access.
bpf progs cannot access normal global vars.
If/when they are we can reconsider.

As an alternative path I think we could introduce hierarchical
split BTF.
Currently vmlinux BTF and BTF of kernel modules is a tree
of depth 2.
We can keep such representation of BTFs and
introduce a fake kernel module that contains kernel global vars.
drgn can parse vmlinux BTF plus BTFs of all ko-s including fake one
and obtain the same amount of debug info as if global vars
were part of vmlinux BTF.
Consuming 2.5Mb on demand via ko would be acceptable
in some scenarios whereas unconditionally burning
that much memory in vmlinux BTF (even optional via kconfig)
is probably not.

Ideally we structure BTFs as a multi level tree.
Where BTF with global vars and other non essential BTF info
can be added to vmlinux BTF at run-time. BTF of kernel mods
can add on top and mods can have split BTF too.
