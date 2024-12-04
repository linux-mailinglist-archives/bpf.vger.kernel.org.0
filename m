Return-Path: <bpf+bounces-46121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BE29E4784
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 23:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC35163EB5
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDA819EED0;
	Wed,  4 Dec 2024 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZqqdANI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0BA19048D
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350130; cv=none; b=SW4gT90/II2dr705rn3XwqHeSC2A8uFhUBKeuIEjggoKmRHx64W4scTLvoEGCSaF8eiOp9W94903FpCJu+IJIj+5hI+Ax6mV+Cp8dcwY7aY7+sz44XEPIlhI3T3i4dBQOTRIM1FPCs5x9K3wXCYPEOBk0pA+l8viFO2DV2UA9mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350130; c=relaxed/simple;
	bh=BE9hL1J3ikmMYpo/naTfxbiyrVjNf2b+FeCzAapsoVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APxsZhe1XfVqrtiH+xSTrVTPoQ10cL7eYnwfVzGh0N/iYXVbLYdx/KUw68phXQcwYsbqYeie7BlXdT0SmDhNxGNZlwLiH9gaKUqBaPXXOjOawbqiZoCR0IQj37AHeJ5/OqZKk8bIpf91USCX6ZeGGuG0HjlySEvhEWGpgGmittM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZqqdANI; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-aa549d9dffdso26609066b.2
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 14:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733350127; x=1733954927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIoz8vo9INqg3KZPOecwkjm61xnKXhIqMqCEo71UuT4=;
        b=SZqqdANIAw1Ez73QBS+KDfO0D7WAAwJ7ZHLT78uF/PXYl/50RfLIPw4Sygd/raC2O3
         KKEj1E7LTT0xVoXfNh2CG2Y8mvl/f8H5tme17OdkjR07YZKoh2bUSUBPWCsrajQv/zdG
         5emSzV5S3WL5FLJGtOpQsaQhUxtwUwReFt1UpocgoeKlbhLHzS/JdRldjss14bhyNT6n
         5jw32/f9EZVjLKLIAIgssFsEGQwcKhhBTeU6wDZ7CSIYZNfIKPH3rV6PnJj0lDmwYMd/
         wjIdkSMYBfLl5Qomn7PSRQzg3XW2FCP9Fea1rvLisNDZNfgtVJkBHE2DrPbG+2m5D7V0
         Uj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733350127; x=1733954927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIoz8vo9INqg3KZPOecwkjm61xnKXhIqMqCEo71UuT4=;
        b=Pf7fSetJsO7rHM7broYMo35QDxkGNaF+72ZEd3HA3z+5Fc5vvJ55pwaOGfPtfZ5zwn
         vEQ7PIuYnRRlVum6hIOaXq1CWOsiShckrG9X1qQkURpilhOgQ0jePs1tQ6ZyPlYyNnc+
         0+jQecVUaX6vriXEmnXhabViVNynJ6TyRVQmPGNps7mFZMu74r2PlHoH5UvY9/qDyB3C
         Qez0GA7uS5woIHJK1l2ZjHfU+4gbF02IrxQlUfP7ff34iWRKlugXEm9TFWr24OhiXNrr
         aaWme2u3U7WrfDZ/7LUY7QsNUtMizM6O/tgLOrl5emkAMqYdh3buqlo5q6OzKEzv08KY
         yR/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUY5wT+vim9rXgdC5juvFHyFWkxv5PPATqKH0+6+ePAz4VQME72K9TdIMCa4mQE/ocYiAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1vxCesoXT7ouYO0ZuJCfKXdTxSqEzbZfS8jTfwFl3Vf6VeVS4
	7lEhCbzXJnkS5FkwpLRD4o1tKClXFV8oZwahQg05gAIX2kiaFtqPbhyRcsKz0q1CHUfuK4bWJNB
	CZnQIKsTbMTq/LbqaB5S8gu/lku0=
X-Gm-Gg: ASbGncu4gdjTcKQU9kTTAxE0DFCxVOX6rau/burjDKs0VASjy1E6WFIMsh0SxTdkHT9
	YFURpabYhqkII6LlxRimYmlSaqnrgdnL51reVArhaUYe04vs7ooJJw9wQpM4AyJus
X-Google-Smtp-Source: AGHT+IE3q3sutyKIg/HDtQjOl4lFIhU/lv/93QmYM08VNUbRSS9kVv3FhwyYxYGZbytlqejCndU0RNzzjZp1RLr6PNw=
X-Received: by 2002:a17:906:318d:b0:aa4:fc7c:ea6d with SMTP id
 a640c23a62f3a-aa5f7d15a96mr702114966b.17.1733350127072; Wed, 04 Dec 2024
 14:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204024154.21386-1-memxor@gmail.com> <20241204024154.21386-3-memxor@gmail.com>
 <f844604cb8f85688c9faf4bf0c6d5566eba5dcdb.camel@gmail.com>
 <CAP01T77v3ctFfT37iOfMm0XOqOD_bzfYuLcjnvT=JeokCZ=2BQ@mail.gmail.com>
 <CAP01T770rUveB4Toj_gU7Fy-SyyTr0EvaCBDTxdkGBz2bBBAzw@mail.gmail.com>
 <CAADnVQLa7ArR0ZSi_zERZxWCCvi6u6TdmOpfkveuRo_EwGqsQA@mail.gmail.com>
 <CAP01T77F4yoJYJ3CZ-zypGUSCCApsS2iGQ-EZiO2Pk0sw2e0Mg@mail.gmail.com>
 <ce15b00ac30c6cfba16f63e6c03018a59af8acb1.camel@gmail.com>
 <CAADnVQ+ObWEF4g_FVrwFJF4gnkmBB=4UcnGZV5jaJ3SffyG0HQ@mail.gmail.com> <4d96bbb0433d4fdd285b9fe12cdfe9259d8b929f.camel@gmail.com>
