Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B03A486AFA
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 21:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243582AbiAFUSJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 15:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiAFUSJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 15:18:09 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F608C061245
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 12:18:09 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id o7so4517825ioo.9
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 12:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gh8HPwk5wIj8j3UO12jMaBLmsjpN4FRqYe3VwkpZtck=;
        b=ANBZLLJ+F4V8/x5EKxiJfEprFjYqH6i8YUjQ5QjSaojGgAtFqjRa0EC/oSGbyxp5lS
         36v0otaWOsd26gdBZSHq5uvm35Jbtxd3dAVPF97vLS+JC1+LJ6Kd8X3A1w/iHCc/vjx9
         Faq7FswrJJzWUT514TO3AG/znsVdrbvqmeCIMbqSSKlMYDKYh28C/ip8SAOtFFu4OoPm
         6391K/mwkogqJ70wFym5AGRFac+7I0WqTAzLSLMEUlSp0fFIqfUTisd1QBozaH6sKSfu
         EyUo1YBeqUf5U72WAGVqvgDjE/Ltu7chWkjqPvP+PiDn85tGMCRn9g6513cKs3KKpKRM
         wfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gh8HPwk5wIj8j3UO12jMaBLmsjpN4FRqYe3VwkpZtck=;
        b=dbUw+NvaXhCHcvVShv8W2Bi4OyIJ9EzFqNGmgVuL9etyZ7N7ma7jPd2qkqBLL5DkmM
         frxGTEQerg79a0MSZ3E6IlVSpuWCGAsEWOg88me2pDUbRFvQFC5VPi1VszD1KyT5jm/2
         95AHvZnt0U52wwiaPnM93mTUJ1YPq+G+tIZUDPiUYBGyIchmcnRFRV+1R3NEE5UFawxK
         s2XYo6xTZZBbDAFFRk8rtbZ/uE6aJgz4d9LTIifpa8IXxiXguPjgQVrZlXbCceZIIvhi
         a8T9inweNuJ88O8hZaeqkQldO0dM7ARga5Kyxz56sq13zX8OKKWCHh4VnibUccCiP9yW
         zgAw==
X-Gm-Message-State: AOAM533K0krpXEcO++AzeA9uEmtCqHB35YKLUSHZQPGRbb0zTjVRHryL
        WkcaNJ9yRjwdC6O+JPCl8GbB5X6/A2zNEPvYHz8=
X-Google-Smtp-Source: ABdhPJziePgL54T/6YUwxfSykH2n+YF+c1atvZ2iF4bIGwXgJtBosqjP9/nfQiM25LiaSvRnWNhAsXPJCASGHwYEedE=
X-Received: by 2002:a02:c6a5:: with SMTP id o5mr29805301jan.145.1641500287912;
 Thu, 06 Jan 2022 12:18:07 -0800 (PST)
MIME-Version: 1.0
References: <1641377010132.82356@hs-osnabrueck.de> <CAEf4BzYfu49iG=mmokC6VpBKoyKfqVDjCpkusjsXGLQTXS1tSQ@mail.gmail.com>
 <1641488009887.85104@hs-osnabrueck.de>
In-Reply-To: <1641488009887.85104@hs-osnabrueck.de>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Jan 2022 12:17:56 -0800
Message-ID: <CAEf4BzaGb3ybiJef4s3-kx_3zeV1kJ7VK=VcE9R59=r7r-sneA@mail.gmail.com>
Subject: Re: [Extern] Re: Problem loading eBPF program on Kernel 4.18 (best
 with CO:RE): -EINVAL
To:     "Buchberger, Dennis" <dennis.buchberger@hs-osnabrueck.de>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 6, 2022 at 8:53 AM Buchberger, Dennis
<dennis.buchberger@hs-osnabrueck.de> wrote:
>
> > >  [...]
> > > As the target kernel does not support CONFIG_DEBUG_INFO_BTF, I used pahole -J (v1.22) to create vmlinux file with BTF info embedded there.
> > > Basically, I followed this mails:
> > > https://urldefense.com/v3/__https://lore.kernel.org/bpf/CADmGQ*1euj7Uv
> > > 9e8UyZMMXDiYAKqXe9=GSTBFNbbg1E0R-ejyg@mail.gmail.com/__;Kw!!MeVeBiz6!5
> > > PZT7QBM-W93AhbZnRJ3kmTO4JyBUiapxeJrPCl4k4gKHidI5Ri0WQp19MbBDFP1nWOL3A$
> > >
> > > Right now, the bpf program is just a uProbe for a simple test app, which writes some output to the tracing pipe. As Kernel 4.18. does not support global data for bpf programs, I had to remove (comment out) the bpf_trace_printk statements.
> >
> > You can do #define BPF_NO_GLOBAL_DATA before including bpf_helpers.h and then you can still use bpf_printk() helper macro.
> >
>
> Thank you! That's really helpful. Is there any collection of up-to-date documentation and best practices in writing bpf code (without skeletons) besides the sources in libbpf/libbpf-bootstrap, iovisor /libbpf-tools and linux/tools/testing/selftests/bpf ?

