Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925B82ED6F8
	for <lists+bpf@lfdr.de>; Thu,  7 Jan 2021 19:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAGSw4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jan 2021 13:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbhAGSw4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 13:52:56 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3888C0612F4
        for <bpf@vger.kernel.org>; Thu,  7 Jan 2021 10:52:15 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id w127so7045677ybw.8
        for <bpf@vger.kernel.org>; Thu, 07 Jan 2021 10:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OsHqO2XQdnnb94wfdTvh3x9KEpm0rAc23B75Nwbw9XQ=;
        b=vKtLTeldP/DwsON9gMQv5eeblBvD88+4l8TslrrPsso3m05ZOqjeRE9n2AwmbTtLov
         ZXdbgYWlVc2Zy54K6W6ZFvZCVJ9JzIUq+KrMcK8B40SVnRtwbY/eHK3yANdy9quEyvvX
         JYl7ZecS76pu+tV1cVClbccTS9RQuR1DLJfO+kNorV1PWgRuTm+7XbSCJtEfD1QTOKB3
         ec8NFaW7LCPR88kA4I92vV4Hj4JzgVIsPOJphVTEEiWhRrOe72agVLZRe4ZGFVKD4vH5
         6kEGmd2XKym7XfI3cbxXE+tVMQCB5gp57OCQJXt+b9BWdII7IMXLNQSNs5zvZXTOqLRN
         N24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OsHqO2XQdnnb94wfdTvh3x9KEpm0rAc23B75Nwbw9XQ=;
        b=l2VD0lcNPUCq9gLxrqLpq49QcgGEva11B31uvUmJ8WRygq6b5e6c9JUHdF1IJfz501
         H56kCOpy8IKDN3ubicGnwRNX7b0A7mQzCIKX0VdskRCttGVUB8e7qe7dEYXbsxipmTZo
         Nkk2FZh9ISkFDMNXOqLQCWEk35wj3S8O+gNkO5i9PT8ButTMWChEbo3IdG08I3zlXgDx
         ZwQwrGtqhIlTiSRAEhqpSqSyiROnD9wQlVoLDOYnDKGWRzCIabq1neX68xi52U5eptza
         htvZuGXwZvZGXwWc0kLaMuP1vsLr6eOCppXP/enw0Vp7FoLDMkW+Rrid5iMTPyqLmiw2
         0Fgg==
X-Gm-Message-State: AOAM531EYLRV2RpklfV85CdCpfNyvXdeSEOa6+krNSAxGvW/GlidLc8U
        m1Ulc3PUZQYE2H7Dpdw28h7bXvFjby656IQ3epc=
X-Google-Smtp-Source: ABdhPJxj8uyav3y315zNelmjPuutpD8d7k4sc769iW3LlRFkTrkdbbD8zyLYpxNrx1ahztDHbuunks8RlxodlE0LuX4=
X-Received: by 2002:a25:2c4c:: with SMTP id s73mr288853ybs.230.1610045535027;
 Thu, 07 Jan 2021 10:52:15 -0800 (PST)
MIME-Version: 1.0
References: <CADmGQ+1euj7Uv9e8UyZMMXDiYAKqXe9=GSTBFNbbg1E0R-ejyg@mail.gmail.com>
 <CAEf4BzbJZLjNoiK8_VfeVg_Vrg=9iYFv+po-38SMe=UzwDKJ=Q@mail.gmail.com> <CADmGQ+1ugPF-n1KnbVpOmC=xiOG_57GyS+0NetfsPz99HxS36A@mail.gmail.com>
