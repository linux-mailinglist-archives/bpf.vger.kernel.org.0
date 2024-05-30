Return-Path: <bpf+bounces-30956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDB68D525C
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 21:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78A8285379
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADB5158860;
	Thu, 30 May 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv7MUDW5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0246433
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717097655; cv=none; b=eE6CBVyWe57h7P+zOuGFVXDGjftkr/QwYZiOeFSYDgrLiif7EYzHd915TSVYJfLpW6m3MjDSgA8bTn84BYmavhHKT+xuWAL8URhFT3jnenkvaTKKIEgFWg5l8SyZEvBcho3yonzZkyvnEPGQDAHytIs3MiEGT2IL5g1luGA0xZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717097655; c=relaxed/simple;
	bh=SCU2b4o9+Vm3iWn12intIYb5/aK9OZvbWm0Nvk4bBXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3acxaFaEpfXJA6+vvEgKcJqIBxyFe0tkyR37EyNrE9S7/CxJMRcPgY0cfcnyPMFGzs80gJFum20AjKKhT+D/ATNBeDRLbaNJJQUMciSwxzau8d93kXDG2thAb19KmXtUJeS7Ke6ncAFcm4GtqmAJJbUuWbjX3Fr0GXoco4KsgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv7MUDW5; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso16053981fa.3
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717097652; x=1717702452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2y3NgThR1lYeAcvGlQdJauugNd9Wv7PZes4lZPXvzaA=;
        b=Gv7MUDW5UiRO3dgLxKhrSW9f/ukDtZaXnYefuEcbBTLw6IiYlVIP6jYdagB2m8506x
         Q0IIqR9/FvLeyqJE274oErqZGdzgixoDOCaF5k7B13a/DbDDJwPtrA/Xfp/6/ZscjTGJ
         njUalt7HLTy7MVJB5QLNf1mSNDi1E+zW9Pm9ti2V7PReMNHyvnpX6dMC7G7ptfrByo0V
         Hx4kBcEk82s4dTyyKm9Dp3gEtUcL5bsUAR/KSZ07XB3zdIKzkatKSI7KcCg6qroyDEsA
         vntpiGcvVcRFp/Ib4r7cdzicXWq1Y00iSbi6eJK86O33nd9tNR5PUkL7a0ISqIcy/pZ0
         J2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717097652; x=1717702452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2y3NgThR1lYeAcvGlQdJauugNd9Wv7PZes4lZPXvzaA=;
        b=PuE32emQ6i8fxiVK4gzDfEZ6r3xlzQG8jrUnzbaYB831h+O0QKgz0ezwjsnmG2yGY2
         9nziDdnfmsaUk5Eap8Tq7s6okxThoLhV0SHmgFHaxyTCqBSkZn1l4IUvwf5CqmpQhNzg
         2QkLKuKgkDXrEGI4ApGSDE98SDo9+sSFtLZZ/X3AtV/MogcX1TluTFgUee82LgEN0KKB
         ogl8T8rqQ1lpOeozOhbL3X4YQku4dQSE6XDexaYCGKkCNE3wIWym0Sf0z0cuPAZEUnFP
         QJsVGSVxGtPl+JasZbcGLrTHbcY7YajZtn/SG8sTJ7lkdn9Gtt/8ppR3Qa6R/d4JjbCZ
         uCSw==
X-Forwarded-Encrypted: i=1; AJvYcCWEDbAkNIQeIiB4Jg7dTs6BKjKbzkFRPaI/0DlsKlrRt5W+2QrOMtbvZUBwuKldMiraEsqTNqqjW2BEGoIZ4T1kOAeC
X-Gm-Message-State: AOJu0YykNy5ggsPFclzF1E5h/z+2+/m8LdvMwuS0nTbj2lhp9iLcQ5h+
	05cNN0WO3VAgtP0203sK1QAf5Av1wqVhSu7hEB/DMBWrNymYxA59JGFQh/7NBQD8+ZDH0ZF4msX
	LZK94vkyPYigizTqdEyTANPc4dGI=
X-Google-Smtp-Source: AGHT+IGidDJKs9X2JNOPfKWkDLyDUu5cxNH1KJtBD5ZbIYu79VvTaXmTVYcjd4MtjYfSOb2VFEffjRb7EsXQEjh+3Vw=
X-Received: by 2002:a2e:b018:0:b0:2e9:659b:ed57 with SMTP id
 38308e7fff4ca-2ea847dfb07mr17410881fa.12.1717097651768; Thu, 30 May 2024
 12:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524223036.318800-1-thinker.li@gmail.com> <20240524223036.318800-7-thinker.li@gmail.com>
 <f0b0e283-9312-4f11-9636-2ea690262180@linux.dev> <CAHE2DV0RBf9JbkmngsdKdER5F2KmUXwY_JH44Z09DsY0VNa37A@mail.gmail.com>
 <8818eaa4-b32c-41a6-82c9-6230d635e89f@linux.dev>
In-Reply-To: <8818eaa4-b32c-41a6-82c9-6230d635e89f@linux.dev>
From: Kuifeng Lee <sinquersw@gmail.com>
Date: Thu, 30 May 2024 12:34:00 -0700
Message-ID: <CAHE2DV2r=RYYp=G5BBSB7Cinab25J+JxcFWXwb_GbZcpxgwVGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 6/8] selftests/bpf: detach a struct_ops link
 from the subsystem managing it.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org, 
	Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 10:53=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> [ The mailing list got dropped in your reply, so CC back the list ]
>
> On 5/29/24 11:05 PM, Kuifeng Lee wrote:
> > On Wed, May 29, 2024 at 2:51=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 5/24/24 3:30 PM, Kui-Feng Lee wrote:
> >>> @@ -832,11 +865,20 @@ static int bpf_dummy_reg(void *kdata, struct bp=
f_link *link)
> >>>        if (ops->test_2)
> >>>                ops->test_2(4, ops->data);
> >>>
> >>> +     spin_lock(&detach_lock);
> >>> +     if (!link_to_detach)
> >>> +             link_to_detach =3D link;
> >>
> >> bpf_testmod_ops is used in a few different tests now. Can you check if
> >> "./test_progs -j <num_of_parallel_workers>" will work considering link=
_to_detach
> >> here is the very first registered link.
> >
> > Yes, it works.  Since the test in test_struct_ops_modules.c is serial,
> > no other test will
> > be run simultaneously. And its subtests are run one after another.
>
> just did a quick search on "bpf_map__attach_struct_ops", how about the ot=
her
> tests like struct_ops_autocreate.c and test_struct_ops_multi_pages.c ?

Got it!
I will put all these test to serial. WDYT?

>
>
> >
> >>
> >>> +     spin_unlock(&detach_lock);
> >>> +
> >>>        return 0;
> >>>    }
> >>
>

