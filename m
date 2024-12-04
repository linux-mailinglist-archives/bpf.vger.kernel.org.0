Return-Path: <bpf+bounces-46098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881479E42E7
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 19:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D1E16A556
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 18:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262BF20E71A;
	Wed,  4 Dec 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMwdJPDi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC820E6FD
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335151; cv=none; b=kfk8F+WtCWYAD/c1XK1OFMwa1syKJf270eeW54shb9slsCQRgSqfzApGOACSg+MZRQfdn9ey7W/G33g+cdO0dlNyXmdxYMSh/Xm/3cY98Yyt4hkMBqlDV5Rjo+MQcUmKt+dsV9ej2eBDrbhL10k8rxazsnY3hMbeIyRhJtfGE14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335151; c=relaxed/simple;
	bh=CI1temIejEQBxloQCdyLp5K1cB4i1AHXIiWKiunVnSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVqxccjMBMYoZ0KaLlDMmUOcz//jjf5LzgjxvQI5MJu2182JZv0Rp109Jj2XTsAPFv0qXHeQPXvifM94Fc5nyUd6/IzD6yPf/2w+xrrEKDzx6VA/TV70TjkWos+i8bBgqC+6WymeOcSLKLhyyuMG6g5WRMIdrd+qt/qJztb4IbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMwdJPDi; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d0bd12374cso3656208a12.3
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 09:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733335148; x=1733939948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FG8I0CeU69+wwfKNtJdrt/AaxfvsY/1jfEuwl5e309A=;
        b=hMwdJPDiHE6F5bhWEXKhi/sKtDbCFzSjQXczEFkLZJbVh3pL/4RGeF7zSo8xnIn0FU
         TMLmHl2aH9E22ojuKGBubfOMWH2d5tBZSAPiMYJSp6AdXU6/kgYbgRMUwhPFLgWCKFYd
         55KqWFGnv/IPsuL99nA6cCIEH/tDHTBiQYHWPkaYxmDCbMRShW9LrLJJVkKBSIArpHg8
         WjrjLLrW36imdQntciZV8aNPA2WfiljlZVRD5/joBpRDX0vmsqHmi9YXZsIl7T3IMk5N
         QxNQqyHnBLjQnQVoBS+HVeP1wMOmEzMV8RWyJ8KBhK/an9aq1Cw0IqiUa/5/xEHOLVhT
         ASFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335148; x=1733939948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FG8I0CeU69+wwfKNtJdrt/AaxfvsY/1jfEuwl5e309A=;
        b=myuEeZCC7rTziIDjpknvQIdJMJHG2NZKHSSwggdB9G3K7RnUZO6rEB+yQBCnwkqg0H
         DvT45lfjhTj1CBP5djAAJNWIMsItV+w34tyPepkd8oieX4bXpFB5AtKquLQeskq09dGt
         eOHnpCUXZqUrv7MSLyWW+i0K2J2E+TkfVNgjiKDOnRq1TcHtRFlbQeYLi3w0wNGV41Ul
         hY/DP3A9kIHjexUCNFsrgdkXFCE4vuTBT0GrG589cXQ/ceGpDaKuQAsGeH4dbCMMNldV
         s5O7R55MqnkvfV5s0UY4he/fN4a0S48qayMPIf3nEbgR27kAWdx1SPoymxeEiG5n36iS
         hirA==
X-Gm-Message-State: AOJu0Yzw01QQ6xTxw/ZWK1ncwBhSfttRLNCHLVCDpix9W8Sr44rrRSL2
	Le42bXHv2M8SOUgk8HHGQmRo3hNwSeh82Ec4f2uE+r7tYIrIseCycyiPrBXPwFh+3J+LsDlPTTR
	9LI3eGR/N2Brca3fWd1YASN9jM5DElw==
X-Gm-Gg: ASbGnctSbweZprYaYE9Hv13V54UWGDyXB9xS1lhF0C6U6m44rKLNvC1wG/Qqb9+KK8P
	o3rz0whHgf/0neosLD5jzO9K507eXhbyx99oZ5HjxPLjvox4=
X-Google-Smtp-Source: AGHT+IEFXyzaaayI1Ql40Asrw1IMLF+jIz7AGoRM9wft2BDyILXfuIb5M8xkudjr/9+oOkPDTcw4DVdmDM+m6lYqV2Q=
X-Received: by 2002:a05:6402:2787:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d10cb9a3f6mr7607501a12.32.1733335148089; Wed, 04 Dec 2024
 09:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203135052.3380721-1-aspsk@isovalent.com> <20241203135052.3380721-2-aspsk@isovalent.com>
 <CAEf4BzZogXRtHgDLa1nm4neOEbd+b2+UX_fog2hpgYJ5vr-X9A@mail.gmail.com> <Z1Ax+woX0zjYH+Qo@eis>
