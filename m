Return-Path: <bpf+bounces-60182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CC2AD39ED
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2762F7AA413
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCC529ACDB;
	Tue, 10 Jun 2025 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="VIQm6z9u"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1D29827C;
	Tue, 10 Jun 2025 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563340; cv=none; b=m1gGDvF/3Qod1ZbLLoAXNVZ4c4N9D6kzQ1AGg+RrDyZ1wYNQTGgNejtpN4nB/8USyIAKrJBA/gia5+cqp50g40NiWGhHRKwQYoXDTLlURZCVDS3afog1iZJV/ALxCKUIOR3sQpXQp4aJIoUZR4xcmgNLvPoXzuund8w2uJ0Ijs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563340; c=relaxed/simple;
	bh=o7MT+1yWJ1FcHO9fcPG6RY9nyAeuxospmM9wYr00rks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MupmL04yonGLp0bln/ak5w8rHn/R9tI5jnzuQbNTPRaNZB7LlU2dea/yHdL3CPFKzI2RwIxMYwj/cTEl6yj3VvMA/SEEWFbz+YBt6cwSBa4Jpfs00Oi7X1C/J/cmdW1hxmHDXmnxiJa5m4mE6WiDAj9ZHIBP/wg7n4msqFHyCV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=VIQm6z9u; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=NN1oY6hyaXR/auEel5IcJ300oTpCb73CwzAZ443+3zI=; b=VIQm6z9uDh7r5x0aSn9a1e6VZ5
	MLf7bkeUQ0VSVVM8+jVLbq4rvIqiZ7jAOGq4YEpzbGWPX3ij1digJZFN/1xYXw7egYcTiGGwGyxTw
	Rt6rLCeQBIlJpXUKnnxAj/AViUMHQGApVPqfSaeavOjo7ovJ7deu+QXhfQUhiAnaxfFV8Cy0SOkcY
	mEgKKqPmD6G0ADZWyqREaHiI/b31i53lKqg2LeMGX27VGIEXJlly6XPiv7fD4YAxMwIzZTE+fjQLD
	DfwBVz5ma53R3syyBdWl9qI8J/fjF4pdpJs/v3s38V96RYNxmnDcSSemtroQrczr98WT+qbogHDAy
	26U71AaQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uOzLJ-000H5V-10;
	Tue, 10 Jun 2025 15:48:45 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uOzLI-000HpM-1I;
	Tue, 10 Jun 2025 15:48:44 +0200
Message-ID: <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
Date: Tue, 10 Jun 2025 15:48:43 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <borkmann@iogearbox.net>, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com, Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <aEJWTPdaVmlIYyKC@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27664/Tue Jun 10 10:41:04 2025)

On 6/6/25 4:45 AM, Stanislav Fomichev wrote:
> On 06/03, Jesper Dangaard Brouer wrote:
>> Update the documentation[1] based on the changes in this patchset.
>>
>> [1] https://docs.kernel.org/networking/xdp-rx-metadata.html
>>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>>   Documentation/networking/xdp-rx-metadata.rst |   74 ++++++++++++++++++++------
>>   net/core/xdp.c                               |   32 +++++++++++
>>   2 files changed, 90 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
>> index a6e0ece18be5..2c54208e4f7e 100644
>> --- a/Documentation/networking/xdp-rx-metadata.rst
>> +++ b/Documentation/networking/xdp-rx-metadata.rst
>> @@ -90,22 +90,64 @@ the ``data_meta`` pointer.
>>   In the future, we'd like to support a case where an XDP program
>>   can override some of the metadata used for building ``skbs``.
>>   
>> -bpf_redirect_map
>> -================
>> -
>> -``bpf_redirect_map`` can redirect the frame to a different device.
>> -Some devices (like virtual ethernet links) support running a second XDP
>> -program after the redirect. However, the final consumer doesn't have
>> -access to the original hardware descriptor and can't access any of
>> -the original metadata. The same applies to XDP programs installed
>> -into devmaps and cpumaps.
>> -
>> -This means that for redirected packets only custom metadata is
>> -currently supported, which has to be prepared by the initial XDP program
>> -before redirect. If the frame is eventually passed to the kernel, the
>> -``skb`` created from such a frame won't have any hardware metadata populated
>> -in its ``skb``. If such a packet is later redirected into an ``XSK``,
>> -that will also only have access to the custom metadata.
>> +XDP_REDIRECT
>> +============
>> +
>> +The ``XDP_REDIRECT`` action forwards an XDP frame to another net device or a CPU
>> +(via cpumap/devmap) for further processing. It is invoked using BPF helpers like
>> +``bpf_redirect_map()`` or ``bpf_redirect()``.  When an XDP frame is redirected,
>> +the recipient (e.g., an XDP program on a veth device, or the kernel stack via
>> +cpumap) loses direct access to the original NIC's hardware descriptor and thus
>> +its hardware metadata
>> +
>> +By default, this loss of access means that if an ``xdp_frame`` is redirected and
>> +then converted to an ``skb``, its ``skb`` fields for hardware-derived metadata
>> +(like ``skb->hash`` or VLAN info) are not populated from the original
>> +packet. This can impact features like Generic Receive Offload (GRO).  While XDP
>> +programs can manually save custom data (e.g., using ``bpf_xdp_adjust_meta()``),
>> +propagating specific *hardware* RX hints to ``skb`` creation requires using the
>> +kfuncs described below.
>> +
>> +To enable propagating selected hardware RX hints, store BPF kfuncs allow an
>> +XDP program on the initial NIC to read these hints and then explicitly
>> +*store* them. The kfuncs place this metadata in locations associated with
>> +the XDP packet buffer, making it available if an ``skb`` is later built or
>> +the frame is otherwise processed. For instance, RX hash and VLAN tags are
>> +stored within the XDP frame's addressable headroom, while RX timestamps are
>> +typically written to an area corresponding to ``skb_shared_info``.
>> +
>> +**Crucially, the BPF programmer must call these "store" kfuncs to save the
>> +desired hardware hints for propagation.** The system does not do this
>> +automatically. The NIC driver is responsible for ensuring sufficient headroom is
>> +available; kfuncs may return ``-ENOSPC`` if space is inadequate for storing
>> +these hints.
> 
> Why not have a new flag for bpf_redirect that transparently stores all
> available metadata? If you care only about the redirect -> skb case.
> Might give us more wiggle room in the future to make it work with
> traits.

Also q from my side: If I understand the proposal correctly, in order to fully
populate an skb at some point, you have to call all the bpf_xdp_metadata_* kfuncs
to collect the data from the driver descriptors (indirect call), and then yet
again all equivalent bpf_xdp_store_rx_* kfuncs to re-store the data in struct
xdp_rx_meta again. This seems rather costly and once you add more kfuncs with
meta data aren't you better off switching to tc(x) directly so the driver can
do all this natively? :/

Also, have you thought about taking the opportunity to generalize the existing
struct xsk_tx_metadata? It would be nice to actually use the same/similar struct
for RX and TX, similarly as done in struct virtio_net_hdr. Such that we have
XDP_{RX,TX}_METADATA and XDP_{RX,TX}MD_FLAGS_* to describe what meta data we
have and from a developer PoV this will be a nicely consistent API in XDP. Then
you could store at the right location in the meta data region just with
bpf_xdp_metadata_* kfuncs (and/or plain BPF code) and finally set XDP_RX_METADATA
indicator bit.

Thanks,
Daniel

