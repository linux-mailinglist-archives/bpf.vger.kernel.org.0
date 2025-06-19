Return-Path: <bpf+bounces-61065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6827EAE01F2
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 11:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4C316CED6
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC02220696;
	Thu, 19 Jun 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O43+g/bn"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A6021C160;
	Thu, 19 Jun 2025 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750326323; cv=none; b=THYojK0+bEQQqXLK1hnPRhibR/uMlUyGqR9aStqyCEjyMI5OlbqEmNHfe/uQDtOWiA3nuRtkMyhE30ZIdmbVCmgdMH4QXW8DJapQKd74+irie9FHCCGTxL0UQnbrRxBmaR0B1uJVLdn5iTqXwqG8AAcbdXD8koJvJoJcPAQOF9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750326323; c=relaxed/simple;
	bh=NnIlT7i/zvs7VO4G/USht2MjNi1sZsoz+k3lOcRMCII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leLAvhOdpZcNwoxZI5H/ahpFOIGQ+14rmLcoUDtz/4SII504C8WaSs04WqGxzJFdpO3VLjsLKj3dD+EdexLK5pV1Us+RvlPQsiRF8e1UtUbY55D8APFqxLPqe4ImIKLVty4/yx+4W0tU0yr/dtyVvg4y4BH9A9/dR0txKvQjKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O43+g/bn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t9vGqsGMLtKz8r6e0ZtTpdqqrhT7A+2/Hsvv7xIOiPM=; b=O43+g/bntkOwapSUleSx7FqaDb
	TwVMBDEOoTTe8LMlVDt56bHKf0zyqymWJyTzw4tBmOF/apL/H2/2NkCtNMnNgL6lRWIObVOwuYeIH
	S+Q/baaeBJLpFBNh6UQXXR/MjxYSWMibgiWuRr+QrPdZquvhcawW+57zp3DOqWuQMdraPpPPjRgfI
	qn7kEd+kcxim8OG9q/zChioZGpIutJhiVTwwusdQQloknAOvWIqV9UttOYsdLTk+JBsPjxJdMKgeT
	oWuvGu8ydBOGCwQCX8esLY+0Llm2DezO3eF8hkC6fbzVaEhZAYHlXN+JkcmU/RCYORqrixaYAnIhv
	Ihn6JDBA==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSBpT-00000004OfE-1W5t;
	Thu, 19 Jun 2025 09:45:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A8DA130890E; Thu, 19 Jun 2025 11:45:05 +0200 (CEST)
Date: Thu, 19 Jun 2025 11:45:05 +0200
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
Message-ID: <20250619094505.GC1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.938845449@goodmis.org>
 <20250619085717.GB1613376@noisy.programming.kicks-ass.net>
 <FCBAD96C-AD1B-4144-91D2-2A48EDA9B6CC@goodmis.org>
 <20250619093226.GH1613200@noisy.programming.kicks-ass.net>
 <80DBA3D8-5B52-43DB-8234-EAC51D0FC0E1@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80DBA3D8-5B52-43DB-8234-EAC51D0FC0E1@goodmis.org>

On Thu, Jun 19, 2025 at 05:42:31AM -0400, Steven Rostedt wrote:
> 
> 
> On June 19, 2025 5:32:26 AM EDT, Peter Zijlstra <peterz@infradead.org> wrote:
> >On Thu, Jun 19, 2025 at 05:07:10AM -0400, Steven Rostedt wrote:
> >
> >> Does #DB make in_nmi() true? If that's the case then we do need to handle that.
> >
> >Yes: #DF, #MC, #BP (int3), #DB and NMI all have in_nmi() true.
> >
> >Ignoring #DF because that's mostly game over, you can get them all
> >nested for up to 4 (you're well aware of the normal NMI recursion
> >crap).
> 
> We probably can implement this with stacked counters.

I would seriously consider dropping support for anything that can't do
cmpxchg at the width you need.


