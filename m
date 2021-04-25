Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719AF36A909
	for <lists+bpf@lfdr.de>; Sun, 25 Apr 2021 21:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhDYTd4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Apr 2021 15:33:56 -0400
Received: from l2mail1.panix.com ([166.84.1.75]:59969 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhDYTd4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Apr 2021 15:33:56 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4FSySz3gfQzDjg;
        Sun, 25 Apr 2021 15:17:07 -0400 (EDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4FSySy3clvzSNw;
        Sun, 25 Apr 2021 15:17:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1619378226; bh=XhZeMGV3zn3KbXb4vXiIiqcwTRwZv6RkFQ/y5sRLQ54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=UChIu6fy15PFybZhRlSS4vrq054UVvqJdU+KyBlRIxDTTEMHxGg67D25N0JFbLdVR
         Kpz2r1rpi9w8L0pujDrTE5VNtc1dOAgk9Q+U0GRptV9ZEyiYrybQdA9biZxvkpUBjM
         zYgAEqqXpozo0XtOvTFPBBXgir5C57DjzTdcc/cY=
Received: by mail-yb1-f171.google.com with SMTP id p202so18428452ybg.8;
        Sun, 25 Apr 2021 12:17:06 -0700 (PDT)
X-Gm-Message-State: AOAM532wkqOoWBIjPeoDxhJuTOFDCRwJFb7Sgby9eKFfY5ZT+I1fXHPP
        SxnpyKjV7HFe61q+BpWqy/RWtLP2/mw4vk7EMqA=
X-Google-Smtp-Source: ABdhPJztPCPXO7s31JTURrUaXheP5N6/ezQIspG2gIv0gIdLsrS/RpqygJaJ2EKeEgLkyzpRG1xzKDeBit2LpklR234=
X-Received: by 2002:a5b:34a:: with SMTP id q10mr19917362ybp.224.1619378226198;
 Sun, 25 Apr 2021 12:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <CAADnVQLf4qe3Hj7cjBUCY4wXb9t2ZjUt=Z=JuygRY0LNNHWAoA@mail.gmail.com> <78af3c302dd5447887f4a14cd4629119@AcuMS.aculab.com>
In-Reply-To: <78af3c302dd5447887f4a14cd4629119@AcuMS.aculab.com>
From:   Zack Weinberg <zackw@panix.com>
Date:   Sun, 25 Apr 2021 15:16:54 -0400
X-Gmail-Original-Message-ID: <CAKCAbMgJBRKc+kszT-foDtOQC6Q1veOuxC_a1aX_Qt4PTCpEkg@mail.gmail.com>
Message-ID: <CAKCAbMgJBRKc+kszT-foDtOQC6Q1veOuxC_a1aX_Qt4PTCpEkg@mail.gmail.com>
Subject: Re: [RFC] bpf.2: Use standard types and attributes
To:     David Laight <David.Laight@aculab.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        bpf <bpf@vger.kernel.org>, linux-man <linux-man@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 24, 2021 at 4:43 PM David Laight via Libc-alpha
<libc-alpha@sourceware.org> wrote:
> From: Alexei Starovoitov
> > On Fri, Apr 23, 2021 at 4:15 PM Alejandro Colomar <alx.manpages@gmail.com> wrote:
...
> > > Some pages also document attributes, using GNU syntax
> > > '__attribute__((xxx))'.  Update those to use the shorter and more
> > > portable C2x syntax, which hasn't been standardized yet, but is
> > > already implemented in GCC, and available through either --std=c2x
> > > or any of the --std=gnu... options.
..
> And the code below is no more portable that a #pragma'.
> It is probably worse than __attribute__((aligned(8)))
> +            uint64_t [[gnu::aligned(8)]] value;
> The standards committee are smoking dope again.
> At least the '__aligned_u64 value;' form stands a reasonable
> chance of being converted by cpp into whatever your compiler supports.

Is it actually necessary to mention the alignment overrides at all in
the manpages?  They are only relevant to people working at the level
of physical layout of the data in RAM, and those people are probably
going to have to consult the header file anyway.

zw
