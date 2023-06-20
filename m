Return-Path: <bpf+bounces-2950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEDC737300
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 19:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53162813B6
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 17:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5922FA955;
	Tue, 20 Jun 2023 17:34:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF72AB20;
	Tue, 20 Jun 2023 17:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5741C433C8;
	Tue, 20 Jun 2023 17:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687282457;
	bh=8h6z/efvrutubaif8t3pIyVm8J77xaV8rSrSuVWeams=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EcTCqK+1y556YQFHYW389zSnG7SgIefIM9gXsqj8FDZBvN55UllY9ha3hHMhDDvnm
	 RjanYU9b0QV/rnqckE2CISHPgeuVzODiKwoXeAvzvk0Iyc/4zmiT/UoqwROrJuxRrG
	 G9FyRDX/dV6V714sVxnGgZO6sb1ky2Pg0m2gN6rsW/LAP1JY4En9+kJo5iqNOHoiQn
	 ZK70drvjjZDr6cyT/XuAnMl97nbMsPv193faJCAwAkdCyAM131krLiXkxcv5hjkuqC
	 Y8hqgjEAQebk5PSEDL1JnXKJEejyEUq+GVUIjIlc2kkyE1q+zrBktI5bWguPjTNLfT
	 VDvrKKMTS/obw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6057CBBF0B4; Tue, 20 Jun 2023 19:34:14 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 tirthendu.sarkar@intel.com, maciej.fijalkowski@intel.com,
 simon.horman@corigine.com
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
In-Reply-To: <20230615172606.349557-16-maciej.fijalkowski@intel.com>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-16-maciej.fijalkowski@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 20 Jun 2023 19:34:14 +0200
Message-ID: <87zg4uca21.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> From: Magnus Karlsson <magnus.karlsson@intel.com>
>
> Add AF_XDP multi-buffer support documentation including two
> pseudo-code samples.
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  Documentation/networking/af_xdp.rst | 177 ++++++++++++++++++++++++++++
>  1 file changed, 177 insertions(+)
>
> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> index 247c6c4127e9..2b583f58967b 100644
> --- a/Documentation/networking/af_xdp.rst
> +++ b/Documentation/networking/af_xdp.rst
> @@ -453,6 +453,93 @@ XDP_OPTIONS getsockopt
>  Gets options from an XDP socket. The only one supported so far is
>  XDP_OPTIONS_ZEROCOPY which tells you if zero-copy is on or not.
>  
> +Multi-Buffer Support
> +--------------------
> +
> +With multi-buffer support, programs using AF_XDP sockets can receive
> +and transmit packets consisting of multiple buffers both in copy and
> +zero-copy mode. For example, a packet can consist of two
> +frames/buffers, one with the header and the other one with the data,
> +or a 9K Ethernet jumbo frame can be constructed by chaining together
> +three 4K frames.
> +
> +Some definitions:
> +
> +* A packet consists of one or more frames
> +
> +* A descriptor in one of the AF_XDP rings always refers to a single
> +  frame. In the case the packet consists of a single frame, the
> +  descriptor refers to the whole packet.
> +
> +To enable multi-buffer support for an AF_XDP socket, use the new bind
> +flag XDP_USE_SG. If this is not provided, all multi-buffer packets
> +will be dropped just as before. Note that the XDP program loaded also
> +needs to be in multi-buffer mode. This can be accomplished by using
> +"xdp.frags" as the section name of the XDP program used.
> +
> +To represent a packet consisting of multiple frames, a new flag called
> +XDP_PKT_CONTD is introduced in the options field of the Rx and Tx
> +descriptors. If it is true (1) the packet continues with the next
> +descriptor and if it is false (0) it means this is the last descriptor
> +of the packet. Why the reverse logic of end-of-packet (eop) flag found
> +in many NICs? Just to preserve compatibility with non-multi-buffer
> +applications that have this bit set to false for all packets on Rx,
> +and the apps set the options field to zero for Tx, as anything else
> +will be treated as an invalid descriptor.
> +
> +These are the semantics for producing packets onto AF_XDP Tx ring
> +consisting of multiple frames:
> +
> +* When an invalid descriptor is found, all the other
> +  descriptors/frames of this packet are marked as invalid and not
> +  completed. The next descriptor is treated as the start of a new
> +  packet, even if this was not the intent (because we cannot guess
> +  the intent). As before, if your program is producing invalid
> +  descriptors you have a bug that must be fixed.
> +
> +* Zero length descriptors are treated as invalid descriptors.
> +
> +* For copy mode, the maximum supported number of frames in a packet is
> +  equal to CONFIG_MAX_SKB_FRAGS + 1. If it is exceeded, all
> +  descriptors accumulated so far are dropped and treated as
> +  invalid. To produce an application that will work on any system
> +  regardless of this config setting, limit the number of frags to 18,
> +  as the minimum value of the config is 17.
> +
> +* For zero-copy mode, the limit is up to what the NIC HW
> +  supports. Usually at least five on the NICs we have checked. We
> +  consciously chose to not enforce a rigid limit (such as
> +  CONFIG_MAX_SKB_FRAGS + 1) for zero-copy mode, as it would have
> +  resulted in copy actions under the hood to fit into what limit
> +  the NIC supports. Kind of defeats the purpose of zero-copy mode.

