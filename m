Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857A33FCFCF
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 01:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhHaXM1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 19:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhHaXM1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Aug 2021 19:12:27 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3A1C061575
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 16:11:31 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id z5so1599857ybj.2
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 16:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w7EJ5rjRWO4ALKigy5lPIOz8Ix5Cpu3v0W2cO3eEUSI=;
        b=dQO466/msDMp8HNUeg7XjsOZzcOveaFKlFfiv5Sp5KNd4mkxeoJSg8mms4iAyN44RG
         rY0mrdFweuuUWcOlZei4rFgRwVyUb1kxhj+HeMqWQ/SafQeFUHuERpJn9hMCrfXJL5Vu
         tXEPVTx6ErFUur75vXewXsIelCZSpxWe/tj1HrarKRNMgI93YpkuzsN1F1cdbEndSTKT
         euzQs6TFaNRlLbVLaVyScwbPsens5lE/nqToxR2sv2iivRJ3hY7rW/yXnW/ozvMOPoT6
         pZLgCr/L9KC6FcUixOcgp0IJrW/4xH1XnWtGDnbZxtD3rXlkbC0JWcQ3pQW8d2arOkZz
         DqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w7EJ5rjRWO4ALKigy5lPIOz8Ix5Cpu3v0W2cO3eEUSI=;
        b=I68r220aOrfcKjuzxDDo/wGkc4mYoqiJViR2DrRbTurSDpNxqEWPUGfy1TxGMXRjC8
         /+RKPpisUtLazioAHPLeaFjJ7B1NZMm+I+FDwduzwujb3paCdfCGuUS6TdE5i10x56OT
         5bPx4NJdTqsR2aLjpnupgOYE9JWbN8IbKnO+mQzTRZDh6Ojrm3ial9iuSKJHCl2WTL/X
         yqWMilUzF7AMsp6Y4I1TYCP3GBRCieu4+eAHZFVw8iVH9pvvA0G1p2CxreHujOj97eAH
         cD7ZFMkxwoKriWXppM0J1lJnNSxdm7js/b5qp6qWc3I1f7BX5b9VZl+arVEvvkj8YBBt
         VMeA==
X-Gm-Message-State: AOAM530LnEL7gfdRuCqQtu/82BnRkoUNKuuPL1/rzY7Gpv7OmRiS0n0O
        C+MP9MED2vK834oh7vUWZAcGkIFVe4WWFSGUjqWXZclDAWw=
X-Google-Smtp-Source: ABdhPJyb9oJM0rHpRHbQBpz4DjtSyKG/AcVTMSzFcQtl+CVFyclfU1ognpdA9zkOmPXIbDOdsW6mKHiEgzumzEAD3LY=
X-Received: by 2002:a25:16c6:: with SMTP id 189mr33713119ybw.27.1630451490122;
 Tue, 31 Aug 2021 16:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210826120953.11041-1-toke@redhat.com> <CAEf4BzZ7dcYrGRgOczk-mLC_VcRW3rucj3TRgkRqLgKXFHgtog@mail.gmail.com>
 <87lf4hvrgc.fsf@toke.dk>
In-Reply-To: <87lf4hvrgc.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 Aug 2021 16:11:19 -0700
Message-ID: <CAEf4BzZxar7oEiXUTSxV_H1GbuJMN6gxGVC9xMFX6PdKzK49+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: ignore .eh_frame sections when
 parsing elf files
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 3:28 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Thu, Aug 26, 2021 at 5:10 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
> >>
> >> When .eh_frame and .rel.eh_frame sections are present in BPF object fi=
les,
> >> libbpf produces errors like this when loading the file:
> >>
> >> libbpf: elf: skipping unrecognized data section(32) .eh_frame
> >> libbpf: elf: skipping relo section(33) .rel.eh_frame for section(32) .=
eh_frame
> >>
> >> It is possible to get rid of the .eh_frame section by adding
> >> -fno-asynchronous-unwind-tables to the compilation, but we have seen
> >> multiple examples of these sections appearing in BPF files in the wild=
,
> >> most recently in samples/bpf, fixed by:
> >> 5a0ae9872d5c ("bpf, samples: Add -fno-asynchronous-unwind-tables to BP=
F Clang invocation")
> >>
> >> While the errors are technically harmless, they look odd and confuse u=
sers.
> >
> > These warnings point out invalid set of compiler flags used for
> > compiling BPF object files, though. Which is a good thing and should
> > incentivize anyone getting those warnings to check and fix how they do
> > BPF compilation. Those .eh_frame sections shouldn't be present in BPF
> > object files at all, and that's what libbpf is trying to say.
>
> Apart from triggering that warning, what effect does this have, though?
> The programs seem to work just fine (as evidenced by the fact that
> samples/bpf has been built this way for years, for instance)...
>
> Also, how is a user supposed to go from that cryptic error message to
> figuring out that it has something to do with compiler flags?

Google and find discussions like these?.. I don't think libbpf error
messages have to include intro into DWARF and .eh_frame.

Just googling ".eh_frame" gives me [0] as a first link, which seems to
describe what it is and how to get rid of it.

  [0] https://stackoverflow.com/questions/26300819/why-gcc-compiled-c-progr=
am-needs-eh-frame-section

>
> > I don't know exactly in which situations that .eh_frame section is
> > added, but looking at our selftests (and now samples/bpf as well),
> > where we use -target bpf, we don't need
> > -fno-asynchronous-unwind-tables at all.
>
> This seems to at least be compiler-dependent. We ran into this with
> bpftool as well (for the internal BPF programs it loads whenever it
> runs), which already had '-target bpf' in the Makefile. We're carrying
> an internal RHEL patch adding -fno-asynchronous-unwind-tables to the
> bpftool build to fix this...

So instead of figuring out why your compilers cause .eh_frame
generation (while they shouldn't), you are trying to hide the warning
in libbpf? This hasn't been the problem in production apps at
Facebook, nor with libbpf-tools or libbpf-bootstrap apps. Which just
makes me keep this warning more. Once we support multiple
.rodata/.data/.bss sections for libbpf, I think I'll turn all those
unrecognized sections into actual errors. I'd rather not have unknown
sections being just ignored by libbpf. Someday we might actually use
.eh_frame with BPF objects, that's when this will become not an error
or warning.

>
> > So instead of hiding the problem, let's use this as an opportunity to
> > fix those user's compilation flags instead.
>
> This really doesn't seem like something that's helping anyone, it's just
> annoying and confusing users...

Warnings like "libbpf: elf: skipping unrecognized data section(4)
.rodata.str1.1" annoy me as well, and that's one of the reasons I'll
add support for multiple .rodata sections. So annoying is fine, it
raises awareness and incentivizes fixing the problem.

>
> -Toke
>
