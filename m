Return-Path: <bpf+bounces-33226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDEA91A003
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5312C283E18
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 07:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144AF47A74;
	Thu, 27 Jun 2024 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uq+sF3pB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7D9ry0I"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4204C2263A;
	Thu, 27 Jun 2024 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472080; cv=none; b=hovZrbxy2KzGzq8zc6KrT05R09RHBceDntrQ9atNdjVNSY/DiMSj6DK5csNASvGXmv10owG+OxvbY1NWBK1Mqvgx83jdOLJsTobglCNAh82JH+cBxWUxWe9KPRSi4ugwg9LEul4dEI1MgzkEdCXjX9EMoX5+4FSJs+EmfODV1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472080; c=relaxed/simple;
	bh=oH++3i2lIsk8bBpYY8twz2VB+Fk8vfbgsXIXDBlKzfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dH/1xlnNMXZGA31Uw9CjcFPzOYfdHv7uprTZx5JfD0IlOl0ljj8DZpqRP2UrEY28rbFfLWs1R3tqbXpAIayQxyTTfZlv3iDbNqbDxwi5bXOt0i+Ah2uJu0tLFa1Iff441rm7tBiqSYqpADFoh23G9AVXtz4pJPE+PU1na+ORpsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uq+sF3pB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t7D9ry0I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719472077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oH++3i2lIsk8bBpYY8twz2VB+Fk8vfbgsXIXDBlKzfg=;
	b=uq+sF3pBgaoRM1KAEuhWD4ANZOE5EmtumvJPqINFf8wRkCRiAaZWP0lEDg2oOn2KmIuUyt
	hCC8Q0sa9j1u3d28mLw9FJ29xy8B/HNVqIQH1gbTHcK+pX607EYkSEJrXwIQqjwSPhXg9G
	9rEyZIC2RxRNLVjKO7DSjkp7Os2osAN5bVIAnvR8fZkSvexNRW4kOLUvS4CwqTSmLcl91X
	LVKVSs982M/ruJShoNIr5lrg0DKW7kHGytfJ7CtZwlKMD4aNQKkHG/UirSupe2I7AX+2YW
	Cue3AsPNQO4MQP1PQK+xa73ex3hHOOVwJg+bCWPjZ6LOnPJERTdnKgXs/d5aiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719472077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oH++3i2lIsk8bBpYY8twz2VB+Fk8vfbgsXIXDBlKzfg=;
	b=t7D9ry0IQqOqjO2huAHD3lXcIjS9/CtH0DdLPUsPGLNJ5NzxezMm+qe/VHQPcCWJvezEzp
	6r2BVtcamQrwuOBQ==
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Magnus Karlsson
 <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: Re: [PATCH iwl-next v4 0/4] igb: Add support for AF_XDP zero-copy
In-Reply-To: <20230804084051.14194-1-sriram.yagnaraman@est.tech>
References: <20230804084051.14194-1-sriram.yagnaraman@est.tech>
Date: Thu, 27 Jun 2024 09:07:55 +0200
Message-ID: <878qyq9838.fsf@kurt.kurt.home>
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

Hi Sriram,

On Fri Aug 04 2023, Sriram Yagnaraman wrote:
> The first couple of patches adds helper funcctions to prepare for AF_XDP
> zero-copy support which comes in the last couple of patches, one each
> for Rx and TX paths.
>
> As mentioned in v1 patchset [0], I don't have access to an actual IGB
> device to provide correct performance numbers. I have used Intel 82576EB
> emulator in QEMU [1] to test the changes to IGB driver.

I gave this patch series a try on a recent kernel and silicon
(i210). There was one issue in igb_xmit_zc(). But other than that it
worked very nicely.

It seems like it hasn't been merged yet. Do you have any plans for
continuing to work on this?

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmZ9D8sTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgtk1D/9OqvWbBa+S5bnIkUNbd++vKMPUyIcG
AQW5y4scHbgaLQN9WkM4iokP7wNf1ckH5AO9pzCNPOZqrEqxLtALuxoMT2wcRM1K
UL0cOlqRrUaVXAN9gge2bbZuMxJqOt2T+Q8iI1TF/iquhGtFmJU/rrQeLbryIPsS
ZfGn0pAtXwnnLmWXmdLXqieKpoGkXB1T/A6ccOYl3uZ2SatMMsfUMl0AHLH22Bau
DR/EoL8ddUgq/vMTNMIBdtk/4ZbWEueB0gL6lbgFt427nnHf/ZgDPM5VJgDDBECY
iVztnt7WOAUs2NTpFr383aWqBt8JWyRSXi9WN2Rqw7IdU3Y6MoK/3UZDyXMCh41R
uwzC1+UcVWclwjPgcH2hsKF+KZuXVvLHX6GtQQ4ePikoVyRGVB31+JmHaaYOv6Ap
gi/F4aikSQ4PD4QYo+JSzBWJajLUK1dwCIQTCq2n6PqA+qTJmmElPNVom/lJV97v
nqL0sEoenzKtO3urA5IbMYFOUHpxBOnbQ7OTIlo0apEj0aaTMNMFYF1vvvWVYK9S
gdP5u76lIVsQe6ahPLQ5fzh0+ie0vMFejPsRaY9L+yzzzSgxhHsDxsDc5t/QquI+
iVGxH+YL1+9IFNFue3GdxEwPmF6965F/bts+uQiyA+8nw4WU0fghk2clByfh9+Wm
V7t9jdQRHFiZ+w==
=8GNQ
-----END PGP SIGNATURE-----
--=-=-=--

