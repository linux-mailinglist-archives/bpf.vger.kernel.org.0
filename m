Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BD427B8C1
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 02:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgI2AQn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 20:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgI2AQn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 20:16:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9604CC061755
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 17:16:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z23so12304609ejr.13
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 17:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TXp2Augxkutc2/klfW5WW6BpM3TaNvawxl81pRZp7lI=;
        b=mdRnKqMcKlFNCzwNVSvCfUjS2DS+FUU7al3Gdzccfx5I0CQEfVC1se6njlMnmORb89
         av+pzaMkbBGGx+aEpbuQSmuYaYqEd1qz35T2EDimjuvaJV+IWoW4K4s47elEqUHxTROd
         1/JiFg/HaObCX+8YIuvY+gdHf7nROhpy2WXKCxAfVZ1X7QMZh/6NJCWkwEUC/sTJIvU5
         JJBVB3Qo7exVbq4pLblJm9XUKaOL8fbwYN4YPrLur4TgGVczBcdK9WY/q6BDmB63mJ5E
         VkHT2pitgq5LnoQ2C1kG4nIh8NXuZ9iEpxM6fRxZWeh/VpvHqkA8OGQQNIM9HEU9DyL0
         DC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TXp2Augxkutc2/klfW5WW6BpM3TaNvawxl81pRZp7lI=;
        b=KEZhXe+wP4qBt/KEQliiFramhnX2iYeMf1s4tSOx5cqWsn37ruWr9w+DdPdL0Fb/u1
         rulqZmerfyZmZn1L8Op8oQxR4SVkMVMdr+iub9Rqv+nR7mTselcmBClDUAr/Lfr1SnRx
         6a/TRbzvOExtxXfU5SeJPUCnZHIIFdHxgKkqGyVdjrtREhRMtCivkHO5YIKlXhnWVPAl
         E0RBzNfWcqFOeEpnhbH4lv9oQcRtmHH5702OJkTjKr1KbbRXdHnJSKqavXI2uVpzZTSZ
         viZLqGVlnKkGIS5IIR7n3xc5lYKVkcyba4e/ZYGdjoopscAqncru6UuHS35yJ3ZRwN3v
         2EuQ==
X-Gm-Message-State: AOAM5311tT6UrrrzsqDz5wmzYtMYI9ouhVLHLW8dI2GsdWl3ZHZTQE6f
        LiFxomecFp55rQyjpEEukpetqApdAuH3um5/HwU=
X-Google-Smtp-Source: ABdhPJyrMj4T7j3bYF8CINyDUePOnn9OzoycTh0zrWuIR8do35t6hSe6PKYw/7GFl81rDUZ2YUFtbcqS+Z3ytu/uhZs=
X-Received: by 2002:a17:906:3ac5:: with SMTP id z5mr1289398ejd.46.1601338598178;
 Mon, 28 Sep 2020 17:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZVMPuXp6sOTPPtDYZbhan2PZDBUtsTTZ78PikxKMoBm9g@mail.gmail.com>
 <CAEf4Bza00DMqu09vPL+1-_1361cw5HoDyE3pY6hSDkD0M-PGjA@mail.gmail.com>
 <CAMy7=ZVCUJKFA5AbaE3DeyCNsWXffWwcYtA6d5t9R5kgnzPi2A@mail.gmail.com>
 <CAEf4BzaTXz6s2xfV0swvcpKFz=U+K1DzD0+DEHSZ+e4Yf0xxPA@mail.gmail.com>
 <CAMy7=ZUgWyZNVs6haL4MF2hZ24MuvfE_mEOXopgVZFGF_D8miA@mail.gmail.com> <429e4b06-9f0c-0565-65fd-fd21a8183c0c@fb.com>
In-Reply-To: <429e4b06-9f0c-0565-65fd-fd21a8183c0c@fb.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Tue, 29 Sep 2020 03:16:27 +0300
Message-ID: <CAMy7=ZW7OHov+eZm5aFfKA9xG5Z4xeYOfc2F5159_y7JZOWvhQ@mail.gmail.com>
Subject: Re: Help using libbpf with kernel 4.14
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Doing this, I get:
"libbpf: kernel doesn't support global data"

