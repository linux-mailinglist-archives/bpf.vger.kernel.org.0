Return-Path: <bpf+bounces-60954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB966ADF101
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7CC3BA148
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF42EF29B;
	Wed, 18 Jun 2025 15:18:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC932EA724;
	Wed, 18 Jun 2025 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259932; cv=none; b=WifL6HUBw4rpMBGUJUfF7DS6QynG9jTkC8FcdElbdEsKLc/InBcj0MRrKmeijmQ9ddTkGfHfOBZLsL0d8/2fSNUqiUTVbEXlLbYeNUy9uj8DpYhb6C4lQize93hWtW7CXWxrzG++UyI2bAnr7BNAAtO5O9fYKJu8wdgu1WhFXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259932; c=relaxed/simple;
	bh=Gh0v9Sq6hmQCc+/tG7k5ip84sNa2fop55rBiVVgpsjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MT3Ja6yRfjzQgORfLo+V9NMOjV0rd115GM7/vw7Zp5rz1Q6E43bbLS4BYAX3jwIyI3/utC7VQNcGNEHeVXJlZtEKOXSiSyi1aKceaXBxGVPp+BuRYHr2cI0ytKY4hRG+WW75YFsxlCUgzkQqPyGffdec2BvHI4LGwvjezC1bI28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 43FEC80274;
	Wed, 18 Jun 2025 15:18:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 4F9602002D;
	Wed, 18 Jun 2025 15:18:33 +0000 (UTC)
Date: Wed, 18 Jun 2025 11:18:40 -0400
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
Subject: Re: [PATCH v10 03/14] unwind_user: Add compat mode frame pointer
 support
Message-ID: <20250618111840.24a940f6@gandalf.local.home>
In-Reply-To: <20250618134758.GK1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.261095906@goodmis.org>
	<20250618134758.GK1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4F9602002D
X-Stat-Signature: iafc33sogu1x5ojhjxzjmzhkj3hpyfpf
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/VEB1AvzoDBoRkcbB9Zv/Ta/DbqKl+qYw=
X-HE-Tag: 1750259913-886977
X-HE-Meta: U2FsdGVkX19EpqP1YJ80kg0CNMkxNA/Kh9qLyQ7T+tbirmYKyY0vcIrQ4tgy/RKET6sH6Vxc/H8/xdX/JnWYFdZ3P2HwQBnG5I3959ejJ7pM45pAo1qaIBek1rhoGosa+i3eKhLXlvIB//R1OUnMwqM32JvzzSDXO9PC6nCU51WERdLNiitNzjR+zZ042s0iKvueltSqNCmQBHFmHBpvBuFLx87wvyOi1HAUVfNMe+8D4w2/kvbwkwdJLLjC3qASe/D01mM/NsIpFOmrjd0RIVeoRtB7m2a/u27yoG0B/L5TUszvo1+Enx2FQeKWGXBJx83Ss2Xe6Ex2hMC1I1qxVGMACpZRrdhHhpMfPuPRdtbtZi4JhbYlxG98wr5lRaZrCJk06NIqi67xdM1BgDppD6cuC+sjKejiwMamyY//NgU=

On Wed, 18 Jun 2025 15:47:58 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jun 10, 2025 at 08:54:24PM -0400, Steven Rostedt wrote:
>=20
> > +#ifndef arch_unwind_user_init
> > +static inline void arch_unwind_user_init(struct unwind_user_state *sta=
te, struct pt_regs *reg) {}
> > +#endif
> > +
> > +#ifndef arch_unwind_user_next
> > +static inline void arch_unwind_user_next(struct unwind_user_state *sta=
te) {}
> > +#endif =20
>=20
> The purpose of these arch hooks is so far mysterious. No comments, no
> changelog, no nothing.

I'll add comments.

It's used later in the x86 compat code to allow the architecture to do any
special initialization or to handling moving to the next frame.

=46rom patch 14:

+#define in_compat_mode(regs) !user_64bit_mode(regs)
+
+static inline void arch_unwind_user_init(struct unwind_user_state *state,
+					 struct pt_regs *regs)
+{
+	unsigned long cs_base, ss_base;
+
+	if (state->type !=3D UNWIND_USER_TYPE_COMPAT_FP)
+		return;
+
+	scoped_guard(irqsave) {
+		cs_base =3D segment_base_address(regs->cs);
+		ss_base =3D segment_base_address(regs->ss);
+	}
+
+	state->arch.cs_base =3D cs_base;
+	state->arch.ss_base =3D ss_base;
+
+	state->ip +=3D cs_base;
+	state->sp +=3D ss_base;
+	state->fp +=3D ss_base;
+}
+#define arch_unwind_user_init arch_unwind_user_init
+
+static inline void arch_unwind_user_next(struct unwind_user_state *state)
+{
+	if (state->type !=3D UNWIND_USER_TYPE_COMPAT_FP)
+		return;
+
+	state->ip +=3D state->arch.cs_base;
+	state->fp +=3D state->arch.ss_base;
+}
+#define arch_unwind_user_next arch_unwind_user_next

-- Steve

