Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE42664A6B
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2019 18:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfGJQEV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Jul 2019 12:04:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42762 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfGJQEV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Jul 2019 12:04:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id h18so2977376qtm.9
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2019 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DJHQQHfctysvJIeqrC4PEtSxL+/U0tkGdTWQfnGNPBM=;
        b=tnjRkLKbeGy68vuP5gA6CvfZh2tvTXZErscOFln2WK2pLq7qQiCEKGnofn8kqMFZ4n
         D82ohmqG8CGIvqRQSJZB0T1gWBCQfHh3SK9XKn3qJgddL0D8WqkH1P+yt+0RCvPI3zDW
         5IlaH9KvRVTuTZvFCac8ldsePUULWiVI4uL3YBNjemaQuDjtvPnCsIHH4xIQNy6jsk+M
         /sxv5VqzgM59hSZUwS5N0astbKCyYZhUIZKVSUXqQ0MM71KBwwxC1NC73wq2OxTZcHBC
         reP1KJWk+yVzLR+8PpuEOPAEIj6hmnJnHw3mrwYRqXY4zLbUxNt9ruUSYqQC8jQKZv9U
         Wb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DJHQQHfctysvJIeqrC4PEtSxL+/U0tkGdTWQfnGNPBM=;
        b=ZhnXTLzGNw3BHRSV5yWwMBB6dcbYyKAz1TYhUqNG6ZfV8z4fbaUYZRbF13T2RoLK0s
         0QpipAcvbwQqSU6hxvtH9wEqZsXkGUWnS1UPyQL6ylBsaFXVE85gx/ZKPoKFHTtN3NyX
         xpECuVsKsER+vHuRvBUoMUMLlhnE0DmeCpJgOakMLxT0goxzwdgq/jEOukYiiCc9Ajbs
         f1izWDAQjVHJEaf/iSwib9tZnP5ki60zMm2//+suKdG5opIIBDLVXGMI+rf6KDZLKvfz
         iwQoxLVV82NT6j94e+0UDyQD5LMAoWubH4DkQFU5ta9dBcQDZglrpmecuMbYmzsd8hdZ
         m8KA==
X-Gm-Message-State: APjAAAVoGZ6TLgFy7Kf5JQe0rkUPsxH/OQrCj7eUDjW4jCY1g6vhAp1D
        oiJDXgMj4JPIBqv02HS5RqU/o7i7CK2EoAjzLsM=
X-Google-Smtp-Source: APXvYqxM4dDK3n+u5KVpnF2K6yDua/BH0sbg7NCDhHz8U+AmzSuqQJegcT2SdejqiKDopHGmAqazPreO+0WJ1nDP1s8=
X-Received: by 2002:ac8:290c:: with SMTP id y12mr23793093qty.141.1562774659678;
 Wed, 10 Jul 2019 09:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4Bzb3BKoEcYiM3qQ6uqn+bZZ7kO2ogvZPba7679TWFT4fmw@mail.gmail.com>
 <20190701184025.25731-1-iii@linux.ibm.com> <cc418117-32a7-b7aa-3570-29b1b3421303@iogearbox.net>
 <59B1630A-537D-43A1-B75C-87BE80709F93@linux.ibm.com> <CAEf4BzZEs24=Cp8CdQiXtGXCcMtW430ER7wDHND7YA7OVfz3XA@mail.gmail.com>
 <AAD094D8-EB0A-4464-B180-0293816B8DF8@linux.ibm.com>