In-Reply-To: <Z1Ax+woX0zjYH+Qo@eis>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Dec 2024 09:58:51 -0800
Message-ID: <CAEf4BzYMNtr3dYvsU8jbqkDos9jg6a-FRmBcW8dkMi3zrE+8LQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/7] bpf: add a __btf_get_by_fd helper
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 2:39=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> On 24/12/03 01:25PM, Andrii Nakryiko wrote:
> > On Tue, Dec 3, 2024 at 5:48=E2=80=AFAM Anton Protopopov <aspsk@isovalen=
t.com> wrote:
> > >
> > > Add a new helper to get a pointer to a struct btf from a file
> > > descriptor. This helper doesn't increase a refcnt. Add a comment
> > > explaining this and pointing to a corresponding function which
> > > does take a reference.
> > >
> > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > ---
> > >  include/linux/bpf.h | 17 +++++++++++++++++
> > >  include/linux/btf.h |  2 ++
> > >  kernel/bpf/btf.c    | 13 ++++---------
> > >  3 files changed, 23 insertions(+), 9 deletions(-)
> > >
> >
> > Minor (but unexplained and/or unnecessary) things I pointed out below,
> > but overall looks good
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index eaee2a819f4c..ac44b857b2f9 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -2301,6 +2301,14 @@ void __bpf_obj_drop_impl(void *p, const struct=
 btf_record *rec, bool percpu);
> > >  struct bpf_map *bpf_map_get(u32 ufd);
> > >  struct bpf_map *bpf_map_get_with_uref(u32 ufd);
> > >
> > > +/*
> > > + * The __bpf_map_get() and __btf_get_by_fd() functions parse a file
> > > + * descriptor and return a corresponding map or btf object.
> > > + * Their names are double underscored to emphasize the fact that the=
y
> > > + * do not increase refcnt. To also increase refcnt use corresponding
> > > + * bpf_map_get() and btf_get_by_fd() functions.
> > > + */
> > > +
> > >  static inline struct bpf_map *__bpf_map_get(struct fd f)
> > >  {
> > >         if (fd_empty(f))
> > > @@ -2310,6 +2318,15 @@ static inline struct bpf_map *__bpf_map_get(st=
ruct fd f)
> > >         return fd_file(f)->private_data;
> > >  }
> > >
> > > +static inline struct btf *__btf_get_by_fd(struct fd f)
> > > +{
> > > +       if (fd_empty(f))
> > > +               return ERR_PTR(-EBADF);
> > > +       if (unlikely(fd_file(f)->f_op !=3D &btf_fops))
> > > +               return ERR_PTR(-EINVAL);
> > > +       return fd_file(f)->private_data;
> > > +}
> > > +
> > >  void bpf_map_inc(struct bpf_map *map);
> > >  void bpf_map_inc_with_uref(struct bpf_map *map);
> > >  struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool ure=
f);
> > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > index 4214e76c9168..69159e649675 100644
> > > --- a/include/linux/btf.h
> > > +++ b/include/linux/btf.h
> > > @@ -4,6 +4,7 @@
> > >  #ifndef _LINUX_BTF_H
> > >  #define _LINUX_BTF_H 1
> > >
> > > +#include <linux/file.h>
> >
> > do we need this in linux/btf.h header?
>
> Thanks, removed.
>
> > >  #include <linux/types.h>
> > >  #include <linux/bpfptr.h>
> > >  #include <linux/bsearch.h>
> > > @@ -143,6 +144,7 @@ void btf_get(struct btf *btf);
> > >  void btf_put(struct btf *btf);
> > >  const struct btf_header *btf_header(const struct btf *btf);
> > >  int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr=
_sz);
> > > +
> >
> > ?
>
> Thanks, removed.
>
> > >  struct btf *btf_get_by_fd(int fd);
> > >  int btf_get_info_by_fd(const struct btf *btf,
> > >                        const union bpf_attr *attr,
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index e7a59e6462a9..ad5310fa1d3b 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -7743,17 +7743,12 @@ int btf_new_fd(const union bpf_attr *attr, bp=
fptr_t uattr, u32 uattr_size)
> > >
> > >  struct btf *btf_get_by_fd(int fd)
> > >  {
> > > -       struct btf *btf;
> > >         CLASS(fd, f)(fd);
> > > +       struct btf *btf;
> >
> > nit: no need to just move this around
>
> Ok, I can remove it. I moved it to form a reverse xmas tree,
> as I was already editing this function.

we don't enforce the, or adjust to, reverse xmas tree styling, so please do=
n't

>
> >
> >
> > >
> > > -       if (fd_empty(f))
> > > -               return ERR_PTR(-EBADF);
> > > -
> > > -       if (fd_file(f)->f_op !=3D &btf_fops)
> > > -               return ERR_PTR(-EINVAL);
> > > -
> > > -       btf =3D fd_file(f)->private_data;
> > > -       refcount_inc(&btf->refcnt);
> > > +       btf =3D __btf_get_by_fd(f);
> > > +       if (!IS_ERR(btf))
> > > +               refcount_inc(&btf->refcnt);
> > >
> > >         return btf;
> > >  }
> > > --
> > > 2.34.1
> > >
> > >

