Return-Path: <bpf+bounces-61055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73043AE017D
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 11:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FB1189EBD1
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FDA279784;
	Thu, 19 Jun 2025 09:07:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEBA1E0DCB;
	Thu, 19 Jun 2025 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324039; cv=none; b=nIPoq2vFtZS43AhkzA6BsE4IXdFg/oZCvO9JTMGNDXXMcSv8BAo41W9UnVHxZ13vGQGU3EcZ3NpGLCTFdD2hesWgg3pXUeHu26l/4vb83+R3sguNXm7rXo3dfMu79LEIomqiwDolicD0/sEGucnFLTrR6Bo6ogpIbEjVG/Amibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324039; c=relaxed/simple;
	bh=ahaaatE1/XxdTvUtlYxYK5uvRoyIvpukhvg61lG4J3A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=IpJfOuscj1wKHTXnwLQAYic3fFu650DA3X90q2v5+HSPLZMKV8uEwGrE7AbuaCh+hlYEhwlsvF76bpNwpZUjyumz7ECldG35CJ0ipbaUerlMXZDaHqU8jm5lulFxvq5ACMo//64PGrMjv507QPGKE+cv3aey/6vUJLyzXvCgxA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 54BE91A0810;
	Thu, 19 Jun 2025 09:07:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id F3CCB80009;
	Thu, 19 Jun 2025 09:07:09 +0000 (UTC)
Date: Thu, 19 Jun 2025 05:07:10 -0400
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
In-Reply-To: <20250619085717.GB1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org> <20250611010428.938845449@goodmis.org> <20250619085717.GB1613376@noisy.programming.kicks-ass.net>
Message-ID: <FCBAD96C-AD1B-4144-91D2-2A48EDA9B6CC@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F3CCB80009
X-Stat-Signature: w4oadz4e5wjgp57dso48bdg8fbff6npa
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+UcTmmDm/7gX7BO+6mWvuXzmb2JAzo29w=
X-HE-Tag: 1750324029-462730
X-HE-Meta: U2FsdGVkX19+7P6lonf3hA4ToYS+99YZHuL4HI/j3lJQyWszyj7ErdINMqxYUvAw+1tC7kLHl/TiMyhb39cZQj8hOgQQzXlBZdRW4PK6SFoCLS8e/lXMPtV/zaWqCCC3yHK58QrcoEo+slhLk9v5s+MhWFsWGB9nc4RmqUezSX6uexUeuEe1Bs7GbeEW/GUEbxnxBxr2oJ+kYNbDewIu3GbhstIqFcxtpD9F4yd0xZ1iq+ahgY5xT1MuaCSExO6o7pNSOTh06h06OTOrYzGZexookrde+zXKD8ZGxtL5CdG5n0IMyNzm15hhFJ9cm6ApLrsatRfDBybSaNKQM5OMZsD+wOraXB1TmYLdD+xpKXwjC33qNqEN8AC9XjdWqowwpbMuhRGPoHnDhFiicrCkfQ==



On June 19, 2025 4:57:17 AM EDT, Peter Zijlstra <peterz@infradead=2Eorg> w=
rote:
>On Tue, Jun 10, 2025 at 08:54:28PM -0400, Steven Rostedt wrote:
>
>>=20
>> +		info->nmi_timestamp =3D local_clock();
>> +		*timestamp =3D info->nmi_timestamp;
>> +		inited_timestamp =3D true;
>> +	}
>> +
>> +	if (info->pending)
>> +		return 1;
>> +
>> +	ret =3D task_work_add(current, &info->work, TWA_NMI_CURRENT);
>> +	if (ret < 0) {
>> +		/*
>> +		 * If this set nmi_timestamp and is not using it,
>> +		 * there's no guarantee that it will be used=2E
>> +		 * Set it back to zero=2E
>> +		 */
>> +		if (inited_timestamp)
>> +			info->nmi_timestamp =3D 0;
>> +		return ret;
>> +	}
>> +
>> +	info->pending =3D 1;
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * unwind_deferred_request - Request a user stacktrace on task exit
>>   * @work: Unwind descriptor requesting the trace
>> @@ -139,31 +207,38 @@ static void unwind_deferred_task_work(struct call=
back_head *head)
>>  int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
>>  {
>>  	struct unwind_task_info *info =3D &current->unwind_info;
>> +	int pending;
>>  	int ret;
>> =20
>>  	*timestamp =3D 0;
>> =20
>>  	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
>>  	    !user_mode(task_pt_regs(current)))
>>  		return -EINVAL;
>> =20
>> +	if (in_nmi())
>> +		return unwind_deferred_request_nmi(work, timestamp);
>
>So nested NMI is a thing -- AFAICT this is broken in the face of nested
>NMI=2E
>
>Specifically, we mark all exceptions that can happen with IRQs disabled
>as NMI like (so that they don't go about taking locks etc=2E)=2E
>
>So imagine you're in #DB, you're asking for an unwind, you do the above
>dance and get hit with NMI=2E

Does #DB make in_nmi() true? If that's the case then we do need to handle =
that=2E

-- Steve=20

>
>Then you get the NMI setting nmi_timestamp, and #DB overwriting it with
>a later value, and you're back up the creek without no paddles=2E
>
>
>Mix that with local_clock() that is only monotonic on a single CPU=2E And
>you ask for an unwind on CPU0, get migrated to CPU1 which for the
>argument will be behind, and see a timestamp 'far' in the future=2E
>

