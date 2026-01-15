Return-Path: <bpf+bounces-79133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD54CD27DAD
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E29D3302197B
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C256D3D1CAF;
	Thu, 15 Jan 2026 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="euwpB91R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2483D1CA0
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503397; cv=none; b=FlqfGnz4A4ZU8hlpJWrDWXD9T3paHCmGVVOfqTYbCWrmg5XEoW6vKF+8gog71ZPGFRLjoBZ+OcvX2355B6lj7sMgoGGGXlN5Df87CeEyEiIeQvqzhObeV6DZUDotsSPeZRgGVzpf51BExkgAKA9/eN0t6jFuOed9cotiCBLEwrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503397; c=relaxed/simple;
	bh=J4zkXurDbsrUzAYPAJwe1QBjBQEtbVlJYztZol4aoBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpdg4tUXmKqZog5fydaGWmi0naMYH+LRsLV454r6aIruWyo6r9FVmHv7Ji8nUeurr+iXzCrVepscD6SDwZ1KgLFmLRuY/wVd8UtxTgZTDBowNpm+I1oxEMg1HjkiNYJ2wffpiX6ge+oDhnB2uufnZU62z+wc0qsgmgaazHjQz7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=euwpB91R; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1220154725fso910918c88.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768503395; x=1769108195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XWtamoostyQ4NanWf6fDJFMlUkHuc5eIgxHtPY9VwI=;
        b=euwpB91R+Xg/W5kNrqONySgAFTygppHqBYlApHFJgd4lrkpoh/iFfz4ZqIxdk+t5Fi
         UGKH2Hou1n90ywT3VttYT3kg16YIBxIwZTYM7QRnvuFz0HMZ+NZ2h6XTos9AGYBfLCDl
         QpgSBpljY5nJ6lX1NkpOr0z7r1sL3rqmnv7602xeVRRxULv1pLh5lDv22U7tke6xjeB/
         CSSlMyODL20C522NBXGyVxbpNsJaFaceZn68fTI177MitZ7j4IK3d3zHFqdzX8lUmF2q
         gOJwPE2AEN7LaE0wDse9gU3vt14vYa4rFgkG7oHnkBOWhwTH6hGraBIeXiyJN9Ykm1hY
         uanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503395; x=1769108195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6XWtamoostyQ4NanWf6fDJFMlUkHuc5eIgxHtPY9VwI=;
        b=O8n/KFHgXf7dJc6372DKCAM/TvNa+MYg9TPntG4EirXbVUl9WrazYwpHtDuiwfxFgj
         DlVSwIFCPxyPQI118R4ofEr0FvMSVjSQmdus+IITYW1CV8z8JavpHQGGbxZsNNO3HZIH
         2oUcRTeaeSmqXtmknnBwfd6sFdup8GIKRR9GMK2jqu2l0PPKePKcKQToAGIN9OttsRTl
         mtZF6xFk5M69G+iqziegCt/YfJAOKMJLW+oQ9vWBKWNYfLEjy5DvP6418GKhinOIjGXA
         StDB1/s0LBTUccS7Rpy86w9C4cLGuYejGLrCtz2XPYb7tgFbJFVuM9mYkBEmELZ9TjrM
         D4XA==
X-Forwarded-Encrypted: i=1; AJvYcCUh8dpGO4wLUe/UaT9gxNrpmIk0yqEwPJEPor8xS/ik94I14F+p5g7iKJBvJx/HdwB6AoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHy3tPEP9G7dyn5CsEb1ZetF9+9KUn0tnCxVVkeGwvR8SjHlP+
	wvjujzG+qq2zb3jHMMBD59uQ3Z6IcLTEP7PYdYS7r2M7+1LTXX9QQmoMbi0m4xE/rKR/0ckBZ7e
	p+n1bzmCV4mQcVU9lZw9hdoDD891BjPj2i5h3F+ca
X-Gm-Gg: AY/fxX4ndDTYEIZuTjEtmhOqDf06X9R7YFJlTrxjLvgOB6voDZbqAdSsFrKWz91EH5H
	EEVBlMmI9MvTU1Iga1BE+BjtebiE+lczzdgILO8jHTOW5luJejqJgYr67iTIblkwypYj1ZamUau
	P9N8/DtxoKg5aDaJMrP4PHvKZ3+zFnneIal6iA2k1P+Lfzyrn2K/hnTsgMhpXgNWtpTj1lJJE5y
	wOfz7s4LUuYqFzcR6iThQCRr1RcAEi8XAIEtjqAYBu1/59s6wxs4pXaL3ac8XO4LowVNAd+3mn+
	hEezCw20purpP9vcyj74NJORbYo=
X-Received: by 2002:a05:7022:926:b0:119:e569:f874 with SMTP id
 a92af1059eb24-1244ae994camr756803c88.17.1768503394364; Thu, 15 Jan 2026
 10:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114183808.2946395-1-alan.maguire@oracle.com>
 <20260114183808.2946395-2-alan.maguire@oracle.com> <CAEf4BzZruKmtcwK+V_qT8RcaXpp3=GXaZaiQtK4OchSR8Ye4Yg@mail.gmail.com>
 <5886e8c8-7646-4686-91b7-185cc953be20@oracle.com>
