Return-Path: <bpf+bounces-31928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E09905532
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 16:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7711C216F0
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAFA17DE2E;
	Wed, 12 Jun 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+1EDUhD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P9P+tl//"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5857E8;
	Wed, 12 Jun 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202748; cv=none; b=TUtqzBstgjNC0pHYv32EFf8CXezdp0R5x3VsLeYlI085ffVFnFWmbViKK/mnEQVCefYMU9RUcXAFNU7kEv9sZKuDqxtT6B152KzRRfyBY6hVZaEdQstv1NJOp9TBijIUFpOZpbc7+TBq5amJDTXF21JeLfBw5Jb0YFQCBRekFPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202748; c=relaxed/simple;
	bh=IGFPyiNwGq3mhr4vqQwRuRvHq1bQnoFrBvx+tebpgqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLPKn5ttxDVgZPuUXXewZYaMg6R6M02WUU7GJ0Uchc/7WBuCjIzY+gAnrvbOrK79586ZSexyBGkBwB/7KTnM39x/69+SLpxQsk9c1+mcqdlGdOzdYso41Mp6gdUSURRyBgbrtlI/rdMEYYwFaXlHuyB0IxQGFYjSZcBRn526B8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T+1EDUhD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P9P+tl//; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Jun 2024 16:32:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718202745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGFPyiNwGq3mhr4vqQwRuRvHq1bQnoFrBvx+tebpgqs=;
	b=T+1EDUhDquGg0/BJGmX0zYImw5+vc4h3D5N0dKVbekaJiQwX68w6pIO7WfsXx0prqKqw0N
	YoR6O5Jy40gzvkCBTvISyQCHNFZ9MdeGd2NkVw925EwT3u0T0+H/5cXIwVFz2ZTacC8ckK
	U3hv+RBAX1i6Lm/vz/pPXksJdh6i/+/EEHrV7GyN/sUvAvQDUTEUmEispBVZ1KEQULc1VC
	wSgcT5+uCeZBLk8mlYfM8oEYUtiv1Ag9s3AEMJMvFJaSAzoAsNoNHIwsRppx8gHLngrfhr
	5ff0D1PhyrfZGQD+JXaZfjjl4d5h6+I5kFiPP0R2p2zKfl1yk7jB3wM9jF/Feg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718202745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGFPyiNwGq3mhr4vqQwRuRvHq1bQnoFrBvx+tebpgqs=;
	b=P9P+tl//YHYJB1idyKOCW2ZOGoIMfh6LPhm18Tketlfsy9xoPLhlsm9MG2w3KbFJAo1o9E
	xloo/+u0KJoC7bBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, linux-rt-users@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org
Subject: Re: bpf_ringbuf_reserve deadlock on rt kernels
Message-ID: <20240612143223.BO0LMFEZ@linutronix.de>
References: <jxkyec5jd54r3cmel4e3pep4ebo3pd4xgedwtb7gj65fntf4s7@om5r3mowjknb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <jxkyec5jd54r3cmel4e3pep4ebo3pd4xgedwtb7gj65fntf4s7@om5r3mowjknb>

On 2024-06-10 17:17:35 [+0200], Dmitry Dolgov wrote:
> Hi,
Hi,

=E2=80=A6
> The BPF program in question is attached to sched_switch. The issue seems
> to be similar to a couple of syzkaller reports [1], [2], although the
> latter one is about nested progs, which seems to be not the case here.
> Talking about nested progs, applying a similar approach as in [3]
> reworked for bpf_ringbuf, elliminates the issue.
>=20
> Do I miss anything, is it a known issue? Any ideas how to address that?

I haven't attached bpf program to trace-events so this new to me. But if
you BPF attach programs to trace-events then there might be more things
that can go wrong=E2=80=A6
Let me add this to the bpf-list-to-look-at.
Do you get more splats with CONFIG_DEBUG_ATOMIC_SLEEP=3Dy?

Sebastian

