Return-Path: <bpf+bounces-56781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E235A9DA5B
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 13:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755A0928344
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4B5227EBF;
	Sat, 26 Apr 2025 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="k8Eaj3p0"
X-Original-To: bpf@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193421C9EF;
	Sat, 26 Apr 2025 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745665770; cv=none; b=qPGxQONHoVsfS2GvOCMW0iUotTSlxiUw1qGHRMr6CxiE9NPKr+4s3l2TO+xAK3GFS2N6yKn71H5RdwhTqoAOMMHThH2m+zqOXGOzOdikm3Xxy9ox7Dcx8i0I548W0lV1kxSREMxQ+nx3L2cOnI4er+fDlK4c7TVMF61z0LqrxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745665770; c=relaxed/simple;
	bh=dgjGpipyMoa9Ud54nCP2vbHddyFOBRvn6OgnTHCKbv8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=vGk6mXzn2jLGJ55XZw3W/eUh54MyflvTu+9rR0OAGAa7jhxk3MPS1cTu7gctUSrs9/mPTITuc0XrRdRhAdvYINCfQh7q4t9AOyTOy6UL3+pEIWWvXhBAMzMeXkEPe++q3d8moNPDkcfPeFyPDodAxLpykOwxmNBvbeA2hg85Dnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=k8Eaj3p0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 33F2240E01FF;
	Sat, 26 Apr 2025 11:09:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vr4N2quaIm86; Sat, 26 Apr 2025 11:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745665750; bh=uTZUPbANBn1FT5juyhJpDoDSfFqVfzieIPf+T2BMphw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=k8Eaj3p0gPnwEf+CsFhhIh4WpbDa9DIP8CuE3FvMDNuS9goYpEVEqj2/y1jsPvNR3
	 c50CDHMm7LO3cQCZ4XoZVE4NA5JlDqE66RyGmnvwwfVzCvwPbYBjVKlebR7BgdRPbQ
	 ib2k0uk0/G8EXqfhLjVxcFz/YtJGkIk380dCgqcwOcp6a93YiULEk6XK/NY1OHfrEv
	 xmaFxRNMzbFfQQ7OsQjMMvO0C510NMxHKEObr/b+kUkhdpBdTF1Sou6G2S8MJ+JLsv
	 agufLgVWpSveFdSQmM2kYnUSiBhPZEzOhR31hv64jSrOU+xNcbetJhDtzjOzOa/2yS
	 IOCSqq3hxS1lmC5+PB08+X++1Ra2j2h9LjuTlZloA94KVFS9tyuW2Tq4gTrl82bQud
	 HU/DLYd8jKst5SRw+yAP9fg8qpBY8410ydmdJRdLCEdklXXsjOClob5vx/TSf2PCnI
	 n4Ma8FbK/6l/5gMEiJ6CnQGWp+HCCC4r9GCoG8JP80h2MaPSg62fpCH3N0jYZG8Fql
	 9k830mZL+dtKp81TrHfTA7Jh0loCUrBAOegakV7KN5HaUywWA0YrfHMa1NhkYE1g9F
	 3p68xYKJ5Pln3e6gmGz2LPohAYuBL6InZD3rMh8mzSHrPB5h2pou+V5jKlry9QSDyh
	 jGjDsmRkhVxxegmwWVnE1wqI=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3037:20b:53e8:6ccf:ad1c:d318:e478])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9E01D40E01F6;
	Sat, 26 Apr 2025 11:08:52 +0000 (UTC)
Date: Sat, 26 Apr 2025 14:08:46 +0300
From: Borislav Petkov <bp@alien8.de>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
CC: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Kees Cook <kees@kernel.org>,
 bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr
Subject: =?US-ASCII?Q?Re=3A_=5BRFC=5D=5BPATCH_1/2=5D_k?=
 =?US-ASCII?Q?thread=3A_Add_is=5Fuser=5Fthr?=
 =?US-ASCII?Q?ead=28=29_and_is=5Fkernel=5Fthread=28=29_helper_functions?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250425204313.616425861@goodmis.org>
References: <20250425204120.639530125@goodmis.org> <20250425204313.616425861@goodmis.org>
Message-ID: <26F4E8D1-4DDF-48EC-AE21-478EDF4C65C3@alien8.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 25, 2025 11:41:21 PM GMT+03:00, Steven Rostedt <rostedt@goodmis=2E=
org> wrote:
>From: Steven Rostedt <rostedt@goodmis=2Eorg>
>
>In order to know if a task is a user thread or a kernel thread it is
>recommended to test the task flags for PF_KTHREAD=2E The old way was to
>check if the task mm pointer is NULL=2E
>
>It is an easy mistake to not test the flag correctly, as:
>
>	if (!(task->flag & PF_KTHREAD))
>
>Is not immediately obvious that it's testing for a user thread=2E
>
>Add helper functions:
>
>  is_user_thread()
>  is_kernel_thread()
>
>that can make seeing what is being tested for much more obvious:
>
>	if (is_user_thread(task))
>
>Link: https://lore=2Ekernel=2Eorg/all/20250425133416=2E63d3e3b8@gandalf=
=2Elocal=2Ehome/
>
>Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis=2Eorg>
>---
> include/linux/sched=2Eh | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/include/linux/sched=2Eh b/include/linux/sched=2Eh
>index f96ac1982893=2E=2E823f38b0fd3e 100644
>--- a/include/linux/sched=2Eh
>+++ b/include/linux/sched=2Eh
>@@ -1785,6 +1785,16 @@ static __always_inline bool is_percpu_thread(void)
> #endif
> }
>=20
>+static __always_inline bool is_user_thread(struct task_struct *task)
>+{
>+	return !(task->flags & PF_KTHREAD);
>+}
>+
>+static __always_inline bool is_kernel_thread(struct task_struct *task)
>+{
>+	return task->flags & PF_KTHREAD;

return !is_user_thread(task);

or the other way around=2E=20

=F0=9F=99=82

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

