Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3E864A42B
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 16:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiLLPba (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 10:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiLLPb3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 10:31:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04826263
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 07:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670859033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eQ9nNY9o+sfN2pVI6l4IpW1tTisjGU+XjI/JTDFZpfw=;
        b=dSlKGLz6oyHu6Z8qBBup8i5mcTbdbEZ2SNtOB5wysL+P+CaI4uzMwzr/XmQ6FkUjmctZ0H
        wZOzuxS7ZZmtr2M88hbscCrQ36C3CJn3BUFEQ2z5s/qyjhweCgzEoAQ3UXOE0N76gzJdet
        b+lJJflur6flKH0/9jBTMwrBiqN7wyk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-166-Z1sk4ZtKO_qIwzSUqMME1Q-1; Mon, 12 Dec 2022 10:30:32 -0500
X-MC-Unique: Z1sk4ZtKO_qIwzSUqMME1Q-1
Received: by mail-ej1-f72.google.com with SMTP id hp16-20020a1709073e1000b007adf5a83df7so7270029ejc.1
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 07:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQ9nNY9o+sfN2pVI6l4IpW1tTisjGU+XjI/JTDFZpfw=;
        b=NgNzFeO0o245mzS0srI2ef+ixPR9mk+JBPRvpamwDPbdYc7QTPcsIj16LJyQ3NqTH3
         HKSL7Y37Sw7eLTIkMZWIxCTTspPgDQMy/42+Xxmdj59G3I2ZMfxTrYR+g6ZSm/9GETjl
         69ykIdJQuAhQs5SNKW4DDqZ1Pf52Uhb+gqiQBJvHKLYIFK8vBV0FaFGSaPsDQBiKdsAL
         45+ro482kCA2sA31o+KWGC3kUukMCS9vmQb3C03eshlxPvGhk6nmbcxlSCvO/Ms1h/wI
         t1Z84cVJJl6pHJvDBFD2Apl3GD8CkaKm+gAxvE2m76zdLAojykuBM7Vd2BAp+CKYhUO0
         Ox7Q==
X-Gm-Message-State: ANoB5pl02BrNLfuAcVqkLCBm8OLvnzGJHfvYJPnEr6Fw24r/Si53Opn6
        hlt5wBJI4V2DVZ3jlDpknbV7YsDx/VlmAVCHQA1SwZiVwAkyZm8WHMJ+66vmklA2cA7XmEe3YkL
        5DPTx6HGQr5YG
X-Received: by 2002:aa7:cd8d:0:b0:45c:835b:ac6a with SMTP id x13-20020aa7cd8d000000b0045c835bac6amr14553055edv.37.1670859031211;
        Mon, 12 Dec 2022 07:30:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf53xcOTdZ54DNjerf9VEqUmoToVe4+cUvVImWb0GUKVRfVqctKwG/ST033E1+S0tjn8H3b+yw==
X-Received: by 2002:aa7:cd8d:0:b0:45c:835b:ac6a with SMTP id x13-20020aa7cd8d000000b0045c835bac6amr14553023edv.37.1670859030745;
        Mon, 12 Dec 2022 07:30:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f5-20020a05640214c500b00458b41d9460sm3814589edx.92.2022.12.12.07.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 07:30:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CCF0F82F162; Mon, 12 Dec 2022 16:30:28 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH bpf-next v1] docs/bpf: Add docs for BPF_PROG_TYPE_XDP
In-Reply-To: <20221212122400.64415-1-donald.hunter@gmail.com>
References: <20221212122400.64415-1-donald.hunter@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 12 Dec 2022 16:30:28 +0100
Message-ID: <87fsdkiqqz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Donald Hunter <donald.hunter@gmail.com> writes:

> Document XDP programs (BPF_PROG_TYPE_XDP) and the XDP data path.
>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/bpf/prog_xdp.rst | 176 +++++++++++++++++++++++++++++++++
>  1 file changed, 176 insertions(+)
>  create mode 100644 Documentation/bpf/prog_xdp.rst
>
> diff --git a/Documentation/bpf/prog_xdp.rst b/Documentation/bpf/prog_xdp.rst
> new file mode 100644
> index 000000000000..69b001a6c7d2
> --- /dev/null
> +++ b/Documentation/bpf/prog_xdp.rst
> @@ -0,0 +1,176 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +================
> +XDP BPF Programs
> +================
> +
> +XDP (eXpress Data Path) is a fast path in the kernel network stack. XDP allows
> +for packet processing by BPF programs before the packets traverse the L4-L7
> +network stack.

