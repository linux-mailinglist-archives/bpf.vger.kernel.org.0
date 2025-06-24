Return-Path: <bpf+bounces-61382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF0CAE6A1E
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 17:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E88167589
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDAB2D29D7;
	Tue, 24 Jun 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VWLkT13X"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D72C1590;
	Tue, 24 Jun 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777237; cv=none; b=INQL5cmCHufmafUMPF/DkQG1saV77AxOLlPb0yR1DM1LQJmlcDdjbYtA1e+UtCMNIMsWi13BrVg4tfymqZfWazvsi/m26xK8HuPsQuNhZ3zAyMRiPGCFmf0NDrXGoreNgC2UvEK8jU8TiCTcxPoOw/EMe3IJvUiBNTZceqJEZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777237; c=relaxed/simple;
	bh=R3yjv+0wYnNEtTMO8SBzprJW3ICc+hObnUMrM7Ptmno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bbx9UEa/1t5gAt84vjw7EuA8EbM2O11I8pNfnCVlwBv9ZKMnSuvYJ0h6ZeDKgzDMPv4Z7Q8HE10u1/Tw35WnpNCBR0pSPg91MeG0JVPZNVWyA8e/zrkG7WVG/cI39ci4ewFSNkZBggxHmRGwhPCR1sLvVBjPjN/0d6vS7NzZ03U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VWLkT13X; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g1WgOkP4gt8nwCNgZux4aVi+SEORxoTzX5CyUlmMViY=; b=VWLkT13X1HdqxVW29bEotP0ulm
	4fkJFH4xdWXFRhNA48yW2YmXv+6qa6ZKaidJqdmQVDlezYzKwmH3IRKOASiTP7D9I5FfxPyJeISVE
	50bENnTUFIDG9ygePqiY3d3fduJg6jqQObsWFoN1I1RO97n4LJAlfmgcJnYu1PJg4y54bxL9NScjN
	WoU8rlAHJwOlClSvK21NAxSLByvUZK4wccCs2+cj8EEV2HSDc/vLknrzOCQgTYve99LMIYq6YwcrF
	VnCEOlSwmj9E8HTLW46N8dGh4Wnnt44q4OXuZUyS1KI8VcW6kW0WmvQum0sjRY0bsHR7SxWxBIuRi
	5sVQuSKQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU58I-00000005TTn-1wOF;
	Tue, 24 Jun 2025 15:00:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0C4C7307E51; Tue, 24 Jun 2025 17:00:21 +0200 (CEST)
Date: Tue, 24 Jun 2025 17:00:21 +0200
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
Subject: Re: [PATCH v10 08/14] unwind deferred: Use bitmask to determine
 which callbacks to call
Message-ID: <20250624150021.GX1613200@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010429.105907436@goodmis.org>
 <20250620081542.GK1613200@noisy.programming.kicks-ass.net>
 <20250624105538.6336a717@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624105538.6336a717@batman.local.home>

On Tue, Jun 24, 2025 at 10:55:38AM -0400, Steven Rostedt wrote:

> > Which is somewhat inconsistent;
> > 
> >   __clear_bit()/__set_bit()
> 
> Hmm, are the above non-atomic?

Yes, ctags or any other code browser of you choice should get you to
their definition, which has a comment explaining the non-atomicy of
them.

