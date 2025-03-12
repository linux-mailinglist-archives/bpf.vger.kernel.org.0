Return-Path: <bpf+bounces-53922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAACA5E422
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 20:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8E93A6340
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 19:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2348256C9E;
	Wed, 12 Mar 2025 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7Y83ZSY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81C1662F1
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806538; cv=none; b=f66ZbdDcppL9onb9W2qVPkOkteiOsTbMb/AIPJVIA/EyztJE0SaQO8VJ08RHrtMvvXK1C50/75OFC0cD8ZxJ4KHa2zR9r4SuPE1jewAUNboDku7ulEqjUMCC3keGQ7Y7WwIX5LTq8BsDK0UKIDszGqZLa+KTSa5wqPY+HEh3lWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806538; c=relaxed/simple;
	bh=Q/kTtpwfVp6ozh6QI+7ZvfxCk5aqqsCriozoiCfmDLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEfQxQ3QNDms5SEJEBV+4B20TkoD+lEzs/ra+KZUDl1sp4YcxedU8J3P/ID7ttpJH6JCT3DXRPD64xDEZkKCNCRCv4qbOQfOfnywICg3dWOarXcxY00VCe7h6ATr31bnuzelbdjgiNHdVPka7/6w3NOOTHWpanrTITnLxvwauI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7Y83ZSY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fef5c978ccso419774a91.1
        for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741806536; x=1742411336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFiWdDaTO/G1LCqAEy3WlAv2K/bWlOTT/Inu1SYtQzw=;
        b=O7Y83ZSYHF9m0PoXVWYkPCa16LlMn5XV3X4Wg1++WhLWxURXR6cHDbzVmg7I7Dw2tI
         traUlx99wHwyPrVIitJ11JQknkU/0a8+h79h/Y6vfkxrg9qDSOW7oQJkJtLDP4pjQl1f
         pariSHvXv1AJAsJN187ufsWn381OIA+86KnbYsyAx4fdgN45fjaLeuLQrTW/321Z00NQ
         VT1+Wn7DpwkVKhk4kCdleynW8bdYrVwT9mKWElKEZT9SxyMKZLI3i9PTG5bkih+WLm9P
         2pzwR8R4E6cQebUHTjXNen52ojM3PFBgaQwvzEqkE6JlBA9CH5sEoUvY2eE1/QnK6430
         EYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741806536; x=1742411336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFiWdDaTO/G1LCqAEy3WlAv2K/bWlOTT/Inu1SYtQzw=;
        b=N7H3aOTc0rR43tQswobEBzXb954EKQDQO/iSEYkx4gujnGQ/Z4/1ndEbWe8HtBT1f+
         Uur3XRgnq2qYt37Cu0LHZRVQ8Kbq1B2ZHPd4xVFH2au/D6tW9eWRbpNO8Xr2KGNfG6iN
         0cINxISuzKERynWlCwrKgpiAW+sOyU89xo1lUa/mzzfPle5AQjsLY7GSM6baMjMFziAl
         UgeN2eb5LoMdvSWWB0Pzl5cHMK4i8k4hhbplxSJTR+AC7CneGHebfXyt8OKKcz44weXd
         lxtADF8hBWNb2vE8Lu7tBIvljbw447WEbD+TW6EEb3++em8ArAvspjmBZ0kfvQQ9z6D4
         0yQg==
X-Gm-Message-State: AOJu0YyBQa82WNFStJis/v9oo1fxGKCH1sS0pqobpi13YXR5HX+5iJE6
	LrD1cYj4ImZ6X8lq254GJY8w00bPtczGU0lEOhE/fBCbfVGGqiVyMyvrUCuCSt3LBPP+4TXNETF
	Y5QFGK+A5Bl53udAvgmdWtBuXvvYXYg==
X-Gm-Gg: ASbGncs4XYpA0qm73jtAS3OvqA1Q19LEWigA5MNq11/RzbPnfB0WAxI9pYay7ZOpE5u
	zcOZKXj8rL+3Bh4E82tWXgKUIqkBhe9xxk0/ghprcpBfr+8etWOl2MF8Oav3rvRmmRXtzIULWHN
	lHJ8pe/gAQf2sLQS0NuhiKdcTFznBnR9DHKxRJCOuwSw==
X-Google-Smtp-Source: AGHT+IHaBXo7ekMjdkprWTKd9aAXtKIE0VmNiGpCOD09AIsZxIwulzTmjLFWbB54yLyMTdeX5Hb37utXgr8x+8IqkYw=
X-Received: by 2002:a17:90b:2d83:b0:2ee:e518:c1d8 with SMTP id
 98e67ed59e1d1-2ff7cf22df2mr30613944a91.30.1741806535896; Wed, 12 Mar 2025
 12:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311215420.456512-1-mykyta.yatsenko5@gmail.com>
 <20250311215420.456512-2-mykyta.yatsenko5@gmail.com> <CAEf4BzYRrHmDUBX=yqAtNbUJ7C9En_YrDSOY=zcbkoLVNZcC9Q@mail.gmail.com>
