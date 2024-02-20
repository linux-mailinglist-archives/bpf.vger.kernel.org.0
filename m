Return-Path: <bpf+bounces-22311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A445C85B8D4
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 11:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD60283E22
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 10:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AE6612DC;
	Tue, 20 Feb 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GYy/jaWq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lTiFMWWX"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4D612D3;
	Tue, 20 Feb 2024 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424266; cv=none; b=ZCGYXam07bHJVOD17L0ZjCm9CyWpeiyQvFRe4su5m7d28DtflFvi1JZTH9reImVJ69o3ua/6XXGMmJmmceR0LqmdCi3vaapG0zIA1IgO6NiR53pddnwz/5PbRNoTQw7ifr9ACfqzOl1jTTY79fmeAWFs158YPf7YNswTYnAN9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424266; c=relaxed/simple;
	bh=aifVOZHUn4ejHKv9dJW1chxcb0eXKyDyyjE3Vt09lx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOd9lmZJPh04WdxEeD7EKtDnkqtJxhhoryr39WpsunWdq2An0hOln/FVCwU/sRw5tbLlrryHdfaz3JFVXY19xJy2reHOXzy7MXmN7dAeyRoz6l7Dnz5kywTynt0xW7SxnpmDypfBscPDd1wn2LdivuoXn/96J9nM58eWw2SsNpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GYy/jaWq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lTiFMWWX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 11:17:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708424262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYHUGjIHbZMRfwCj8LUS9e4pU93xVsPLVMybAEahurE=;
	b=GYy/jaWqnJOiGNl3TM19wnPTL9iVjomun+FXHD5Gduz9UMSdwD3LZqUkCgdhRtYNVsT9Yc
	WRK1nuWDRXFnSAUIs7MtJkZtUtFe0QRRY8gtUSsRG+b1TW6HzzL1gOcwC1BSZiLmQQxP8r
	jL4nj8z8VHet6yoIf7h31DM8VRpsVT1ZW9YvS3RqoO2XYHOJFZORoQ335casVmU1KGIdDc
	gRsEekBCcaQH++X1nE5WYbT4wJp+x0uYRhKsPy/qJ69f6wTt4KqvCOqXzyJUNa2/QvzRwg
	W3S1wKbIw1c5raNquOfwOxtyXDfHAXM3dhuT6uSD869NnQ/09l/UPHiBi9XDCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708424262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYHUGjIHbZMRfwCj8LUS9e4pU93xVsPLVMybAEahurE=;
	b=lTiFMWWXju58R+UIZ8UU0dAoCvJy4RKKx85mzIc3USLo6CMG6SL1nC2XidYRLJ7CW56dwc
	wr3hKXINwyNMYADA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240220101741.PZwhANsA@linutronix.de>
References: <66d9ee60-fbe3-4444-b98d-887845d4c187@kernel.org>
 <20240214121921.VJJ2bCBE@linutronix.de>
 <87y1bndvsx.fsf@toke.dk>
 <20240214142827.3vV2WhIA@linutronix.de>
 <87le7ndo4z.fsf@toke.dk>
 <20240214163607.RjjT5bO_@linutronix.de>
 <87jzn5cw90.fsf@toke.dk>
 <20240216165737.oIFG5g-U@linutronix.de>
 <87ttm4b7mh.fsf@toke.dk>
 <04d72b93-a423-4574-a98e-f8915a949415@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <04d72b93-a423-4574-a98e-f8915a949415@kernel.org>

On 2024-02-20 10:17:53 [+0100], Jesper Dangaard Brouer wrote:
>=20
>=20
> On 19/02/2024 20.01, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > may be simpler to use pktgen, and at 10G rates that shouldn't become a
> > bottleneck either. The pktgen_sample03_burst_single_flow.sh script in
> > samples/pktgen in the kernel source tree is fine for this usage.
>=20
> Example of running script:
>  ./pktgen_sample03_burst_single_flow.sh -vi mlx5p1 -d 198.18.1.1 -m
> ec:0d:9a:db:11:c4 -t 12
>=20
> Notice the last parameter, which is number threads to start.
> If you have a ixgbe NIC driver, then I recommend -t 2 even if you have mo=
re
> CPUs.

I get=20
| Summary                 8,435,690 rx/s                  0 err/s
| Summary                 8,436,294 rx/s                  0 err/s

with "-t 8 -b 64". I started with 2 and then increased until rx/s was
falling again. I have ixgbe on the sending side and i40e on the
receiving side. I tried to receive on ixgbe but this ended with -ENOMEM
| # xdp-bench drop eth1
| Failed to attach XDP program: Cannot allocate memory

This is v6.8-rc5 on both sides. Let me see where this is coming from=E2=80=
=A6

> --Jesper

Sebastian