In-Reply-To: <5886e8c8-7646-4686-91b7-185cc953be20@oracle.com>
From: Marco Elver <elver@google.com>
Date: Thu, 15 Jan 2026 19:55:58 +0100
X-Gm-Features: AZwV_QiCB-51Uke67Wa-hZAtb59WtmZ-fOlJrrpyx7kymY6CLFLRPNaQsdq2GvE
Message-ID: <CANpmjNPJfmN57BsZknURkPG+1__1CsxW3zk+gpWS83c1diKstg@mail.gmail.com>
Subject: Re: KCSCAN and duplicate types in BTF [was Re: [PATCH bpf v2 1/2]
 libbpf: BTF dedup should ignore modifiers in type equivalence checks)]
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org, yonghong.song@linux.dev, 
	nilay@linux.ibm.com, ast@kernel.org, jolsa@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, bvanassche@acm.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Jan 2026 at 19:36, Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 15/01/2026 17:50, Andrii Nakryiko wrote:
> > On Wed, Jan 14, 2026 at 10:38=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>
> >> We see identical type problems in [1] as a result of an occasionally
> >> applied volatile modifier to kernel data structures. Such things can
> >> result from different header include patterns, explicit Makefile
> >> rules, and in the KCSAN case compiler flags.  As a result consider
> >> types with modifiers const, volatile and restrict as equivalent
> >> for dedup equivalence testing purposes.
> >>
> >> Type tag is excluded from modifier equivalence as it would be possible
> >> we would end up with the type without the type tag annotations in the
> >> final BTF, which could potentially lead to information loss.
> >>
> >> Importantly we do not update the hypothetical map for matching types;
> >> this allows us to match in both directions where the canonical has
> >> the modifier _and_ when it does not.  This bidirectional matching is
> >> important because in some cases we need to favour the modifier,
> >> and in other cases not.  Consider split BTF; if the base BTF has
> >> a struct containing a type without modifier and the split has the
> >> modifier, we want to deduplicate and have base type as canonical.
> >> Also if a type has a mix of modifier and non-modifier qualified
> >> types we want it to deduplicate against a possibly different mix.
> >> See the following selftest for examples of these cases.
> >>
> >> [1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@l=
inux.ibm.com/
> >>
> >> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++---------
> >>  1 file changed, 26 insertions(+), 9 deletions(-)
> >>
> >
> > Alan,
> >
> > I do not like this approach and I do not want to teach BTF dedup to
> > ignore random volatiles. Let's either work with KCSAN folks to fix
> > __data_racy discrepancy or add some option to pahole to strip
> > volatiles (but not by default, only if KCSAN is enabled in Kconfig)
> > before dedup (and thus we can't do that in resolve_btfids,
> > unfortunately; it has to go into pahole).
> >
>
> Okay, I think the former would be the better path if possible; cc'ed Marc=
o
> who introduced __data_racy with commit
>
> 31f605a308e6 ("kcsan, compiler_types: Introduce __data_racy type qualifie=
r")
>
>
> ...and Bart is already on the cc list. Feel free to include anyone
> else who might be able to help here.
>
> The background here is that in generating BPF Type Format (BTF)
> info for kernels we are hitting a problem since a few structures
> use __data_racy annotations for fields and these structures are compiled
> into both KCSAN and non-KCSAN objects. The result is some have a volatile
> modifier and some do not, and we wind up with a bunch of duplicated
> core kernel data structures as a result of the differences, and this
> creates problems for BTF generation.
>
> Perhaps one way out of this would be to have an unconditional __data_racy
> definition specific for struct fields
>
> #define __data_racy_field       volatile
>
> ...and use it for the two cases below?
>
> By having that defined regardless of whether KCSAN was enabled or not,
> and using it for struct fields (while leaving variables intact) we
> can sidestep the problem from the BTF side. Would that work from the
> KCSAN side and for the fields in question in general?
>
> > Furthermore, it seems like __data_racy is meant to be used with
> > *variables*, not as part of *field* declaration ([0]), so perhaps it
> > was a mistake to add those to fields. Note, there are just *TWO*
> > fields with __data_racy:
> >
> > include/linux/blkdev.h
> > 498:    unsigned int __data_racy rq_timeout;
> >
> > include/linux/backing-dev-defs.h
> > 174:    unsigned long __data_racy ra_pages;
> >
>
> Not sure, the original commit above gives a struct field annotation
> as an example. Anyway hopefully we can find a workable solution.

By "KCSAN enabled or not", I assume you mean in KCSAN kernels only? We
should _not_ define __data_racy as volatile outside KCSAN kernels, as
that's not what __data_racy is for and would have other unintended
consequences. KCSAN just knows to treat "volatile" specially, which is
why it's used like it is here, but otherwise explicit volatile
variables are a no-no in general.

Right now we have this in include/linux/compiler_types.h:

#ifdef __SANITIZE_THREAD__
... other defs that should remain untouched ...
# define __data_racy volatile
#else
...
# define __data_racy
#endif

But perhaps that should be moved to a separate #ifdef block:

#ifdef CONFIG_KCSAN
# define __data_racy volatile
#else
# define __data_racy
#endif

... with an explanation why (consistent definitions across
instrumented and uninstrumented source files), and why it's benign for
uninstrumented code in KCSAN kernels (behaviour unchanged, but subtle
performance loss, although it's an already instrumented kernel so
performance is moot anyway). I think that should work, but it needs
some testing.

Could you test something like that?

Thanks,
-- Marco

