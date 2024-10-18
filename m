Return-Path: <bpf+bounces-42367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D629A3588
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 08:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A7E1C239EE
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 06:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28534186E20;
	Fri, 18 Oct 2024 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bbQ6uDZG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yeCgp7aW"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177E2BAEF;
	Fri, 18 Oct 2024 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233436; cv=none; b=t4bYBIFpp2Yp0pJk+LD4eOejL+vVk5r+gPN1S4dcFeOFupDjHOvI+ekL+Ag0a00LehRwBpEiOobHthatJpeWm1g1qZIqdlYjtozuUmfPrxrJGaKrr9dl2JzmiRJNyrsWCopVBuyLvcZuWTk7yF4cw+SroRRCl9mAcs1Lwhe2tuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233436; c=relaxed/simple;
	bh=FWPeLueaahRvEyhzQjhwr48MT//oQgzxtAKe6WkfkHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m2KZuYQ3MGKM8hge7QoxfDv04paggVYLZI5PtafEudB+RrdXMVizbvedaRRaGhJnExfPIPV7NBkOj3iq7Ixbr2X+JSK3nL1nureXYtEzjiFGNVsZzMQtRil0QOGh+g9mJuJ0koD0lRikk4EgIQdMqveNiO7zcJA3+Ul6Ak2gLrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bbQ6uDZG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yeCgp7aW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729233432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWPeLueaahRvEyhzQjhwr48MT//oQgzxtAKe6WkfkHk=;
	b=bbQ6uDZGTWMwUjFeF9YcHx5NijazNcGbbtiAvxDzFCc+GE3GZ0Hy1rN001M9uMSboxAMGB
	qwHW8g5dHoiVUATXzHMBI4D+kOYcrPEkjfoOsdmpg2Js/Xmm3QKOqvBSpc4+qcYnTfPuYs
	Uih8LdvXyZnO55NmEXkXwdNVpO2WT3l2J3RnBJwvEZzm17tO/UTtD4t7TzBm60ZybDILnj
	EGCbrLmhj8IoZ5611S1cy/VIMb0QGfqfsYcKvLztEHmBJs1f2T+iFnqDkQbfAOJv8ZXjM9
	7D9Yl2PpdtWjivNeefF1tbc91Gq6UGC22S9OGSekLIDNVa0MfXUbGlT6pEYg+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729233432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWPeLueaahRvEyhzQjhwr48MT//oQgzxtAKe6WkfkHk=;
	b=yeCgp7aWfAiNlczEq8fQypuq5itu8yID1sBI87ZEvY0H3WfT2xc+wdEp0AN8lFj7vUQwcL
	cfTE5VFFP4YZR0Cg==
To: Jacob Keller <jacob.e.keller@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Yue Haibing <yuehaibing@huawei.com>
Cc: Simon Horman <horms@kernel.org>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, vedang.patel@intel.com,
 andre.guedes@intel.com, jithu.joseph@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix passing 0 to ERR_PTR in
 igc_xdp_run_prog()
In-Reply-To: <1779f0d7-de2c-46d9-93ab-f73e6e09b186@intel.com>
References: <20241016105310.3500279-1-yuehaibing@huawei.com>
 <20241016185333.GL2162@kernel.org>
 <8e4ef7f6-1d7d-45dc-b26e-4d9bc37269de@intel.com>
 <f8bcde08-b526-4b2e-8098-88402107c8ee@intel.com>
 <672730fc-2224-d5fe-87d0-7dc9b00bf207@huawei.com> <ZxDvCoAo2puufMiH@boxer>
 <1779f0d7-de2c-46d9-93ab-f73e6e09b186@intel.com>
Date: Fri, 18 Oct 2024 08:37:10 +0200
Message-ID: <87jze5udbd.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Oct 17 2024, Jacob Keller wrote:
> On 10/17/2024 4:03 AM, Maciej Fijalkowski wrote:
>> On Thu, Oct 17, 2024 at 11:55:05AM +0800, Yue Haibing wrote:
>>> On 2024/10/17 7:12, Jacob Keller wrote:
>>>> On 10/16/2024 4:06 PM, Jacob Keller wrote:
>>>>> I don't like this fix, I think we could drop the igc_xdp_run_prog
>>>>> wrapper, call __igc_xdp_run_prog directly and check its return value
>>>>> instead of this method of using an error pointer.
>>>>
>>>> Indeed, this SKB error stuff was added by 26575105d6ed ("igc: Add
>>>> initial XDP support") which claims to be aligning with other Intel dri=
vers.
>>>>
>>>
>>> Thanks for review=EF=BC=8Cmaybe can fix this as commit 12738ac4754e ("i=
40e: Fix sparse errors in i40e_txrx.c")?
>>=20
>> Yes please get rid of this logic. Historically speaking, i40e started th=
is
>> and other drivers followed, but I chose in ice implementation to avoid
>> that :)
>
> Thanks!
>
>>=20
>> Kurt, if you'll be sending next revision for igb xsk support, then avoid
>> the logic we talk about here as well, please.
>>=20
> Yes, please fix this the way i40e did in the mentioned commit above.
> That looks significantly better to me :)

Changed the return type of igb_run_xdp_zc() from skb* to int.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmcSAhYTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgtgyD/9dW1vUgApH8WsLAyCRl96GSA1+yEDs
6IzC2ZwqGGZcqXP5ZMo0WL3ijPBQ4E0MbwRnewFiSjQnxBzNHLTz7GyR9ciZP+2F
5FpPeeTApRDiHtj2/6HattbN2ZMXiHFSop1Snq09yrs73XJVHvPvN8s37oG2psrq
VaG4y7XLCHxHhbt/jSkgQqRJ0xWsCqq2WWWmB4TukxTnUMI2NZFYxpMFJhifPH//
Ntf6aTrHfwy60cys8iyH5uHv3SnzcAUktL97ligXPVmveNZ/mJLV/REZ2m11bhmH
IJrfOjDTrr/NLfdp5mn5YEmm7eqIvhjR8PQptnJhcBmUCfwysxOEskd0BBHm3So5
DK55P0V60+5pGCj/UAacTqtolOTP4FWmjEho3GicbShwoT3VdS8QF31ufLzQP8Gs
bG7VMEU/L5PK4fNRLxbrT0D0NwbPRxSnXAdKMPKfGtyYE7OPk+PmG7ng4xkiSEOv
x9pN8+2EK3880fckzqinNmj7gLqmHgHZY9yVHovCdLhnuHvx6pWqmyEadCPSeA7n
31PDElsdxH+Z7DaWsaBXjvkBQoBuZzwqVC6F9nL85JF2lyzppI3AoIok9uolm8x2
4ZNSGuXibubHCnH3n+VHyjZMYnsuR7rBXEVAHOQimcXcdviljqM9idbeb9h70JWu
hs78hoDAs0+5pQ==
=VBMv
-----END PGP SIGNATURE-----
--=-=-=--

