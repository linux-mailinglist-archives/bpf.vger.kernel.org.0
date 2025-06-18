Return-Path: <bpf+bounces-60937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7C1ADEEAD
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321813AEBC0
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB07C2EA737;
	Wed, 18 Jun 2025 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dgKr3HPH"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F5275845;
	Wed, 18 Jun 2025 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255281; cv=none; b=QOl+gdkiMxmRzErCi1zAiKTmkmx2rIevZF/qKyvQZT4sEFPdIheD76VRU15Ayqm6TJBuisdWc/EyzvOJG9XlKt5jLVTLzAbsOOBpetakoJTwiXm/OohvXT93bIQ5LQJ767orQqyVXqOgkBiaGgIBhZ1dvspv2d79FJtcD5O6YZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255281; c=relaxed/simple;
	bh=2xpKxneeDSxJx5GW+cKcbZYtSwQpXKRUzK8mzxpBifQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRolE5L1QgnTpfH1kfL0FTjd9zdDatMClBXI648mLGtojJwI+1DFcgEIjZexo3TrIaChW/7kFnV+Gu9VvRJpIMszUr/7XQkEZJl3+jNbDxl1q1OFo3142qLgczZDX7KPurfHPcbFYTjaLwGpO6BWTOkbX0AfcmPIMtGQu8MG7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dgKr3HPH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=phDELo4pD3olcEbI7zprE6ptC866ichD2lbV8m6X3fU=; b=dgKr3HPHp7VibE+A8z6x46nhYb
	BlSqvfHVmNLcAkBpDr5DTjmmDlk8d/NUUdqOXGnKLgOUlr3wBnuk6IeQrWl+sQZ9r91EC/EX/xpZb
	lu+CAeM18sXMQESceBqcI6Cgh2ImJNJQSw4k0sJJlNRJX7yxYKZHZfeYh36e7WF958BfcwU0sbw1b
	UErN1vliZN3fB5L/NUpAQUldzhMMpexqYXkx4Fy+jjjj471gCPjIaCPZZRzBU2fxjHd+t3A4o9LzK
	yey5UDde3s4u7a9OKwEriv9GB7icwcJAVObTQXRtn0lrRdaH6zkGcN6u2cPFG+aw7dBb92LAC0Ntk
	OA1TGF4g==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRtLk-000000044zW-1hYN;
	Wed, 18 Jun 2025 14:01:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 486BF307FB7; Wed, 18 Jun 2025 16:01:11 +0200 (CEST)
Date: Wed, 18 Jun 2025 16:01:11 +0200
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
Subject: Re: [PATCH v10 04/14] unwind_user/deferred: Add
 unwind_deferred_trace()
Message-ID: <20250618140111.GP1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.433111891@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611010428.433111891@goodmis.org>

On Tue, Jun 10, 2025 at 08:54:25PM -0400, Steven Rostedt wrote:

> +#define UNWIND_MAX_ENTRIES 512

The reason this is 512 is so that you end up with a whole page below?

> +int unwind_deferred_trace(struct unwind_stacktrace *trace)
> +{
> +	struct unwind_task_info *info = &current->unwind_info;
> +
> +	/* Should always be called from faultable context */
> +	might_fault();
> +
> +	if (current->flags & PF_EXITING)
> +		return -EINVAL;
> +
> +	if (!info->entries) {
> +		info->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
> +					      GFP_KERNEL);



