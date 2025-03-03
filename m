Return-Path: <bpf+bounces-53114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CB9A4CD94
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 22:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6921719A4
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 21:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048CD235345;
	Mon,  3 Mar 2025 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDzmxeXi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21311F03EE
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037950; cv=none; b=II5JZK2lfHffpDct0gdjmcCeEfdGCYqQDkgRXrfmXBDr+d4Ii/0Twiz8uw/V16rjRYxBufDMlHcEyS3Az1Y89HHpUGdp5VXe9eO/43+HFmpP5K5cAN6BXovzCnOxe85cGOII581aJKpKQWhEwlswQhsk60kwxTaBS0jAg/XzIlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037950; c=relaxed/simple;
	bh=9gL/0Vth5MPu6/iOXbLT7SkM+qvHkm0JMJrwlya60Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+pl9IIqPhuoiZMfucegqR6gGZJIYlPQAZ3ffLrqhVwUT3j3D/gvPCIwFql6KrPanvCuCiUj47djEexWzcoHYwPM5VFjl1NNt/+b5qbustanJSyVgBa0fW73rkBZj3PS/VG/S70fpnluQYlnkQJV68qoVtN6TFtbZAuVeOh0BjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDzmxeXi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf6f3b836aso283700566b.3
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 13:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741037947; x=1741642747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0FinuGHiBCGDC8j9R5yALA+vqb1hOfcXDLD1oyMnOg=;
        b=UDzmxeXiYv9rPUx76AfhxzbwrDMls0EJdLP8ZcFJMkS0jFfWuSisF1f23o4m7v9Fgt
         E20SNHmzsXnFY2ralSBVlr9Zzx6rV1eQIt0lipKObAZrgZn6XBSWIGt2r6OLqoctJmQa
         1hOn7qJa9oaEIVyp6G/iY6Gd9kXpJWCbh2+cdPQY49AO7JswzSvdhyOmKwUoc6tUj2O+
         EiSSaT1d0yi+NxZU/4e3l8U9AkBbhM2nhrpr0e9b1mxyLMDcpmFcMoerfBW383B87t6d
         uMlpXfkmF21JDIwCdMaZV6YmA3xY5ciHbNNY58Lhw10/0oDHXtNNx7qDLMqXr7ahy1DN
         mQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741037947; x=1741642747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0FinuGHiBCGDC8j9R5yALA+vqb1hOfcXDLD1oyMnOg=;
        b=Yl6perzPYuFj4Kq90ErRXRc3aWTa+XFWhKmUjdegDW572wApuhKuHd5nmjfr+KHRuU
         3hninAKHE4mlWX4dMGNHOPYYNABY+Jgoy7PGq63eEdrsM7hulKu+oeylOQMd0e50nQqQ
         /cHRMqbWPI1RrAm52sfc7Pr2clNXECjjBJsuvgLMCgaWGaJITe3mrmCuWKFCcyuo8RTc
         1XwCtoTXSsJ8VfBv5QXqiaMHVdL2COmM/eMWCibK78RL0VsiEyZ8HrA4bsXeWCHq6OMu
         69eSzaWrdEOXUmm60YEkGe6iM0rqEzjhFdIic/QesdVdIF9oyzCKukGPIdGPTv29kGCh
         DMvw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ0FA58XqaAwfWYXZcfloM4TIowkDvFTEPexHQ+Ds6WzHRARChOYv6sR67c4s9MzXb3U8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2vmkeHKt3l5pz2VLFsNmjNBGqJM6I/J+Rc40cMacEUSXceJ5D
	eEvGEKGLCoUxbevzJ8XX2YmN21nD1k4tCM3xXm75R0SXFVtqnISZPOYKn91NCW9xAbX9ybzpgla
	f2kRTOOjHKylW16TQt//KGZ4/whY=
X-Gm-Gg: ASbGnctDWzMCuQga9h7znmFPme2/I+QM32WshRxaa8iq59Q2id4plF+p/PHmiimEBHn
	FnhNOcEIviOGjs0IV8HN3SiJg/z789uEuF/o+f6NnXHhX72LhHOFhzKvTrutk9eGNvASf2F14id
	nBd7qdrQ6cYJTVDQQXgyOWQ0cm
X-Google-Smtp-Source: AGHT+IFqJ6FCwbYJxKutmhRrAbRR0pXosxvDeaCxD0OaVaOtQpR6c1nUiK/0xp4PyT3cviIkICfQPCMxCXaRrzPxSPc=
X-Received: by 2002:a17:906:4788:b0:ac1:ed96:56d9 with SMTP id
 a640c23a62f3a-ac1ed966efdmr167742666b.40.1741037946709; Mon, 03 Mar 2025
 13:39:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com>
 <20250228175255.254009-3-mykyta.yatsenko5@gmail.com> <5d7fb7202625b999cb77a1e010ba6f7099dbb561.camel@gmail.com>
 <00e385df-7ffc-4fd9-aad8-60dddef300af@gmail.com>
In-Reply-To: <00e385df-7ffc-4fd9-aad8-60dddef300af@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 3 Mar 2025 13:38:24 -0800
X-Gm-Features: AQ5f1JrgUyWmP8tvPuoEEg9oUdx95cvwBlRZYzKy_mh1zcAw1RumjI5Jjqll3jU
Message-ID: <CAEf4Bzat3grecmd_PkmLpN9gAfkuGhmO4o4HmgZWE4sJ9BL+fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: split bpf object load into prepare/load
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 1:45=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 01/03/2025 08:12, Eduard Zingerman wrote:
> > On Fri, 2025-02-28 at 17:52 +0000, Mykyta Yatsenko wrote:
> >
> > [...]
> >
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 9ced1ce2334c..dd2f64903c3b 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -4858,7 +4858,7 @@ bool bpf_map__autocreate(const struct bpf_map *m=
ap)
> >>
> >>   int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
> >>   {
> >> -    if (map->obj->state >=3D OBJ_LOADED)
> >> +    if (map->obj->state >=3D OBJ_PREPARED)
> >>              return libbpf_err(-EBUSY);
> > I looked through logic in patches #1 and #2 and changes look correct.
> > Running tests under valgrind does not show issues with this feature.
> > The only ask from my side is to consider doing =3D=3D/!=3D comparisons =
in
> > cases like above. E.g. it seems that `map->obj->state !=3D OBJ_OPENED`
> > is a bit simpler to understand when reading condition above.
> > Or maybe that's just me.
> I'm not sure about this one.  >=3D or < checks for state relative to
> operand more
> flexibly,for example `map->obj->state >=3D OBJ_PREPARED` is read as
> "is the object in at least PREPARED state". Perhaps, if we add more state=
s,
> these >,< checks will not require any changes, while =3D=3D, !=3D may.
> I guess this also depends on what we actually want to check here, is it t=
hat
> state at least PREPARED or the state is not initial OPENED.
> Not a strong opinion, though, happy to flip code to =3D=3D, !=3D.

Those steps are logically ordered, so >=3D and <=3D makes more sense. If
we ever add one extra step somewhere in between existing steps, most
checks will stay correct, while with equality a lot of them might need
to be adjusted to multiple equalities.

> >
> >>      map->autocreate =3D autocreate;
> > [...]
> >
>

