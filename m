Return-Path: <bpf+bounces-57718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740FDAAEFE1
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 02:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5EC4A7CFB
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 00:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13B66F2F2;
	Thu,  8 May 2025 00:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLY0meii"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5EB28691;
	Thu,  8 May 2025 00:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663513; cv=none; b=UcN5/YkC71VBC2g1NQWVKlDckOwVpiVSs5cVzoscHW63cesdBr79yH1WlVPFC0YS2evZkvKjauzm08kuW/7nZcmLZ2V6FQXGxorlWYewBtaEMbrVXKe1lxEaGOYnp99A6AL3qHcPoJe/EhuSRQdSzSOG/x1xhA92Wf0AGK3icOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663513; c=relaxed/simple;
	bh=o/r3Crhq07EKv5wPTB5TLDFeP5lJ10MUGwPxhG8uu0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPHNGFUNhwFEaJZcSdI3r+VBdQ418E3DEXW9pwW3H0H7fQIahZoY0GBghTkAz/rt6JoNRPEU7OjeBmlkijBaENP9lUMdF7aDB8nS63fVy9k5x4RV7ksX5hBSIojrKTE6z+lYzN3WAF9zSS7puHpojqMp2byPlsLsQbjHJDzSN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLY0meii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAC1C4CEE2;
	Thu,  8 May 2025 00:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746663511;
	bh=o/r3Crhq07EKv5wPTB5TLDFeP5lJ10MUGwPxhG8uu0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kLY0meiiGNAwrS6pokJqsAWF/7XG5lR/2y7UJ9VoYtmEzeh97Lio4vCRAPKQIsAU7
	 trjhAIylZDGWHSl/Y9Cd14E+khHoHasDU2rDE6dCjJcrVM/XuPa7BdWfl+aiCBeRbE
	 h3kXpG7FBMf4+BSEog6WyocZv+HtNV03PfQC2ashh90tfh7VoH/97NtyctwHlSNIJx
	 tEAiFpx205sUMpHZ4r852ku4NF5s+LJY23w28C6CqlaE7gdQgazvTN8TQCyrm2FwLA
	 zsOXSxICoikHuzeF+BSEARBDNj+JaP2zX3ohVr1G73OVZRD2RHVpfU+5qpSHzYnbDm
	 NOSM5XSVF3ggA==
Date: Wed, 7 May 2025 17:18:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Jon Kohler <jon@nutanix.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Zvi Effron <zeffron@riotgames.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
Message-ID: <20250507171829.3e8f8a76@kernel.org>
In-Reply-To: <b99b73e8-0957-45f8-bd54-6c50640706df@kernel.org>
References: <20250506125242.2685182-1-jon@nutanix.com>
	<aBpKLNPct95KdADM@mini-arch>
	<681b603ac8473_1e4406294a6@willemb.c.googlers.com.notmuch>
	<c8ad3f65-f70e-4c6e-9231-0ae709e87bfe@kernel.org>
	<CAC1LvL3nE14cbQx7Me6oWS88EdpGP4Gx2A0Um4g-Vuxk4m_7Rw@mail.gmail.com>
	<062e886f-7c83-4d46-97f1-ebbce3ca8212@kernel.org>
	<681b96abe7ae4_1f6aad294c9@willemb.c.googlers.com.notmuch>
	<B4F050C6-610F-4D04-88D7-7EF581DA7DF1@nutanix.com>
	<e4cf6912-74fb-441f-ad05-82ea99d81020@kernel.org>
	<6FF98F38-2AE5-4000-8827-81369C3FB429@nutanix.com>
	<b99b73e8-0957-45f8-bd54-6c50640706df@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 May 2025 22:58:33 +0200 Jesper Dangaard Brouer wrote:
> > There is a neat hint from Lorenzo=E2=80=99s change in bpf.h for bpf_xdp=
_get_buff_len()
> > that talks about both linear and paged length. Also, xdp_buff_flags=E2=
=80=99s
> > XDP_FLAGS_HAS_FRAGS says non-linear xdp buff.
> >=20
> > Taking those hints, what about:
> > xdp_linear_len() =3D=3D xdp->data_end - xdp->data
> > xdp_paged_len() =3D=3D sinfo->xdp_frags_size
> > xdp_get_buff_len() =3D=3D xdp_linear_len() + xdp_paged_len()
>=20
> I like xdp_linear_len() as it is descriptive/clear.

FWIW I don't feel strongly but my very weak preference would be=20
not to merge this. I already know I'll be looking at the definitions
every time. Is it obvious to everyone in this thread whether "headroom"
includes the metadata length? It's not obvious to me. But the patch
seems quite popular so =F0=9F=A4=B7=EF=B8=8F

