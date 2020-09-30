Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B411B27F15F
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 20:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgI3Sec (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Seb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 14:34:31 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C915C061755
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 11:34:31 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id k18so2037393ybh.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pf9xXAIrRO5cVcksMMdEfgc1USQVFFM5TEuzISyiKWU=;
        b=nrUw3ho67Y86+s6oIRWDb1zecCdJsGtGp2P8H5GHPH/mqHjBPvD8DVsYLbgajBgYb8
         bDeKn3iJrGFK0JNteHiTj0/kBoroN5RbiMfGMb9zCJO13aZdcl+6o12qk3lFdXSlc2EG
         T4incwHBtl50BpK576QjNA0lZmLzxbPCtH6dtu7vGTWmdqBcNwwKRBLofFiyLyCc9Q5k
         ztQkmGPRtAaufY8mZzcpLe8EtynPmpyqyaGDLieKPj4T+X8catud1FLKajmKScdk50TS
         MEo0hK4BKMOBkN1z5qPQEpTMUxwsctOo3eOuSUpAX4Elr4c4yxsOVYlGa5v5NYg6yDx+
         wfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pf9xXAIrRO5cVcksMMdEfgc1USQVFFM5TEuzISyiKWU=;
        b=VmfZr6xCe483viz36s0vUpGNmGtLc8LK+LtktazuCL/Bcae4nWy+rs8eMjRe0PztVW
         DC4gyDQJJzzS4fAJDPaq9+zEbIkT4JlEGi515RXhp1Z8PAxlmlAtmJCuQG74FEiSxjl6
         35GaGH2wLim+ND2PcaIlow0wVF9Wpp0QNmu/rWldiC3ZWCQu++pObmwCA1XU3dwXHPuZ
         J1LjkJiC3S9JnyrfXDvz/i4kVdIfuVnpmZiE35MhIeFKsxgkc8Ut/od2d12iGyu80seI
         v7jDINii48RaXqLQfYgpy+g/2yidGbOAv2UCSZNpauQaInsIhwqez47plNuKrnF+qorw
         Arjg==
X-Gm-Message-State: AOAM532yJ9TZJTnsDaCty7/2fqIEi5lns8048blKPqkEfuPALTQzBDk+
        GMPjzDDc9nAzWxr5z8LErl1jYVpquGxVDjycJNDNzTYSwG/P/g==
X-Google-Smtp-Source: ABdhPJzY8z/dNxLuBSQHju8ZuZZxI5Y/vqHGvjBNSAaHa5BwKOajRozz8pPFALGe3TnOdAdQbYFgPWaN+ONWfdTYr18=
X-Received: by 2002:a25:8541:: with SMTP id f1mr4785593ybn.230.1601490870673;
 Wed, 30 Sep 2020 11:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZVMPuXp6sOTPPtDYZbhan2PZDBUtsTTZ78PikxKMoBm9g@mail.gmail.com>
 <CAEf4Bza00DMqu09vPL+1-_1361cw5HoDyE3pY6hSDkD0M-PGjA@mail.gmail.com>
 <CAMy7=ZVCUJKFA5AbaE3DeyCNsWXffWwcYtA6d5t9R5kgnzPi2A@mail.gmail.com>
 <CAEf4BzaTXz6s2xfV0swvcpKFz=U+K1DzD0+DEHSZ+e4Yf0xxPA@mail.gmail.com>
 <CAMy7=ZUgWyZNVs6haL4MF2hZ24MuvfE_mEOXopgVZFGF_D8miA@mail.gmail.com>
 <CAEf4BzZ=w++q3VVG8Mox4KsRHfY4P4J7G0Pnse2erWS6=OX3UQ@mail.gmail.com> <CAMy7=ZXdR5MgHLiqvgVyavVCLX3Erm=DURdEWZTYPMyJGC9Frw@mail.gmail.com>
In-Reply-To: <CAMy7=ZXdR5MgHLiqvgVyavVCLX3Erm=DURdEWZTYPMyJGC9Frw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Sep 2020 11:34:19 -0700
Message-ID: <CAEf4Bza47eedA_PFyOs94ZJczqFxLgPGDBgq4HES=EMMcUF44g@mail.gmail.com>
Subject: Re: Help using libbpf with kernel 4.14
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 29, 2020 at 1:25 AM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=92=
=D7=B3, 29 =D7=91=D7=A1=D7=A4=D7=98=D7=B3 2020 =D7=91-4:29 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> > On Mon, Sep 28, 2020 at 5:01 PM Yaniv Agman <yanivagman@gmail.com> wrot=
e:
> > >
> > > Hi Andrii,
> > >
> > > I used BPF skeleton as you suggested, which did work with kernel 4.19
> > > but not with 4.14.
> > > I used the exact same program,  same environment, only changed the
> > > kernel version.
> > > The error message I get on 4.14:
> > >
> > > libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
> > > libbpf: failed to determine kprobe perf type: No such file or directo=
ry
> >
> > This means that your kernel doesn't support attaching to
> > kprobe/tracepoint through perf_event subsystem. That's currently the
> > only way that libbpf supports for kprobe/tracapoint programs. It was
> > added in 4.17 kernel, which explains what is happening in your case.
> > It is still possible to attach to kprobe using legacy ways, but libbpf
> > doesn't provide that out of the box. We had a discussion a while ago
> > (about 1 year ago) about adding that to libbpf, but at that time we
> > didn't have a good testing infrastructure to validate such legacy
> > interfaces, plus it's a bit on the unsafe side as far as APIs go
> > (there is no auto-detachment and cleanup with how old kernels allow to
> > do kprobe/tracepoint). But we might reconsider, given it's not a first
> > time I see people get confused and blocked by this.
> >
> > Anyways, here's how you can do it without waiting for libbpf to do
> > this out of the box:
> >
> >

[...]

> >
> >
> > Then you'd use it in your application as:
> >
> > ...
> >
> >   skel->links.handler =3D attach_kprobe_legacy(
> >       skel->progs.handler, "do_sys_open", false /* is_kretprobe */);
> >   if (!skel->links.handler) {
> >     fprintf(stderr, "Failed to attach kprobe using legacy debugfs API!\=
n");
> >     err =3D 1;
> >     goto out;
> >   }
> >
> >   ... kprobe is attached here ...
> >
> > out:
> >   /* first clean up step */
> >   bpf_link__destroy(skel->links.handler);
> >   /* this is second necessary clean up step */
> >   remove_kprobe_event("do_sys_open", false /* is_kretprobe */);
> >
> >
> > Let me know if that worked.
> >
>
> Thanks Andrii,
>
> I made a small change for the code to compile:
> skel->links.handler to skel->links.kprobe__do_sys_open and same for skel-=
>progs
>
> After compiling the code, I'm now getting the following error:
> failed to create perf event for kprobe ID 1930: -2
> Failed to attach kprobe using legacy debugfs API!
> failed to remove kprobe '-:kprobes/do_sys_open': -2

I've successfully used that code on the kernel as old as 4.9, so this
must be something about your kernel configuration. E.g., check that
CONFIG_KPROBE_EVENTS is enabled.

>
> As our application is written in go,
> I hoped libbpf would support kernel 3.14 out of the box, so we can
> just call libbpf functions using cgo wrappers.
> I can do further checks if you'd like, but I think we will also
> consider updating the minimal kernel version requirement to 4.18

It's up to you. Of course using a more recent kernel would be much
better, if you can get away with it.

>
> > > libbpf: prog 'kprobe__do_sys_open': failed to create kprobe
> > > 'do_sys_open' perf event: No such file or directory
> > > libbpf: failed to auto-attach program 'kprobe__do_sys_open': -2
> > > failed to attach BPF programs: No such file or directory
> > >
> >
> > [...]
