Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9432E30E36B
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 20:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBCTkq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 14:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhBCTkI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 14:40:08 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA27BC0613D6
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 11:39:28 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v123so697057yba.13
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 11:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jXpAv4PpMxiXP/GiWA78Y+llvYykdwOfJBoA8NvqV5Q=;
        b=PL14tHNq+aAARS0x6dMHb8NFp7cM3tU6REPMLne9rwlWhTnhWayv7fjLaUdUF+a3WR
         TZp6+qnrynTnXO3E5eDy10+q1l4Iv/5L09CjrpDyVOZpj2HT9gTJm4O0kELc9Ke3BtYH
         ns5KdtGz3nRy7vsvPk9zhko/XI0Mh21x1RejFDewUeUMnyLyftRGlE4peQlTTBjhHVQV
         1319OCOlHGObi8ZLKbxUtWL5b/A32jq/Zo7X0gsjtz9TL1ejxErgqVnIip+qLYJ9SjHg
         OyDTMEVPR7s0RVaxE+m9k7vVi9hyGqiQ4CXkntrPM3ivkdweOUNX2Ld18G95wzOLxQne
         1iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jXpAv4PpMxiXP/GiWA78Y+llvYykdwOfJBoA8NvqV5Q=;
        b=t+3VPPIXscn+i0g+1BtndbgfFLNMAgabUJMpRgVyyYZZfQ9eFqFj6lGlLFFRVkQumr
         gxD/Qd7Ii9xas2rfI+cfb3beipbqtAKQRlxIWAE//6GSt1jeXugSHYyq4yeW5qLMU2oe
         HXflqkmuIU2irS9P3cdKFZRL6sXSvXpMfznVexcGHUA+wtI8/wAGiLuxj1MXqAvX+Auf
         BVdGanBM5pyT9hWosWJp4YI2adDhN+6xsIbS/Hxml9uAyQucEnck90kaKn5rnOKtOHi2
         oRFa6MLLCtzvBNZ6Iaucwd/UduA4gjlemMZ8yTBljdl5C7+qSuMl8HhGk2PCI8Slw9pU
         2hSg==
X-Gm-Message-State: AOAM533jDNwPoR0MAZXGaxnEP9+2oY6aZJNIF0VC769FdZSDY3MQEkXz
        OBIkbhe15yodMMwe+8nFfy9wj8Oam7kVNZNpn6E=
X-Google-Smtp-Source: ABdhPJxyy+gZvjqXwOLUNlxqf5xw/C+CqLbcj7x00VT9wmX6jPSGur8lWR8WBJOzfCoxIzGNMb3om6uLBVuNRnxnmic=
X-Received: by 2002:a25:a183:: with SMTP id a3mr6565187ybi.459.1612381167847;
 Wed, 03 Feb 2021 11:39:27 -0800 (PST)
MIME-Version: 1.0
References: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
 <87eehxa06v.fsf@toke.dk> <a6a8fbd6-c610-873e-12e1-b6b0fadb94be@infradead.org>
In-Reply-To: <a6a8fbd6-c610-873e-12e1-b6b0fadb94be@infradead.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Feb 2021 11:39:17 -0800
Message-ID: <CAEf4Bzb7-jpQLStjtrWm+CvDkLGHR_LiVdb6YcagR2v-Yt42tw@mail.gmail.com>
Subject: Re: finding libelf
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 9:22 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/3/21 2:57 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Randy Dunlap <rdunlap@infradead.org> writes:
> >
> >> Hi,
> >>
> >> I see this sometimes when building a kernel: (on x86_64,
> >> with today's linux-next 20210202):
> >>
> >>
> >> CONFIG_CGROUP_BPF=3Dy
> >> CONFIG_BPF=3Dy
> >> CONFIG_BPF_SYSCALL=3Dy
> >> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
> >> CONFIG_BPF_PRELOAD=3Dy
> >> CONFIG_BPF_PRELOAD_UMD=3Dm
> >> CONFIG_HAVE_EBPF_JIT=3Dy
> >>
> >>
> >> Auto-detecting system features:
> >> ...                        libelf: [ [31mOFF[m ]
> >> ...                          zlib: [ [31mOFF[m ]
> >> ...                           bpf: [ [31mOFF[m ]
> >>
> >> No libelf found
> >> make[5]: [Makefile:287: elfdep] Error 1 (ignored)
> >> No zlib found
> >> make[5]: [Makefile:290: zdep] Error 1 (ignored)
> >> BPF API too old
> >> make[5]: [Makefile:293: bpfdep] Error 1 (ignored)
> >>
> >>
> >> but pkg-config tells me:
> >>
> >> $ pkg-config --modversion  libelf
> >> 0.168
> >> $ pkg-config --libs  libelf
> >> -lelf
> >>
> >>
> >> Any ideas?
> >
> > This usually happens because there's a stale cache of the feature
> > detection tests lying around somewhere. Look for a 'feature' directory
> > in whatever subdir you got that error. Just removing the feature
> > directory usually fixes this; I've fixed a couple of places where this
> > is not picked up by 'make clean' (see, e.g., 9d9aae53b96d ("bpf/preload=
:
> > Make sure Makefile cleans up after itself, and add .gitignore")) but I
> > wouldn't be surprised if there are still some that are broken.
>
> Hi,
>
> Thanks for replying.
>
> I removed the feature subdir and still got this build error, so I
> removed everything in BUILDDIR/kernel/bpf/preload and rebuilt --
> and still got the same libelf build error.

I hate the complexity of feature detection framework to the point that
I'm willing to rip it out from libbpf's Makefile completely. I just
spent an hour trying to understand what's going on in a very similar
situation. Extremely frustrating.

In your case, it might be feature detection triggered from
resolve_btfids, so try removing
$(OUTPUT)/tools/bpf/resolve_btfids/{feature/,FEATURE-DUMP.libbpf}.

It seems like we don't do proper cleanup in resolve_btfids (it should
probably call libbpf's clean as well). And it's beyond me why `make -C
tools/build/feature clean` doesn't clean up FEATURE-DUMP.<use-case>
file as well.

>
>
> --
> ~Randy
>