How is an application supposed to discover the actual limit for a given
NIC/driver?

> +* The ZC batch API guarantees that it will provide a batch of Tx
> +  descriptors that ends with full packet at the end. If not, ZC
> +  drivers would have to gather the full packet on their side. The
> +  approach we picked makes ZC drivers' life much easier (at least on
> +  Tx side).

This seems like it implies some constraint on how an application can use
the APIs, but it's not quite clear to me what those constraints are, nor
what happens if an application does something different. This should
probably be spelled out...

> +On the Rx path in copy-mode, the xsk core copies the XDP data into
> +multiple descriptors, if needed, and sets the XDP_PKT_CONTD flag as
> +detailed before. Zero-copy mode works the same, though the data is not
> +copied. When the application gets a descriptor with the XDP_PKT_CONTD
> +flag set to one, it means that the packet consists of multiple buffers
> +and it continues with the next buffer in the following
> +descriptor. When a descriptor with XDP_PKT_CONTD == 0 is received, it
> +means that this is the last buffer of the packet. AF_XDP guarantees
> +that only a complete packet (all frames in the packet) is sent to the
> +application.

In light of the comment on batch size below, I think it would be useful
to spell out what this means exactly. IIUC correctly, it means that the
kernel will check the ringbuffer before starting to copy the data, and
if there are not enough descriptors available, it will drop the packet
instead of doing a partial copy, right? And this is the case for both ZC
and copy mode?

> +If application reads a batch of descriptors, using for example the libxdp
> +interfaces, it is not guaranteed that the batch will end with a full
> +packet. It might end in the middle of a packet and the rest of the
> +buffers of that packet will arrive at the beginning of the next batch,
> +since the libxdp interface does not read the whole ring (unless you
> +have an enormous batch size or a very small ring size).
> +
> +An example program each for Rx and Tx multi-buffer support can be found
> +later in this document.
> +
>  Usage
>  =====
>  
> @@ -532,6 +619,96 @@ like this:
>  But please use the libbpf functions as they are optimized and ready to
>  use. Will make your life easier.
>  
> +Usage Multi-Buffer Rx
> +=====================
> +
> +Here is a simple Rx path pseudo-code example (using libxdp interfaces
> +for simplicity). Error paths have been excluded to keep it short:
> +
> +.. code-block:: c
> +
> +    void rx_packets(struct xsk_socket_info *xsk)
> +    {
> +        static bool new_packet = true;
> +        u32 idx_rx = 0, idx_fq = 0;
> +        static char *pkt;
> +
> +        int rcvd = xsk_ring_cons__peek(&xsk->rx, opt_batch_size, &idx_rx);
> +
> +        xsk_ring_prod__reserve(&xsk->umem->fq, rcvd, &idx_fq);
> +
> +        for (int i = 0; i < rcvd; i++) {
> +            struct xdp_desc *desc = xsk_ring_cons__rx_desc(&xsk->rx, idx_rx++);
> +            char *frag = xsk_umem__get_data(xsk->umem->buffer, desc->addr);
> +            bool eop = !(desc->options & XDP_PKT_CONTD);
> +
> +        if (new_packet)
> +            pkt = frag;
> +        else
> +            add_frag_to_pkt(pkt, frag);
> +
> +        if (eop)
> +            process_pkt(pkt);
> +
> +        new_packet = eop;
> +
> +        *xsk_ring_prod__fill_addr(&xsk->umem->fq, idx_fq++) = desc->addr;

Indentation is off here...

-Toke

