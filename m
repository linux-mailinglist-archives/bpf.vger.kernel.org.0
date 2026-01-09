Return-Path: <bpf+bounces-78409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2163D0C676
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 23:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35DBD30133FC
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 22:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D3E33EB1D;
	Fri,  9 Jan 2026 22:00:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C409EB640;
	Fri,  9 Jan 2026 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767996041; cv=none; b=U5oeDjeD+7qwnLRyNNwnjw4HDPgIJccuUFigdYxy+SVcNnZikcTNHr41JqzV6rQZRdocxBRGT/vQ/vFVqMY/vs9AIpJuxt552K6CF77soRMl0TePUdQFtRoSjMeSEPAlQYu9cNw4OtVfg8hxcpX5+8X94gKK17ZYQ7yqZHMVDxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767996041; c=relaxed/simple;
	bh=2b//BR2IDYW15K0i4zqJVCCHK8/tQaGKGIDk4oXExNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ev9iVCDDFzvnPlwZ17oMbiEmDKuiMa3ZUIOF+RU4634loUf3i2ZmwzlPOqDl1/5M+LrNKuXuydzhLKiEQRGAB8Z9qwampNtZIRlcUzZfGi5WTs17fs138xWdDsr72kbD9O60nzfqKKm2EPwX15EXBmBGloIt6teyLaPWWeMZMAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 707FE1ADF4F;
	Fri,  9 Jan 2026 22:00:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 2BCB320025;
	Fri,  9 Jan 2026 22:00:30 +0000 (UTC)
Date: Fri, 9 Jan 2026 17:00:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20260109170028.0068a14d@fedora>
In-Reply-To: <CAADnVQLeCLRhx1Oe5DdJCT0e+WWq4L3Rdee1Ky0JNNh3LdozeQ@mail.gmail.com>
References: <20260108220550.2f6638f3@fedora>
	<da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
	<CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
	<20260109141930.6deb2a0a@gandalf.local.home>
	<3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
	<CAADnVQLeCLRhx1Oe5DdJCT0e+WWq4L3Rdee1Ky0JNNh3LdozeQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 2BCB320025
X-Stat-Signature: c8hexy5g764qqjqf97t3puc4p516gqgw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/0vMYx7c3XI/LmL4WF94KqNRRrNen/jBA=
X-HE-Tag: 1767996030-483354
X-HE-Meta: U2FsdGVkX1/xTqlTOKZD+wAifHP85oBj0PSnB+wau6oMw3Wt+2IAZtgcreEIrFpIdaUxQvLz07f0Xg/Hunz94oCKRrlseLp1xgrJSYVgzNuW7BbXCuHMJnuRUe46BB2xOs/6XO5SX7MxdrbsAMwAS8xFPIP/DERn54IfgR52H3wiA6cD+kgOWQKz0UT6VLF8qPG9kkppLLva7ajSS4wGnAbHq/XE8uslIF/mJBCKIMfZhdSj2MlHH/nPK+ErnzqofHO6EeoOF/8a0aCofO/yV1vD993lpn/h3KCHNi8esgQDT81WxvZCrwjQOPu6h01BLrPazzSe3+EG8cBm3eBtZs5rFsAyDfu6wBwES8Z9NiWsKwun9sjW3QDsGYctFfQSqH3QpxA6ibCbiJsIuRps3w==

On Fri, 9 Jan 2026 13:54:34 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Fri, Jan 9, 2026 at 12:21=E2=80=AFPM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> >
> > * preempt disable/enable pair:                                     1.1 =
ns
> > * srcu-fast lock/unlock:                                           1.5 =
ns
> >
> > CONFIG_RCU_REF_SCALE_TEST=3Dy
> > * migrate disable/enable pair:                                     3.0 =
ns =20
>=20
> .. and you're arguing that 3ns vs 1ns difference is so important
> for your out-of-tree tracer that in-tree tracers need to do
> some workarounds?! wtf

This has nothing to do with out of tree tracers. The overhead of the
22ns is for any tracepoint in an in-tree module. That's because the
rq->nr_pinned isn't exported for modules to use.

-- Steve

