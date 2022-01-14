Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A2348F0BE
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 21:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244136AbiANUDZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 15:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiANUDZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 15:03:25 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1844CC061574
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 12:03:25 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id a12so8815517iod.9
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 12:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gQQuB6Jil2VBAln6SIP1BYK5KPyXInHya5fJcujRZ48=;
        b=FQQi5gtmKu/lM3M7Om8MtG8WrAqsSP3OZ6i6NDpRqm6VWp79WA5Nzpi1ZJIOE9586i
         uU6wJnOO9l8poC6S7yLIhh1gSWCSGiIn2LvyAGVl4NH/5Q4J1KdHSduF6jj5rAbjMvim
         RJvQpq/xZicqogwaauewlepM+j6ZwVyDQdyV7+ZgKKxQ2VzFAaWwO7AeSUh4vLGu7zTu
         iMPW9d0aSZugXPI4d05w7p839bhu68D2opHuLD8+OEE3mtMnSrcy9FEkeixJ4q0+w4mg
         +kjadtHKXtaz/6mJhzflO2r2ql5o+tRXFpmERQFA7AZZ2tuoQ5BJTZ9kKUeBvE6qp5HH
         raTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gQQuB6Jil2VBAln6SIP1BYK5KPyXInHya5fJcujRZ48=;
        b=w+fl4iJZQYxoXRhJnBXdooZKiNZOzplaAhFGu8aldmByJMd+VPkK5CEXBi+2dXphB1
         r52FUYxSOnB553Y6JJ6DEGAGF769KzP04o1+Kg8K3h+pfaAJAgWrt32kRgE4D+ysv9kT
         3TRG3LfX+QeqwZdetrkStqmuiuA5WK6+b+n2zgQiCx+imn2kQD75mbIktwGtveJgMHN/
         y9EfMLuUBxY30a8VLoaGntL0/nzy5ueJ7w94tX0nufdcHcSMc/fiH93KtMyNGeagq96Z
         m7NUAvA7k5otNx+hvd9XBq2cTNr5KfLU8oP6WDF1s4T0w7lkSeFK8aAeF/bFHl9K1w+Q
         QkZA==
X-Gm-Message-State: AOAM530eG0WarM6K0VJI1n1hdeClz0G7F4B35mK9PkXpvYmgFgVlIxg7
        VQweU0njmphCgMDvq2gn5gyg3hwPPY1JiqghHajur/g0Gig=
X-Google-Smtp-Source: ABdhPJy38vEj5DuMttGs0YvuQoq92je0I0vEhcVSMeumhPvrUrQ9J8y21ocTZ4cjM8a2rndKUrlGANEyJO+906IKu4Q=
X-Received: by 2002:a5d:87d8:: with SMTP id q24mr5018453ios.154.1642190604456;
 Fri, 14 Jan 2022 12:03:24 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZXqyoaw0mOk2Z8ADxUSs95B=SRgvTua3vRJ00nS5qTFgQ@mail.gmail.com>
 <CAEf4BzY-H7ySLukPn+aUm55DhDxfO07e45J4V1q1bLqpDZ98_Q@mail.gmail.com> <CAMy7=ZV_SVoHPxCvcm0NJttg0pgq0ccfjUj9egszWnC0cjXoLg@mail.gmail.com>
In-Reply-To: <CAMy7=ZV_SVoHPxCvcm0NJttg0pgq0ccfjUj9egszWnC0cjXoLg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 Jan 2022 12:03:13 -0800
Message-ID: <CAEf4BzZ8=dV0wvggAKnD64yXnhcXhdf1ovCT_LBd17RtJJXrdA@mail.gmail.com>
Subject: Re: libbpf API: dynamically load(/unload/attach/detach) bpf programs question
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, michael.tcherniack@aquasec.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 12, 2022 at 2:42 AM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=92=
=D7=B3, 11 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2022 =D7=91-22:59 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> > On Tue, Jan 11, 2022 at 4:33 AM Yaniv Agman <yanivagman@gmail.com> wrot=
e:
> > >
> > > Hello!
> > >
> > > I noticed that the bpf_program__load() API was deprecated since libbp=
f
> > > 0.6 saying that bpf_object__load() should be used instead.
> > > This, however, doesn't seem to fit our use case of loading multiple
> > > bpf programs (that also share the same maps) from one bpf object (elf
> > > file), then unloading and loading them dynamically according to some
> > > given needs.
> >
> > What's the use case for loading, then unloading, and then loading again=
?
>
> In Tracee we have different bpf programs (tracepoints, kprobes, tc)
> used to send events and capture data according to what was chosen by
> the user.
> Currently, the user provides this configuration at start, and we use
> autoload to only load the required bpf programs.
> We want to be able to change this configuration at runtime, without
> having to restart Tracee.
> For example, if the user wants to enable/disable network capture, we
> want to load/unload the relevant bpf programs.
> It is possible that only destroying the link (and attaching back
> later) will be enough, but I think that there are other
> considerations, such as kernel memory consumption, that makes
> unloading the program preferable.

