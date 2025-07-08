Return-Path: <bpf+bounces-62706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6CFAFD7F1
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 22:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7C01893726
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 20:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023EC23D290;
	Tue,  8 Jul 2025 20:11:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089267464;
	Tue,  8 Jul 2025 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005493; cv=none; b=A2OcLUjfz74BCyLcqRTbY2CDD60keINI3+6PtjUw6FOTti6a3rUNTW/oHHnlJSAD0jqzOuBzwZEbFgv4NpJAUCCcNKfrPLPM1Jp8TGf9iiZ03gG0D+1xLY4c+SlomnQPgVN8mVjYdbSuv7IB0IK/0q4AbV+8Z0D2BqPLFFd2oHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005493; c=relaxed/simple;
	bh=fNYmNdrfWDR3qFw2aIqlP4mKYgW1cvAJ6DWnTm12UHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4lKjyYzmzv3P9ApAIDYy0cG1Lb0xkXe3BMaLzNRGw9sK0oOuvCXwND4h6t2gfVIB1Zw74y7dlsrsPxZHA0pxg+srpNGBAIcuvZbZj+DjE5v9640E+c0SilhJ8TnYKZWYR0NGrfxqcHitX1IO8JKaneuyZ1pi2pW9xY15OO8p4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 2C98D1601EA;
	Tue,  8 Jul 2025 20:11:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 8A1A52002B;
	Tue,  8 Jul 2025 20:11:23 +0000 (UTC)
Date: Tue, 8 Jul 2025 16:11:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>
Subject: Re: [PATCH v8 06/12] unwind_user/sframe: Wire up unwind_user to
 sframe
Message-ID: <20250708161124.23d775f4@gandalf.local.home>
In-Reply-To: <d7d840f6-dc79-471e-9390-a58da20b6721@efficios.com>
References: <20250708021115.894007410@kernel.org>
	<20250708021159.386608979@kernel.org>
	<d7d840f6-dc79-471e-9390-a58da20b6721@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8A1A52002B
X-Rspamd-Server: rspamout02
X-Stat-Signature: z4kuexq43jkzca874nwfhqjexqg3uoar
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/gb7+/LpuJYeY9wyOM0qcEfMTETAnu92c=
X-HE-Tag: 1752005483-521339
X-HE-Meta: U2FsdGVkX1/CaGf+4/87+CJDDzOW33IhrAh44BHrQ9odA+n+1NU9Aq2JW1nGD8UDn1xb0J9caWhhiNMUc54C5prtVOQs5ksx0o/lP/iXZkOyOPSTrn80fFHXAqFYbxlMoeqiKXuNjCySP2juh9VW2xDJAxcaHZjvbM4VzYtOtw3MyCDuCUiJqZ1sn2QibW45ylzb1FWmje4HfCuSIFHsHU71UE6Sr7IuHy13m6p2QEgL/4c7rhMA50dhJoWL/RjKgDML0lqcywuJd0R/15O/eh35eBwJPQ6iSNv6mfefY86dVpXrfl+sMA7ySOzch7yowVP5n4+Fj04blLvukX7+uN4j3k5X2xlYO7S3DK4BywfSsBa7r9qyu66S277HPhaA

On Tue, 8 Jul 2025 15:58:56 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > @@ -111,6 +128,8 @@ static int unwind_user_start(struct unwind_user_sta=
te *state)
> >  =20
> >   	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) && in_compat_mode(=
regs))
> >   		state->type =3D UNWIND_USER_TYPE_COMPAT_FP;
> > +	else if (current_has_sframe())
> > +		state->type =3D UNWIND_USER_TYPE_SFRAME; =20
>=20
> I think you'll want to update the state->type during the
> traversal (in next()), because depending on whether
> sframe is available for a given memory area of code
> or not, the next() function can use either frame pointers
> or sframe during the same traversal. It would be good
> to know which is used after each specific call to next().

=46rom my understanding this sets up what is available for the task at the
beginning.

So once we say "this task has sframes" it will try to use it every time. In
next we have:

	if (compat_fp_state(state)) {
		frame =3D &compat_fp_frame;
	} else if (sframe_state(state)) {
		/* sframe expects the frame to be local storage */
		frame =3D &_frame;
		if (sframe_find(state->ip, frame)) {
			if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
				goto done;
			frame =3D &fp_frame;
		}
	} else if (fp_state(state)) {
		frame =3D &fp_frame;
	} else {
		goto done;
	}

Where if sframe_find() fails and we switch over to frame pointers, if frame
pointers works, we can continue. But the next iteration, where the frame
pointer finds the previous ip, that ip may be in the sframe section again.

I've seen this work with my trace_printk()s. A function from code that is
running sframes calls into a library function that has frame pointers. The
walk walks through the frame pointers in the library, and when it hits the
code that has sframes, it starts using that again.

If we switched the state to just FP, it will never try to use sframes.

So this state is more about "what does this task have" than what was used
per iteration.

-- Steve

