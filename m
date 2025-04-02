Return-Path: <bpf+bounces-55137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9455FA78CB6
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD553AF09F
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B20A236424;
	Wed,  2 Apr 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ro4ClCPs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NDi8v/wH"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1BC2E3394
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743591470; cv=none; b=n23KpPzo+5qL6InFRTz/zMy+U+aLcUKyTT+Uogr7hK728qZg2S/wqaHPGI8XQUFW6cMLvP7oM8FSjWvISZwq8dIVw1pfCuzWJx6eyMjXLj0oJoenUbmSzUmuJrEU85pin2izFLm131SC8lM8XS7JxUB53BUqJ0N3MlIHl4zcx3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743591470; c=relaxed/simple;
	bh=H7+8whQYU/yA5QmipvNfRQHKtZ/ybUB9LSEqIEUF2M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5z7ef4JZGE9imVdrOBJ4OdlPmG7BEjv/PbkJXqEYUupiC/jKYUo6AQWSKCaKSD5DX6IilWTMy0fDVA0HSfwuxkKAz5ibCwOqGReh2QiBYkEOCH7ZskhRH/mleI13e9lu9rAFpSelv7ggGNuNkcO+PX4kaNgajBcHn9DBA8on6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ro4ClCPs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NDi8v/wH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Apr 2025 12:57:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743591467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7HxBGrYHQcdzDgbRNqap49eUFQi4id8h0yaacfJA08=;
	b=ro4ClCPss0dpFBaj78UT2Z+uAJfETS+WZLT7P1Tp1WytlQJ0mdv0f07klSyNdtoTKZapRI
	wZ5HBE2vSx4xYcmOVXN4vZ3f98DcAg9OpwJ4jUNWwoajNC18mje0/yyfUKY+Ya9608bhIo
	xphiE8Cb09wP9p6g1pRW8OlcEnmCap/HE+1GfJES4AWh/8h2eGHpp6f/8EfS6mVWbOGyyy
	o4v9iKqXt5QhZ+40H6WW93N1xNgJINFhQ4Lk7NZAZdJ5p76tiJVTX2AdNwF7KobhPqSXfA
	VtGhkEMKFVaO6tmP7xywszpDOfwcHqyp5SdGzviEBh7Mi34FfajUlyAS2LqlUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743591467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7HxBGrYHQcdzDgbRNqap49eUFQi4id8h0yaacfJA08=;
	b=NDi8v/wH2kUyTkOKFp1slUpdnG0KHA0kj6+Gl0lDSKj/GfFXRUnjsZ3gNwNgjY9Fjw2k3t
	oRGbrSHd/tyw6HBw==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Ziljstra <peterz@infradead.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250402105746.FMPvRBwL@linutronix.de>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250401172225.06b01b22@gandalf.local.home>
 <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
 <20250402103326.GD22091@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250402103326.GD22091@redhat.com>

On 2025-04-02 12:33:55 [+0200], Oleg Nesterov wrote:
>=20
> I still didn't read this code, but after the quick glance I don't
> understand why do we actually need utask->ri_seqcount.

Same here but on it=E2=80=A6

> The "writer" ri_timer() can't race with itself, right?

On PREEMPT_RT the timer could be preempted by a task with higher
priority and invoke hprobe_expire() somewhere else.

> The "reader" free_ret_instance() uses raw_seqcount_try_begin() without
> the "retry" logic.
>=20
> I have no idea if this logic is correct or not, but it seems that (apart
> from the necessary barriers) we could use the utask->ri_timer_is_running
> boolean instead with the same effect? Set/cleared in ri_timer(), checked
> in free_ret_instance().
>=20
> I must have missed something...

Let me try to study this  before I can make a statement=E2=80=A6

> Oleg.

Sebastian

