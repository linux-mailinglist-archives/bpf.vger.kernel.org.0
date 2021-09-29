Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EAB41D027
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 01:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347721AbhI2XvT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 19:51:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39630 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347701AbhI2XvT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 19:51:19 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5315020B87E7
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 16:49:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5315020B87E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1632959377;
        bh=rq+frOJopjrhqSQQ8JIptI5MqWLVobMWsWyHQwwI8To=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ET7RgEnJDq9Mbm9GI/E3KJicxv9JnxfXE/1n6vhafpiM9ZXBXwtIYICe1FRO6LLJS
         nIgENYIde74g4hI/Oe4nJUIxFm8umQyHnklIfapGrx8MpMhjxUdoiOujU2nkzdftdg
         vQ0vDJwXetHVeTaohxmsz/KqhE8/kgjjko3HIBNQ=
Received: by mail-pg1-f179.google.com with SMTP id 133so4405931pgb.1
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 16:49:37 -0700 (PDT)
X-Gm-Message-State: AOAM530NuCD3ygFMYzavoYQ5QDKdBhQPERmme2cAsuTg3LAjzRNE/NXE
        jwW2FMdl1TSj7NVQ4Vr5QPDm4RE7q5S3ZFhwFQ4=
X-Google-Smtp-Source: ABdhPJymRAGx4gHy5JD6MtsGzQwf8AePOzm9e5wW9BULJMCKAxwmmQvMg0T8QXR5CMZomjISebU02vqTYU0yTGDCoME=
X-Received: by 2002:a65:528a:: with SMTP id y10mr2223677pgp.103.1632959376847;
 Wed, 29 Sep 2021 16:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
 <20210917215721.43491-2-alexei.starovoitov@gmail.com> <20210928164515.46fad888@linux.microsoft.com>
 <20210928163730.7v7ovjhk7kxputny@ast-mbp.dhcp.thefacebook.com>
 <20210928191103.193a9c62@linux.microsoft.com> <CAADnVQ+ajFPKfP+Q5WQFztfZ+05uGgbuQk3H8_9OTny=0vku=g@mail.gmail.com>
 <CAFnufp3hx0CaF=ukCXY3UJj0omVX+5WWk0=-QuENvTPGye_sKA@mail.gmail.com>
 <20210929193858.57ba3cd1@linux.microsoft.com> <CAADnVQJjHyB1CwquYx2X2uMGygEpFJhNh75gPcHnYkD2pLmcDA@mail.gmail.com>
In-Reply-To: <CAADnVQJjHyB1CwquYx2X2uMGygEpFJhNh75gPcHnYkD2pLmcDA@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Thu, 30 Sep 2021 01:49:01 +0200
X-Gmail-Original-Message-ID: <CAFnufp07EHqc0wgv0V2H5yMfdw-9diPOX6RS_z+k1iJV+LJ=Kw@mail.gmail.com>
Message-ID: <CAFnufp07EHqc0wgv0V2H5yMfdw-9diPOX6RS_z+k1iJV+LJ=Kw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 01/10] bpf: Prepare relo_core.c for kernel duty.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Matteo Croce <mcroce@microsoft.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 30, 2021 at 1:01 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Sep 29, 2021 at 10:39 AM Matteo Croce
> <mcroce@linux.microsoft.com> wrote:
> > > >
> > > > I'll take a look. Could you provide the full .c file?
> > >
> > > Sure. I put everything in this repo:
> > >
> > > https://gist.github.com/teknoraver/2855e0f8770d1363b57d683fa32bccc3
>
> This gist is not a reproducer. It doesn't have a single CO-RE relo.
>
> But I've hacked it with dev->ifindex like in your email above
> and managed to repro.
> My error is different though:
> [ 1127.634633] libbpf: prog 'prog_name': relo #0: trying to relocate
> unrecognized insn #0, code:0x85, src:0x0, dst:0x0, off:0x0, imm:0x7
> [ 1127.636003] libbpf: prog 'prog_name': relo #0: failed to patch insn #0: -22
>
> But there is a bug. Debugging...

Oops, I forget to force push, sorry..
I've updated the gist, even if you managed to reproduce a similar error.

Regards,
-- 
per aspera ad upstream
