Return-Path: <bpf+bounces-13047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F077B7D3F45
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 20:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90043B20F55
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90AB219FC;
	Mon, 23 Oct 2023 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noRhcJwh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE0224CC
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 18:31:23 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9032E9B
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 11:31:21 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c9f973d319so25709065ad.0
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698085881; x=1698690681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wPnBqAKtu7qfmlWwJUK17l0J3rYG4g6m8kBJfqHBWcI=;
        b=noRhcJwhCQfXlnR6nfDGhLsP3UYBi2y7YHr2RGSwCp2duqgu/TN2ecnH1nS4lco7J/
         /OjqbzZ2DpoEZUSwx5b4QGw2bbD19cBsH8/rBdq0ZxbEOXvXkMSz0Ny+uBDCkbPUWVgo
         fotd9a9N8BdpoO3Fno7JblFiRbIzTdxFp5CBHxZOQs524v6jtEPfKznXMhBGuklpd5aK
         348Hbd8fCbf9Wxg4SFpl3+ei52or/r9tntS2EmpeOPisvSnn61mirLtexxTIfpCWCtdR
         I9vLYKtr7cN9QuHwZ4AW3cPWMn1ZInQPDLDGnPLhba6gJvjGZBWnIECfr7amhNrW/qw3
         djVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085881; x=1698690681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPnBqAKtu7qfmlWwJUK17l0J3rYG4g6m8kBJfqHBWcI=;
        b=I0740epeMjjFP+ynTT5uNj8BZXc9G+4pVRCOA6b14vXydmge0H75cr6pfWd9BVwegd
         SrbhqUwNduSdx3lZr52Gqgm/bdVduR1AQIP8AuleVhPiYcUn42v0Jdv42v4m0BYdE3oN
         YnX4uBdVbeRmUCAOvAkmd+0T2S8reQhwaEHX4c1Op2yG32mSb+hLc6H2RLF5YKx35VaA
         3KLi18cgPLAo8rAOtOJjnVjkKNHY+onmuC6ktNXOCYryonMA8feWIrm+TUOdDzPbUbX1
         tHrBTr4v7wMZ71wn0xL0dJe8jx/p3RRRRTOBBzTmn8aXwMTJ8mHSZylEm/Zafb+Cvqqv
         iHuA==
X-Gm-Message-State: AOJu0YzXKl8gOfkQOJeDFOwcJ6Su165+08t3iDg0BK1lM2jdGSTFLeG9
	8waJs3PdTyA6+kXtnzGL2PD4ZSA=
X-Google-Smtp-Source: AGHT+IG+XvWazJNWN5c7NNnSVe2lrJdtfauU4L3Qq2lLLg+ikexd9cjwYoiGnk2YQZO9DGNX/ZkD6CQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:968d:b0:1ca:7a4c:834d with SMTP id
 n13-20020a170902968d00b001ca7a4c834dmr206694plp.13.1698085881006; Mon, 23 Oct
 2023 11:31:21 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:31:19 -0700
In-Reply-To: <CAJ8uoz0UERM3_yAbNmTV=c5kE1rmKBY2KQ0bRH9gV6de1NRJqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com> <20231019174944.3376335-12-sdf@google.com>
 <CAJ8uoz0UERM3_yAbNmTV=c5kE1rmKBY2KQ0bRH9gV6de1NRJqA@mail.gmail.com>
Message-ID: <ZTa792UUm6dACdf0@google.com>
Subject: Re: [PATCH bpf-next v4 11/11] xsk: Document tx_metadata_len layout
From: Stanislav Fomichev <sdf@google.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, yoong.siang.song@intel.com, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"

On 10/23, Magnus Karlsson wrote:
> On Thu, 19 Oct 2023 at 19:50, Stanislav Fomichev <sdf@google.com> wrote:
> >
> > - how to use
> > - how to query features
> > - pointers to the examples
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  Documentation/networking/index.rst           |  1 +
> >  Documentation/networking/xsk-tx-metadata.rst | 77 ++++++++++++++++++++
> >  2 files changed, 78 insertions(+)
> >  create mode 100644 Documentation/networking/xsk-tx-metadata.rst
> >
> > diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> > index 2ffc5ad10295..f3c2566d6cad 100644
> > --- a/Documentation/networking/index.rst
> > +++ b/Documentation/networking/index.rst
> > @@ -122,6 +122,7 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev development process specifics.
> >     xfrm_sync
> >     xfrm_sysctl
> >     xdp-rx-metadata
> > +   xsk-tx-metadata
> >
> >  .. only::  subproject and html
> >
> > diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
> > new file mode 100644
> > index 000000000000..b7289f06745c
> > --- /dev/null
> > +++ b/Documentation/networking/xsk-tx-metadata.rst
> > @@ -0,0 +1,77 @@
> > +==================
> > +AF_XDP TX Metadata
> > +==================
> > +
> > +This document describes how to enable offloads when transmitting packets
> > +via :doc:`af_xdp`. Refer to :doc:`xdp-rx-metadata` on how to access similar
> > +metadata on the receive side.
> > +
> > +General Design
> > +==============
> > +
> > +The headroom for the metadata is reserved via ``tx_metadata_len`` in
> > +``struct xdp_umem_reg``. The metadata length is therefore the same for
> > +every socket that shares the same umem. The metadata layout is a fixed UAPI,
> > +refer to ``union xsk_tx_metadata`` in ``include/uapi/linux/if_xdp.h``.
> > +Thus, generally, the ``tx_metadata_len`` field above should contain
> > +``sizeof(union xsk_tx_metadata)``.
> > +
> > +The headroom and the metadata itself should be located right before
> > +``xdp_desc->addr`` in the umem frame. Within a frame, the metadata
> > +layout is as follows::
> > +
> > +           tx_metadata_len
> > +     /                         \
> > +    +-----------------+---------+----------------------------+
> > +    | xsk_tx_metadata | padding |          payload           |
> > +    +-----------------+---------+----------------------------+
> > +                                ^
> > +                                |
> > +                          xdp_desc->addr
> > +
> > +An AF_XDP application can request headrooms larger than ``sizeof(struct
> > +xsk_tx_metadata)``. The kernel will ignore the padding (and will still
> > +use ``xdp_desc->addr - tx_metadata_len`` to locate
> > +the ``xsk_tx_metadata``). For the frames that shouldn't carry
> > +any metadata (i.e., the ones that don't have ``XDP_TX_METADATA`` option),
> > +the metadata area is ignored by the kernel as well.
> > +
> > +The flags field enables the particular offload:
> > +
> > +- ``XDP_TX_METADATA_TIMESTAMP``: requests the device to put transmission
> > +  timestamp into ``tx_timestamp`` field of ``union xsk_tx_metadata``.
> > +- ``XDP_TX_METADATA_CHECKSUM``: requests the device to calculate L4
> > +  checksum. ``csum_start`` specifies byte offset of there the checksumming
> 
> nit: of there -> where
> 
> > +  should start and ``csum_offset`` specifies byte offset where the
> > +  device should store the computed checksum.
> > +- ``XDP_TX_METADATA_CHECKSUM_SW``: requests checksum calculation to
> > +  be done in software; this mode works only in ``XSK_COPY`` mode and
> > +  is mostly intended for testing. Do not enable this option, it
> > +  will negatively affect performance.
> > +
> > +Besides the flags above, in order to trigger the offloads, the first
> > +packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
> > +bit in the ``options`` field. Also not that in a multi-buffer packet
> 
> nit: not -> note

Thank you for both, will fix!