And now it failed earlier (in the loading phase and not the attach
phase as before)
Anyways, I think that what you suggested may resolve the "skipping
unrecognized data section" and not the probe attachment errors

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=92=D7=
=B3, 29 =D7=91=D7=A1=D7=A4=D7=98=D7=B3 2020 =D7=91-3:07 =D7=9E=D7=90=D7=AA =
=E2=80=AAYonghong Song=E2=80=AC=E2=80=8F <=E2=80=AAyhs@fb.com=E2=80=AC=E2=
=80=8F>:=E2=80=AC
>
>
>
> On 9/28/20 5:00 PM, Yaniv Agman wrote:
> > Hi Andrii,
> >
> > I used BPF skeleton as you suggested, which did work with kernel 4.19
> > but not with 4.14.
> > I used the exact same program,  same environment, only changed the
> > kernel version.
> > The error message I get on 4.14:
> >
> > libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
> > libbpf: failed to determine kprobe perf type: No such file or directory
> > libbpf: prog 'kprobe__do_sys_open': failed to create kprobe
> > 'do_sys_open' perf event: No such file or directory
> > libbpf: failed to auto-attach program 'kprobe__do_sys_open': -2
> > failed to attach BPF programs: No such file or directory
> >
> > As the program I made is small, I'm copying it here:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > #include <linux/version.h>
> > #include <bpf/bpf_helpers.h>
> > #include <bpf/bpf_tracing.h>
> > #include <uapi/linux/bpf.h>
> > #include <uapi/linux/ptrace.h>
> >
> > struct bpf_map_def SEC("maps") open_fds =3D {
> >    .type =3D BPF_MAP_TYPE_LRU_HASH,
> >    .key_size =3D sizeof(int),
> >    .value_size =3D sizeof(int),
> >    .max_entries =3D 1024,
> > };
> >
> > SEC("kprobe/do_sys_open")
> > int BPF_KPROBE(kprobe__do_sys_open)
> > {
> >    int err;
> >
> >    u32 id =3D bpf_get_current_pid_tgid();
> >    int dfd =3D PT_REGS_PARM1(ctx);
> >
> >    if ((err =3D bpf_map_update_elem(&open_fds, &id, &dfd, BPF_ANY))) {
> >      char log[] =3D "bpf_map_update_elem %d\n";
>
> put the above definition as global like
> const char log[] =3D "bpf_map_update_elem %d\n";
> might help.
>
> >      bpf_trace_printk(log, sizeof(log), err);
> >      return 1;
> >    }
> >
> >    return 0;
> > }
> >
> > char LICENSE[] SEC("license") =3D "GPL";
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > Can you think of a reason why this only happens on 4.14?
> >
> > Thanks,
> > Yaniv
> >
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=
=D7=B3, 28 =D7=91=D7=A1=D7=A4=D7=98=D7=B3 2020 =D7=91-23:24 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> > <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>
> >> On Mon, Sep 28, 2020 at 1:08 PM Yaniv Agman <yanivagman@gmail.com> wro=
te:
> >>>
> >>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=91=D7=B3, 28 =D7=91=D7=A1=D7=A4=D7=98=D7=B3 2020 =D7=91-8:50 =D7=9E=D7=90=
=D7=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> >>> <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>>>
> >>>> On Fri, Sep 25, 2020 at 4:58 PM Yaniv Agman <yanivagman@gmail.com> w=
rote:
> >>>>>
> >>>>> Hello,
> >>>>>
> >>>>> I'm developing a tool which is now based on BCC, and would like to
> >>>>> make the move to libbpf.
> >>>>> I need the tool to support a minimal kernel version 4.14, which
> >>>>> doesn't have CO-RE.
> >>>>
> >>>> You don't need kernel itself to support CO-RE, you just need that
> >>>> kernel to have BTF in it. If the kernel is too old to have
> >>>> CONFIG_DEBUG_INFO_BTF config, you can still add BTF by running `paho=
le
> >>>> -J <path-to-vmlinux-image>`, if that's at all an option for your
> >>>> setup.
> >>>>
> >>>
> >>> Thanks, I didn't know that
> >>>
> >>>>>
> >>>>> I have read bcc-to-libbpf-howto-guide, and looked at the libbpf-too=
ls of bcc,
> >>>>> but both only deal with newer kernels, and I failed to change them =
to
> >>>>> run with a 4.14 kernel.
> >>>>>
> >>>>> Although some of the bpf samples in the kernel source don't use CO-=
RE,
> >>>>> they all use bpf_load.h,
> >>>>> and have dependencies on the tools dir, which I would like to avoid=
.
> >>>>
> >>>> Depending on what exactly you are trying to achieve with your BPF
> >>>> application, you might not need BPF CO-RE, and using libbpf without
> >>>> CO-RE would be enough for your needs. This would be the case if you
> >>>> don't need to access any of the kernel data structures (e.g., all so=
rt
> >>>> of networking BPF apps: TC programs, cgroup sock progs, XDP). But if
> >>>> you need to do anything tracing related (e.g., looking at kernel's
> >>>> task_struct or any other internal structure), then you have no choic=
e
> >>>> and you either have to do on-the-target-host runtime compilation (BC=
C
> >>>> way) or relocations (libbpf + BPF CO-RE). This is because of changin=
g
> >>>> memory layout of kernel structures.
> >>>>
> >>>> So, unless you can compile one specific version of your BPF code for=
 a
