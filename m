Return-Path: <bpf+bounces-60234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902FDAD438E
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 22:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E58017C7B9
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 20:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CF8267F53;
	Tue, 10 Jun 2025 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K10jK+A8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705962676C5
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749586373; cv=none; b=nDZDh5MwF2czBNyXl/vJPxKWo/TwGCVh9fmM8nvc3g5O5A7OGeFw9EOk3pDkVcHTVykTf9P49HghPJ+WZkyB1n2/c530o0HVQ8yJtF+Ctdr7uVdmwOBPN7qLLfPP9XZIRaeUBFLgC42z8n4WBQC/0Joww6wg/jKCGLE9fXI1Qs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749586373; c=relaxed/simple;
	bh=9HZg/zGdCA3uPb4SkTr8gpbbnD935x6loHb47pHsqRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WrIEsK+41vL7/UP/cI7o6Hcnwb+B8uVt5rBBTwkfLybbuGRChfihyWCW/WjbVN/VkS0PxSmzh374KvUCBs6hNgnYhmNa7LbmMEYhHF1KVF1hi9KYp7a+DAEwcqlt+xSR+PcydTau4Pmtb8K2ytx6llJY/oxyfO/7qfN54bECuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K10jK+A8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749586369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SN4L+FP9co++O04iFLwWVF/+cUo3J0C+YHwejI7xqYg=;
	b=K10jK+A8lfACHrp46icizqiMqfA25kathRFTzQRiRR4bZ8c/TrT79TuRbqTjCoNQwa/tHe
	h8sQ9tg+69/DDV4x5afsazCdWN+lMTb6BUkCO7VYpkBiQHT+eJY0srkzBHuJqD1VffTzp2
	q58IzUKcwDGr1908wu03bgsrg75nkns=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-seQszZ8xOjqcYfhWBnCqcQ-1; Tue, 10 Jun 2025 16:12:48 -0400
X-MC-Unique: seQszZ8xOjqcYfhWBnCqcQ-1
X-Mimecast-MFC-AGG-ID: seQszZ8xOjqcYfhWBnCqcQ_1749586366
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-55324829e0eso3598697e87.3
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 13:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749586365; x=1750191165;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SN4L+FP9co++O04iFLwWVF/+cUo3J0C+YHwejI7xqYg=;
        b=UwEteHqrUrVt/YztwfdGqCRfjABT+gobXjPiviho62+4+0qBzJ46N4G/1T79cK1uVY
         axqH4Z/s79oqK17bvG0qyGRwdeH0wdQXVzj7sq99dN0hnMSl9S7LlDBs4UkGwtyW384m
         lsi68Wss06oWWzzo8hfwMsQlGhKPbMCqT4biLgcjiHyx7kfiZjVPhtRYgN3aNKlgk0B4
         ivzvhSzp23FBsNeyEaskHDC5zytbib17P8FaAuZ/zYDXI6qO1GL4H9kA1eBtnYpV7ikY
         aqN8lWPVu59nS/gZ4Gt86YR9vgu2BbRvR6zwIRkYW4uxDJtVozEScb2KadlOb84oZaQK
         yCsw==
X-Gm-Message-State: AOJu0YxEc+ZMPUd0/7mQzH0YEP+taWf8c8bXObEIQuWw0dlHzkk7IS7C
	zOhdBvGrYpK0Way9ac6jLhu/S91xrh9BchIZERIcaK8XdKh8OgbwxcPQcmr8QpvoO0QqfAWKq98
	oBQmhi1ILKGynJaMHju75xbHjc2bmAM8I4J7rm0gkXtEUcMXRnMNhHg==
X-Gm-Gg: ASbGncs+g04uAfU8+wUpFaAzLOzUZxr9MVRjn3WWNx0Qjc8hT3GS1syGBjSU5Ubjk8e
	oHCdyTjo8p9O1qWOGYjHH7MNUHdGEVSMNcDZcGrpuFWx/EPS3WXyQzJ+RxjjuOaPb2CBsI37yZI
	pEpG7ZDJR29lTyxVC88YtPXkXqvlx+ux9HGWOUNMHs0N+QDiuNH3262ALhFNMJHQNiOnVEDaCHF
	KBdrHTDRJVrHEFLVHThVG8fkaPdJxZqU0kTOWyD/9CDe9CyxQlI/gaGPLM0ajZfD88qTPHavOph
	MybL5Prrm1mpmO9CfAU=
X-Received: by 2002:a05:6512:1290:b0:553:2438:8d02 with SMTP id 2adb3069b0e04-5539c256e90mr289032e87.47.1749586365452;
        Tue, 10 Jun 2025 13:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETd7q66qjBBDNFnAaWMNeZTHbVKgAYdc2PTw/KS13FF24A4gTLmlNwf6c5ZdZRW9tFDroFYA==
X-Received: by 2002:a05:6512:1290:b0:553:2438:8d02 with SMTP id 2adb3069b0e04-5539c256e90mr289014e87.47.1749586364896;
        Tue, 10 Jun 2025 13:12:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553676d712fsm1673767e87.57.2025.06.10.13.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 13:12:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 505FE1AF6B64; Tue, 10 Jun 2025 22:12:41 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev
 <stfomichev@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, lorenzo@kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, sdf@fomichev.me, kernel-team@cloudflare.com,
 arthur@arthurfabre.com, jakub@cloudflare.com, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
