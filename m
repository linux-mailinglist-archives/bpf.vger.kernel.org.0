Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28929490230
	for <lists+bpf@lfdr.de>; Mon, 17 Jan 2022 07:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiAQG5Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jan 2022 01:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiAQG5Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jan 2022 01:57:24 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AFAC061574
        for <bpf@vger.kernel.org>; Sun, 16 Jan 2022 22:57:23 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u21so61372051edd.5
        for <bpf@vger.kernel.org>; Sun, 16 Jan 2022 22:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AMuVkbtMKfwly1qcQszqXLxDg3nFtxQOhJQIDjSWv0c=;
        b=qLiFfZBgykeKUg5V+Q9xOvMWxBTbX6B5fx0oUA4fmlEbQCuZJpmiEGaatlzh1Drp1j
         QckBWvDYzalUuX7y1BqHF6bjnItmRCAKPhZLs8JZGRQnoCFfgVN2dzCiqn54oJGO60bK
         l+WMQcIhlahSqIfT8CBhYJlwQSio7U/A4aQ/LMKACoNbNfzhcqYMCoQV6fWEScr8WdAZ
         0is4GCbn5UF5R4sPvnwmfG3JCbsvohDMAp3usaqvoqPsofV0dySv+68aBHGNJtjohW4U
         HERBZDmfhTZ3xECj4vTb2w6va3EBg0moKgM1anS6uoX7HBIiPFF1VzEQYhQLg4PwwOsH
         Wj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AMuVkbtMKfwly1qcQszqXLxDg3nFtxQOhJQIDjSWv0c=;
        b=LMrZHZNQIfQTSX/+4ygxWvV5RiV9MRuEOwFG0e56fbb4jc3SBsedqfrCPz+Uz2q++Z
         yXZObqFXqDcir75/aWtZV5a7sIGlaSgUcC3pU1YCDBphuVUniSKqmyuktLlG4z+jZC4E
         +qxVaZKICudYwZrvkzOrrQy+Mb3f0bik4I6KovVW+fjRl89gmiC3cUQ/If9CH8udpCgB
         sfuUuv2wXDd5UyOgQ/3pnPp9qVaPwtyIr/HsKYIKqJDj2UVwUNhy7tA+6YTwZQkPna3E
         AU6tTNYFKthMvcdyRybxt9L5thu5wxkMjJ+MhHczR0tGUovOw13Vjd8hX9htVtNC/I3p
         xGGA==
X-Gm-Message-State: AOAM533DrHKAyDPLpyWOCBORypMRYjOnrL6WkiPWK+9PvG8lCX9bSgeE
        hy+Q0d68S5PWbzcfL3u6kSwguC1h9eBlKbSYlD8=
X-Google-Smtp-Source: ABdhPJxUIf6IByWQKasmWWdsmFVy1TRQ+DQqXGgddBOIbOBWLYhpNym1De2IruTm+tp/aH9AdOzyHMam+gCtEQitEU4=
X-Received: by 2002:a05:6402:268a:: with SMTP id w10mr19722164edd.10.1642402642066;
 Sun, 16 Jan 2022 22:57:22 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZXqyoaw0mOk2Z8ADxUSs95B=SRgvTua3vRJ00nS5qTFgQ@mail.gmail.com>
 <CAEf4BzY-H7ySLukPn+aUm55DhDxfO07e45J4V1q1bLqpDZ98_Q@mail.gmail.com>
 <CAMy7=ZV_SVoHPxCvcm0NJttg0pgq0ccfjUj9egszWnC0cjXoLg@mail.gmail.com> <CAEf4BzZ8=dV0wvggAKnD64yXnhcXhdf1ovCT_LBd17RtJJXrdA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ8=dV0wvggAKnD64yXnhcXhdf1ovCT_LBd17RtJJXrdA@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Mon, 17 Jan 2022 08:57:11 +0200
Message-ID: <CAMy7=ZW60WmV5R9myXCzrZGZXMrPhO+dwaW8+aABUJO9pMV+yA@mail.gmail.com>
Subject: Re: libbpf API: dynamically load(/unload/attach/detach) bpf programs question
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, michael.tcherniack@aquasec.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=D7=
=B3, 14 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2022 =D7=91-22:03 =D7=9E=D7=90=D7=AA=
 =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
<=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Wed, Jan 12, 2022 at 2:42 AM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=92=
=D7=B3, 11 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2022 =D7=91-22:59 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> > <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > >
> > > On Tue, Jan 11, 2022 at 4:33 AM Yaniv Agman <yanivagman@gmail.com> wr=
ote:
> > > >
> > > > Hello!
> > > >
> > > > I noticed that the bpf_program__load() API was deprecated since lib=
bpf
> > > > 0.6 saying that bpf_object__load() should be used instead.
> > > > This, however, doesn't seem to fit our use case of loading multiple
> > > > bpf programs (that also share the same maps) from one bpf object (e=
lf
> > > > file), then unloading and loading them dynamically according to som=
e
> > > > given needs.
> > >
> > > What's the use case for loading, then unloading, and then loading aga=
in?
> >
> > In Tracee we have different bpf programs (tracepoints, kprobes, tc)
> > used to send events and capture data according to what was chosen by
> > the user.
> > Currently, the user provides this configuration at start, and we use
> > autoload to only load the required bpf programs.
> > We want to be able to change this configuration at runtime, without
> > having to restart Tracee.
> > For example, if the user wants to enable/disable network capture, we
> > want to load/unload the relevant bpf programs.
> > It is possible that only destroying the link (and attaching back
> > later) will be enough, but I think that there are other
> > considerations, such as kernel memory consumption, that makes
> > unloading the program preferable.
>
> I think the amount of memory held for verifier BPF program is pretty
> miniscule and shouldn't be a big deal. It's much more expensive to
> validate the program (especially if you do it repeatedly).

