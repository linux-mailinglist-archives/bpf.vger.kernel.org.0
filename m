Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48C625A246
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 02:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBA3Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Sep 2020 20:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBA3Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Sep 2020 20:29:16 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57313C061244
        for <bpf@vger.kernel.org>; Tue,  1 Sep 2020 17:29:16 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id c17so1902124ybe.0
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2020 17:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1E1gk1XBS9BBka7KthAcYPF0o72m+yKDkUrp6VcVfcY=;
        b=WBVbDIyEt2Vdwxq9tH+cdLKDGU/hkWeI/JTqPfVPtJiIqtTAHawyPGgfoF7Cwkfc0h
         qahqrLIJUVL6uFKTZzMal//k3WvTeGSrlyfwVj03Mu3kWwR2SlByw6w6a9CFVzlQ4ZEk
         m2KvzGQ/KoJyZfzKfcQLE+do2i5JpTkuZykBzFf1rIcej7FFVW/pLlGawhWINo3qFhL7
         sEUliTCZCFtdfIVaj9CDstpV4mGjDvkSRnctVUOybuMUn5fzLWbxQe6n2kSiQx3TdjON
         13AIdpsvgjo9jeWsth2ne/rp8oUKVN/suWsFSFytXcYLUEaFu8yr/ax0JYAOmtono47v
         Tgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1E1gk1XBS9BBka7KthAcYPF0o72m+yKDkUrp6VcVfcY=;
        b=VUFMwCABTaVHhEoIS3CAsla9nMKR6iZ8ejz/z1h/ObAXg07BJmcrflJDoE6UreA1eS
         rYJDZF89R5FAVwPocvuzaDHmElqdZqckSGqe/aaoDYHv4TEdSnJ+EcSuHEFFI3TmJ75+
         GF4nZaaXjjdbIzQjzmZBeCGQTGRh8Dio1B9wSO0xUFLh84kqEaKS6OJ3FiHeb/Xk/hrN
         wFkZgONUHQDrgZ00EsRg+RUVT26SXMeV4Y+1mA8WazWJi2OV+9pY1VepWyHAgwiExmas
         6zdKPLcZBqMi67I3ROCuFFOJYJA9ekHDqGBl+H48SdX+Ys2vlpH2k1z+XFtK6Sow2Ph8
         Sh1g==
X-Gm-Message-State: AOAM531riJa4Sb6jbWfJJueRzxRhOIH3uq8RV4HoySK8dIKVUuSQLvZf
        mTUwL8QusSjBMfQ+gudVrfoCR+iWU+Prn0JNhPA=
X-Google-Smtp-Source: ABdhPJw1ul0yPC/L74Ndc/aSsZZchqye9vrcnIGTFnojGHTBFeHJnAFlvjZVpyq9UNdVhJiGQdxCzGvzx7iNTLo0O0Q=
X-Received: by 2002:a25:cb57:: with SMTP id b84mr2622023ybg.425.1599006555375;
 Tue, 01 Sep 2020 17:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeTCaWAs9gX_Y17gXJhSVvsbuJF2aD3Tfi9+79JmndF2ERmOw@mail.gmail.com>
 <e21c4dd9-9336-017f-752e-5b83704d86bf@fb.com> <CAGeTCaUtECKWZP2UpbeHNhrJgWRQkh0yfUimGnWVF4Q=K1iYkg@mail.gmail.com>
In-Reply-To: <CAGeTCaUtECKWZP2UpbeHNhrJgWRQkh0yfUimGnWVF4Q=K1iYkg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Sep 2020 17:29:04 -0700
Message-ID: <CAEf4BzbXvGLYLEeS7NjRG3YdYrMbKQSweNJ=c2uJgga5D-hY3w@mail.gmail.com>
Subject: Re: perf event and data_sz
To:     Borna Cafuk <borna.cafuk@sartura.hr>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 27, 2020 at 3:02 AM Borna Cafuk <borna.cafuk@sartura.hr> wrote:
>
> On Wed, Aug 26, 2020 at 8:45 PM Yonghong Song <yhs@fb.com> wrote:
> >
> > On 8/26/20 7:11 AM, Borna Cafuk wrote:
> > > Hi everyone,
> > >
> > > When examining BPF programs that use perf buffers, I have noticed that
> > > the `data_sz` parameter in the sample callback has a different value than
> > > the size passed to `bpf_perf_event_output`.
> > >
> > > Raw samples are padded in `perf_prepare_sample` so their size is a multiple of
> > > `sizeof(u64)` (see [0]). The sample includes the size header, a `u32`.
> > > The size stored in `raw->size` is then size of the sample, minus the 4 bytes for
> > > the size header. This size, however, includes both the data and the padding.
> > >
> > > What I find confusing is that this size including the padding is eventually
> > > passed as `data_sz` to the callback in the userspace, instead of
> > > the size of the data that was passed as an argument to `bpf_perf_event_output`.
> > >
> > > Is this intended behaviour?
> >
> >  From the kernel source code, yes, this is expected behavior. What you
> > described below matches what the kernel did. So raw->size = 68 is expected.
>
> I understand why this size that is stored in `raw->size` is needed.
> What I don't see is how the value is of any use in the callback.
>
> >
> > >
> > > I have a use-case for getting only the size of the data in the
> > > userspace, could this be done?
> >
> > In this case, since we know the kernel writes one record at a time,
> > you check the size, it is 68 more than 62, you just read 62 bytes
> > as your real data, ignore the rest as the padding. Does this work?
>
> The `data_sz` parameter seems a little pointless, then. What is its purpose
> in the callback if it doesn't accurately represent the size of the data?
>
> >
> > bcc callback passed the the buffer with raw->size to application.
> > But applications are expected to know what the record layout is...
>
> I'm afraid that wouldn't work for the use-case, our application should be able
> to read the raw data without having to know the record layout. It has to be
> generic, we handle interpreting the records elsewhere and at another time.

I agree it's confusing and less useful (not exactly useless, though),
but seems like PERF_SAMPLE_RAW doesn't store neither original size nor
(equivalently) the added padding size, so libbpf has nothing to go off
of, unfortunately.

I can only offer two suggestions:
1. Make sure samples you are emitting are 8 byte aligned, in which
case data_sz will always match actual data size. If you need different
sizes for different structs, you'd have to artificially add extra
bytes, though.
2. Consider using BPF ringbuf, it's data_sz is exact and doesn't
include padding (you need 5.8+ kernel).

>
> >
> > >
> > > To demonstrate, I have prepared a minimal example by modifying
> > > BCC's filelife example. It uses a kprobe on vfs_unlink to print some sizes
> > > every time a file is unlinked. The sizes are:
> > >   * the `sizeof(struct event)` measured in the userspace program,
> > >   * the `sizeof(struct event)` measured in the BPF program, and
> > >   * the `data_sz` parameter.
> > >
> > > The first two are 62, as expected, but `data_sz` is 68.
> > > The 62 bytes of the struct and the 4 bytes of the sample header make 66 bytes.
> > > This is rounded up to the first multiple of 8, which is 72.
> > > The 4 bytes for the size header are then subtracted,
> > > and 68 is written as the data size.
> > >
> > > Any input is much appreciated,
> > >
> > > Best regards,
> > > Borna Cafuk
> > >
> > >
> > > [0] https://github.com/torvalds/linux/blob/6a9dc5fd6170d0a41c8a14eb19e63d94bea5705a/kernel/events/core.c#L7035
> > >
> > >
> > > example.h

[...]
