Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7C6282FA2
	for <lists+bpf@lfdr.de>; Mon,  5 Oct 2020 06:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgJEEaH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Oct 2020 00:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgJEEaG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 00:30:06 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C6DC0613CE
        for <bpf@vger.kernel.org>; Sun,  4 Oct 2020 21:30:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f70so5712610ybg.13
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2020 21:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l9ztmww0YGh9IiyCJO/ShWmZmBIBDmouppZu286Hu+8=;
        b=QFIGV8dRUwXPcwZG7Bg+Gx/gszk5NBVXCl8CjccW3bP//RRSPN/NalMK/NYtdTL2yP
         IUm3iuoQPoZrThDW89L1kZjpe4rvIimQ8iZ9+rdpyhgUNqFE9x1Qhh4sPGtW+WAD9EzH
         oLpwrg0Uv6umWSKhyWz6g8lb2xJgAoaJku7vc/VJpLf5QLNF9qiOUP3nuMkayI24lJ1c
         PDVU/oyEcU0dhoXazLLjjOFFQ8IxY6GMzj9kOqwkHiCFcVOSE2ug7wYt1F+i4ofkUdgn
         fHYj5f+/zKXm06ppt77jWR1HZ7DW2MxvK4K5F4Ki2A+zSjVlBnsyLm7qeaX1UiKCx6M3
         QheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l9ztmww0YGh9IiyCJO/ShWmZmBIBDmouppZu286Hu+8=;
        b=Xj93EvkwlNph7jlgreTVMIyng2anXdnHV7ZJAzGCric9aYiBydZtRcVfvOYnPT0CbB
         a9YRNyVCxbeb4bL6OMGm6ojgm66/r8xg9rgJ52pRWgkKi92HsKWYOd/Hd6TwyGx96lNs
         aJbfyCx30x0rJJhwANyLSWidKE/FXGFsEbTGPXTqoyvE81jMyYhAhzR68WHQOe/sxbYE
         EUMp79w9DY2oStiuhdc48yXAZ3Gw3rwAzzRo87AZCG+oQgj2bKrXTNRhSmrGrppF3QQr
         r8ooIDBbGtmFBY2NsgoOOaYSjAT76YqA6btE7tAM2Vda6V44WyG7sHksEYqZTnI9mzCi
         H/Dw==
X-Gm-Message-State: AOAM5326P8XlhAbonWY/NXaUX49GdsHPNLkHrusC70Z4T5QLDGCltbkh
        zldyzogGH6XrRumHIdf4yz7uNPVntXbm/qjMrWzzmTo1iOE=
X-Google-Smtp-Source: ABdhPJy00boWV8rBZYLbyFfVhU8WJnA5lKGe0G6+Z82dc73GSrHVUYSisKiqPWMxKrKMjDJdm07sBbl6p4FNEmJXnBI=
X-Received: by 2002:a25:2687:: with SMTP id m129mr16208901ybm.425.1601872204352;
 Sun, 04 Oct 2020 21:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZVMPuXp6sOTPPtDYZbhan2PZDBUtsTTZ78PikxKMoBm9g@mail.gmail.com>
 <CAEf4Bza00DMqu09vPL+1-_1361cw5HoDyE3pY6hSDkD0M-PGjA@mail.gmail.com>
 <CAMy7=ZVCUJKFA5AbaE3DeyCNsWXffWwcYtA6d5t9R5kgnzPi2A@mail.gmail.com>
 <CAEf4BzaTXz6s2xfV0swvcpKFz=U+K1DzD0+DEHSZ+e4Yf0xxPA@mail.gmail.com>
 <CAMy7=ZUgWyZNVs6haL4MF2hZ24MuvfE_mEOXopgVZFGF_D8miA@mail.gmail.com>
 <CAEf4BzZ=w++q3VVG8Mox4KsRHfY4P4J7G0Pnse2erWS6=OX3UQ@mail.gmail.com>
 <CAMy7=ZXdR5MgHLiqvgVyavVCLX3Erm=DURdEWZTYPMyJGC9Frw@mail.gmail.com>
 <CAEf4Bza47eedA_PFyOs94ZJczqFxLgPGDBgq4HES=EMMcUF44g@mail.gmail.com> <CAMy7=ZUoQ2JKjAxnqOX_PjaQQJBCMyYZKxqPM4uo-ZRsbCK6rQ@mail.gmail.com>