The 'L4-L7' thing is not really accurate, and it's not really relevant
here either, so just leave it out? Maybe:

"XDP (eXpress Data Path) is a fast path in the kernel network stack. XDP
allows for packet processing by BPF programs in the driver, before the
packets traverse the kernel networking stack"?


> Programs of type ``BPF_PROG_TYPE_XDP`` are attached to the XDP
> +hook of a specific interface in one of three modes:
> +
> +- ``SKB_MODE`` - The hook point is in the generic net device
> +- ``DRV_MODE`` - The hook point is in the driver for the interface
> +- ``HW_MODE`` - The BPF program is offloaded to the NIC

How about moving the attach mode stuff a bit later? When it's mentioned
this early it seems more important than it really is. Since the "modes"
is the next section, we could just leave it out of this intro altogether
(and move this paragraph into the beginning of the "XDP modes" section
below)?

> +The BPF program attached to an interface's XDP hook gets called for each L2
> +frame that is received on the interface. The program is passed a ``struct xdp_md
> +*ctx`` which gives access to the L2 data frame as well as some essential
> +metadata for the frame:
> +
> +.. code-block:: c
> +
> +    struct xdp_md {
> +            __u32 data;
> +            __u32 data_end;
> +            __u32 data_meta;
> +
> +            __u32 ingress_ifindex; /* rxq->dev->ifindex */
> +            __u32 rx_queue_index;  /* rxq->queue_index  */
> +            __u32 egress_ifindex;  /* txq->dev->ifindex */

Not sure it's relevant to show which kernel structures the data comes
from? Maybe change the comments to be English descriptions (like
"ingress ifindex", "ingress RXQ index"). We should also mention that
egress_ifindex is only available the program is attached to a devmap.
And, erm, the text should mention that XDP programs can be attached to a
devmap somewhere? :)

> +    };
> +
> +The BPF program can read and modify the frame before deciding what action should
> +be taken for the packet.

Do we explain how to do that anywhere? I.e., is the "direct data access"
thing explained in some other doc?

> The program returns one of the following action values
> +in order to tell the driver or net device how to process the packet (details in
> +:ref:`xdp_packet_actions`):
> +
> +- ``XDP_DROP`` - Drop the packet without any further processing
> +- ``XDP_PASS`` - Pass the packet to the kernel network stack for further
> +  processing
> +- ``XDP_TX`` - Transmit the packet out of the same interface
> +- ``XDP_REDIRECT`` - Redirect the packet to a specific destination
> +- ``XDP_ABORTED`` - Drop the packet and notify an exception state
> +
> +There are many BPF helper functions available to XDP programs for accessing and
> +modifying packet data, for interacting with the kernel networking stack and for
> +using BPF maps. `bpf-helpers(7)`_ describes the helpers available to XDP
> +programs.
> +
> +The `libxdp`_ library provides functions for attaching XDP programs to network
> +interfaces and for using ``AF_XDP`` sockets.
> +
> +XDP Modes
> +=========
> +
> +SKB Mode
> +--------
> +
> +An XDP program attached in SKB mode gets executed by the kernel network stack
> +*after* the driver has created a ``struct sk_buff`` (SKB) and passed it to the
> +networking stack. SKB mode is also referred to as *generic* mode and is always
> +available, whether or not the driver is XDP-enabled. An XDP program in SKB mode
> +is run by the netdev before classifiers or ``tc`` BPF programs are run.

I think we should add some text saying that the SKB mode has a
significant performance overhead compared to driver mode, and that the
TC hook in many cases is a better choice than using XDP in SKB mode.

I'd also move SKB mode below driver mode, to highlight that driver mode
is really the "main" XDP execution mode.

