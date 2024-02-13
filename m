Return-Path: <bpf+bounces-21859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A9A8536BF
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 18:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98971F25033
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 17:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4753D5FB9D;
	Tue, 13 Feb 2024 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6T2VkJ0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805A5FEE0
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843769; cv=none; b=fPLyUMaqH4UGuoLeqW088Rn1+p9g6EWMs2MZVpd+eh8Ay4b7kx56FCMfpFbqki2NgTM9zDgzHcnGTcd5953Prk8ITDCFl4ntFZtWf2CvihlHefnv+4BN0Ig1tcnO2QA+2RNXx7R/WWTEQTA95sryRdUM+6buqp3YM5C+ogr6XCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843769; c=relaxed/simple;
	bh=ULUToAy2W0qrK87gj1ICpBLPk8U0M+m/n6gMxES3DL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m90RZnjgN/P6X1JZ9zVP7bUjrrinkcmkHqDUUmuJhoSOIX1EwbqK41tnpO/bKhAQFsqMkCheGBJsN5Cs8OnuWKxE1PLnY6/E7vvbzH5HLvIMMfEUS+ZSjGM5X1F3VIHFx5irE7nFmSIiQlprTTcpm5UgL8bKV3rARZKqVWVosF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6T2VkJ0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2816186a12.3
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 09:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707843767; x=1708448567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6p8xo4PVdrK9SGpWap7qMruvADAH2uGBuS+Y0N3J4TY=;
        b=O6T2VkJ0HAy4uS/uWXHCSZwm2XYkDSJkCcNlerWq0lpZaE7wi6HUb6yRNc4O2waJpX
         plEhnhdrxn8BJXMvDplrqwRWmMQIhAwb9YlkElCyukDpN3mGlMycgEXV6nNnQZBDEICd
         d3iad++0d2aU9CtbygKNG77tgHUXEHQHxYpPMG9FCWeRgo4SGjwqSOy2aGoJo0xSfRTD
         VAgYpq0+Q0SbyGFzJWcQkxsvQ3/claD8uAMM/rPdTWpqCCTNgeuBhkpLmD0VpI8fV2x/
         MbAHWYKzTH/pdc2Nr+YFU3ogm8qyNOjrSLEoB8BU8qA3r41SXkSduZeyN0ONdG51fmoL
         5VbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707843767; x=1708448567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6p8xo4PVdrK9SGpWap7qMruvADAH2uGBuS+Y0N3J4TY=;
        b=Of47tqA+TT1gxtGldrvZKDhRfQOWfAmuHWokTtif1YYBXnZhAN5t5RvsK5fzCedFRX
         Z/rQGQKo7tu2/v7XHNmCBFdjFgsRB5ZCuFZUS/jtUp7vGnLn8DcFX/Ebz6wNAqoxGFII
         40a1H5vlqWds5GbMYPCKYsEq/rwL1PEgPWhvGDEHaX8tghoJXky0hyO10/rIM7sz3La9
         zCMJU9wt7EGv+qgsa1S5dDP8eaJ4bj4cBuD/XfTUg93Xsp1Ada0FcPM+A9PpzhHckigl
         4PwndhWrRU/9+OQUrJY6Ai0i6dmKKt8UsFODDHDS3/WNi/dsKtgVuaH+90JFo7frc4df
         zJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDO8gU7VLu+6WYfQaLJJS3sOifVazfZavyBe8jqh30HJ0pzjO9siH4rMIZJFky2Qas0acg+vc5PQI8z8UOn2OG7f3W
X-Gm-Message-State: AOJu0YxcVmhhs/sdWhK2hEd9qPKgTjEEjNl2xqvGFK+2bA90g9YSrsEI
	2fIJ4SEZwDsGZGxi78HgKhZS+CKoLfknARJfYtNTXR5ljPp0I+6qd0EZcC3kRmWOT2vMIf3p8/t
	8/oOavfCA54pASP6pZ6DfKpXrFySpfJSb
X-Google-Smtp-Source: AGHT+IHqB3vLmSi9xX2eK3UFPM3ax+odjSoxWmWoqozMZROp6BJebs1Vd8O+mvQO9YKT82zhrTXW0ZDCgxK44CaoGNc=
X-Received: by 2002:a17:90a:4981:b0:296:286c:4dd6 with SMTP id
 d1-20020a17090a498100b00296286c4dd6mr40391pjh.46.1707843767453; Tue, 13 Feb
 2024 09:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212233221.2575350-1-andrii@kernel.org> <20240212233221.2575350-3-andrii@kernel.org>
 <e3b68a899b8ade18addd198d6f33dcbbed473c3c.camel@gmail.com>
