Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAAE26B6E4
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 02:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgIPANd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 20:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbgIPANO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 20:13:14 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E330EC06174A
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 17:13:12 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id m17so6278733ioo.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 17:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K16SS9rcPXwS/KBnQsaiiaLjK9KWOSN5Uw5UgElGEE4=;
        b=RM4StYvI2cYuO7L8XUXzRU2wmAiwjmtIjwTmr4k19e++1WqPgmUjascPUP0w4VqkrH
         tViLRoFMbM6+6SjFyPBJN5ij2KEkqAozyPfPN3Jw4GDzCv/8UvK7gSdDYjA2MdrZmzBX
         OCV34G5VlHwCVy039uJ9r9l84x6tIXTZGNF7zUAHQeBzlWUeL6wxOq0GnKqblY3pHhsW
         pdwvatPLB1QmHqvXmCdvc3ihgomB8cLhlvPzr+HtMGQqRxgVBBIShClFlSnVWsAg1Qsn
         vcgyKbKpienH/klJNOy/KzryUVTkynSi8pTvQS0mhy3I3QlkyhzFDRYvhozjWuhzqtA1
         u5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K16SS9rcPXwS/KBnQsaiiaLjK9KWOSN5Uw5UgElGEE4=;
        b=b0D3WyFaNlLWOPNPOvi1x1INKFidZ4ef70X2HNvre6D3c60baQKFdkjl1Fmq4UdCM/
         e5EN7ck97kzxj6fkviq9vtJOy8MfzWv698sYImoY2fHL087eFb8zXr7ElT0qf9bgPRzM
         P2nGL+mFlgD6J7UBdjlUavxTXb91cGYB924bmV99HjjMMsUhaetEPGXnWXFK5hrK4aUV
         qWYEGQOpSJzp8KSRQcFGpDg3cl5Ddz/5aOpY70h/1X7Z7Jf2v6rgWlghB3JpymPvEDv3
         8l9rYz6mmmRwXqWueYzD+fhRGhHK+GJifejAPTK3BQkhfvqina8mK7YYUE15JCFlu1mk
         r63A==
X-Gm-Message-State: AOAM532okeBvpWfi3S4GNcbcMxXUFUlIzg+rTCpeXiUW1eZ9ljG2N/nA
        b10zVfA2EfZCJ6pY6t8lnTvgsJpxaehWvjHISbWdyA==
X-Google-Smtp-Source: ABdhPJxcld7S0TfU57/c6MV0BtBBz450m+30655BTDKoD3NWCBexpyEM41tdzU3AAqi6oxmUEvqY1BD/vBbXmZmmVm8=
X-Received: by 2002:a05:6638:144:: with SMTP id y4mr19842940jao.61.1600215192042;
 Tue, 15 Sep 2020 17:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <159921182827.1260200.9699352760916903781.stgit@firesoul>
 <20200904163947.20839d7e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200907160757.1f249256@carbon> <CANP3RGfjUOoVH152VHLXL3y7mBsF+sUCqEZgGAMdeb9_r_Z-Bw@mail.gmail.com>
 <20200914160538.2bd51893@carbon> <CANP3RGftg2-_tBc=hGGzxjGZUq9b1amb=TiKRVHSBEyXq-A5QA@mail.gmail.com>
 <87ft7jzas7.fsf@toke.dk>
In-Reply-To: <87ft7jzas7.fsf@toke.dk>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Tue, 15 Sep 2020 17:12:59 -0700
Message-ID: <CANP3RGf581mZKE2Eky-bY6swU6TAFv1vzxxZ24SQ+yB9TGAD8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: don't check against device MTU in __bpf_skb_max_len
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux NetDev <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 15, 2020 at 1:47 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> [ just jumping in to answer this bit: ]
>
> > Would you happen to know what ebpf startup overhead is?
> > How big a problem is having two (or more) back to back tc programs
> > instead of one?
>
> With a jit'ed BPF program and the in-kernel dispatcher code (which
> avoids indirect calls), it's quite close to a native function call.

Hmm, I know we have (had? they're upstream now I think) some CFI vs
BPF interaction issues.
We needed to mark the BPF call into JIT'ed code as CFI exempt.

CFI is Code Flow Integrity and is some compiler magic, to quote wikipedia:
Google has shipped Android with the Linux kernel compiled by Clang
with link-time optimization (LTO) and CFI since 2018.[12]
I don't know much more about it.

But we do BPF_JIT_ALWAYS_ON on 64-bit kernels, so it sounds like we
might be good.

> > We're running into both verifier performance scaling problems and code
> > ownership issues with large programs...
> >
> > [btw. I understand for XDP we could only use 1 program anyway...]
>
> Working on that! See my talk at LPC:
> https://linuxplumbersconf.org/event/7/contributions/671/

Yes, I'm aware and excited about it!

Unfortunately, Android S will only support 4.19, 5.4 and 5.10 for
newly launched devices (and 4.9/4.14 for upgrades).
(5.10 here means 'whatever is the next 5.x LTS', but that's most likely 5.1=
0)
I don't (yet) even have real phone hardware running 5.4, and 5.10
within the next year is even more of a stretch.

> Will post a follow-up to the list once the freplace multi-attach series
> lands.