In-Reply-To: <CADmGQ+1ugPF-n1KnbVpOmC=xiOG_57GyS+0NetfsPz99HxS36A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 7 Jan 2021 10:52:04 -0800
Message-ID: <CAEf4BzbpOVKLKq+Cz5kWNZHu-yNG9BsY4udOU+md_zdoT7sG1A@mail.gmail.com>
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
To:     Vamsi Kodavanty <vamsi@araalinetworks.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 7, 2021 at 10:12 AM Vamsi Kodavanty
<vamsi@araalinetworks.com> wrote:
>
> First of all thank you very much for your quick response. And helpful pointers.
> It seems like you also think what I am attempting to do should work.
>
> Please see inline [VAMSI-2].
>
> On Wed, Jan 6, 2021 at 3:55 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jan 6, 2021 at 10:04 AM Vamsi Kodavanty
> > <vamsi@araalinetworks.com> wrote:
> > >
> > > Had a few questions on CO-RE dependencies and usage. From what I read
> > > CO-RE needs a supported kernel version and be compiled with
> > > `CONFIG_DEBUG_INFO_BTF=y`.
> > >
> > > I also understand there are three pieces to enable CO-RE
> > > functionality. (1) The BTF format. For efficient/compressed kernel
> > > symbol table. (2) clang changes to emit the BTF relocations. (3)
> >
> > BTF is not really a symbol table, rather a type information. Like
> > simpler and more compact DWARF.
> >
> > > `libbpf` changes to locate a BTF file and fix-up relocations. Once
> > > these 3 steps are done the resulting byte code is no different from
> > > non-CO-RE byte code.
> > >
> > > Given this I am hoping the knowledgeable folks on this mailer correct
> > > and guide me if I am stating something incorrectly.
> > >
> > > (1) Is the kernel support requirement ONLY for the purposes of
> > > generating and exposing the BTF file information on
> > > `/sys/kernel/btf/vmlinux`? So that the eBPF CO-RE applications
> > > `libbpf` can find the BTF information at a standard location?.
> >
> > /sys/kernel/btf/vmlinux is a standardized place, but libbpf will also
> > try to search for vmlinux image (and BTF info within it) in a few
> > standard locations, see [0]. Early versions of in-kernel BTF didn't
> > even expose /sys/kernel/btf/vmlinux.
> >
> >   [0] https://github.com/libbpf/libbpf/blob/master/src/btf.c#L4580
> >
> > >
> > > (2) If the answer to the above question is YES. Could the below
> > > mechanism be used so that it works on all kernels whether they support
> > > the `CONFIG_DEBUG_INFO_BTF` flag or not?.
> > >        (a) Extract BTF generation process outside of the kernel build.
> > > Use this to generate the equivalent BTF file for it.
> >
> > Yes, CONFIG_DEBUG_INFO_BTF=y is the most convenient way to add BTF
> > info, but it's also possible to just embed BTF manually with a direct
> > invocation of pahole -J, see [1] on how it's done for
> > CONFIG_DEBUG_INFO_BTF. You can do that for *any* kernel image, no
> > matter the version, and it will work with CO-RE relocations.
> >
> >   [1] https://github.com/torvalds/linux/blob/master/scripts/link-vmlinux.sh#L137-L170
> >
>
> [VAMSI-2] Yes, this is exactly what I did. I extracted out the
> `gen_btf` from the
> `link-vmlinux.sh` (which uses pahole -J) and used it to generate a BTF
> file for the
> 4.14.0 kernel.
>
> > >        (b) Make changes to `libbpf` to look for BTF not only at the
> > > standard locations but also at a user specified location. The BTF file
> > > generated in (a) can be presented here.
> >
> > You can already do that, actually, though it's not very obvious. You
> > can specify (or override) kernel BTF location by using
> > bpf_object__load_xattr() and passing target_btf_path pointing to your
> > BTF location (see [2]). I've been meaning to add it instead to a
> > bpf_object_open_opts, btw, to make its use possible with a BPF
> > skeleton. Also keep in mind that currently libbpf expects that custom
> > BTF to be an ELF file with .BTF section, not just a raw BTF data. But
> > we can improve that, of course.
> >
> >   [2] https://github.com/libbpf/libbpf/blob/master/src/libbpf.h#L136-L141
>
> [VAMSI-2] I took a look at this and what you suggested above does not
> work as is.
> Even if we used `bpf_object__load_xattr` with `target_btf_path`. It seems like
> `bpf_object__load_vmlinux_btf` is not yet modified to use the
> `target_btf_path` attribute.

Ah, right. We used to need vmlinux BTF only for CO-RE relocations, but
since then added a bunch more use cases. So some libbpf changes are
needed to make this work. But it should still work for CO-RE to have a
custom BTF.

I'm not sure about making bpf_object__load_vmlinux_btf() load custom
BTF as the real kernel BTF, because that will never work for
fentry/fexit, struct_ops, etc. I think it is better to teach
bpf_object__load_vmlinux_btf() to not attempt to load real kernel BTF
if we need it only for CO-RE relocations *and* we have it overloaded
with target_btf_path

> Only, the `bpf_object__relocate` looks at the `target_btf_path`. As
> you suggested enabling
> use from the BPF skeleton seems useful and I can possibly help with that.

Yeah, adding something like core_btf_path option to
bpf_object_open_opts would go nicely with this change.

>
> For now, just for proof of concept I modified the search options in
> `libbpf_find_kernel_btf` to
> include my custom path. And on a 4.14 AmazonLinux2 VM I observe these failures.
>
> libbpf: loading kernel BTF '/home/ec2-user/vmlinux.btf': 0

so here you successfully loaded custom BTF, which is good.

> libbpf: Kernel doesn't support BTF, skipping uploading it.

this just means that your BPF object's BTF won't be loaded into the
kernel. That's no big deal, ignore this.

> libbpf: kernel doesn't support global data

But this means that your BPF programs rely on global variables, which
are not supported by the kernel. So you need to change the code to not
use global variables to make this work on very old kernels.


> libbpf: failed to load object 'tcpconnect_bpf'
> libbpf: failed to load BPF skeleton 'tcpconnect_bpf': -95
> failed to load BPF object: -95

This is probably OPNOTSUPP from the global data above

>
> This is the reason I had posted on the mailer. If the CO-RE executable
> has relocations
> resolved by the time of the BPF load. Why do we need to check for
> kernel support?. Also,
> does this mean what I am attempting to do will not work?.
>

it will work with minimal libbpf logic changes. Nothing in principle
prevents this.


> Best Regards. And again thanks a lot for your precious time.
> - Vamsi.
>
> > >
> > > This should provide us a way to enable CO-RE functionality on older
> > > kernel versions as well. I tried to make the above changes and tried
> > > against a 4.14 kernel and it did not work. Either I am not doing
> > > something right or my assumptions are wrong.
> > >
> > > Thanks in advance for your time. And I hope someone here can guide me
> > > in the right direction.
> > >
> > > Regards
> > > Vamsi.
