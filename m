Return-Path: <bpf+bounces-62174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C0AF605C
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C534A099C
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E629309A71;
	Wed,  2 Jul 2025 17:49:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A423184F;
	Wed,  2 Jul 2025 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478541; cv=none; b=EIlsAAqCJAb2lQ5vgpDNrcGbhMuhcJWsSXEwkJOjpiJXFc8iYnyHxyqdBWwTyJ1A3pvc6lZWJ/3KcuwGQgn8oyvOgHIzJ6/cEEgBRDBLnmfhvBMLuMcFqTdhmUQKnhwvXVdrT/mUTHkpJ4I5hdojv6pT77PrMZ8LMYxz/ssYuNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478541; c=relaxed/simple;
	bh=W4clqCGcKkGRaHM8rxxqoaw6muvKMFw6Txw+b/rsxO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8wrAq/5rcFxwdZ9nuIHUZ057SHsuCbbYwc5CPaDWaAR6w2Sb8rcfK6Nej4UJvsyl+6x4gOOuxW6Ze9gnGeTIn7Bf7OB074w8Q6UDXizbpCJN8NA3Bjlvpfh3WnpBYThEOPCwxxkL0mHNMtEf62fENXKh/F76AoS81x+Gvwmz7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 12AE180397;
	Wed,  2 Jul 2025 17:48:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 85C361C;
	Wed,  2 Jul 2025 17:48:51 +0000 (UTC)
Date: Wed, 2 Jul 2025 13:48:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>
Subject: Re: [PATCH v12 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250702134850.254cec76@batman.local.home>
In-Reply-To: <20250702132605.6c79c1ec@batman.local.home>
References: <20250701005321.942306427@goodmis.org>
	<20250701005451.571473750@goodmis.org>
	<20250702163609.GR1613200@noisy.programming.kicks-ass.net>
	<20250702124216.4668826a@batman.local.home>
	<CAHk-=wiXjrvif6ZdunRV3OT0YTrY=5Oiw1xU_F1L93iGLGUdhQ@mail.gmail.com>
	<20250702132605.6c79c1ec@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 85C361C
X-Rspamd-Server: rspamout02
X-Stat-Signature: 175jbe4168myexmy1gk6dtde914kmzj9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18LFL9mMEFyOkjz76afnK3fxJjKKQ7f0x4=
X-HE-Tag: 1751478531-629861
X-HE-Meta: U2FsdGVkX1/OiWiWpEVHt+o9dCeRXDTbiofXevMg1yXZS67j6WEEFBdCtKq8nE2r7OSUgZQ5Gb5xb6qhk4225JfyXP5xCaaMNUXqsKuh1L3YWxF3x/3YPJLFQ79yTimAun0pTD3KTU342Tt6GwM7zdETUua6tGFlojPwnR61c+T+pV2ALC4Zs5rLqds1+QMjYWFyBHIkzFpLfDArf/FAfnWPnnn7kaKqygomQcchcAxHbxonaBk4acXZbWAfcxwx0U/28bXtER+JR0TMBnGU9DUUktXm1rWUJOd9JqSy0wzF70ESeVdrBU/G4moPz3+qR96aT2i854+g57tTa/egXIhZtJbCG0+BjgC+Dciy0ZbSXO/bac6DkSUL7ax7l8oB

On Wed, 2 Jul 2025 13:26:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> So I'm fine with making this a 32 bit counter using 16 bits for the CPU
> and 16 bits for per thread uniqueness.

To still be able to use a 32 bit cmpxchg (for racing with an NMI), we
could break this number up into two 32 bit words. One with the CPU that
it was created on, and one with the per_cpu counter:

union unwind_task_id {
	struct {
		u32		cpu;
		u32		cnt;
	}
	u64 id;
};

static DEFINE_PER_CPU(u32, unwind_ctx_ctr);

static u64 get_cookie(struct unwind_task_info *info)
{
	u32 cpu_cnt;
	u32 cnt;
	u32 old = 0;

	if (info->id.cpu)
		return info->id.id;

	cpu_cnt = __this_cpu_read(unwind_ctx_ctr);
	cpu_cnt += 2;
	cnt = cpu_cnt | 1; /* Always make non zero */

	if (try_cmpxchg(&info->id.cnt, &old, cnt)) {
		/* Update the per cpu counter */
		__this_cpu_write(unwind_ctx_ctr, cpu_cnt);
	}
	/* Interrupts are disabled, the CPU will always be same */
	info->id.cpu = smp_processor_id() + 1; /* Must be non zero */

	return info->id.id;
}

When leaving the kernel it does:

	info->id.id = 0;

-- Steve

