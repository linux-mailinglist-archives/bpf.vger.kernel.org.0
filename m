Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6966B2ED672
	for <lists+bpf@lfdr.de>; Thu,  7 Jan 2021 19:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbhAGSND (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jan 2021 13:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbhAGSND (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 13:13:03 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B32C0612F9
        for <bpf@vger.kernel.org>; Thu,  7 Jan 2021 10:12:22 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ga15so11010935ejb.4
        for <bpf@vger.kernel.org>; Thu, 07 Jan 2021 10:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=araalinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ki6iEKaf9mGTwBPKClYrgz6N5E4xoSuWvuQbYgF+P0=;
        b=pwrv77g8OFNuOhLJQpre2UrSnZmUcE1nhQwcQVPZf/E/1iXZNWqpQngJjbqmFV6Vx7
         fPhkCC75hmfBpRL163WCJQrQvnzKQ+NV8fHHbqCSilhf06fzZP7YbtzawVvUYAVDKwDR
         br5NJ5iFhB9PItjFi26BbH+n0WeWu5/5IQVb47waonREQrC2ri076H8UJXo+57rH/XRc
         sOXNkYMkUFhus8SyOc9X6I4InR/yjiLW9j+ikr8NQ9bFz/Fj4NGYkPlW5ZIX1iJaClwJ
         Lr16IW1JpnI8cTf8VqzR8de3VWZPfDRwiyXjAA9ieC69nGStjkAUydJHPBi8QxgGfRes
         dTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ki6iEKaf9mGTwBPKClYrgz6N5E4xoSuWvuQbYgF+P0=;
        b=rN/Pp0auvAeUAesfLN4bNHpyfh8BuIoyKPAIDirIeCE5YUjm2h8TYw41DkS5LkS2KK
         I3hJkm4P+NvrmkmBGcL7USG8p044SW7iBtk9QA4Ft1bvvroJYnKAdqan9JUtLxXI2iN0
         gTaI7j3+/JRzeCQF/fzYzwmXAEcb0oHYIM2sjFjeRCglAEkJhc8otMpiYIPq6LkDG/JX
         1iDv95sk0O0kgVc/s5Xjr3rgBUiQf6o0/GCoVCrZD2IRaH4SncUsDunTuLYoO/o16dOb
         b/7s9nyIPYkQi2KBbz1NXPbo8TjJ9RN5OVbm+ti4vvrsCjNtohAGduL++k+ohqeLbzLW
         3TPQ==
X-Gm-Message-State: AOAM531hcg7tATUYK1oy/JbAVmDKUaUJnYck82sIRcTFyDHK9DRW8dEp
        AaUSxSscZZxvlPUcj+LG4XlGDlxOfmQ53DU87+VW5Q==
X-Google-Smtp-Source: ABdhPJyEOd8XIg3bfbY01DdW686YIhJafWa5EIEOcZXTuv+iyfqeyvKs8NZS8OiqDTqJ9Lg0byuUHxkUVwhGlu0NV7c=
X-Received: by 2002:a17:906:52d9:: with SMTP id w25mr9895ejn.504.1610043141341;
 Thu, 07 Jan 2021 10:12:21 -0800 (PST)
MIME-Version: 1.0
References: <CADmGQ+1euj7Uv9e8UyZMMXDiYAKqXe9=GSTBFNbbg1E0R-ejyg@mail.gmail.com>
 <CAEf4BzbJZLjNoiK8_VfeVg_Vrg=9iYFv+po-38SMe=UzwDKJ=Q@mail.gmail.com>
In-Reply-To: <CAEf4BzbJZLjNoiK8_VfeVg_Vrg=9iYFv+po-38SMe=UzwDKJ=Q@mail.gmail.com>
From:   Vamsi Kodavanty <vamsi@araalinetworks.com>
Date:   Thu, 7 Jan 2021 10:12:10 -0800
Message-ID: <CADmGQ+1ugPF-n1KnbVpOmC=xiOG_57GyS+0NetfsPz99HxS36A@mail.gmail.com>
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First of all thank you very much for your quick response. And helpful pointers.
It seems like you also think what I am attempting to do should work.

Please see inline [VAMSI-2].

On Wed, Jan 6, 2021 at 3:55 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jan 6, 2021 at 10:04 AM Vamsi Kodavanty
> <vamsi@araalinetworks.com> wrote:
> >
> > Had a few questions on CO-RE dependencies and usage. From what I read
> > CO-RE needs a supported kernel version and be compiled with
> > `CONFIG_DEBUG_INFO_BTF=y`.
> >
> > I also understand there are three pieces to enable CO-RE
> > functionality. (1) The BTF format. For efficient/compressed kernel
> > symbol table. (2) clang changes to emit the BTF relocations. (3)
>
> BTF is not really a symbol table, rather a type information. Like
> simpler and more compact DWARF.
>
> > `libbpf` changes to locate a BTF file and fix-up relocations. Once
> > these 3 steps are done the resulting byte code is no different from
> > non-CO-RE byte code.
> >
> > Given this I am hoping the knowledgeable folks on this mailer correct
> > and guide me if I am stating something incorrectly.
> >
> > (1) Is the kernel support requirement ONLY for the purposes of
> > generating and exposing the BTF file information on
> > `/sys/kernel/btf/vmlinux`? So that the eBPF CO-RE applications
> > `libbpf` can find the BTF information at a standard location?.
>
> /sys/kernel/btf/vmlinux is a standardized place, but libbpf will also
> try to search for vmlinux image (and BTF info within it) in a few
> standard locations, see [0]. Early versions of in-kernel BTF didn't
> even expose /sys/kernel/btf/vmlinux.
>
>   [0] https://github.com/libbpf/libbpf/blob/master/src/btf.c#L4580
>
> >
> > (2) If the answer to the above question is YES. Could the below
> > mechanism be used so that it works on all kernels whether they support
> > the `CONFIG_DEBUG_INFO_BTF` flag or not?.
> >        (a) Extract BTF generation process outside of the kernel build.
> > Use this to generate the equivalent BTF file for it.
>
> Yes, CONFIG_DEBUG_INFO_BTF=y is the most convenient way to add BTF
> info, but it's also possible to just embed BTF manually with a direct
> invocation of pahole -J, see [1] on how it's done for
> CONFIG_DEBUG_INFO_BTF. You can do that for *any* kernel image, no
> matter the version, and it will work with CO-RE relocations.
>
>   [1] https://github.com/torvalds/linux/blob/master/scripts/link-vmlinux.sh#L137-L170
>

[VAMSI-2] Yes, this is exactly what I did. I extracted out the
`gen_btf` from the
`link-vmlinux.sh` (which uses pahole -J) and used it to generate a BTF
file for the
4.14.0 kernel.

> >        (b) Make changes to `libbpf` to look for BTF not only at the
> > standard locations but also at a user specified location. The BTF file
> > generated in (a) can be presented here.
>
> You can already do that, actually, though it's not very obvious. You
> can specify (or override) kernel BTF location by using
> bpf_object__load_xattr() and passing target_btf_path pointing to your
> BTF location (see [2]). I've been meaning to add it instead to a
> bpf_object_open_opts, btw, to make its use possible with a BPF
> skeleton. Also keep in mind that currently libbpf expects that custom
> BTF to be an ELF file with .BTF section, not just a raw BTF data. But
> we can improve that, of course.
>
>   [2] https://github.com/libbpf/libbpf/blob/master/src/libbpf.h#L136-L141

[VAMSI-2] I took a look at this and what you suggested above does not
work as is.
Even if we used `bpf_object__load_xattr` with `target_btf_path`. It seems like
`bpf_object__load_vmlinux_btf` is not yet modified to use the
`target_btf_path` attribute.
Only, the `bpf_object__relocate` looks at the `target_btf_path`. As
you suggested enabling
use from the BPF skeleton seems useful and I can possibly help with that.

For now, just for proof of concept I modified the search options in
`libbpf_find_kernel_btf` to
include my custom path. And on a 4.14 AmazonLinux2 VM I observe these failures.

libbpf: loading kernel BTF '/home/ec2-user/vmlinux.btf': 0
libbpf: Kernel doesn't support BTF, skipping uploading it.
libbpf: kernel doesn't support global data
libbpf: failed to load object 'tcpconnect_bpf'
libbpf: failed to load BPF skeleton 'tcpconnect_bpf': -95
failed to load BPF object: -95

This is the reason I had posted on the mailer. If the CO-RE executable
has relocations
resolved by the time of the BPF load. Why do we need to check for
kernel support?. Also,
does this mean what I am attempting to do will not work?.

Best Regards. And again thanks a lot for your precious time.
- Vamsi.

> >
> > This should provide us a way to enable CO-RE functionality on older
> > kernel versions as well. I tried to make the above changes and tried
> > against a 4.14 kernel and it did not work. Either I am not doing
> > something right or my assumptions are wrong.
> >
> > Thanks in advance for your time. And I hope someone here can guide me
> > in the right direction.
> >
> > Regards
> > Vamsi.
