Return-Path: <bpf+bounces-54925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0DA75F4D
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 09:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38D518889F8
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 07:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135DCAD23;
	Mon, 31 Mar 2025 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IoulPSNw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i3hrdc5x"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D51B4F0F;
	Mon, 31 Mar 2025 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743405254; cv=none; b=QE4d+3sVhs7lMZEyBq415xk/0gmHgy8Yf4hxkz6bJ6KfFcUeklEkLsi0xoFgMHYd18sRpNA5U4nvUCjpkV7NaY3qwmB6ral1TBDOu1RguG/hzpo46GF1fNxsas871wMcGTvvDx0ztEiD+DAek57T+vHSYzhKcXnIP2tbJxdLBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743405254; c=relaxed/simple;
	bh=14OiOFgKNzhtSB+lwAKQ6sSgA5AUmbgsIVjCgbUdAGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJ3uyb5eVd8TZLL3HWPWmmy54/vUiATRdkm/W0ehbGyW3xiQa7f7MNGmUBU2InAR7ba6LogCN0+CzVS/ruN0SugRw6oEXwdqfUo4cB11J116fZGPoicmGdhu67BjrpBHNwpPQJULZmBdwMDhF5H5vvST8UsdqtIDXSBxkewsuHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IoulPSNw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i3hrdc5x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 31 Mar 2025 09:14:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743405251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14OiOFgKNzhtSB+lwAKQ6sSgA5AUmbgsIVjCgbUdAGA=;
	b=IoulPSNwmBsQwL2ELGgYoXjp0H/WHpcx0uJiFwlNufrtSi1XUGJ6a+/iXaru9QwHVkZi7v
	enN1QAFR8Pt9Khyr16M6tJ+2tT171Hc/5p5gyaiR48XsebGwP4+vr4xMOLZBuNFyqXNArI
	E30XlBmjHI7Fq/f2RiDc+D6phSrIg+IN5tgYBJ14PSCOI1MP7wseYRDBdI55kWxy1EvnyU
	YjSwhJYbz5QSX1z4TWLj26miN8yf9RKYDUyQI+PeoenD6/7aXvm229dx0gmSky9YIPYZn5
	LecigZ9gGKbwczx3ULyiOAQRMSh4sd/66+vBdwC1AVmA1DarQbaiR6I5HNCbAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743405251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14OiOFgKNzhtSB+lwAKQ6sSgA5AUmbgsIVjCgbUdAGA=;
	b=i3hrdc5xD2jgNcGVyGU1sPXbHLt0ylDnXiwHs8y+EobPj45/vndg/svbVW/nSgQ5iWkUjr
	ZOGFJVpUWDfMKvAA==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Michal Hocko <mhocko@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Introduce try_alloc_pages for 6.15
Message-ID: <20250331071409.ycI7q6Q2@linutronix.de>
References: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
 <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com>
 <CAHk-=whVcfPyL3PhmSoQyRQZpYUDaKTFA+MOR9w8HCXDdQX8Uw@mail.gmail.com>
 <CAADnVQKBg0ESvDRvs_cHHrwLrpkar9bAZ9JJRnxUwe4zfGym6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAADnVQKBg0ESvDRvs_cHHrwLrpkar9bAZ9JJRnxUwe4zfGym6w@mail.gmail.com>

On 2025-03-30 14:49:25 [-0700], Alexei Starovoitov wrote:
> On Sun, Mar 30, 2025 at 1:56=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > So maybe "nmisafe_local_lock_t" or something in that vein?
> >
> > Please fix this up, There aren't *that* many users of
> > "localtry_xyzzy", let's get this fixed before there are more of them.
>=20
> Ok. Agree with the reasoning that the name doesn't quite fit.
>=20
> nmisafe_local_lock_t name works for me,
> though nmisafe_local_lock_irqsave() is a bit verbose.
>=20
> Don't have better name suggestions at the moment.
>=20
> Sebastian, Vlastimil,
> what do you prefer ?

nmisafe_local_lock_t sounds okay assuming the "nmisafe" part does not
make it look like it can be used without the trylock part in NMI context.

But yeah, it sounds better than the previous one.

Sebastian

