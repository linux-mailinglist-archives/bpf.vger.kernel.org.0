Return-Path: <bpf+bounces-77212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37315CD24D3
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 02:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5093302DB5F
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 01:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB179257459;
	Sat, 20 Dec 2025 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BGDJHXsm"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4971339A4
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766193182; cv=none; b=Fu2L90ZuJTyrCLvzem2PHx3ucpGWxmWSQ+9XAWpoFJeoculZTRiE90VyylibBaatIcpAGcRUFrR0grh9KloGdVcj/YaYdRE6UWd3ASnt8ElGcrs3IK4L7clw2aVLyoLdgj46oY3N3xOB5KFyfDmIHJxVtbm+g7D1NRLcbp6dvE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766193182; c=relaxed/simple;
	bh=bcM5Uxjsmcm1Jd6vgHbr0jpv+c+NE27oaULZHHa3psk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbZU0wXxmD0595vZmynwNv/3N1k9IDGII7A+NHh6zzLstFpIJ6RR5oS8wk8AE31ldDLERCHYdLazJY6u21wO0Za2vlM+BGPzSihJMeTM0p5yzyu0GJdxMS+3fMaj2XqpcqFF3IybJthIjRwKpm8D8E+sUXmpGc+djfXmcG/7nVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BGDJHXsm; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766193178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcM5Uxjsmcm1Jd6vgHbr0jpv+c+NE27oaULZHHa3psk=;
	b=BGDJHXsm5+8Pho9Qno6FGfschMqUt6W9L7KFUVGxNoz8LcNLRqGdZIDLGmZz0mW0Q4FhTd
	3yfyLEREXoLmTmfVDS9xEJ+vdymf5hKxLItVqlT+vqBbPzHJ+43C9x0YVDUdk3tLAQDpCz
	d4B1zpNmjNcmRteOnc0/5StEgMoWyxU=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 andrii@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/9] bpf: tracing session supporting
Date: Sat, 20 Dec 2025 09:12:37 +0800
Message-ID: <2393471.ElGaqSPkdT@7950hx>
In-Reply-To:
 <CAEf4BzYm3=zzmCRg3zr1F99sBkxEZ_pDgjtKMBurb9LGu6JJKQ@mail.gmail.com>
References:
 <20251217095445.218428-1-dongml2@chinatelecom.cn> <1943128.tdWV9SEqCh@7940hx>
 <CAEf4BzYm3=zzmCRg3zr1F99sBkxEZ_pDgjtKMBurb9LGu6JJKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/12/20 00:55, Andrii Nakryiko wrote:
> On Thu, Dec 18, 2025 at 5:18=E2=80=AFPM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> > On 2025/12/19 08:55 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > > On Wed, Dec 17, 2025 at 1:54=E2=80=AFAM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> > > >
> > > > Hi, all.
> > > >
> > > > In this version, I combined Alexei and Andrii's advice, which makes=
 the
> > > > architecture specific code much simpler.
> > > >
> > > > Sometimes, we need to hook both the entry and exit of a function wi=
th
> > > > TRACING. Therefore, we need define a FENTRY and a FEXIT for the tar=
get
> > > > function, which is not convenient.
> > > >
> > > > Therefore, we add a tracing session support for TRACING. Generally
> > > > speaking, it's similar to kprobe session, which can hook both the e=
ntry
> > > > and exit of a function with a single BPF program. Session cookie is=
 also
> > > > supported with the kfunc bpf_fsession_cookie(). In order to limit t=
he
> > > > stack usage, we limit the maximum number of cookies to 4.
> > > >
> > > > The kfunc bpf_fsession_is_return() and bpf_fsession_cookie() are bo=
th
> > > > inlined in the verifier.
> > >
> > > We have generic bpf_session_is_return() and bpf_session_cookie() (that
> > > currently works for ksession), can't you just implement them for the
> > > newly added program type instead of adding type-specific kfuncs?
> >
> > Hi, Andrii. I tried and found that it's a little hard to reuse them. The
> > bpf_session_is_return() and bpf_session_cookie() are defined as kfunc, =
which
> > makes we can't implement different functions for different attach type,=
 like
> > what bpf helper does.
>=20
> Are you sure? We certainly support kfunc implementation specialization
> for sleepable vs non-sleepable BPF programs. Check specialize_kfunc()
> in verifier.c

Ah, I remember it now. We do can use different kfunc version
for different case in specialize_kfunc().

>=20
> >
> > The way we store "is_return" and "cookie" in fsession is different with
> > ksession. For ksession, it store the "is_return" in struct bpf_session_=
run_ctx.
> > Even if we move the "nr_regs" from stack to struct bpf_tramp_run_ctx,
> > it's still hard to reuse the bpf_session_is_return() or bpf_session_coo=
kie(),
> > as the way of storing the "is_return" and "cookie" in fsession and kses=
sion
> > is different, and it's a little difficult and complex to unify them.
>=20
> I'm not saying we should unify the implementation, you have to
> implement different version of logically the same kfunc, of course.

I see. The problem now is that the prototype of bpf_session_cookie()
or bpf_session_is_return() don't satisfy our need. For bpf_session_cookie(),
we at least need the context to be the argument. However, both
of them don't have any function argument. After all, the prototype of
different version of logically the same kfunc should be the same.

I think it's not a good idea to modify the prototype of existing kfunc,
can we?

>=20
> >
> > What's more, we will lose the advantage of inline bpf_fsession_is_return
> > and bpf_fsession_cookie in verifier.
> >
>=20
> I'd double check that either. BPF verifier and JIT do know program
> type, so you can pick how to inline
> bpf_session_is_return()/bpf_session_cookie() based on that.

Yeah, we can inline it depend on the program type if we can solve
the prototype problem.

Thanks!
Menglong Dong


>=20
> > I'll check more to see if there is a more simple way to reuse them.
> >
> > Thanks!
> > Menglong Dong
> >
> > >
[...]
> >
> >
> >
> >





