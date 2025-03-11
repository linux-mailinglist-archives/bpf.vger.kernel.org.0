Return-Path: <bpf+bounces-53846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC58DA5CAAF
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 17:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483877A5FE6
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F7125EFBC;
	Tue, 11 Mar 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EDLIcF3Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QLgJlvp+"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F94425BAD4
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710065; cv=none; b=gsUbVTdd1v2uWoj8TvUT0qSH5jg8Nzhuub33iXRjR0cVrmdTP8G61+WyVGtixhe5C7Wqln5cXyiRGX3tn4jv74sNPqz0wD3MGOWdis4jst1zF0TCv1GkMk1XzhsCsjJpIKGqxOBSAGhvn92CXbpo0ueQxWdKDYlIXKDf58We2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710065; c=relaxed/simple;
	bh=TFOxrLrTdAiZA3HKuYA+JJO+csdfiT+cFTI/ComoFYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thtHeffqfeCUerUg12mfX5QEVTh7RJfSORLllWSBP7pmPp1rhFAw6qfW7oukINutX7c0t4eIyvqJYbmFJ8xz0kOIJdf925F+IJilWuX2FZyJ0y+SM/GvQ/7pYVlsrCtehWib4w2VuST8T+vYDsMFMVWQcivQVC2qH4e5dE+/RRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EDLIcF3Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QLgJlvp+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Mar 2025 17:20:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741710061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idnFXAwrGeEWSsNe0E7zhElexsxSDEbSkKaAW2x51HA=;
	b=EDLIcF3Zswap0FRX/SVRYP5JW3JR6z01NFd8tiLAI0vFyL4tRQQiPt0SxesnWQIwUyj2j2
	56EYIvdjKmvNmX+wCb+TtS+AS2fMZwy5nNAtfh3QrEoPK06NzQHNKndxdwDw+8PoXi6tPJ
	qj5Ei+vdiQ3bJksEvOzH1q4JgH64U3WdVSIrM+9QBJe/76zNZ3XQmJOePlsxbmOBefkTCU
	nDkPgFnCon/o6BTfG8qFtOeMKYq5xal12R+SoTwUeP9aLaFAXZQm8YWcgGWU0SdyTuFs+i
	cv5N6c6EAScRY0GuImabi2eT7udjaPmYOTAW24j4GxeAqn12+ToBRylIWDaCXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741710061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idnFXAwrGeEWSsNe0E7zhElexsxSDEbSkKaAW2x51HA=;
	b=QLgJlvp+LNALSDwcB+B0SqQcTQC25eQ1KuRXqgmtsfJnTzrpLGR+CUJGTLf7kb4eUmgV+f
	azZ98u8VYFSoueBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
	peterz@infradead.org, vbabka@suse.cz, rostedt@goodmis.org,
	houtao1@huawei.com, hannes@cmpxchg.org, shakeel.butt@linux.dev,
	mhocko@suse.com, willy@infradead.org, tglx@linutronix.de,
	jannh@google.com, tj@kernel.org, linux-mm@kvack.org,
	kernel-team@fb.com
Subject: Re: [PATCH bpf-next v9 1/6] locking/local_lock: Introduce
 localtry_lock_t
Message-ID: <20250311162059.BunTzxde@linutronix.de>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-2-alexei.starovoitov@gmail.com>
 <oswrb2f2mx36l6f624hqjvx4lkjdi26xwfwux2wi2mlzmdmmf2@dpaodu372ldv>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <oswrb2f2mx36l6f624hqjvx4lkjdi26xwfwux2wi2mlzmdmmf2@dpaodu372ldv>

On 2025-03-11 16:44:30 [+0100], Mateusz Guzik wrote:
> On Fri, Feb 21, 2025 at 06:44:22PM -0800, Alexei Starovoitov wrote:
> > +#define __localtry_lock(lock)					\
> > +	do {							\
> > +		localtry_lock_t *lt;				\
> > +		preempt_disable();				\
> > +		lt =3D this_cpu_ptr(lock);			\
> > +		local_lock_acquire(&lt->llock);			\
> > +		WRITE_ONCE(lt->acquired, 1);			\
> > +	} while (0)
>=20
> I think these need compiler barriers.
>=20
> I checked with gcc docs (https://gcc.gnu.org/onlinedocs/gcc/Volatiles.htm=
l)
> and found this as confirmation:
> > Accesses to non-volatile objects are not ordered with respect to volati=
le accesses.
>=20
> Unless the Linux kernel is built with some magic to render this moot(?).

You say we need a barrier() after the WRITE_ONCE()? If so, we need it in
the whole file=E2=80=A6

Sebastian