In-Reply-To: <CAEf4BzYRrHmDUBX=yqAtNbUJ7C9En_YrDSOY=zcbkoLVNZcC9Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 12 Mar 2025 12:08:43 -0700
X-Gm-Features: AQ5f1Jr9fqeL3iRLHNtjSkAZyQynn48_jed_aQIWOdXs3MF4nIPJJxBQ_R6MHlc
Message-ID: <CAEf4BzbEbJPeTihWW6M-MmW9MC1N9LTLF5vTLDVSm1E-Jxk_hA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	olsajiri@gmail.com, yonghong.song@linux.dev, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 11:53=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 11, 2025 at 2:54=E2=80=AFPM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Currently BPF_BTF_GET_FD_BY_ID requires CAP_SYS_ADMIN, which does not
> > allow running it from user namespace. This creates a problem when
> > freplace program running from user namespace needs to query target
> > program BTF.
> > This patch relaxes capable check from CAP_SYS_ADMIN to CAP_BPF and adds
> > support for BPF token that can be passed in attributes to syscall.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
> >  include/uapi/linux/bpf.h                      |  1 +
> >  kernel/bpf/syscall.c                          | 20 +++++++++++++++++--
> >  tools/include/uapi/linux/bpf.h                |  1 +
> >  .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  3 +--
> >  4 files changed, 21 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index bb37897c0393..73c23daacabf 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1652,6 +1652,7 @@ union bpf_attr {
> >                 };
> >                 __u32           next_id;
> >                 __u32           open_flags;
> > +               __s32           token_fd;

So I almost applied it (I was going to add that flags check myself),
but then I realized that attrs->token_fd looks a bit too good to be
true... It's an ugly "historical" bpf_attr structure, but we have
these weird mixes of named and anon sub-structs, so some fields are
way too easily accessed even when dealing with a completely unrelated
command.

That is just to say that token_fd here is way too error-prone and
generically named, unfortunately. All other token-enabled commands
have more specific name (btf_token_fd, prog_token_fd, map_token_fd),
so I think we should continue the pattern here.

Let's call it `fd_by_id_token_fd` (unless someone has a better name)?
Let's keep a clean "token_fd" on libbpf API side (in opts), like we
did for other APIs.


> >         };
> >
> >         struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 57a438706215..188f7296cf9f 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -5137,15 +5137,31 @@ static int bpf_btf_load(const union bpf_attr *a=
ttr, bpfptr_t uattr, __u32 uattr_
> >         return btf_new_fd(attr, uattr, uattr_size);
> >  }
> >
> > -#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
> > +#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD token_fd
> >
> >  static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
> >  {
> > +       struct bpf_token *token =3D NULL;
> > +
> >         if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
> >                 return -EINVAL;
>
> as I mentioned in another email, we used to implicitly reject any
> open_flags set because of BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id, but
> now that we do support some flags in open_flags, we need to validate
> that there are no other flags. So you need something like:
>
> if (attr->open_flags & ~BPF_F_TOKEN_FD)
>     return -EINVAL;
>
>
> pw-bot: cr
>
> >
> > -       if (!capable(CAP_SYS_ADMIN))
> > +       if (attr->open_flags & BPF_F_TOKEN_FD) {
> > +               token =3D bpf_token_get_from_fd(attr->token_fd);
> > +               if (IS_ERR(token))
> > +                       return PTR_ERR(token);
> > +               if (!bpf_token_allow_cmd(token, BPF_BTF_GET_FD_BY_ID)) =
{
> > +                       bpf_token_put(token);
> > +                       token =3D NULL;
> > +               }
> > +       }
> > +
> > +       if (!bpf_token_capable(token, CAP_SYS_ADMIN)) {
> > +               bpf_token_put(token);
> >                 return -EPERM;
> > +       }
> > +
> > +       bpf_token_put(token);
> >
> >         return btf_get_fd_by_id(attr->btf_id);
> >  }
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index bb37897c0393..73c23daacabf 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -1652,6 +1652,7 @@ union bpf_attr {
> >                 };
> >                 __u32           next_id;
> >                 __u32           open_flags;
> > +               __s32           token_fd;
> >         };
> >
> >         struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
> > diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id=
_opts.c b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
> > index a3f238f51d05..976ff38a6d43 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
> > @@ -75,9 +75,8 @@ void test_libbpf_get_fd_by_id_opts(void)
> >         if (!ASSERT_EQ(ret, -EINVAL, "bpf_link_get_fd_by_id_opts"))
> >                 goto close_prog;
> >
> > -       /* BTF get fd with opts set should not work (no kernel support)=
. */
> >         ret =3D bpf_btf_get_fd_by_id_opts(0, &fd_opts_rdonly);
> > -       ASSERT_EQ(ret, -EINVAL, "bpf_btf_get_fd_by_id_opts");
> > +       ASSERT_EQ(ret, -ENOENT, "bpf_btf_get_fd_by_id_opts");
> >
> >  close_prog:
> >         if (fd >=3D 0)
> > --
> > 2.48.1
> >

