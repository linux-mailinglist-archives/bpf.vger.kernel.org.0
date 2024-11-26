Return-Path: <bpf+bounces-45622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDB79D9BDD
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 17:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4C21626A2
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 16:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F941D90A2;
	Tue, 26 Nov 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hynjgtro"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0431D7E42
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639982; cv=none; b=pWx0cRep9wR7wQgt1jDuXRspQOwXXYFWnL6IYhNvKMlN7IAboWMuoF+RZhqABWXFcWFteMgd2CgD1Y91aiqQA+DuamRhu72h9tKDO2qhW1Qo90WfBs8hQqK+rkkx3lf1GfH4Y3X2feTkmTZQjDGK63C2qPOdU9jAFIhF6dBeTWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639982; c=relaxed/simple;
	bh=Xd7VW0c0UvpPE9YJ+np+yiKN7fKN0VSSMrbc8aFupKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsx1qIi2ids3xIZgrSd6d6Fayn0o449HbtsbuV7SRCngJZWEQBd06Gr81/oPXMs7d9RZ/h6wV3PEIV+nqsnAuKwC0ihyS3TDHlOyqpCzYoto2iudt+q2LivCGLkMzuSZXyfMYhdxZvRbxx8g+XkzE8jIJfscvA7w979IdIcedns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hynjgtro; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3824aef833bso4235689f8f.0
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 08:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732639979; x=1733244779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn0cRt1BIxcZdB4ocTOP13lXDlEvZqXsjfogUbFkJ+4=;
        b=hynjgtros9iHIABm7QWMJXB284Rl/iIvX3CmS91TmjrSDiprJFv1RjWwykXXCodZNT
         Bqth4EQFSIEjGTPbjK0yswrCvBLnOLIigtqevXqbju94/UlUHxAIpXe6Zobl9VfZC3fs
         IUOYGPlHB8II6jPcWuyGWsv02/MLVdvQTLiD7K9r5R1+necifi1Rt3u5kPrskfunitVD
         al05BOxWZbodQTDuSANtepRYui7qoPaVNbk7u8X3G8RXVyp21wc+S3DmATRS+w7yo0e6
         vogW8TECWzxhG8aoHLn2ZJ16TaVbQTA1SB3oivANgfHWq2fdmG7YHp1oCTyrDmpyt5do
         POWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732639979; x=1733244779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn0cRt1BIxcZdB4ocTOP13lXDlEvZqXsjfogUbFkJ+4=;
        b=RSoCunfIdG6hhzIXQyNXCDE/egbwg9+rw6AbOPU1k3bnr1RWuOKahFTzFSlduvVNG3
         t8A9XSA4TuOOis02mhwlTRv2JH3mVa/2uC4zXUj9lNMSi+D5JBH3Kyb9ShbLfSbTHZAx
         lRaXPbgN1nepmKaYr3LskrDSpQ+DZe4DZi7+zAWcyjinjst8CNuRIAT5DEDwNEa+Lue4
         6SOXwy4thKPSw6FUIH4oxwQYZ1EM2uPKlCUYfmhBpTFgTesiFXIj2o2D7fcexpc0Z3Wk
         E5NhMkn+FHAB3xsYmVeJsm/Vmohj75YJWWjmzCFxw3szLrJWPrY/hOwHGVYhSikHuyzG
         A91Q==
X-Gm-Message-State: AOJu0YztahnyCvkUg7ldIYtkHBElFPlge7nu0T7ap2MLC4sTkhq4eNr1
	TlzVrHDF8trwySj8CIVq7EoqflH3k8oUyW/c+LoCM9bgSGlll1GQqVWQMwaMxEIbQ4p9BmOCcEg
	W2J+kIA7fPgeExPwKMP+TiIK5rN+fuVuM
X-Gm-Gg: ASbGncucEAuRRZteu7mzmZzFetthQbc4iq7Xkr3ieoFI6m5enkioPTpxGhQPG7xvy8E
	qZtZAym577I9qNomm/C6YBp3Row0KraeT6Vgm6wpRm2hXsCY=
X-Google-Smtp-Source: AGHT+IGhjtLdhZ4FzunF5aUgPwkRKadjtyVPSklGr2jBruYXF44xd5E5FYUT/+3rhrOKoTixfU1nd/X9E1RSBra+v10=
X-Received: by 2002:a05:6000:178e:b0:37d:3650:fae5 with SMTP id
 ffacd0b85a97d-38260be4129mr13062597f8f.52.1732639979028; Tue, 26 Nov 2024
 08:52:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119101552.505650-1-aspsk@isovalent.com> <20241119101552.505650-2-aspsk@isovalent.com>
 <CAADnVQ+MdboMD8SGyx2xSbJ3+YL2HgwKAZvj+S49G3x0gqKLXw@mail.gmail.com> <Z0X4VqTxbT8+NAuW@eis>
In-Reply-To: <Z0X4VqTxbT8+NAuW@eis>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Nov 2024 08:52:47 -0800
Message-ID: <CAADnVQJNixZnDmujV7x--aDfN3cE02hWrqTJfRkb5NS-=pjnkw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/6] bpf: add a __btf_get_by_fd helper
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 8:30=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> On 24/11/25 05:31PM, Alexei Starovoitov wrote:
> > On Tue, Nov 19, 2024 at 2:17=E2=80=AFAM Anton Protopopov <aspsk@isovale=
nt.com> wrote:
> > >
> > > Add a new helper to get a pointer to a struct btf from a file
> > > descriptor which doesn't increase a refcount.
> > >
> > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > ---
> > >  include/linux/btf.h | 13 +++++++++++++
> > >  kernel/bpf/btf.c    | 13 ++++---------
> > >  2 files changed, 17 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > index 4214e76c9168..050051a578a8 100644
> > > --- a/include/linux/btf.h
> > > +++ b/include/linux/btf.h
> > > @@ -4,6 +4,7 @@
> > >  #ifndef _LINUX_BTF_H
> > >  #define _LINUX_BTF_H 1
> > >
> > > +#include <linux/file.h>
> > >  #include <linux/types.h>
> > >  #include <linux/bpfptr.h>
> > >  #include <linux/bsearch.h>
> > > @@ -143,6 +144,18 @@ void btf_get(struct btf *btf);
> > >  void btf_put(struct btf *btf);
> > >  const struct btf_header *btf_header(const struct btf *btf);
> > >  int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr=
_sz);
> > > +
> > > +static inline struct btf *__btf_get_by_fd(struct fd f)
> > > +{
> > > +       if (fd_empty(f))
> > > +               return ERR_PTR(-EBADF);
> > > +
> > > +       if (unlikely(fd_file(f)->f_op !=3D &btf_fops))
> > > +               return ERR_PTR(-EINVAL);
> > > +
> > > +       return fd_file(f)->private_data;
> > > +}
> >
> > Maybe let's call it __btf_get() and place it next to __bpf_map_get() ?
> > So names and function bodies are directly comparable?
>
> I named it so because the corresponding helper which is taking a ref is n=
amed
> btf_get_by_fd(). And btf_get() is actually increasing a refcnt. In the bp=
f_map
> case naming is a bit different (and also not super-consistent,
> bpf_map_inc/bpf_map_put to +- refcnt).

I see. __btf_get_by_fd() is fine then.
Only place it next to __bpf_map_get() and add a comment that
double underscore helpers don't inc refcnt while correspoing bpf_map_get()
and btf_get_by_fd().

> Do you want me to make names more
> consistent, globally?

No. let's avoid the churn.

