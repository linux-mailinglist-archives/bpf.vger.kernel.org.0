Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D6A43BBDA
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 22:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbhJZUwT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 16:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239292AbhJZUwS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 16:52:18 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358F5C061745
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 13:49:54 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id b9so795497ybc.5
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 13:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YjZ5EhhGdLze14LFEduv1EBHlZE3EpZeVNXD2k5fQRk=;
        b=dFipTbfKKvH35GJHbcTdBTlCQCFEv1PEcu6861y2NkhUuNiQRzfnaxSRp6XXRmzcVk
         5arUmvVKmDJd0BvVI+DC8YncBi7kG9OChGkMD85j8ES/8HamvfFHjAuMuaJygXGzK9Ei
         HFVrxip7I08OTbkprXxXITYdemjDUcCESLUH2h0pQqd3P7Klrna9xcZ+a/ArtepX55ui
         VNNv+Npva2gc0JA+3pkXSD8N7SqjIH5Fir+eywbBltz97yVj8Nc7IBPaAKT2zcX8BNMH
         tu/IibD8X7qqKphSdvkSDcE2eh9g+YZocgImgpj1B+eomdUGNeHJbIu15s0SBH1PB3vd
         IRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YjZ5EhhGdLze14LFEduv1EBHlZE3EpZeVNXD2k5fQRk=;
        b=F0LnFqDONe7rrgQDvYJEkjc3Qrr7ejPUBX0uWynJ1qoaWVffe+DEn9Ub4OBFgKievo
         2r28GIRMS0/HyErgcQBY1wwnzi9p9rZcGBg96cDmyIho3SYziiM0ck4GMh5AtfAOwiQc
         Vr/tHQAT6NBCSnPdGPoiwvhgGNin/timwBsVUuMgJ+O1WR4vtl7tMCWyDr/1265nL9kZ
         Fbxjuwx1cejtyMXvFH6trXHT8NEeAtQDITdORSUbMYw/z0PZBrIkcmusa0g3EvwehniZ
         6Uct5GvejS4AxHKjEPnGxSYUTLLplTKGMSR/6zmiP+ad4gkITFO1BD41SFcvkpxeFzrZ
         Rw1w==
X-Gm-Message-State: AOAM531zQ6LnvJKCrZ7MDthgyvqvm107XEiGe9zEl77JI/yKMnA1MKuu
        RjU3j/kzF/h+kFsYDzgI4GSSwqkC17EXetcU8eeT1A==
X-Google-Smtp-Source: ABdhPJxipC0mZsczaIymyyOS4rorEYxFNbMgZwIB5gRsXHweUa8Ez2ZGn7D4RMzvEkwL+lmbNv9vqtiC5Lxx7aw5zbw=
X-Received: by 2002:a25:e652:: with SMTP id d79mr25797519ybh.291.1635281393128;
 Tue, 26 Oct 2021 13:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211026203825.2720459-1-eric.dumazet@gmail.com>
 <20211026203825.2720459-2-eric.dumazet@gmail.com> <CAADnVQKOXXf4vSKYF2+One8PLfva06d4USdTjQj72S7+czhd_Q@mail.gmail.com>
In-Reply-To: <CAADnVQKOXXf4vSKYF2+One8PLfva06d4USdTjQj72S7+czhd_Q@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 26 Oct 2021 13:49:41 -0700
Message-ID: <CANn89iKFE5kLmRUqRcsJz5ijR5k-nhkhPM6puqHifN+FcKOhiw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: avoid races in __bpf_prog_run() for 32bit arches
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 1:43 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 26, 2021 at 1:38 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> > From: Eric Dumazet <edumazet@google.com>
> >
> > __bpf_prog_run() can run from non IRQ contexts, meaning
> > it could be re entered if interrupted.
> >
> > This calls for the irq safe variant of u64_stats_update_{begin|end},
> > or risk a deadlock.
> >
> > This patch is a nop on 64bit arches, fortunately.
>
> u64_stats_update_begin_irqsave is a nop. Good!
> We just sent the last bpf tree PR for this cycle.
> We'll probably take it into bpf-next after CI has a chance to run it.

Great, this means I can add the followup patch to the series.
