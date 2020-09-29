Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DC627D48E
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 19:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgI2ReQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 13:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbgI2ReP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 13:34:15 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCDDC0613D0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 10:34:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s205so4702433lja.7
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 10:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gQw31JbN9r1vFvakmg6vqsptjB02uipjQeewjuzCYo=;
        b=Dj4LZUTZaMoxXiQYp1yCnL13i1u4TjHn4IcRQKlOfLg1BjfZI+RWtxkuo9VQTvLP5P
         OIs526Qbw18cMojzwKe6n0wAG3nd5eNY1oSuQGok5iuaF9ZPLy1nw5SIFDd9uTZts3TK
         Qg+Hh/Srm1LUp2HVK4uPp//n03Wp84CTWhOZcCUfDGydGTyW5/mKIo4uflV2jcH/Xnfg
         Kt4eA0BWDQKXQGemSiLDVndm2inZUjBR2jBugboAvCCg0CQX4KHa0lb6Xgo0XXWhqraV
         wJdikWnmrC+ekXxxDDkrh9UJhHviERFB8HsNkCR2bY28vv3fBr/FPLKQ3guAXPpa1pUu
         Fx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gQw31JbN9r1vFvakmg6vqsptjB02uipjQeewjuzCYo=;
        b=EESra5bkpqwQ+SOZAC5fatLO4ABR5GhvQoUDcJ5IxFBet1ToO5q0LWxNPczt/gfVT3
         sXembXkMhDjfb01rGu2+F8EnRohZdJYhazyfrj9iSkn1BDyxz580VpPrv5tkjpA/Ch+z
         +GBlkrkBGWuaWpMe/byMirXnXK6oryF+Bb27dipXD9e/IXZCDka3Nbb7cueE45ohB0Sr
         e0LRiUrxy80yrHKct9l8IfPpMH9igSkYsPTZTSvdixJ98syNkn34YKh3yFpaGEyYpWHs
         G8dzNXbiECC+JzaIEcIRBPoxxYYcpvP9m6eXSw9jsNYEArk50toD7DjKIX5zUWEWa5jb
         VRjQ==
X-Gm-Message-State: AOAM530f/iv8cJG2zBP6sYn12ejW/YgDM4pH4sqAOYo0GY0xWniR46jD
        8rgomijqInDMLAZrGtJE9cBnDYJzGnqUbHrhGHbEIw==
X-Google-Smtp-Source: ABdhPJw9ESoIBe1vVan7K9MFOZ52+odIiwjunnVR36ZIu8Jo3g92sv2VIrYAmYWZNAVbxkIoNCqRD/CEqacb0UFAclk=
X-Received: by 2002:a2e:89c8:: with SMTP id c8mr1442472ljk.163.1601400853321;
 Tue, 29 Sep 2020 10:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
 <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
 <CAEf4Bza9tZ-Jj0dj9Ne0fmxa95t=9XxxJR+Ce=6hDmw_d8uVFA@mail.gmail.com>
 <8cf42e2752e442bb54e988261d8bf3cd22ad00f2.camel@linux.ibm.com>
 <20200909142750.GC3788224@kernel.org> <CAPGftE8jNys9aVfUZW2iE5vB=QWKEmmwwWuWq9ek0ZXp-Aobkg@mail.gmail.com>
 <CAEf4BzYDm3QOOgND9p+LR21bn98QMjE+VYspQSvi4ebG9EdW0g@mail.gmail.com>
 <CAEf4Bzb7LZX8Y=qKpO5j3eUYU=tJzvNRYd1CdXXxq8Y-V4=+Vw@mail.gmail.com>
 <CAPGftE9iVH=eG_FRxSFJC0B3FX8LVdKStfvLbs0gRt8kvMoqJw@mail.gmail.com>
 <CAEf4Bza2D2MQ_F7+vNg7x05JachvJ5bLM3Uyjv+oEx=xna_u4g@mail.gmail.com> <CAPGftE_aD6raGXnjhAM6CCMjB2_9C77Z=Xg-=wMwaduTHCp3Pw@mail.gmail.com>
