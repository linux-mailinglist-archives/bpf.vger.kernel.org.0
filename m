Return-Path: <bpf+bounces-12985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C4C7D2DF2
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 11:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD531C20928
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 09:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A1612B9F;
	Mon, 23 Oct 2023 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe2km3me"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AEE12B8A;
	Mon, 23 Oct 2023 09:20:04 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C22597;
	Mon, 23 Oct 2023 02:20:02 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b2d9a9c824so734942b6e.0;
        Mon, 23 Oct 2023 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698052801; x=1698657601; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vTLLmppAiMZ7nebqhxgQeiaMrLVs8gT7ZeBZYFeZ6xE=;
        b=Xe2km3mefczzcEdTcj3r5z29OEcc9m2dEynCHe4u18Bg0Qe0xPid9udVTJReXpgL11
         /w1OLrrz2peHd2LXTZ4EIKsg5CZcwjG71QleQVJr4SwXD69nUZK14zJ4/2/6DtJMDmpl
         q6sH0ZpqliwoIIse/Q7hogJXfwO24OP6RIBjkqd9C69T14l83saw1cCXXWwI1CP7jVa/
         n/q8GLseWdzzM5ew4ZP7FHRWJ4MPHJxsX12HSxfrqlhAFFANrCHvDon1gDR3fGNh5+Wh
         UWsUQzSD/1GMV6ULZ7ZKK00RlGWHNlcym4P019lzr2UmIqZN7VlPAdalGSClmdO6zyKr
         fMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698052801; x=1698657601;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTLLmppAiMZ7nebqhxgQeiaMrLVs8gT7ZeBZYFeZ6xE=;
        b=gSApZzXYJNSnO3MdOJtLS+gsY/HfxTeDiE2ungy1jqPW3wMMSjftQA4x7JE/s/gPTR
         qB0y0wmi++hcyMmkLVfUcl1oyU/hIHb1sl9r/LgTKq25efTBLb0choawYiRreuLqZu73
         6UBkvmd/P5uC5ye9mRWEJe5ZXDMYGZAOzyfYpoD9NTIVUHrmkKQSALP67Ia2o9Q7P93U
         rLQKe/lPcaz6VtBA0tuNfmjvezSJKDPs4feYWL3Rwyjtqw+V/+8q8WScuVnPhBO+PRBS
         E/GEIXhIY+Tc2QnaQKiaDv10lv17+MGPGTWG1tEMhVzaMnaVkiufYyOw0veOFZ+e0lsK
         KUPw==
X-Gm-Message-State: AOJu0Yztr85CcmydEXO8iqJFft4srNUy1UhcEmRy0GhinW61BJjAchwE
	Cjb+xakws4GuRtJfbZA5RUdr/3T4NONqE8g3j5Q=
X-Google-Smtp-Source: AGHT+IFriz68SBWCUSMU11F4QB9bXbe0kY3AVlbNs7eJqLAlATQXIQkeCpneiw2ILwtUzPeql2Rdrrw5FcvVA8kr3SI=
X-Received: by 2002:a05:6830:a84:b0:6c4:7516:f2cf with SMTP id
 n4-20020a0568300a8400b006c47516f2cfmr8139106otu.2.1698052801541; Mon, 23 Oct
 2023 02:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com> <20231019174944.3376335-12-sdf@google.com>
