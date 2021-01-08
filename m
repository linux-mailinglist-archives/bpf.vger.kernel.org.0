Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E262EEAF7
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 02:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbhAHBcE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jan 2021 20:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbhAHBcE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 20:32:04 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D148C0612F4
        for <bpf@vger.kernel.org>; Thu,  7 Jan 2021 17:31:24 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id d17so12355292ejy.9
        for <bpf@vger.kernel.org>; Thu, 07 Jan 2021 17:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=araalinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEQqSaji7x4g9sJP714WqIXWe2yFgkV8N/hJleIjVrU=;
        b=rEF0qRv8sYGS3gcaW978YXrvkXgRODH4WX5530dGLUvgI0qIqHXhmHADhe/SkqXgEN
         i0/dPUKqUUs5D9HKww2ZfaalfTdjsQJfj13wvJkZw1buNxpOYoZsiDOLn3Dh8xxQB8JD
         rKiA67XVrsSPYYWwl6wecaNGAWV7Cf/Q0GB/093c5Aj/YPKHbRx9f2y2CzKQ8uikcU7L
         h1u9kjtB8+QxLGOOfIS+JljquInj/fRQAQPcUOuXBnOG+uVpkyXFP6LPAQUi4BzsYY2+
         aQvOUXP1HvKK5l/cRwtPt07004x258AyPyhUyDQCAvx43aYTLb0Qn3fZHWib7vFgblA8
         qTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEQqSaji7x4g9sJP714WqIXWe2yFgkV8N/hJleIjVrU=;
        b=DkgLDt0/vhYSvj59NsydBWfQXvzkXShmAFIRnQqwrY7lAHGrPKFPOq2NqI2//mME72
         suHXvvibCR1N/J5+fh/so3aKimO9mMfqsP/GzbNTskZxMUqX7WoaeVKErFoezrOlR1+9
         Zpmi80+p42BXPUXIQ0hCxh/+gHIhgPTk95uIRrHRH7YXtTHukDJRnJmer1FxDKg8ZeRq
         4zePylpNbB7FjhndpSCu03Y6o0PtWk/Ubf9BM36kldWfcLLoee25SyVEG5S7GM8Go1Eu
         rQv5W8CifOyMM2+oIklIfE9ZPSB3cZhF12lalRktjFjzAX7bcwRqL3WGGPn1suHZVFO/
         JDYg==
X-Gm-Message-State: AOAM530iJIgsIqxi7liKexHYBnK/51vbPrd+s368yemdQm/6x1yOoVAA
        LcIZ/EJ1hP2Cgkk8W8MOBoWOOkWGUqnJfe0dmqVydg==
X-Google-Smtp-Source: ABdhPJxF0ZK9sYhIiuNMF0kACyzqjbPfx1x7EILcjG1GXZLKsjdRbReLuKOSiQEFBjet2ct11rZ9OvRCa7K2AlXZPIs=
X-Received: by 2002:a17:906:af75:: with SMTP id os21mr1123591ejb.330.1610069482833;
 Thu, 07 Jan 2021 17:31:22 -0800 (PST)
MIME-Version: 1.0
References: <CADmGQ+1euj7Uv9e8UyZMMXDiYAKqXe9=GSTBFNbbg1E0R-ejyg@mail.gmail.com>
 <CAEf4BzbJZLjNoiK8_VfeVg_Vrg=9iYFv+po-38SMe=UzwDKJ=Q@mail.gmail.com>
 <CADmGQ+1ugPF-n1KnbVpOmC=xiOG_57GyS+0NetfsPz99HxS36A@mail.gmail.com>
 <CAEf4BzbpOVKLKq+Cz5kWNZHu-yNG9BsY4udOU+md_zdoT7sG1A@mail.gmail.com>
 <CADmGQ+0UFDY2Eb_xbcsrPKDmoD8ri1ufZ4Mp3YiMo8AW-X=zgw@mail.gmail.com>
 <CAEf4BzYtOYuZnVnvi_12xR+EEKddQmMM891rWHGsSgwzt473VA@mail.gmail.com> <CADmGQ+294Fx7Z2xJzLwxFqsFvoEkY0_CjrUff3XvjrReHtKcYw@mail.gmail.com>
