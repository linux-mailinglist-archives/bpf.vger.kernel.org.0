Return-Path: <bpf+bounces-15295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92417EFD76
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 04:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8BD1C209C6
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 03:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63DE524B;
	Sat, 18 Nov 2023 03:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY84iQGx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A84BC
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 19:38:28 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9e62f903e88so344627666b.2
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 19:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700278707; x=1700883507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91JTQs1M1Pu0C/MxU/i1WP/5f9NlnNxdw/URS1f06K4=;
        b=mY84iQGxVd+z/GW5xWz/rv/iJPn9soMan1FLobh7CSRZrDwRdFLrRa0Rssy4jdhbWr
         QhEkFxR+CVrrEK7CnM9+iaq9QBOqhrVK1nOfk8/HVax+zK9gQdwEhgW9tO8ceEv5wIE7
         Xdxx4T0oJufibSauXlN+xZOueR/tv4y++emJcfypNSxHoMcb6rYmwhIZvMzELWUkzC2y
         Tb1xIzN7Q0NGHjvfvs9h3wbYG3GcFbIzbKFIL/Rw/F3e9oKsFzh9jHT414Jko9i5NlXV
         U8xdWuA1+SOGgBA7X4PAibxdh0aQSLj8h9IaepRmlRKhF9mYrQyDqMJ+6R/PNrgTwavY
         gI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278707; x=1700883507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91JTQs1M1Pu0C/MxU/i1WP/5f9NlnNxdw/URS1f06K4=;
        b=ewcf3WwccE051XSYab4iS6WnxdrxAGsKEHQLp55uHTEyNoeUaa3pvEKnpYS/m9OIWO
         6hmWvXWVuiJ3Ui1vEwX6nyAhuA9vNxbpVZONxPkp5NCgH6x/FHPqLdXXNrnw/2A2bYYZ
         EDDLD+y2koRYxbno8Htc9JhNCqoEB/MuzewESI+WrlXXvDbXxB4ulHO83LyaqZEd2IJl
         Hdf9iDL57Lara/Eq8gF4+jHT8NNqmSamohhu0lQxS4/L89BGRp/FMlRHPzcaqzjdfE+w
         7PBKLIWr5IAyQnMEewdiDlnTPPlL4Jv3pI3HT4HDFdhlTrHR/7iTUIWJ0g17DWIdWJuq
         xnEg==
X-Gm-Message-State: AOJu0YyIRy/Siy/ZrupRgWET/DvZ4YAUcexP4Rw/SLCDhQiZioGOw9HX
	jXi+O17Ox5rZMQIafUiNiB+tdUYEvemWVFkGV1E=
X-Google-Smtp-Source: AGHT+IFwhdNPPjpXLZ4FmXhnSATffgWyv++jniaSn2t9qV89BWoWVcMMLEZVq3qu/+ZPBQnZgTeZtnaVRTs1UsZxdVA=
X-Received: by 2002:a17:906:a014:b0:9e8:de5e:911a with SMTP id
 p20-20020a170906a01400b009e8de5e911amr849606ejy.73.1700278707083; Fri, 17 Nov
 2023 19:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111201633.3434794-1-andrii@kernel.org> <20231111201633.3434794-8-andrii@kernel.org>
 <CAADnVQJT_On7dbs8_KZt8otZfVZBUerJfTBJpLE2_CmbbiNvdA@mail.gmail.com>
In-Reply-To: <CAADnVQJT_On7dbs8_KZt8otZfVZBUerJfTBJpLE2_CmbbiNvdA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 19:38:14 -0800
Message-ID: <CAEf4BzYdY9b3hsKYPipwxQGy3X1tLbQMqjTxJf2Y5-XamuQaZQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/8] bpf: smarter verifier log number printing logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 9:33=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Nov 11, 2023 at 12:17=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > +static void verbose_unum(struct bpf_verifier_env *env, u64 num)
> > +{
> > +       if (is_unum_decimal(num))
> > +               verbose(env, "%llu", num);
> > +       else
> > +               verbose(env, "%#llx", num);
>
> I didn't know about %#.
> The kernel printk doc doesn't describe it.
> Great find.
> Curious, how did you discover this modifier?
> Not sure whether it's worth adding a comment here
> that # adds 0x. Probably not ?

This # is called "an alternative form" and is a standard printf()
feature. I saw it somewhere, don't remember where, so yeah, probably
an overkill to add a comment for that.

>
> > +       if (type_is_pkt_pointer(t)) {
> > +               verbose_a("r=3D");
> > +               verbose_snum(env, reg->range);
> > +       }
>
> A tiny nit...
> The pkt range cannot be negative, so using Snum here
> begs the question... why?

original code was using "r=3D%d" format string, so I was preserving
signedness. But if it's supposed to be unsigned, then yeah, no reason
to do snum here.

> The rest looks great.
> If you're ok I can fix it up to unum while applying or respin?

This patch requires fixes for reg_bounds.c tester in the part that
parses register state. It's not a lot, but not really trivially
fixup-able. I already have all that ready locally, so I'll repost v3
with unum change.

