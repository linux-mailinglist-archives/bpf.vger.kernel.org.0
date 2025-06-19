Return-Path: <bpf+bounces-61058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F018FAE0194
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 11:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEC619E56D7
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E066B266573;
	Thu, 19 Jun 2025 09:12:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBE921C186;
	Thu, 19 Jun 2025 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324346; cv=none; b=UUPP/vBhlRWVE+9Bb22kxTLhkzXtdRieAlN8uh0acVUHqvC9+OTyAsQcBepCLEs7xnGuvPsw/tdTVZiDQfvRVnPR+NaBRw+MBiW8Dcl402s/CYP2hfEMJePz7QUArit9rWv3TACN8Z6TciF5SWeAvVOqFlxRGwu0yVPDq26X+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324346; c=relaxed/simple;
	bh=9dtD8ZQTlCedQDdhY5DGYeOU6xnMoF/N3xDyZt0TPVo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=n1D08x0tcpsp6MijlT2CujsPQJQcLPDJNy7v5BUExdFRfUdtlfUTkBxv5gPfcrDc6LmEl+GA2lMzmGZoDilmXZZiZvH6A/9XQ+7rgLSdPYBCmotPVRTx7yRC9VFfNldyCymnpDGUyMxiAdM93KtIaHMCBANpMJ7l2nzCs350ZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id D8ABD120849;
	Thu, 19 Jun 2025 09:12:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 7BEBE19;
	Thu, 19 Jun 2025 09:12:18 +0000 (UTC)
Date: Thu, 19 Jun 2025 05:12:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 05/14] unwind_user/deferred: Add unwind cache
User-Agent: K-9 Mail for Android
In-Reply-To: <20250619090436.GE1613200@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org> <20250611010428.603778772@goodmis.org> <20250618141345.GR1613376@noisy.programming.kicks-ass.net> <20250618113359.585b3770@gandalf.local.home> <20250619075611.GX1613376@noisy.programming.kicks-ass.net> <20250619044714.5e676bf3@batman.local.home> <20250619090436.GE1613200@noisy.programming.kicks-ass.net>
Message-ID: <88E4D247-84F1-41A8-AA64-0E1390F41B1E@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 7BEBE19
X-Stat-Signature: y5oyhsa37ksymoxtsehon998dmmjpft7
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Z/TL067T9RzTU/wh7bL5NRFsDHAz9Hiw=
X-HE-Tag: 1750324338-810967
X-HE-Meta: U2FsdGVkX1/A3C2NyH77oHHTFskXovxw8kRvhw4c2ZWZ1eEuQvstb/Uh35U+mNUeLtwWyuR1lxjZAmtg/ObFeKNU8LUIeEFjLb0WLYfmoHaa1GEv9zs3vccWXb8gCsJMwp1L2bD8sRsjdDvZiGZhTFPOwfXqc4X47w2O//dExXA1xxvpTqKRd8zhsAyiN1mo0t2BfzqxzxsGNo2p9612k3sba8xQjmAuXGYKjC/42hV1HlU0i8cttKecCw/4I4AHmmxXe82CykcbaQ58/JdXPsrRwh4q2mQDN8zbtiLplkfv2K5bgc+Zpahs+r5+NTa8mJfFhc/dF4NsLnf/ylvyEw7L/ooWFUF11FoUYxpywCmjN4H7pwfaSKYZsnVNuBmj



On June 19, 2025 5:04:36 AM EDT, Peter Zijlstra <peterz@infradead=2Eorg> w=
rote:
>On Thu, Jun 19, 2025 at 04:47:14AM -0400, Steven Rostedt wrote:
>> On Thu, 19 Jun 2025 09:56:11 +0200
>> Peter Zijlstra <peterz@infradead=2Eorg> wrote:
>>=20
>> > Well, the trivial solution is to make it 511 and call it a day=2E Don=
't
>> > make things complicated if you don't have to=2E
>>=20
>> I don't know if this is more complicated, but it should make it fit
>> nicely in a page:
>>=20
>>   /* Make the cache fit in a page */
>>   #define UNWIND_MAX_ENTRIES                                      \
>>         ((PAGE_SIZE - sizeof(struct unwind_cache)) / sizeof(long))
>
>Right, that's the fancy way of spelling 511 :-) Except on 32bit, where
>it now spells 1023 instead=2E
>
>Did you want that bitness difference?
>
>Also, you ready for some *reaaally* big numbers on Power/ARM with 64K
>pages? :-)

Bah, yeah, I need to use a size and not just PAGE_SIZE=2E

 Thanks,

-- Steve=20