There are also various blog posts on the Internet. I tried to do my
part with CO-RE at [0], but I don't think there is any single
documentation that captures all possible issues in one place (and I
don't think it's possible, there are just way too many variables to
anticipate all possible problems).

  [0] https://nakryiko.com/posts/bpf-core-reference-guide/

>
>
> >
> > > On the development machine, it works fine. But on the target machine, loading the program fails: libbpf: load bpf program failed: Invalid argument (full libbpf log see below).
> > > When compiling the programs on the target machine without using CO:RE, I get a similar error (invalid argument, -22).
> > > What could be the problem? I don't think the eBPF program uses anything that is available on Kernel 5.4.0 and not available on the system with Kernel 4.18, does it?
> > >
> > > Thanks in advance for your help.
> > > Best
> > > Dennis
> > >
> > >
> > >
> > >
> > > ============ log ============
> > >
> > > sudo ./ebpf
> > > libbpf: loading main.bpf.o
> > > [...]
> > > libbpf: CO-RE relocating [0] struct pt_regs: found target candidate
> > > [201] struct pt_regs in [vmlinux]
> > > libbpf: prog 'trace_func_entry': relo #0: kind <byte_off> (0), spec is
> > > [2] struct pt_regs.di (0:14 @ offset 112)
> > > libbpf: prog 'trace_func_entry': relo #0: matching candidate #0 [201]
> > > struct pt_regs.di (0:14 @ offset 112)
> > > libbpf: prog 'trace_func_entry': relo #0: patched insn #2 (ALU/ALU64)
> > > imm 112 -> 112
> > > libbpf: prog 'trace_func_entry': relo #1: kind <byte_off> (0), spec is
> > > [2] struct pt_regs.si (0:13 @ offset 104)
> > > libbpf: prog 'trace_func_entry': relo #1: matching candidate #0 [201]
> > > struct pt_regs.si (0:13 @ offset 104)
> > > libbpf: prog 'trace_func_entry': relo #1: patched insn #9 (ALU/ALU64)
> > > imm 104 -> 104
> > > libbpf: sec 'kretprobe/': found 1 CO-RE relocations
> > > libbpf: prog 'trace_func_exit': relo #0: kind <byte_off> (0), spec is
> > > [2] struct pt_regs.ax (0:10 @ offset 80)
> > > libbpf: prog 'trace_func_exit': relo #0: matching candidate #0 [201]
> > > struct pt_regs.ax (0:10 @ offset 80)
> > > libbpf: prog 'trace_func_exit': relo #0: patched insn #2 (ALU/ALU64)
> > > imm 80 -> 80
> >
> > CO-RE relocations succeeded, btf_custom_path worked, the problem is not in CO-RE.
> >
> > > libbpf: load bpf program failed: Invalid argument
> > > libbpf: failed to load program 'trace_func_entry'
> >
> > I suspect this is due to your target machine running Ubuntu 18.10.
> > Ubuntu has infamous problem with reporting kernel version through
> > uname() syscall. I've just improved libbpf's detection of it few days ago (see [0]), but it didn't yet make it into Github mirror of libbpf.
> > I'm going to start the sync right now, but you can manually specify correct version code with bpf_object__set_kversion() as you already realized. See how I do that in my patch [0], you can do that manually as well.
> >
> >   [0] https://urldefense.com/v3/__https://patchwork.kernel.org/project/netdevbpf/patch/20211222231003.2334940-1-andrii@kernel.org/__;!!MeVeBiz6!5PZT7QBM-W93AhbZnRJ3kmTO4JyBUiapxeJrPCl4k4gKHidI5Ri0WQp19MbBDFM_zuNNKA$
>
> That's it, thank you very much!
>
> I just added
>         __u32 currKernelVersion = get_kernel_version();
>         bpf_object__set_kversion(main_bpf_obj, currKernelVersion)
> with get_kernel_version() from libbpf.c and your patch [0] and now it is working. :)
>

Great, once [1] is merged (I'll need to fix up selftests first),
libbpf will be able to deal with this Ubuntu quirk automatically and
you'll never know it existed.

  [1] https://github.com/libbpf/libbpf/pull/435

> However, there is something I do not understand:
> (a): Why did it work on the development machine in the first place with Ubuntu 20.04?
>         - the old get_kernel_version() returned 328704 (5.4.0), the new version returns 328852 (5.4.148) so there already is a missmatch. (and I did not call it, so libbpf set the kernel version to 0?)

You dev machine has recent enough kernel that doesn't check kernel
version anymore, so it doesn't matter that Ubuntu reports the wrong
one.

>         - on the target machine, it is 266752 (4.2.0) vs. 266772 (4.2.4)
> (b): I use a uProbe. Why is the bpf program type kProbe? Is it just for usability of libbpf as for a uProbe the user must specify the address while for a kprobe only the symbol is required?

4.2 is old enough where kernel version has to match and it didn't.


> (c): Why does the kernel version matter at all?
>
> It would be really nice if you could answer these questions as well or point me to a source.
>
> Best
> Dennis
>
> [...]
>
