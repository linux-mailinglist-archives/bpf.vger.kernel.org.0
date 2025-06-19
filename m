Return-Path: <bpf+bounces-61099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A664AE0B7D
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 18:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8161BC32DF
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 16:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A628B504;
	Thu, 19 Jun 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjTdCd8t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0BA11712;
	Thu, 19 Jun 2025 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750351780; cv=none; b=NYpqTSHA2YZ3n+bKHJZCWzcKNsbUjEhNWY4zQPDKkcOMLn20qrUkV4GMzYdrvQxyvvk1sgD0wCoT8PKfu/dIe6AFO4h51rmzwNuZoR8duzzabrDqqVwNQ0f4km4/cFJqLd9afu5Qtiz5S6YmTvk8QGcpC/d27TO9KhiRrLLnNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750351780; c=relaxed/simple;
	bh=v2rGwpvhsgNlqwzz6HnVKBV99RkjKZA9tOke9X/4Ork=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHezSRvPzsTThIVm7gPlEQ0dN4S+kZ+FSD06FtxbgW8yin9SD30czPYDp8Qhbc2hw66bOcMxWnhqa9hD98EYq2T/ThvvvGtpain4VTcunRBJ1nwkA8XMko5V/kib/CqcAbFbsHHYyNmAn2Aid54SAEHZCeE1epcjE9frzLV9oyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjTdCd8t; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso638769f8f.2;
        Thu, 19 Jun 2025 09:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750351775; x=1750956575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AR5Nmbgu5IO0KNvV/iIxHYLr5O4o3QCvKhcsPLIPeDk=;
        b=CjTdCd8tWvVYbTbd3yFRnS0vN3b9PBkMZYasyNrBT7727Yh7i9AjzO0DqxAtqQT6xo
         jrszKFp056AG3xX1m7S8MkSPETAX7ona40H5cluGdPrkUSYcbmZgFUOxE3uq8uEaWVhq
         nELCO3p573QKuTiQRvPaznCU/Zic+sRh4FK5kGW0qssd3Gx62CRXlah/KPpK21I4ol2j
         9Q1Ws4/nt3r6SWWrfTgodmoM/yzzUydDbpGKqb5EzCQzBiF50+0loKt8SQD5gVzAsOXj
         G9LMHuV8fOq0o5whNZe4xAjX3qScIOdGRZgUZOlRnoAtbDArLbDVECgzyKCNGgvaLI2Y
         tvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750351775; x=1750956575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AR5Nmbgu5IO0KNvV/iIxHYLr5O4o3QCvKhcsPLIPeDk=;
        b=SNbno677bX5m4g2GHKGMEj8ENMW54siSQR09awilewpI61e26y9/Ett176pOBNiMMx
         /KIU1/wKexFaGnpwH73IK2AHUmFiXrYUwtvwCslLZl7bXqeyU1CJG8xqU2ut2ZYl/JFW
         f9hCpi0I+0DPVRqi7jzBTuJoFSKIGuaDWqYwO9bZJ3SC4DE+v8zw31laTwCHJ+smlISB
         kLSMGn5QUM8tUwCewtg6Cozya0I2AiXXr0FDNU6Wh5OJ317KfE2/I8WGSmy1i8OQ4YCk
         QVDDMoM8useTeCPdkT6yHUiyf54ljqU0AQkiMlriALa/Y7UrCoL3PLxKiZCjwKt6qI1F
         VMjw==
X-Forwarded-Encrypted: i=1; AJvYcCV2md/A9XF2hUumbMCxfVRESDs4YpQf0gYwVVvcxlJV8qbivOC7YiNlZ2rBz+ylpkB1OX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtbgBvcjRKEncRNZds1RR3IZAg5Cg3+uL4er44On2vWjAlF2qU
	gsSJfZsJ36i9TqHzm8QuUfAP8VvprIJIubgrrUmBPy5DB6TiyA7IuJIansEJbR5qJNOyhGrTMah
	t4eUDRil3RN4hjv5BmFUMd0Tv29hDWas=
X-Gm-Gg: ASbGncu/s/epdWBBss+7Gi7lff1VCXWNJ8P0lJyfkLqD49m1Lb0IpPbikOhieSPxUIq
	bABUr+6SbipxN0ltMzvXfQ+MWmW0sFwG1JFiCcABLSvRBgmBIB0JgYtg8QFmJmhfS2CFEyulYoy
	jSjkQSNK1czDqZaIcTWNVGFwBxAHrfBN7kxXXND1B4Jikk/yAfwy6mZYUN456U4yeoABgEEV+sp
	BJ0SHOEF78=