In-Reply-To: <CADmGQ+294Fx7Z2xJzLwxFqsFvoEkY0_CjrUff3XvjrReHtKcYw@mail.gmail.com>
From:   Vamsi Kodavanty <vamsi@araalinetworks.com>
Date:   Thu, 7 Jan 2021 17:31:11 -0800
Message-ID: <CADmGQ+0dDjfs6UL63m3vLAfu+GHgSFdMO+Rmz_jk+0R9Wva2Tw@mail.gmail.com>
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 7, 2021 at 4:16 PM Vamsi Kodavanty <vamsi@araalinetworks.com> wrote:
>
> On Thu, Jan 7, 2021 at 3:32 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jan 7, 2021 at 2:45 PM Vamsi Kodavanty <vamsi@araalinetworks.com> wrote:
> > >
> > > Andrii,
> > >     Thank you so much for the quick response. You were right. I was
> > > trying to CO-RE the `tcpconnect.py` program. It had some `.rodata`
> > > which I removed. Now the program goes much further. It now finishes
> > > the relocations successfully. But, fails at the next step
> > > `bpf_object__load_progs`.
> >
> > It's discouraged to use top posting on the mailing list. So for the
> > future please reply inline.
> >
>
> [VAMSI-3] Apologies. Will be mindful next time on.
>
> >
> > >
> > > ===
> > > libbpf: prog 'tcp_v6_connect_ret': relo #3: patched insn #50
> > > (ALU/ALU64) imm 56 -> 56
> > > libbpf: failed to open '/sys/bus/event_source/devices/kprobe/type': No
> > > such file or directory
> > > libbpf: failed to determine kprobe perf type: No such file or directory
> > > libbpf: prog 'tcp_v4_connect': failed to create kprobe
> > > 'tcp_v4_connect' perf event: No such file or directory
> > > libbpf: failed to auto-attach program 'tcp_v4_connect': -2
> > > ===
> > >
> > > This host has a 4.14 kernel AmazonLinux2 and does not have the above
> > > file. It instead has this
> > >
> > > ===
> > > $ sudo cat /sys/kernel/debug/tracing/kprobe_events
> > > p:kprobes/p_sys_execve_bcc_2566 sys_execve
> > > ===
> > >
> >
> > Right. Libbpf only supports a newer and safer way to attach to
> > kprobes. For your experiments, try to stick to tracepoints and you'll
> > have a better time.
> >
> > But it's another thing I've been meaning to add to libbpf for
> > supporting older kernels. I even have code written to do legacy kprobe
> > attachment, just need to find time to send a patch to add it as a
> > fallback for kernels that don't support new kprobe interface.
> >
>
> [VAMSI-3] I think that will be very helpful, as there are bound to be hosts
> with older kernels for the foreseeable future. Good to know it's being
> considered.
>
> >
> > > I am guessing this is a backward compatibility issue?. I will try to
> > > look at an earlier version of libbpf to see how this was handled.
> >
> > it was never supported by libbpf. BCC support both old and new APIs,
> > but old APIs is more dangerous, as it's easy to leave attached kprobe
> > BPF program active in the kernel unintentionally. E.g., if the process
> > crashes. But with bpf_link and its expected use of
> > bpf_link__destroy(), we can support the legacy API (it won't be any
> > safer, but still).
> >
>
> [VAMSI-3] Will use tracepoints to validate the process as you suggested. I
> will then try to see what I can do to use this on kprobe/kretprobe's. Will also
> check how BCC does this. I will start a new thread if needed.
>

[VAMSI-4] Just to round up this thread. The tracepoints did work out
of the box.
I tried the `execsnoop` tool and it worked fine.

Thank you again.
Vamsi.