In-Reply-To: <CAPGftE_aD6raGXnjhAM6CCMjB2_9C77Z=Xg-=wMwaduTHCp3Pw@mail.gmail.com>
From:   Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Date:   Tue, 29 Sep 2020 19:36:27 +0200
Message-ID: <CAOjtDRUvh8vC5Q=9QN4UDCvKSRQTmx4zPhcZ4AB0n3ZXBqg_DQ@mail.gmail.com>
Subject: Re: Problem with endianess of pahole BTF output for vmlinux
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Tony Ambardar <tony.ambardar@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        David Marcinkovic <david.marcinkovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Borna Cafuk <borna.cafuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Andrii and Tony,

as Luka mentioned we do not yet have a final version of the testing
environment that we are working on for ARM32.

However, I previously created an ARM32 little endian QEMU virt image
that runs Debian, to test issues that we encountered with BPF CO-RE
programs on ARM32.
I only managed to get BPF CO-RE programs working with the default
Debian kernel image, which is version 4.19. I built a custom 5.7
kernel but it has some issues (none of the BPF programs work), which i
haven't managed to fix yet.
I'm not sure if the issue is due to the 5.7 kernel image, or due to
the QEMU image. Because of that I'm not sure if it will work with
other kernel versions, but if you are interested in trying to use it,
it is available at the following Google Drive link:
https://drive.google.com/drive/folders/1hs80tYhQG76As7_vkj1y7EF-sFXWxep1?usp=sharing

To run the command i use "qemu-system-arm -M virt -m 1024 -kernel
vmlinuz-4.19.0-10-armmp-lpae -initrd initrd.img-4.19.0-10-armmp-lpae
-append 'root=/dev/vda2' -drive
if=none,file=qemu-backup.qcow2,format=qcow2,id=hd -device
virtio-blk-device,drive=hd -netdev user,id=mynet -device
virtio-net-device,netdev=mynet -nographic".

The logins are root:test and user:user.
The link has the disk image in qemu-backup.qcow, the 4.19 kernel and
initrd and a run.sh which has the above mentioned command to run the
image.

Regards,
Juraj


On Tue, Sep 29, 2020 at 8:48 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
>
> On Mon, 28 Sep 2020 at 21:15, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Sep 28, 2020 at 8:41 PM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> > >
> [...]
> > > I can provide 32-bit and 64-bit big-endian system images for running
> > > on QEMU's malta target. These are built using OpenWRT's build system
> > > and include a recent stable bpftool (v5.8.x) and v5.4.x kernel. Is
> > > that sufficient? It would work if manually creating raw or elf-based
> > > BTF files on a build host, then copying into the QEMU target to test
> > > parsing with bpftool (linked with the standard libbpf).
> >
> > That would be great! I intend to run them under qemu-system-arm and
> > supply latest kernel through -kernel option, so kernel itself is not
> > that critical. Same for bpftool, pahole, etc, I'll just supply them
> > from my host environment. So please let me know how I can get ahold of
> > those. Sample qemu invocation command line would be highly appreciated
> > as well. Thank you!
> >
> Sounds good. However, malta is actually a MIPS platform. I've been using it
> a long time because it makes things particularly easy to switch configuration
> between different word-sizes and endianness.
>
> I had some malta mips images ready to go, but if you need ARM I'll need
> to look into building images for big-endian ARM. Big-endian isn't so common
> in the wild, and I'll need to see if OpenWRT supports these, and how to
> configure with QEMU's 'armvirt' target if possible...
>
> > >
> > > For changes to the Linux build system itself (e.g. pahole endian
> > > options and target endian awareness), you would need to set up a
> >
> > I think that shouldn't be a problem and should be handled
> > transparently, even in a cross-compilation case, but let's see.
> >
> > > standard OpenWRT build environment. I can help with that, or simply
> > > integrate your patches myself for testing. As you say, nothing to be
> > > super pumped about...
> > >
> > > Let me know what's easiest and how best to get images to you.
> >
> > Any way you like and can. Dropbox, Google drive, what have you.
> >
> Meantime, I can package up what I have and send you the details. That
> would include images for mips32/64 big-endian and arm32/64 little-endian,
> plus usage examples. Is that still helpful for you?
>
> Thanks,
> Tony
