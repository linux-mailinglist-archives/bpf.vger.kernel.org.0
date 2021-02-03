Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C95D30E3C2
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 21:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhBCUHF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 15:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhBCUHC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 15:07:02 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283EEC061573
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 12:06:22 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y4so773029ybk.12
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 12:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DCthBB1Dphhkwg5y9vLKc+oulD0A2I9wUy3ZgNov1Rk=;
        b=NK32gz0qRKJn0TaETE2HbTrp0jbcerA1fMBS7kG+j2UyyQKfn1M6mdwGNOQ3z0Db4V
         jaaUizssSkg9xppGTY3ofWqMxo8NHtt4i+mnv16eVvZdpAMT6dx0yP957tp4f3RKuW4M
         fDw5eJapcbUExh1EtHaZ8jhqwkspElw3JoBOLg5mNbG27HHr7IcjiGoMGDbYCQc5APOz
         BVeIghHdGubhtYecN8aQUxDlxnxz9/uS4uHTtV/4gIOnLk0WwyWD0a+Nln6IbYmnBldI
         Rx1MUR72Xq0AnFUJWHlNZ60vF/IgEXgjww0QErdc+sXyKnCRooAE8XljFAR5XB3P1wqg
         YW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DCthBB1Dphhkwg5y9vLKc+oulD0A2I9wUy3ZgNov1Rk=;
        b=ZZdaxGecT2iRge2kn4NlMPCeJ4tRg7FqieQvs8Iula05SxE/4tv1g2i4svy/D4MSoj
         tZ4Tpp1auFjXrlZB80p/A0vNg7bZKrDHN2gRt40FMqnLwULTbpHAfs5TkyIv8R8qEj5d
         hWmWWTgZXeGPN0c5/JbSWqKbsPv9ILvS+tv9id6GZaTLVCMRASjgne7k1rTAEqWYxmng
         ssMLIcOdt7FfIYp/kxGFSVeVYwhM5DyfOVe+pPmn1RywHDIOGq55vYz3WPaXIE57U3rW
         pHra6L/qPeroriERc6EHdFQcIErbkdxN5CvJ0Oz5brB2rYX62UHHCLTTDMpSRfBSLaed
         TcXg==
X-Gm-Message-State: AOAM531X3nzBR8Eazh+8p9fQrXe6pAVgHX2PphFoplONveQryOFtlSu0
        KT3anWEvquI62eaVlLqKTFE/zHDd6jhzSRpNQmk=
X-Google-Smtp-Source: ABdhPJxzwFcKIWBZOX7lgEotbX9J6IqhmRwEANochRZ1aBrBseUrHh+EA9ZeR9I4PWFZzhck2W+TFAiX2I2iMGWzXio=
X-Received: by 2002:a25:da4d:: with SMTP id n74mr7161439ybf.347.1612382781382;
 Wed, 03 Feb 2021 12:06:21 -0800 (PST)
MIME-Version: 1.0
References: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
 <87eehxa06v.fsf@toke.dk> <a6a8fbd6-c610-873e-12e1-b6b0fadb94be@infradead.org> <CAEf4Bzb7-jpQLStjtrWm+CvDkLGHR_LiVdb6YcagR2v-Yt42tw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb7-jpQLStjtrWm+CvDkLGHR_LiVdb6YcagR2v-Yt42tw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Feb 2021 12:06:10 -0800
Message-ID: <CAEf4BzbvQPmaDauPeH5FiqgjVjf-TA+kKL6gsN505q02Un6QZA@mail.gmail.com>
Subject: Re: finding libelf
To:     Randy Dunlap <rdunlap@infradead.org>, Jiri Olsa <jolsa@kernel.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 11:39 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 3, 2021 at 9:22 AM Randy Dunlap <rdunlap@infradead.org> wrote=
:
> >
> > On 2/3/21 2:57 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > > Randy Dunlap <rdunlap@infradead.org> writes:
> > >
> > >> Hi,
> > >>
> > >> I see this sometimes when building a kernel: (on x86_64,
> > >> with today's linux-next 20210202):
> > >>
> > >>
> > >> CONFIG_CGROUP_BPF=3Dy
> > >> CONFIG_BPF=3Dy
> > >> CONFIG_BPF_SYSCALL=3Dy
> > >> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
> > >> CONFIG_BPF_PRELOAD=3Dy
> > >> CONFIG_BPF_PRELOAD_UMD=3Dm
> > >> CONFIG_HAVE_EBPF_JIT=3Dy
> > >>
> > >>
> > >> Auto-detecting system features:
> > >> ...                        libelf: [ [31mOFF[m ]
> > >> ...                          zlib: [ [31mOFF[m ]
> > >> ...                           bpf: [ [31mOFF[m ]
> > >>
> > >> No libelf found
> > >> make[5]: [Makefile:287: elfdep] Error 1 (ignored)
> > >> No zlib found
> > >> make[5]: [Makefile:290: zdep] Error 1 (ignored)
> > >> BPF API too old
> > >> make[5]: [Makefile:293: bpfdep] Error 1 (ignored)
> > >>
> > >>
> > >> but pkg-config tells me:
> > >>
> > >> $ pkg-config --modversion  libelf
> > >> 0.168
> > >> $ pkg-config --libs  libelf
> > >> -lelf
> > >>
> > >>
> > >> Any ideas?
> > >
> > > This usually happens because there's a stale cache of the feature
> > > detection tests lying around somewhere. Look for a 'feature' director=
y
> > > in whatever subdir you got that error. Just removing the feature
> > > directory usually fixes this; I've fixed a couple of places where thi=
s
> > > is not picked up by 'make clean' (see, e.g., 9d9aae53b96d ("bpf/prelo=
ad:
> > > Make sure Makefile cleans up after itself, and add .gitignore")) but =
I
> > > wouldn't be surprised if there are still some that are broken.
> >
> > Hi,
> >
> > Thanks for replying.
> >
> > I removed the feature subdir and still got this build error, so I
> > removed everything in BUILDDIR/kernel/bpf/preload and rebuilt --
> > and still got the same libelf build error.
>
> I hate the complexity of feature detection framework to the point that
> I'm willing to rip it out from libbpf's Makefile completely. I just
> spent an hour trying to understand what's going on in a very similar
> situation. Extremely frustrating.
>
> In your case, it might be feature detection triggered from
> resolve_btfids, so try removing
> $(OUTPUT)/tools/bpf/resolve_btfids/{feature/,FEATURE-DUMP.libbpf}.
>
> It seems like we don't do proper cleanup in resolve_btfids (it should
> probably call libbpf's clean as well). And it's beyond me why `make -C
> tools/build/feature clean` doesn't clean up FEATURE-DUMP.<use-case>
> file as well.

So resolve_btfids does call libbpf's clean, but Linux Kbuild never
calls resolve_btfids' clean. Jiri, do you think that could be
improved? Basically, if something goes wrong with feature detection,
no amount of `make clean` would help and users will be forced to
struggle with frustrating experience trying to understand what's going
on.

I also still think that FEATURE-DUMP should be cleaned up by feature
infra on clean and that's not happening today, but I'm unwilling to go
and untangle all that complexity right now.

>
> >
> >
> > --
> > ~Randy
> >
