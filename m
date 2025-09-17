Return-Path: <bpf+bounces-68714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07277B8203C
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 23:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF1B4A63ED
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 21:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D77E246BB7;
	Wed, 17 Sep 2025 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9UpYuSw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5234BA30
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145576; cv=none; b=e9ahEGUwCrMxuq6m5Kl5+FTKrMWWMQN9Le/ATUIW68SAH1P0D0OkVx/NACHB4mZ8bSW5fRz3GqHXtxLy/iBT7EQrw/OHPhjus2/nRMj1dOVV//pJHTgpKKL8W8iUH9E2OeatzFLpS8FvZnZc/b/jknhYumtqTZiuvInsNcXDkBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145576; c=relaxed/simple;
	bh=pEw2mJH5mYnB1YQ8JiL5o9G2H5TKasQwDdSGSYnlYbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XByI4gSOu0sk8L1mLgOVUcT8bM6b43yi4shfc2SLG/Mx5sE0i/AcglRGTqj38e3bRoJKYnDGdiTrmWDw3EOM4m807zGwJ7KtzmLhx2urTdpIRF/WsSDUhpXYU/tpkSagJBP7apaqI0rNUsbcAFIWF2sMuhsIhqqP+Lgr7EwFJGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9UpYuSw; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b55003f99fdso133230a12.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758145575; x=1758750375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RBgceh57dk9MKJNMLyUTtF0Kco4AKFAzGFD9Lw3sEY=;
        b=A9UpYuSwjHCsHEUf24pu/mkD0WvnOXfZ3fLHOIzGX+NbHHCM4ijCCBaGqWN41pmWoh
         CTHdqG0PtGWqojb8PADb3JRgmGArhlqG+v3mtk6WsgvJIatGsBqMbmDFtAJ4NCYESmG5
         kjHVhbrekQe0PXCMBM1DML3kVAMExcfYK5zZHdTKrfcaBjfOSmNImfKKoXaROtb/IZNs
         xj9hnlIALon+2NyrP4Pg55z2WWyhZ4rYgXwHVbOerg2tywYDKaQOWKldll1fl0Q0UIRR
         EzxfpApJPiOnSiVgqZfiff7fWzdzAuyDO6IgwfBHYITyTTsw7P/U89+ecR6n3macyL2c
         t6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145575; x=1758750375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RBgceh57dk9MKJNMLyUTtF0Kco4AKFAzGFD9Lw3sEY=;
        b=TUp/fSXJpzjkE1Q8IGuVvQMZteaBCTd23jc4MOghATKTWGZLpFsr9DHEg2IoowgcAZ
         lkRxQYn66toXdefU0u3VPvOFoPVgXTCIB58LSe64qp11UWbixzYifRV8kJRPsaOGNSAo
         9mq2YdbauTxN3Y68GY2wvZvtmFW6KA/VrERQse6VTE48EepaVG97O60ChZzwhKgKo+fn
         23Hr3IzfboRSIJWutcZk8c84jvY6zKB2G1kd0QFDCrGUMPUmL8bOoqYFhPdyIBEBCNhl
         NauKKaVkPk2PYoJnJxqb8ZEUxVa5qG5VSzPHicgSkXQVnRkLvYdfmdjH0eg0/SorJacG
         99ow==
X-Gm-Message-State: AOJu0YzSnRap4Moqw+zSgJ/xi8Bm06Qhahs15K4GDR6UCAtTrIYyVu3H
	sjM6498ugmmNrKF1fM/ppHfI5gVCZjZAC0yTRlx7cY3vCkHMJUSuQKkY8F3RQ7vuhOgmSaFvoum
	lNHN14iUN81qgQI9sjm1lEyG6p98h/OiCYQ==
X-Gm-Gg: ASbGncvuKgMmIzxbMnZl8oOzxHWv05Y8x14jRoL1tmGjCdnSydrzaBy8m7dhnj/OUBk
	1MrTYng92Oto7gCO/ysqhaRE7sAg7lj1kLpCfH5B/a+WCagCBPk7lRZPQ1duHwAOkxHehn3glzS
	u0kJUgMrpCyQpG7hAuG6h2SHWm4ESRqwWw1vP0Hy6cBF9o+B9Io4DqMcv9XwM8brirkcMuHxTfY
	5aDra19b4rXIow1vxfQN7Q=
