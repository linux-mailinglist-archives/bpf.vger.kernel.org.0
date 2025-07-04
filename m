Return-Path: <bpf+bounces-62427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CBFAF9A67
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF9A87B63C4
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4D31F4615;
	Fri,  4 Jul 2025 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFMHm0Eu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B651E7C1B
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653065; cv=none; b=KBmO+pAgFaDd6f1nsyO5mMfexkix0qeMeOeps2fRnHz00+357Bd67fntbEds4+JZ+O+cmg6pWdg6NU0X/HNzfI8K17i6KqI8/n/nXlOIe+WsagoEyEK5nBGLF3dKGNtseKod3ttWexum9x+/8qsMWAWKgA2wMERfcJ/bV34Xbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653065; c=relaxed/simple;
	bh=xLtbvc2FzzV+MS84ZC8E1GaY98gcJEssSjBMgL/ne50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3rqYlbcGu+oZb9JiRV+CMCKHrog3efaIS41/ALi0un21VgCEnXOitf7DDAFwcmfRJ15RDiH6O9LxDzdG2e8PSfDjf079miyDPhWgRhJBBy+UVJJCGHhEwUnirnNJSUrRMdE/AsrDXpiTpi6bHlh/9HPyADWtdsIgzzyQV2CfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFMHm0Eu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so988526f8f.2
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751653062; x=1752257862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0LubEeA7QtYGWt5v3ZfzLKEULmI0rQlXV2PAkZHwzY=;
        b=jFMHm0EuRD7aRBRQj/GrRJnXftCaDGA0XWY9mYD1FS1O/QwZq81mkuMzcS6AWBPjZ8
         tCIf0kRECYr6gSRRuYawFQr/lFrpZU3Q6UJIdxnC0DPPmvemGb6mBqXjfHGikkcuDyNU
         aaexaTDHbRHxdiXTng+UUnrW/GRqfQ+8SHoqZpQetI8kqAJKiqQ1UIVSkNmgIO1pQdFD
         3ryZ3/0YpisU9J1vBaTvRW7DCTkqFQlx5g24pVSROIJJZvnt3zigCllUTgklAZjv5JQp
         mied/ObVo5wl5JotR5FMB+mcqYlM+VVOJJFNdmKCJ0xGP3KQZn6cJvNLW257RQ+EzCK5
         32RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751653062; x=1752257862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0LubEeA7QtYGWt5v3ZfzLKEULmI0rQlXV2PAkZHwzY=;
        b=fey8rzn7ZGL4+cy8XfO2rl6WOy6zhF0Ee0+WS2kWB05JreZ9YmK6VJ3fxn6DdkA1kx
         PaIxO2LWeWTboD4gChZS1PhFLpUqIFXoW4cEueRQhQTdWR42U8O5Vu/lmh7NDi84jDJv
         wsfeFtspt4QWZZpuvRHdAaE7NVsv2w8O1FgdT2kjG5sYFJ/wwl8F3m0kzVwf7ARyb2W9
         XekWlJvaQiMuTWJZhEzOxqSeZikicpZEPUJCDCb9DYtHhlzgmE5MvrkNNeXpvmWQvWg9
         rt1dWPtljT1wnXfhuNjWE7xu7pDoKJ/ZifSGUQQgL1zoYHLfM0dpwu+ScVACeGjeLInV
         hzKg==
X-Gm-Message-State: AOJu0YxQfPgaj5df2ZaIX02J4tQrIcyrjvhTz9ogkWAg0+JeTCplJSum
	RyiFaqSklQ8uBxrYMAIYG0xN6ItR0zovRhgj3E7RQcJWIPraJ7md1abbBiq+OFQ9L7lpACJkixQ
	7s257KTqtIEspocrjVfP8+Fh2uAPSj8Q=
