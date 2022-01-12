Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F1948C272
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 11:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352586AbiALKmq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 05:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239535AbiALKmp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 05:42:45 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B296C06173F
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 02:42:45 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b13so8385822edn.0
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 02:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9yUwGgvx6FID2GpP1QBBu1mcSI2UYxHzI3K7CJZYljg=;
        b=qJ5c5reRAj2O40rxTfj5GkuMeKutuNEUlAniSUoGNx8t/wSaVH0XvjXeOE8woKK79S
         zcpu9IrmTCwK/rZajIU/B4xmrbMO/dJAHxA+Md7d9D+pEmEADCfDVHtVYeGLzs5boY5e
         cuXrECe0wzUooY4Tc5ac3xiaL3rFq4ydiula5ijodX/ilDgSMzeHpDuaMSOIbQxPGuGW
         cdXjBgiwm1GVUbfJ4Pebw1l0YEO7ujHtVRvdGJg2UrE7x2R+pj3PPpE4sLrBAnj44EaF
         4XjRReCyIR1sahPGzI5e47Xuu+UM/d346NBFifCwYh2Wpvu0yF2JkI9Qkcn9VIKowUiI
         igeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9yUwGgvx6FID2GpP1QBBu1mcSI2UYxHzI3K7CJZYljg=;
        b=hO7YDUiiO7Q6S4MthwBkflPcndeKPOPyje+0pItD8NkR0JAgwl0Q3o93ndgCJGrkVg
         S059jtJyG+t62wG6HzxYl4ud3eHr0HRPcFVEm8S38xGj5VS3pjiSI1kEUrn63fLg38Sf
         7MhT1k18Xt6z2EzLtiEoacPgKotEg2NHGrDhpzTGWobhRJwaN8CX+f4IL26mOjF4x3rF
         dEhQybH6OGlQ8wdfAR1doyP806iukU0csJEgUyGsGjtali9fDDfHNhlV4PJJaHYRthap
         3byP1xQal2WoPh+Ni3QGsAofDiNtXf4HQrLizATSbQojmWHvKj5zhuixa0wUPU/P+eoq
         UguA==
X-Gm-Message-State: AOAM530JT8UgugPLZaif7rN6a0rpl0njYCNCw9A9qS5p3enkAYEWoYfl
        5FtHH/y8S+M1ok7FlLv+93zOHRwUJUtjN2hpmLhKESKjJ3Y=
X-Google-Smtp-Source: ABdhPJwoADMpeKf2isYJUPFsD9qNyyyyMy0h9VGBZVuDNpdgheaV0jDZzk4Lewhfal9p0vtglEmjvcQ/fddK38sfEks=
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr3246966ejd.367.1641984163610;
 Wed, 12 Jan 2022 02:42:43 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZXqyoaw0mOk2Z8ADxUSs95B=SRgvTua3vRJ00nS5qTFgQ@mail.gmail.com>
 <CAEf4BzY-H7ySLukPn+aUm55DhDxfO07e45J4V1q1bLqpDZ98_Q@mail.gmail.com>
In-Reply-To: <CAEf4BzY-H7ySLukPn+aUm55DhDxfO07e45J4V1q1bLqpDZ98_Q@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Wed, 12 Jan 2022 12:42:32 +0200
Message-ID: <CAMy7=ZV_SVoHPxCvcm0NJttg0pgq0ccfjUj9egszWnC0cjXoLg@mail.gmail.com>
Subject: Re: libbpf API: dynamically load(/unload/attach/detach) bpf programs question
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, michael.tcherniack@aquasec.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=92=D7=
=B3, 11 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2022 =D7=91-22:59 =D7=9E=D7=90=D7=AA=
 =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
<=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Tue, Jan 11, 2022 at 4:33 AM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > Hello!
> >
> > I noticed that the bpf_program__load() API was deprecated since libbpf
> > 0.6 saying that bpf_object__load() should be used instead.
> > This, however, doesn't seem to fit our use case of loading multiple
> > bpf programs (that also share the same maps) from one bpf object (elf
> > file), then unloading and loading them dynamically according to some
> > given needs.
>
> What's the use case for loading, then unloading, and then loading again?

