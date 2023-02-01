Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D226871F0
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 00:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjBAX3D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 18:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjBAX3B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 18:29:01 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B863F283
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 15:28:55 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q9so111987pgq.5
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 15:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TdJOrjVwP/aCuc7SHJPSxsPSpKaCt8lwZQUfBYSUkLs=;
        b=ArPJV2QAe98sE6JokcwBlq69+epecc3Z7VB7nzSPYULrlJNAhcFWp1fI0/bfF3z16D
         wB0iTCiIA38R6YbAoF/AcLToDUk4dEQtizVnE4d/Q2gY05XnIDobIjaSI+iDncYlwMgk
         ktIVK2fBdmn4EKJrTP11ynZfRhgUMhOotvKO8boy8YCtpkeNkVqDHeZxSWi2hcAwusLW
         dPOnPXobv55MSc5ZhHeRC14iD1yPAL+kc3caJEgrZJFgNzjG8z05mCUK7XjmQKbrY1wq
         U2OpaoLRDM8+kWb2rOZFELppE71oC1VWGSFPg1KJvA9T78bINX3D/BxJrqiG4caarVCq
         vnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdJOrjVwP/aCuc7SHJPSxsPSpKaCt8lwZQUfBYSUkLs=;
        b=LBuGphI5UWNFhBZy2GN9gmsvrbWgnVN9u0iMML+wxn+TEq6HZcpHBbmg5Gkd53K2v0
         x70pc9Hgq8w/VWR0lDqr6HDXP8mCY/1rCZ8QcLmGD3eLsZEl/Wq03FZrhq6320WiTdCu
         QQbiNYnujyu0gtPghaZXa60HSkC36kr5fFPgBc9FOEJZ23sAdsK1YwT4Y/XqoMalIyEb
         RnjnFbV/XFEXebSoHkUl7agm0URz9GcRf+5SZV/k/HA+wckl8I6a64p9K//zEcoD/2V1
         gyOYK+Ckd97xVYqpvR7eVc/ZLM3ZRRpCHCB3VQ/+lPFvfTCj6MDgr8Qs1yduSsNaZgbJ
         cojg==
X-Gm-Message-State: AO0yUKVewQ/aDIJZ5borytgz+koHvCCYhtCa9oro1gMDQT27VOo9nng1
        vrAZiEEDNbk8LbpF/up1gW83OTqyTSghWmpKLurvKQ==
X-Google-Smtp-Source: AK7set95EqfOjIbWeWiGh02vOq4TRnntSmXJ8xbfF6nQgWy4dz6ClzUXFuZljL9P0inOkF55wPCrG2Kx+1IqboOrfb8=
X-Received: by 2002:aa7:94b9:0:b0:593:1253:2ff5 with SMTP id
 a25-20020aa794b9000000b0059312532ff5mr957920pfl.14.1675294134296; Wed, 01 Feb
 2023 15:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20230130215137.3473320-1-sdf@google.com> <CAADnVQK+zRPa7O9o1Vf3ir9W9UmZnp-XPxMguTF6L_eGK=cOjA@mail.gmail.com>
 <CAKH8qBtBBUi2E581vbdxzWOHTQACRt7k41fkt-MRvvW9N0zy5A@mail.gmail.com>
In-Reply-To: <CAKH8qBtBBUi2E581vbdxzWOHTQACRt7k41fkt-MRvvW9N0zy5A@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 1 Feb 2023 15:28:42 -0800
Message-ID: <CAKH8qBtYBJFyQRVnrM_SMSUqAc+9JqcarvEhiqBcOfKktT9PNA@mail.gmail.com>
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

