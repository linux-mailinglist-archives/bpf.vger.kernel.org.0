Return-Path: <bpf+bounces-15677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F07F4EA0
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 18:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A1ECB20D4D
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1C157898;
	Wed, 22 Nov 2023 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMQZEna1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB115BC
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 09:45:40 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a00ac0101d9so398933466b.0
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 09:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700675139; x=1701279939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTaG8gvjGqbBe1ElweAD1y2yynBvXeWggWHe/rVpTIw=;
        b=fMQZEna1I4okup3OqQZq/IMxgi05D7IZ7fLDt41ItG4aZSpCRBNH/JE5pkwTsVdkwR
         KXS+hapt7DPtQGnQ2uv2gXjEF5AA8/DkDyXAKkqOHL7UoqKYVzFc6ujd4XvhI425YQOJ
         A1cMEHUiFDMmq096T2QtARJmN1YPp43Hi8VtKvMraD82XU26fJ+y5FQyOCe/hx1cgGl3
         mXZVb8PNz/JVWic8JTz5ExddTg2sJ66NJeJZL5t0pdgCbbeiykt0cr9xnjvxZ3XfvSJv
         ujKSMXKWIF6QKQPnURjJVUjGG9RtHVEZdFkExS5k/jvhiuQZwdwKB4hyP3eb/GQdlSCE
         zh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700675139; x=1701279939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTaG8gvjGqbBe1ElweAD1y2yynBvXeWggWHe/rVpTIw=;
        b=TnLty2y6pY6s1fpS0ufQWOnrW8IpbnpMU+7kY83W0oiaJ0RRydOWDwC2pN6qBa3LGS
         bsk4xvAWPRtIH0nG+V5K5lD7YGjBLzqSBcWkw4cqXxn+U4Lo08wr/jYB3V1T9+yab60v
         rUNqgy35Ycjl8Ar1/T+SR3P22ixb7YD1cVfdthin5WJcDMIDlbkdUWgie7Ht6XaSqel6
         XTG5jmuzsIe95Fict9yU6h1+7j5rUORmBZrjc3GNs6m+3gNmxe+qgQrgYpEOP03XQTsr
         S9WoA0aj/gf1ojbM5gv5gbRb5uml2+RNdaO3+xTYTQr8CSX4H4MS1XnmQSmjXEFendNh
         220Q==
X-Gm-Message-State: AOJu0YwcPgBUp1s8ThmgLnvNc8f0TS35EpNni+d3LO+W9LOh1bn+W1DO
	T6hQ8fcNR2J1IOQxiiI/gKi5Z8lIDC/SkrWuU1s=
X-Google-Smtp-Source: AGHT+IGQ2OTsEpZrj2tlecbp4t5LurMDSayTEwAoudrAlwfsyL8Y5hFtnOmHrZ1XFyboom87b9TfQYTRoFQFwr76Xnw=
X-Received: by 2002:a17:906:250a:b0:a00:b4ab:cb6d with SMTP id
 i10-20020a170906250a00b00a00b4abcb6dmr937288ejb.69.1700675138852; Wed, 22 Nov
 2023 09:45:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122011656.1105943-1-andrii@kernel.org> <20231122011656.1105943-5-andrii@kernel.org>
 <a6edebc8d7063836c7d031d86a3c43f2dd0f49bd.camel@gmail.com>
In-Reply-To: <a6edebc8d7063836c7d031d86a3c43f2dd0f49bd.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 22 Nov 2023 09:45:27 -0800
Message-ID: <CAEf4BzaXazY88jiLgwdrnOw2OgSREfuTp5sAfs_-0FyumQB4BQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/10] bpf: enforce exact retval range on
 subprog/callback exit
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 7:13=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-11-21 at 17:16 -0800, Andrii Nakryiko wrote:
> > Instead of relying on potentially imprecise tnum representation of
> > expected return value range for callbacks and subprogs, validate that
> > both tnum and umin/umax range satisfy exact expected range of return
> > values.
> >
> > E.g., if callback would need to return [0, 2] range, tnum can't
> > represent this precisely and instead will allow [0, 3] range. By
> > additionally checking umin/umax range, we can make sure that
> > subprog/callback indeed returns only valid [0, 2] range.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> (but please see a question below)
>
> [...]
>
> > @@ -9464,6 +9477,16 @@ static bool in_rbtree_lock_required_cb(struct bp=
f_verifier_env *env)
> >       return is_rbtree_lock_required_kfunc(kfunc_btf_id);
> >  }
> >
> > +static bool retval_range_within(struct bpf_retval_range range, const s=
truct bpf_reg_state *reg)
> > +{
> > +     struct tnum trange =3D retval_range_as_tnum(range);
> > +
> > +     if (!tnum_in(trange, reg->var_off))
> > +             return false;
>
> Q: When is it necessary to do this check?
>    I tried commenting it and test_{verifier,progs} still pass.
>    Are there situations when umin/umax change is not sufficient?

I believe not. But we still check tnum in check_cond_jmp_op, for
example, so I decided to keep it to not have to argue and prove why
it's ok to ditch tnum.

Generally speaking, I think tnum is useful in only one use case:
checking (un)aligned memory accesses. This is the only representation
that can make sure we have lower 2-3 bits as zero to prove that memory
access is 4- or 8-byte aligned.

Other than this, I think ranges are more precise and easier to work with.

But I'm not ready to go on the quest to eliminate tnum usage everywhere :)

>
> > +
> > +     return range.minval <=3D reg->umin_value && reg->umax_value <=3D =
range.maxval;
> > +}
> > +
>
> [...]
>
>

