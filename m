Return-Path: <bpf+bounces-8492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E1787527
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 18:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA723280D5B
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621BD15485;
	Thu, 24 Aug 2023 16:21:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7413AE8
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 16:21:13 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B56819A9
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 09:21:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5009d4a4897so1743173e87.0
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692894069; x=1693498869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRNa1ojeBAT68a/vyXgz6AoZU91t+qu0ykXayNZa+lQ=;
        b=nPqRhgXsh6k7pzt7/P3A9E65U2c7CnCFfOAlVQCqia4APuJlYONWhzIY9vB8HItm5W
         izJFjnqHIWowofPfDLi1uNMgIi51FdudQWwdLjQ1pO19e5SdiSBnD4NIOBxZx0JO6XKW
         Fr1ZWMFiQOkedJAxC0/2PmWCPQB0WUmB+UhMMa+hD1mYCnFH+qQY/wJAmElD6I9ePwMn
         YrOxyUscpJ9gVth1d1HPtDSI4MozeOZ+am+4Q/rbmQb/2wdn3bQWfBGmTitHWFJtVVoT
         COwUw6YiAAyRSVMeKhksTtWVJEvAnGhLAgV7PWooezPiut8C93WYdcMeJCwk/zfOYW+V
         bDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692894069; x=1693498869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRNa1ojeBAT68a/vyXgz6AoZU91t+qu0ykXayNZa+lQ=;
        b=EedwmgUOPVW6OoLS0MrPc9fZGoFlTgQp9k2PCg6wOKZmK2fkeeT/EibPGlg3ChuVca
         dGwK2iI6Cn0AuSYgT+T2qmwa2amuaWHdQj7E2Ga+xnNrM2ZbW2uTsJwp8UIg1pVqZ7Zv
         zJyrGiSckhs2DNgD/DS1vrj2FUkytbyocp7ppl2+HwkIAiGpq2touKA8JgfbjdQfdnoI
         Y+3XWSUdf4v9zli+1of8j6sa3LMs1Kx4UmEaSX+8GS4Y5hd/iQnaICpw1vozPFY9WNyG
         DT1Or2vBVVav/10k1VhyUBTxnEloKiQl1NkPQ8V0ByeI6GXm1pOdJM84MVs2H91sE16u
         73kw==
X-Gm-Message-State: AOJu0YzAuiP2g6IzqQwZdY3kBPL0lYLutasHTuLsFFEeEQ2C1qlTTxGa
	p88adNGwxgSeuYYFYIuh7XG1SffWEofSK24PufSPXufU
X-Google-Smtp-Source: AGHT+IElOz9h2U8HbN47z2BkcaxfJVfXMaAijA7XnNB/IedcJuJomL77pmhSTcUeanacX//tXnBXYK6iz+OKmWTpr2I=
X-Received: by 2002:a05:6512:3613:b0:500:8c19:d8c6 with SMTP id
 f19-20020a056512361300b005008c19d8c6mr6346215lfs.58.1692894069070; Thu, 24
 Aug 2023 09:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230823234426.2506685-1-andrii@kernel.org> <f4933856-ce85-0611-409d-bd62240d15af@linux.dev>
In-Reply-To: <f4933856-ce85-0611-409d-bd62240d15af@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Aug 2023 09:20:57 -0700
Message-ID: <CAEf4BzZqhmEvrrdMa35LKHyK8vwyhG-HEPHzbV_2pw7OVuUP0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add basic BTF sanity validation
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, kernel-team@meta.com, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 10:04=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 8/23/23 4:44 PM, Andrii Nakryiko wrote:
> > +/* Validate basic sanity of BTF. It's intentionally less thorough than
> > + * kernel's validation and validates only properties of BTF that libbp=
f relies
> > + * on to be correct (e.g., valid type IDs, valid string offsets, etc)
> > + */
> > +int btf_sanity_check(const struct btf *btf)
> > +{
> > +     const struct btf_type *t;
> > +     __u32 i, n =3D btf__type_cnt(btf);
> > +     int err;
> > +
> > +     for (i =3D 1; i < n; i++) {
> > +             t =3D btf_type_by_id(btf, i);
> > +             err =3D btf_validate_type(btf, t, i);
> > +             if (err)
> > +                     return err;
> > +     }
> > +     return 0;
> > +}
> > +
> >   static void *btf_get_raw_data(const struct btf *btf, __u32 *size, boo=
l swap_endian);
> >
> >   int btf_load_into_kernel(struct btf *btf, char *log_buf, size_t log_s=
z, __u32 log_level)
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 4c3967d94b6d..71a3c768d9af 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -2833,6 +2833,13 @@ static int bpf_object__init_btf(struct bpf_objec=
t *obj,
> >                       pr_warn("Error loading ELF section %s: %d.\n", BT=
F_ELF_SEC, err);
> >                       goto out;
> >               }
> > +             err =3D btf_sanity_check(obj->btf);
>
> Should btf_sanity_check() be called in btf_parse_type_sec() instead such =
that
> btf__parse_elf() can also have sanity check?


yep, good point, I'll move it there, thanks!

