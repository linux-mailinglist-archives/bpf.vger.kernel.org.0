Return-Path: <bpf+bounces-61679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AE1AEA24C
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 17:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1981894B93
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6092EACFE;
	Thu, 26 Jun 2025 15:12:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49FF2E7179;
	Thu, 26 Jun 2025 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950779; cv=none; b=JyZp+NCQb5eiE0H/Xuz6/9BkuJN080+B73qBSfGFIzhrXweZqkPSWxR3C/BWGu06xDZXNvHrrtMDuj45CFRMGpNFcRPd6/beagK7w+3ssN0bQKIRNv4j9vSp66FBZVe4gYOrC9iU7Mwt1B0OOMqSayDJLb2gl0D875W/UqV6LuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950779; c=relaxed/simple;
	bh=kjP7uV4m2t7heIe5+bDyCCiI6ZdG5nj7J/pYmxeikak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yyk5oskUw03+iPmMdY4cL3wEAd4sxhCEnbKcvaG0g0ucsB0owG8UqWnXu/aotnEBtleS9Uv49MZf0sIw1f/Iz7JT/w0aIIAa+uBnXbk7Ym9bWymU2quUHTGlWv/QjVmlLN1DXLq0D7lP0M9hCzubj8zGZHdaPeJ3UuHl/UlOgHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 1F5E61CFADA;
	Thu, 26 Jun 2025 15:12:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 1798235;
	Thu, 26 Jun 2025 15:12:50 +0000 (UTC)
Date: Thu, 26 Jun 2025 11:13:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v11 13/14] perf/x86: Rename and move get_segment_base()
 and make it global
Message-ID: <20250626111316.5a783695@gandalf.local.home>
In-Reply-To: <20250626130705.GG1613200@noisy.programming.kicks-ass.net>
References: <20250625225600.555017347@goodmis.org>
	<20250625225717.016385736@goodmis.org>
	<20250626130705.GG1613200@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1798235
X-Stat-Signature: edt3eijep336mifp7prug3xos45x95ef
X-Rspamd-Server: rspamout04
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+bn/ih2YZ8YJqiejKRF1XUzEdJygscgZQ=
X-HE-Tag: 1750950770-886151
X-HE-Meta: U2FsdGVkX191LKE7dxzPM0MGzqIrJqCDp3BxRWT/5VP7sCr/B0/MnbgyK/rdULcwuD1pdQj5pc//ZUJKP3oDPc0uAgs/hijvc0TNoajduRATo6j/dAQwEXDvNVuExYNVqEzyWoTnaPbec/WM2COi8IG7WvktPOX8l48fFJjA31iZ4rYHhS1gFKJuL8GYAxiTfY61xv846QoYWgcm6Zuubv4dvPqovT5YtiHuO3C1uWNqDh7vfVUqBHEQlWOiKGSiiAo8yu4lzdVDb/I+1Ap/6ARloOqG5fQ8azxUmXXdkMPi+0jYz23HnhOzmKY52NXHXRTgEu8J46Ei7LTtc0huAGJdEbA1zvLWENSXJR2uTv/avMYbnPGmnrcu8smS8E5L

On Thu, 26 Jun 2025 15:07:05 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> FWIW, I recently found we have a second 'copy' of all this in
> insn_get_seg_base() / get_desc().
> 
> Its all subtly different, but largely the same.

Should I just use that then?

Instead of:

		cs_base = segment_base_address(regs->cs);
		ss_base = segment_base_address(regs->ss);

Use:

		cs_base = insn_get_seg_base(regs, INAT_SEG_REG_CS);
		ss_base = insn_get_seg_base(regs, INAT_SEG_REG_SS);

As it is used in a few places in the x86 code already. Then I could get rid
of this patch.

-- Steve

