Return-Path: <bpf+bounces-46133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6020B9E4FBE
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 09:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC2F165F52
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 08:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D311C3BFC;
	Thu,  5 Dec 2024 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="iyD8pVER"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE31AF0DA
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387475; cv=none; b=HcxZuLZdo4QYzkKDdHH8GZR/7FDX2eK52eCWKG3uiGwtx3534nJDBCXndYPz5X7nTacYzyLjZ5CnAeE+P5VsqZRbGH+wIE0BSB9dAwu70JG+uoWctIX0rOcqLxx8j0AhnEP8rd1VI+1lg1f4kYYqNchAJKLubVC/fP9gBS7y680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387475; c=relaxed/simple;
	bh=StomAU/lvVTu3uuXaqpvPwaWEXVsApt0MhGnePHO3oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxE5fTxUncZpzxbM9odRi445dYC1BN1SPxZv6h2c1FkcNRazz1qoaoGat8+32e4iJy/PjBcfXZ3WuwqYWh7QMKHY8knwjicY0CNRtzB65CPJMqfGz2vPFsjM+yXgF9jVyse2bDXuJNsCuoBlTEENhKcoDD6JW46re5EvVURN7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=iyD8pVER; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e3621518so536525f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 00:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733387471; x=1733992271; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fv9EOy8WRYpVRy3lnznsnj2jgH8HiMPoZC1ybfGSd98=;
        b=iyD8pVERYVOOeugRc1Bok/KhC89RoACJ/vykKJwNkR+Rtouq9+Ma3BVUx8M7vEM+zw
         /QEYtFjd7CZJFPXdkVaZtldg6nxGMshAaP3iXNakLYgi+P7Er0OFPd2EXNkLE0KDJxII
         YqbNjlfGvPB+32eFurtOlksDkolUmGDpEJr38xL3Z0pt8IfoMkjDX0lNS8VBsEih95EQ
         /Eu/Mfcn5DIvG2amQYeBgPJOl68OwUtS9RSUkBHRd16S5ydCSBtJjD47PQZr6GcdAwxE
         ay/3L5WnrLTErzEcjbwegh4Wp9JtkLhqQB8fx7mYK8zPJhcmRYpUblm7Db8W0AQ97F2P
         zR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733387471; x=1733992271;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fv9EOy8WRYpVRy3lnznsnj2jgH8HiMPoZC1ybfGSd98=;
        b=vORKaOaQPnSQ/UvSrF3hLRldEdxhjP2frUY61CVKrl/bdt54cXYMfWNtCN3IQQ0QCs
         imETwewMNlZMFfLOnpNh0DLKnM4mM83hmcq3Xou+OSd8kq8ylq4AL5xcAkk67HsQbNc2
         QBKzbFeJ++bWsZBALC5bVrX+A8UjLtHpNE5hW5jlYowNe9KvBzzNsxd7WXuivLcKk9BH
         r+jheYDr8PI0x8YcrYxJHgGQMW2997gpWpC0/hSXCrQeJ25G6hpo0MJLOFjRULh219gJ
         2gIUo9h3Ka7tkOWUWbf6u5LqDdNs9A23VHrOxUDtP6zcWn/ol2xrRJGBwvKthmb8bwk5
         7tsQ==
X-Gm-Message-State: AOJu0Yx6iXNKYpCWpVH1I/X6VCrkWXyP7LQlnvA+qe+pKVXZ5kemqY7H
	oJnClXqUF/dEDueGxHKLEGMYQ7pZCPL5XRs6v99dyrsoHn8llSvHz0JWpquiTqM=
X-Gm-Gg: ASbGncs57mb9znz/OJOo8hXJAAr+CpUKhTWqTapbpu39O7wU6dlQh511zdrAky/8DbD
	7ZhdW1mDEwHOV8BTCfrgISrcebcXl6LDuKm4FT6d9Io9s5PZxjIedFVY4IWtvzDppyR+P8t0/yK
	Wa8trOmvhwEbNf8lHhajYzMlA++TmyTZaZjd2roAJKRJ8Ud4o2ZUNqM1sn1X+CK70dV7wKq3Y7G
	spn4BUipLO6qyMIUoIk6MA/hVc6Uc34IN5JRKQ=
X-Google-Smtp-Source: AGHT+IHOM4uZ6qIBWQwWngOB5PLA99nGE1fEv9MVdqAX8VyWDOItSPpr2fQqDiZsWTKSlvi7BLOXxg==
X-Received: by 2002:a05:6000:79d:b0:385:f2d2:2ef0 with SMTP id ffacd0b85a97d-385fd53ece7mr8708938f8f.41.1733387470895;
        Thu, 05 Dec 2024 00:31:10 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46f1bsm1296051f8f.61.2024.12.05.00.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 00:31:10 -0800 (PST)
Date: Thu, 5 Dec 2024 08:33:22 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 1/7] bpf: add a __btf_get_by_fd helper
Message-ID: <Z1FlUnZrM/Q9EOuI@eis>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
 <20241203135052.3380721-2-aspsk@isovalent.com>
 <CAEf4BzZogXRtHgDLa1nm4neOEbd+b2+UX_fog2hpgYJ5vr-X9A@mail.gmail.com>
 <Z1Ax+woX0zjYH+Qo@eis>
 <CAEf4BzYMNtr3dYvsU8jbqkDos9jg6a-FRmBcW8dkMi3zrE+8LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYMNtr3dYvsU8jbqkDos9jg6a-FRmBcW8dkMi3zrE+8LQ@mail.gmail.com>