> >>>> one specific version of the kernel, you need either BCC or BPF CO-RE=
.
> >>>>
> >>>
> >>> I'm working on a tracing application
> >>> (https://github.com/aquasecurity/tracee) which now uses bcc. We now
> >>> require a minimal kernel version 4.14, and bcc, but eventually we
> >>> would like to support CO-RE. I thought that we could do the move in
> >>> two steps. First moving to libbpf and keeping the 4.14 minimal
> >>> requirement, then adding CO-RE support in the future.
> >>> In order to do that, I thought of changing bcc requirement to clang
> >>> requirement, and compile the program once during installation on the
> >>> target host. This way we get the added value of fast start time
> >>> without the need to compile every time the program starts (like bcc
> >>> does), plus having an easier move to CO-RE in the future.
> >>
> >> Right, pre-compiling on the target machine with host kernel headers
> >> should work. So just don't use any of CO-RE features (no CO-RE
> >> relocations, no vmlinux.h), and it should just work.
> >>
> >>>
> >>> A problem that I encountered with kernel 4.14 and libbpf was that whe=
n
> >>> using bpf_prog_load (If I remember correctly), it returned an error o=
f
> >>> invalid argument (-22). Doing a small investigation I saw that it
> >>> happened when trying to create bpf maps with names. Indeed I saw that
> >>> libbpf API changed between kernel 4.14 and 4.15 and the function
> >>> bpf_create_map_node now takes map name as an argument. Is there a way
> >>> to workaround this with kernel 4.14 and still use map names in
> >>> userspace to refer to bpf maps with libbpf?
> >>
> >> So we do run a few simple tests loading BPF programs (using libbpf) on
> >> 4.9 kernel, so map name should definitely not be a problem at all
> >> (libbpf is smart about detecting what's not supported in kernel and
> >> omitting non-essential things). It might be because of bpf_prog_load
> >> itself, which was long deprecated and you shouldn't use it for
> >> real-world applications. Please either use BPF skeleton or bpf_object
> >> APIs. It should just work, but if it doesn't please report back.
> >>
> >>>
> >>>>>
> >>>>> I would appreciate it if someone can help with a simple working
> >>>>> example of using libbpf on 4.14 kernel, without having any
> >>>>> dependencies. Specifically, I'm looking for an example makefile, an=
d
> >>>>> to know how to load my bpf code with libbpf.
> >>>>
> >>>> libbpf-tools's Makefile would still work. Just drop dependency on
> >>>> vmlinux.h and include system headers directly, if necessary (and if
> >>>> you considered implications of kernel memory layout changes).
> >>>>
> >>>
> >>> Thanks, I'll try that
> >>>
> >>>>>
> >>>>> Thanks,
> >>>>> Yaniv
