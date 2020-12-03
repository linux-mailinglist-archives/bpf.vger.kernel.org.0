Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63762CDFC3
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 21:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgLCUfw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 15:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgLCUfw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 15:35:52 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01131C061A4F
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 12:35:12 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id x2so3249012ybt.11
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 12:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ldc6B+v+tau+/f/rY+pmidYRNTvPkodsXO48z3rDebU=;
        b=SoDtwp3iTQMxztUKflx6qPBXUJVyuL3b+OdRsd0gwwcfuWz0HNIHkmXncdpH6/Z5yy
         KpTiMQTe2JcpxRyCgNUoaI39gnoXkPkncdh7B6KCh1JCmN5zeMW33l8ncUB6w7S0ho/c
         ba6OclAxMG/rbq9Nh70+D9MRzTkgkZgWDvSdsIVGm1P4p33Zat64QNftX4DzaC4VMADK
         a0HV5kpMwj1OeCkT+lElC71MY8FrGLAlQ/GNvIV8ffYUb5C3y7wxnkVzREjdrrOGkm2/
         T1D/+YOINDIPTNvvCpfbGCsxCms5NW8wp+i635LqYSoV9KJU4+uVWaBaYssCx9Dq3I7d
         wzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ldc6B+v+tau+/f/rY+pmidYRNTvPkodsXO48z3rDebU=;
        b=ScWc0R9c4Ac1mffidrTc7xcCxQQexMKMfBWh9Wal+eR08Pw/+2Y9KWh1cwzg7/Oy3L
         SN0UhPIYEcVM50dJxumqSovJmw0VYqU54Y2xFXwk275PNQLX2ENt47Oz3JPFuiJVSbNm
         QdiN+Lbs3KK1SPBIy/iO10pox6YoJTlSWfzNzVc4wSzyJYvEbyfkqDa07m961Q1dCVna
         ebfhqggUQECBIHx4w8IOeMdYC/Pz0QtuCP3eFIuofCKxk06AsY+tYQPQB9d4KJ2J/Y5g
         OigxL5TmpJBLHznZnbe476TVidTr5TaejVgy5fnI3XTw4COCUrA3Lrnnf6Hq00t2uazP
         mc5g==
X-Gm-Message-State: AOAM5305UwiYOlTafQ9ioRmek1Cva+3MT06QxAM/9JDW5WoVwiygx78Y
        hW/MPuCD8esDdHitR5xci/Nbw73mDNO8FpKcudc=
X-Google-Smtp-Source: ABdhPJzrcEFQkClvm+4tpiBdajVnmB9XiYcEFUYDXgI0sU5WIkpp3XxiPP8OFzuDkENw6aqtwDgn2tdxFFDODAthsuc=
X-Received: by 2002:a25:df82:: with SMTP id w124mr1298461ybg.347.1607027711246;
 Thu, 03 Dec 2020 12:35:11 -0800 (PST)
MIME-Version: 1.0
References: <CAO__=G52s_=2E4wF8wDcgc3KwMU0kzmDfBQhDD3+LMZ8M3fZ8w@mail.gmail.com>
In-Reply-To: <CAO__=G52s_=2E4wF8wDcgc3KwMU0kzmDfBQhDD3+LMZ8M3fZ8w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Dec 2020 12:35:00 -0800
Message-ID: <CAEf4BzbKtAcO81ZvxOJwhpOKauDQ==Y+Bcvy4_QAF3FZyLbMeg@mail.gmail.com>
Subject: Re: Problem with BPF_CORE_READ macro function
To:     David Marcinkovic <david.marcinkovic@sartura.hr>
Cc:     bpf <bpf@vger.kernel.org>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 4:20 AM David Marcinkovic
<david.marcinkovic@sartura.hr> wrote:
>
> Hello everyone,
>
> I am trying to run a simple BPF program that hooks onto
> `mac80211/drv_sta_state` tracepoint. When I run the program on the arm
> 32 bit architecture,
> the verifier rejects to load the program and outputs the following error
> message:
>
> Unrecognized arg#0 type PTR
> ; int tp__mac80211_drv_sta_state(struct trace_event_raw_drv_sta_state* ct=
x)
> 0: (bf) r3 =3D r1
> 1: (85) call unknown#195896080
> invalid func unknown#195896080
>
> This error does not seem to occur on the amd64 architecture. I am
> using clang version 10 for both, compiling on amd64 and
> cross-compiling for arm32.
>
>
> I have prepared a simple program that hooks onto the
> `mac80211/drv_sta_state` tracepoint.
> In this example, `BPF_CORE_READ` macro function seems to cause the
> verifier to reject to load the program.
> I've been using this macro in various different programs and it didn't
> cause any problems.
> Also, I've been using packed structs and bit fields in other programs
> and they also didn't cause any problems.
>
> I tried to use BPF_CORE_READ_BITFIELD as stated in this patch [0] and
> got a similar error.
>
> Any input is much appreciated,
>

Can you provide libbpf debug output, especially the section about
CO-RE relocations? Could it be that this tracepoint is inside the
kernel module?

> Best regards,
> David Mar=C4=8Dinkovi=C4=87
>
>
> [0] https://lore.kernel.org/bpf/20201007202946.3684483-1-andrii@kernel.or=
g/T/#ma08db511daa0b5978f16df9f98f4ef644b83fc96
>
>

[...]