In-Reply-To: <4d96bbb0433d4fdd285b9fe12cdfe9259d8b929f.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 4 Dec 2024 23:08:10 +0100
Message-ID: <CAP01T761t46kRus1F6T75ORG53_rVJDmSurxXspO0bek1QK2YA@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add raw_tp tests for
 PTR_MAYBE_NULL marking
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Manu Bretelle <chantra@meta.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Dec 2024 at 22:37, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2024-12-04 at 13:13 -0800, Alexei Starovoitov wrote:
> > On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Wed, 2024-12-04 at 21:48 +0100, Kumar Kartikeya Dwivedi wrote:
> > >
> > > [...[
> > >
> > > (A) ----.
> > >         |
> > >         v
> > > > > > What this will do in both cases::
> > > > > > First, avoid walking states when off !=3D 0, and reset id.
> > > > > > If off =3D=3D 0, go inside mark_ptr_or_null_reg and walk all re=
gs, and
> > > > > > remove marks for those with off !=3D 0.
> > >
> > > (B) ----.
> > >         |
> > >         v
> > > > > That's getting intrusive.
> > > > > How about we reset id=3D0 in adjust_ptr_min_max_vals()
> > > > > right after we suppressed "null-check it first" message for raw_t=
p-s.
> > > > >
> > > > > That will address the issue as well, right?
> > > >
> > > > Yes (minor detail, it needs to be reset to a new id, otherwise we h=
ave
> > > > warn on maybe_null set but !reg->id, but the idea is the same).
> > > > Let's see what Eduard thinks and then I can give it a go.
> > >
> > > Sorry for delay.
> > >
> > > I like what Kumar is proposing in (A) because it could be generalized=
:
> > > there is no real harm in doing 'r2 =3D r1; r2 +=3D 8; r1 !=3D 0; ...'
> > > and what Kumar suggests could be used to lift the "null-check it firs=
t ..."
> > > restriction.
> >
> > I don't see how it can be generalized.
> > Also 'avoid walking states when off !=3D 0' is far from simple.
> > We call into mark_ptr_or_null_regs() with id =3D=3D 0 already
> > and with reg->off !=3D 0 for RCU and alloc_obj.
>
> I did not try to implement this, so there might be a devil in the details=
.
> The naive approach looks as below.
>
> Suppose we want to allow 'rX +=3D K' when rX is PTR_MAYBE_NULL.
> Such operations generate a set of pointers with different .off values
> but same .id .
> For a regular (non raw_tp) case:
> - dereferencing PTR_MAYBE_NULL is disallowed;
> - if there is a check 'if rY !=3D 0' and rY.off =3D=3D 0,
>   the non-null status could be propagated to each
>   register in a set (and PTR_MAYBE_NULL mark removed);
> - if there is a check 'if rY !=3D 0' and rY.off !=3D 0,
>   nothing happens, no marks are changed.

Yes, also I realized after some thinking that when rY with off !=3D 0 is
checked, it just needs to be a no-op (in context of this solution), we
don't need to remove it from the set. Later if rX with off =3D=3D 0
sharing the same id is checked rY should be marked not null.

>
> For a raw_tp case:
> - dereferencing PTR_MAYBE_NULL is allowed (as it is already);
> - the mechanics for 'if rY !=3D 0' and rY.off =3D=3D/!=3D 0 can remain th=
e same,
>   nothing is wrong with removing PTR_MAYBE_NULL marks from such pointers.

Yes, it can be generalized, this solution to generalize to all types
does not require the state forking approach, which is different.

It is getting late for me here so I will continue looking at this
tomorrow, but I can do this for raw_tp in this patch as a fix for the
warning.
Then, I can send a follow up doing it for all pointer types against
bpf-next where can continue discussion based on concrete code.

Alexei said he was giving the state forking a go in parallel (which is
much more involved and impact on veristat needs to be analyzed).

Anyhow, I will continue tomorrow. Let me know what you think.

>
> > 'avoid walking with off !=3D 0' doesn't look trivial.
> > It would need to be special cased to raw_tp and some other
> > conditions.
> > I could be missing something.
> >
> > Let's see how patches look.
> >
> > > However, as far as I understand, the plan is to fix this by generatin=
g
> > > two entry tracepoint states: one with parameter as null, another with
> > > parameter not-null (all combinations for every parameter).
> > > If that is the plan, what Alexei suggests in (B) is simpler.
>