> Again appreciate the inputs and direction very much.
>
> Best Regards
> Vamsi.
>
> > > Meanwhile, if you have further comments they are appreciated.
> > >
> > > And again I can't thank you enough for how helpful you have been and
> > > your time. Cheers!.
> > >
> > >
> > >
> > >
> > > On Thu, Jan 7, 2021 at 10:52 AM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Jan 7, 2021 at 10:12 AM Vamsi Kodavanty
> > > > <vamsi@araalinetworks.com> wrote:
> > > > >
> > > > > First of all thank you very much for your quick response. And helpful pointers.
> > > > > It seems like you also think what I am attempting to do should work.
> > > > >
> > > > > Please see inline [VAMSI-2].
> > > > >
> > > > > On Wed, Jan 6, 2021 at 3:55 PM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Jan 6, 2021 at 10:04 AM Vamsi Kodavanty
> > > > > > <vamsi@araalinetworks.com> wrote:
> > > > > > >
> > > > > > > Had a few questions on CO-RE dependencies and usage. From what I read
> > > > > > > CO-RE needs a supported kernel version and be compiled with
> > > > > > > `CONFIG_DEBUG_INFO_BTF=y`.
> > > > > > >
> > > > > > > I also understand there are three pieces to enable CO-RE
> > > > > > > functionality. (1) The BTF format. For efficient/compressed kernel
> > > > > > > symbol table. (2) clang changes to emit the BTF relocations. (3)
> > > > > >
> > > > > > BTF is not really a symbol table, rather a type information. Like
> > > > > > simpler and more compact DWARF.
> > > > > >
> > > > > > > `libbpf` changes to locate a BTF file and fix-up relocations. Once
> > > > > > > these 3 steps are done the resulting byte code is no different from
> > > > > > > non-CO-RE byte code.
> > > > > > >
> > > > > > > Given this I am hoping the knowledgeable folks on this mailer correct
> > > > > > > and guide me if I am stating something incorrectly.
> > > > > > >
> > > > > > > (1) Is the kernel support requirement ONLY for the purposes of
> > > > > > > generating and exposing the BTF file information on
> > > > > > > `/sys/kernel/btf/vmlinux`? So that the eBPF CO-RE applications
> > > > > > > `libbpf` can find the BTF information at a standard location?.
> > > > > >
> > > > > > /sys/kernel/btf/vmlinux is a standardized place, but libbpf will also
> > > > > > try to search for vmlinux image (and BTF info within it) in a few
> > > > > > standard locations, see [0]. Early versions of in-kernel BTF didn't
> > > > > > even expose /sys/kernel/btf/vmlinux.
> > > > > >
> > > > > >   [0] https://github.com/libbpf/libbpf/blob/master/src/btf.c#L4580
> > > > > >
> > > > > > >
> > > > > > > (2) If the answer to the above question is YES. Could the below
> > > > > > > mechanism be used so that it works on all kernels whether they support
> > > > > > > the `CONFIG_DEBUG_INFO_BTF` flag or not?.
> > > > > > >        (a) Extract BTF generation process outside of the kernel build.
> > > > > > > Use this to generate the equivalent BTF file for it.
> > > > > >
> > > > > > Yes, CONFIG_DEBUG_INFO_BTF=y is the most convenient way to add BTF
> > > > > > info, but it's also possible to just embed BTF manually with a direct
> > > > > > invocation of pahole -J, see [1] on how it's done for
> > > > > > CONFIG_DEBUG_INFO_BTF. You can do that for *any* kernel image, no
> > > > > > matter the version, and it will work with CO-RE relocations.
> > > > > >
> > > > > >   [1] https://github.com/torvalds/linux/blob/master/scripts/link-vmlinux.sh#L137-L170
> > > > > >
> > > > >
> > > > > [VAMSI-2] Yes, this is exactly what I did. I extracted out the
> > > > > `gen_btf` from the
> > > > > `link-vmlinux.sh` (which uses pahole -J) and used it to generate a BTF
> > > > > file for the
> > > > > 4.14.0 kernel.
> > > > >
> > > > > > >        (b) Make changes to `libbpf` to look for BTF not only at the
> > > > > > > standard locations but also at a user specified location. The BTF file
> > > > > > > generated in (a) can be presented here.
> > > > > >
> > > > > > You can already do that, actually, though it's not very obvious. You
> > > > > > can specify (or override) kernel BTF location by using
> > > > > > bpf_object__load_xattr() and passing target_btf_path pointing to your
> > > > > > BTF location (see [2]). I've been meaning to add it instead to a
> > > > > > bpf_object_open_opts, btw, to make its use possible with a BPF
> > > > > > skeleton. Also keep in mind that currently libbpf expects that custom
> > > > > > BTF to be an ELF file with .BTF section, not just a raw BTF data. But
> > > > > > we can improve that, of course.
> > > > > >
> > > > > >   [2] https://github.com/libbpf/libbpf/blob/master/src/libbpf.h#L136-L141
> > > > >
> > > > > [VAMSI-2] I took a look at this and what you suggested above does not
> > > > > work as is.
> > > > > Even if we used `bpf_object__load_xattr` with `target_btf_path`. It seems like
> > > > > `bpf_object__load_vmlinux_btf` is not yet modified to use the
> > > > > `target_btf_path` attribute.
> > > >
> > > > Ah, right. We used to need vmlinux BTF only for CO-RE relocations, but
> > > > since then added a bunch more use cases. So some libbpf changes are
> > > > needed to make this work. But it should still work for CO-RE to have a
> > > > custom BTF.
> > > >
> > > > I'm not sure about making bpf_object__load_vmlinux_btf() load custom
> > > > BTF as the real kernel BTF, because that will never work for
> > > > fentry/fexit, struct_ops, etc. I think it is better to teach
> > > > bpf_object__load_vmlinux_btf() to not attempt to load real kernel BTF
> > > > if we need it only for CO-RE relocations *and* we have it overloaded
> > > > with target_btf_path
> > > >
> > > > > Only, the `bpf_object__relocate` looks at the `target_btf_path`. As
> > > > > you suggested enabling
> > > > > use from the BPF skeleton seems useful and I can possibly help with that.
> > > >
> > > > Yeah, adding something like core_btf_path option to
> > > > bpf_object_open_opts would go nicely with this change.
> > > >
> > > > >
> > > > > For now, just for proof of concept I modified the search options in
> > > > > `libbpf_find_kernel_btf` to
> > > > > include my custom path. And on a 4.14 AmazonLinux2 VM I observe these failures.
> > > > >
> > > > > libbpf: loading kernel BTF '/home/ec2-user/vmlinux.btf': 0
> > > >
> > > > so here you successfully loaded custom BTF, which is good.
> > > >
> > > > > libbpf: Kernel doesn't support BTF, skipping uploading it.
> > > >
> > > > this just means that your BPF object's BTF won't be loaded into the
> > > > kernel. That's no big deal, ignore this.
> > > >
> > > > > libbpf: kernel doesn't support global data
> > > >
> > > > But this means that your BPF programs rely on global variables, which
> > > > are not supported by the kernel. So you need to change the code to not
> > > > use global variables to make this work on very old kernels.
> > > >
> > > >
> > > > > libbpf: failed to load object 'tcpconnect_bpf'
> > > > > libbpf: failed to load BPF skeleton 'tcpconnect_bpf': -95
> > > > > failed to load BPF object: -95
> > > >
> > > > This is probably OPNOTSUPP from the global data above
> > > >
> > > > >
> > > > > This is the reason I had posted on the mailer. If the CO-RE executable
> > > > > has relocations
> > > > > resolved by the time of the BPF load. Why do we need to check for
> > > > > kernel support?. Also,
> > > > > does this mean what I am attempting to do will not work?.
> > > > >
> > > >
> > > > it will work with minimal libbpf logic changes. Nothing in principle
> > > > prevents this.
> > > >
> > > >
> > > > > Best Regards. And again thanks a lot for your precious time.
> > > > > - Vamsi.
> > > > >
> > > > > > >
> > > > > > > This should provide us a way to enable CO-RE functionality on older
> > > > > > > kernel versions as well. I tried to make the above changes and tried
> > > > > > > against a 4.14 kernel and it did not work. Either I am not doing
> > > > > > > something right or my assumptions are wrong.
> > > > > > >
> > > > > > > Thanks in advance for your time. And I hope someone here can guide me
> > > > > > > in the right direction.
> > > > > > >
> > > > > > > Regards
> > > > > > > Vamsi.
