Return-Path: <bpf+bounces-33282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB4891ADD5
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 19:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD9E1C260A6
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3BF19A295;
	Thu, 27 Jun 2024 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qa1f0okN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NdByjKI4"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A4F2557A;
	Thu, 27 Jun 2024 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508727; cv=none; b=ZOkS0Bg21Ggnvx+tKYQpevwRdYhsxC2bE9W1GGxG0e/3hckKl5E95q1K75PhGNv893Ae9O7MAB8IRywmxmKAb3tBz3CRxtJHCdVb29f4DCS3mhsClr0YjwOQogWs7qfZ4aAdRuerglCYhZU+e8bpQDImqS17/37b0Dp5q66Hxok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508727; c=relaxed/simple;
	bh=CHuHLwaEQogzti/Wgim2DX3UCfEUc2e7oTUGZObSet8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gfRHHxRPj8L9lWZFDibJqUuQDed7daBG7ItiuarnKYjQU5RU19ATBxwgtCH85F1MWpbBieJdQmje5cnFEHqk5vzEVpRv9EGboMSUopjSaPcgsEvhT7EHI8mbhhDIditn3htSI2BAJa2JdIGerEqrOUMD70yctQpkCiCkAnBR8v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qa1f0okN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NdByjKI4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719508719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rv4qQ9XUgJyYPZ1ma44+xCJ8R7rfKAASWLHCsJDEwyA=;
	b=Qa1f0okNDUqR/75XscYh3RJut+LNBA0XOJLhajIDH7DbobeXi+XlyCA2AwSMTnZ69WNZdy
	UFOCdrwr3OTpxfobuqSJ4O5WfQMVrRtR0l5CSEbqm/9yMUwOFYmO25YANxXNdCqtEhjbp0
	nZQsY+hq7AnTCgW0lTxhB9HG+SpzoWVEk+dfDRwR0o3R3OqCaHB7rJ1SG0qEhfvFlh+FNq
	dX/A6gUEJE8gOpsEGrPVFd4z1ujTUVeY4ggW4wdIEELiSY8Ncme9gOLn3rNwCm6zyvgdm5
	QIM7CaslzvQzyXFGJmXF+mReJMF+pW7M7jkAHjQWtYg5xAe5fjmRVH9/RB5XoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719508719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rv4qQ9XUgJyYPZ1ma44+xCJ8R7rfKAASWLHCsJDEwyA=;
	b=NdByjKI4CUhqVhdtqRaoP63u1yu9XkgwCAsB4tX285JtCkkR9YhZ3CxfBDDCMzAs2JG2bJ
	TFbh979yoMmQeUDQ==
To: Benjamin Steinke <benjamin.steinke@woks-audio.com>, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>
Cc: intel-wired-lan@osuosl.org, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Jonathan
 Lemon <jonathan.lemon@gmail.com>, John Fastabend
 <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Sriram
 Yagnaraman <sriram.yagnaraman@est.tech>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Jakub
 Kicinski <kuba@kernel.org>, bpf@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, Magnus
 Karlsson <magnus.karlsson@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/4] igb: Add support for
 AF_XDP zero-copy
In-Reply-To: <3253130.2gtjKKCVsX@desktop>
References: <20230804084051.14194-1-sriram.yagnaraman@est.tech>
 <878qyq9838.fsf@kurt.kurt.home> <3253130.2gtjKKCVsX@desktop>
Date: Thu, 27 Jun 2024 19:18:37 +0200
Message-ID: <87cyo2fgnm.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

On Thu Jun 27 2024, Benjamin Steinke wrote:
> On Thursday, 27 June 2024, 09:07:55 CEST, Kurt Kanzenbach wrote:
>> Hi Sriram,
>>=20
>> On Fri Aug 04 2023, Sriram Yagnaraman wrote:
>> > The first couple of patches adds helper funcctions to prepare for AF_X=
DP
>> > zero-copy support which comes in the last couple of patches, one each
>> > for Rx and TX paths.
>> >=20
>> > As mentioned in v1 patchset [0], I don't have access to an actual IGB
>> > device to provide correct performance numbers. I have used Intel 82576=
EB
>> > emulator in QEMU [1] to test the changes to IGB driver.
>>=20
>> I gave this patch series a try on a recent kernel and silicon
>> (i210). There was one issue in igb_xmit_zc(). But other than that it
>> worked very nicely.
>
> Hi Kurt and Sriram,
>
> I recently tried the patches on a 6.1 kernel. On two different devices i2=
10 &=20
> i211 I couldn't see any packets being transmitted on the wire. Perhaps ca=
used=20
> by the issue in igb_xmit_zc() you mentioned, Kurt? Can you share your fin=
dings,=20
> please?

Yeah, that's exactly the issue.

Following igb_xmit_xdp_ring() I've added PAYLEN to the Tx descriptor
instead of setting it to zero:

igb_xmit_zc()
{
        [...]

	/* put descriptor type bits */
	cmd_type =3D E1000_ADVTXD_DTYP_DATA | E1000_ADVTXD_DCMD_DEXT |
		   E1000_ADVTXD_DCMD_IFCS;
	olinfo_status =3D descs[i].len << E1000_ADVTXD_PAYLEN_SHIFT;
=09
	cmd_type |=3D descs[i].len | IGB_TXD_DCMD;
	tx_desc->read.cmd_type_len =3D cpu_to_le32(cmd_type);
	tx_desc->read.olinfo_status =3D cpu_to_le32(olinfo_status);

	[...]
}

Afterwards packets are transmitted on the wire.

>
> RX seemed to work on first sight.
>

Yes, Rx works even with PTP enabled.

>> It seems like it hasn't been merged yet. Do you have any plans for
>> continuing to work on this?
>
> I can offer to do testing and debugging on real hardware if this helps.

Great. Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmZ9nu0THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzglRkEACej+Q8i7Tg/ATprtzVt9sEaP90+gaz
EDQ/JeF3ElM4LYTDmzPseXBgWTcBvtAcLHrpmFls/HnPXPQG7suBhUkGb1hbORiv
d5hbhO0CyEA6RjaGFCprmtsB4gHoRv4saQmywEmxSVw63q55BYGulwVGVQrUfeVW
ddwJnzpOefhrqIldEuzn2GmL+W9y95mKbE/XB4Neo0l89vEARqywsxYiMZ3dkUy6
CNXgBdZdjIEqWukWZiSQugJCNUuYE84G3TeYsKIsv4l+w/l8jgg2Iw1MFG8ajN/a
iyEnAPP+5/8M1jKyYa+1rxbiI6wegarbLnHJiqNitanmXEYMnHdTBhqW2dUDtD8f
qGVt80kvbL1uqvd1T05OoR49v3noNEwSyByymDsGMrn2F5/c8NRQHVAqEyhld04w
0uHil5AaEU4/YPoCLPkvZQuG6X+WjOrogkCyJocLTUzRz5uK9w6KZf6/pZQus4QT
OkgCWTU1yED844AwTAoxmrVFLcnhQU1U4K6zBcQqgytpli9SzrrHMm8jvGBGCidY
H96OKQg9tjcsmFjCFlFNl0Ozg4s1dZzVQv+utYVoJnkyXLyuK+U+h26zK/bu3rer
tlu3jvXMooCrniRxqwCtc+WBYMeQ0tnsOgLOasWBkD+QdgCFJntu9ml577YqxKPY
4lhvb3a3D0fM/g==
=Srqp
-----END PGP SIGNATURE-----
--=-=-=--

