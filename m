Return-Path: <bpf+bounces-70567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A55FBC31B1
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 03:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A53F3B4272
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 01:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8604B28C854;
	Wed,  8 Oct 2025 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkAKs9Y/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051F81DE4FB;
	Wed,  8 Oct 2025 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759885915; cv=none; b=VptSMwZx8CR211QmUeEnabaRn0ghSZPGpLM0Zpe1lXJ6XoMWG+Z2f6l9vzuyPnFfHyL9p1v3Rdy1JN1sb3DwC84Dogn5gcZRoFzeDqBhQrTWeGrhWX2oeiEHP/QosPxaoNEsKpzev8upai+veFUP2jFWq+MRPxt9UaQxX/AoTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759885915; c=relaxed/simple;
	bh=m5VsaHctQ/GyRCS6vrWoDePHx3Vguv0XSO4HpON4Mxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4L+2g7C8ALuK1sCFtCns12EM1u1EtRniCHnl7Rake/mELhjBFpcP6tkF9BPY+bhdg6YBKsW4WsIYrSwgdhF3NaRhGNWpfEkPh3mK26vAPbO9NeCvKPtVUW9H7h8ZYiG1VbH/XnloKmdA6ODJFVWniOYpmtFWqADENt5TSF8Cvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkAKs9Y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7090C4CEF1;
	Wed,  8 Oct 2025 01:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759885914;
	bh=m5VsaHctQ/GyRCS6vrWoDePHx3Vguv0XSO4HpON4Mxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AkAKs9Y/PatvjXTbIvCp2+2VwTh7NCd2KIQaXTw+pp3Yqz/9m3V+TDgIxSlG9CsUX
	 nkfude7F9Kde4u59WqJvsbt2s97XlPiJOQo+WXzeadSilN9ekM6GrGjOSrxwYtZ9MD
	 gW4KQ1prUaN32XD979FCR/xKUlCoULs8N3wfcyP6U7fnt7NIdtczfCkyZcaXcgolBW
	 kQheic075WObPE9Kt1qlP21VFDSipoOX16+N0xC/8O2w43yKOWDLMAyAqr3i9N5teD
	 4avM9mZoQhs/+L8HkdOIwnFn0I/S2R+dvnAqb9n/m4lIv7SF4Q6soe3JP1T+ZvBh5C
	 1iUfd5cZHyk6A==
Date: Tue, 7 Oct 2025 18:11:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <toke@redhat.com>,
 <lorenzo@kernel.org>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <andrii@kernel.org>, <stfomichev@gmail.com>,
 <aleksander.lobakin@intel.com>
Subject: Re: [PATCH bpf 2/2] veth: update mem type in xdp_buff
Message-ID: <20251007181153.5bfa78f8@kernel.org>
In-Reply-To: <aOUqyXZvmxjhJnEe@boxer>
References: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
	<20251003140243.2534865-3-maciej.fijalkowski@intel.com>
	<20251003161026.5190fcd2@kernel.org>
	<aOUqyXZvmxjhJnEe@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Oct 2025 16:59:21 +0200 Maciej Fijalkowski wrote:
> > My thinking was that we should try to bake the rxq into "conversion"
> > APIs, draft diff below, very much unfinished and I'm probably missing
> > some cases but hopefully gets the point across: =20
>=20
> That is not related IMHO. The bugs being fixed have existing rxqs. It's
> just the mem type that needs to be correctly set per packet.
>=20
> Plus we do *not* convert frame to buff here which was your initial (on
> point) comment WRT onstack rxqs. Traffic comes as skbs from peer's
> ndo_start_xmit(). What you're referring to is when source is xdp_frame (in
> veth case this is when ndo_xdp_xmit or XDP_TX is used).

I guess we're slipping into a philosophical discussion but I'd say=20
that the problem is that rxq stores part of what is de facto xdp buff
state. It is evacuated into the xdp frame when frame is constructed,
as packet is detached from driver context. We need to reconstitute it
when we convert frame (skb, or anything else) back info an xdp buff.

xdp_convert_buff_to_frame() and xdp_convert_frame_to_buff() should be
a mirror image of each other, to put it more concisely.

> However the problem pointed out by AI (!) is something we should fix as
> for XDP_{TX,REDIRECT} xdp_rxq_info is overwritten and mem type update is
> lost.

> > +/* Initialize an xdp_buff from an skb.
> > + *
> > + * Note: if skb has frags skb_cow_data_for_xdp() must be called first,
> > + * or caller must otherwise guarantee that the frags come from a page =
pool
> > + */
> > +static inline
> > +void xdp_convert_skb_to_buff(const struct xdp_frame *frame,
> > +			     struct xdp_buff *xdp, struct xdp_rxq_info *rxq) =20
>=20
> I would expect to get skb as an input here

Jo=C5=82. Don't nit pick my draft diff :D It's not meant as a working patch.

