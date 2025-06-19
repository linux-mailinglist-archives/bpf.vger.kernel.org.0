Return-Path: <bpf+bounces-61064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7334AE01E6
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 11:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275097A78B6
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7087321E082;
	Thu, 19 Jun 2025 09:42:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28741E3DE8;
	Thu, 19 Jun 2025 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750326169; cv=none; b=gsUZdWvh9oib28ZrREEJD4ZSoS6PkvUgAioQtHYAowvr/hCQVj4HvzP4+Ix/GorLf5hh5g8rNbezqBJpF7nypt/ynNXvaMdmelSgCANSl+aTfwx74VDxkCfQsRS2XAvEmtfOv5rNMPvywjqd4DCO+wi9Le7DMdN5t0gMDs0e2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750326169; c=relaxed/simple;
	bh=O1jGF4Wb/pUkbNhephusfL38vZ4JQA1lxSzsxn3VAAY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qxwm6cuM10xfsa/SHv02Y/rV0waStEXbSvUt2CdFBf3lhRenV4D/gHlYi820kwbJhikKozY8+id9s7pmSxUlsobYJkWLA6IVFZcJKIuX7hKjCbx3G5l+hiPWfxf9DbQF8y8CSwfzbEFqfET10Pe24jpFPEmT7dK92aF5cP0V5xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 657C310179E;
	Thu, 19 Jun 2025 09:42:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 2AABC20011;
	Thu, 19 Jun 2025 09:42:32 +0000 (UTC)
Date: Thu, 19 Jun 2025 05:42:31 -0400
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
In-Reply-To: <20250619093226.GH1613200@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org> <20250611010428.938845449@goodmis.org> <20250619085717.GB1613376@noisy.programming.kicks-ass.net> <FCBAD96C-AD1B-4144-91D2-2A48EDA9B6CC@goodmis.org> <20250619093226.GH1613200@noisy.programming.kicks-ass.net>
Message-ID: <80DBA3D8-5B52-43DB-8234-EAC51D0FC0E1@goodmis.org>
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
X-Rspamd-Queue-Id: 2AABC20011
X-Stat-Signature: ebhysdh4njnmbf8en7ntwmgruebqwmcq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18r+Rb1/p1OHbLk2qYYFtxDJr7jwhy5qnQ=
X-HE-Tag: 1750326152-351886
X-HE-Meta: U2FsdGVkX18MPqMRRCSliM51ziRnLbUMZnaU3ozI0ina4JEAZ2mw9ijPZ4E8GXsAn6cT1ldjS/hTHG6T2pVNQx5YhCW4kjup0rzzC+o1BBq/ZYtKLE0QnRV3q4vrUHs+hV/vz+A2cJamMDKjVYf5zlH9L0pVeNq+bUjyDXJGjr5P/JQUctb6/w7KpWR6yvSuGjx3EFblP71hFLS2B05Vkz7CkQb5XW38J4WmjJ9Ncf+HEJV+OiAkHJiNXCmTo58xPtlRaL8jQZuIeDmti0oZdqr41xNTPbeXDOLvg4Il25ldF6oxrr4tlgEJbKxg8JGkKfLj8QPuUhA8jmLe75wIogTnRJ4kvcm8XHmsT9cKmI1x6VvRzo2x7cp5/1fxf2xDGY3vgjWD/4C80xoXeVXJ8NVwz3dO29/5KqGyjXThKEY=



On June 19, 2025 5:32:26 AM EDT, Peter Zijlstra <peterz@infradead=2Eorg> w=
rote:
>On Thu, Jun 19, 2025 at 05:07:10AM -0400, Steven Rostedt wrote:
>
>> Does #DB make in_nmi() true? If that's the case then we do need to hand=
le that=2E
>
>Yes: #DF, #MC, #BP (int3), #DB and NMI all have in_nmi() true=2E
>
>Ignoring #DF because that's mostly game over, you can get them all
>nested for up to 4 (you're well aware of the normal NMI recursion
>crap)=2E

We probably can implement this with stacked counters=2E

>Then there is the SEV #VC stuff, which is also NMI like=2E So if you're a
>CoCo-nut, you can perhaps get it up to 5=2E

The rest of the tracing infrastructure goes 4 deep and hasn't had issues, =
so 4 is probably sufficient=2E

-- Steve=20


