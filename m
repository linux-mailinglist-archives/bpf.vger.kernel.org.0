Return-Path: <bpf+bounces-61060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7718AE01B4
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 11:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728223AE0EE
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0CE21C161;
	Thu, 19 Jun 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fKQbPheb"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C281D3085D0;
	Thu, 19 Jun 2025 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325562; cv=none; b=GoTQCZKt4+4eY5/h5h+mvOgfNnUvJf1Yp96c7+tchbP29usYfDuGWXhHibGrglpRbk01pGcd6R6067anSGbtj8DajBBWH0bRgFuoXiKy4rgbCOdoClHa9gAB9m8SQy6pocX4QvZjwKhRWzK3xN+xIi1j24ery43K3/jBfRkHfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325562; c=relaxed/simple;
	bh=4FpPqocwRjspUujRRO+7sBR2qIM50X60Fw+TQSKYuDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQVRpsj1ugon1DAJTPPqv0CIUb1DAaW2j0bgIz9OoKz0jLKFKUOlonQ/cdw2qHjk5329rXDQ3DnToxALAURcoxdGTV/TleO5EjH3hed8eiCFfQV/jzS0q2z1NkhZNSvz/LqzyRZsyemGcxsRlDZ3XYIumA4e0xtnv5DdDpt3QU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fKQbPheb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4FpPqocwRjspUujRRO+7sBR2qIM50X60Fw+TQSKYuDY=; b=fKQbPheb7I3t+v9y0QYYo0pRWk
	i86g/W67a28ba3OEGp1UZf2FjfNq0zAiOliAbyoOz+IIpgBwRONcDBeEaAOFVrlHpOC90k0cWnoVi
	zfzHCKge7jSD9RA/a5I9wzGEwHjVFJYmfQ90TD0jToYaFgzzmNJHnbfZe6j2x54iyPPNzaS7d7L5E
	89DhKK6dpngVdaxx0ZUmpJj1u8L6ZO2Drma6QurkMXLXxZVqpDGmdYX/CPdV57Of1q5DK7RtDTXq6
	hrgj0NFoJF/YxSLqpdy6ZFlT9ywdRgIPGK/wDZ4BEqlyRLJdNU24Uxawmmyi5guXCa3hcBI5J8l7Q
	RhqKZFhA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSBdD-000000083nl-0M94;
	Thu, 19 Jun 2025 09:32:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A23E83088F2; Thu, 19 Jun 2025 11:32:26 +0200 (CEST)
Date: Thu, 19 Jun 2025 11:32:26 +0200
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
Subject: Re: [PATCH v10 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250619093226.GH1613200@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.938845449@goodmis.org>
 <20250619085717.GB1613376@noisy.programming.kicks-ass.net>
 <FCBAD96C-AD1B-4144-91D2-2A48EDA9B6CC@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FCBAD96C-AD1B-4144-91D2-2A48EDA9B6CC@goodmis.org>

On Thu, Jun 19, 2025 at 05:07:10AM -0400, Steven Rostedt wrote:

> Does #DB make in_nmi() true? If that's the case then we do need to handle that.

Yes: #DF, #MC, #BP (int3), #DB and NMI all have in_nmi() true.

Ignoring #DF because that's mostly game over, you can get them all
nested for up to 4 (you're well aware of the normal NMI recursion
crap).

Then there is the SEV #VC stuff, which is also NMI like. So if you're a
CoCo-nut, you can perhaps get it up to 5.

