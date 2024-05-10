Return-Path: <bpf+bounces-29485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3873E8C290B
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81041F225B3
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434C8175AE;
	Fri, 10 May 2024 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHy06qxG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2796C18042
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715360646; cv=none; b=mgSr9bZaXxC1rZLY1MEwW7VlG09PQWrt4dlFe4gsyk4ttmXZzRibYEB71Y/zdDMggFoKbBLNg8GneaXzq51CV2Dqy3bWWfa9qxa9DIqOUyT/YAmWr8JBQ0BSnlDtdoyhIy9CJPKMPkmOs3cNATCLobc8o/pB/w1/c+rLiiCZr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715360646; c=relaxed/simple;
	bh=6B/enOU8H7RwdF0k7J3IEkhYWqG9Zw5pTe7tVofBjFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJHokP4HDY/SdVgjLWLB0LjcljjoM1V+SpYilHPvMXFye8+CwdVS56ZjiE782heq+vVID4mEjeSM7RQx74UYwgkA+Zo49b9J0/qp6LeTpKZsGN5biI9JOYFtF3+kkMhiqF0x3bLpXUzNtOY2NV5fWZ5tISzacNpBxRCpBODmprY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHy06qxG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34ef66c0178so1457255f8f.1
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715360643; x=1715965443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD3b6mkTLSQDS1Z1Zl4kWqyGeLySYiGcFmxePBdqWGY=;
        b=VHy06qxGByarwkqpOpH2iOMNTgpNsip0ICv3lWzCBD6t6uT0hDLsdQmVEO3CtA3270
         gGVpI5L2S2Lr+bHQjgRPcMEBeb87KAB//a+enDuK27TyLjBH+m2E5vnmxKzt9Eh3LeP4
         OA2hrhLPjBUD2hEVOnou1utoPsFRUPXU+pFBeqUxIgsbAH9t6ChfPBKg9pdNUfa5g6cx
         s34ph+/1QDD2BI7/3aWNrEbRN4E6rOz/YHZVJ42fjCVKCH44YbbdB2mVdW8o5XVcATKR
         /S9938JrUM1j5ja9pTmMmCPNv93x0uaeLtb8jPLLH9iUPv4RJWtkP90e8/KF+zb5Nr/F
         PKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715360643; x=1715965443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD3b6mkTLSQDS1Z1Zl4kWqyGeLySYiGcFmxePBdqWGY=;
        b=Ew7WLJJpeU9sMniCvW4cdUX30tpAa201HQ1nPdmkAfh6D0dvf/tmCHRoscGertyuDB
         56XLLi79w9DgA9JHnznsKuwbba/Z7nJVyEBq3KxoqrA4yQCysl6YV65d+nrSF993phLz
         Y3fFnPwsvSzRat1xyB9wxixDK7BS6SuICJAj7bBrySEtVxnTssSLhIzi6S2OoDBJXQVE
         INvzz4jtI9FKm4g5+q0JSGxWVyqp+AxgJDjDRVgGCcDCG2431XqmJEKaIcY3wrGqcfl4
         urB9iJR1HXbz2hq+RHUyYpvFsZpzeCbJLU0o7mTDhqUbFoEgm12piBddkxncyupNenVK
         Y+6A==
X-Gm-Message-State: AOJu0YwPz89wvEcjqut8GfAUdumR+NWcX+K2wsOiQ/+R9FfOkkGfiA0K
	/SLsPA6B/N/eGHFwhORiWAIi7DjIx4/51FQNfiDOPvHHSrbVReYXn0AvGb6l9GIxPjBEPd4AXPX
	rrF/JLT+mFXneR3TQlYUPjoDHLcQ=
X-Google-Smtp-Source: AGHT+IF2hNvQC09CXZtX0CEWrV7LOV3Rs8XlcA9J+Ochk3YJ/Spx+5dP6rreCID1tItVqrmrEtOaQ2LAHDof9omXoh8=
X-Received: by 2002:adf:fe04:0:b0:34d:939c:d022 with SMTP id
 ffacd0b85a97d-3504a631140mr2821542f8f.18.1715360643129; Fri, 10 May 2024
 10:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509084650.17546-1-jose.marchesi@oracle.com>
 <CAADnVQJRpCX+vmwCu3xYz+V4Bq1gn3vnCAZk3CAJcB3KUq_-Cg@mail.gmail.com> <874jb62ht9.fsf@oracle.com>
In-Reply-To: <874jb62ht9.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 May 2024 10:03:51 -0700
Message-ID: <CAADnVQ+-w1cD83mE0u0QhCP4cCvSSB1-GNoqErYRRhtxcwkTmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make list_for_each_entry portable
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, David Faust <david.faust@oracle.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 1:27=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Thu, May 9, 2024 at 1:47=E2=80=AFAM Jose E. Marchesi
> > <jose.marchesi@oracle.com> wrote:
> >> +/* A `break' executed in the head of a `for' loop statement is bound
> >> +   to the current loop in clang, but it is bound to the enclosing loo=
p
> >> +   in GCC.  Note both compilers optimize the outer loop out with -O1
> >> +   and higher.  This macro shall be used to annotate any loop that
> >> +   uses cond_break within its header.  */
> >> +#ifdef __clang__
> >> +#define __compat_break
> >> +#else
> >> +#define __compat_break for (int __control =3D 1; __control; --__contr=
ol)
> >> +#endif
> > ..
> >> +       __compat_break
> >>         for (i =3D zero; i < cnt; cond_break, i++) {
> >>                 struct elem __arena *n =3D bpf_alloc(sizeof(*n));
> >
> > This is too ugly. It ruins the readability of the code.
> > Let's introduce can_loop macro similar to cond_break
> > that returns 0 or 1 instead of break/continue and use it as:
> >
> >         for (i =3D zero; i < cnt && can_loop; i++) {
> >
> > pw-bot: cr
>
> I went with the ugliness because I was trying to avoid rewriting the
> loops in the tests, assuming the tests were actually testing using
> cond_break in these particular locations would result in a particular
> number of iterations.
>
> The loops
>
>   for (i =3D zero; i < cnt; cond_break, i++) BODY
>
> and
>
>   for (i =3D zero; i < cnt && can_loop; i++) BODY
>
> are not equivalent if can_loop implements the same logic than
> cond_break.

It's off by one and it's fine.
The loops don't and shouldn't expect the precise number allowed
by may_goto.

btw there are tests that use cond_break inside {}.
They don't need to change.

>
> The may_goto instructions are somehow patched at run-time, and in a
> predictable way since the tests are checking for explicit iteration
> counts, right?

They're patched by the verifier, but they're unpredictable.
Right now it's a simpler counter, but sooner or later
it will be time based.

