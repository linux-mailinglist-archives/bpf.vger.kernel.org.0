Return-Path: <bpf+bounces-33143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6BA917B64
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 10:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401A61F22A7E
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF030166319;
	Wed, 26 Jun 2024 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9Bj8EQz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D291534F8;
	Wed, 26 Jun 2024 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391900; cv=none; b=NuG9+FIC1hCgPhWVZ1B+2PaJEAb9yuyMt+eCl8fdpb/O/TfmXy+Tuc659EsLrk86atDPayfbPxKGce95w2YgdYMvnC+WyKsq3w0nWrzN0+rPS326pETVkCTBx9jDf6FUmasiodqQoaQ1P5q4J0MtB9Q6uX0KW0qZ3ue1cAtcdhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391900; c=relaxed/simple;
	bh=4MakcVKMpy+Kjbu8XIHYZwWbT/cX9l2eCq0rVqbDWhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYokPbteGbVVqAsoeU6GaBnf586aPt6uK9ZkuclxzmYFzsHVG8AkPzd/E4w0c5SKpni4DmaQBsdoh/ZsHBitXJX0kNLGQuEVhIQWkBhquEXBqU6dryvD4m6/8VHhAWGLsX4HjU4D25wICusSHRLcSp63fbKZG7yb15K6FY/8vyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9Bj8EQz; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ad8265e889so7284746d6.3;
        Wed, 26 Jun 2024 01:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719391897; x=1719996697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xng73UHtuhzNM88NgVDcghWf0TbGG0cQtt8atLDW4vI=;
        b=V9Bj8EQzutyULOwLli9mCP8EsAlECTPGu+BAkmYa/nmcemy3OBa1JhqAvg0h43sjAl
         xP8X/RKhEb13WxYSeANibLIiW2FcNTf+lcFLxe8gQTnNu1uskSUMMA4O4mvCF2mJghcx
         9Vcr/4OIRlojm61Y4UNLBLZWLkXTiLuN/gNcaUDmG2UueIZ6O7SOTXos28wjltJ5JYUf
         JH8IXqkS21c7ecOrfLyj3cHRQavX0d6Ed/qzVinGo326KGfU7maOn81PRmZH2p/iy6T+
         zJEwJ1cmX3k87ac0mQVLNZNn+ssrYMcmN3sq0yIaFjlQYk5fzKktc9fZkHNZJnHcTmBZ
         jV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391897; x=1719996697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xng73UHtuhzNM88NgVDcghWf0TbGG0cQtt8atLDW4vI=;
        b=FICBhidafjxtw0nruYEvkMajUQfhUNLbivGxzvzhtbB690Z+lB2++9PFAVFGsrkEl6
         cZiXvsFqFN1DswwF6rJr1MeVGjNJlauooHg3+G2NgiYWeiHSCpKSHndkGy79cVCowr+R
         wb2gxp5Ryv/fqKBJESG3Cdnc+N1uM3UVvQykCPViEb3rupXMCd96a1Lgg30NaeNlVG7W
         R7XQkc5SOVk8xwlkCMYt7Z9imp75i9xtSw5I1exxoACkPChWFoXAXSlg7v3linRqfbYx
         G9m2GQWM9InI+S6Fm+tfWPf1IYRZJOIrcgqEaUIlPBL6Kp0dA6oMCZa6SRv3yDFA0AEn
         5JSA==
X-Forwarded-Encrypted: i=1; AJvYcCXfyL04rS60TznMN8XS8JQL+jG9no4XwogNT7JzkokU3D/U8+GtjqOC1K8BgJ5wa08HyutwOZfsdYuZuIKDUSXRpN4msWwkAvoFG5Mzn81LBbp3HwL6rnV5vfx7
X-Gm-Message-State: AOJu0YwyaQm6ICeYVoXID8xp7YPCidELlRLg6uqsilodSKmCrrFH054l
	D0kWQaC9J9k4I7tPCweXfMNouZTs8BZ8rXFdAoIrlG3C1xVQJclEX0K7/TS2xDQjaSnS7xQW3o6
	qtak5Dfgnj+Cv8ftZXgWwhTryuHg=
