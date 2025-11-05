Return-Path: <bpf+bounces-73551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A35C3391A
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 01:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE613AA08A
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 00:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406F52459D9;
	Wed,  5 Nov 2025 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHGL+O7n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679E223B63E
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304270; cv=none; b=jG2jLgaNcPRkjqLA/0KozP6WbUw+cEwY3mfURLbBVdxNFhTbEFUKgazs9nbK5rqLCHSDlYflHsPXLjgaFVQkbYacGvhhYeiFJeGjCW05XNry2CmO2QY/H3UTp1h0Crl4YjimXCJXKbjurHQVCv/1GS+Ww3sGGyk273lBkTLxfIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304270; c=relaxed/simple;
	bh=MdCs5/Ukb2AiV8T8Ct9yHZ0Zi/cWXw8zLLtAtOC4IKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uS/fDdkxpbK81RnXbfHowpH/QYpRt7zEunI0stUx3BGHQzjoW+SezY9WLNBIbpbvaRp9yngyKJNvU4ofgD+HbxqRc5DDnRZKKliAQONChwM9qC4W3M1cV4Gy0FMU2WQBaNPpbETtNKBg2r44TZX4gGXdoHy19cuP/TaBFn1WsOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHGL+O7n; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso412110a91.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 16:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762304269; x=1762909069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro4he9b99RaQOSRLzbgYwUyzMh6pfOVPB3Dy70tnakU=;
        b=LHGL+O7nhEvGgJYOvoXf7SgUJoAkMXPHlF5eLKFIOV+FuOPyhEH2t+VAP1IU+QoLcO
         bIVkmHCuJWe+wxTsHHTgNOTXX4J1rmqTTg7MsaO5CqSX5fv6MmzS0FcqeEtzNXJt4jIO
         2UeWer15YirGVyag+JN5+Vlkd1GFH+0TM6tcjeDNv/bfLZucXztJDTQDOFoDgIsNopvL
         s429AWamVPhGeyCweo6G7zEwlR3/8TAV1v9WnbUhhRuqNSlgZSljB0I/McgPbCmG315c
         Gsy76uU+WFGOAnE7DKx+UneNjOWvziVwJnTkeotHyz4U5B8407hS/Neorol4CwdIXaDz
         DT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762304269; x=1762909069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ro4he9b99RaQOSRLzbgYwUyzMh6pfOVPB3Dy70tnakU=;
        b=LsEAc5CdOIP23hrrXHDp89hDYsWmxLYIOPbWa+RTsKJe/+CZ54qzcBwelQs1coplTV
         zFjizVkOdzpZ/WQ7AudlGXRNIdUdLb0yXQ5cNCaZCtvTjZzjPXv/Wr7zTrIzFpTDa/T3
         uw/m9chbtKC62bmcc9wNdq4N1dGWQ2sdssuihRmar9PAD3CFho5OXvoLxx+SXDahxAhs
         1p+0ecSQXwDxgy+MCl/l5MieWkcUCDzKGfRe5Z4bz3bg4RguSYu/SXJw1PoXChsMk3fR
         WWBj8C6deFg3YODExsCD5H2hw+40EMyHZlG8bI8vRHiByhkI6HEIfxGKEiRb+rZ+OXQi
         uC7A==
X-Forwarded-Encrypted: i=1; AJvYcCU1A5R4yZYOeE0XfYyNNaRvpXbmPTUhpvHiWxJhDtabT7ESQqifuk2uVAxcEquqlRRH/WA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3QQgbTKSjnPARP/9gJccYFvLWi7Ydb8UMfpQia7uI0g5OZL3R
	0i7yflGB98AKDN4i5xLF6X6ODKytaYXi/PgeMve5gbsK3/7awQnJum5IakjYiaqfp2HGggDOYkz
	ytscDtxSjQ5x4qaKTa71rlOni1AkcNug=
X-Gm-Gg: ASbGncvPCLXJqUwZBNhmDj3nZ8Uwq5h82M2vTVVJoF6CQ1mCl//OVtiuLwxzhCpZxwE
	31Rz6jqCSk9/mxp76LgdxUoN4zMS4bc0nkJwYY4vdt12wYYK87/fQaE1g1GHRSDsP8ujJZdQT+o
	6qszfB3qraM4v4hMtQpEN7+kQcGmoiZKxqqXTR+FoXD10weQ8vcz9QMi9b3h4R81dY42htHrhAX
	F3Ocg3j/HdAh+wj+m9rvZVGG8mIoWc8o83Y9BI4xEJGr/sfG2r02XkgbgZv0q3CV9xXTqUqWQFf
X-Google-Smtp-Source: AGHT+IEFdDYkeiVXHfThrLZ3qx4bTq8lAPvaIfTzJNX83e6CXSiN+WlPvB91awh7Q4S9g3BLKYiYgOKUfBksPKjO0jc=
X-Received: by 2002:a17:90b:1c07:b0:33b:dff1:5f44 with SMTP id
 98e67ed59e1d1-3417186b032mr5780776a91.6.1762304268661; Tue, 04 Nov 2025
 16:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-2-dolinux.peng@gmail.com> <CAEf4BzaPDKJvQtCss4Gm1073wyBGXmixv4s9V5twnF7uEHRhPg@mail.gmail.com>
 <61e92756ea7f202f2e501747b574e97b2f5bc32f.camel@gmail.com>
In-Reply-To: <61e92756ea7f202f2e501747b574e97b2f5bc32f.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 16:57:34 -0800
X-Gm-Features: AWmQ_bk5lOsda_VYeV8g_qd53ljF9BoUg6l_UY2pmI8-MVpQB5upLfcy09Rozbk
Message-ID: <CAEf4BzanAmmSe84GnvWSR_KLFVmeEvrxVVJAvApFNRjgeRXk8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/7] libbpf: Extract BTF type remapping logic into
 helper function
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 4:36=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > > @@ -3400,6 +3400,37 @@ int btf_ext__set_endianness(struct btf_ext *bt=
f_ext, enum btf_endianness endian)
> > >         return 0;
> > >  }
> > >
> > > +static int btf_remap_types(struct btf *btf, struct btf_ext *btf_ext,
> > > +                          btf_remap_type_fn visit, void *ctx)
> >
> > tbh, my goal is to reduce the amount of callback usage within libbpf,
> > not add more of it...
> >
> > I don't like this refactoring. We should convert
> > btf_ext_visit_type_ids() into iterators, have btf_field_iter_init +
> > btf_field_iter_next usable in for_each() form, and not try to reuse 5
> > lines of code. See my comments in the next patch.
>
> Remapping types is a concept.
> I hate duplicating code for concepts.
> Similarly, having patch #3 =3D=3D patch #5 and patch #4 =3D=3D patch #6 i=
s
> plain ugly. Just waiting for a bug because we changed the one but
> forgot to change another in a year or two.

Tricky and evolving part (iterating all type ID fields) is abstracted
behind the iterator (and we should do the same for btf_ext). Iterating
types is not something tricky or requiring constant maintenance.

Same for binary search, I don't see why we'd need to adjust it. So no,
I don't want to share code between kernel and libbpf just to reuse
binary search implementation, sorry.

>
> [...]

