Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E82627B5F2
	for <lists+bpf@lfdr.de>; Mon, 28 Sep 2020 22:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgI1UIr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 16:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1UIr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 16:08:47 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2577EC061755
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 13:08:47 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b12so3216762edz.11
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 13:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pr1GdFogfdEl0p7FxahjShOSuP7868ky9JXGJeDW8Hs=;
        b=NDN6Fe5xS6RJ9DOlqpGalnawz1O26J74eD/VoKeSR/4rxmfZa9LFT4A4adG7hkQAFN
         Z4r70im3HbX52D2yelqFgz0m71ocXO3osQhTsP5HNMmobM3bJG+RiC5ah00N9WYLQjpZ
         8uRtlypJOm4rXI6d9sTuQnr20O3BqiT6DS0TqZYdp19DLR/kTDI0fuQIOWNyBcNYnDpn
         qKr6a3iXtOhFu9wNGIGztNvhmRGEjHEiN6OqCSmMVhYnYCdHONHufaPR1rRvWWvNoL6o
         XKMghOVwbvcxy/K0QcvcgGEHFpV8HT7ZvzeMTJ/en1EfA3aQiRVAhvIwo5iaHHbi3L38
         XReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pr1GdFogfdEl0p7FxahjShOSuP7868ky9JXGJeDW8Hs=;
        b=sYWk7J+2FhGliYKP+5fhvuO+VomDoT5gjA56HGvttpP+jlN77dAfSFUSvFuTmxd+YE
         BuMutHXTnbH6OcaylSe9XZU5wD8ECvu12Nkq6ke7AeBQtpoKFt3e86PoPNMJFZp1MOkE
         avD3epTW9TCmdqtB8lAVwp1ZlKOCWiYk+xj5pkHFjrU0uaYHuF9RKT8b3lz/5j1/2UMi
         SNQVy5wfMmOYnSuYEUAhIuF6GRwc9bIUsFPeUzU2hao1z6q7l6DU3A7/EEvktIzvHFvd
         Rw7pfj0KmXZU6166qkBSJb4sF4BVqePXY6NzCS9AUNodsO2W9+1xWZGgW/2eSbSIl/tw
         HgZg==
X-Gm-Message-State: AOAM530wpVUfTlrOIaW+aSf3TMatAjriNhckLnsHE2PROvD5wLYNprOR
        cpXleIuSP7rrmq3wUyVFXK0UN5rgnxdhkGrqKvx4X8PRaXMR8w==
X-Google-Smtp-Source: ABdhPJx0JUXG24zbbqv4TfO5rxpicnKU8XRIwTSa2lJHxAJsKkW+WhzvK6h+Cvp9D8SdGSJuYX/pal055yHbqHQLJQg=
X-Received: by 2002:aa7:cd90:: with SMTP id x16mr3648730edv.302.1601323725766;
 Mon, 28 Sep 2020 13:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZVMPuXp6sOTPPtDYZbhan2PZDBUtsTTZ78PikxKMoBm9g@mail.gmail.com>
 <CAEf4Bza00DMqu09vPL+1-_1361cw5HoDyE3pY6hSDkD0M-PGjA@mail.gmail.com>
In-Reply-To: <CAEf4Bza00DMqu09vPL+1-_1361cw5HoDyE3pY6hSDkD0M-PGjA@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Mon, 28 Sep 2020 23:08:34 +0300
Message-ID: <CAMy7=ZVCUJKFA5AbaE3DeyCNsWXffWwcYtA6d5t9R5kgnzPi2A@mail.gmail.com>
Subject: Re: Help using libbpf with kernel 4.14
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 28 =D7=91=D7=A1=D7=A4=D7=98=D7=B3 2020 =D7=91-8:50 =D7=9E=D7=90=D7=AA =
=E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
<=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Fri, Sep 25, 2020 at 4:58 PM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > Hello,
> >
> > I'm developing a tool which is now based on BCC, and would like to
> > make the move to libbpf.
> > I need the tool to support a minimal kernel version 4.14, which
> > doesn't have CO-RE.
>
> You don't need kernel itself to support CO-RE, you just need that
> kernel to have BTF in it. If the kernel is too old to have
> CONFIG_DEBUG_INFO_BTF config, you can still add BTF by running `pahole
> -J <path-to-vmlinux-image>`, if that's at all an option for your
> setup.
>

Thanks, I didn't know that

> >
> > I have read bcc-to-libbpf-howto-guide, and looked at the libbpf-tools o=
f bcc,
> > but both only deal with newer kernels, and I failed to change them to
> > run with a 4.14 kernel.
> >
> > Although some of the bpf samples in the kernel source don't use CO-RE,
> > they all use bpf_load.h,
> > and have dependencies on the tools dir, which I would like to avoid.
>
> Depending on what exactly you are trying to achieve with your BPF
> application, you might not need BPF CO-RE, and using libbpf without
> CO-RE would be enough for your needs. This would be the case if you
> don't need to access any of the kernel data structures (e.g., all sort
> of networking BPF apps: TC programs, cgroup sock progs, XDP). But if
> you need to do anything tracing related (e.g., looking at kernel's
> task_struct or any other internal structure), then you have no choice
> and you either have to do on-the-target-host runtime compilation (BCC
> way) or relocations (libbpf + BPF CO-RE). This is because of changing
> memory layout of kernel structures.
>
> So, unless you can compile one specific version of your BPF code for a
> one specific version of the kernel, you need either BCC or BPF CO-RE.
>

I'm working on a tracing application
(https://github.com/aquasecurity/tracee) which now uses bcc. We now
require a minimal kernel version 4.14, and bcc, but eventually we
would like to support CO-RE. I thought that we could do the move in
two steps. First moving to libbpf and keeping the 4.14 minimal
requirement, then adding CO-RE support in the future.
In order to do that, I thought of changing bcc requirement to clang
requirement, and compile the program once during installation on the
target host. This way we get the added value of fast start time
without the need to compile every time the program starts (like bcc
does), plus having an easier move to CO-RE in the future.

A problem that I encountered with kernel 4.14 and libbpf was that when
using bpf_prog_load (If I remember correctly), it returned an error of
invalid argument (-22). Doing a small investigation I saw that it
happened when trying to create bpf maps with names. Indeed I saw that
libbpf API changed between kernel 4.14 and 4.15 and the function
bpf_create_map_node now takes map name as an argument. Is there a way
to workaround this with kernel 4.14 and still use map names in
userspace to refer to bpf maps with libbpf?

> >
> > I would appreciate it if someone can help with a simple working
> > example of using libbpf on 4.14 kernel, without having any
> > dependencies. Specifically, I'm looking for an example makefile, and
> > to know how to load my bpf code with libbpf.
>
> libbpf-tools's Makefile would still work. Just drop dependency on
> vmlinux.h and include system headers directly, if necessary (and if
> you considered implications of kernel memory layout changes).
>

Thanks, I'll try that

> >
> > Thanks,
> > Yaniv
