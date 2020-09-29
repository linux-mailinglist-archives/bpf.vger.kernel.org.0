Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F0827BD50
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 08:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbgI2GsS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 02:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2GsS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 02:48:18 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59676C061755;
        Mon, 28 Sep 2020 23:48:18 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id b17so530829ilr.12;
        Mon, 28 Sep 2020 23:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4siLnRReiSCIjTtwXHK/hDaafFxouxQSN90epg+CRhE=;
        b=vcT3NG3biFE3yMA3zD1QAx9zfsrVpTQwZwK+pD/DS4X8T+d7TFM11s4SsXYQzMtO1w
         BvVZAKTvfcbzgc3GDnJ2ITDvXBmzRrAHvennE/kvT/NRtT+Jq77NUIocXeWyl6kzi1u3
         aELdkYZCuHwuiDZD7H6OGjYw9ISL5NKNIkVNRnGGQsae+aqLXost5shqKaY955dbTXxr
         k2UiIFxwOU4yw96xdpQEP6PVr5nUtvqUW4+6Wx7gjVDkm/LtCwqBXkltmRp8ju0k80Wq
         Nx4v6PjeM0GHDPXppFozHAy2aMLDI+wmZNMUNFDBOcC6cw71+3qRMvu4X0uKbYAEgz1F
         RUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4siLnRReiSCIjTtwXHK/hDaafFxouxQSN90epg+CRhE=;
        b=Qp4qH76GCiOGoT7LYh+d79sv0pn88LSi9l2nDZ1Jgt+yiD+nUxrU46zIpscpZU0783
         BHXZXCs5Y39s4VLhCo5Wg6E6XNNUyk+8lutlDNiH1jRYoF1HfUliqQ+7+qPAvXoaohEn
         I9dNhCsfEa3Hi9KLkHXNTtVxULx66pxwTbiqwP1S8TdyPJ7KKu9DGwRl+YNU6w+xdcoP
         o8YfEi6jCeFADlboxw1l1clWcAC51MONc666QF9hn1i4va1X3Ngu1jxN12UQ4yZfeThC
         pm+tS9/wqXPeLaSbxDy4ZFG5g/bEsVvPuBXMNSCHstA/eKft9fR3aevdUJsPNjNZkJjg
         dvvA==
X-Gm-Message-State: AOAM531iBSyS3fg4KIq4m7ptGcbgPwyRlkovxuA+v/TY+iZM67nCkRU0
        8pd60LHYm6BPRXn2eG+Uaw0YHLAJLiutvzqA2NSeG/hMSgrbd2Xs
X-Google-Smtp-Source: ABdhPJx7G5VvIXJ3HVLxfT7T8ekhJhiRVTDbqf5dRpm+TMxYl7DOv+rXACUtiD1zVdW77JTuIpJhwJ6Oc0VwPoIyM2U=
X-Received: by 2002:a92:d68c:: with SMTP id p12mr1879914iln.266.1601362097657;
 Mon, 28 Sep 2020 23:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
 <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
 <CAEf4Bza9tZ-Jj0dj9Ne0fmxa95t=9XxxJR+Ce=6hDmw_d8uVFA@mail.gmail.com>
 <8cf42e2752e442bb54e988261d8bf3cd22ad00f2.camel@linux.ibm.com>
 <20200909142750.GC3788224@kernel.org> <CAPGftE8jNys9aVfUZW2iE5vB=QWKEmmwwWuWq9ek0ZXp-Aobkg@mail.gmail.com>
 <CAEf4BzYDm3QOOgND9p+LR21bn98QMjE+VYspQSvi4ebG9EdW0g@mail.gmail.com>
 <CAEf4Bzb7LZX8Y=qKpO5j3eUYU=tJzvNRYd1CdXXxq8Y-V4=+Vw@mail.gmail.com>
 <CAPGftE9iVH=eG_FRxSFJC0B3FX8LVdKStfvLbs0gRt8kvMoqJw@mail.gmail.com> <CAEf4Bza2D2MQ_F7+vNg7x05JachvJ5bLM3Uyjv+oEx=xna_u4g@mail.gmail.com>
In-Reply-To: <CAEf4Bza2D2MQ_F7+vNg7x05JachvJ5bLM3Uyjv+oEx=xna_u4g@mail.gmail.com>
From:   Tony Ambardar <tony.ambardar@gmail.com>
Date:   Mon, 28 Sep 2020 23:48:07 -0700
Message-ID: <CAPGftE_aD6raGXnjhAM6CCMjB2_9C77Z=Xg-=wMwaduTHCp3Pw@mail.gmail.com>
Subject: Re: Problem with endianess of pahole BTF output for vmlinux
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        David Marcinkovic <david.marcinkovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Borna Cafuk <borna.cafuk@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 28 Sep 2020 at 21:15, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 28, 2020 at 8:41 PM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
[...]
> > I can provide 32-bit and 64-bit big-endian system images for running
> > on QEMU's malta target. These are built using OpenWRT's build system
> > and include a recent stable bpftool (v5.8.x) and v5.4.x kernel. Is
> > that sufficient? It would work if manually creating raw or elf-based
> > BTF files on a build host, then copying into the QEMU target to test
> > parsing with bpftool (linked with the standard libbpf).
>
> That would be great! I intend to run them under qemu-system-arm and
> supply latest kernel through -kernel option, so kernel itself is not
> that critical. Same for bpftool, pahole, etc, I'll just supply them
> from my host environment. So please let me know how I can get ahold of
> those. Sample qemu invocation command line would be highly appreciated
> as well. Thank you!
>
Sounds good. However, malta is actually a MIPS platform. I've been using it
a long time because it makes things particularly easy to switch configuration
between different word-sizes and endianness.

I had some malta mips images ready to go, but if you need ARM I'll need
to look into building images for big-endian ARM. Big-endian isn't so common
in the wild, and I'll need to see if OpenWRT supports these, and how to
configure with QEMU's 'armvirt' target if possible...

> >
> > For changes to the Linux build system itself (e.g. pahole endian
> > options and target endian awareness), you would need to set up a
>
> I think that shouldn't be a problem and should be handled
> transparently, even in a cross-compilation case, but let's see.
>
> > standard OpenWRT build environment. I can help with that, or simply
> > integrate your patches myself for testing. As you say, nothing to be
> > super pumped about...
> >
> > Let me know what's easiest and how best to get images to you.
>
> Any way you like and can. Dropbox, Google drive, what have you.
>
Meantime, I can package up what I have and send you the details. That
would include images for mips32/64 big-endian and arm32/64 little-endian,
plus usage examples. Is that still helpful for you?

Thanks,
Tony