In-Reply-To: <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Jun 2025 22:12:41 +0200
Message-ID: <87plfbcq4m.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 6/6/25 4:45 AM, Stanislav Fomichev wrote:
>> On 06/03, Jesper Dangaard Brouer wrote:
>>> Update the documentation[1] based on the changes in this patchset.
>>>
>>> [1] https://docs.kernel.org/networking/xdp-rx-metadata.html
>>>
>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> ---
>>>   Documentation/networking/xdp-rx-metadata.rst |   74 ++++++++++++++++++++------
>>>   net/core/xdp.c                               |   32 +++++++++++
>>>   2 files changed, 90 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
>>> index a6e0ece18be5..2c54208e4f7e 100644
>>> --- a/Documentation/networking/xdp-rx-metadata.rst
>>> +++ b/Documentation/networking/xdp-rx-metadata.rst
>>> @@ -90,22 +90,64 @@ the ``data_meta`` pointer.
>>>   In the future, we'd like to support a case where an XDP program
>>>   can override some of the metadata used for building ``skbs``.
>>>   
>>> -bpf_redirect_map
>>> -================
>>> -
>>> -``bpf_redirect_map`` can redirect the frame to a different device.
>>> -Some devices (like virtual ethernet links) support running a second XDP
>>> -program after the redirect. However, the final consumer doesn't have
>>> -access to the original hardware descriptor and can't access any of
>>> -the original metadata. The same applies to XDP programs installed
>>> -into devmaps and cpumaps.
>>> -
>>> -This means that for redirected packets only custom metadata is
>>> -currently supported, which has to be prepared by the initial XDP program
>>> -before redirect. If the frame is eventually passed to the kernel, the
>>> -``skb`` created from such a frame won't have any hardware metadata populated
>>> -in its ``skb``. If such a packet is later redirected into an ``XSK``,
>>> -that will also only have access to the custom metadata.
>>> +XDP_REDIRECT
>>> +============
>>> +
>>> +The ``XDP_REDIRECT`` action forwards an XDP frame to another net device or a CPU
>>> +(via cpumap/devmap) for further processing. It is invoked using BPF helpers like
>>> +``bpf_redirect_map()`` or ``bpf_redirect()``.  When an XDP frame is redirected,
>>> +the recipient (e.g., an XDP program on a veth device, or the kernel stack via
>>> +cpumap) loses direct access to the original NIC's hardware descriptor and thus
>>> +its hardware metadata
>>> +
>>> +By default, this loss of access means that if an ``xdp_frame`` is redirected and
>>> +then converted to an ``skb``, its ``skb`` fields for hardware-derived metadata
>>> +(like ``skb->hash`` or VLAN info) are not populated from the original
>>> +packet. This can impact features like Generic Receive Offload (GRO).  While XDP
>>> +programs can manually save custom data (e.g., using ``bpf_xdp_adjust_meta()``),
>>> +propagating specific *hardware* RX hints to ``skb`` creation requires using the
>>> +kfuncs described below.
>>> +
>>> +To enable propagating selected hardware RX hints, store BPF kfuncs allow an
>>> +XDP program on the initial NIC to read these hints and then explicitly
>>> +*store* them. The kfuncs place this metadata in locations associated with
>>> +the XDP packet buffer, making it available if an ``skb`` is later built or
>>> +the frame is otherwise processed. For instance, RX hash and VLAN tags are
>>> +stored within the XDP frame's addressable headroom, while RX timestamps are
>>> +typically written to an area corresponding to ``skb_shared_info``.
>>> +
>>> +**Crucially, the BPF programmer must call these "store" kfuncs to save the
>>> +desired hardware hints for propagation.** The system does not do this
>>> +automatically. The NIC driver is responsible for ensuring sufficient headroom is
>>> +available; kfuncs may return ``-ENOSPC`` if space is inadequate for storing
>>> +these hints.
>> 
>> Why not have a new flag for bpf_redirect that transparently stores all
>> available metadata? If you care only about the redirect -> skb case.
>> Might give us more wiggle room in the future to make it work with
>> traits.
>
> Also q from my side: If I understand the proposal correctly, in order to fully
> populate an skb at some point, you have to call all the bpf_xdp_metadata_* kfuncs
> to collect the data from the driver descriptors (indirect call), and then yet
> again all equivalent bpf_xdp_store_rx_* kfuncs to re-store the data in struct
> xdp_rx_meta again. This seems rather costly and once you add more kfuncs with
> meta data aren't you better off switching to tc(x) directly so the driver can
> do all this natively? :/

I agree that the "one kfunc per metadata item" scales poorly. IIRC, the
hope was (back when we added the initial HW metadata support) that we
would be able to inline them to avoid the function call overhead.

That being said, even with half a dozen function calls, that's still a
lot less overhead from going all the way to TC(x). The goal of the use
case here is to do as little work as possible on the CPU that initially
receives the packet, instead moving the network stack processing (and
skb allocation) to a different CPU with cpumap.

So even if the *total* amount of work being done is a bit higher because
of the kfunc overhead, that can still be beneficial because it's split
between two (or more) CPUs.

I'm sure Jesper has some concrete benchmarks for this lying around
somewhere, hopefully he can share those :)

> Also, have you thought about taking the opportunity to generalize the existing
> struct xsk_tx_metadata? It would be nice to actually use the same/similar struct
> for RX and TX, similarly as done in struct virtio_net_hdr. Such that we have
> XDP_{RX,TX}_METADATA and XDP_{RX,TX}MD_FLAGS_* to describe what meta data we
> have and from a developer PoV this will be a nicely consistent API in XDP. Then
> you could store at the right location in the meta data region just with
> bpf_xdp_metadata_* kfuncs (and/or plain BPF code) and finally set XDP_RX_METADATA
> indicator bit.

Wouldn't this make the whole thing (effectively) UAPI?

-Toke