On 24/12/04 09:58AM, Andrii Nakryiko wrote:
> On Wed, Dec 4, 2024 at 2:39 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > On 24/12/03 01:25PM, Andrii Nakryiko wrote:
> > > On Tue, Dec 3, 2024 at 5:48 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > >
> > > > Add a new helper to get a pointer to a struct btf from a file
> > > > descriptor. This helper doesn't increase a refcnt. Add a comment
> > > > explaining this and pointing to a corresponding function which
> > > > does take a reference.
> > > >
> > > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > > ---
> > > >  include/linux/bpf.h | 17 +++++++++++++++++
> > > >  include/linux/btf.h |  2 ++
> > > >  kernel/bpf/btf.c    | 13 ++++---------
> > > >  3 files changed, 23 insertions(+), 9 deletions(-)
> > > >
> > >
> > > Minor (but unexplained and/or unnecessary) things I pointed out below,
> > > but overall looks good
> > >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index eaee2a819f4c..ac44b857b2f9 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -2301,6 +2301,14 @@ void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
> > > >  struct bpf_map *bpf_map_get(u32 ufd);
> > > >  struct bpf_map *bpf_map_get_with_uref(u32 ufd);
> > > >
> > > > +/*
> > > > + * The __bpf_map_get() and __btf_get_by_fd() functions parse a file
> > > > + * descriptor and return a corresponding map or btf object.
> > > > + * Their names are double underscored to emphasize the fact that they
> > > > + * do not increase refcnt. To also increase refcnt use corresponding
> > > > + * bpf_map_get() and btf_get_by_fd() functions.
> > > > + */
> > > > +
> > > >  static inline struct bpf_map *__bpf_map_get(struct fd f)
> > > >  {
> > > >         if (fd_empty(f))
> > > > @@ -2310,6 +2318,15 @@ static inline struct bpf_map *__bpf_map_get(struct fd f)
> > > >         return fd_file(f)->private_data;
> > > >  }
> > > >
> > > > +static inline struct btf *__btf_get_by_fd(struct fd f)
> > > > +{
> > > > +       if (fd_empty(f))
> > > > +               return ERR_PTR(-EBADF);
> > > > +       if (unlikely(fd_file(f)->f_op != &btf_fops))
> > > > +               return ERR_PTR(-EINVAL);
> > > > +       return fd_file(f)->private_data;
> > > > +}
> > > > +
> > > >  void bpf_map_inc(struct bpf_map *map);
> > > >  void bpf_map_inc_with_uref(struct bpf_map *map);
> > > >  struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
> > > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > > index 4214e76c9168..69159e649675 100644
> > > > --- a/include/linux/btf.h
> > > > +++ b/include/linux/btf.h
> > > > @@ -4,6 +4,7 @@
> > > >  #ifndef _LINUX_BTF_H
> > > >  #define _LINUX_BTF_H 1
> > > >
> > > > +#include <linux/file.h>
> > >
> > > do we need this in linux/btf.h header?
> >
> > Thanks, removed.
> >
> > > >  #include <linux/types.h>
> > > >  #include <linux/bpfptr.h>
> > > >  #include <linux/bsearch.h>
> > > > @@ -143,6 +144,7 @@ void btf_get(struct btf *btf);
> > > >  void btf_put(struct btf *btf);
> > > >  const struct btf_header *btf_header(const struct btf *btf);
> > > >  int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
> > > > +
> > >
> > > ?
> >
> > Thanks, removed.
> >
> > > >  struct btf *btf_get_by_fd(int fd);
> > > >  int btf_get_info_by_fd(const struct btf *btf,
> > > >                        const union bpf_attr *attr,
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index e7a59e6462a9..ad5310fa1d3b 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -7743,17 +7743,12 @@ int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
> > > >
> > > >  struct btf *btf_get_by_fd(int fd)
> > > >  {
> > > > -       struct btf *btf;
> > > >         CLASS(fd, f)(fd);
> > > > +       struct btf *btf;
> > >
> > > nit: no need to just move this around
> >
> > Ok, I can remove it. I moved it to form a reverse xmas tree,
> > as I was already editing this function.
> 
> we don't enforce the, or adjust to, reverse xmas tree styling, so please don't

Ok, thanks, good to know. I've removed this diff.

> >
> > >
> > >
> > > >
> > > > -       if (fd_empty(f))
> > > > -               return ERR_PTR(-EBADF);
> > > > -
> > > > -       if (fd_file(f)->f_op != &btf_fops)
> > > > -               return ERR_PTR(-EINVAL);
> > > > -
> > > > -       btf = fd_file(f)->private_data;
> > > > -       refcount_inc(&btf->refcnt);
> > > > +       btf = __btf_get_by_fd(f);
> > > > +       if (!IS_ERR(btf))
> > > > +               refcount_inc(&btf->refcnt);
> > > >
> > > >         return btf;
> > > >  }
> > > > --
> > > > 2.34.1
> > > >
> > > >

