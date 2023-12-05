Return-Path: <bpf+bounces-16765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B772805D82
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032CD281FC9
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F156A033;
	Tue,  5 Dec 2023 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZSPIId9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32BF1A2
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 10:41:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9e1021dbd28so822175566b.3
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 10:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701801670; x=1702406470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp2apMoh24DOQYWEUxYhiF6iTgHCpdqbcFQ1AUvBgZk=;
        b=ZZSPIId9T9RJK4+wzwVcVA06T4uhV+ufULlDjvkVKaqNq+gKw99DZREXxbLWQ7XeyM
         fXHibyrBjrekdNBnjANxy7ZUvb6MTSx4DoeuDnh5659ER9K5YvZo8Z4ILIVydCi7q77A
         gRd08+YUQ+30nibwFKPGM7KFCtM5tauNTAImVi+6T+UFhs/dhr9PXn1J4alRwJb7dhVD
         g0DK7Y9taxI8c6kQvdk2VM6G+QdFLQAa4BoUmTexwN3tfWVb33GTXeQyBMiVOfXA7dGC
         ksFsunRwwU8f2ivx2Ell8RJzGHESeMzZaVp24FVFCKLD4EQ9AxMgv+Z9502AV02OW0i0
         flLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701801670; x=1702406470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mp2apMoh24DOQYWEUxYhiF6iTgHCpdqbcFQ1AUvBgZk=;
        b=kONIG+SWqljqBxvYgK5TBhAVZ886/PAmLSKW7vsgX8lokCrWmuVqV1fzA6OEHk38tj
         J0JKHbvicXGH3pTOE6NCHP8dEVPBiXeqpA24snN+bjWMnWWsC4Rn21n2W7z7OSOa53Z6
         OVnMgwaWfqMQznguXtdxckXmGJhVtCVh/VgBjpitXOc7nJRhfbS72vndC9AzZAE1jfD8
         RWarqmDIq+VG72atiaxFgZaoS7B1lgFgJyCucxC/z5w3cDJLoAx/m0hWIjVVnwDZYMio
         94jU2wuQt5iih5KE8ZVyTe0SqbvE7xvdNYejpH+9IMyIN/dXLXgBc8nN5nETfyJPZR1I
         +kzw==
X-Gm-Message-State: AOJu0Yxt4LbX3jGGxFFRoC3doAMtkKTizVGNwYhdfYFcpWNueuLH03MM
	Bh9csAeQx2+/LiLOujgn5zZ30G+TXIOEWZ8UgKFPh76YsyN4wA==
X-Google-Smtp-Source: AGHT+IHKUc889eb+YNPJzDF70C7FKtT56pvolCeyR+g33h/yxOlUmJJ5liZtR1N9iDVZj7YlWewRMYJFKmNSJShd7Oc=
X-Received: by 2002:a17:906:aacd:b0:a1c:8714:a2e5 with SMTP id
 kt13-20020a170906aacd00b00a1c8714a2e5mr915091ejb.72.1701801669940; Tue, 05
 Dec 2023 10:41:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204153919.11967-1-andreimatei1@gmail.com> <CAEf4BzZ57kAWYDBwpxxAsWRyo5fvnHf5-R+OZuPSd1L-viQDig@mail.gmail.com>
In-Reply-To: <CAEf4BzZ57kAWYDBwpxxAsWRyo5fvnHf5-R+OZuPSd1L-viQDig@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Tue, 5 Dec 2023 13:40:58 -0500
Message-ID: <CABWLseuNGNvXdNRZib=ymNuqx8OVnYBznLhMeoR3bpzSC6cpgQ@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 1:32=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 4, 2023 at 7:39=E2=80=AFAM Andrei Matei <andreimatei1@gmail.c=
om> wrote:
> >
> > This patch fixes a bug around the verification of possibly-zero-sized
> > stack accesses. When the access was done through a var-offset stack
> > pointer, check_stack_access_within_bounds was incorrectly computing the
> > maximum-offset of a zero-sized read to be the same as the register's mi=
n
> > offset. Instead, we have to take in account the register's maximum
> > possible value.
> >
> > The bug was allowing accesses to erroneously pass the
> > check_stack_access_within_bounds() checks, only to later crash in
> > check_stack_range_initialized() when all the possibly-affected stack
> > slots are iterated (this time with a correct max offset).
> > check_stack_range_initialized() is relying on
> > check_stack_access_within_bounds() for its accesses to the
> > stack-tracking vector to be within bounds; in the case of zero-sized
> > accesses, we were essentially only verifying that the lowest possible
> > slot was within bounds. We would crash when the max-offset of the stack
> > pointer was >=3D 0 (which shouldn't pass verification, and hopefully is
> > not something anyone's code attempts to do in practice).
> >
> > Thanks Hao for reporting!
> >
> > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
> > Closes: https://lore.kernel.org/bpf/CACkBjsZGEUaRCHsmaX=3Dh-efVogsRfK1F=
Pxmkgb0Os_frnHiNdw@mail.gmail.com/
> > Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index af2819d5c8ee..b646bdde09cd 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6816,10 +6816,9 @@ static int check_stack_access_within_bounds(
> >                         return -EACCES;
> >                 }
> >                 min_off =3D reg->smin_value + off;
> > +               max_off =3D reg->smax_value + off;
> >                 if (access_size > 0)
> > -                       max_off =3D reg->smax_value + off + access_size=
 - 1;
> > -               else
> > -                       max_off =3D min_off;
> > +                       max_off +=3D access_size - 1;
>
> this special casing of access_size =3D=3D 0 feels wrong (and I mean befor=
e
> your patch as well).
>
> Looking at the code, we only really calculate max_off to check that we
> don't go to a non-negative stack offset, e.g., r10+0 or r10+1 (and
> beyond).
>
> So given that, I propose to calculate max_off as an exclusive bound,
> and instead of doing a mostly useless check_stack_slot_within_bounds()
> call for it, just check that max_off is <=3D 0.
>
> Something like this:
>
> min_off =3D reg->smin_value + off;
> max_off =3D reg->smax_value + off + access_size;
> err =3D check_stack_slot_within_bounds(min_off, state, type);
> if (!err && max_off > 0)
>     err =3D -EINVAL; /* out of stack access into non-negative offsets */
>
>
> Now, one more issue that jumped out at me is that we calculate min/max
> off as a sum of smin/smax values (which are checked to be within
> +/-1<<29, all good so far) *and* insn->off, which can be a full s32,
> it seems. So we are running into overflow/underflow territory with
> using int for min_off/max_off.
>
> While you are at it, can you please use s64 for all these calculations? T=
hanks!


insn->off is __s16, not s32 [1], so I think we're good as far as
offsets coming from instructions are concerned.
For helpers, the offset comes from a register, but it's checked
against 1<<29 here [2].
However, there's also this code path [3] dealing with kfunc args,
where I think the size can indeed technically be a full u32. So yeah,
I'll append a patch to deal with possible overflow.

[1] https://github.com/torvalds/linux/blob/815fb87b753055df2d9e50f6cd80eb10=
235fe3e9/include/uapi/linux/bpf.h#L76
[2] https://github.com/torvalds/linux/blob/815fb87b753055df2d9e50f6cd80eb10=
235fe3e9/kernel/bpf/verifier.c#L7494-L7498
[3] https://github.com/torvalds/linux/blob/815fb87b753055df2d9e50f6cd80eb10=
235fe3e9/kernel/bpf/verifier.c#L7528


>
>
> >         }
> >
> >         err =3D check_stack_slot_within_bounds(min_off, state, type);
> > --
> > 2.40.1
> >