In-Reply-To: <20231019174944.3376335-12-sdf@google.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 23 Oct 2023 11:19:50 +0200
Message-ID: <CAJ8uoz0UERM3_yAbNmTV=c5kE1rmKBY2KQ0bRH9gV6de1NRJqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 11/11] xsk: Document tx_metadata_len layout
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, yoong.siang.song@intel.com, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Oct 2023 at 19:50, Stanislav Fomichev <sdf@google.com> wrote:
>
> - how to use
> - how to query features
> - pointers to the examples
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  Documentation/networking/index.rst           |  1 +
>  Documentation/networking/xsk-tx-metadata.rst | 77 ++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/networking/xsk-tx-metadata.rst
>
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index 2ffc5ad10295..f3c2566d6cad 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -122,6 +122,7 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev development process specifics.
>     xfrm_sync
>     xfrm_sysctl
>     xdp-rx-metadata
> +   xsk-tx-metadata
>
>  .. only::  subproject and html
>
> diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
> new file mode 100644
> index 000000000000..b7289f06745c
> --- /dev/null
> +++ b/Documentation/networking/xsk-tx-metadata.rst
> @@ -0,0 +1,77 @@
> +==================
> +AF_XDP TX Metadata
> +==================
> +
> +This document describes how to enable offloads when transmitting packets
> +via :doc:`af_xdp`. Refer to :doc:`xdp-rx-metadata` on how to access similar
> +metadata on the receive side.
> +
> +General Design
> +==============
> +
> +The headroom for the metadata is reserved via ``tx_metadata_len`` in
> +``struct xdp_umem_reg``. The metadata length is therefore the same for
> +every socket that shares the same umem. The metadata layout is a fixed UAPI,
> +refer to ``union xsk_tx_metadata`` in ``include/uapi/linux/if_xdp.h``.
> +Thus, generally, the ``tx_metadata_len`` field above should contain
> +``sizeof(union xsk_tx_metadata)``.
> +
> +The headroom and the metadata itself should be located right before
> +``xdp_desc->addr`` in the umem frame. Within a frame, the metadata
> +layout is as follows::
> +
> +           tx_metadata_len
> +     /                         \
> +    +-----------------+---------+----------------------------+
> +    | xsk_tx_metadata | padding |          payload           |
> +    +-----------------+---------+----------------------------+
> +                                ^
> +                                |
> +                          xdp_desc->addr
> +
> +An AF_XDP application can request headrooms larger than ``sizeof(struct
> +xsk_tx_metadata)``. The kernel will ignore the padding (and will still
> +use ``xdp_desc->addr - tx_metadata_len`` to locate
> +the ``xsk_tx_metadata``). For the frames that shouldn't carry
> +any metadata (i.e., the ones that don't have ``XDP_TX_METADATA`` option),
> +the metadata area is ignored by the kernel as well.
> +
> +The flags field enables the particular offload:
> +
> +- ``XDP_TX_METADATA_TIMESTAMP``: requests the device to put transmission
> +  timestamp into ``tx_timestamp`` field of ``union xsk_tx_metadata``.
> +- ``XDP_TX_METADATA_CHECKSUM``: requests the device to calculate L4
> +  checksum. ``csum_start`` specifies byte offset of there the checksumming

nit: of there -> where

> +  should start and ``csum_offset`` specifies byte offset where the
> +  device should store the computed checksum.
> +- ``XDP_TX_METADATA_CHECKSUM_SW``: requests checksum calculation to
> +  be done in software; this mode works only in ``XSK_COPY`` mode and
> +  is mostly intended for testing. Do not enable this option, it
> +  will negatively affect performance.
> +
> +Besides the flags above, in order to trigger the offloads, the first
> +packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
> +bit in the ``options`` field. Also not that in a multi-buffer packet

nit: not -> note

> +only the first chunk should carry the metadata.
> +
> +Querying Device Capabilities
> +============================
> +
> +Every devices exports its offloads capabilities via netlink netdev family.
> +Refer to ``xsk-flags`` features bitmask in
> +``Documentation/netlink/specs/netdev.yaml``.
> +
> +- ``tx-timestamp``: device supports ``XDP_TX_METADATA_TIMESTAMP``
> +- ``tx-checksum``: device supports ``XDP_TX_METADATA_CHECKSUM``
> +
> +Note that every devices supports ``XDP_TX_METADATA_CHECKSUM_SW`` when
> +running in ``XSK_COPY`` mode.
> +
> +See ``tools/net/ynl/samples/netdev.c`` on how to query this information.
> +
> +Example
> +=======
> +
> +See ``tools/testing/selftests/bpf/xdp_hw_metadata.c`` for an example
> +program that handles TX metadata. Also see https://github.com/fomichev/xskgen
> +for a more bare-bones example.
> --
> 2.42.0.655.g421f12c284-goog
>
>

