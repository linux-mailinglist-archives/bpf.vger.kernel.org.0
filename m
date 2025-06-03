Return-Path: <bpf+bounces-59512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C4EACCA52
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 17:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E873A3AA3
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E11123C513;
	Tue,  3 Jun 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="27ezcxZ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC5B140E34
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965178; cv=none; b=jQdgHgRm5b/CRSmeAt4oVn3j6wqlMvYjxAKXZ0TcugjXjyDmynXvq7EeFqQ3zuU1hQehBQzjO6zHZsyBTqRIFCjgVGUF82Mdku8eK4p6yhdsvNUODjmHvMZyEanvIkmGxzMIDDPJo7wOR7Rmu03txmuDThJb6E+Vef8VjDeyONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965178; c=relaxed/simple;
	bh=UuT5g9Si2iw2CIgCkdkvrI6apMY4EOTkxGjsvbaoGu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGKyNBiSbd84ts80e+Y/KxESWrC6ZMQITT1ivPQNGgcmrHHBYHjefXWCQu3CiranaO6lhB+NJN8A+i4nxTx8+Uw/U14q8VX9M/vtOrOMjVJNQrDQO52QVjH1zfx1vkotLbEIqTWPNmdW3i66b0YuU3gkyCFkuTtU5RLlDtTmBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=27ezcxZ4; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-52617ceae0dso2031900e0c.0
        for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748965176; x=1749569976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KI0KUCc4GKGFyOQz+VkwvXZxmWd+cX7dW8bnjIdqNfw=;
        b=27ezcxZ44/B6MjglwU0uJ1RKQRT6nZgV4VxjMh0AHeBnMB4xp8J5nuXXTMCIG/CSuW
         D0nB/w8CTZbiGIi8/X0jNrZkVaAMvtCzUNlG0yFfX1NCJmsPJlL1Iqj05LVwP+vCm+XD
         6iDO3k/mB7gUqB9Pr1V0xLCf6SIx8kSmFwPp7Z5u8kGgvWSKrkpmcKxsFC6RgsORqa2U
         7Cwikva6jEYjqGJW/UZBXaGHVLl85lWx8YYe/RJ4saGabX2f1XV1XvWQSOSvlb07Vg+F
         K10BZMrWGZtxT7Lw/2Eov+hM+EuP68dbI78QpzBwR0lDvgKpxOhmlfEpszJa3E8ywU98
         OHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748965176; x=1749569976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KI0KUCc4GKGFyOQz+VkwvXZxmWd+cX7dW8bnjIdqNfw=;
        b=lwj9+w0odlZMMsNxjNVTSXyLRHngSr6EeY7cEU9DMvDX1aLMFgl6hYDsV1eGz+ZR96
         y1ffNVEns6XgYjOmWNGLG3AWgaRgW3jmcdwDg9PG05ntBcgQM34TqEJNa7LoKayEB+oH
         Ev/yF6NKRTNzvUXbm7pZYpanaBoD7+Bw9u+SepsT8p4OQdMnPzCBSgxersD+PN0kDuAC
         67Z28cF4cpZHgh+SBtvmQ3BSLWMeU3P6XKXmuWmco+OgtQkvHZSXmZNyzR5s2xDwF+lu
         DonthX+mmsFnt7aKct2RojTmhESFcFdRXDwCVYxARvWf6wvyOLhw0FppR3xkWUPVpRgr
         tHlw==
X-Forwarded-Encrypted: i=1; AJvYcCVx5kZZsGtHf3VtGInMX50PVDStug6rxr7QScv+mvuvBeGlaXxUpj5wfJ+zMmIiLyZQwLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRrFHovuibCnkOEj7TjOtMc/E3BeVuVtFKw80SvsuFLcPgVJB9
	MoYorxrF3xkI0XqeE/IogmRVSmakV0qUM6sZCcH37tXuBa35Q+GAMmR1+HyAG5mk4tDFGSmYlCF
	c5nxAOHpmu+ups0nCufv50d72nAsrbJUjKd42iO5c
X-Gm-Gg: ASbGncsScUvYNHbFRuE1tS3sYNouBBkf+X7nAau69roYkskixRq8mNS4+A6oa7bz155
	+Kti5B8NAwAAXh3h4oSnuM5Jg0597Gpigv6cWDYtsnsjCBMqGsbSvrQyvBd6qDOwhCI/tSxNoQB
	GQhT4LxOJoV0VdwKd6KgFHEYFcwvWcvd/Ha/Sa8V1VlJY=
X-Google-Smtp-Source: AGHT+IFP1W8JY2mCchvmzAj895DlittXPX7dwIqkrpqJOi2cGxL0MhFgoA+lb/sIi6f+nQXajzDBlAkwp1cCik+mccg=
X-Received: by 2002:a05:6122:17a8:b0:530:5f5a:1362 with SMTP id
 71dfb90a1353d-53084d9df14mr11975682e0c.10.1748965171447; Tue, 03 Jun 2025
 08:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603044813.88265-1-blakejones@google.com> <aD72CVq-kWr3G4S3@krava>
In-Reply-To: <aD72CVq-kWr3G4S3@krava>
From: Blake Jones <blakejones@google.com>
Date: Tue, 3 Jun 2025 08:39:20 -0700
X-Gm-Features: AX0GCFuztqxiBrROMefdagMnpx8xS7mbzVyRECRkSzeDsnAU9IK_GlaCTp_q3q0
Message-ID: <CAP_z_CgAAAaAPGfYY2DErT_V2-E2e8E+fDHcGPVSaOq+_D9EeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libbpf: add support for printing BTF character
 arrays as strings
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 6:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
> > +static int btf_dump_string_data(struct btf_dump *d,
> > +                             const struct btf_type *t,
> > +                             __u32 id,
> > +                             const void *data)
> > +{
> > +     const struct btf_array *array =3D btf_array(t);
> > +     __u32 i;
> > +
> > +     btf_dump_data_pfx(d);
> > +     btf_dump_printf(d, "\"");
> > +
> > +     for (i =3D 0; i < array->nelems; i++, data++) {
> > +             char c;
> > +
> > +             if (data >=3D d->typed_dump->data_end)
> > +                     return -E2BIG;
>
> curious, is this just string array without null terminating byte?
> should we just print " and return 0 instead of E2BIG error ?

Good question. That E2BIG error would happen, for example, if we tried
to print the array "{ 'a', 'b', 'c' }" when the type was "char[4]".
I'd say your proposed behavior would be consistent with the semantic of
".emit_strings should display strings in an intuitively useful way",
and I'd be in favor of doing that (replacing "return -E2BIG" with "break").
If others agree (specifically Andrii, who had comments about the semantics
yesterday), I'll make that change.

Blake

