Return-Path: <bpf+bounces-32062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75699906A33
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 12:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 104B5B21777
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C33F1411FD;
	Thu, 13 Jun 2024 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ENpHPoxb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CHWdpCl7"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D51411E1;
	Thu, 13 Jun 2024 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275263; cv=none; b=RjKgozY6Zh+wxX5Vj1KLUJhANoTunlcVyHds86BOXjDRG1NHuEXvU2sOJVcM38rY2Hyn0tTWYcVw9Wwgl5GoyhKR1URuNCOYfe5RY/nbV3nhBuystRw8Rqe7/6CPxI8SQwncTm/jmMzuOtske6cGK/H5jlQ1UuUwHHKJdlo4e6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275263; c=relaxed/simple;
	bh=nRxuS8TQSwLi+pwiDue0EWkS34/sJTRfL66Ra+mtZ3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLNHOD5LD/sdiSZNuB1B88gEiivJFNjgfMt9dxXrnlK7YNGavnJhBigbsJ8BTfqf6Cc39dJfyVRuekg7J0GOz+CH3EkylhaMJ6/sgv3FtdxhTyWdudBUj/jjKAbSumH1K3lYlrG2CM8F/UELzcRs5MGBNt/UIWMu9hnBdpJoR3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ENpHPoxb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CHWdpCl7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Jun 2024 12:40:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718275259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRxuS8TQSwLi+pwiDue0EWkS34/sJTRfL66Ra+mtZ3k=;
	b=ENpHPoxbN1UZUqdF3eyDwVK269zlN7y3xFpx450E2yfjFIMdm7PGdHcBDi30rW0kcy5KG2
	CGY8eS9hYvWXmbIsmmuxDh9EgG1/oywuyImuNbChFEMxPXN2CjyR8aBBUsyPOP0DQr7dzS
	5VaFWxwU9BDo1FOnlWw/tP35d+v5iv0CVNYONwQTmkqdTQjybL3v1W6LOwLxGisKaJWq3G
	VpQ3SeIpEDpiGHj4j4UW2lREocdA5cgsde8WknfU9hd0Z7STdnDrSDo03gvRKZmHAya4yO
	zYAxMWMQz+n9TdvSkbo09HWUiOPoecchnnrO06p50vRHzamjqHuNbu5KBwp0IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718275259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRxuS8TQSwLi+pwiDue0EWkS34/sJTRfL66Ra+mtZ3k=;
	b=CHWdpCl7Vii8/hob5dcs4TO62C780cJ0pRWuG04RUnX6JJ0WyuVghr/wgKBZlXupWFefKA
	93+Fz/dNaZHKOFAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, linux-rt-users@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org
Subject: Re: bpf_ringbuf_reserve deadlock on rt kernels
Message-ID: <20240613104058.bwDKdWSV@linutronix.de>
References: <jxkyec5jd54r3cmel4e3pep4ebo3pd4xgedwtb7gj65fntf4s7@om5r3mowjknb>
 <20240612143223.BO0LMFEZ@linutronix.de>
 <mt2yblzo4ezlx4vjfmw3pul3cqgd27oddbaq2coqjkcp342cni@ob4gkaxfz7mg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <mt2yblzo4ezlx4vjfmw3pul3cqgd27oddbaq2coqjkcp342cni@ob4gkaxfz7mg>

On 2024-06-13 12:23:46 [+0200], Dmitry Dolgov wrote:
> > On Wed, Jun 12, 2024 at 04:32:23PM GMT, Sebastian Andrzej Siewior wrote:
> >
> > > The BPF program in question is attached to sched_switch. The issue se=
ems
> > > to be similar to a couple of syzkaller reports [1], [2], although the
> > > latter one is about nested progs, which seems to be not the case here.
> > > Talking about nested progs, applying a similar approach as in [3]
> > > reworked for bpf_ringbuf, elliminates the issue.
> > >
> > > Do I miss anything, is it a known issue? Any ideas how to address tha=
t?
> >
> > I haven't attached bpf program to trace-events so this new to me. But if
> > you BPF attach programs to trace-events then there might be more things
> > that can go wrong=E2=80=A6
>=20
> Things related to RT kernels, or something else?

Related to RT kernel. The trace-event is invoked with disabled
preemption. This means locking is limit to raw_spinlock_t and no memory
allocation are allowed. Otherwise the splat below will appear.

Sebastian

