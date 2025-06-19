Return-Path: <bpf+bounces-61056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971F8AE0155
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 11:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF637A8158
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A7B2405EC;
	Thu, 19 Jun 2025 09:10:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D01E0DCB;
	Thu, 19 Jun 2025 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324228; cv=none; b=kDZFOoY1PTS70ji5XyHSN6wcNh8Lx6O3WAfCrv+LqD+xtw75kQRZZxpve+VHItlpFpwrDuPZqVwr4BINFHs4CH+dQPS26So0PVQ226s2cqBBbxR+hFTDlDDN4uArHFH5da0Hlm1/KrAxyxbaN82CnPPX58hQLR2/0kP7vTi0Bvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324228; c=relaxed/simple;
	bh=X9Ur4oICRVpAYe+lohYqKv4M0W5+UI7MMTETEAjmmgA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UuroD/VKk5vbnzAFh9wnztCs+7KB3vmHYoNl65HpoCm1VqWpnUqzpf0fAYfeP2rV9GQAH2HGWoqZ+xYSIxJP/pC0P42Dxf4jFbaiJ8FVv4Snf5aHr3MpM9Wa3k8iDcUYW8LbO1zlWI5LKiP23GQ8e7yyqSFwSSW8VfWcyoHvD7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 3A72A1607B5;
	Thu, 19 Jun 2025 09:10:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 05D4420026;
	Thu, 19 Jun 2025 09:10:20 +0000 (UTC)
Date: Thu, 19 Jun 2025 05:10:20 -0400
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
In-Reply-To: <20250619084813.GG1613633@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org> <20250611010428.938845449@goodmis.org> <20250619083415.GZ1613376@noisy.programming.kicks-ass.net> <20250619043733.2a74d431@batman.local.home> <20250619084427.GA1613376@noisy.programming.kicks-ass.net> <20250619084813.GG1613633@noisy.programming.kicks-ass.net>
Message-ID: <66B9E72C-4FDF-46DF-9231-BED06A6000D9@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 5u6tcifhicbkngw4cdyjd46w7i7yqabo
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 05D4420026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18IqjclQyx/l3AVNRVrVgUJZj9ZVpWbu7Q=
X-HE-Tag: 1750324220-266712
X-HE-Meta: U2FsdGVkX19nSMfWqL4SvKuyY/SxEm8yaKdZ24faUL3mw6DIjEBvVzSdy4eLizzyBXsRqtSr/wR8M3sE3NdZfV3o3xBJwCVAX7udrhIwovODF86IS5bRRq/s58yiuQqqfschJjiQMnHnlQNfRvYMvdYeg9xEi1ZW+8b7jjC6cxJRs/ILbZr3bDaX3weqjgUuETtmQPKam0BrQphxDkSA14AiV7WuENKRqM+guMuWCZV7c6cDM5ulB3FVYG1exQMgNQENbSp6xYS4E6Qm0mJhzWHItbz4b6ij/q38s5m19FcroGV7whvFTVfgiKYZnvUEB6rrhJySry3O99uikWGjjK+5Rx7aTNaNUMVZh70RgIppVF8RX5yKchNI5WHwHHFYutH/OGemyrlmsnARNQpPTQ==



On June 19, 2025 4:48:13 AM EDT, Peter Zijlstra <peterz@infradead=2Eorg> w=
rote:
>On Thu, Jun 19, 2025 at 10:44:27AM +0200, Peter Zijlstra wrote:
>
>> Luckily, x86 dropped support for !CMPXCHG8B right along with !TSC=2E So=
 on
>> x86 we good with timestamps, even on 32bit=2E
>
>Well, not entirely true, local_clock() is not guaranteed monotonic=2E So
>you might be in for quite a bit of hurt if you rely on that=2E
>

As long as it is monotonic per task=2E If it is not, then pretty much all =
tracers that use it are broken=2E

-- Steve=20