X-Google-Smtp-Source: AGHT+IFemGOnuymNCTpu4VPWt8NdqRP9Mm9qHZma7/h8qIRhpPQ3qE2Dty2Jf6to1ms8qe5HKmOdJLB+VsrWXzkgv30=
X-Received: by 2002:a0c:d6c5:0:b0:6b5:3c89:6d06 with SMTP id
 6a1803df08f44-6b53c896d70mr110892736d6.4.1719391897505; Wed, 26 Jun 2024
 01:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619132048.152830-1-tushar.vyavahare@intel.com>
 <20240619132048.152830-3-tushar.vyavahare@intel.com> <ZnsBF//QuXQ9Nyix@boxer> <IA1PR11MB6514E556BFDD10C0846D407A8FD62@IA1PR11MB6514.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6514E556BFDD10C0846D407A8FD62@IA1PR11MB6514.namprd11.prod.outlook.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 26 Jun 2024 10:51:26 +0200
Message-ID: <CAJ8uoz2jknsnVZFvuH_D7kOuv7yEn3_miqdkBrzGA0zSdSdsyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/xsk: Enhance batch size support
 with dynamic configurations
To: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
Cc: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Jun 2024 at 10:36, Vyavahare, Tushar
<tushar.vyavahare@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> > Sent: Tuesday, June 25, 2024 11:11 PM
> > To: Vyavahare, Tushar <tushar.vyavahare@intel.com>
> > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org; bjorn@kernel.org;
> > Karlsson, Magnus <magnus.karlsson@intel.com>;
> > jonathan.lemon@gmail.com; davem@davemloft.net; kuba@kernel.org;
> > pabeni@redhat.com; ast@kernel.org; daniel@iogearbox.net; Sarkar,
> > Tirthendu <tirthendu.sarkar@intel.com>
> > Subject: Re: [PATCH bpf-next 2/2] selftests/xsk: Enhance batch size support
> > with dynamic configurations
> >
> > On Wed, Jun 19, 2024 at 01:20:48PM +0000, Tushar Vyavahare wrote:
> > > Introduce dynamic adjustment capabilities for fill_size, comp_size,
> > > tx_size, and rx_size parameters to support larger batch sizes beyond
> > > the
> >
> > you are only introducing fill_size and comp_size to xsk_umem_info. The latter
> > two seem to be in place.
> >
>
> I will do it.
>
> > > previous 2K limit.
> > >
> > > Update HW_SW_MAX_RING_SIZE test cases to evaluate AF_XDP's
> > robustness
> > > by pushing hardware and software ring sizes to their limits. This test
> > > ensures AF_XDP's reliability amidst potential producer/consumer
> > > throttling due to maximum ring utilization.
> > >
> > > Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> > > ---
> > >  tools/testing/selftests/bpf/xskxceiver.c | 26
> > > ++++++++++++++++++------  tools/testing/selftests/bpf/xskxceiver.h |
> > > 2 ++
> > >  2 files changed, 22 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/xskxceiver.c
> > > b/tools/testing/selftests/bpf/xskxceiver.c
> > > index 088df53869e8..5b049f0296e6 100644
> > > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > > @@ -196,6 +196,12 @@ static int xsk_configure_umem(struct ifobject
> > *ifobj, struct xsk_umem_info *umem
> > >     };
> > >     int ret;
> > >
> > > +   if (umem->fill_size)
> > > +           cfg.fill_size = umem->fill_size;
> > > +
> > > +   if (umem->comp_size)
> > > +           cfg.comp_size = umem->comp_size;
> > > +
> > >     if (umem->unaligned_mode)
> > >             cfg.flags |= XDP_UMEM_UNALIGNED_CHUNK_FLAG;
> > >
> > > @@ -265,6 +271,10 @@ static int __xsk_configure_socket(struct
> > xsk_socket_info *xsk, struct xsk_umem_i
> > >             cfg.bind_flags |= XDP_SHARED_UMEM;
> > >     if (ifobject->mtu > MAX_ETH_PKT_SIZE)
> > >             cfg.bind_flags |= XDP_USE_SG;
> > > +   if (umem->fill_size)
> > > +           cfg.tx_size = umem->fill_size;
> > > +   if (umem->comp_size)
> > > +           cfg.rx_size = umem->comp_size;
> >
> > how is the fq related to txq ? and cq to rxq? shouldn't this be fq-rxq and cq-
> > txq. What is the intent here? In the end they are the same in your test.
> >
>
> Yes, you are correct, updating code accordingly.
>
> > >
> > >     txr = ifobject->tx_on ? &xsk->tx : NULL;
> > >     rxr = ifobject->rx_on ? &xsk->rx : NULL; @@ -1616,7 +1626,7 @@
> > > static void xsk_populate_fill_ring(struct xsk_umem_info *umem, struct
> > pkt_stream
> > >     if (umem->num_frames < XSK_RING_PROD__DEFAULT_NUM_DESCS)
> > >             buffers_to_fill = umem->num_frames;
> > >     else
> > > -           buffers_to_fill = XSK_RING_PROD__DEFAULT_NUM_DESCS;
> > > +           buffers_to_fill = umem->fill_size;
> > >
> > >     ret = xsk_ring_prod__reserve(&umem->fq, buffers_to_fill, &idx);
> > >     if (ret != buffers_to_fill)
> > > @@ -2445,7 +2455,7 @@ static int testapp_hw_sw_min_ring_size(struct
> > > test_spec *test)
> > >
> > >  static int testapp_hw_sw_max_ring_size(struct test_spec *test)  {
> > > -   u32 max_descs = XSK_RING_PROD__DEFAULT_NUM_DESCS * 2;
> > > +   u32 max_descs = XSK_RING_PROD__DEFAULT_NUM_DESCS * 4;
> > >     int ret;
> > >
> > >     test->set_ring = true;
> > > @@ -2453,7 +2463,8 @@ static int testapp_hw_sw_max_ring_size(struct
> > test_spec *test)
> > >     test->ifobj_tx->ring.tx_pending = test->ifobj_tx-
> > >ring.tx_max_pending;
> > >     test->ifobj_tx->ring.rx_pending  = test->ifobj_tx-
> > >ring.rx_max_pending;
> > >     test->ifobj_rx->umem->num_frames = max_descs;
> > > -   test->ifobj_rx->xsk->rxqsize = max_descs;
> >
> > rxqsize is only used for setting xsk_socket_config::rx_size ?
> >
>
> Initially, we used the rxqsize field from the xsk_socket object, directly
> assigning max_descs to it and then using this value to set cfg.rx_size.
> However, we are now shifted to a different approach for test,  where we are
> setting cfg.rx_size based on the comp_size from the umem object, provided
> that umem->fill_size is true.
>
> > > +   test->ifobj_rx->umem->fill_size = max_descs;
> > > +   test->ifobj_rx->umem->comp_size = max_descs;
> > >     test->ifobj_tx->xsk->batch_size =
> > XSK_RING_PROD__DEFAULT_NUM_DESCS;
> > >     test->ifobj_rx->xsk->batch_size =
> > XSK_RING_PROD__DEFAULT_NUM_DESCS;
> > >
> > > @@ -2461,9 +2472,12 @@ static int testapp_hw_sw_max_ring_size(struct
> > test_spec *test)
> > >     if (ret)
> > >             return ret;
> > >
> > > -   /* Set batch_size to 4095 */
> > > -   test->ifobj_tx->xsk->batch_size = max_descs - 1;
> > > -   test->ifobj_rx->xsk->batch_size = max_descs - 1;
> > > +   /* Set batch_size to 8152 for testing, as the ice HW ignores the 3
> > lowest bits when updating
> > > +    * the Rx HW tail register.
> >
> > i would wrap the comment to 80 chars but that's personal taste.
> >
>
> I will do it.

You can keep it at 100 chars since that is used in most of the file.
That is allowed these days unless I mistake myself. Though the file
started out at 80 chars.

> > > +    */
> > > +   test->ifobj_tx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending
> > - 8;
> > > +   test->ifobj_rx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending
> > - 8;
> > > +   pkt_stream_replace(test, max_descs, MIN_PKT_SIZE);
> > >     return testapp_validate_traffic(test);  }
> > >
> > > diff --git a/tools/testing/selftests/bpf/xskxceiver.h
> > > b/tools/testing/selftests/bpf/xskxceiver.h
> > > index 906de5fab7a3..885c948c5d83 100644
> > > --- a/tools/testing/selftests/bpf/xskxceiver.h
> > > +++ b/tools/testing/selftests/bpf/xskxceiver.h
> > > @@ -80,6 +80,8 @@ struct xsk_umem_info {
> > >     void *buffer;
> > >     u32 frame_size;
> > >     u32 base_addr;
> > > +   u32 fill_size;
> > > +   u32 comp_size;
> > >     bool unaligned_mode;
> > >  };
> > >
> > > --
> > > 2.34.1
> > >
>

