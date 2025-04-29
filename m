Return-Path: <bpf+bounces-56971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118BEAA16B3
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 19:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51CC2166D1E
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 17:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D0F22DF91;
	Tue, 29 Apr 2025 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g43szRVv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F61E82C60;
	Tue, 29 Apr 2025 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948237; cv=none; b=sltmwWyDsQAwUXHJ4BxePOXcLnAWiZjvt2/BxC81fgxMVAQLT3DfoAgyRO4L68BiFQqec29HFRNgbx994ojuKQOwPObTdVUQJaGTqgAZpwL4LoOW6K5D6q9VmfOYk+S3BUJ/Ax1V6GJf8etiGc/+PPWpnPHibu/yKhTZj8ku058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948237; c=relaxed/simple;
	bh=J40wyeNhpWU4brfiX4kXhvh3pSUU7Zeqd0HHOZCDBmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syYiQE+1dlrY3Y5295xfSJbV5V04DnvU1YwPBoEt5nEk9/oSHRapgOXCxF03u+gefPCdSYl//vMvIlTNJNzZeFisyIKwWgcxIGdY5qAuqaxPUkSXC9sy7ljCEYd9xNvmMjNpXGCdH2VnAw4cRGTkaXKordMBCKjoTE7OfPJ70xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g43szRVv; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso2369096276.1;
        Tue, 29 Apr 2025 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745948233; x=1746553033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQLA1DjAwGvc147yeNV2dgLh47BJHeWkb7DFfNZy16I=;
        b=g43szRVveIt+ou0HhTRh+SHQU2qJRl4AzezmNV9xT5nxzsh675cjyb6t9nngMs9HVx
         AF6SbUMwdO85gyZL4e9+9FkBNkhMiuPLXl9HAyxm6wRZ32WzA+zZ+ro0QAEPS/2ayxf2
         HQtwg+qb3El0X9fXvIn1XvqLrUVMX1g33pL1Opbhqaq2fDQwye7tZh4kgZUKLqKz+goW
         cQU5IrcS4C/OR/8gmcu758R9Oe4y00FN4v8Zax30tmDz2TaR9b/LU3opY/J1XStTty4n
         Cn+8swNu20sjOAwMTdY0eY/Nb6HOV7x9rmy2qXQ7W9nu7AExzYtWOh92zp56CxgrYpBX
         yesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745948233; x=1746553033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQLA1DjAwGvc147yeNV2dgLh47BJHeWkb7DFfNZy16I=;
        b=aln4RBbPrWV5Hhn9gTUMoPCMANIMTMlTAV4ndas743Vhc24/UQc1JnDcLE5z19R/7w
         J6lxsz6KVCGn8+G8CMtz0GVPJxEIQHIqGKdFV96JrBV5ukRJ4nQcRB2wWrt1DTMM1GW5
         x9iamaIUKDpNvRTkgwM1iBbM7vapypK1uZ30XxXVqDhC4XAmW3fJjZbTxPfPaRg6MZ4S
         nmD2Kl0NWmTKh+gPpLlxmhPraedI75QK/tsbrENmwtp89sgLLxjPMPlCz1CVARHmmD/m
         S3muH22elIa+hN6OnSTrfv5vcNUtoRH1tfQw4Oll1q0maKzeYdHE5LjPs4PkR52AKN9r
         Lt0w==
X-Forwarded-Encrypted: i=1; AJvYcCUwPESeETFiqfp6xBq8nzTQo7+BhAUwe1uFR2VuMnI1wm54CfKPu0q9DiRHR2d3Ef/z7IQP/3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+izycH5QKSFIQozSV0fue6PCff/+iu+DQQS6fCWvXv7by9mNj
	gYJA1jETyeJ/Yn0Owatz3Cb3tRzOx7dpjgpdnVFnEdYgah5T1YsbeTVt5BhxytU1cyg9NkQx1hV
	tak5N6UAQN31Jtra/2+FuNam9rGQ=
X-Gm-Gg: ASbGncsfXkWNt5FX8PrYIll1napZMbOqvmN040cBTjA1U08jInBxU+QJie0BG77VY9v
	DQ0jUuHXIFDdU8NZBelu6NNF9wwj0aAzQsb4AaKQmEd8VVFvI6cADPGSIFM82MmmG4EvSnFP5Yr
	wGVG77R20m9M9wnu2heqVkZmkrl8lpwy+fi7lnTA==
X-Google-Smtp-Source: AGHT+IHa2XNC3KDB6z+P2WVheariWz4E5Kj+Us6RNhQd57YTNaF1OTvjOUZxtYR+s+fRyqS+YFEXTNuQEb88QBlDJds=
X-Received: by 2002:a05:6902:2388:b0:e73:930:cc30 with SMTP id
 3f1490d57ef6-e73eaadcdf4mr42956276.16.1745948233589; Tue, 29 Apr 2025
 10:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422225808.3900221-1-ameryhung@gmail.com> <ae064b92-1d9d-47a8-ac26-1172076e5bcb@linux.dev>
In-Reply-To: <ae064b92-1d9d-47a8-ac26-1172076e5bcb@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 29 Apr 2025 10:37:02 -0700
X-Gm-Features: ATxdqUEUeaF_2-GyhGA3DDYRIWeHqzc4XQhfhed_VBzY0Z4YY0lWFR9QmuserHc
Message-ID: <CAMB2axP9PZOPjKMfod40bo=t==vjCG0TvJj5SW67X69K-gSiww@mail.gmail.com>
Subject: Re: [PATCH bpf-next/net] bpf: net_sched: Fix using bpf qdisc as
 default qdisc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	xiyou.wangcong@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 10:30=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 4/22/25 3:58 PM, Amery Hung wrote:
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index db6330258dda..1cda7e7feb32 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -208,7 +208,7 @@ static struct Qdisc_ops *qdisc_lookup_default(const=
 char *name)
> >
> >       for (q =3D qdisc_base; q; q =3D q->next) {
> >               if (!strcmp(name, q->id)) {
> > -                     if (!try_module_get(q->owner))
> > +                     if (!bpf_try_module_get(q, q->owner))
> >                               q =3D NULL;
> >                       break;
> >               }
> > @@ -238,7 +238,7 @@ int qdisc_set_default(const char *name)
> >
> >       if (ops) {
> >               /* Set new default */
> > -             module_put(default_qdisc_ops->owner);
> > +             bpf_module_put(ops, default_qdisc_ops->owner);
>
> The first arg, should it be the "default_qdisc_ops" instead?
>

You are right. I will fix this sloppy mistake and resend.

Thanks,
Amery

>
> >               default_qdisc_ops =3D ops;
> >       }
> >       write_unlock(&qdisc_mod_lock);

