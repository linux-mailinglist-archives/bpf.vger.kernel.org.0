Return-Path: <bpf+bounces-62927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27CCB006C2
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 17:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AC96428DA
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E542750E2;
	Thu, 10 Jul 2025 15:30:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427B82749C3;
	Thu, 10 Jul 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161459; cv=none; b=HwBxV9vVAbJo3qsVicmWE11ZlG/FW+CKYGzpjxuva346gXAuaJksJH1BMAIX2Ca28gnT0ChlR+XKsNyRoIz+lVK1bjsuHM/kvQLccY6dskvlcqEcympJabbrAFmj6jA+OIVObvEUmbPbnpq0GajZLFSVS1zT509n3sDhc0taEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161459; c=relaxed/simple;
	bh=XiSsCFRTD5cMvXe2s6h4lB41KvWkOyNafNn/I1We6II=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeTSKfLyn2Be/ov8QeNmk6XChcM7xdryWdZ9800mG7gDcLoxtxjxY5K9nfZxdFDOXG4mHzR6JjmGH5VGF7qHdEvaAR2tZ22IhJKcDCTrRsfYOY69hEqsSzkKRhtLlzGw/LmHdbIwlkwZLUNxDDJ3aEsu7HcvbC61sIpXJLCsBOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 1609F16031C;
	Thu, 10 Jul 2025 15:21:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id C26DE17;
	Thu, 10 Jul 2025 15:21:48 +0000 (UTC)
Date: Thu, 10 Jul 2025 11:21:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [PATCH v13 02/14] unwind_user: Add frame pointer support
Message-ID: <20250710112147.41585f6a@batman.local.home>
In-Reply-To: <d3279556-9bb6-429d-a037-fe279c5e3c67@linux.ibm.com>
References: <20250708012239.268642741@kernel.org>
	<20250708012357.982692711@kernel.org>
	<d3279556-9bb6-429d-a037-fe279c5e3c67@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C26DE17
X-Stat-Signature: 9a67qtwtzs3whei6qbk91ijegsrfjhby
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19s3JFU+AFOGAbq0yjNp84acB8tAlaKeEc=
X-HE-Tag: 1752160908-914413
X-HE-Meta: U2FsdGVkX1+mXnZuaaZaBfszAwdxFee1skDRxqvogXueGUBIv8TsRQqSv9byQILZgjsvvkaUymcAJ4XaGth3Hmnsni25KaBGMq6TUjRf9x63gQvm3NRJQfn7YdH6YrWou1imbDLBZGtWuJsLosIsoFZVk3NLH9GbcN7owtOGg7n38pMV7OUK8sfHZ5rU0kfeRsBxl01icuhpbhEhOm3c9v0Ah0eh5ivVUTLjMzyzrPvJYXOJR5SyvtBXbZKTMmNvboigFyKZmLb+AXQ9oaDv2dzIWzM91rtQI9Cj0qQov6mfSKrUO6GTSQZ08/ztAZ7kFuIaperrrFsM7BUWaziz6TjpVBtklDf1

On Wed, 9 Jul 2025 12:01:14 +0200
Jens Remus <jremus@linux.ibm.com> wrote:
> >  static int unwind_user_next(struct unwind_user_state *state)
> >  {
> > -	/* no implementation yet */
> > +	struct unwind_user_frame *frame;
> > +	unsigned long cfa =3D 0, fp, ra =3D 0;
> > +	unsigned int shift;
> > +
> > +	if (state->done)
> > +		return -EINVAL;
> > +
> > +	if (fp_state(state))
> > +		frame =3D &fp_frame;
> > +	else
> > +		goto done;
> > +
> > +	if (frame->use_fp) {
> > +		if (state->fp < state->sp) =20
>=20
> 		if (state->fp <=3D state->sp)
>=20
> I meanwhile came to the conclusion that for architectures, such as s390,
> where SP at function entry =3D=3D SP at call site, the FP may be equal to
> the SP.  At least for the brief period where the FP has been setup and
> stack allocation did not yet take place.  For most architectures this
> can probably only occur in the topmost frame.  For s390 the FP is setup
> after static stack allocation, so --fno-omit-frame-pointer would enforce
> FP=3D=3DSP in any frame that does not perform dynamic stack allocation.

=46rom your latest email, I take it I can ignore the above?

>=20
> > +			goto done;
> > +		cfa =3D state->fp;
> > +	} else {
> > +		cfa =3D state->sp;
> > +	}
> > +
> > +	/* Get the Canonical Frame Address (CFA) */
> > +	cfa +=3D frame->cfa_off;
> > +
> > +	/* stack going in wrong direction? */
> > +	if (cfa <=3D state->sp)
> > +		goto done;
> > +
> > +	/* Make sure that the address is word aligned */
> > +	shift =3D sizeof(long) =3D=3D 4 ? 2 : 3;
> > +	if ((cfa + frame->ra_off) & ((1 << shift) - 1))
> > +		goto done; =20
>=20
> Do all architectures/ABI mandate register stack save slots to be aligned?
> s390 does.

I believe so.

>=20
> > +
> > +	/* Find the Return Address (RA) */
> > +	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
> > +		goto done;
> > + =20
>=20
> Why not validate the FP stack save slot address as well?

You mean to validate cfa + frame->fp_off?

Isn't cfa the only real variable here? That is, if cfa + frame->ra_off
works, wouldn't the same go for frame->fp_off, as both frame->ra_off
and frame->fp_off are constants set by the architecture, and should be
word aligned.

-- Steve

>=20
> > +	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + fram=
e->fp_off)))
> > +		goto done;
> > +


