Return-Path: <bpf+bounces-22496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D831485F650
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 11:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77EC51F27649
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 10:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB96405E6;
	Thu, 22 Feb 2024 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HKLm/d/M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sz3ehyfG"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5C945976;
	Thu, 22 Feb 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599534; cv=none; b=m9drfpLV3iuvHwNlwAGFaCqo1G7UQgppQLPERy/PRNWwKCzVqWW6op3sMXUVQwZU75Prpy06LFzyWJEsZrtHpRXAZSTkrCGWca8UNTPkJQD4qMAl5exBHb3F2xKxjWnZJFAhHNGXQdBh7jkr0vYIHuT1MrPqOaowia2G2Uebhh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599534; c=relaxed/simple;
	bh=Diss7zlBPxC4jTn0gu/kGE8cJpycBkyC63PKOC6t6vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHBrMjMbkFQEf2qcS/QtkQs682x5sTY6iL6wTX8hr+TTHZJEsgoa0N7CwDTYLNd8w6z7/mNe5jKACT6mc/FPVtk3blRmI8Xaiy82Nts6bcVRF45Vvo2gWfAfttwMDU3afsQLmCTceA4NbwhFyAzkTbKBQMHrMsFXD7exVTYF6cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HKLm/d/M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sz3ehyfG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 11:58:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708599523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzKJ0M4bd7vLp9/i2P/cVKIkDRUIoIsDR4fq498vcgA=;
	b=HKLm/d/MjfOth0EWHg8nQcBrqW2D7+n9rFZicTzaHBSobHmj3naHZv7LHa88yH6k0b0C+u
	o2YrrcYtkZXiZw1Towb4onB+uFQOTKig354GH44QpRSVZEOu/EziplswmSLg4RMKz67jAK
	joUObS3nptwVI+wz/Vk96oGc4BrxZGajsgPzeP5Pk5BPfPdlPdnZ48gWKoi6EMiK0cwVTp
	DzXLQJlSOOP1XaW1i6V4dZjpA4vtXCat4r4qU7xADmKkAqJYpnBunFXG/XmviL+FiAGXh/
	wXmQwhPSL+cu4NoS4bhTMKL77nKMtHPELf3Z5k/fIIGEO0d2YxtEkuMSaNGSpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708599523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzKJ0M4bd7vLp9/i2P/cVKIkDRUIoIsDR4fq498vcgA=;
	b=sz3ehyfGOi9r6v3/OHe094X4Oh5G9HEyxWUM/AG4RxGswAgfRHhmz53nWvOMMlT386wpyh
	4t0okMMPZEWP1/Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240222105842.AuHJQwT-@linutronix.de>
References: <20240216165737.oIFG5g-U@linutronix.de>
 <87ttm4b7mh.fsf@toke.dk>
 <04d72b93-a423-4574-a98e-f8915a949415@kernel.org>
 <20240220101741.PZwhANsA@linutronix.de>
 <0b1c8247-ccfb-4228-bd64-53583329aaa7@kernel.org>
 <20240220120821.1Tbz6IeI@linutronix.de>
 <07620deb-2b96-4bcc-a045-480568a27c58@kernel.org>
 <20240220153206.AUZ_zP24@linutronix.de>
 <20240222092228.4ACXUrvU@linutronix.de>
 <f782b460-38fc-4c2b-b886-870760a96ece@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f782b460-38fc-4c2b-b886-870760a96ece@kernel.org>

On 2024-02-22 11:10:44 [+0100], Jesper Dangaard Brouer wrote:
> > Ethtool(eth1    ) stat:     14158562 (     14,158,562) <=3D tx_packets =
/sec
> > Ethtool(eth1    ) stat:     14158685 (     14,158,685) <=3D tx_pkts_nic=
 /sec
> >=20
> > looks like a small improvement=E2=80=A6 It is not your 15 but close. -t=
2 does
> > improve the situation.
>=20
> You cannot reach 15Mpps on 10Gbit/s as wirespeed for 10G is 14.88Mpps.

Oh, my bad.

> Congratulations, I think this 14.15 Mpps is as close to wirespeed as it
> possible on your hardware.
>=20
> BTW what CPU are you using?

"Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz"
The "performance" governor is used, I lowered the number of CPUs and
disabled SMT.

> > There is a warning from DMA mapping code but ;)
>=20
> It is a warning from IOMMU code?
> It usually means there is a real DMA unmap bug (which we should fix).

Not sure, I don't think so:
| ------------[ cut here ]------------
| ehci-pci 0000:00:1a.0: DMA addr 0x0000000105016ce8+8 overflow (mask fffff=
fff, bus limit 0).
| WARNING: CPU: 0 PID: 1029 at kernel/dma/direct.h:105 dma_map_page_attrs+0=
x1e8/0x1f0
| RIP: 0010:dma_map_page_attrs+0x1e8/0x1f0
| Call Trace:
|  <TASK>
|  usb_hcd_map_urb_for_dma+0x1b0/0x4d0
|  usb_hcd_submit_urb+0x342/0x9b0
|  usb_start_wait_urb+0x50/0xc0
|  usb_control_msg+0xc8/0x110
|  get_bMaxPacketSize0+0x5a/0xb0

and USB isn't working. I *think* it is the "memory above 4G" thing, not
sure where it took the wrong turn.

> --Jesper

Sebastian

