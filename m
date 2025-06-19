Return-Path: <bpf+bounces-61070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E1BAE0289
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DC41BC4DB5
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA65F222565;
	Thu, 19 Jun 2025 10:19:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC8219313;
	Thu, 19 Jun 2025 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328387; cv=none; b=qlQif2iZgFhsh6qjFZ59eSbcXCgCZVDaFMPza0rZ3/sPxavJWir62VAoeGInmmkknQqCdlXGciaxj7u5Qj5dm6HRcWXXSnXyKzbOt5QvnZtR+FghjbuYY9tbqulaGTkz/SImBcrl3yFeuKDikhf+2kzsIJmpHQYJpXBKIc2TQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328387; c=relaxed/simple;
	bh=uQpmKJcQa3jBiyQsVs7DbKF/c71PSRaAxJgyqI1jUlc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NsUNcHNsYyoUUcGmITdPreM5RdH/TCUu5JCRJItH4xsAyQ3CJD819jFKf33XHpn1kv4EyXQ4KN4YATNjTk3cXPyc1FsnvrGijrC7RqdjLSdQNmV+/pB22sRKtlOeQtLjL3bzhDFPU9mU6+FjSlnRoLC+749a7BkW96Kb5Qeey48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id BCC0B1D6FBB;
	Thu, 19 Jun 2025 10:19:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id D459E2000D;
	Thu, 19 Jun 2025 10:19:36 +0000 (UTC)
Date: Thu, 19 Jun 2025 06:19:28 -0400
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v10_07/14=5D_unwind=5Fuser/deferre?=
 =?US-ASCII?Q?d=3A_Make_unwind_deferral_requests_NMI-safe?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250619094505.GC1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org> <20250611010428.938845449@goodmis.org> <20250619085717.GB1613376@noisy.programming.kicks-ass.net> <FCBAD96C-AD1B-4144-91D2-2A48EDA9B6CC@goodmis.org> <20250619093226.GH1613200@noisy.programming.kicks-ass.net> <80DBA3D8-5B52-43DB-8234-EAC51D0FC0E1@goodmis.org> <20250619094505.GC1613376@noisy.programming.kicks-ass.net>
Message-ID: <66A7F6C1-3693-4F76-A513-7CBBE3154B06@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D459E2000D
X-Stat-Signature: rxft1uw1rdfn3xzxfp9smhq4zoupegsz
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19xJoYPE0er2ykcY2JEewGtd3aTP/uPG1s=
X-HE-Tag: 1750328376-968138
X-HE-Meta: U2FsdGVkX18lITO42vyn34nmUSpJ97ltbSkNmlsjkVJLW5p7rI+wja5UcqQ3e8Yeclt7U10twAE8flO4jSkwyv73xTFcTJL6tyi2/EHSb1KqG0jrWBXTtPQAcKt95Qh/ZF/2f5FDt/0rAhAfoPgjbhB+SE2GQLjnIsnnUpagLjqsl6dVq3TvoIsX/lHbL/hMbYCUNzdGe6gyHCEZtVz9AEkU64ixxZToL/PDHFNWMRojp1PkWYExOomeJOVxZD+deTJuK7r7z80dP6pj2t5lX36HnMKnh2CrLAWR/AvvbA+tKHgyrfuj9AlDic5Mag4x+12FWJWmkEEPLTl0UB77E/D+rqf0TNKap/JQKxOlPK4/mkA5lbqiHhQfrI0BOnbKamGxNYn28tfAdTRoAPzfhg==



On June 19, 2025 5:45:05 AM EDT, Peter Zijlstra <peterz@infradead=2Eorg> w=
rote:
>On Thu, Jun 19, 2025 at 05:42:31AM -0400, Steven Rostedt wrote:
>>=20
>>=20
>> On June 19, 2025 5:32:26 AM EDT, Peter Zijlstra <peterz@infradead=2Eorg=
> wrote:
>> >On Thu, Jun 19, 2025 at 05:07:10AM -0400, Steven Rostedt wrote:
>> >
>> >> Does #DB make in_nmi() true? If that's the case then we do need to h=
andle that=2E
>> >
>> >Yes: #DF, #MC, #BP (int3), #DB and NMI all have in_nmi() true=2E
>> >
>> >Ignoring #DF because that's mostly game over, you can get them all
>> >nested for up to 4 (you're well aware of the normal NMI recursion
>> >crap)=2E
>>=20
>> We probably can implement this with stacked counters=2E
>
>I would seriously consider dropping support for anything that can't do
>cmpxchg at the width you need=2E

That may be something we can do as it's a new feature and unlike the ftrac=
e ring buffer, it won't be a regression not to support them=2E

We currently care about x86-64, arm64, ppc 64 and s390=2E I'm assuming the=
y all have a proper 64 bit cmpxchg=2E

-- Steve=20