In Tracee we have different bpf programs (tracepoints, kprobes, tc)
used to send events and capture data according to what was chosen by
the user.
Currently, the user provides this configuration at start, and we use
autoload to only load the required bpf programs.
We want to be able to change this configuration at runtime, without
having to restart Tracee.
For example, if the user wants to enable/disable network capture, we
want to load/unload the relevant bpf programs.
It is possible that only destroying the link (and attaching back
later) will be enough, but I think that there are other
considerations, such as kernel memory consumption, that makes
unloading the program preferable.

>
> > I'm not sure it is possible to load one specific program from the bpf
> > object using bpf_object__load() API - is it?
>
> It is possible. You can disable loading BPF program by calling
> bpf_program__set_autoload(prog, false) after bpf_object__open() and
> before bpf_object__load().

Yes, I'm aware of bpf_program__set_autoload() and we already use it as
I described above.
I think, however, that there might be problems loading the same object
file more than once:
1. obj->loaded is set to true, and an error will be returned
2. The maps defined by the object were already created and initialized
And possibly other issues that we might encounter.

>
> I've thought about adding a convention to SEC() to disable
> auto-loading declaratively (e.g., SEC('!kprobe/whatever') won't
> auto-load unless autoload is set to true through
> bpf_program__set_autoload()), but we haven't implemented that yet.
>

That can be a nice addition, but I don't think that it will help in our cas=
e

> >
> > Another question with the same context -
> > If I understand correctly, the purpose of detach is to "prevent
> > execution of a previously attached program from any future events"
> > (https://facebookmicrosites.github.io/bpf/blog/2018/08/31/object-lifeti=
me.html),
> > which seems like something that I would want to do if I just wanted to
> > temporarily stop an event from triggering the program. But then I ask
> > myself - what is the meaning of detaching a link (and not
> > bpf_link__destroy() it) if there is no way to attach it back (without
>
> you mean bpf_link__detach()? this is a special "admin-only" operation
> of force-detaching the link, even if there are still link FDs open.
> Normally you shouldn't do it. Use bpf_link__destroy() to detach (and
> make sure no one dup()'ed extra FDs)

Ok, cool. I didn't know that this is a special "admin-only" operation,
as it is defined in libbpf.h with LIBBPF_API and I didn't see any
documentation saying that.

>
> > re-creating the link object)? I don't see any function named
> > bpf_link__attach() that would do such a thing, or any other function
> > in libbpf API that can do something similar, am I right?
>
> Right, links are created with bpf_program__attach*() APIs.

Got it. I thought that it should be possible to use the same bpf_link
object and temporarily detach it when required (attaching it back when
required).
So now I understand that the only way to achieve such a behavior is to
destroy the link and recreate it, right?

>
> > Also, It seems that using bpf_link__detach() does not fit all link
> > types. For example, when attaching a (non legacy) kprobe, detaching it
> > should probably happen using PERF_EVENT_IOC_DISABLE and not through
> > sys_bpf(BPF_LINK_DETACH), shouldn't it?
> >
> > And one last question:
> > When using bpf_program__unload() on a program that is already
> > attached, should we first call bpf_link__detach() or does the kernel
> > already take care of this?
>
> Keep in mind that bpf_program__unload() is also deprecated. The idea
> is that if you are working with high-level libbpf APIs that are
> centered around struct bpf_object, bpf_program, and bpf_map, the
> entire collection of programs and maps is functioning as a single
> bundle. If that abstraction doesn't work, you'll have to drop to
> low-level APIs (defined in bpf/bpf.h) and manipulate everything
> through FDs.

Yes, it seems that this abstraction is not enough for our use case.
As I described above, Tracee's bpf programs and maps do work as a
bundle, but sometimes it might be required to unload/load bpf programs
according to user request.
The problem with using the lower level APIs (such as bpf_prog_load())
is that they expect to get bpf instructions and not a bpf_program
struct (which is a good abstraction),
so working with them will require to implement by ourselves some of
the logic of libbpf, and we want to avoid that

>
> As for detaching (destroying in libbpf lingo, though) the link, yes,
> you need to destroy links before unloading the program. Otherwise
> links themselves will keep programs loaded in the kernel. Some legacy
> links (legacy kprobe/uprobe) won't auto-detach even on process exit
> because the kernel doesn't support this.

Got it, thanks

>
> >
> > Thanks,
> > Yaniv
