Return-Path: <bpf+bounces-64906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F5BB18551
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A8DA82790
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1A927AC4B;
	Fri,  1 Aug 2025 15:56:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B087B271471;
	Fri,  1 Aug 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063796; cv=none; b=adogNEUWI0XtXr4vfgaKIGfUrfEix6VMUGAxc2MpEnB/kwpBwKSG6X9b3smLP6PN48a012LbAmogLBr3/C1qr2YkoVnaiTw5xdzNiN7dEHh3lV9R8kEUqpC3Fqsy4AOYd38vQGQEL28khSIhqposZLmkpLZRq5NwDyIdBIafn8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063796; c=relaxed/simple;
	bh=rOlclQzf0MpdDr28TdB3p6yVIA0DUsE5KtkQqdIlTmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXfaBLnb3Zwqj+Ph79niI7xR4Oj5hKQU4KAp0VrUlbGsDXO6jORSg0+Dk0/kbRz17BvpUAW7VS19rOyNi7cLtSrZ/gXMDbStFTX/ERwPSI+xD4hpb1K+FqmZkxFmCReIjkJQnRocO44+lxXpO6h+LJZ7p8DR/cWp/PwJvWnJhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 93C82803D1;
	Fri,  1 Aug 2025 15:56:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 9B8B220029;
	Fri,  1 Aug 2025 15:56:28 +0000 (UTC)
Date: Fri, 1 Aug 2025 11:56:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH] btf: Simplify BTF logic with use of __free(btf_put)
Message-ID: <20250801115649.0b31f582@gandalf.local.home>
In-Reply-To: <CAP4=nvSNeviiHg89L3dB9pGzi4Obf_s=bWJ8v89Q-fsJbuqymQ@mail.gmail.com>
References: <20250801071622.63dc9b78@gandalf.local.home>
	<CAADnVQLky+R-tfkGaDo-R_-tJ8E3bmWz8Ug7etgTKsCpfXTSKw@mail.gmail.com>
	<20250801110705.373c69b4@gandalf.local.home>
	<CAADnVQLFLSwrnHKZUtUpwQ1tst71AfYCcbbtK2haxF=R9StpSw@mail.gmail.com>
	<20250801111919.13c0620e@gandalf.local.home>
	<CAADnVQJnTqXLNT9YWWkpLqjxw7MGMrq_CTT7Dhb__R0uO2-COA@mail.gmail.com>
	<CAP4=nvSNeviiHg89L3dB9pGzi4Obf_s=bWJ8v89Q-fsJbuqymQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: rpsw9hw7g9bc5n6ubxi6p5tot8a6r4to
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 9B8B220029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18tRMsEs6gIm+onxM9f8CgANtnmJYTEijc=
X-HE-Tag: 1754063788-626321
X-HE-Meta: U2FsdGVkX1+Gr69W3MyGy6UZYPyUz65OhHUD3NIjt4gUFiq2d20/gO9X2AJJljJeTSTLRz1REeOLyr5eUkmhf7e+XKhNoMBAX7ZqQ/FyKaGZoqLsyiEFVE/d260oYr5Lv+YFMefScUQHzqewUCV2sKpBQN4sbH61H5zPuXKf7oIO55Lrm7yjtBsxhDSC3Eve9DtiIjs73OijkKCXLEU3pIO48jMjUC1x8T4LZ6pZS0oo0InmPPuEXD9oKHkh0Y29XcDKBvqy0+r1ITqfSubbA9peXyyBvEicfACApVlXZoruv8gTOPO5V77pvl8zkdUm4IiIL841eHqrYJ3oN3uQdo/rIl5Zv2ruB6j5I6Bjw+xfkrwq9GwAnw==

On Fri, 1 Aug 2025 17:34:51 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> p=C3=A1 1. 8. 2025 v 17:29 odes=C3=ADlatel Alexei Starovoitov
> <alexei.starovoitov@gmail.com> napsal:
> >
> > but __free() is imo garbage. It's essence of what's wrong with C++
> > =20
>=20
> Here, you at least can read the beginning of the function though, and
> see that a free will be done at the end, like Go's defer, right?

I don't know Go, but I'll assume "yes".

I prefer the __free() over goto end; where you need to free up a temporary
variable on error paths.

But regardless. This will just be a difference of opinion, and I respect
that Alexei doesn't want to use it in his code.

-- Steve

