Return-Path: <bpf+bounces-61076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D98AE0680
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 15:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DDA18908EB
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 13:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5024293C;
	Thu, 19 Jun 2025 13:04:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BFC22B598;
	Thu, 19 Jun 2025 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338274; cv=none; b=ocPwu/k6ljByH9stR+Jba3/+YL7XCnE3L5Q/fhNAy61vvEa3/FlWXWFbvY+CND8P3lLl1kfbAZuViRU/OlhY1/UHONghAEJoAxsm4+Nyl1bh1kTlhFL8dxfbhBxfc7XsoE/Rkd1g978SdEUWjPDSGbXWGYUsUQVizYMsTPwWQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338274; c=relaxed/simple;
	bh=93F8isZ1HTnaU2t1j/RbAbv2oZp/2EaKdxoLa9X7CrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYxsvIdIrN5yMNQ0BVBBG8t5YW0KB+TTZvyF0rNUx9BycNAA9fBEMViBSVFQm2XwNu0Vz5je5Bu2sYDlbIe4nSHveq9dralKVA4gZ3+8hCtbVa4PidG0QuDbH3XVGuE5Ayy2kzblEg8PxQL9LxLqe2E6YwJ3BhTGYD2N9KPhmAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id D7026C1081;
	Thu, 19 Jun 2025 13:04:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id D54E060011;
	Thu, 19 Jun 2025 13:04:19 +0000 (UTC)
Date: Thu, 19 Jun 2025 09:04:17 -0400
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
Subject: Re: [PATCH v10 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250619090417.20d37c7c@batman.local.home>
In-Reply-To: <20250619103951.GJ1613200@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.938845449@goodmis.org>
	<20250619085717.GB1613376@noisy.programming.kicks-ass.net>
	<FCBAD96C-AD1B-4144-91D2-2A48EDA9B6CC@goodmis.org>
	<20250619093226.GH1613200@noisy.programming.kicks-ass.net>
	<80DBA3D8-5B52-43DB-8234-EAC51D0FC0E1@goodmis.org>
	<20250619094505.GC1613376@noisy.programming.kicks-ass.net>
	<66A7F6C1-3693-4F76-A513-7CBBE3154B06@goodmis.org>
	<20250619103951.GJ1613200@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D54E060011
X-Stat-Signature: e8khyg14i3uotp84pi8cd8k4airseesc
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19HZx29y+G7eky02MlJ/UB1A7jJXzDrWzk=
X-HE-Tag: 1750338259-146528
X-HE-Meta: U2FsdGVkX1+DX4gkzy3U5oqaMpU2HDSIG5jczdrwwkXd3/XekNLX9ZoizcM0xjRhAJNFye0bYAzARnApx8Qx8k9bUueaEV4KV+RugMz+761I9FM8wovIqIiZhCkN49yQj3fz5FoGZT5oZ1lM4zI9/sIm9uykglhlUjRKDSNaTRP94UvOTBkeoISqlCb5ZJGVPZXnW8girs5DlIy4WOG0ZuACSk0QB0iXiZl9UJjXEfjC2rvGtuy/8t3OaTIK6+ylWJJ1oa2UWRGHb3HiXOpNf6xizENfUFFtby562ux7v5ODeU4YXHN766dvRE6sF0A7qVRCjpaSqtHozQWMyGlI27z3Yk7YgZELv1qc1k8mNFFVVX5PvKNs2HOYySersi+V

On Thu, 19 Jun 2025 12:39:51 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jun 19, 2025 at 06:19:28AM -0400, Steven Rostedt wrote:
> 
> > We currently care about x86-64, arm64, ppc 64 and s390. I'm assuming
> > they all have a proper 64 bit cmpxchg.  
> 
> They do. The only 64bit architecture that does not is HPPA IIRC.

It appears that I refactored the ring buffer code to get rid of all 64
bit cmpxchg(), but I do have this in the code:

        if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) || 
             IS_ENABLED(CONFIG_GENERIC_ATOMIC64)) &&
            (unlikely(in_nmi()))) {
                return NULL;
        }

We could do something similar, in the function that asks for a deferred
stack trace:

	/* NMI requires having safe 64 bit cmpxchg operations */
	if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) || !IS_ENABLED(CONFIG_64BIT)) && in_nmi())
		return -EINVAL;

As the only thing not supported is requesting a deferred stack trace
from NMI context when 64 bit cmpxchg is not available. No reason to not
support the rest of the functionality.

I'll have to wrap the cmpxchg too to not be performed and just do the
update, as for these archs, NMI is not an issue and interrupts will be
disabled, so no cmpxchg is needed.

-- Steve


