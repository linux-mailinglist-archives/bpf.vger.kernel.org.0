Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92AD27B678
	for <lists+bpf@lfdr.de>; Mon, 28 Sep 2020 22:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgI1UjP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 16:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgI1UjP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 16:39:15 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D624EC061755
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 13:39:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id q13so10991152ejo.9
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 13:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7C3d5R+7akB1opp2XfU1DXj3YjGd+B5lclaA2qaX+xk=;
        b=QS20iN4A2tNWzNZVnr4+/dE85L2sbLZrF/2dOfqzRAazo8uhfJTbcLwVVQQrGQvyxB
         enk4GJgIu9u/j3BMxt5akxrZCC3x2KoTHMz+kUoMmGOwIdHnS5m5sCwCiAE39GOVr6hD
         vmmtAvMb/xSovSJZGAbEMZaE24Y0ZXTKYo5xTPGVeYjOthIzoTE5DwwKxf1e8+V8YqE6
         2oMfxyJ1ZH6dHI6RBlA3YOm5r7iNCePfZHyix3RFAhyLRyvUFxeNB40NM5f+Fbm/K6W5
         /UgmC9Q5AmgpTHboHfCvgk32hdmphpd64ZeDt8Yi9U6fOuy5VT7RvY9MA7qk+bOtplPd
         pXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7C3d5R+7akB1opp2XfU1DXj3YjGd+B5lclaA2qaX+xk=;
        b=I3SymRwZnAm7ewrn6B13on6EIUuw0I9gpEWepa6mZ7IXsyAx2Ff8AqkoTf3mxjhpbg
         DewkoGOMLMPHDZFiUE/RTFdC21OyoFyppBwvf3GQKLnxZlY0Z+apxi+Wr+BKAPWb2xPZ
         uI2e8hv4OVzcNCK2V7BbuqG9gz+e/iWclprvEWJrMXk45QCaqsRHKHlbxl5YL0LaM5j6
         7rUHThu0+usgXGoImIOpby9CVkAqLDVaKwfNgVzdp/oSjDYcU/Gu0NGaeF7k9/8e7nGb
         OoiDjkhlzFfqyRNopSS6YowBZYPrBEQGIY6BixGkSrNrAd9X7hwAVRXzuKZeXredbLPJ
         3Ynw==
X-Gm-Message-State: AOAM532TTHqxd8t9MYz2zN6UgkaJpzKSsFKix3bD2GFYXS1uxihmaKEY
        IWVfPvFdncyXa5HijVF3hZDZSUrs4iTZTE06klk=
X-Google-Smtp-Source: ABdhPJyC3qvVUuCmIM6gpYuYqLMSIPhhqLtWD7Nf8o8GZMn6xGejurxkcQIpaLn+K/3UV6Xz3T3rgZKB3m736P7KAaY=
X-Received: by 2002:a17:906:3ca2:: with SMTP id b2mr560159ejh.460.1601325552251;
 Mon, 28 Sep 2020 13:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZVMPuXp6sOTPPtDYZbhan2PZDBUtsTTZ78PikxKMoBm9g@mail.gmail.com>
 <CAEf4Bza00DMqu09vPL+1-_1361cw5HoDyE3pY6hSDkD0M-PGjA@mail.gmail.com>
 <CAMy7=ZVCUJKFA5AbaE3DeyCNsWXffWwcYtA6d5t9R5kgnzPi2A@mail.gmail.com> <CAEf4BzaTXz6s2xfV0swvcpKFz=U+K1DzD0+DEHSZ+e4Yf0xxPA@mail.gmail.com>
In-Reply-To: <CAEf4BzaTXz6s2xfV0swvcpKFz=U+K1DzD0+DEHSZ+e4Yf0xxPA@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Mon, 28 Sep 2020 23:39:01 +0300
Message-ID: <CAMy7=ZWFGYRzYG5b-ynC9XiPers8jovhdOyfMdB0sa5kiNypbw@mail.gmail.com>
Subject: Re: Help using libbpf with kernel 4.14
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 28 =D7=91=D7=A1=D7=A4=D7=98=D7=B3 2020 =D7=91-23:24 =D7=9E=D7=90=D7=AA=
 =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
