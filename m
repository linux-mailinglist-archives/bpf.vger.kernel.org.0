Return-Path: <bpf+bounces-76533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF46CB8C98
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 13:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2D81301245C
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28B6225779;
	Fri, 12 Dec 2025 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Khu89WHR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2788C4502A
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765542134; cv=none; b=qDnq/cV8Dh38t9/vov9Rv9b4rC675kki0+q0/SLOGQ3MsKls9U1xmjlZu4PoqXB+xc4pvS1Or0aa+YTpEpzpw+cDc/f95U6h10ZOGno/6oPx3VlM9bCCYteTQ21S5BVrkeAXGmGvN9JxAEFzrwdNCdkPUKwqeQxKtMYTOPcqoO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765542134; c=relaxed/simple;
	bh=4Z6YmuI8AjyYUopovVu2Wd+1ecBdpezuvA7xXlmNmho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0KVX6/6ILwqh8zFjUuwqz7SQZWrHtJNmROm6HiSI2xbakjNfXwBJkmpJd3azJ8+VjwxC8d0ONfARLA9o33n6FRm6po7ZEt56IkSp5tPbGUPMc6kOwT73HEU17EkAQfdB+Q2PmJJ+qBWR1PPh7mPYClKcAWiwD6ciTACJ8ZzYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Khu89WHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96C4C19422
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 12:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765542133;
	bh=4Z6YmuI8AjyYUopovVu2Wd+1ecBdpezuvA7xXlmNmho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Khu89WHRgBrDbdaZLW4WWaiByRtua+Zahgjh+FnVY0KxXwnRjQ56uTtm9bYlVvxk7
	 nE4tbgJjs3YNngVYMcdW1PmSoWCHPET2ZJ8rgcQ5ePxmqZcVdoGnU01mAnE1qQorhD
	 nJg3dQmXrPHDgImNeP64z5k6U5cQ+K86D9BjaoFJVvR8E70Ms4m+mGV1vQ+on3J7tM
	 XGy5dbgscxj66BTs9pyQGDviaFbTWkeNl7LKuHtykN5rITfMy3R4k6I03p5Kh9DCeh
	 AhGr5FCWXgog70Nbavhp0ZS0r+wi7aCEXbppRviGUGb2CknwCT039DVZQIwEdWlEMu
	 JfOxMUp32iuPg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64951939e1eso1901993a12.1
        for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 04:22:13 -0800 (PST)
X-Gm-Message-State: AOJu0Ywe4iUEBYugngJ5rUPai1uji3P0Ed6TfRai9e9kDzTRoWTLMWiV
	g5MNQkLMZ4xo/uZrnSKEOzph8dmvfsOaW5fugPjkDCmdtWLH5pQBFvOhXxLN013JO6+FNWKALll
	3FiVCeCvpbTWwgTM1jN1lnq4rqB2McEE=
X-Google-Smtp-Source: AGHT+IEkdJkat7xc4EAvtCSYUHWhNj2kueShrvm0FU1W2FBZNfi3pciHpBmyRTrxMu79mkc9aK/Zc8igyJLvqKgbfOw=
X-Received: by 2002:a05:6402:1ed4:b0:640:b99c:de83 with SMTP id
 4fb4d7f45d1cf-6499b1b18bfmr1829794a12.17.1765542132165; Fri, 12 Dec 2025
 04:22:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212044516.37513-2-puranjay@kernel.org> <af86aa9e3f81872ae3f623614440c73448d2f5feb4bbaa9ad5942369681351d3@mail.kernel.org>
In-Reply-To: <af86aa9e3f81872ae3f623614440c73448d2f5feb4bbaa9ad5942369681351d3@mail.kernel.org>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Fri, 12 Dec 2025 21:22:00 +0900
X-Gmail-Original-Message-ID: <CANk7y0gt=MQ-ah8hb88fkNF-cb=A=jn3b10y-rpx0oiehMZG9w@mail.gmail.com>
X-Gm-Features: AQt7F2pTDFSdwg_O6QbOhw1eLNiQjNH-nR_CXfwpmIHXjf3LZsQIPlro-rn3OLw
Message-ID: <CANk7y0gt=MQ-ah8hb88fkNF-cb=A=jn3b10y-rpx0oiehMZG9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: arena: populate vm_area without
 allocating memory
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, kernel-team@meta.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 2:04=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 1074ac4459f2..dd07268b67d4 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
>
> [ ... ]
>
> > @@ -477,17 +544,20 @@ static long arena_alloc_pages(struct bpf_arena *a=
rena, long uaddr, long page_cnt
> >        * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflo=
w
> >        * lower 32-bit and it's ok.
> >        */
> > -     ret =3D vm_area_map_pages(arena->kern_vm, kern_vm_start + uaddr32=
,
> > -                             kern_vm_start + uaddr32 + page_cnt * PAGE=
_SIZE, pages);
> > +     ret =3D apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
> > +                               page_cnt << PAGE_SHIFT, apply_range_set=
_cb, &data);
> >       if (ret) {
> > -             for (i =3D 0; i < page_cnt; i++)
> > +             mapped =3D data.i
>                          ^^^^^^^^^
>
> Is the missing semicolon here intentional? This causes a compilation
> error in arena_alloc_pages().

Was fixed in the next commits, but I am aware that every commit should
be fully functional it itself,
so I will fix it in the next version.

>
> > +             for (i =3D mapped; i < page_cnt; i++)
> >                       __free_page(pages[i]);
> >               goto out;
> >       }
> >       kvfree(pages);
> >       return clear_lo32(arena->user_vm_start) + uaddr32;
> >  out:
> > -     range_tree_set(&arena->rt, pgoff, page_cnt);
> > +     range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
> > +     if (mapped)
> > +             arena_free_pages(arena, uaddr32, mapped);
> >  out_free_pages:
> >       kvfree(pages);
> >       return 0;
>
> [ ... ]
>
> The commit message states the goal is to make bpf_arena_alloc_pages()
> non-sleepable, but the KF_SLEEPABLE flag is not removed from the kfunc
> registration. Without removing this flag, the BPF verifier still treats
> the function as requiring sleepable context. Should the following change
> be included to remove the flag from the kfunc definitions:
>
> BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_TRUSTED_ARGS | KF_ARENA_RET =
| KF_ARENA_ARG2)
> BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_TRUSTED_ARGS | KF_ARENA_ARG2)
> BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_TRUSTED_ARGS | KF_ARENA_AR=
G2)

There are more changes required before KF_SLEEPABLE can be removed. It
is removed in the
3rd commit, after all requirements have been met.


> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/201566=
88454