> +Driver Mode
> +-----------
> +
> +An XDP program attached in driver mode gets executed by the network driver for
> +an interface *before* the driver creates a ``struct sk_buff`` (SKB) for the
> +incoming packet. The XDP program runs immediately after the driver receives the
> +packet. This gives the XDP program an opportunity to entirely avoid the cost of
> +SKB creation and kernel network stack processing.
> +
> +Driver mode requires the driver to be XDP-enabled so is not always available.

Since this is supposed to be the authoritative documentation on XDP,
should we list which drivers support XDP here?

> +Hardware Mode
> +-------------
> +
> +Some devices may support hardware offload of BPF programs, which they do in a
> +hardware specific way.

"...which they do in a hardware-specific way, meaning that some features
and helpers are not available to offloaded programs." ?

Also, as above, should we mention that only the nfp driver supports this? 

> +.. _xdp_packet_actions:
> +
> +XDP Packet Actions
> +==================
> +
> +XDP_DROP
> +--------
> +
> +The ``XDP_DROP`` action tells the driver or netdev to drop the XDP frame without
> +any further processing.
> +
> +XDP_PASS
> +--------
> +
> +The ``XDP_PASS`` action tells the driver to convert the XDP frame into an SKB
> +and the driver or netdev to pass the SKB on to the kernel network stack for
> +normal processing.
> +
> +XDP_TX
> +------
> +
> +The ``XDP_TX`` action tells the driver or netdev to transmit the XDP frame out
> +of the associated interface.
> +
> +XDP_REDIRECT
> +------------
> +
> +The ``XDP_REDIRECT`` action tells the driver to redirect the packet for further
> +processing. There are several types of redirect available to the XDP program:
> +
> +- Redirect to another device by ifindex
> +- Redirect to another device using a devmap
> +- Redirect into an ``AF_XDP`` socket using an xskmap
> +- Redirect to another CPU using a cpumap, before delivering to the network stack
> +
> +The ``bpf_redirect()`` and ``bpf_redirect_map()`` helper functions are used
> +to set up the desired redirect destination before returning ``XDP_REDIRECT`` to
> +the driver.
> +
> +.. code-block:: c
> +
> +    long bpf_redirect(u32 ifindex, u64 flags)
> +
> +The ``bpf_redirect()`` helper function redirects the packet to the net device
> +identified by ``ifindex``.
> +
> +.. code-block:: c
> +
> +    long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
> +
> +The ``bpf_redirect_map()`` helper function redirects the packet to the
> +destination referenced by ``map`` at index ``key``. The type of destination
> +depends on the type ``map`` that is used:
> +
> +- ``BPF_MAP_TYPE_DEVMAP`` and ``BPF_MAP_TYPE_DEVMAP_HASH`` redirects the packet
> +  to another net device
> +- ``BPF_MAP_TYPE_CPUMAP`` redirects the packet processing to a specific CPU
> +- ``BPF_MAP_TYPE_XSKMAP`` redirects the packet to an ``AF_XDP`` socket. See
> +  ../networking/af_xdp.rst for more information.
> +
> +Detailed behaviour of ``bpf_redirect()`` and ``bpf_redirect_map()`` is described
> +in `bpf-helpers(7)`_. ``XDP_REDIRECT`` is described in more detail in
> +redirect.rst.
> +
> +XDP_ABORTED
> +-----------
> +
> +The ``XDP_ABORTED`` action tells the driver that the BPF program exited in an
> +exception state. The driver will drop the packet in the same way as if the BPF
> +program returned ``XDP_DROP`` but the ``trace_xdp_exception`` trace point is also
> +triggered.
> +
> +Examples
> +========
> +
> +An example XDP program that uses ``XDP_REDIRECT`` can be found in
> +`tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c`_ and the
> +corresponding user space code in
> +`tools/testing/selftests/bpf/xdp_redirect_multi.c`_
> +
> +References
> +==========
> +
> +- https://github.com/xdp-project/xdp-tools
> +- https://github.com/xdp-project/xdp-tutorial
> +- https://docs.cilium.io/en/latest/bpf/progtypes

Should we incorporate (some of) the text from the Cilium doc instead of
linking to it (assuming the license is compatible, of course)?

-Toke

