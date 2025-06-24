Return-Path: <bpf+bounces-61376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6643EAE67C1
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 16:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D995A5C87
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 14:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F282C3274;
	Tue, 24 Jun 2025 14:04:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC2E1BC07A;
	Tue, 24 Jun 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773842; cv=none; b=my5UpS72QtlqOzvagoaLcbFWhxI+keKVGZ6GL0EK27qqxLHF9OnjoiS+RvSBdp14at683I3/5QO9cgUK1qKAEp3oyDi2oWalo1fWuiwlqVA+3KRHeO2tgXJCGmadxAjXElEQmogSBDPdoaKNhIlV0s+SjRfNhTIl916uvYXOrTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773842; c=relaxed/simple;
	bh=A3fqxi1Gy38Ugk0YVhHa8CEMOpg2yAhTHWCTcVioxXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwCf/Z8vsw1JcOfEgXgPPqMJBjvfi7+5TyiCP0ejBRSHz50skh2UGG1Zt5Z+da3rdSW9DE3Ou7EYbXzslnAi7V9KcewD4gDgAwYBHa9OhhrIDqRxpMSUE8jcffHpMv9skyqCD5A3LR3a0azdk1K03kImol0MgVFg6/wack4Terc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 8EF091D7B90;
	Tue, 24 Jun 2025 14:03:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 89D1C20027;
	Tue, 24 Jun 2025 14:03:47 +0000 (UTC)
Date: Tue, 24 Jun 2025 10:03:46 -0400
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
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250624100346.37bae8d5@batman.local.home>
In-Reply-To: <20250619091121.GF1613200@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.770214773@goodmis.org>
	<20250618184620.GT1613376@noisy.programming.kicks-ass.net>
	<20250618150915.3e811f4b@gandalf.local.home>
	<20250619075008.GU1613376@noisy.programming.kicks-ass.net>
	<20250619045659.390cc014@batman.local.home>
	<20250619091121.GF1613200@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 89D1C20027
X-Stat-Signature: b5pscrbs7693m5s7gh6q8bzbh6qkg3hz
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ZDcuVGNr6IrYvNwwot/CijvMr9Ql6HhY=
X-HE-Tag: 1750773827-572531
X-HE-Meta: U2FsdGVkX1/k3rL43ACSxNa5qBQc9cE/D2z+xFmXn37hoQbG5P66Zk2B5NEEFJukSYAelTM74e8+nxq5wRQqhEkwa53Xp4tT4AgJRevcNJhWKxOXtELL3Qo3gB2h8wKkWBDVLXcYaj/1jMtGQSGutaJxTKUKm+KH0CBXl4Vjn7EDucBUrgciLvAOYDe8Wc1+McguIo6mM9Fzs3n27i3gFK5Z0J0isuFY00OowigNTrI6DqVX8DhCsrLFUg59Ajpva06viqoERpY72RjKFyA19JAC1fDV/0Yu4IdSeYeB7odCcXgXsGqS0Ke6ih4EScckaQ5l+EM/H1fZXCzbFqKeV0ORPGUSAWUihWqdjP5QF3nD8XzwpOoWyPAlwPH7Ai37

On Thu, 19 Jun 2025 11:11:21 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> I feel much of this complication stems from the fact you're wanting to
> make this perhaps too generic.

I want to make it work for perf, ftrace, LTTng and BPF, where each has
their own requirements, which tends to force making it generic. :-/

-- Steve

