Return-Path: <bpf+bounces-40171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E748A97E0AB
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 11:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8646E2814F8
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E7719341D;
	Sun, 22 Sep 2024 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pmnhfe6m"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044EC1EB46
	for <bpf@vger.kernel.org>; Sun, 22 Sep 2024 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726996108; cv=none; b=OMiMvwX48eArADaW6FgOkX+8KSkPkjtak3+8W8QDO5qH3NN4Gko+iH8y927ZV0ra7dHsRPL/46z1Mm89oCjOehWlqRF2xzmB2C0z+syKFi4VloxRj12AeUNOhbJtaTIep1BWzAqmy9MZUn7GlEqjzRFYmQRx29cGAiHQfHcBFVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726996108; c=relaxed/simple;
	bh=1HXtPzRt9nLzfCZCLMBt52X//n1f7S7R+U2+wChVizk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p95FNyzj50RpdBnWCR0NipF5qJAy5sfxT3fH8k8t9Yi0ZbM7Qhbyn3R6eacj9sILSKszeiakAv4hY6wdqqDeWhpFjwqsW1Aq0vKY3SKl3lpX4lUYE0jMkJ2Bemfji4o8O+kNgSxPUv9n2JTEFkmNTTQzceC0MJtNfc9eMmh+zU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pmnhfe6m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726996105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1VHLsfNfIqLcFZ23vrbINoBQfbbGCd6neqC+brlrwbA=;
	b=Pmnhfe6mqf9aFVNFmxeqrNyjv7c1Pki43YE7a2aTJvv4tIAYcyP1t8K/TKe5SJRAlPZh02
	t0RcEKIBvPZTNEZywl/RQOtNYL/1IUM2ndwx8ISDz8D+IHXvWtHU+skPq7xXXwZzNprgOa
	PyWPRPq94KfIhqcc7aDrMDw92YSyx6I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-agkCnxrBOEO0V5ylvGEZ6g-1; Sun, 22 Sep 2024 05:08:22 -0400
X-MC-Unique: agkCnxrBOEO0V5ylvGEZ6g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb471a230so26377595e9.3
        for <bpf@vger.kernel.org>; Sun, 22 Sep 2024 02:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726996101; x=1727600901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VHLsfNfIqLcFZ23vrbINoBQfbbGCd6neqC+brlrwbA=;
        b=VsIk/WBNjyimWYL1t8JzYdoioUBPTtrElzsMKqJOfeXnK3dU8RPWqL183PG9EJqhz2
         2LAiiG/0jKHNiNbhivTlVG5PGo3SeUmwuH5aQtTKGs6cvP6m6iqCeaAt1MXDRM6OaJfr
         ddfaFgUn0vhBrfWO+KFygkDNZ7JZiOBoKNx92X+WNAuUT8MCu2DfVPqPpbyTcqkMzv7O
         im+lHrEgHcMG3LFTvypuG99U3O6ED4LcqLGeUE+vWl1qDhrIQHKh64sR+uX/DaFwej4v
         V2r0GdgV4cq45DRxtJbClaA81rDdajV86jbxGsKUeTlzcA9wCiVAj+eAdrpH96ums/Ul
         RFXw==
X-Forwarded-Encrypted: i=1; AJvYcCVpzxJ+dtIcZEydHxRhM0x6TNXU5FOpR4dphtfjAoeJURVeSV/0rig03Qn6H4AT7E2Rbho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLIsma7FAFCtRC6ODRk1WljGYbUlyjoHnFTGWZwfnYlTu25yG8
	par/rR9Kh37IAdyNF0GRBVnCUfBWnnKMpA9cdiLJO8KoawojdeX3g0kOn+jZtG0Im0kldJqSz10
	r+GCSLAJbldWHo9exXGr7/JQj4twtSoIf+4JVIS1RiN73Zl6QzA==
X-Received: by 2002:a05:6000:1375:b0:374:b675:6213 with SMTP id ffacd0b85a97d-37a4235a0d5mr4342830f8f.45.1726996100959;
        Sun, 22 Sep 2024 02:08:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ792wGCd1MWhimTqAIbkaAYTvIoSbeWFq1FnVJvLvLdsklUapLCXxGhVVkH7LlMYgJ6lmNA==