X-Gm-Gg: ASbGncvVEPBRHrZgD4EqEwqKe/VwWn63imNoFPTaDIxO0UgkDFBJO/tq3TxxTG8qPQb
	Cxp76z4mCMSCDZLaBGxv5TEL/yn/NWCnV9b6tiD51Ik/DRSm3ZfHt4/UGFB58GG0bEb9WOHLgF1
	u5g9ubgweuk/4P4ZALKckQ9O4K3xiROShMu+2vR53PFpQbLDUWP512R61b3RGUVpwcesfnRgJ9
X-Google-Smtp-Source: AGHT+IFXMG9hJCW4n5xaZ+mkl6gw+V4GBZsYa6jDHwG5OUBLWsoXma2dtxlNF+b9I5dK3G1KBpA2xVwi7vHZL5q6fhE=
X-Received: by 2002:a05:6000:4386:b0:3a8:6262:6ef5 with SMTP id
 ffacd0b85a97d-3b496fef6bcmr3287077f8f.10.1751653061462; Fri, 04 Jul 2025
 11:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-5-eddyz87@gmail.com>
 <CAADnVQLRL8Vuh_VGAqSF_MhcsHhOvfYFurGoGiC9RfAiGJcbZQ@mail.gmail.com> <7e8e074d1b76565acf251033fcb963cd7417741e.camel@gmail.com>
In-Reply-To: <7e8e074d1b76565acf251033fcb963cd7417741e.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Jul 2025 11:17:30 -0700
X-Gm-Features: Ac12FXxezHyGp8M4YnfIBedM8hFOIAJDXhYhWgYScnCG6mveCDxznevkUTP8lXE
Message-ID: <CAADnVQKTBUpQbi66-SDE8dSRi78Ht48ddx=iQi_XEguYhYe0AQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for global
 function parameters
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 2:25=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2025-07-02 at 20:18 -0700, Alexei Starovoitov wrote:
> > On Wed, Jul 2, 2025 at 3:42=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
>
> [...]
>
> > > @@ -7818,6 +7821,22 @@ int btf_prepare_func_args(struct bpf_verifier_=
env *env, int subprog)
> > >                         sub->args[i].btf_id =3D kern_type_id;
> > >                         continue;
> > >                 }
> > > +               if (tags & ARG_TAG_UNTRUSTED) {
> > > +                       int kern_type_id;
> > > +
> > > +                       if (tags & ~ARG_TAG_UNTRUSTED) {
> > > +                               bpf_log(log, "arg#%d untrusted cannot=
 be combined with any other tags\n", i);
> > > +                               return -EINVAL;
> > > +                       }
> > > +
> > > +                       kern_type_id =3D btf_get_ptr_to_btf_id(log, i=
, btf, t);
> > > +                       if (kern_type_id < 0)
> > > +                               return kern_type_id;
> > > +
> > > +                       sub->args[i].arg_type =3D ARG_PTR_TO_BTF_ID |=
 PTR_UNTRUSTED;
> > > +                       sub->args[i].btf_id =3D kern_type_id;
> > > +                       continue;
> > > +               }
> >
> > Looking at this hunk standalone (without patch 7) one might get
> > an impression that odd ptr_to_btf_id is allowed that points
> > to non-struct type,
> > but patch 7 sort-of fixes it by handling primitive types first.
> >
> > Still, I think it would be good to add a check here that kern_type_id
> > is a struct kind.
>
> I'm adding this check, but it will go w/o a test:
> - unions are allowed by btf_struct_walk, so need to be accepted

Of course, by "checking a struct kind" I meant btf_type_is_struct()
which does kind =3D=3D BTF_KIND_STRUCT || kind =3D=3D BTF_KIND_UNION.

> - function types are anonymous and candidates search wants types with nam=
es
> - float -- no candidate in kernel btf
> - func/var/datasec -- need a corrupt BTF to sneak these in.

You're probably right, but extra "if (btf_type_is_struct(..."
just to be safe is imo worth it. syzbot-s and such.