In our case there will potentially be about 100 loaded programs while
only 20-30 are attached.

If that's the case and there is no real problem in keeping many bpf
programs loaded at once,
I'll take your advice and load all the programs at start,
attaching/destroying the links when required.

Thanks!

>
> >
> > >
> > > > I'm not sure it is possible to load one specific program from the b=
pf
> > > > object using bpf_object__load() API - is it?
> > >
> > > It is possible. You can disable loading BPF program by calling
> > > bpf_program__set_autoload(prog, false) after bpf_object__open() and
> > > before bpf_object__load().
> >
> > Yes, I'm aware of bpf_program__set_autoload() and we already use it as
> > I described above.
> > I think, however, that there might be problems loading the same object
> > file more than once:
> > 1. obj->loaded is set to true, and an error will be returned
>
> Right, because re-loading bpf_object isn't supported, even if it might
> have worked in some limited situations.
>
> > 2. The maps defined by the object were already created and initialized
> > And possibly other issues that we might encounter.
>
> You could use bpf_map__reuse_fd() to work around that problem, but it
> certainly adds complexity. I'd prefer keep verified programs ready
> (but not attached), if possible
>
>
> >
> > >
> > > I've thought about adding a convention to SEC() to disable
> > > auto-loading declaratively (e.g., SEC('!kprobe/whatever') won't
> > > auto-load unless autoload is set to true through
> > > bpf_program__set_autoload()), but we haven't implemented that yet.
> > >
> >
> > That can be a nice addition, but I don't think that it will help in our=
 case
> >
> > > >
> > > > Another question with the same context -
> > > > If I understand correctly, the purpose of detach is to "prevent
> > > > execution of a previously attached program from any future events"
> > > > (https://facebookmicrosites.github.io/bpf/blog/2018/08/31/object-li=
fetime.html),
> > > > which seems like something that I would want to do if I just wanted=
 to
> > > > temporarily stop an event from triggering the program. But then I a=
sk
> > > > myself - what is the meaning of detaching a link (and not
> > > > bpf_link__destroy() it) if there is no way to attach it back (witho=
ut
> > >
> > > you mean bpf_link__detach()? this is a special "admin-only" operation
> > > of force-detaching the link, even if there are still link FDs open.
> > > Normally you shouldn't do it. Use bpf_link__destroy() to detach (and
> > > make sure no one dup()'ed extra FDs)
> >
> > Ok, cool. I didn't know that this is a special "admin-only" operation,
> > as it is defined in libbpf.h with LIBBPF_API and I didn't see any
> > documentation saying that.
> >
> > >
> > > > re-creating the link object)? I don't see any function named
> > > > bpf_link__attach() that would do such a thing, or any other functio=
n
> > > > in libbpf API that can do something similar, am I right?
> > >
> > > Right, links are created with bpf_program__attach*() APIs.
> >
> > Got it. I thought that it should be possible to use the same bpf_link
> > object and temporarily detach it when required (attaching it back when
> > required).
> > So now I understand that the only way to achieve such a behavior is to
> > destroy the link and recreate it, right?
>
> Right. You could "restore" struct bpf_link from pinned link instance
> in BPF FS through bpf_link__open(), but overall bpf_link is meant to
> be created by attachment and destroyed to detach the program.
>
> >
> > >
> > > > Also, It seems that using bpf_link__detach() does not fit all link
> > > > types. For example, when attaching a (non legacy) kprobe, detaching=
 it
> > > > should probably happen using PERF_EVENT_IOC_DISABLE and not through
> > > > sys_bpf(BPF_LINK_DETACH), shouldn't it?
> > > >
> > > > And one last question:
> > > > When using bpf_program__unload() on a program that is already
> > > > attached, should we first call bpf_link__detach() or does the kerne=
l
> > > > already take care of this?
> > >
> > > Keep in mind that bpf_program__unload() is also deprecated. The idea
> > > is that if you are working with high-level libbpf APIs that are
> > > centered around struct bpf_object, bpf_program, and bpf_map, the
> > > entire collection of programs and maps is functioning as a single
> > > bundle. If that abstraction doesn't work, you'll have to drop to
> > > low-level APIs (defined in bpf/bpf.h) and manipulate everything
> > > through FDs.
> >
> > Yes, it seems that this abstraction is not enough for our use case.
> > As I described above, Tracee's bpf programs and maps do work as a
> > bundle, but sometimes it might be required to unload/load bpf programs
> > according to user request.
> > The problem with using the lower level APIs (such as bpf_prog_load())
> > is that they expect to get bpf instructions and not a bpf_program
> > struct (which is a good abstraction),
> > so working with them will require to implement by ourselves some of
> > the logic of libbpf, and we want to avoid that
> >
> > >
> > > As for detaching (destroying in libbpf lingo, though) the link, yes,
> > > you need to destroy links before unloading the program. Otherwise
> > > links themselves will keep programs loaded in the kernel. Some legacy
> > > links (legacy kprobe/uprobe) won't auto-detach even on process exit
> > > because the kernel doesn't support this.
> >
> > Got it, thanks
> >
> > >
> > > >
> > > > Thanks,
> > > > Yaniv