<=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Mon, Sep 28, 2020 at 1:08 PM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=
=D7=B3, 28 =D7=91=D7=A1=D7=A4=D7=98=D7=B3 2020 =D7=91-8:50 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> > <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > >
> > > On Fri, Sep 25, 2020 at 4:58 PM Yaniv Agman <yanivagman@gmail.com> wr=
ote:
> > > >
> > > > Hello,
> > > >
> > > > I'm developing a tool which is now based on BCC, and would like to
> > > > make the move to libbpf.
> > > > I need the tool to support a minimal kernel version 4.14, which
> > > > doesn't have CO-RE.
> > >
> > > You don't need kernel itself to support CO-RE, you just need that
> > > kernel to have BTF in it. If the kernel is too old to have
> > > CONFIG_DEBUG_INFO_BTF config, you can still add BTF by running `pahol=
e
> > > -J <path-to-vmlinux-image>`, if that's at all an option for your
> > > setup.
> > >
> >
> > Thanks, I didn't know that
> >
> > > >
> > > > I have read bcc-to-libbpf-howto-guide, and looked at the libbpf-too=
ls of bcc,
> > > > but both only deal with newer kernels, and I failed to change them =
to
> > > > run with a 4.14 kernel.
> > > >
> > > > Although some of the bpf samples in the kernel source don't use CO-=
RE,
> > > > they all use bpf_load.h,
> > > > and have dependencies on the tools dir, which I would like to avoid=
.
> > >
> > > Depending on what exactly you are trying to achieve with your BPF
> > > application, you might not need BPF CO-RE, and using libbpf without
> > > CO-RE would be enough for your needs. This would be the case if you
> > > don't need to access any of the kernel data structures (e.g., all sor=
t
> > > of networking BPF apps: TC programs, cgroup sock progs, XDP). But if
> > > you need to do anything tracing related (e.g., looking at kernel's
> > > task_struct or any other internal structure), then you have no choice
> > > and you either have to do on-the-target-host runtime compilation (BCC
> > > way) or relocations (libbpf + BPF CO-RE). This is because of changing
> > > memory layout of kernel structures.
> > >
> > > So, unless you can compile one specific version of your BPF code for =
a
> > > one specific version of the kernel, you need either BCC or BPF CO-RE.
> > >
> >
> > I'm working on a tracing application
> > (https://github.com/aquasecurity/tracee) which now uses bcc. We now
> > require a minimal kernel version 4.14, and bcc, but eventually we
> > would like to support CO-RE. I thought that we could do the move in
> > two steps. First moving to libbpf and keeping the 4.14 minimal
> > requirement, then adding CO-RE support in the future.
> > In order to do that, I thought of changing bcc requirement to clang
> > requirement, and compile the program once during installation on the
> > target host. This way we get the added value of fast start time
> > without the need to compile every time the program starts (like bcc
> > does), plus having an easier move to CO-RE in the future.
>
> Right, pre-compiling on the target machine with host kernel headers
> should work. So just don't use any of CO-RE features (no CO-RE
> relocations, no vmlinux.h), and it should just work.
>
> >
> > A problem that I encountered with kernel 4.14 and libbpf was that when
> > using bpf_prog_load (If I remember correctly), it returned an error of
> > invalid argument (-22). Doing a small investigation I saw that it
> > happened when trying to create bpf maps with names. Indeed I saw that
> > libbpf API changed between kernel 4.14 and 4.15 and the function
> > bpf_create_map_node now takes map name as an argument. Is there a way
> > to workaround this with kernel 4.14 and still use map names in
> > userspace to refer to bpf maps with libbpf?
>
> So we do run a few simple tests loading BPF programs (using libbpf) on
> 4.9 kernel, so map name should definitely not be a problem at all
> (libbpf is smart about detecting what's not supported in kernel and
> omitting non-essential things). It might be because of bpf_prog_load
> itself, which was long deprecated and you shouldn't use it for
> real-world applications. Please either use BPF skeleton or bpf_object
> APIs. It should just work, but if it doesn't please report back.
>

Thanks, I'll try that and report on any issues found

> >
> > > >
> > > > I would appreciate it if someone can help with a simple working
> > > > example of using libbpf on 4.14 kernel, without having any
> > > > dependencies. Specifically, I'm looking for an example makefile, an=
d
> > > > to know how to load my bpf code with libbpf.
> > >
> > > libbpf-tools's Makefile would still work. Just drop dependency on
> > > vmlinux.h and include system headers directly, if necessary (and if
> > > you considered implications of kernel memory layout changes).
> > >
> >
> > Thanks, I'll try that
> >
> > > >
> > > > Thanks,
> > > > Yaniv
