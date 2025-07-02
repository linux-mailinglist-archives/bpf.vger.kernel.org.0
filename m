Return-Path: <bpf+bounces-62120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF54CAF5BDB
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6644D5215EC
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4224A30B998;
	Wed,  2 Jul 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwmzkYlw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA3F30B988;
	Wed,  2 Jul 2025 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468167; cv=none; b=g72RbpJyPyBb4m+DZVV2liQDALRl9CV8+We4kjPAuLzIn7nTH0AaRYsQalFZdoiLb7G7fjqoD81U+lf41siItNLwDP8NlRJKvHheh8isRApHGn95ptf8qD0P0VzcXzTtQBody2SaYeEGNBDKuHSCcAvLYxduD61oCbRLxZ5y6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468167; c=relaxed/simple;
	bh=jPSExSFTuCmZYyW1vpV6frVat4xvr0IfGJRia6zEiEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhkpBVr7N4owY3tH6jIk348F3uix3e83VjpK0ZdozdGtLFpy8x5Wp7PDFr7Q3kUfEJJ6eZeoz5bnj0vvxPqIbcV4Bd9JIeKuqKRPzkCvPa60z5aoismMX69snpnb0K/NyW8S2z5u6a5acD+YduC+JCusY1MBPCIX0/yYeT7TBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwmzkYlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3090DC4CEE7;
	Wed,  2 Jul 2025 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751468167;
	bh=jPSExSFTuCmZYyW1vpV6frVat4xvr0IfGJRia6zEiEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwmzkYlwB9IXoWYiTTPlsJR9akZk93fcjgJg6GoqsidFL3/va22HeolW4AtWm6WBR
	 qDORl0UL2v1tX9sqxupC621a9pK4Po/zcfQTqQ93FeFqHU4lIAO82OY2azKmqOSw6z
	 juJ/kKe+A4Jyr4MHP2RmWZD28BsxqVQZ+8LkLAN4S8sP5+TyuHDl+lj1cwEoeV3J87
	 BQibCF8oi7FhXWzO7FypDa15h26jMsH+ynDLuonuhHj21WNBRSAc3WQRozq20sQCTr
	 IZTy2epyswxYsioCWK9zFS7c4uUgKPWmtHtAR49sUt6LgUHTa8moooBkgVSEkuRE+G
	 jQGOPhmB+QPIQ==
Date: Wed, 2 Jul 2025 07:56:06 -0700
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v12 00/14] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <202507020751.CB3EFC2D@keescook>
References: <20250701005321.942306427@goodmis.org>
 <CAHk-=wijwK_idn0TFvu2NL0vUaQF93xK01_Rru78EMqUHj=b1w@mail.gmail.com>
 <20250630224539.3ccf38b0@gandalf.local.home>
 <202507011547.D291476BE1@keescook>
 <20250701192619.20eb2a58@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701192619.20eb2a58@gandalf.local.home>

On Tue, Jul 01, 2025 at 07:26:19PM -0400, Steven Rostedt wrote:
> On Tue, 1 Jul 2025 15:49:23 -0700 Kees Cook <kees@kernel.org> wrote:
> > Okay, I've read the cover letter and this wiki page, but I am dense: why
> > does the _kernel_ want to do this? Shouldn't it only be userspace that
> > cares about userspace unwinding? I don't use perf, ftrace, and ebpf
> > enough to make this obvious to me, I guess. ;)
> [...]
> Anyway, yeah, it's something that has a ton of interest, as it's the way
> for tools like perf to give nice graphs of where user space bottlenecks
> exist.

Right! Yeah, I know it's very wanted -- I wasn't saying "don't this in
the kernel", but quite literally, "*I* am missing something about why
this is so important." :) And thank you, now I see: the sampling-based
profiling of userspace must happen via the kernel.

-- 
Kees Cook

