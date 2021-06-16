Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390CB3AA6A7
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 00:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhFPWjO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 18:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbhFPWjO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 18:39:14 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567EDC061574;
        Wed, 16 Jun 2021 15:37:06 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id m9so5316279ybo.5;
        Wed, 16 Jun 2021 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pd9Fva3YY2E2a2ltMSDz/uASpxX1N+xx1oVHoW3LOek=;
        b=qWo/jHeVYTsEZKWI9/VZreoJNG9zEIJhhn8EDHyYPlvqDuxH5zkAePSUpPfRy5eGQj
         rwHEVUErbJ2Xz8xwJR0Lquv0jQPSMmKkOSo6eSjzZew4Lyhp48h35HcmJWc2qfNw49U7
         xPkEqy1zWcxo0tKSUv8RMsane6+VccPUEqKoWX3/GWc4zXwTWzrrw6rkwofrh1AIbX3z
         dJrNxRKnUJN1mL6E4kKaP7lEADR4Cd/GrX5OvSjdQ28n6JzefjNwITN/NRqEVvzHUdFv
         tbxdk3IF9BC6stLXXQKgvtEkQRsyTj41Uf9T5deYOpu6jzolmYk3uhHK6jSpl4rYkdue
         XRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pd9Fva3YY2E2a2ltMSDz/uASpxX1N+xx1oVHoW3LOek=;
        b=WgD3kzUVlWTXW6GHzUvjQ2582Bc73ccn+KtqbN4e8M+LT9dRaCghLCL9FyRMadfDpy
         mi/smvKAhxyHWBK2JpdZMbMAJjkHrNoLU7z6dXDU+mrpbTCugA/J4H6QBpSLkeliTE5c
         6g6MZqYKRCa0C2TVj/fdg2qh2SKB5aXtI1U3UkyFg0D1q6w+qOOHNhhiLqSq4VCWIc1S
         VmYM1krQmOZAoYAf6q5olNhJNwUImNHlf5LKKT3WeLlnUTyrtkcq1HAE/a1xaiytAaVT
         2eUS+FW2fzGJPVniwdm5Fn886BZRqvIqI90TmYp8058YF8YbamKh8Sn1UE9X+6ukxIME
         xEWw==
X-Gm-Message-State: AOAM533qodCQnR5+tz7ojuHh4ctiV4mE4vG00xt2HrFZbeagyAYx9h2w
        +mZzxokro5p6YylOP3YHCjse5229N9QX5cHPiG8=
X-Google-Smtp-Source: ABdhPJxg1/Mg0/LyataSuKiUIMdVeam1mmEKSLSswupbXKuyIDCnYdYZ78vGtm+fNpSWesj6hCInWTO9Cs67L6VOJlE=
X-Received: by 2002:a25:7246:: with SMTP id n67mr1802315ybc.510.1623883025508;
 Wed, 16 Jun 2021 15:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
 <YMoRBvTdD0qzjYf4@kernel.org> <YMopYxHgmoNVd3Yl@kernel.org> <YMph3VeKA1Met65X@kernel.org>