On Tue, Jan 31, 2023 at 10:07 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Mon, Jan 30, 2023 at 9:41 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jan 30, 2023 at 1:51 PM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > Commit e04ce9f4040b ("selftests/bpf: Make crashes more debuggable in
> > > test_progs") hasn't uncovered anything interesting besides
> > > confirming that the test passes successfully, but crashes eventually [0].
> > >
> > > I'm assuming the crashes are coming from something overriding
> > > the stack/heap. Probably from the xsk misuse. So I'm trying
> > > a bunch of things to address that:
> > >
> > > - More debugging with real memory pointers for the queues/umem
> > >   - To confirm that everything is sane
> > > - Set proper tx/fill ring sizes
> > >   - In particular, fill ring wasn't fully initialized, but I'm
> > >     assuming no packets should be flowing there regardless
> > >   - Do the same for xdp_hw_metadata
> > > - Don't refill on tx completion; instead, only ack it
> > >
> > > 0: https://github.com/kernel-patches/bpf/actions/runs/4032162075/jobs/6931951300
> > >
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/xdp_metadata.c   | 36 +++++++++++++------
> > >  tools/testing/selftests/bpf/xdp_hw_metadata.c |  4 +--
> > >  2 files changed, 28 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > > index e033d48288c0..453b4045a9d1 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > > @@ -54,11 +54,11 @@ static int open_xsk(int ifindex, struct xsk *xsk)
> > >         int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
> > >         const struct xsk_socket_config socket_config = {
> > >                 .rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > > -               .tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > > +               .tx_size = UMEM_NUM / 2,
> >
> > I'm not following. Is this a fix or just random debug code?
>
> This chunk is a potential fix. But the patch overall is a mix of
> potential fixes + debug code.
> I can't reproduce locally, so I'm trying a bunch of potential fixes +
> adding more debugging in case it doesn't help.
>
> > >                 .bind_flags = XDP_COPY,
> > >         };
> > >         const struct xsk_umem_config umem_config = {
> > > -               .fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > > +               .fill_size = UMEM_NUM / 2,
> > >                 .comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
> > >                 .frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
> > >                 .flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
> > > @@ -88,13 +88,24 @@ static int open_xsk(int ifindex, struct xsk *xsk)
> > >         if (!ASSERT_OK(ret, "xsk_socket__create"))
> > >                 return ret;
> > >
> > > +       printf("%p: umem=<%p..%p>\n", xsk, xsk->umem_area, xsk->umem_area + UMEM_SIZE);
> > > +       printf("%p: fill=<%p..%p>\n", xsk, xsk->fill.ring,
> > > +              xsk->fill.ring + xsk->fill.size * sizeof(__u64));
> > > +       printf("%p: comp=<%p..%p>\n", xsk, xsk->comp.ring,
> > > +              xsk->comp.ring + xsk->comp.size * sizeof(__u64));
> > > +       printf("%p: rx=<%p..%p>\n", xsk, xsk->rx.ring,
> > > +              xsk->rx.ring + xsk->rx.size * sizeof(struct xdp_desc));
> > > +       printf("%p: tx=<%p..%p>\n", xsk, xsk->tx.ring,
> > > +              xsk->tx.ring + xsk->tx.size * sizeof(struct xdp_desc));
> > > +
> >
> > This is fine as debug.
>
> Right. It should also be irrelevant for when the test passes since we
> are writing this to /dev/null.
>
> > >         /* First half of umem is for TX. This way address matches 1-to-1
> > >          * to the completion queue index.
> > >          */
> > >
> > >         for (i = 0; i < UMEM_NUM / 2; i++) {
> > >                 addr = i * UMEM_FRAME_SIZE;
> > > -               printf("%p: tx_desc[%d] -> %lx\n", xsk, i, addr);
> > > +               printf("%p: tx_desc[%d] -> %lx (%p)\n", xsk, i, addr,
> > > +                      xsk_umem__get_data(xsk->umem_area, addr));
> > >         }
> > >
> > >         /* Second half of umem is for RX. */
> > > @@ -107,7 +118,10 @@ static int open_xsk(int ifindex, struct xsk *xsk)
> > >
> > >         for (i = 0; i < UMEM_NUM / 2; i++) {
> > >                 addr = (UMEM_NUM / 2 + i) * UMEM_FRAME_SIZE;
> > > -               printf("%p: rx_desc[%d] -> %lx\n", xsk, i, addr);
> > > +               printf("%p: rx_desc[%d] -> %lx (%p)\n", xsk, i, addr,
> > > +                      xsk_umem__get_data(xsk->umem_area, addr));
> > > +               printf("%p: fill %lx at %p\n", xsk, addr,
> > > +                      xsk_ring_prod__fill_addr(&xsk->fill, i));
> > >                 *xsk_ring_prod__fill_addr(&xsk->fill, i) = addr;
> > >         }
> > >         xsk_ring_prod__submit(&xsk->fill, ret);
> > > @@ -159,6 +173,7 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
> > >         tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
> > >         printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
> > >         data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
> > > +       printf("%p: tx %llx (%p) at %p\n", xsk, tx_desc->addr, data, tx_desc);
> > >
> > >         eth = data;
> > >         iph = (void *)(eth + 1);
> > > @@ -205,9 +220,8 @@ static void complete_tx(struct xsk *xsk)
> > >         if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
> > >                 addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
> > >
> > > -               printf("%p: refill idx=%u addr=%llx\n", xsk, idx, addr);
> > > -               *xsk_ring_prod__fill_addr(&xsk->fill, idx) = addr;
> > > -               xsk_ring_prod__submit(&xsk->fill, 1);
> > > +               printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
> > > +               xsk_ring_cons__release(&xsk->comp, 1);
> >
> > What does this do?
>
> I was incorrectly refilling 'fill' ring on tx completion. Changing it
> to "consume" the completion
> (xsk_ring_cons__peek+xsk_ring_cons__release).

FYI, given Jesper's find with the wrong munmap, I'm gonna respin only
with this part fixed.

> > >         }
> > >  }
> > >
> > > @@ -216,7 +230,9 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
> > >         __u32 idx;
> > >
> > >         if (ASSERT_EQ(xsk_ring_prod__reserve(&xsk->fill, 1, &idx), 1, "xsk_ring_prod__reserve")) {
> > > -               printf("%p: complete idx=%u addr=%llx\n", xsk, idx, addr);
> > > +               printf("%p: complete rx idx=%u addr=%llx\n", xsk, idx, addr);
> > > +               printf("%p: fill %llx at %p\n", xsk, addr,
> > > +                      xsk_ring_prod__fill_addr(&xsk->fill, idx));
> > >                 *xsk_ring_prod__fill_addr(&xsk->fill, idx) = addr;
> > >                 xsk_ring_prod__submit(&xsk->fill, 1);
> > >         }
> > > @@ -253,8 +269,8 @@ static int verify_xsk_metadata(struct xsk *xsk)
> > >         rx_desc = xsk_ring_cons__rx_desc(&xsk->rx, idx);
> > >         comp_addr = xsk_umem__extract_addr(rx_desc->addr);
> > >         addr = xsk_umem__add_offset_to_addr(rx_desc->addr);
> > > -       printf("%p: rx_desc[%u]->addr=%llx addr=%llx comp_addr=%llx\n",
> > > -              xsk, idx, rx_desc->addr, addr, comp_addr);
> > > +       printf("%p: rx_desc[%u]->addr=%llx (%p) addr=%llx comp_addr=%llx\n",
> > > +              xsk, idx, rx_desc->addr, rx_desc, addr, comp_addr);
> > >         data = xsk_umem__get_data(xsk->umem_area, addr);
> > >
> > >         /* Make sure we got the packet offset correctly. */
> > > diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > > index 3823b1c499cc..6d715f85ea20 100644
> > > --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > > +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > > @@ -59,11 +59,11 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
> > >         int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
> > >         const struct xsk_socket_config socket_config = {
> > >                 .rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > > -               .tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > > +               .tx_size = UMEM_NUM / 2,
> > >                 .bind_flags = XDP_COPY,
> > >         };
> > >         const struct xsk_umem_config umem_config = {
> > > -               .fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > > +               .fill_size = UMEM_NUM / 2,
> > >                 .comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
> > >                 .frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
> > >                 .flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
> > > --
> > > 2.39.1.456.gfc5497dd1b-goog
> > >
