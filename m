Return-Path: <bpf+bounces-68620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E9FB7EA8C
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779947B37D0
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 04:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D52221DB5;
	Wed, 17 Sep 2025 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqLbIs92"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590A469D
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 04:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758083850; cv=none; b=Tl9dw2uOmCfBz9nVIwEvuyZk+gHUMs42izpsW92B3s4vDet9Tk04gLilHI9W969uaS4mM+36Xc2viWCgGqgdDDlNSm6s9x7eFfz+MayHJddp4PqLlTvLl/IOP4gpKsW3wMyCGRj3OlzlaFyUhPHLRyFQZxABJsJBP4eaVNs9xBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758083850; c=relaxed/simple;
	bh=zr58wJzPOc5b7Luxg336xSbUshJ7nhL2GGcwOCUccFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZhC/lebLRZZLrRFwJTd0ZGKWw6uhTRyH1xvA+CICFapPqjzVVfNzb6HI8w9v0HOe8l0HuHiGrCf4TG+rS+rtg0E8ukL50N6J+cL5V4dLryyP8wriu7QoFAtTIpsY3sJG5gBzu03g1v65k6/2lafOplj84zoyDcOQtZ1yPirhVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqLbIs92; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso3660795f8f.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 21:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758083847; x=1758688647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGnI4AfCjnUriquEf5IbcuEymc84BmZFju6achZemKc=;
        b=YqLbIs92+vN/54Hj93/jcurtlHcxeeCcEqRJmooQGvThDaiR74hlA1UzVH+Rc3aYZO
         d+Z3oY63hnKwN3AY4T3g9VprVNYOyQK0RJ9QuhlaneLXW8HLx+HcD6Xm+338bwNfIApA
         okjoMuROwNa6kRA1qTILLwV0GlKZKQcX8/y+vrgJTIrHgcTf0oGIeheA/x41Pbd3snst
         CXHC1j7kgve7xnGsaIYmB5dzIo78YRkXPV2OgX5nQXhSFz//KRe6ZoA8qGUvuNdXWFRX
         S0CjyUotQ4YIvAWHAagpTUlATaEmDNl/qEpLDQY+L0eplf+shMtJRtUIngC5vor4J3I6
         kOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758083847; x=1758688647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGnI4AfCjnUriquEf5IbcuEymc84BmZFju6achZemKc=;
        b=aVr5TWAVQRgQazGlHAgrxtK5kM4psVxPq5hduLgUKRp92MzG2PG83EDvsOhA97aLx5
         +u4wEIqsOhfVrc3bqT8D+xZe+b6vCSVnv7m1RR+vhN5X9+j1FgSmVQfhmtfPxHJ1bwfU
         Gq32o4s6uOik5J0nZdiQ9FA8vG3dzKO1MuwFzoW0/hkqG0rWGO2s8+BU4/AQQtx1BrzU
         kRJH9C4Kmp15oMTGfQPrEenOkL2vRiSdfKC4Ctqc8axftorexgn2xULyLPgx3/thiQ0t
         K8GDf1D11PHMKL2lOUa2+Qv2qiwdiB/Dp09lQzAzATd/3fh73RUB2xkbGBlvXpm4sXEY
         7ozw==
X-Forwarded-Encrypted: i=1; AJvYcCVjm7CSbNCs2DheCIWZ4gogEtQADG4zB1EUq/XM81qAY3ykorihWjHIMpMXMgSCFqgn5uE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1QUKe4WdEvYLN1hV9ezLifUq75CJOsuAAAnM6fLy3rklEZgjN
	jJJ8qpDNkhbv4jV8ms2IwV7xmBg3xSh6sbc80KZCWr+ec18FU4LpvxtHh0tf9pQfGRWNnfiDSxc
	da6WzwJHNv252aFkijr70t5Ygv0W1B0U=
X-Gm-Gg: ASbGncuJ1LdNIn4EnXU+mTHD1T4/215aXWix++lQSy6xWGqkSQPIus00c2XMJplyNAg
	p4vE8J8Syo/ekSEj10xy/hcJlW+L8waR7Ozr4+3PkOLJYhFYkq2RTOTz1KE3CXo2ikDQdD6/SG0
	ql124MBwg/M5rtKRD1ouJ0OzU/XVDNmEG1SgqkPeMfKCW5OD7PoDwQAW6+f4v6gJYpr4xGdGJwA
	5nWd0QJXsJeoiRoM7NNSuBUxOkZru5OJZww
X-Google-Smtp-Source: AGHT+IEk0nC9w51IGMK7WcjsPGVPHNm7xYTM/eKhLpJZE2cRDY3MHxqMvwIS6NVqOLPe//gUKwFMv1uljQEmhdjj6Eo=
X-Received: by 2002:a05:6000:40df:b0:3eb:7f7d:af22 with SMTP id
 ffacd0b85a97d-3ecdfa38677mr561740f8f.51.1758083846494; Tue, 16 Sep 2025
 21:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com> <3b65db27f2cd4575875a090f9cce0ca0f138daea.camel@gmail.com>
In-Reply-To: <3b65db27f2cd4575875a090f9cce0ca0f138daea.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Sep 2025 21:37:15 -0700
X-Gm-Features: AS18NWDibl-lFGzdNQ6vSvFiBGXMc1LMbaAc49eueFkPvKGDpQuBcmz6e11pTGU
Message-ID: <CAADnVQLe+5C8MH9SEU2MxHP9iaCHJHXdnuXTHkqvnVwsHTynwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/8] bpf: Introduce deferred task context execution
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-09-17 at 00:36 +0100, Mykyta Yatsenko wrote:
>
> [...]
>
> > Changelog:
> > ---
> > v4 -> v5
> > v4:
> > https://lore.kernel.org/all/20250915201820.248977-1-mykyta.yatsenko5@gm=
ail.com/
> >  * Fix invalid/null pointer dereference bug, reported by syzbot
> >  * Nits in selftests
>
> Note for reviewrs, this is the part that takes care of syzbot report:
>
>    /* Check if @regno is a pointer to a specific field in a map value */
>    static int check_map_field_pointer(struct bpf_verifier_env *env, u32 r=
egno,
>   -                                  enum btf_field_type field_type, u32 =
field_off,
>   -                                  const char *struct_name)
>   +                                  enum btf_field_type field_type, u32 =
rec_off)
>    {
>           struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[re=
gno];
>           bool is_const =3D tnum_is_const(reg->var_off);
>           struct bpf_map *map =3D reg->map_ptr;
>           u64 val =3D reg->var_off.value;
>   +       const char *struct_name =3D btf_field_type_name(field_type);
>   +       int field_off;
>
>           if (!is_const) {
>                   verbose(env,
>   @@ -8545,6 +8546,8 @@ static int check_map_field_pointer(struct bpf_ver=
ifier_env *env, u32 regno,
>                   verbose(env, "map '%s' has no valid %s\n", map->name, s=
truct_name);
>                   return -EINVAL;
>           }
>   +       /* Now it's safe to dereference map->record */
>   +       field_off =3D *(int *)((void *)map->record + rec_off);

I don't follow. Why does it have to be so weird?
The syzbot flagged that:
if (btf_record_has_field(map->record, ...)
if (map->record->timer_off
crashes.

and the workaround is to do:
*(int *)((void *)map->record + rec_off)
?!

That's quite ugly.
Is this the case of compiler assuming non-null and hoists load?
Then barrier() will solve it?

