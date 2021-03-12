Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BAB3396B9
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 19:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhCLSgh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Mar 2021 13:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbhCLSgO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Mar 2021 13:36:14 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE60C061574
        for <bpf@vger.kernel.org>; Fri, 12 Mar 2021 10:36:13 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id h82so26310215ybc.13
        for <bpf@vger.kernel.org>; Fri, 12 Mar 2021 10:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tD2LcR+jeY2PujLGCXU413q1Ncl2mZmpdgdtnTMIL0g=;
        b=k/eyTxBwTl2nftc/oruMQtnynAVPOdH9XLlJHL5TFrHm92/+KGrSRAAk6+pk4zEjeN
         vFfsfKfTkggo0zCdV33O6lzmaVH9c2VsrmpotGIpo48GFUlHnQkjYF4maegOnR/uztm+
         RZEpHvvzztaf3WiKWa0H7OzBt/k7/xUhW2EZjykTHAb6bg38ct9bv9nLa6Dm/foq/thl
         +U1Wff6hKspqmXAMBtgRiUw5Zkj4QD5gqCFJKDONG05i+pRMFRIi4uCo2AtOxOn7r9/e
         WyKDr7hxvg2Cn14stysslLr1DwncfevAbVoXItw6NJg/PQj2w/7Q64VEhVNapwf5E84G
         eXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tD2LcR+jeY2PujLGCXU413q1Ncl2mZmpdgdtnTMIL0g=;
        b=ijNk6QHwvTFbwiievOgpvA6nGjUKKOw2G/UkRqox/ieV7B/Ft2lE+ifyTq3zgExqcM
         JZzCYJZKacHbe8zMfbk7//frrJ1ecXxJf7Ie20Qo/DAi1baCR1RwZhAz60mibltInUXJ
         aRqhn6KXXa2jUBQvpwZ/zqR14zw4Rli84DBVo76eMtDOegQb1wqGpG+idheYCJdhCgL8
         RmvzRTkeY4UOCk+RZWE+/mi2zhcTd+r2AtTpEZZM13h6nCGs1VU99TztofBwOjNK62aP
         UO/LSnumJJF4nhFKzUoRlSbACk2F/a2iCsTwanO1jvJPFIvmbT3366gLTvTCHv7tKgPs
         eSbg==
X-Gm-Message-State: AOAM533GYMiQSIVS5Ys4iSlQyYOnHKoT4ggpl3tFksa2kZgjXSkRN9Ej
        mi/qbd5GMiV85etLfazraDEhZYvaXP6Yn1J39D7G4YHpRlY=
X-Google-Smtp-Source: ABdhPJwVjlyd3nOTnF5Q/nN3U4lm7Cl0Q+sWQ2yoeKBioPamrURKF5uQH9m5bJXiLCOPOZ+sRzi677DcxVtlM+FrF+o=
X-Received: by 2002:a25:37c4:: with SMTP id e187mr21382022yba.347.1615574173214;
 Fri, 12 Mar 2021 10:36:13 -0800 (PST)
MIME-Version: 1.0
References: <CADmGQ+0dDjfs6UL63m3vLAfu+GHgSFdMO+Rmz_jk+0R9Wva2Tw@mail.gmail.com>
 <20210303181457.172434-1-rafaeldtinoco@ubuntu.com> <CAEf4BzZE_Ss7-cNdVpKJbC57mr2V_-OMcC9fvHw7XTntn3K2jA@mail.gmail.com>
 <043B1B9B-EEF7-49CD-88AF-29A2A3E97304@ubuntu.com> <67E3C788-2835-4793-8A9C-51C5D807C294@ubuntu.com>
 <CAEf4BzaPytBkMqDh15eLPskOj_+FQa0ta2G+BToEn1pSwMGpfA@mail.gmail.com> <7BEF1010-5D4A-4C6F-8059-BD18A4A9EA6F@ubuntu.com>
