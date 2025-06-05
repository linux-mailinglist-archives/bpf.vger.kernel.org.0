Return-Path: <bpf+bounces-59728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1648ACF049
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 15:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1574E18867B5
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135F322DFA8;
	Thu,  5 Jun 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGtoOFBn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A181EB5DB;
	Thu,  5 Jun 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129756; cv=none; b=KgGLFjcCuhan5KJKlznq/zmAmDtgor4RjSVHtLz6fdRfTi5d9UU0/M7GDessVtC8ob4ihV97ZAWKF36FAWRBAlDqfo4TMjXK5MYUal4gSIc0sqFDEqe0pjunyR3KDuZ8qZAuI6MHSLsRkIdf5J2jmb9rhkT5C0PCjUIZUuJCucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129756; c=relaxed/simple;
	bh=JvTf3aYuD8WZNyJR7DX5tEiC/DIwqZvjQDVPN2rddeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPoHQHKLQTa+bo8jmEV1Fpwg11h8m+4kjh0/2y8u09H7VHMPVZSHyigWLT87tnGI9W+4EYtE8v4cuMhjzxPeqN+85v2bljVMQzUs87hNyrx6rpsi/NkTvBiFv9VPaomquyRoJk9iuP9xXRo67OIhXsN/x962G1z/lAHDIVdMwF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGtoOFBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4519BC4CEE7;
	Thu,  5 Jun 2025 13:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749129756;
	bh=JvTf3aYuD8WZNyJR7DX5tEiC/DIwqZvjQDVPN2rddeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tGtoOFBnmbZYum0ueMIX6vKyt9x6IZU14TGkwXOkDcp/ejgmJ+XXgLp12L9gtmOV+
	 PJaBuWGZrlwQ5P7/vJ+T6tln/d+fLbbNlhoNIr5gXjeZrCaQj4U3ksD6ngXRoc6+Bl
	 JZCQONM1BVK6sY35SNpvfk1KHJojBy7zfhkPqxgQP9iZddO7PiGJ7+RFg3CkTeoxRE
	 1hHf2qyVlWI2HobVpSkj5ZpqpTZY6tTZYQ2MWaE8ab93QW/w0IHVgLaC08M95ywvLk
	 ++hvGJdA+KWx6hLGfIRPSiPavd7ReozrWNY+75prpqpYq+DLt8va7ehOHhXc5hSzAG
	 d7qTmr2Kjufdg==
Date: Thu, 5 Jun 2025 06:22:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com,
 eddyz87@gmail.com, sdf@fomichev.me, haoluo@google.com, willemb@google.com,
 william.xuanziyang@huawei.com, alan.maguire@oracle.com, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: clear the dst when changing skb protocol
Message-ID: <20250605062234.1df7e74a@kernel.org>
In-Reply-To: <CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com>
References: <20250604210604.257036-1-kuba@kernel.org>
	<CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Jun 2025 23:21:02 +0200 Maciej =C5=BBenczykowski wrote:
> > @@ -3550,10 +3557,10 @@ static int bpf_skb_net_grow(struct sk_buff *skb=
, u32 off, u32 len_diff,
> >                 /* Match skb->protocol to new outer l3 protocol */
> >                 if (skb->protocol =3D=3D htons(ETH_P_IP) &&
> >                     flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
> > -                       skb->protocol =3D htons(ETH_P_IPV6);
> > +                       bpf_skb_change_protocol(skb, ETH_P_IPV6);
> >                 else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
> >                          flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
> > -                       skb->protocol =3D htons(ETH_P_IP);
> > +                       bpf_skb_change_protocol(skb, ETH_P_IP); =20
>=20
> I wonder if this shouldn't drop dst even when doing ipv4->ipv4 or
> ipv6->ipv6 -- it's encapping, presumably old dst is irrelevant...

I keep going back and forth on this. You definitely have a point,=20
but I feel like there are levels to how BPF prog can make the dst
irrelevant:
 - change proto
 - encap
 - adjust room but not set any encap flag
 - overwrite the addrs without calling any helpers
First case we have to cover for safety, last we can't possibly cover.
So the question is whether we should draw the line somewhere in
the middle, or leave this patch as is and if the actual use case arrives
- let BPF call skb_dst_drop() as a kfunc. Right now I'm leaning towards
the latter.

Does that make sense? Does anyone else have an opinion?