In-Reply-To: <AAD094D8-EB0A-4464-B180-0293816B8DF8@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Jul 2019 09:04:08 -0700
Message-ID: <CAEf4BzaDWsPnEQtvnsomLT02yO3XTYsp1bUN9KGgjuw-C742bA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: do not ignore clang failures
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Song Liu <liu.song.a23@gmail.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 10, 2019 at 6:25 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> > Am 09.07.2019 um 20:14 schrieb Andrii Nakryiko <andrii.nakryiko@gmail.c=
om>:
> >
> > On Mon, Jul 8, 2019 at 8:01 AM Ilya Leoshkevich <iii@linux.ibm.com> wro=
te:
> >>
> >>> Am 05.07.2019 um 16:22 schrieb Daniel Borkmann <daniel@iogearbox.net>=
:
> >>>
> >>> On 07/01/2019 08:40 PM, Ilya Leoshkevich wrote:
> >>>> Am 01.07.2019 um 17:31 schrieb Andrii Nakryiko <andrii.nakryiko@gmai=
l.com>:
> >>>>> Do we still need clang | llc pipeline with new clang? Could the sam=
e
> >>>>> be achieved with single clang invocation? That would solve the prob=
lem
> >>>>> of not detecting pipeline failures.
> >>>>
> >>>> I=E2=80=99ve experimented with this a little, and found that new cla=
ng:
> >>>>
> >>>> - Does not understand -march, but -target is sufficient.
> >>>> - Understands -mcpu.
> >>>> - Understands -Xclang -target-feature -Xclang +foo as a replacement =
for
> >>>> -mattr=3Dfoo.
> >>>>
> >>>> However, there are two issues with that:
> >>>>
> >>>> - Don=E2=80=99t older clangs need to be supported? For example, righ=
t now alu32
> >>>> progs are built conditionally.
> >>>
> >>> We usually require latest clang to be able to test most recent featur=
es like
> >>> BTF such that it helps to catch potential bugs in either of the proje=
cts
> >>> before release.
> >>>
> >>>> - It does not seem to be possible to build test_xdp.o without -targe=
t
> >>>> bpf.
> >>>
> >>> For everything non-tracing, it does not make sense to invoke clang w/=
o
> >>> the -target bpf flag, see also Documentation/bpf/bpf_devel_QA.rst +57=
3
> >>> for more explanation, so this needs to be present for building test_x=
dp.o.
> >>
> >> I'm referring to the test introduced in [1]. test_xdp.o might not be a=
n
> >> ideal target, but even if it's replaced with a more suitable one, the
> >> llc invocation would still be required. So I could redo the patch as
> >> follows:
> >>
> >> - Replace test_xdp.o with get_cgroup_id_kern.o, use an intermediate .b=
c
> >>  file.
> >> - Use clang without llc for all other eBPF programs.
> >> - Split out Kbuild include and order-only prerequisites.
> >>
> >> What do you think?
> >
> > How about just forcing llc to fail as well like this:
> >
> > (clang <whatever> || echo "clain failed") | llc <whatever>
> >
> > While not pretty, it will get us what we need with very clear
> > messaging as well. E.g.:
> >
> > progs/test_btf_newkv.c:21:37: error: expected identifier
> > PF_ANNOTATE_KV_PAIR(btf_map_legacy, int, struct ipv_counts);
> >                                    ^
> > progs/test_btf_newkv.c:21:1: warning: type specifier missing, defaults
> > to 'int' [-Wimplicit-int]
> > PF_ANNOTATE_KV_PAIR(btf_map_legacy, int, struct ipv_counts);
> > ^
> > 1 warning and 1 error generated.
> > llc: error: llc: <stdin>:1:1: error: expected top-level entity
> > clang failed
> > ^
>
> While this would definitely work at least in my scenario, what about the
> following hypothetical cases?
>
> - clang manages to output something before exiting with nonzero rc
> - future llc version exits with zero rc when given "clang failed" or any
>   other arbitrary string as an input (perhaps, with just a warning?)

This seems very far-fetched. While I can imagine partial output from
clang, I can't imagine accepting some garbage as an input for llc and
yet returning zero exit code. That would be major regression, so I
wouldn't worry about it.

>
> Come to think of it, what are the downsides of having intermediate
> bitcode files? While I did not run into this yet, I could imagine it
> might be even useful from time to time to inspect them.

Main downside is complication of Makefile, which is not the simplest
to follow already. So if we can solve problem in simpler way without
adding more complexity, that would be my preferred way.

If someone wants bitcode, when you do `make`, you see all the commands
that are being run, so just copy/paste parts you care about (i.e.,
clang invocation). That's what I do when I need to repro something for
single .o file, for instance.

>
