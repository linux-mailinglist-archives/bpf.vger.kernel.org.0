Return-Path: <bpf+bounces-60697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8ADADA838
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 08:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89EBA7A4ACC
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 06:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0351DF26E;
	Mon, 16 Jun 2025 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QXm5+uxr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0cTukvmU"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594E1DE2BD;
	Mon, 16 Jun 2025 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750055345; cv=none; b=LqgU6hFqzV+CMWds9p4ZQrV56V1kE8xgv4tNcZytbC0NmTaA1J5aVeYXrXvp6a1rBmiJlykPR11z235KILhoSsd68SO+QBFP20rJojVxstQKZmPYCgU3QLDq5nDkcgqt5jUWRpbPvVDYNvHiiO/VxhMkvFkbPFEyCebY2kL6Y/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750055345; c=relaxed/simple;
	bh=9JJEZwJcy718D1DrMK8Hs+ZKn8NzsTjuogMc/xnMV6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuarvnaHEObucf1xLZ+CMJglbn3Xhq20U0c0NV+R4BZyFewGZm43tW0d2hErq0J9BtM+WjZCbS/3HC5n9sEKIoLlYLJtMosHFiZkFyz/sRDpqL+8IjVa0rKnKnRprJtJDRNRrAEPNJAFgKM/lyAPmT816urr32QvEvP0UXCr6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QXm5+uxr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0cTukvmU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 16 Jun 2025 08:28:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750055335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LICzzU5v3SFqwCiAXYPpdpUgYqySOSePsKj/xJRbx4=;
	b=QXm5+uxrJxDXN6WaP4aDXprPGZDiQmKTUXTpwed9hi+VP7xu8ZzQs1J7nmeTwua3lso/J1
	kPN9kBLJREooVryRBDPOgiSssvgNcENdcdySSAb3oI+jKzpo1tMtUbBYYzXDwD4j3ro2+d
	/XT3mrWzRh2oSGRcvGnxN8wqJZAPXVYIXOP6LjRlrAwminD+to6chtUP0q7QUHBFqhzIih
	yWpeRQQnl1k5sJvJIgClncO/plKBTXVOrxLJLRoQPXYVxrQ3OTGmfTMlZAR16RJvrC063y
	5sYzD8yTDxhcm+ueiBdzR4SphqHUj7n/u7GLAVFGbdrasVpIS3amxua7J4t/ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750055335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LICzzU5v3SFqwCiAXYPpdpUgYqySOSePsKj/xJRbx4=;
	b=0cTukvmUiSNPCOcrLgwcOuURn2EirANnSFbj9MA2OrOylAaL0PRh2ro8v1A0szyqq8xSST
	X+gLHtnggF3lBrBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	bpf@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
Message-ID: <20250616062853.G6JxYeK1@linutronix.de>
References: <20250605091904.5853-1-spasswolf@web.de>
 <20250605084816.3e5d1af1@gandalf.local.home>
 <20250605125133.RSTingmi@linutronix.de>
 <0b1f48ba715a16c4d4874ae65bc01914de4d5a90.camel@web.de>
 <727212f9d3c324787ddd9ede9e2d800a02b629b2.camel@web.de>
 <0c0b2385452292d6b1df3066b7223b420066f0a1.camel@web.de>
 <aa28ef09763eeefd54d4c26fb01599fd5197b265.camel@web.de>
 <7937d287a3ff24ce7c7e3eb2cd18788521975511.camel@web.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7937d287a3ff24ce7c7e3eb2cd18788521975511.camel@web.de>

On 2025-06-16 00:12:49 [+0200], Bert Karwatzki wrote:
> These three patches fixes all the dmesg warning (with CONFIG_LOCKDEP) iss=
ues when running the
> bpf test_progs and does not cause deadlocks without CONFIG_LOCKDEP.
>=20
=E2=80=A6
> is fixed by this:
>=20
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 183fa2aa2935..49257cb90209 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -58,9 +58,9 @@ static notrace void \
>  __bpf_trace_##call(void *__data, proto) \
>  { \
>  might_fault(); \
> - preempt_disable_notrace(); \
> + migrate_disable(); \
>  CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));=
 \
> - preempt_enable_notrace(); \
> + migrate_enable(); \
>  }

I doubt this can be fixed that way. I sent a series out
	https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/

which is the first the step towards fixing this properly.

Sebastian

