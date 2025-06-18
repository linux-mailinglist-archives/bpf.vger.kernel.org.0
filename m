Return-Path: <bpf+bounces-60928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C50ADEE4A
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5C53B5F61
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71D12EA174;
	Wed, 18 Jun 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QP6wXJoo"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20666B672;
	Wed, 18 Jun 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254486; cv=none; b=NfB/XDOsJ6CV+nM0b50UiS6Kuz8UVgcpQbCLADP7RoUSQtdhlMclQy/GceEFjTaPbA1ZChF3wSlKvf1K6SpSV740dK7vpehap1YaiwSDrp4uBLBxmpauvvgICjMosPV9P8fnRMtaqcyJtSOHj97hTrTpRL2KOymmRNiEBPSM9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254486; c=relaxed/simple;
	bh=5q52AFiBs+7L3OY6u5IhA1aPUxaOW/jcKnStTG35KcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftfafIHGzutVS1IAUal8Ibt/Dh+Svo0HbkPWjmxXia8ynrJP6dt5hL1FJeYbfQYLOD1gMeXOCV3tbTq58AqqzY3bmv1CaWJK5n9JpSalamSCGK5ewcD/YNTqVa/zxwHoD7skesOYGLNvek1MolfrvfQbkhOSZy23e1F6YQQJIJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QP6wXJoo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5q52AFiBs+7L3OY6u5IhA1aPUxaOW/jcKnStTG35KcU=; b=QP6wXJooBzsjpnNzOcsTC6EwFZ
	fTU8B6o2WWCzQS3FSlKoVTTuArG6mGJ+XNsO/76zoAYBU7dnNAKVw0z92KZkYB48G/4sLWPZ5gL5v
	8MHoCEKrAv6/e+fmscNeMmJp+c8aaO2umR9dhIrJ4NhRnDUxpb+V5XZiDdnr0PoMkmzOOxb7ArBpE
	MFFP7JYczCxQuv4AGF+Sjfup0OZQjnQOSsTHS4Z1axuN154yrK+2AiB3R59ZeLaxpKd9yaXxyR5eP
	2XAHPw+33GfSFFWNETFUDwHEE1phvESZjBCQMc9sKYUZdgpGYh2OcEoO+/D4MqWxNJCcDfIAVEvfW
	HKGnYwGA==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRt8w-00000003i4W-2DNV;
	Wed, 18 Jun 2025 13:47:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1CB6A308010; Wed, 18 Jun 2025 15:47:58 +0200 (CEST)
Date: Wed, 18 Jun 2025 15:47:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 03/14] unwind_user: Add compat mode frame pointer
 support
Message-ID: <20250618134758.GK1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.261095906@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611010428.261095906@goodmis.org>

On Tue, Jun 10, 2025 at 08:54:24PM -0400, Steven Rostedt wrote:

> +#ifndef arch_unwind_user_init
> +static inline void arch_unwind_user_init(struct unwind_user_state *state, struct pt_regs *reg) {}
> +#endif
> +
> +#ifndef arch_unwind_user_next
> +static inline void arch_unwind_user_next(struct unwind_user_state *state) {}
> +#endif

The purpose of these arch hooks is so far mysterious. No comments, no
changelog, no nothing.

