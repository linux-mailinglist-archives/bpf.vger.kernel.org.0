Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445F537F43D
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 10:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhEMIig (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 04:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbhEMIif (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 04:38:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65681C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 01:37:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z13so37528461lft.1
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 01:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PHaCWgEE6c4TCqnr20Y2Tb/elcO/UUWT8003QZ9uRCI=;
        b=LuOJKvNiAT8kHzQImtibnuxjXNT2Ftq34giDbSM3s+GbkMD+01nvAuPIr8cqgEqMZa
         PP0jbr9fUlYEvPQ5JzoZ+nu7Jq0hEni2K7zzLN7F2lZHj+GPsFZ07YHnNY9YWz6sg1tV
         UO3PX9KHVUBYDVJW39/Q13+Xp2/Q1IOqdLMgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHaCWgEE6c4TCqnr20Y2Tb/elcO/UUWT8003QZ9uRCI=;
        b=jSJAHjwjsSSBhAiNJKmQ9o9r+VIyaYdh58IRXiqtmwmaeRbuz58etBS9sDiq5LFtIM
         eXpPPdAnnRom6+k6resRt1bFC5gAjeVdGyXaSAXDZJj2uw2bSqEhrAbFLhuNQOFAbU0N
         nDUaT/Cs3jTAix+9sM1GbDlVvJ2Eh0X4gToa4340YEcV8bbdKc3kMoJReUG+Co0iBZ9T
         Z6VeSb6UTO8EK6aDNmNXZJ8qMDVU2QzS0DlnD2c7j7UZw6EHNMy6vb/7njobkJSD3jkj
         DOnnsQkXcSIqHWLWPnoKFK9BX78hP6/kEePEvSW5T1YJKhfgKZcbFHeaoMmgUJYINofN
         8c1Q==
X-Gm-Message-State: AOAM530JoV67shLjN/vAO4HVyy4MIASS4LvIyzwh7mftEJrb0DdfOeA1
        u5BcKsOPq5cTF/S/meo/gJFrpUBKO1DjvS6kxfDofQ==
X-Google-Smtp-Source: ABdhPJzeRRycic2njXDn3pfCDB1CZHgy1g/M5uvhqHrDC3Ae39xKnZg0dj+/8raTcyBd/2FHcnwYd1v3KZ6CBxNySvE=
X-Received: by 2002:a05:6512:3618:: with SMTP id f24mr28416584lfs.34.1620895044869;
 Thu, 13 May 2021 01:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZOmCgmbYDUGA-s5AF6XJFkT1xKinY3Jax3Zm2OLNmguA@mail.gmail.com>
 <20210426223449.5njjmcjpu63chqbb@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzYZX9YJcoragK20cvQvr_tPTWYBQSRh7diKc1KoCtu4Dg@mail.gmail.com>
 <20210427022231.pbgtrdbxpgdx2zrw@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzZOwTp4vQxvCSXaS4-94fz_eZ7Q4n6uQfkAnMQnLRaTbQ@mail.gmail.com>
 <20210428045545.egqvhyulr4ybbad6@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzZo7_r-hsNvJt3w3kyrmmBJj7ghGY8+k4nvKF0KLjma=w@mail.gmail.com>
 <20210504044204.kpt6t5kaomj7oivq@ast-mbp> <CAADnVQ+WV8xZqJfWx8em5Ch8aKA8xcPqR0wT0BdFf9M==W5_FQ@mail.gmail.com>
 <CAEf4BzY2z+oh=N0X26RBLEWw0t9pT7_fN0mWyDqfGcwuK8A-kg@mail.gmail.com>
 <20210511230505.z3rdnppplk3v3jce@ast-mbp.dhcp.thefacebook.com> <CAEf4BzbJ==4iUFp4pYpkgbKy40+Q6+RTPJVh0gUANHajs88ZTg@mail.gmail.com>
In-Reply-To: <CAEf4BzbJ==4iUFp4pYpkgbKy40+Q6+RTPJVh0gUANHajs88ZTg@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 13 May 2021 09:37:13 +0100
Message-ID: <CACAyw9-9CwzMPzZGOOs6RD5Rz4X+MsBkDE-y3FZuLCw1znSUEQ@mail.gmail.com>
Subject: Re: bpf libraries and static variables. Was: [PATCH v2 bpf-next 2/6]
 libbpf: rename static variables during linking
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 12 May 2021 at 19:50, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>

...

> So at least for BPF skeleton, the flow I was imagining would be
> like this.

Thank you for the worked out example, it's really helpful.

>
> 1. BPF library abc consists of abc1.bpf.c and abc2.bpf.c. It also has
> user-space component in abc.c.
> 2. BPF app uses abs library and has its own app1.bpf.c and app2.bpf.c
> and app.c for user-space.
> 3. BPF library author sets up its Makefile to do
>   a. clang -target bpf -g -O2 -c abc1.bpf.c -o abc1.bpf.o
>   b. clang -target bpf -g -O2 -c abc2.bpf.c -o abc2.bpf.o
>   c. bpftool gen lib libabc.bpf.o abc1.bpf.o abc2.bpf.o

I think we can plug this into bpf2go [1] on our side in the best case,
which would avoid duplicating the static linker.

>   d. bpftool gen subskeleton libabc.bpf.o > libabc.subskel.h
>   e. abc.c (user-space library) is of the form
>
> #include "libabc.subskel.h"
>
> static struct libabc_bpf *subskel;
>
> int libabc__init(struct bpf_object *obj)
> {
>     subskel = libabc_bpf__open_subskel(obj);
>
>     subskel->data->abc_my_var = 123;
> }
>
> int libabc__attach()
> {
>     libabc_bpf__attach(subskel);
> }
>
>   f. cc abc.c into libabc.a and then libabc.a and libabc.bpf.o are
> distributed to end user
>
> 3. Now, from BPF application author side:
>   a. clang -target bpf -g -O2 -c app1.bpf.c -o app1.bpf.o
>   b. clang -target bpf -g -O2 -c app2.bpf.c -o app2.bpf.o
>   c. bpftool gen object app.bpf.o app1.bpf.o app2.bpf.o libabc.bpf.o

I haven't worked out exactly how things would work, but on the Go side
it might be possible to distribute libabc.bpf.o plus the Go "library"
code as a package. So the Go toolchain would never create this merged
object, but instead do

    bpftool gen object app.bpf.o app1.bpf.o app2.bpf.o

and later link app.bpf.o and libabc.bpf.o at runtime. It would be
simpler from our side if bpftool gen object could link both libraries
and "programs", maybe we can discuss the details of this during office
hours.

1: https://pkg.go.dev/github.com/cilium/ebpf/cmd/bpf2go

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
