Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3389619FB4
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 19:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiKDSWi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 14:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiKDSWL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 14:22:11 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B5E4B984
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 11:21:59 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p141so4444348iod.6
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 11:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5isSgji227OnXCXBtz9OXLRfJu0KpxWw6aIG81a7vo=;
        b=LRXTX1ke/zE9Xa5Ofl+JiFsQxcsxi5UuY5Jm2skqH2ojrvCpQkUQZsz6YNstF9rOxZ
         bKYhAntgaw++z1XyE2mn7NbQcpSja2KrWs+ATtE5Kk3jghOlf+miyhSubqOsepDLNsgP
         luUCHER0/LgPx26bqsuM+NdT+TncHyEQ5uUOhcOiHwJ5HgJ6Qz1aGzQBhlohptr3eSDj
         pDfk6J6HOkPQ3oFnSRS/5+TAJPTPhjGtjIY3o2GeorySPK1DlFE/GcK5BhBJ5yCe2+9F
         yvle3lufYDpyWR/T1I3DN0puyYh7azxRPlKh6IF/+WaNRFqZSnDuJ2KfFOZdyuoPcEcK
         rDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5isSgji227OnXCXBtz9OXLRfJu0KpxWw6aIG81a7vo=;
        b=AUQxIRpg1WfpmzRR9uizePMxEtYggg2vkvpnLtuXZnb7gNk2WTQOZhG1Kl7MNfEudF
         57PsnxsIoxUye8IaRCi3stkPngWl9kGmO9BQeYOQq7YfLdQ0BCPThtKdGR6Samo00KOT
         t3Bp935h///oQ7AhHlKN9N7kevhYCOuJKT/jVWoZVQ8EpIdwzwT110qIzRSqBdw3qggQ
         h9B5fi/IoeePbm+zNjh0kzk8vMgLSNRVXI33Sfvebd6e8nGOXgOya5ya+4FEyjwRwEm6
         hW09fmatOeKg4ewmtljmiwbbdcfk4wAn1SQMua447XbU3Z6oJLBdFD84HFbZ10nhQ1Qc
         1E5g==
X-Gm-Message-State: ACrzQf1Iqk6rK609LyY60F6TfQImzUcUQsahUM16HK6UT2lAANiDt33w
        MS2pwhj3p1kqm3pWPOKjQnHQIj+JnzZ4JWG3smcNKQ==
X-Google-Smtp-Source: AMsMyM4K0pV8YXMUH6zIcn59kuwZdSU8ufQZsEVjZO23fbx9zo7WsOGnyriwbnsFk3gX+SMpp2JgOEP9HR6k0U5rM14=
X-Received: by 2002:a6b:400e:0:b0:6ca:91aa:c0ca with SMTP id
 k14-20020a6b400e000000b006ca91aac0camr23793547ioa.34.1667586118276; Fri, 04
 Nov 2022 11:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221104032311.1606050-1-sdf@google.com> <87leori0xh.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87leori0xh.fsf@all.your.base.are.belong.to.us>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 4 Nov 2022 11:21:43 -0700
Message-ID: <CAKH8qBvuPH9GkXKsfi1Nt+J1S16Khcc2D8MtXVkEES8iEQ_9PQ@mail.gmail.com>
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

On Fri, Nov 4, 2022 at 1:22 AM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> > While working on a simplified test for [0] it occurred to me that
> > the following looks fishy:
> >
> >       data =3D xsk_umem__get_data(xsk->umem_area, rx_desc->addr);
> >       data_meta =3D data - sizeof(my metadata);
> >
> > Since the data points to umem frame at addr X, data_mem points to
> > the end of umem frame X-1.
> >
> > I don't think it's by design?
>
> It is by design. :-)

Noted, thanks for clarifying!

> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 9f0561b67c12..0547fe37ba7e 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -163,7 +163,7 @@ static void xsk_copy_xdp(struct xdp_buff *to, struc=
t xdp_buff *from, u32 len)
> >       } else {
> >               from_buf =3D from->data_meta;
> >               metalen =3D from->data - from->data_meta;
> > -             to_buf =3D to->data - metalen;
>
> This is to include the XDP meta data in the receive buffer. Note that
> AF_XDP descriptor that you get back on the RX ring points to the *data*
> not the metadata.
>
> For the unaligned mode you can pass any address (umem offset) into the
> fill ring, and the kernel will simply mask it and setup headroom
> accordingly.

Thanks for the details! And what happens in the aligned case?

Looking purely from the user side:

tx_desc =3D xsk_ring_prod__tx_desc(&xsk->tx, idx);
tx_desc->addr =3D idx * UMEM_FRAME_SIZE; /* this has to be aligned to
the frame size? */
data =3D xsk_umem__get_data(xsk->umem_area, tx_desc->addr);

data here is basically =3D umem_area + idx * UMEM_FRAM_SIZE, right? How
do I make sure metadata is placed in the same umem chunk? Will passing
umem headroom do the trick?




> The buffer allocator guarantees that there's XDP_PACKET_HEADROOM
> available.
>
> IOW your example userland code above is correct.
>
>
> Bj=C3=B6rn
>
>