X-Google-Smtp-Source: AGHT+IE8lXRasHKj67zo9F0loPDZ/GFYaT99Cadr2BhcQURlgadiLX7TxkBSssTI01HhYltl9GK9lJOrh+F5d1l7X/c=
X-Received: by 2002:a05:6000:18ae:b0:3a4:d939:62f8 with SMTP id
 ffacd0b85a97d-3a5723a3f05mr15797043f8f.32.1750351774698; Thu, 19 Jun 2025
 09:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-btf_skip_structs_on_stack-v1-1-e70be639cc53@bootlin.com>
 <CAADnVQJOiqCic664bPaBdwBwf1NGqfH-T6ZkQJOF7X4h7HuxBA@mail.gmail.com> <DAQJB898I4M9.2EE33TP8JV9X9@bootlin.com>
In-Reply-To: <DAQJB898I4M9.2EE33TP8JV9X9@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Jun 2025 09:49:22 -0700
X-Gm-Features: Ac12FXzcSjRU68EddUzovAY0oR17Kd2cnhMb8vSTjelzQgTpedUJx6wMlUFJtcw
Message-ID: <CAADnVQJ+aX95k7dgX-Msi7=Rvr6SGOy8FnL1ZdwBs19zPzKgeA@mail.gmail.com>
Subject: Re: [PATCH RFC] btf_encoder: skip functions consuming structs passed
 by value on stack
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexei Starovoitov <ast@fb.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 6:12=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> On Wed Jun 18, 2025 at 6:28 PM CEST, Alexei Starovoitov wrote:
> > On Wed, Jun 18, 2025 at 8:02=E2=80=AFAM Alexis Lothor=C3=A9
> > <alexis.lothore@bootlin.com> wrote:
> >>
> >> - those attributes are not reliably encoded by compilers in DWARF info
> >
> > What would be an example of unreliability?
> > Maybe they're reliable enough for cases we're concerned about ?
>
> The example I had in mind is around the fact that there is no explicit
> dwarf attribute stating that a struct is packed. It may be deduced in som=
e
> cases by taking a look at the DW_TAG_byte_size and checking if it matches
> the expected size of locations of all its members, but there are cases in

That will be good enough.

> which the packed attribute does not change the struct size, while still
> altering its alignment (but more below)

It's fine to ignore such a corner case.
Really, the pahole doesn't need to be perfect to catch cases that
never going to happen in practice.
If a software bug happens once in a million runs
it's not worth fixing it. ions cause just as many crashes
in real production. Cannot cheat physics.

> >
> >> +
> >> +               if (param_idx >=3D cu->nr_register_params) {
> >> +                       if(dwarf_attr(die, DW_AT_type, &attr)){
> >> +                               Dwarf_Die type_die;
> >> +                               if (dwarf_formref_die(&attr, &type_die=
) &&
> >> +                                               dwarf_tag(&type_die) =
=3D=3D DW_TAG_structure_type) {
> >> +                                       parm->uncertain_loc =3D 1;
> >> +                               }
> >> +                       }
> >> +                       return parm;
> >
> > This is too pessimistic.
> > In
> > bpf_testmod_test_struct_arg_9(u64 a, void *b, short c, int d, void *e, =
char f,
> >                               short g, struct bpf_testmod_struct_arg_5
> > h, long i)
> >
> > struct bpf_testmod_struct_arg_5 {
> >         char a;
> >         short b;
> >         int c;
> >         long d;
> > };
> >
> > though it's passed on the stack it fits into normal calling convention.
> > It doesn't have align or packed attributes, so no need to exclude it ?
>
> I went for the simplest solution, assuming that there were cases involvin=
g
> packing/alignent customization that we would not be able to detect (eg: t=
he
> packed attr that does not change size but reduce alignment). But thinking
> more about it, those cases need really specific conditions thay may not
> exist currently in the kernel (eg: having some __int128 embedded in a
> struct).
>
> I see that pahole already has some logic to check if a struct is
> altered (eg class__infer_packed_attributes), I'll check if I can come wit=
h
> something more selective.

Looking at class__infer_packed_attributes()... It looks sufficient.

