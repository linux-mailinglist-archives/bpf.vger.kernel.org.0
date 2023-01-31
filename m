Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D006A6834BE
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjAaSHq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAaSHo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:07:44 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A453C2E
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:07:43 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id e6so7686845plg.12
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AEm/WqgIzYy6XXNe3nq7qeuNFp53+is3RzeKFqm0pJQ=;
        b=SuP9j5SC7uIpYNPpO58S19V69jsCsSdSTjHiro5hXicAit5auRfNadFS76ZfF+rMaR
         2Z1ZbT3EkS7V6yJXNUxtZDJTolSPNO9l1l7hijkyO4/t95Y6+iL5ZE8hlAEGX5Zdlp53
         2ozyLYM28UBe/y/DS/BHkE1Wb/cdEFELJL+1DActNKx1ICZKe6Hsx0jmOTGj8JymRiie
         Of+EuaUrZVedgxBP7xzH2Yj60fJtz2zdHZ6p2tLFHvpE7VEm23HDdfRbWRQ1Gy828jzj
         GYTqqas/bGkyDh/FvnKm0pxDf4e9NzCpLyiRo/KaXxqTrj36mbMk6rxCc5tXvBl0Dhdl
         N6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEm/WqgIzYy6XXNe3nq7qeuNFp53+is3RzeKFqm0pJQ=;
        b=2/wrujrc+BPitaxVu6Pwfhg5M6e+zcHknP3QOsD3vpMH7sda5k4NBv9xyTBVwU6YET
         teZx05sXSiEj0SueuEAI22DkyFlyXXckQwmw5CrPbzaiuSBo3f++nQVQkH5+SAJmyPiW
         vd5uTERF3kUDvkEQeUz0Nk5NNwDWIqBE+2pqwTUn6cP6dwacvdfd/CqC1WjBvyKnzRyI
         e2pPzL0XdLAfkWfPjA23nVwhOtWrtdttNYYH/PlTYhG2lTECPQVpaLmjrU3axlcSC6/x
         AmSCxkxPFdOR5DFbLpqtGrTA+CBvvVNSgQgCXKuXIdMKnsC7NLr9dsbbAe2UJOi0DcpG
         xI9Q==
X-Gm-Message-State: AO0yUKVGaWly456AU+ioDlabprX4y79L/SpEdpyCQpPN0W9updSIuPt8
        u3MAw1AhvLXwkTN0mAgiS2TWCsoKzj5gJo0Vnwb3cA==
X-Google-Smtp-Source: AK7set9eX5f54oE38QyPpc/u9tBb5UD3Hj/cwbWFKuSl/Gcl7wOu6xcntlftdfpW5/MXKUshAVqf24VtGpGxsiMCaqs=
X-Received: by 2002:a17:902:82c6:b0:196:cca:a0b4 with SMTP id
 u6-20020a17090282c600b001960ccaa0b4mr4541216plz.20.1675188462832; Tue, 31 Jan
 2023 10:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20230130215137.3473320-1-sdf@google.com> <CAADnVQK+zRPa7O9o1Vf3ir9W9UmZnp-XPxMguTF6L_eGK=cOjA@mail.gmail.com>
