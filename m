Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62703A7DB3
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 13:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFOL61 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 07:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFOL61 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 07:58:27 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EDFC061574
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 04:56:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x19so8345970pln.2
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 04:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8m3xS1lo1ojJX7DLhpIDzMjZevTvavzMcgebUZUykLw=;
        b=ZIzbObNKV9kNcaJmHIkN5745PoR/6+ppWRfD9buNNfHCq2fgkIKYDlyUATTp/P6teG
         K32iombZjPCfUAvwI5qXhjURZfWItl+NhjObXggeeSXxKccptfeqeYquHfoU3QaaODFm
         aUcBtcuQbXUHUgdLVJCH/cPtb6sKPDWoBiyG6RT1x9ErgUKtnmta+FvBUNvXAKEmRkRl
         +SHNxVAmR4xW7zRDXgrGAdhXZ1VtnBnnLBDTGWKaI1+saH6r9UXmcXlDp1a5WZ34qXm8
         r7AeOSAwRgRTdkZiAKq0ugC6R9Q+1kh1NMgxZR62Psrm71I0jOFu8xzx+W+9MvDADsys
         cs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8m3xS1lo1ojJX7DLhpIDzMjZevTvavzMcgebUZUykLw=;
        b=hfIeSWuZP0YFqA5R0lqsKKQ5zEhzbKI3u+yDYbuEIV/kbr76jEaultnjazK6zUdB7q
         tIjYnlN/zIpaVtKqbua2Svlb4zxK0ZPWep4Jyd28RzqFLZCcBNcy3Yk81Sqgngb6fzkN
         8+XNa+D5TNYvp7KPTSQ5aI8DABINt73+xHu0udfLNtEuDPbt3RetDuv47iJ9zxPLU4N6
         GS54KI6gMo5g0yBQ72IhgCwnu3D1uBMK6HxuHbZXOYvCbuRMlwY7cs++28l4EgYUjoUB
         YQwv7mAArPVYRhYKSofJ+b5VqWO9nss8lPLEPSg99OC3seLsoRGYMFypm3PYmKoiF7+z
         04SQ==
X-Gm-Message-State: AOAM533KkS8N0NZ7L52tOl1GjUeRxlYrGN4aC0F/YNmHFkPufC5CUarp
        Ia/ecWlWuVZ8Qa2NmZRzDYjdijOA1qv/HxbZBdI=
X-Google-Smtp-Source: ABdhPJz1UwNcF5Gyj7r7vmXidW7wAag2hBkt9UQrgBhuDv3xFpT/6GuZbvchbNYLVGFktlt9dPF/+qFiN6Ear/1aaHg=
X-Received: by 2002:a17:902:8b8a:b029:108:7849:dae0 with SMTP id
 ay10-20020a1709028b8ab02901087849dae0mr3928952plb.36.1623758181869; Tue, 15
 Jun 2021 04:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAGG-pUTpppu-voYuT81LiTMAUA5oAWwnAwYQVAhyPwj3CwnZPA@mail.gmail.com>
 <CAEf4BzZkK9X2RadSYUWV5oh960iwaw3y5EKr7zu8WZ7XnRYz6g@mail.gmail.com>
In-Reply-To: <CAEf4BzZkK9X2RadSYUWV5oh960iwaw3y5EKr7zu8WZ7XnRYz6g@mail.gmail.com>
From:   "Geyslan G. Bem" <geyslan@gmail.com>
Date:   Tue, 15 Jun 2021 08:54:31 -0300
Message-ID: <CAGG-pUR-7EWOLwLPG_aR1La4Qh+_8zLoo5zuA-D96FOqwX4QZA@mail.gmail.com>
Subject: Re: kernel bpf test_progs - vm wrong libc version
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 15 Jun 2021 at 03:27, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 11, 2021 at 1:23 PM Geyslan G. Bem <geyslan@gmail.com> wrote:
> >
> > Trying to run vmtest.sh from the bpf-next linux
> > tools/testing/selftests/bpf on Arch Linux raises this error:
> >
> > ./test_progs
> > ./test_progs: /usr/lib/libc.so.6: version `GLIBC_2.33' not found
> > (required by ./test_progs)
> >
> > VM:
> > https://libbpf-vmtest.s3-us-west-1.amazonaws.com/x86_64/libbpf-vmtest-rootfs-2020.09.27.tar.zst
> >
> > [root@(none) /]# strings /usr/lib/libc.so.6 | grep '^GLIBC_2.' | tail
> > GLIBC_2.30
> > GLIBC_2.5
> > GLIBC_2.9
> > GLIBC_2.7
> > GLIBC_2.6
> > GLIBC_2.18
> > GLIBC_2.11
> > GLIBC_2.16
> > GLIBC_2.13
> > GLIBC_2.2.6
> >
> > It would be nice to have
> > https://github.com/libbpf/libbpf/blob/master/travis-ci/vmtest/configs/INDEX
> > updated to refer to a new image with GLIBC_2.33.
> >
> > Host settings:
> >
> > $ strings /usr/lib/libc.so.6 | grep GLIBC_2.33
> > GLIBC_2.33
> > GLIBC_2.33
> >
>
> It seems kind of silly to update our perfectly working image just
> because a new version of glibc was released. Is there any way for you
> to down-grade glibc or build it in some compatibility mode, etc?
> selftests don't really rely on any bleeding-edge features of glibc.

Yeah. Continuously updating/regenerating the image would be a bit
silly, indeed. It was just the trigger for a better proposal.

I would rely on a self-updating image rather than a static one.
Probably that would be more operative. I don't know.

>
> > $ uname -a
> > Linux hb 5.12.9-arch1-1 #1 SMP PREEMPT Thu, 03 Jun 2021 11:36:13 +0000
> > x86_64 GNU/Linux
> >
> > $ gcc --version
> > gcc (GCC) 11.1.0
> >
> > $ clang --version
> > clang version 13.0.0 (/home/uzu/.cache/yay/llvm-git/llvm-project
> > ad381e39a52604ba07e1e027e7bdec1c287d9089)
> > Target: x86_64-pc-linux-gnu
> > Thread model: posix
> > InstalledDir: /usr/bin
> >
> > P.S.: This issue was started in
> > https://github.com/libbpf/libbpf/issues/321 and brought to here.
> >
> > Thank you.
> >
> > Regards,
> >
> > Geyslan G. Bem



-- 
Regards,

Geyslan G. Bem
