Return-Path: <bpf+bounces-76743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B154ECC4E28
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 996A830813DC
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F88345CC2;
	Tue, 16 Dec 2025 18:05:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A66345CAE;
	Tue, 16 Dec 2025 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908328; cv=none; b=mQQ0UwbCWr8ovAzqg0X4NJqvS4LQlWudl++KpqPdruJCwWFLM88h133SxT0BASgU/Zp6C64ITzEkm7BpIbriZGbymD4rFzyDLPK1AmGkGLWecoPKPdv5GEcDVve17S71vWaQ4wBVaLsg6DIyBHrIcNykxdBlJcdXvHQ6fZIwO40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908328; c=relaxed/simple;
	bh=njOfu2PidBDyap2da0caS8gKEBLi288gNp03OgsXYgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgDI81Vnnw0+MLSdjYZ6WylWQlLwACHXkmI0eeBnM6ksHcm6hlYU4CYjaIiTWuuH4yVrTVZpfCmPUYQpasedJdciOAFlL6X/hAXBbmC0W9ln2Su/QYkRk56cdd8N3RSR6miveV4mUQ5ztNtXGvT0FezhK+mWkCys/9RKIJUowWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id BAC7C12E30;
	Tue, 16 Dec 2025 18:05:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id C7A622000E;
	Tue, 16 Dec 2025 18:05:22 +0000 (UTC)
Date: Tue, 16 Dec 2025 13:06:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20251216130656.13322c0d@gandalf.local.home>
In-Reply-To: <20251216120819.3499e00e@gandalf.local.home>
References: <20251216120819.3499e00e@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: C7A622000E
X-Stat-Signature: kzqoo3sr7afo697hmkc1kyaoijodridd
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+YrXJPSKn6J3eWgQy2JE9VFItmaMB801I=
X-HE-Tag: 1765908322-339602
X-HE-Meta: U2FsdGVkX1+WTbHUt48timsVepSYWGd0zbl1hQlJvLgleKa5IihU8h7apmcrud316jQYSDxLZjiJI47gYYdEMSJ67h0v9Rm6ibg+b3tUElAION4e60D/Kxh+xydVbnLJ10a7frJPyfSEDwk+TS0raj0O6GyHc7q9AUhK6v7RC9OMYsTnHEwEi+LD6KNjQTB2Dc7WnS53JSB3cZOPyu4NMO5viAFyhq8eiN2nSMB8PoViX8Z4oIbdU00bz3/1QOFQlLDr8dSheOxtrn1V5Iu4+S+qBOuDKXIuMggyWaWBCZZShiVhBIBafLWmd11KL8tW


Ignore this one, I sent it out before updating the subject to say "v4" :-p

-- Steve