In-Reply-To: <CAMy7=ZUoQ2JKjAxnqOX_PjaQQJBCMyYZKxqPM4uo-ZRsbCK6rQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 4 Oct 2020 21:29:53 -0700
Message-ID: <CAEf4BzaBWUGSRzOG+36h7CTFgYS8j+JphTLtcb5AezYk79MF_g@mail.gmail.com>
Subject: Re: Help using libbpf with kernel 4.14
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 4, 2020 at 3:52 PM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=93=
=D7=B3, 30 =D7=91=D7=A1=D7=A4=D7=98=D7=B3 2020 =D7=91-21:34 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> > On Tue, Sep 29, 2020 at 1:25 AM Yaniv Agman <yanivagman@gmail.com> wrot=
e:
> > >
> > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=92=D7=B3, 29 =D7=91=D7=A1=D7=A4=D7=98=D7=B3 2020 =D7=91-4:29 =D7=9E=D7=90=
=D7=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> > > <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > >
> > > > On Mon, Sep 28, 2020 at 5:01 PM Yaniv Agman <yanivagman@gmail.com> =
wrote:
> > > > >
> > > > > Hi Andrii,
> > > > >
> > > > > I used BPF skeleton as you suggested, which did work with kernel =
4.19
> > > > > but not with 4.14.
> > > > > I used the exact same program,  same environment, only changed th=
e
> > > > > kernel version.
> > > > > The error message I get on 4.14:
> > > > >
> > > > > libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
> > > > > libbpf: failed to determine kprobe perf type: No such file or dir=
ectory
> > > >
> > > > This means that your kernel doesn't support attaching to
> > > > kprobe/tracepoint through perf_event subsystem. That's currently th=
e
> > > > only way that libbpf supports for kprobe/tracapoint programs. It wa=
s
> > > > added in 4.17 kernel, which explains what is happening in your case=
.
> > > > It is still possible to attach to kprobe using legacy ways, but lib=
bpf
> > > > doesn't provide that out of the box. We had a discussion a while ag=
o
> > > > (about 1 year ago) about adding that to libbpf, but at that time we
> > > > didn't have a good testing infrastructure to validate such legacy
> > > > interfaces, plus it's a bit on the unsafe side as far as APIs go
> > > > (there is no auto-detachment and cleanup with how old kernels allow=
 to
> > > > do kprobe/tracepoint). But we might reconsider, given it's not a fi=
rst
> > > > time I see people get confused and blocked by this.
> > > >
> > > > Anyways, here's how you can do it without waiting for libbpf to do
> > > > this out of the box:
> > > >
> > > >
> >
> > [...]
> >
> > > >
> > > >
> > > > Then you'd use it in your application as:
> > > >
> > > > ...
> > > >
> > > >   skel->links.handler =3D attach_kprobe_legacy(
> > > >       skel->progs.handler, "do_sys_open", false /* is_kretprobe */)=
;
> > > >   if (!skel->links.handler) {
> > > >     fprintf(stderr, "Failed to attach kprobe using legacy debugfs A=
PI!\n");
> > > >     err =3D 1;
> > > >     goto out;
> > > >   }
> > > >
> > > >   ... kprobe is attached here ...
> > > >
> > > > out:
> > > >   /* first clean up step */
> > > >   bpf_link__destroy(skel->links.handler);
> > > >   /* this is second necessary clean up step */
> > > >   remove_kprobe_event("do_sys_open", false /* is_kretprobe */);
> > > >
> > > >
> > > > Let me know if that worked.
> > > >
> > >
> > > Thanks Andrii,
> > >
> > > I made a small change for the code to compile:
> > > skel->links.handler to skel->links.kprobe__do_sys_open and same for s=
kel->progs
> > >
> > > After compiling the code, I'm now getting the following error:
> > > failed to create perf event for kprobe ID 1930: -2
> > > Failed to attach kprobe using legacy debugfs API!
> > > failed to remove kprobe '-:kprobes/do_sys_open': -2
> >
> > I've successfully used that code on the kernel as old as 4.9, so this
> > must be something about your kernel configuration. E.g., check that
> > CONFIG_KPROBE_EVENTS is enabled.
>
> Just wanted to update that this code works!
> I didn't include <linux/unistd.h> and for some reason the compiler
> didn't complain...
> Thank you very much Andrii!

You are welcome, I'm glad you figured it out.

>
> >
> > >
> > > As our application is written in go,
> > > I hoped libbpf would support kernel 3.14 out of the box, so we can
> > > just call libbpf functions using cgo wrappers.
> > > I can do further checks if you'd like, but I think we will also
> > > consider updating the minimal kernel version requirement to 4.18
> >
> > It's up to you. Of course using a more recent kernel would be much
> > better, if you can get away with it.
> >
> > >
> > > > > libbpf: prog 'kprobe__do_sys_open': failed to create kprobe
> > > > > 'do_sys_open' perf event: No such file or directory
> > > > > libbpf: failed to auto-attach program 'kprobe__do_sys_open': -2
> > > > > failed to attach BPF programs: No such file or directory
> > > > >
> > > >
> > > > [...]