In-Reply-To: <e3b68a899b8ade18addd198d6f33dcbbed473c3c.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 09:02:35 -0800
Message-ID: <CAEf4Bza5yWU0Tu18ZfPB_XJeAKx_iKyR=FCkSvWXE17vPa73DA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: handle bpf_user_pt_regs_t typedef
 explicitly for PTR_TO_CTX global arg
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 8:40=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2024-02-12 at 15:32 -0800, Andrii Nakryiko wrote:
> > Expected canonical argument type for global function arguments
> > representing PTR_TO_CTX is `bpf_user_pt_regs_t *ctx`. This currently
> > works on s390x by accident because kernel resolves such typedef to
> > underlying struct (which is anonymous on s390x), and erroneously
> > accepting it as expected context type. We are fixing this problem next,
> > which would break s390x arch, so we need to handle `bpf_user_pt_regs_t`
> > case explicitly for KPROBE programs.
> >
> > Fixes: 91cc1a99740e ("bpf: Annotate context types")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Nit: same could be achieved w/o special casing kprobes by looking
>      if typedef's type is named before skipping, e.g. as below.
>      But I do not insist, probably good as it is as well.
>
> ---
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index f0ce384aa73e..830635b37fa1 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -907,11 +907,9 @@ bool btf_member_is_reg_int(const struct btf *btf, co=
nst struct btf_type *s,
>  }
>
>  /* Similar to btf_type_skip_modifiers() but does not skip typedefs. */
> -static const struct btf_type *btf_type_skip_qualifiers(const struct btf =
*btf,
> -                                                      u32 id)
> +static const struct btf_type *__btf_type_skip_qualifiers(const struct bt=
f *btf,
> +                                                        const struct btf=
_type *t)
>  {
> -       const struct btf_type *t =3D btf_type_by_id(btf, id);
> -
>         while (btf_type_is_modifier(t) &&
>                BTF_INFO_KIND(t->info) !=3D BTF_KIND_TYPEDEF) {
>                 t =3D btf_type_by_id(btf, t->type);
> @@ -920,6 +918,12 @@ static const struct btf_type *btf_type_skip_qualifie=
rs(const struct btf *btf,
>         return t;
>  }
>
> +static const struct btf_type *btf_type_skip_qualifiers(const struct btf =
*btf,
> +                                                      u32 id)
> +{
> +       return __btf_type_skip_qualifiers(btf, btf_type_by_id(btf, id));
> +}
> +
>  #define BTF_SHOW_MAX_ITER      10
>
>  #define BTF_KIND_BIT(kind)     (1ULL << kind)
> @@ -5695,9 +5699,25 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log =
*log, const struct btf *btf,
>         const char *tname, *ctx_tname;
>
>         t =3D btf_type_by_id(btf, t->type);
> -       while (btf_type_is_modifier(t))
> -               t =3D btf_type_by_id(btf, t->type);
> -       if (!btf_type_is_struct(t)) {
> +
> +       /* Skip modifiers, but stop if skipping of typedef would
> +        * lead an anonymous type, e.g. like for s390:
> +        *
> +        *   typedef struct { ... } user_pt_regs;
> +        *   typedef user_pt_regs bpf_user_pt_regs_t;
> +        */
> +       t =3D __btf_type_skip_qualifiers(btf, t);
> +       while (btf_type_is_typedef(t)) {
> +               const struct btf_type *t1;
> +
> +               t1 =3D btf_type_by_id(btf, t->type);
> +               t1 =3D __btf_type_skip_qualifiers(btf, t1);
> +               tname =3D btf_name_by_offset(btf, t1->name_off);
> +               if (!tname || tname[0] =3D=3D '\0')
> +                       break;
> +               t =3D t1;
> +       }
> +       if (!btf_type_is_struct(t) && !btf_type_is_typedef(t)) {

and now we potentially are intermixing structs and typedefs and don't
really distinguish them later (but struct abc is not the same thing as
typedef abc), which is probably not what we want.

Also, we resolve typedef to its underlying type *or* typedef, right?
So if I have typedef A -> typedef B -> struct C, we won't get to
struct C, even if struct C is the expected correct context type for a
given program type (and it should work).

So in general, yes, I think this code could be changed to not ignore
typedefs and do the right thing, but we'd need to be very careful to
not allow unexpected things for all program types. Given only kprobes
define context as typedef, it's simpler and more reliable to special
case kprobe, IMO.

>                 /* Only pointer to struct is supported for now.
>                  * That means that BPF_PROG_TYPE_TRACEPOINT with BTF
>                  * is not supported yet.