X-Received: by 2002:a05:6000:1375:b0:374:b675:6213 with SMTP id ffacd0b85a97d-37a4235a0d5mr4342805f8f.45.1726996100388;
        Sun, 22 Sep 2024 02:08:20 -0700 (PDT)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80c5sm21507653f8f.39.2024.09.22.02.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 02:08:19 -0700 (PDT)
Date: Sun, 22 Sep 2024 11:08:18 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>,
	bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
	hawk@kernel.org, john.fastabend@gmail.com, edumazet@google.com,
	pabeni@redhat.com, toke@toke.dk, sdf@fomichev.me, tariqt@nvidia.com,
	saeedm@nvidia.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
	mst@redhat.com, jasowang@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
Message-ID: <Zu_eghZAEoYBkThM@lore-desk>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pFkQmBWfCOwm/HFL"
Content-Disposition: inline
In-Reply-To: <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>


--pFkQmBWfCOwm/HFL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Sat, 21 Sep 2024 18:52:56 +0200
>=20
> > This series introduces the xdp_rx_meta struct in the xdp_buff/xdp_frame
>=20
> &xdp_buff is on the stack.
> &xdp_frame consumes headroom.

ack, right.

>=20
> IOW they're size-sensitive and putting metadata directly there might
> play bad; if not now, then later.

I was thinking to use a TLV approach for it (so a variable struct), but then
I decided to implement the simplest solution for the moment since, using TL=
V,
we would need to add parsing logic and waste at least 2B for each meta info
to store the type and length. Moreover, with XDP we have 256B available for
headeroom and for xdp_frame we would use the same cacheline of the current
implementation:

struct xdp_frame {
	void *                     data;                 /*     0     8 */
	u16                        len;                  /*     8     2 */
	u16                        headroom;             /*    10     2 */
	u32                        metasize;             /*    12     4 */
	struct xdp_mem_info        mem;                  /*    16     8 */
	struct net_device *        dev_rx;               /*    24     8 */
	u32                        frame_sz;             /*    32     4 */
	u32                        flags;                /*    36     4 */
	struct xdp_rx_meta         rx_meta;              /*    40    12 */

	/* size: 56, cachelines: 1, members: 9 */
	/* padding: 4 */
	/* last cacheline: 56 bytes */
};

Anyway I do not have a strong opinion about it and I am fine to covert the
current implementation to a TLV one if we agree on it.

>=20
> Our idea (me + Toke) was as follows:
>=20
> - new BPF kfunc to build generic meta. If called, the driver builds a
>   generic meta with hash, csum etc., in the data_meta area.
>   Yes, this also consumes headroom, but only when the corresponding func
>   is called. Introducing new fields like you're doing will consume it
>   unconditionally;

ack, I am currently reusing the kfuncs added by Stanislav but I agree it is
better to add a new one to store the rx hw hints info, I will work on it.

> - when &xdp_frame gets converted to sk_buff, the function checks whether
>   data_meta contains a generic structure filled with hints.
>=20
> We also thought about &skb_shared_info, but it's also size-sensitive as
> it consumes tailroom.

for rx_timestamp we can reuse the field available in the skb_shared_info.

Regards,
Lorenzo

>=20
> > one as a container to store the already supported xdp rx hw hints (rx_h=
ash
> > and rx_vlan, rx_timestamp will be stored in skb_shared_info area) when =
the
> > eBPF program running on the nic performs XDP_REDIRECT. Doing so, we are=
 able
> > to set the skb metadata converting the xdp_buff/xdp_frame to a skb.
>=20
> Thanks,
> Olek
>=20

--pFkQmBWfCOwm/HFL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZu/eggAKCRA6cBh0uS2t
rIdLAP0R/dGPCXgseg1Iy65MrQgRuHzAgV36/bG2Weac6f4WwQEA8KXcwzorG0oU
nZx4Agc2TmA8ZFiQyO3aR9f63sZWrAA=
=hB8l
-----END PGP SIGNATURE-----

--pFkQmBWfCOwm/HFL--