In-Reply-To: <7BEF1010-5D4A-4C6F-8059-BD18A4A9EA6F@ubuntu.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 12 Mar 2021 10:36:02 -0800
Message-ID: <CAEf4BzYDNQwTBmd_gG5isqfy0JPrW+ticu=NUvqhvbYmLOWC-g@mail.gmail.com>
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Vamsi Kodavanty <vamsi@araalinetworks.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 2:45 PM Rafael David Tinoco
<rafaeldtinoco@ubuntu.com> wrote:
>
>
> > From what I see all the CO-RE relocations applied successfully (even
> > though all the offsets stayed the same, so presumably you compiled
> > your BPF program with vmlinux.h from the exact same kernel you are
> > running it on?). Are you sure that vmlinux image you are providing
> > corresponds to the actual kernel you are running on?
>
> Yep, I have created the following:
>
> https://pastebin.ubuntu.com/p/h58YyNr4HR/
>

Ok, I have no idea, tbh. Maybe `pahole -j` is subtly modifying vmlinux
is some way (but then why would kernel start and only fail to
load/verify your BPF program?). It's also clear that CO-RE is doing
exactly the same instruction patching, so shouldn't be some invalid
CO-RE relocation applied, I think. So no idea and not sure how to
investigate this.

But I think I'd never do `pahole -J` on actual vmlinux image you are
going to run. It's much safer and more convenient to make a copy,
generate .BTF and then extract just .BTF section into a small binary,
which can be provided separately.


> to make this easier.
>
> It is a 4.15.0-1080 kernel and a 4.15.18+. They are pretty close

Also this. Seems like it is two different kernels still, however small
the difference between them is. Have you tried building *exactly* the
same kernel with exactly the same config, but just with pahole -J
during the build on vmlinux.o (which is later linked into a final
vmlinux) vs running pahole -J on final vmlinux after the build. Notice
that two approach differ in terms of which object file is being
modified. With link-vmlinux.sh, kernel linker scripts dictate final
layout, while if you run `pahole -J` on final vmlinux, it can modify
the layout and potentially break something sensitive. pahole is using
llvm-objcopy internally, and llvm-objcopy isn't a very trivial tool.


> despite the versioning (second was generated with make deb-dpkg).
>
> I=E2=80=99m using same .config file for both, only difference is that the
> 4.15.18+ was compiled with the changed link-vmlinux.sh file.
>
> The /usr/lib/debug/boot/vmlinux files are generated by the same
> build and I have tried 2 or 3 of the existing packaged kernels. The
> only thing I did was =E2=80=9Cpahole -J=E2=80=9D to /usr/lib/debug/boot/v=
mlinux-XXX
> files (adding the BTF section to them).
>
> Running same binary in a 5.8.0-43 kernel works out-of-the-box:
>
> https://pastebin.ubuntu.com/p/VKTjMcp6Xs/
>
> >
> > I'd start by comparing libbpf logs for vmlinux you get with modified
> > link-vmlinux.sh script and with just explicit pahole -J. If all the
> > CO-RE parts are identical, the problem is somewhere else most
> > probably.
>
> The difference between (1) and (2) from the paste (error and success):
>
> libbpf: CO-RE relocating [0] struct task_struct: found target
> candidate [17361] struct task_struct in [vmlinux]
> libbpf: CO-RE relocating [0] struct task_struct: found target
> candidate [17360] struct task_struct in [vmlinux]
>
> libbpf: prog 'tcp_connect': relo #0: matching candidate #1 [17361]
> struct task_struct.comm (0:90 @ offset 2640)
> libbpf: prog 'tcp_connect': relo #0: matching candidate #1 [17360]
> struct task_struct.comm (0:90 @ offset 2640)
>
> Code is at:
>
> https://github.com/rafaeldtinoco/portablebpf
>
> and it is not much different than any other libbpf example.
>
> thanks again for verifying this!
>
> -rafaeldtinoco
>
>
>