In-Reply-To: <YMph3VeKA1Met65X@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 16 Jun 2021 15:36:54 -0700
Message-ID: <CAEf4BzZmBbkU1WWLEsZG1yVMdt7CDcuHhRF8uoLqeamhef3bVQ@mail.gmail.com>
Subject: Re: latest pahole breaks libbpf CI and let's talk about staging
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, siudin@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 16, 2021 at 1:41 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Jun 16, 2021 at 01:40:03PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Wed, Jun 16, 2021 at 11:56:06AM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Tue, Jun 15, 2021 at 04:30:03PM -0700, Andrii Nakryiko escreveu:
> > > > Hey Arnaldo,
>
> > > > Seems like de3a7f912559 ("btf_encoder: Reduce the size of encode_cu=
()
> > > > by moving function encoding to separate method") break two selftest=
s
> > > > in libbpf CI (see [0]). Please take a look. I suspect some bad BTF,
> > > > because both tests rely on kernel BTF info.
>
> > > > You've previously asked about staging pahole changes. Did you make =
up
> > > > your mind about branch names and the process overall? Seems like a
> > > > good chance to bring this up ;-P
>
> > > >   [0] https://travis-ci.com/github/libbpf/libbpf/jobs/514329152
>
> > > Ok, please add tmp.master as the staging branch, I'll move things to
> > > master only after it passing thru CI.
>
> > > Now looking at that code, must be something subtle...
>
> > Running selftests I'm getting a failure at:
>
> >   GEN-SKEL [test_progs] bpf_cubic.skel.h
> > libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section:=
 -2
> > Error: failed to open BPF object file: No such file or directory
> > make: *** [Makefile:460: /mnt/linux/tools/testing/selftests/bpf/bpf_cub=
ic.skel.h] Error 255
> > make: *** Deleting file '/mnt/linux/tools/testing/selftests/bpf/bpf_cub=
ic.skel.h'
> > make: Leaving directory '/mnt/linux/tools/testing/selftests/bpf'
> > [acme@seventh linux]$
>
> > I'll try to reproduce what you reported, i.e. revert that patch, and
> > rebuild the kernel.
>
> I tried with 1.21 plus that ftrace fix but I still get:
>
> [acme@seventh linux]$ uname -a
> Linux seventh 5.13.0-rc6.pahole-58a98f76ac95b1bb+ #1 SMP Wed Jun 16 15:47=
:50 -03 2021 x86_64 x86_64 x86_64 GNU/Linux
>
> Which is pahole build up to:
>
> =E2=AC=A2[acme@toolbox pahole]$ git log --oneline -4 58a98f76ac95b1bb
> 58a98f76ac95b1bb btf: Remove ftrace filter
> 7c60b0443cb01795 pahole: Fix error message when --header couldn't be read
> 7eea706c14997b4f pahole: Introduce --with_flexible_array option to show j=
ust types ending in a flexible array
> 25ad41e7b52e3ad6 (tag: v1.21) pahole: Prep 1.21
> =E2=AC=A2[acme@toolbox pahole]$
>
> But selftests is still failing at:
>
> [acme@seventh linux]$ sudo make -C tools/testing/selftests/bpf/ clean > /=
dev/null 2>&1
> [sudo] password for acme:
> [acme@seventh linux]$ sudo make -C tools/testing/selftests/bpf/ clean > /=
dev/null 2>&1
> [acme@seventh linux]$ sudo make -C tools/testing/selftests/bpf/ | tail
> Warning: Kernel ABI header at 'tools/include/uapi/linux/netlink.h' differ=
s from latest version at 'include/uapi/linux/netlink.h'
> Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differ=
s from latest version at 'include/uapi/linux/if_link.h'
> libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
> libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
> libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -=
2
> Error: failed to open BPF object file: No such file or directory
> make: *** [Makefile:460: /mnt/linux/tools/testing/selftests/bpf/bpf_cubic=
.skel.h] Error 255
> make: *** Deleting file '/mnt/linux/tools/testing/selftests/bpf/bpf_cubic=
.skel.h'
>   CLNG-BPF [test_maps] xdping_kern.o
>   CLNG-BPF [test_maps] xdp_redirect_map.o
>   CLNG-BPF [test_maps] xdp_tx.o
>   GEN-SKEL [test_progs] atomic_bounds.skel.h
>   GEN-SKEL [test_progs] atomics.skel.h
>   GEN-SKEL [test_progs] bind4_prog.skel.h
>   GEN-SKEL [test_progs] bind6_prog.skel.h
>   GEN-SKEL [test_progs] bind_perm.skel.h
>   GEN-SKEL [test_progs] bpf_cubic.skel.h
> make: Leaving directory '/mnt/linux/tools/testing/selftests/bpf'
> [acme@seventh linux]$
>
> And if I use pahole's BTF loader I find the info about that function:
>
> [acme@seventh linux]$ strace -e openat -o /tmp/bla pfunct -F btf tcp_cong=
_avoid_ai  ; grep vmlinux /tmp/bla
> void tcp_cong_avoid_ai(struct tcp_sock * tp, u32 w, u32 acked);
> openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) =3D 3
>
> So this should be unrelated to the breakage you noticed in the CI.
>
> I'm trying to to reproduce the CI breakage by building the kernel and
> running selftests after a reboot.
>
> I suspect I'm missing something, can you see what it is?

Oh, I didn't realize initially what it is. This is not kernel-related,
you are right. You just need newer Clang. Can you please use nightly
version or build from sources? Basically, your Clang is too old and it
doesn't generate BTF information for extern functions in BPF code.

>
> - Arnaldo
>
> > [acme@seventh linux]$ uname -a
> > Linux seventh 5.13.0-rc6+ #1 SMP Wed Jun 16 11:59:35 -03 2021 x86_64 x8=
6_64 x86_64 GNU/Linux
> >
> > [acme@seventh linux]$ sudo make -C tools/testing/selftests/bpf/

[...]

>
> --
>
> - Arnaldo
