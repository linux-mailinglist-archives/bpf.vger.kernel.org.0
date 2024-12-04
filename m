Return-Path: <bpf+bounces-46065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A4A9E37E9
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 11:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84DAB25C02
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 10:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C0018BC1D;
	Wed,  4 Dec 2024 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="W+2b//bJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77972B9B7
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308793; cv=none; b=sd9iwxyu1t0O7Nm5jU/cuft1HbfCRgCPovohZ68IS+O2e/lFNf9uVQKReQqsXxY6Ed1Hfl26+QtspMS0TXMdExD2Swi4UZ9H0C+KOAFsdx8u62TYiplsgrW8vn7yHwjCKi4SC8Qk6Xn0s6GHK97+j4Pk0c05lVkjzj6K0umiZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308793; c=relaxed/simple;
	bh=jjMb4drhHmXeHKQ6KnkBTUk3j0kOGrCLz2ZHDg7iyZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5uqaJxOC5bN/DQdVI+n2Fh2ztOImWKsNjaA0iu1YU2vLuRzWHmdY06f18jxJ11DmjuMSPPlcySrHODbzfPP6j/PCzEpY0b9alQDf6GK2dn0J3caE2EBK40C5LUVUYuXqR2l/eLKMc584RHjL+Rtkv+EqpjTvkIH5WWdj5e6b18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=W+2b//bJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso60685115e9.3
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 02:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733308790; x=1733913590; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gsTJHJnOfP2TjCS3oToZURujMQ9fOBK7YKUhaBxKj7E=;
        b=W+2b//bJPOc53QKHv4H6sc5/wcw1v8M/DfXohaEklEkiONoPQE7D8wSsqgykTPFGkW
         v1MNu/W+iu7GoE4s7uwAweuLANigiTii0IoLalIBOAj0+wxO27Yz8FB0lg1lLyW/GPpx
         YDqQ+YJEq7otP1a6YDgTBZq+oUh1Zc6KxV8X2WJRVaE97+RLrbS6HcSpnqNzZ6BFPwwp
         Bk3yNNpOoSm3LTpItCqNfyMYRARY79q8tO+mJ12q0nHkp44GrmXonBmtCsNCgEwbBQoe
         qnFQLXjbLaBT2pmDgoKfWQznoyb+8B03VLDK1pqkE2WF7odJi/4UxqO6N67WJHC65t8L
         T/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733308790; x=1733913590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gsTJHJnOfP2TjCS3oToZURujMQ9fOBK7YKUhaBxKj7E=;
        b=plFSizEp1BGqI094SewZkPExkax6mJlup5itPKAcfEVbdsRjfDV0LucN/QVxYWo5Rc
         qDcu9xJ+BzmgBoncui/w6yPS8AByuyaeC4PkhKLTfJhZneseKF+azcGhU+8qrFtG1TWl
         dPdHYtKVP8KWkznR6BxghGeSE7r2SXZn6aRjz3m8T+uCSSOkBE6LnCfN77wsUJqAj+iH
         5V/fTdMkFIaClhf2na/nOPuJKGLb/Q+atAbMNSu+eOS7q0t2wgnsGqMMW3BKWPvpGUiM
         VgnrtUMFfZRoL++B1I6uz356pKBvs6e77t4xWTSRVGq7EjZxuCzToDp4ZBK2FEmsl5eY
         gBbA==
X-Gm-Message-State: AOJu0Yw4rGctok1riMQyJBeCQxa3NdreNrrpplDVjiTk3Mlfz3zfynew
	I8+pIkHRPbvpKMstiGnoEMXe1kR79g36F35wfl45ffV+MsmanHyNf7P/qQLU7lM=
X-Gm-Gg: ASbGncvx/XnbB1AU6KvNrGu6LJ8hA+BKJnmjLUMtn8FTYxyYe0AGzcGL4+JS+kUUX8Q
	GfgIgcqMS7UawK93q+9s7hCHYGGl67BhUir62UVfF3pkHpZUjp+cWXucW1vj9O+pZvg0egfresp
	Q8HtZQpUG5EuNMAt0FFVbn9wXUY711VVwEyG9b2Uau8eTcj1s6vAzSSUxBcpVPy4+f4VOfeUj4C
	B0NHzaxE5k5wvlOYxsVu5PzmJMEeaw5CV2QpTA=
X-Google-Smtp-Source: AGHT+IHZhZnt76cbndrD+eokLK3BvrnVUAq/2skOyWHkXgDpwQ9EqEpFg1RVaC8vy7rJyZHldNPnvg==
X-Received: by 2002:a05:600c:35cf:b0:431:52b7:a499 with SMTP id 5b1f17b1804b1-434d0a07e76mr45474985e9.20.1733308789903;
        Wed, 04 Dec 2024 02:39:49 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d43b8557sm19950575e9.1.2024.12.04.02.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:39:49 -0800 (PST)
