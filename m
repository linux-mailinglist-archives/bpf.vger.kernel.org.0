Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB7A61A38C
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 22:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKDVr2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 17:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiKDVr1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 17:47:27 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F21D9E
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 14:47:25 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p141so4840328iod.6
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRjSS2dEk9hnD7ThB06Hgs90PSlFs4eH6cYa+KdqcnQ=;
        b=WQf9bRlsI1XKPD3Jshb9XofLOKEJOYFYf2YIY6e+ns03rUkYYW6OAFrWeWJst0zltf
         aQzK0nRcI7LBFEWyQ6yVO7lT4s9ZES2Bp8BLM1q5pgRBeDMPDO8ABPRhrMc10/VhYD2Y
         U8+ERCxxvtn8MMjgFYmViqOGzb1eHnC2Crt0gduVUjhcCr5IWGGUJv2qk+/YGYTr7L5J
         hqxhtJ6QIcFpnLHNdy17bhkmf5HBdqRvVjeD2OiGdpYJ8xWu7DXdlHjbzOWqCs4ipVj6
         zmknOR1gsfsfqmIUT3bh28T2YkorBaZwE5OJRfYHB4j2eF0G+c+dUygVVNoEKbwMVEUj
         WbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRjSS2dEk9hnD7ThB06Hgs90PSlFs4eH6cYa+KdqcnQ=;
        b=nax5qxi1f5SrdDz6tuH+nmCn//7ecZnEpWMcR7a6rM0AkasM4G1DI+ZOe4w4+nVXcC
         HCdwwPe51uCaBfi2sdl7leA6pq/5A3u4KdKQOsvMhN8WWKWvZqwL94gIqHyLP10emoIG
         3h+JyqkZ2ktEyJTKfOaHzNlhYKk3YGuNGxbP43g+Z15XCXmyy/J6gx8/kMaiWIS1K62X
         QMYlf0e8L1HkG9/rPqzXAJA1L9+E96KEkjwOr4nzEDupbbxgJqglU/VXcRZ/vZ4pXfRh
         dyJihrbig+b5Rr/Nbh+Mt4WY9GTd//Bce+PMKR70KchiWvtrt9xu7wRk9xhgSg8Z+a6z
         nJzg==
X-Gm-Message-State: ACrzQf2o0wVcjh+1qgfz1Y0AC9pNgPog7bWvIF8Fm30/g+Mq40fUvfwB
        XT47BfVW4cGYJBvdDrPHtL5URW910OfAndt+GtgSig==
X-Google-Smtp-Source: AMsMyM4HbweZapfCjy1oNY1gEpuc+TtrBVcA9ubkHAfx3c4hWPaIZHx5JX5znxT5VFxE5La4J1TivVlmOxk8nEPYoOc=
X-Received: by 2002:a02:cacf:0:b0:375:4038:62a0 with SMTP id
 f15-20020a02cacf000000b00375403862a0mr23423691jap.23.1667598445102; Fri, 04
 Nov 2022 14:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221104032311.1606050-1-sdf@google.com> <87leori0xh.fsf@all.your.base.are.belong.to.us>
 <CAKH8qBvuPH9GkXKsfi1Nt+J1S16Khcc2D8MtXVkEES8iEQ_9PQ@mail.gmail.com>
In-Reply-To: <CAKH8qBvuPH9GkXKsfi1Nt+J1S16Khcc2D8MtXVkEES8iEQ_9PQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 4 Nov 2022 14:47:14 -0700
Message-ID: <CAKH8qBtWgefqhMsMFVwFv-mhhhMycVXhyzzgu4s7NDkQGfPy0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] xsk: fix destination buffer address when copying
 with metadata
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Nov 4, 2022 at 11:21 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Fri, Nov 4, 2022 at 1:22 AM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> w=
rote:
> >
> > Stanislav Fomichev <sdf@google.com> writes:
> >
> > > While working on a simplified test for [0] it occurred to me that
> > > the following looks fishy:
> > >
> > >       data =3D xsk_umem__get_data(xsk->umem_area, rx_desc->addr);
> > >       data_meta =3D data - sizeof(my metadata);
> > >
> > > Since the data points to umem frame at addr X, data_mem points to
> > > the end of umem frame X-1.
> > >
> > > I don't think it's by design?
> >
> > It is by design. :-)
>
> Noted, thanks for clarifying!
>
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 9f0561b67c12..0547fe37ba7e 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -163,7 +163,7 @@ static void xsk_copy_xdp(struct xdp_buff *to, str=
uct xdp_buff *from, u32 len)
> > >       } else {
> > >               from_buf =3D from->data_meta;
> > >               metalen =3D from->data - from->data_meta;
> > > -             to_buf =3D to->data - metalen;
> >
> > This is to include the XDP meta data in the receive buffer. Note that
> > AF_XDP descriptor that you get back on the RX ring points to the *data*
> > not the metadata.
> >
> > For the unaligned mode you can pass any address (umem offset) into the
> > fill ring, and the kernel will simply mask it and setup headroom
> > accordingly.
>
> Thanks for the details! And what happens in the aligned case?
>
> Looking purely from the user side:
>
> tx_desc =3D xsk_ring_prod__tx_desc(&xsk->tx, idx);
> tx_desc->addr =3D idx * UMEM_FRAME_SIZE; /* this has to be aligned to
> the frame size? */
> data =3D xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
>
> data here is basically =3D umem_area + idx * UMEM_FRAM_SIZE, right? How
> do I make sure metadata is placed in the same umem chunk? Will passing
> umem headroom do the trick?

Ignore me. I do see now that there is always XDP_PACKET_HEADROOM bytes
of headroom in rx_desc.



>
> > The buffer allocator guarantees that there's XDP_PACKET_HEADROOM
> > available.
> >
> > IOW your example userland code above is correct.
> >
> >
> > Bj=C3=B6rn
> >
> >
