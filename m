Return-Path: <bpf+bounces-61072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ABEAE02D0
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 12:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0D33B842F
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DDC2248B9;
	Thu, 19 Jun 2025 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YZctAzzL"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB4F224227;
	Thu, 19 Jun 2025 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750329606; cv=none; b=Y1o0p93ECNMIs9oYQheQuFCW3exnoBiU7VpsoCsQpjothFLwA71ng/POjDOR1j7hCO+uZVyBKX91YSSRcKyEmWIjwuBaq75AITldmRNfqT/TomC0Zv6RMMxddW6qmf7dNzZX1+Is8sVbzMz6zjbfjxmIXMCoRGjUfwGlIBSZ8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750329606; c=relaxed/simple;
	bh=nntOW/P5iGDCWsOWzk1HoLNiFqAj5krOk873NBh3xys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7jdOMgAN7D80ebWtrw0NsLZ4gNXAOzsYx2kKenzJey/xywRKwMf1pyJBkB2FrupsPY1gAsU9q8TiC4e/HR+mQxSHHF3OK0+4AMtp4+lNT79IHpL0UMdiYIbGzw4RoVUahrBJV2BiSK/KID7pB1o3FF1GYfPxuEBwKfohujlXc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YZctAzzL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nntOW/P5iGDCWsOWzk1HoLNiFqAj5krOk873NBh3xys=; b=YZctAzzLpoDxOnzb14Pro3peMI
	XvjAGHaTK9JTW/16WWu9v/Hltm8e0T4M4hvapVZde6mVrufyjuFf5c9cDA2V70otQ3F3vxvnseJkq
	BpxHT8RxjinEyZgrmP2001WwYLJRgoPaOLCmhDn7TNZacWJv96F40VxslyBxjKm6+2zAe0SFHRx6q
	xuYRDcYSgPNgwmpfA4cIgHfX1SEjXqIEylqEn7GWGQE5Bmm4/ImH/LvFZpiNOz/Ij1nLwoccabEd3
	EcHNurT+CIMzPCwWHVOjM+tOArDy1hbn6qvH6FbeIb2GaPvudbJMj7UbIVGgtuO+OKaWJUhcUdhU3
	4D0kuJXw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSCgS-00000004PyM-3ueU;
	Thu, 19 Jun 2025 10:39:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3C1CD30890E; Thu, 19 Jun 2025 12:39:51 +0200 (CEST)
Date: Thu, 19 Jun 2025 12:39:51 +0200
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
Message-ID: <20250619103951.GJ1613200@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.938845449@goodmis.org>
 <20250619085717.GB1613376@noisy.programming.kicks-ass.net>
 <FCBAD96C-AD1B-4144-91D2-2A48EDA9B6CC@goodmis.org>
 <20250619093226.GH1613200@noisy.programming.kicks-ass.net>
 <80DBA3D8-5B52-43DB-8234-EAC51D0FC0E1@goodmis.org>
 <20250619094505.GC1613376@noisy.programming.kicks-ass.net>
 <66A7F6C1-3693-4F76-A513-7CBBE3154B06@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66A7F6C1-3693-4F76-A513-7CBBE3154B06@goodmis.org>

On Thu, Jun 19, 2025 at 06:19:28AM -0400, Steven Rostedt wrote:

> We currently care about x86-64, arm64, ppc 64 and s390. I'm assuming
> they all have a proper 64 bit cmpxchg.

They do. The only 64bit architecture that does not is HPPA IIRC.