In-Reply-To: <CAADnVQK+zRPa7O9o1Vf3ir9W9UmZnp-XPxMguTF6L_eGK=cOjA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 31 Jan 2023 10:07:31 -0800
Message-ID: <CAKH8qBtBBUi2E581vbdxzWOHTQACRt7k41fkt-MRvvW9N0zy5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Try to address xdp_metadata crashes
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 9:41 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jan 30, 2023 at 1:51 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Commit e04ce9f4040b ("selftests/bpf: Make crashes more debuggable in
> > test_progs") hasn't uncovered anything interesting besides
> > confirming that the test passes successfully, but crashes eventually [0].
> >
> > I'm assuming the crashes are coming from something overriding
> > the stack/heap. Probably from the xsk misuse. So I'm trying
> > a bunch of things to address that:
> >
> > - More debugging with real memory pointers for the queues/umem
> >   - To confirm that everything is sane
> > - Set proper tx/fill ring sizes
> >   - In particular, fill ring wasn't fully initialized, but I'm
> >     assuming no packets should be flowing there regardless
> >   - Do the same for xdp_hw_metadata
> > - Don't refill on tx completion; instead, only ack it
> >
> > 0: https://github.com/kernel-patches/bpf/actions/runs/4032162075/jobs/6931951300
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  .../selftests/bpf/prog_tests/xdp_metadata.c   | 36 +++++++++++++------
> >  tools/testing/selftests/bpf/xdp_hw_metadata.c |  4 +--
> >  2 files changed, 28 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > index e033d48288c0..453b4045a9d1 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > @@ -54,11 +54,11 @@ static int open_xsk(int ifindex, struct xsk *xsk)
> >         int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
> >         const struct xsk_socket_config socket_config = {
> >                 .rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > -               .tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > +               .tx_size = UMEM_NUM / 2,
>
> I'm not following. Is this a fix or just random debug code?

This chunk is a potential fix. But the patch overall is a mix of
potential fixes + debug code.
I can't reproduce locally, so I'm trying a bunch of potential fixes +
adding more debugging in case it doesn't help.

> >                 .bind_flags = XDP_COPY,
> >         };
> >         const struct xsk_umem_config umem_config = {
> > -               .fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > +               .fill_size = UMEM_NUM / 2,
> >                 .comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
> >                 .frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
> >                 .flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
> > @@ -88,13 +88,24 @@ static int open_xsk(int ifindex, struct xsk *xsk)
> >         if (!ASSERT_OK(ret, "xsk_socket__create"))
> >                 return ret;
> >
> > +       printf("%p: umem=<%p..%p>\n", xsk, xsk->umem_area, xsk->umem_area + UMEM_SIZE);
> > +       printf("%p: fill=<%p..%p>\n", xsk, xsk->fill.ring,
> > +              xsk->fill.ring + xsk->fill.size * sizeof(__u64));
> > +       printf("%p: comp=<%p..%p>\n", xsk, xsk->comp.ring,
> > +              xsk->comp.ring + xsk->comp.size * sizeof(__u64));
> > +       printf("%p: rx=<%p..%p>\n", xsk, xsk->rx.ring,
> > +              xsk->rx.ring + xsk->rx.size * sizeof(struct xdp_desc));
> > +       printf("%p: tx=<%p..%p>\n", xsk, xsk->tx.ring,
> > +              xsk->tx.ring + xsk->tx.size * sizeof(struct xdp_desc));
> > +
>
> This is fine as debug.

Right. It should also be irrelevant for when the test passes since we
are writing this to /dev/null.

> >         /* First half of umem is for TX. This way address matches 1-to-1
> >          * to the completion queue index.
> >          */
> >
> >         for (i = 0; i < UMEM_NUM / 2; i++) {
> >                 addr = i * UMEM_FRAME_SIZE;
> > -               printf("%p: tx_desc[%d] -> %lx\n", xsk, i, addr);
> > +               printf("%p: tx_desc[%d] -> %lx (%p)\n", xsk, i, addr,
> > +                      xsk_umem__get_data(xsk->umem_area, addr));
> >         }
> >
> >         /* Second half of umem is for RX. */
> > @@ -107,7 +118,10 @@ static int open_xsk(int ifindex, struct xsk *xsk)
> >
> >         for (i = 0; i < UMEM_NUM / 2; i++) {
> >                 addr = (UMEM_NUM / 2 + i) * UMEM_FRAME_SIZE;
> > -               printf("%p: rx_desc[%d] -> %lx\n", xsk, i, addr);
> > +               printf("%p: rx_desc[%d] -> %lx (%p)\n", xsk, i, addr,
> > +                      xsk_umem__get_data(xsk->umem_area, addr));
> > +               printf("%p: fill %lx at %p\n", xsk, addr,
> > +                      xsk_ring_prod__fill_addr(&xsk->fill, i));
> >                 *xsk_ring_prod__fill_addr(&xsk->fill, i) = addr;
> >         }
> >         xsk_ring_prod__submit(&xsk->fill, ret);
> > @@ -159,6 +173,7 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
> >         tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
> >         printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
> >         data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
> > +       printf("%p: tx %llx (%p) at %p\n", xsk, tx_desc->addr, data, tx_desc);
> >
> >         eth = data;
> >         iph = (void *)(eth + 1);
> > @@ -205,9 +220,8 @@ static void complete_tx(struct xsk *xsk)
> >         if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
> >                 addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
> >
> > -               printf("%p: refill idx=%u addr=%llx\n", xsk, idx, addr);
> > -               *xsk_ring_prod__fill_addr(&xsk->fill, idx) = addr;
> > -               xsk_ring_prod__submit(&xsk->fill, 1);
> > +               printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
> > +               xsk_ring_cons__release(&xsk->comp, 1);
>
> What does this do?

I was incorrectly refilling 'fill' ring on tx completion. Changing it
to "consume" the completion
(xsk_ring_cons__peek+xsk_ring_cons__release).

> >         }
> >  }
> >
> > @@ -216,7 +230,9 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
> >         __u32 idx;
> >
> >         if (ASSERT_EQ(xsk_ring_prod__reserve(&xsk->fill, 1, &idx), 1, "xsk_ring_prod__reserve")) {
> > -               printf("%p: complete idx=%u addr=%llx\n", xsk, idx, addr);
> > +               printf("%p: complete rx idx=%u addr=%llx\n", xsk, idx, addr);
> > +               printf("%p: fill %llx at %p\n", xsk, addr,
> > +                      xsk_ring_prod__fill_addr(&xsk->fill, idx));
> >                 *xsk_ring_prod__fill_addr(&xsk->fill, idx) = addr;
> >                 xsk_ring_prod__submit(&xsk->fill, 1);
> >         }
> > @@ -253,8 +269,8 @@ static int verify_xsk_metadata(struct xsk *xsk)
> >         rx_desc = xsk_ring_cons__rx_desc(&xsk->rx, idx);
> >         comp_addr = xsk_umem__extract_addr(rx_desc->addr);
> >         addr = xsk_umem__add_offset_to_addr(rx_desc->addr);
> > -       printf("%p: rx_desc[%u]->addr=%llx addr=%llx comp_addr=%llx\n",
> > -              xsk, idx, rx_desc->addr, addr, comp_addr);
> > +       printf("%p: rx_desc[%u]->addr=%llx (%p) addr=%llx comp_addr=%llx\n",
> > +              xsk, idx, rx_desc->addr, rx_desc, addr, comp_addr);
> >         data = xsk_umem__get_data(xsk->umem_area, addr);
> >
> >         /* Make sure we got the packet offset correctly. */
> > diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > index 3823b1c499cc..6d715f85ea20 100644
> > --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > @@ -59,11 +59,11 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
> >         int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
> >         const struct xsk_socket_config socket_config = {
> >                 .rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > -               .tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > +               .tx_size = UMEM_NUM / 2,
> >                 .bind_flags = XDP_COPY,
> >         };
> >         const struct xsk_umem_config umem_config = {
> > -               .fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > +               .fill_size = UMEM_NUM / 2,
> >                 .comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
> >                 .frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
> >                 .flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
> > --
> > 2.39.1.456.gfc5497dd1b-goog
> >