Date: Wed, 4 Dec 2024 10:42:03 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 1/7] bpf: add a __btf_get_by_fd helper
Message-ID: <Z1Ax+woX0zjYH+Qo@eis>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
 <20241203135052.3380721-2-aspsk@isovalent.com>
 <CAEf4BzZogXRtHgDLa1nm4neOEbd+b2+UX_fog2hpgYJ5vr-X9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZogXRtHgDLa1nm4neOEbd+b2+UX_fog2hpgYJ5vr-X9A@mail.gmail.com>

On 24/12/03 01:25PM, Andrii Nakryiko wrote:
> On Tue, Dec 3, 2024 at 5:48 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > Add a new helper to get a pointer to a struct btf from a file
> > descriptor. This helper doesn't increase a refcnt. Add a comment
> > explaining this and pointing to a corresponding function which
> > does take a reference.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  include/linux/bpf.h | 17 +++++++++++++++++
> >  include/linux/btf.h |  2 ++
> >  kernel/bpf/btf.c    | 13 ++++---------
> >  3 files changed, 23 insertions(+), 9 deletions(-)
> >
> 
> Minor (but unexplained and/or unnecessary) things I pointed out below,
> but overall looks good
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index eaee2a819f4c..ac44b857b2f9 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2301,6 +2301,14 @@ void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
> >  struct bpf_map *bpf_map_get(u32 ufd);
> >  struct bpf_map *bpf_map_get_with_uref(u32 ufd);
> >
> > +/*
> > + * The __bpf_map_get() and __btf_get_by_fd() functions parse a file
> > + * descriptor and return a corresponding map or btf object.
> > + * Their names are double underscored to emphasize the fact that they
> > + * do not increase refcnt. To also increase refcnt use corresponding
> > + * bpf_map_get() and btf_get_by_fd() functions.
> > + */
> > +
> >  static inline struct bpf_map *__bpf_map_get(struct fd f)
> >  {
> >         if (fd_empty(f))
> > @@ -2310,6 +2318,15 @@ static inline struct bpf_map *__bpf_map_get(struct fd f)
> >         return fd_file(f)->private_data;
> >  }
> >
> > +static inline struct btf *__btf_get_by_fd(struct fd f)
> > +{
> > +       if (fd_empty(f))
> > +               return ERR_PTR(-EBADF);
> > +       if (unlikely(fd_file(f)->f_op != &btf_fops))
> > +               return ERR_PTR(-EINVAL);
> > +       return fd_file(f)->private_data;
> > +}
> > +
> >  void bpf_map_inc(struct bpf_map *map);
> >  void bpf_map_inc_with_uref(struct bpf_map *map);
> >  struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 4214e76c9168..69159e649675 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -4,6 +4,7 @@
> >  #ifndef _LINUX_BTF_H
> >  #define _LINUX_BTF_H 1
> >
> > +#include <linux/file.h>
> 
> do we need this in linux/btf.h header?

Thanks, removed.

> >  #include <linux/types.h>
> >  #include <linux/bpfptr.h>
> >  #include <linux/bsearch.h>
> > @@ -143,6 +144,7 @@ void btf_get(struct btf *btf);
> >  void btf_put(struct btf *btf);
> >  const struct btf_header *btf_header(const struct btf *btf);
> >  int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
> > +
> 
> ?

Thanks, removed.

> >  struct btf *btf_get_by_fd(int fd);
> >  int btf_get_info_by_fd(const struct btf *btf,
> >                        const union bpf_attr *attr,
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index e7a59e6462a9..ad5310fa1d3b 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -7743,17 +7743,12 @@ int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
> >
> >  struct btf *btf_get_by_fd(int fd)
> >  {
> > -       struct btf *btf;
> >         CLASS(fd, f)(fd);
> > +       struct btf *btf;
> 
> nit: no need to just move this around

Ok, I can remove it. I moved it to form a reverse xmas tree,
as I was already editing this function.

> 
> 
> >
> > -       if (fd_empty(f))
> > -               return ERR_PTR(-EBADF);
> > -
> > -       if (fd_file(f)->f_op != &btf_fops)
> > -               return ERR_PTR(-EINVAL);
> > -
> > -       btf = fd_file(f)->private_data;
> > -       refcount_inc(&btf->refcnt);
> > +       btf = __btf_get_by_fd(f);
> > +       if (!IS_ERR(btf))
> > +               refcount_inc(&btf->refcnt);
> >
> >         return btf;
> >  }
> > --
> > 2.34.1
> >
> >

