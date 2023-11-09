Return-Path: <bpf+bounces-14603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399D57E7068
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EC4281180
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D2722EF2;
	Thu,  9 Nov 2023 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMhIC+BL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F19225D5
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:37:23 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F9CD58
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:37:23 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9e2838bcb5eso195877466b.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 09:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699551441; x=1700156241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pm/chHffG6PHIjAWY8HTOC8dv7OHQ69JDxIWBgj4kT4=;
        b=kMhIC+BLjerA0F4NUYGwyW8MoSf8n5WTEpqv2XMX09C6f6poeWvbaHsgoX0MAvcuuW
         DMxr6RAOCNYSdDE3Jn7Q1hX4myzLf+NyNsX+kOysRrXZpisG30cueKSmnrDHvb48YPHY
         Vfz+xCjjcWBHY3npfcdMIvFRwqw4mgyLhxeKdoaa7y8Bouljnb6b7PqimBvi6UTfNWLA
         tX2oezBguzYaYEq/ridbPCZYupfTQzYSu9m4maVBsD+SjLHTgs/dKErzXen5u14wCxN0
         0YKRPbpvxLmlRJEiGiAUFG+moqZ+XplvyGAPIFCqj9IMzSS5BNkjvkPnPvqVb8wsQctn
         ZEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699551441; x=1700156241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pm/chHffG6PHIjAWY8HTOC8dv7OHQ69JDxIWBgj4kT4=;
        b=XXq30ubQOESMlYMUPkhKbHDlbYPvUbTfvshaTXP3W+FYNjPb13MeAjXpzlhepOevR8
         4tJzyCfvIUaQNsaU7u/6/6BsRWXL21Lb7+Ph3i91A7tbFxAVbKoACrYEiLsMvrVSjvzg
         +qfG9SeG4OcuXARa2axuDqavE5sroSPvUiJPXJDGnGbXE/UW+JdItDlreDAy2ZwzlhIt
         92fPgBABCtCzl34+Q/rj4ynXKTJEpeIdMJ801X8H3s/YOMjUnFApQfGArSywWsLQxWHK
         +OtxUmQAwDCzv9l1Qyu7JkaQ0Os+bypKTtEi0gXjU0HhJdD7/iKmeNQwRSFMzMRDsadW
         rjXw==
X-Gm-Message-State: AOJu0YxfwF7bDbbeA2qAVdhazRqHOtLRwZW6SovFOPgvCYsrl0FXNYYj
	pjhUWo0G/Vj35XcqYAQ4NEL2ebQBgKCNblt7FFE=
X-Google-Smtp-Source: AGHT+IH7nLQde4+aE+NsfLnbyzt2lpvbu5aNGFpJT+/ufk/QQuwL6r47vYv+7gfd9JXsi8NWqB5X0UyuPEGRYPC8Rbw=
X-Received: by 2002:a17:907:2da2:b0:9be:fc60:32d9 with SMTP id
 gt34-20020a1709072da200b009befc6032d9mr5203262ejc.47.1699551441438; Thu, 09
 Nov 2023 09:37:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-6-andrii@kernel.org>
 <8163041bb608879cee598cb6262c04fc18bf226f.camel@gmail.com>
In-Reply-To: <8163041bb608879cee598cb6262c04fc18bf226f.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 09:37:09 -0800
Message-ID: <CAEf4Bzb0SY9uoc268qanOcCQ0_8k21WzLtHzj-KM6U_=9W8XXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/7] bpf: preserve STACK_ZERO slots on partial
 reg spills
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 7:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> > Instead of always forcing STACK_ZERO slots to STACK_MISC, preserve it i=
n
> > situations where this is possible. E.g., when spilling register as
> > 1/2/4-byte subslots on the stack, all the remaining bytes in the stack
> > slot do not automatically become unknown. If we knew they contained
> > zeroes, we can preserve those STACK_ZERO markers.
> >
> > Add a helper mark_stack_slot_misc(), similar to scrub_spilled_slot(),
> > but that doesn't overwrite either STACK_INVALID nor STACK_ZERO. Note
> > that we need to take into account possibility of being in unprivileged
> > mode, in which case STACK_INVALID is forced to STACK_MISC for correctne=
ss,
> > as treating STACK_INVALID as equivalent STACK_MISC is only enabled in
> > privileged mode.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Could you please add a test case?
>

sure

> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > @@ -1355,6 +1355,21 @@ static void scrub_spilled_slot(u8 *stype)
> >               *stype =3D STACK_MISC;
> >  }
> >
> > +/* Mark stack slot as STACK_MISC, unless it is already STACK_INVALID, =
in which
> > + * case they are equivalent, or it's STACK_ZERO, in which case we pres=
erve
> > + * more precise STACK_ZERO.
> > + * Note, in uprivileged mode leaving STACK_INVALID is wrong, so we tak=
e
> > + * env->allow_ptr_leaks into account and force STACK_MISC, if necessar=
y.
> > + */
> > +static void mark_stack_slot_misc(struct bpf_verifier_env *env, u8 *sty=
pe)
>
> Nitpick: I find this name misleading, maybe something like "remove_spill_=
mark"?

remove_spill_mark is even more misleading, no? there is also DYNPTR
and ITER stack slots?

maybe mark_stack_slot_scalar (though that's a bit misleading as well,
as can be understood as marking slot as spilled SCALAR_VALUE
register)? not sure, I think "slot_misc" is close enough as an
approximation of what it's doing, modulo ZERO/INVALID

>
> [...]
>
>

