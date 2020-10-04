Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A16E282E33
	for <lists+bpf@lfdr.de>; Mon,  5 Oct 2020 00:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgJDWwx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Oct 2020 18:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgJDWww (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Oct 2020 18:52:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F8EC0613CE
        for <bpf@vger.kernel.org>; Sun,  4 Oct 2020 15:52:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l17so7351791edq.12
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2020 15:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KKtPWB3qCfBDrOOqt7qQDIxItKo9oFbV2GP8nvmxXHE=;
        b=lLkhMyeaWoeRHo9ICMaA1XW+rcBs9pinrOsuydyl5Xwa/vqq3YTDTnLfLHYfSjKSFO
         pZ8uIaeCybSgqs0peyszW0QdWgH3Sa/EdjFH4R+ExEKoqpm8ZUPzFJsXTQQ37N/DNY53
         pGUPTy/BlKs97icERe2WUsR0L5/6baZOK9HBpsuj5VGoPa494YYvbd2wETOsEUU15vfL
         l5Ov9m4x1h4+RiDPGugCUjWZucvGL2OBEp3yRNlQI3R5JXN4v9T8CCmR7LxBQ/XAuPBL
         CuXkNz3T2HOnhmrcsnYeedhXiJi03eFOvdKRF4lVpM5fhGoK6IapFjSgtwV5oKUVZhXA
         2GsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KKtPWB3qCfBDrOOqt7qQDIxItKo9oFbV2GP8nvmxXHE=;
        b=NjoAf5ik5O6VJMS2bf/ruG7tt83xdFkMiHHNZuenZDbNz66CNH8ZsMTz2nKMWspDBs
         inJw7HNp01dXGttdA2k8ZwRxdGwR4GE/4UoYVd4va0e2xiwugonicpUt2hwChs2WBNx8
         M1ZBpv5Uf1CjoCFH8Fn4BS1L0XdMzj3e5AZ1RcMsGmZrqo1faVrQ2Via7Wx8R9lN7BJO
         c3ytmvU894bZCaIdNKRwZOpYLZ3y27iy7i1Ssg/Y9TEwx5brj/C7s1dDf9IBQ7xQFOxy
         yx6aHKsV0izq8YI/PP3nEN0JDHZiSVLEY93odjMNcg90Chi+EoAOiCfyG2X9rsiPXY8N
         56uQ==
X-Gm-Message-State: AOAM533DbbWOotQASWzg7sb9DmDaruXtl57zpMzNpKsoTAm3ZWW9SYfT
        rA4llYanwb4lMrk3MQR0sKjWBxTqVbgE7EOzNxQ7r2NSnwE=
X-Google-Smtp-Source: ABdhPJw73lEWATN4VzWV49m+63MSOpJIGHpPPJOjBabZrQ7G1ZVo6DiuMsOygTan4FZotUxEqS6VK9vBsO4mG1UQZnE=
X-Received: by 2002:a05:6402:3c1:: with SMTP id t1mr13702093edw.231.1601851970917;
 Sun, 04 Oct 2020 15:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZVMPuXp6sOTPPtDYZbhan2PZDBUtsTTZ78PikxKMoBm9g@mail.gmail.com>
 <CAEf4Bza00DMqu09vPL+1-_1361cw5HoDyE3pY6hSDkD0M-PGjA@mail.gmail.com>
 <CAMy7=ZVCUJKFA5AbaE3DeyCNsWXffWwcYtA6d5t9R5kgnzPi2A@mail.gmail.com>
 <CAEf4BzaTXz6s2xfV0swvcpKFz=U+K1DzD0+DEHSZ+e4Yf0xxPA@mail.gmail.com>
 <CAMy7=ZUgWyZNVs6haL4MF2hZ24MuvfE_mEOXopgVZFGF_D8miA@mail.gmail.com>
 <CAEf4BzZ=w++q3VVG8Mox4KsRHfY4P4J7G0Pnse2erWS6=OX3UQ@mail.gmail.com>
 <CAMy7=ZXdR5MgHLiqvgVyavVCLX3Erm=DURdEWZTYPMyJGC9Frw@mail.gmail.com> <CAEf4Bza47eedA_PFyOs94ZJczqFxLgPGDBgq4HES=EMMcUF44g@mail.gmail.com>
In-Reply-To: <CAEf4Bza47eedA_PFyOs94ZJczqFxLgPGDBgq4HES=EMMcUF44g@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Mon, 5 Oct 2020 01:52:39 +0300
Message-ID: <CAMy7=ZUoQ2JKjAxnqOX_PjaQQJBCMyYZKxqPM4uo-ZRsbCK6rQ@mail.gmail.com>
Subject: Re: Help using libbpf with kernel 4.14
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=93=D7=
=B3, 30 =D7=91=D7=A1=D7=A4=D7=98=D7=B3 2020 =D7=91-21:34 =D7=9E=D7=90=D7=AA=
 =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
<=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Tue, Sep 29, 2020 at 1:25 AM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=92=
=D7=B3, 29 =D7=91=D7=A1=D7=A4=D7=98=D7=B3 2020 =D7=91-4:29 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> > <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > >
> > > On Mon, Sep 28, 2020 at 5:01 PM Yaniv Agman <yanivagman@gmail.com> wr=
ote:
> > > >
> > > > Hi Andrii,
> > > >
> > > > I used BPF skeleton as you suggested, which did work with kernel 4.=
19
> > > > but not with 4.14.
> > > > I used the exact same program,  same environment, only changed the
> > > > kernel version.
> > > > The error message I get on 4.14:
> > > >
> > > > libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
> > > > libbpf: failed to determine kprobe perf type: No such file or direc=
tory
> > >
> > > This means that your kernel doesn't support attaching to
> > > kprobe/tracepoint through perf_event subsystem. That's currently the
> > > only way that libbpf supports for kprobe/tracapoint programs. It was
> > > added in 4.17 kernel, which explains what is happening in your case.
> > > It is still possible to attach to kprobe using legacy ways, but libbp=
f
> > > doesn't provide that out of the box. We had a discussion a while ago
> > > (about 1 year ago) about adding that to libbpf, but at that time we
> > > didn't have a good testing infrastructure to validate such legacy
> > > interfaces, plus it's a bit on the unsafe side as far as APIs go
> > > (there is no auto-detachment and cleanup with how old kernels allow t=
o
> > > do kprobe/tracepoint). But we might reconsider, given it's not a firs=
t
> > > time I see people get confused and blocked by this.
> > >
> > > Anyways, here's how you can do it without waiting for libbpf to do
> > > this out of the box:
> > >
> > >
>
> [...]
>
> > >
> > >
> > > Then you'd use it in your application as:
> > >
> > > ...
> > >
> > >   skel->links.handler =3D attach_kprobe_legacy(
> > >       skel->progs.handler, "do_sys_open", false /* is_kretprobe */);
> > >   if (!skel->links.handler) {
> > >     fprintf(stderr, "Failed to attach kprobe using legacy debugfs API=
!\n");
> > >     err =3D 1;
> > >     goto out;
> > >   }
> > >
> > >   ... kprobe is attached here ...
> > >
> > > out:
> > >   /* first clean up step */
> > >   bpf_link__destroy(skel->links.handler);
> > >   /* this is second necessary clean up step */
> > >   remove_kprobe_event("do_sys_open", false /* is_kretprobe */);
> > >
> > >
> > > Let me know if that worked.
> > >
> >
> > Thanks Andrii,
> >
> > I made a small change for the code to compile:
> > skel->links.handler to skel->links.kprobe__do_sys_open and same for ske=
l->progs
> >
> > After compiling the code, I'm now getting the following error:
> > failed to create perf event for kprobe ID 1930: -2
> > Failed to attach kprobe using legacy debugfs API!
> > failed to remove kprobe '-:kprobes/do_sys_open': -2
>
> I've successfully used that code on the kernel as old as 4.9, so this
> must be something about your kernel configuration. E.g., check that
> CONFIG_KPROBE_EVENTS is enabled.

Just wanted to update that this code works!
I didn't include <linux/unistd.h> and for some reason the compiler
didn't complain...
Thank you very much Andrii!

>
> >
> > As our application is written in go,
> > I hoped libbpf would support kernel 3.14 out of the box, so we can
> > just call libbpf functions using cgo wrappers.
> > I can do further checks if you'd like, but I think we will also
> > consider updating the minimal kernel version requirement to 4.18
>
> It's up to you. Of course using a more recent kernel would be much
> better, if you can get away with it.
>
> >
> > > > libbpf: prog 'kprobe__do_sys_open': failed to create kprobe
> > > > 'do_sys_open' perf event: No such file or directory
> > > > libbpf: failed to auto-attach program 'kprobe__do_sys_open': -2
> > > > failed to attach BPF programs: No such file or directory
> > > >
> > >
> > > [...]
