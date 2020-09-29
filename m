Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9B827BB9F
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 05:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgI2Dli (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 23:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbgI2Dli (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 23:41:38 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3FFC061755;
        Mon, 28 Sep 2020 20:41:38 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id v8so3378232iom.6;
        Mon, 28 Sep 2020 20:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5bKbaqa9mc74f6W5QDGnV6VZ3QogiRCN2uLDVFwKcT8=;
        b=Q3SS9iZ61kdUAxAbVj0J4GesRey9ePiA/PCPZ8AkZJ3fxX0onnab42e4sMVLlG0ZWR
         M4Tg79+SgXpx4EzaIklFUV2iH+2fruLHraV0FhUUuZmb6WHlCTVSFzCu1gyodxqdj7zM
         Ct0S6p3fFIxGYrRbv0v/igorGbubQVegoMtpqsKWFII+hDrU1iwhmg7Ed4fdbEo+rA6v
         ZX24ed9PJbIUBkJ5xHnI7kl0jplbmBiXf+TNfn3ge4cZpwF1xZqHDxyrVOdHXuuzRYAa
         6L3p/JQuODwrGtT8GcEUsx8p8u0b37M5uIf3N0cFIbLtMwuIP4cVDu424cijsEqWQMEy
         9/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bKbaqa9mc74f6W5QDGnV6VZ3QogiRCN2uLDVFwKcT8=;
        b=sN5E4NZ+h4CN+1b7v0YRTEgK1h7w65sqHIOhut2FEkDsSAi/jxLqyhj/LyNatx9Xqz
         1EGgnVKinMuS5znjglQf9cUevuiWTTlPLUX+YuAU+TSmufckpljqschOaB+lOzJ+ympM
         B1T6we2sNDgbID6cM5gIvvfi9aDiE69kzY23iCcg+o/qyWCx5/ohICRTF+nmlcJJXCnA
         RrIPkWPW9n5Ju4AB7/7cTt6Qh2SCbj08eGFcIL9SUIjxcggGx8rDXUSRw3Z54MMhA41Q
         pLR93duNDbng0u2YWm92lS7i21nXUdWoiA+rW9PvXxWSd0vy/8fFoVNltbMnnmbc0k0i
         +/mw==
X-Gm-Message-State: AOAM532KrSjucJV4jqbHAkKs8mw4WPgNRMW1TF/gVprXT7+YGrfl6vv2
        ii0IIUL9nB3FwWH4kkIq32nREoO/5PG1CI2UjzGbBAcv1tU=
X-Google-Smtp-Source: ABdhPJw3WL8GUmuwpND7J/X+Ht7Fc/LFVrcfx/KhDV1qZmjNFRRW5aCfdo5jUA9Nh4tESbGaJtQUQ6C2hgyuPhvUSKc=
X-Received: by 2002:a5d:840a:: with SMTP id i10mr1055708ion.4.1601350897380;
 Mon, 28 Sep 2020 20:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
 <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
 <CAEf4Bza9tZ-Jj0dj9Ne0fmxa95t=9XxxJR+Ce=6hDmw_d8uVFA@mail.gmail.com>
 <8cf42e2752e442bb54e988261d8bf3cd22ad00f2.camel@linux.ibm.com>
 <20200909142750.GC3788224@kernel.org> <CAPGftE8jNys9aVfUZW2iE5vB=QWKEmmwwWuWq9ek0ZXp-Aobkg@mail.gmail.com>
 <CAEf4BzYDm3QOOgND9p+LR21bn98QMjE+VYspQSvi4ebG9EdW0g@mail.gmail.com> <CAEf4Bzb7LZX8Y=qKpO5j3eUYU=tJzvNRYd1CdXXxq8Y-V4=+Vw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb7LZX8Y=qKpO5j3eUYU=tJzvNRYd1CdXXxq8Y-V4=+Vw@mail.gmail.com>
From:   Tony Ambardar <tony.ambardar@gmail.com>
Date:   Mon, 28 Sep 2020 20:41:27 -0700
Message-ID: <CAPGftE9iVH=eG_FRxSFJC0B3FX8LVdKStfvLbs0gRt8kvMoqJw@mail.gmail.com>
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

Hello Andrii!

On Mon, 28 Sep 2020 at 13:19, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 21, 2020 at 11:19 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > I have a bunch of code changes locally. I'll clean that up, partition
> > libbpf and pahole patches, and post them for review this week. To
> > address endianness support, those are the prerequisites. Once those
> > changes land, I'll be able to solve endianness issues you are having.
> > So just a bit longer till all that is done, sorry for the wait!
> >
>
> Question to folks that are working with 32-bit and/or big-endian
> architectures. Do you guys have an VM image that you'd be able to
> share with me, such that I can use it with qemu to test patches like
> this. My normal setup is all 64-bit/little-endian, so testing changes
> like this (and a few more I'm planning to do to address mixed 32-bit
> on the host vs 64-bit in BPF cases) is a bit problematic. And it's
> hard to get superpumped about spending lots of time setting up a new
> Linux image (never goes easy or fast for me).
>
> So, if you do have something like this, please share. Thank you!
>

I can provide 32-bit and 64-bit big-endian system images for running
on QEMU's malta target. These are built using OpenWRT's build system
and include a recent stable bpftool (v5.8.x) and v5.4.x kernel. Is
that sufficient? It would work if manually creating raw or elf-based
BTF files on a build host, then copying into the QEMU target to test
parsing with bpftool (linked with the standard libbpf).

For changes to the Linux build system itself (e.g. pahole endian
options and target endian awareness), you would need to set up a
standard OpenWRT build environment. I can help with that, or simply
integrate your patches myself for testing. As you say, nothing to be
super pumped about...

Let me know what's easiest and how best to get images to you.

Many thanks,
Tony
