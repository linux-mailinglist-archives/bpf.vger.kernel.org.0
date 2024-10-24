Return-Path: <bpf+bounces-43110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627439AF561
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 00:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272A22824A4
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E092218328;
	Thu, 24 Oct 2024 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnO4zwME"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A072178FC
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808944; cv=none; b=i2s5CXWy/oAWRAeLMiYLTLbo/Lgpmn+gwR7M79N79wgWJMc4H4j+c9sr/nK1VNoQxSc/TpiwNXMNef9p2vesl0TOMl74eAEuScb5sJNq2GneihHEwRiiaoxO8iu9oYli1vEWkx0iYIei1G9aZyVEZ51gaewyt3bMnKckZPNrTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808944; c=relaxed/simple;
	bh=yIb4gN2E1EQO1b3riPGAK3KOk8/rNypZhYT+gBtZGwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBbTVZ5XzXoiJ1vqPN5P1xqIbNyRN6niTRY3hL55xeiHiDiRcEoIYLzT10aIuALURenkojequFeU2U3x2qkw7GftqW40SgBjk9/od9v4OcCt0pEYmXvQe2whKZb+gOdIp+/jOqRIMPaeElOyjqLC0K9U7AaXJ0mB2YQGCPnvonU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnO4zwME; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso14775145e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 15:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729808940; x=1730413740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrOozFp4lhDJsNqkXP1baFLggN7HXqoLrn1eitz9B/8=;
        b=dnO4zwMEbbc/9i4x+fv6IKBwsyrD2t1MChZYMTMgQE2Y6qgwH9Yyyc0uC+r+BCQ+iC
         6mxz8JV26nhsPPE0zyMKQWLj9+TypKIKf8WSMmuvVhZV47aAmGXeT8fAmRJJs/cOymEm
         G39K0eRayX7/tG4FvYqMmZqKo7ETXYfHV83GOgef0fyQEBfwkguHyES5CDBsiAZN3+g6
         6DhGzIujAKxBRDm4J7+tinxWewfN4FrV2W8KZRyRiXO9Gf9zc5Uiu5LSIcL08N28s6Cz
         AlMxNzvumueIqIi5QPKtpeCgWx7WYAXEAdQ5L8qfEkwCHf0IGMAqCOZW3OnPbsOVXX0q
         PnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808940; x=1730413740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrOozFp4lhDJsNqkXP1baFLggN7HXqoLrn1eitz9B/8=;
        b=HFi6oGn4YmrEwBhlIJRZvYCr3sNiIvjt5GXW8yqIjdTrZoruuwaHdmva6gPlCeNn4j
         N+DJG/2z8UtnT89GJgwADbruOY5b87DQA8TmcgG5V3xMJnHx99W8yIoUt94kYzuDTH8W
         Bhbn7fiXL0+n/5aVhpvhEuaM85slAAzzwNiMxTam4NROjiuOtuOAmSZNymfGmr1FLOv/
         4gwJeS6xG9/gnx09GuGnm+BvKNJ1UEr1SNxzoZScBnqCR0qXU2eWELXTutQ2ZsVG2jqV
         3WYIUPT7FHKSTKSJMDsLOrsCkAfJ7eWBEGXXO7/n8p96Wyoa1Ssm+Q8dq9WQ0O3ZSn6z
         ud/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4dgJKU6dIypoK+BKzU6UATT/O4FxexhSLMUsx/Z+A8oSI/mN1le34hOWxs8nW7v7c2mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmCefWTjfumQopMYiOtAkjufOwV4+QB+hfcxZ4oip4PYysLqOx
	FV25VffC4EhQXohA2ei5eb6VBKl3G//B63j+d1VnI5UQjbtF3lYUtE0kxoEkf7VkYuC3tuQT+Ho
	pAGPefMZ1H1gzdCy9wkgK7sNs4ds=
X-Google-Smtp-Source: AGHT+IEkD09GE/N1NPHdrFVWr8kl9dRI4uK0BonBNuwPlFuJGSYlz8KZuwWdXuo37acOAiPB/rE4OksviEXE3FI8kWU=
X-Received: by 2002:adf:f7cb:0:b0:37d:461d:b1ea with SMTP id
 ffacd0b85a97d-37efcf898d0mr4670043f8f.48.1729808940011; Thu, 24 Oct 2024
 15:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024205113.762622-1-vadfed@meta.com> <CAADnVQJnM5uu-Nu-okWTwDvbPQjiYTcVrX0mmP-JUhVOFxWDVw@mail.gmail.com>
 <3f6d2d9c7699a0bfcd245149502ed1c8945ac334.camel@gmail.com>
In-Reply-To: <3f6d2d9c7699a0bfcd245149502ed1c8945ac334.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Oct 2024 15:28:48 -0700
Message-ID: <CAADnVQKApKc=UBftjUuRVSpB9nb12fxmAM=3RviQvwF1umt21A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_get_hw_counter kfunc
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, X86 ML <x86@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 3:17=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-10-24 at 15:14 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > > @@ -16291,7 +16292,8 @@ static void mark_fastcall_pattern_for_call(st=
ruct bpf_verifier_env *env,
> > >                         return;
> > >
> > >                 clobbered_regs_mask =3D kfunc_fastcall_clobber_mask(&=
meta);
> > > -               can_be_inlined =3D is_fastcall_kfunc_call(&meta);
> > > +               can_be_inlined =3D is_fastcall_kfunc_call(&meta) && !=
call->off &&
> >
> > what call->off check is for?
>
> call->imm is BTF id, call->off is ID of the BTF itself.

it's actually offset in fd_array

> I asked Vadim to add this check to make sure that imm points to the
> kernel BTF.

makes sense.

is_fastcall_kfunc_call(&meta) && meta.btf =3D=3D btf_vmlinux && ..

would have been much more obvious.

