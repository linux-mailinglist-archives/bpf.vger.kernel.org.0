Return-Path: <bpf+bounces-61875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E95E0AEE5D7
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 19:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB28E1BC1E83
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159C02E3393;
	Mon, 30 Jun 2025 17:30:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD1292B35;
	Mon, 30 Jun 2025 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304636; cv=none; b=N+f2JI0vmByNeUbQSe1xErESJMgGkVubKqpmtW3/STBamoVJCY2G6ghCIU9WQS1xUsiSv/SXJMbGGNi/JXkJo8k7azThnniZE7fN0VKwY1HUQBDJjgPV8UWHTCqAuGjScZolt7NGsThuD8d42hjgP75b45vr4ZyGm6ooWBrNTWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304636; c=relaxed/simple;
	bh=ZZk1bTuR+eQdo+aXGtW3YKXo5ceds8+PLoRwsPMSE5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kY3KTQWnjiaVV2umTZX/qHNwBHuI1nbVcetBXkFENeGa1GipQ8N1iD4m0RN0KQOv9Z8rbEh86YiLwg15kPBF+i9Nf3hBbsFQEScwpSiI7Px9HpfZ7CK9Ea2/Jc8GNY+E6lC68ZpiVwd3vRPn5QaebBPJh9cZADzma63Spnd1hrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id F2A80BA72B;
	Mon, 30 Jun 2025 17:30:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 19EDA8000E;
	Mon, 30 Jun 2025 17:30:18 +0000 (UTC)
Date: Mon, 30 Jun 2025 13:30:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v11 00/14] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <20250630133016.0d2ee00d@batman.local.home>
In-Reply-To: <878ql9mlzn.fsf@oldenburg.str.redhat.com>
References: <20250625225600.555017347@goodmis.org>
	<878ql9mlzn.fsf@oldenburg.str.redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 19EDA8000E
X-Rspamd-Server: rspamout02
X-Stat-Signature: r9f65q6e9r51fnods6fc4aqhgd7unowy
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ZvsfPP75fXsfwixf2F8ZEisAyCWZ9X7U=
X-HE-Tag: 1751304618-698338
X-HE-Meta: U2FsdGVkX18ReyhwQGPDmiXIvcUbTrLh5g+d9tjEYO1dBSURbQFkC6Ort79EfoPKCMbNOX/OqUL0YnpJ50/UbSs1l0XJSYrzPhwZHh/fnD3uCAVAnPzXo49vbBdQcmiMYT3FbqrQUjAK6SKZNR13dcG2QRiwJ30/IRXyUjbQpb14EDuRBimRPWrEAapZtYp8tFV6Hd0x2vrpZJKpvibwtC4vgTYgiNyEnK4ZMxFt1gP8UjiVzOe/ZVuQW5Z/M9TONsOkxgfUtRH7s3TEGMLBporcLjZDnaPdtcL9ofrU12TIm9YyOPI+/XrzdL9jI56OoOIfsoHz8I9PHR35nLVLKMRnSYW7FDO04H4t91brqet6zScSnmMGMVrXktrXl00CMd73JQ9saw/fqasbWn2HNS+m0dQrBDMFsMHx6+84ayc=

On Mon, 30 Jun 2025 14:50:52 +0200
Florian Weimer <fweimer@redhat.com> wrote:

> * Steven Rostedt:
>=20
> > SFrames is now supported in gcc binutils and soon will also be supported
> > by LLVM. =20
>=20
> Is the LLVM support discussed here?
>=20
>   [RFC] Adding SFrame support to llvm
>   <https://discourse.llvm.org/t/rfc-adding-sframe-support-to-llvm/86900>
>=20
> Or is there a secone effort?

Not a second effort, but also discussed here:

 https://github.com/llvm/llvm-project/issues/64449

I know internally at Google, it's being worked on. One of the
motivations for getting LLVM to support sframes is to allow live kernel
patching on arm64. Live kernel patching is currently only supported on
x86 because it requires the ORC unwinder. Which is Josh's creation (and
works basically the same way as sframes do) to have reliable stack
traces in the kernel at run time. It's been stated that porting ORC to
other archs would be too much, but since sframes do basically the same
thing, and would support multiple architectures, then it makes sense to
use sframes instead of ORC.

>=20
> > I have more patches on top of this series that add perf support, ftrace
> > support, sframe support and the x86 fix ups (for VDSO). But each of tho=
se
> > patch series can be worked on independently, but they all depend on this
> > series (although the x86 specific patches at the end isn't necessarily
> > needed, at least for other architectures). =20
>=20
> Related to perf support: I'm writing up the SFrame change proposal for
> Fedora, and I want to include testing instructions.  Any idea yet what a
> typical =E2=80=9Cperf top=E2=80=9D or =E2=80=9Cperf report=E2=80=9D comma=
nd line would look like?

I'll be posting updated patches soon and will Cc you. I'll also include
git branches that contain the patches. You'll need the core patches
(what this patch set is), the perf updates and the sframe patches.

The perf patches contain both the kernel side and user space side to
update perf.

Note, to make sure sframes are working properly, I also add
"trace_printk()" into the code and make sure that the sframes code is
being executed and used (it falls back to frame pointers if they fail).

I'll post a patch that includes the trace_printk() that I use as well.
But obviously that wouldn't be something you would add to your
documentation. It's mostly FYI for you.

Hopefully I'll have them done either tonight or tomorrow.

-- Steve