I think the amount of memory held for verifier BPF program is pretty
miniscule and shouldn't be a big deal. It's much more expensive to
validate the program (especially if you do it repeatedly).

>
> >
> > > I'm not sure it is possible to load one specific program from the bpf
> > > object using bpf_object__load() API - is it?
> >
> > It is possible. You can disable loading BPF program by calling
> > bpf_program__set_autoload(prog, false) after bpf_object__open() and
> > before bpf_object__load().
>
> Yes, I'm aware of bpf_program__set_autoload() and we already use it as
> I described above.
> I think, however, that there might be problems loading the same object
> file more than once:
> 1. obj->loaded is set to true, and an error will be returned

Right, because re-loading bpf_object isn't supported, even if it might
have worked in some limited situations.

> 2. The maps defined by the object were already created and initialized
> And possibly other issues that we might encounter.

You could use bpf_map__reuse_fd() to work around that problem, but it
certainly adds complexity. I'd prefer keep verified programs ready
(but not attached), if possible


>
> >
> > I've thought about adding a convention to SEC() to disable
> > auto-loading declaratively (e.g., SEC('!kprobe/whatever') won't
> > auto-load unless autoload is set to true through
> > bpf_program__set_autoload()), but we haven't implemented that yet.
> >
>
> That can be a nice addition, but I don't think that it will help in our c=
ase
>
> > >
> > > Another question with the same context -
> > > If I understand correctly, the purpose of detach is to "prevent
> > > execution of a previously attached program from any future events"
> > > (https://facebookmicrosites.github.io/bpf/blog/2018/08/31/object-life=
time.html),
> > > which seems like something that I would want to do if I just wanted t=
o
> > > temporarily stop an event from triggering the program. But then I ask
> > > myself - what is the meaning of detaching a link (and not
> > > bpf_link__destroy() it) if there is no way to attach it back (without
> >
> > you mean bpf_link__detach()? this is a special "admin-only" operation
> > of force-detaching the link, even if there are still link FDs open.
> > Normally you shouldn't do it. Use bpf_link__destroy() to detach (and
> > make sure no one dup()'ed extra FDs)
>
> Ok, cool. I didn't know that this is a special "admin-only" operation,
> as it is defined in libbpf.h with LIBBPF_API and I didn't see any
> documentation saying that.
>
> >
> > > re-creating the link object)? I don't see any function named
> > > bpf_link__attach() that would do such a thing, or any other function
> > > in libbpf API that can do something similar, am I right?
> >
> > Right, links are created with bpf_program__attach*() APIs.
>
> Got it. I thought that it should be possible to use the same bpf_link
> object and temporarily detach it when required (attaching it back when
> required).
> So now I understand that the only way to achieve such a behavior is to
> destroy the link and recreate it, right?

Right. You could "restore" struct bpf_link from pinned link instance
in BPF FS through bpf_link__open(), but overall bpf_link is meant to
be created by attachment and destroyed to detach the program.

>
> >
> > > Also, It seems that using bpf_link__detach() does not fit all link
> > > types. For example, when attaching a (non legacy) kprobe, detaching i=
t
> > > should probably happen using PERF_EVENT_IOC_DISABLE and not through
> > > sys_bpf(BPF_LINK_DETACH), shouldn't it?
> > >
> > > And one last question:
> > > When using bpf_program__unload() on a program that is already
> > > attached, should we first call bpf_link__detach() or does the kernel
> > > already take care of this?
> >
> > Keep in mind that bpf_program__unload() is also deprecated. The idea
> > is that if you are working with high-level libbpf APIs that are
> > centered around struct bpf_object, bpf_program, and bpf_map, the
> > entire collection of programs and maps is functioning as a single
> > bundle. If that abstraction doesn't work, you'll have to drop to
> > low-level APIs (defined in bpf/bpf.h) and manipulate everything
> > through FDs.
>
> Yes, it seems that this abstraction is not enough for our use case.
> As I described above, Tracee's bpf programs and maps do work as a
> bundle, but sometimes it might be required to unload/load bpf programs
> according to user request.
> The problem with using the lower level APIs (such as bpf_prog_load())
> is that they expect to get bpf instructions and not a bpf_program
> struct (which is a good abstraction),
> so working with them will require to implement by ourselves some of
> the logic of libbpf, and we want to avoid that
>
> >
> > As for detaching (destroying in libbpf lingo, though) the link, yes,
> > you need to destroy links before unloading the program. Otherwise
> > links themselves will keep programs loaded in the kernel. Some legacy
> > links (legacy kprobe/uprobe) won't auto-detach even on process exit
> > because the kernel doesn't support this.
>
> Got it, thanks
>
> >
> > >
> > > Thanks,
> > > Yaniv
