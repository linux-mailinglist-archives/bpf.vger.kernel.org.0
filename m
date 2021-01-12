Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB482F3CE3
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 01:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438067AbhALVhV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 16:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436972AbhALUeC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 15:34:02 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1857DC061786
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 12:33:22 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id d203so3784029oia.0
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 12:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdKAiHHOV0gEOUCHTem1lXmPy7p7WSVRP8s4VyMJD7g=;
        b=XzdHAZtBLN8jEbpfBFRWzK2HBZHiOO4C9a171JtLYJzvgwtm5uUvQhkGV6EQDILv7m
         Qea0KfqrqImYYanIVbA0Zv9Afk/EzyUJss9gS9beRgEOOo7K5TeItUwEISEWfbq8xBWF
         jKvYrpNxTSSxLeVUN+c1aOhyP4jhRc+xVA6IAJ4YBZxfDPzbuXWGDmoNwetn5Cm2CX0X
         /fn+OQBB4+a2Jq8QWNnbkpzLJWRJo2WBhbjkR1wFfrMkM0kxwu+OP4BJAbDnLEBCtF4k
         pZvgmkIu56Q5jQcLR36V9SsmR1S4KgCvZyThObq7/0a+u6Fz4cffzjiKnYyHoXUA7PJh
         3YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdKAiHHOV0gEOUCHTem1lXmPy7p7WSVRP8s4VyMJD7g=;
        b=K/rGrt9pG5w6gDxi6l5obFS+p1qC4TJRFy8POFCBS6HbjmGQRZic64wdIOH8RSGAv1
         xD3cGzaXRC5aQ9fBGWNpVujFXYKSnIkdNhAQQCJxDbzCxnbX5O4sHN1f0ZIuKXEX2Apq
         eD3B00d+Qn7zT8TKxSvVYuRNwsS8DSzrf24WWuYXuzOalxqmUHytaPDaSU/sCY2tMpyV
         cXjjSG2NKv33ZWw89jtSJ1YIeTXNovoePbN2MAaIH+NhNv0eWvjXzlW69r4inmtQtAIv
         XqoCc1/R+kpxGKOeqzHJOG81B7QHdEyrolDEFdvZNNfpPBaZoSQ3r1yDQ14xSeMO/OXn
         kN+g==
X-Gm-Message-State: AOAM531QhiSg1WxaBPEliSdue0fCtR3EmU5BSlbJEMfW1yUkrFkOgDhd
        o8bz81yzVDCcZtr5/TTS7iJO25WhUd82r0R2gR8J4Q==
X-Google-Smtp-Source: ABdhPJxkWjYpBEyulD2m3Ij8CK3ZsGgrRo312GFNR95pqEC5fG4bVq8NKft/CBnSXWToT/VzmMXndNmfgHNU8eR/aPg=
X-Received: by 2002:a05:6808:49a:: with SMTP id z26mr570751oid.137.1610483601498;
 Tue, 12 Jan 2021 12:33:21 -0800 (PST)
MIME-Version: 1.0
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
 <20210112194143.1494-4-yuri.benditovich@daynix.com> <CAADnVQ++1_voT2fZ021ExcON0KfHtA8MyHc-WYe-XXJoPTD6ig@mail.gmail.com>
In-Reply-To: <CAADnVQ++1_voT2fZ021ExcON0KfHtA8MyHc-WYe-XXJoPTD6ig@mail.gmail.com>
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
Date:   Tue, 12 Jan 2021 22:33:09 +0200
Message-ID: <CAOEp5Oca3-Dvm2=nV3ZKsx3Ltgrt1Sm5gzvoG+8LD+yURtJ8bg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] tun: allow use of BPF_PROG_TYPE_SCHED_CLS program type
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Willem de Bruijn <willemb@google.com>, gustavoars@kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>, decui@microsoft.com,
        cai@lca.pw, Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bpf <bpf@vger.kernel.org>, Yan Vugenfirer <yan@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 12, 2021 at 9:46 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 12, 2021 at 11:42 AM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > This program type can set skb hash value. It will be useful
> > when the tun will support hash reporting feature if virtio-net.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  drivers/net/tun.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 7959b5c2d11f..455f7afc1f36 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -2981,6 +2981,8 @@ static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
> >                 prog = NULL;
> >         } else {
> >                 prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SOCKET_FILTER);
> > +               if (IS_ERR(prog))
> > +                       prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SCHED_CLS);
>
> You've ignored the feedback and just resend? what for?

No, I do not. Some patches did not reach relevant people at all, so I
just resent _all_ the patches to all the people.
I will copy your earlier comment to this patch and will address it in
the discussion.
Sorry for misunderstanding and some redundant noise.