X-Google-Smtp-Source: AGHT+IHgIXzxGSQOaPbDNmH0C8oz88uK4OMElKxbeA04WQu+eizKG7lAnQbgFFDgp4h6gqWxL0WC+MQb6/jxJVO/5BE=
X-Received: by 2002:a17:90b:3bcb:b0:32b:96fa:5f46 with SMTP id
 98e67ed59e1d1-32ee3ec6823mr3905869a91.5.1758145574656; Wed, 17 Sep 2025
 14:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911163328.93490-1-leon.hwang@linux.dev> <20250911163328.93490-6-leon.hwang@linux.dev>
 <CAEf4BzZ5R-H+XL6TPftv6KGFnowA1yeCXii7OZ9uq_A-zFrjJg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ5R-H+XL6TPftv6KGFnowA1yeCXii7OZ9uq_A-zFrjJg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Sep 2025 14:46:02 -0700
X-Gm-Features: AS18NWDsHzOdcWQ2JHa-vnWOT-4jPDv5AMDCbvPaCqnu-a-93I9509VbLnJc2eE
Message-ID: <CAEf4BzY233bt3NdVu8tp7VVmyNWVk-DQB+wQ-uchBJA4Ya3p-g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 5/6] libbpf: Add common attr support for map_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, menglong8.dong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 2:45=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 11, 2025 at 9:33=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
> >
> > With the previous patch adding common attribute support for
> > BPF_MAP_CREATE, it is now possible to retrieve detailed error messages
> > when map creation fails by using the 'log_buf' field from the common
> > attributes.
> >
> > This patch extends 'bpf_map_create_opts' with two new fields, 'log_buf'
> > and 'log_size', allowing users to capture and inspect these log message=
s.
> >
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> >  tools/lib/bpf/bpf.c | 16 +++++++++++++++-
> >  tools/lib/bpf/bpf.h |  5 ++++-
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index 27845e287dd5c..5b58e981a7669 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -218,7 +218,9 @@ int bpf_map_create(enum bpf_map_type map_type,
> >                    const struct bpf_map_create_opts *opts)
> >  {
> >         const size_t attr_sz =3D offsetofend(union bpf_attr, map_token_=
fd);
> > +       struct bpf_common_attr common_attrs;
> >         union bpf_attr attr;
> > +       __u64 log_buf;
>
>
> const char *
>
> >         int fd;
> >
> >         bump_rlimit_memlock();
> > @@ -249,7 +251,19 @@ int bpf_map_create(enum bpf_map_type map_type,
> >
> >         attr.map_token_fd =3D OPTS_GET(opts, token_fd, 0);
> >
> > -       fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> > +       log_buf =3D (__u64) OPTS_GET(opts, log_buf, NULL);
>
> no u64 casting just yet
>
> > +       if (log_buf) {
> > +               if (!feat_supported(NULL, FEAT_EXTENDED_SYSCALL))
> > +                       return libbpf_err(-EOPNOTSUPP);
>
> um.. I'm thinking that it would be better usability for libbpf to
> ignore provided log if kernel doesn't support this feature just yet.
> Then users don't have to care, they will just opportunistically
> provide buffer and get extra error log, if kernel supports this
> feature. Otherwise, log won't be touched, instead of failing an API
> call.
>
> > +
> > +               memset(&common_attrs, 0, sizeof(common_attrs));
> > +               common_attrs.log_buf =3D log_buf;
>
> ptr_to_u64(log_buf) here
>
> > +               common_attrs.log_size =3D OPTS_GET(opts, log_size, 0);
> > +               fd =3D sys_bpf_extended(BPF_MAP_CREATE, &attr, attr_sz,=
 &common_attrs,
> > +                                     sizeof(common_attrs));
> > +       } else {
> > +               fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> > +       }
> >         return libbpf_err_errno(fd);
> >  }
> >
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > index 38819071ecbe7..3b54d6feb5842 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -55,9 +55,12 @@ struct bpf_map_create_opts {
> >         __s32 value_type_btf_obj_fd;
> >
> >         __u32 token_fd;
> > +
> > +       const char *log_buf;
> > +       __u32 log_size;

also, what about that log_level ?

> >         size_t :0;
> >  };
> > -#define bpf_map_create_opts__last_field token_fd
> > +#define bpf_map_create_opts__last_field log_size
> >
> >  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
> >                               const char *map_name,
> > --
> > 2.50.1
> >

