Return-Path: <bpf+bounces-77000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1CCCCCA47
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6729C3020CC3
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FD338257D;
	Thu, 18 Dec 2025 16:04:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21F729AAF7;
	Thu, 18 Dec 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073871; cv=none; b=Bb65bbkl7sNO1qYKporGf061ssJ9w1Qi+ZAfKHpTATw1mQIgzsSKkFYpSz4hF0v1N/37ModuXYxsmJnJg6pOt8KcRrPkIVlYBTzHraiy+Is9/8hXcIvS4aqNnCLee+i1rFNS8IxjBjZL+FPhvhmokxAWlTk/Im5ZMDQbT87xclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073871; c=relaxed/simple;
	bh=zVgHN21Tp/CFQHVnykpfsgzbFUcCsCGg+ndjObkJ4Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAhYTTTjKSj7AOjadXsWcrQFCzOQ/midepohyNEExYB0w+YsZA+dJtJ26YGc4aCIe5mVXCFS7zpEb3p3GcjBawea5wwUtr23ColSDET3g3QuF3WR2bS8t8j7B67IoJfq20FMt3kVgKJe7Akvgnd7Q21VuQ1QBkAe48BsCwTmn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 70388B7BE6;
	Thu, 18 Dec 2025 16:04:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 94F2B20012;
	Thu, 18 Dec 2025 16:04:23 +0000 (UTC)
Date: Thu, 18 Dec 2025 11:06:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>,
 Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, Song Liu
 <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 8/9] ftrace: Factor ftrace_ops ops_func
 interface
Message-ID: <20251218110602.2e8d4663@gandalf.local.home>
In-Reply-To: <20251215211402.353056-9-jolsa@kernel.org>
References: <20251215211402.353056-1-jolsa@kernel.org>
	<20251215211402.353056-9-jolsa@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 94F2B20012
X-Stat-Signature: 1phd97uu84bs96m3sy5rbg85rg413raq
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+aGNRDENTMUib0iCViJwboi4wcneSr5cU=
X-HE-Tag: 1766073863-938075
X-HE-Meta: U2FsdGVkX18wqY2inedRQwkLOcwAi6uSIlagwQEwRSozsWrmWC9XiMsbQkUViMmkKWgshcNt0feN+UGrRbD4sIwt0PpR5W4flywVA8swgabpJQrSQD1q3kZw+F+mzn06gWTFRQPiLRXKcCqjEov7W6o4v2NSdFFltZFHG5l7C534LaeD/OEOS/7T6rp9yitzxPtC9ZGxoZRCXNvBrRLR+nubARaxoAX2FB3mIdKPg8d7BCqwzuybYApSXYFQjwmpN9Qm4kYN/wtp/dc2mM82DVyKbIVNiJ9A6qF1WAzXlvvoAeQ7EmOP+bavKmFqNEGDPt5s+KALJ+N5+zweVE02LFsSbkM1UIcT/hb5kNOOHD/UXNF9af7wC1REpmPclS9xLs30cRSXIxq/Buu70dSHiw==

On Mon, 15 Dec 2025 22:14:01 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> We are going to remove "ftrace_ops->private == bpf_trampoline" setup
> in following changes.
> 
> Adding ip argument to ftrace_ops_func_t callback function, so we can
> use it to look up the trampoline.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

This mostly touches bpf code so:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

