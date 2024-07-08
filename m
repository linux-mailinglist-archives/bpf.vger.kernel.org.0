Return-Path: <bpf+bounces-34168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8018A92AC85
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 01:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6A71F222E2
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 23:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AE0152789;
	Mon,  8 Jul 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zkhh4X1G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688615217A
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480833; cv=none; b=Y+LUjv3UjBeZMAyE0p4ZBEPX26A8lxg9XEAzGsql56rjEkd8adWwyKwjYdzo4tw4DQYogJBxwoLnbvkdToSyhpqT6/qTJJHXMlz6gKByR/fuCEAuE+Hs+1117TNW5DF0lIEDPkzEFp7seCBvz4rHKiyldVMXbBsDx1OyNjixVLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480833; c=relaxed/simple;
	bh=4gHEu399GXMTmj/4qA1JDT+UwjJio18Ekau3pLyLUEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQdq/73hQn8ez+GGK885H1uzF/vWdQg6nPxrZjwib1EdZq5tLnCmakKqnAUddf/2nPoEeBjOBHcu1JKSP+U0WqkMDnyG3OKPS4BnxutYVJ4aFmfpO/CN/fWDdrZJr7BbN2P22OTS9SJuy2WWRs/UGJRz9VkXd4t5bmCChcLwjxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zkhh4X1G; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d92bbadfd6so1235776b6e.3
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 16:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720480831; x=1721085631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU7e1+jSxYEoP62yx4w196ID3Mm6Ijq3QsP61xmaoaE=;
        b=Zkhh4X1G0oyrYukWJjMeSFBZn0MEMNf4HdqGwlEL4M8bSIMq23T0pKRj/y4wl1xSgW
         sZZ/JZUxlGhHmgIauZRtko1fCng85iQSPYiv9Qkl4MC3mYNaT10A2FAeEwe5Rzo2ezBC
         cc/LFwMnRgU+kyuSjEgdheW2+dbiomgvByP2bpxIA+yslr2vXNdL89FS9R8y5JvjU4e0
         qwTlCrTLAyTLKiU1bBrMErpOmSYkP6AcZkYB047MRPl5pA6CBhjpqJBpvWp52MmzpSSq
         UgRw64psoyZ6C4nGGF9ciPGDzCPTDaA5y8HQ+9RSZidOhS6mkryXlT+y+NW80+fj4RWJ
         fLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720480831; x=1721085631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IU7e1+jSxYEoP62yx4w196ID3Mm6Ijq3QsP61xmaoaE=;
        b=qSdiFEdlurfxVT/x1/HnyjTLsmI1pcM4hGre8W/N7g6Zq9z8lUx0A35GVLyLC76i2E
         5zbzBBiXStmhWFR7Lw789Ka6Eu1eLIg9dnMTw56kA3PVpCpPrHhMG4JtHSbHoBNo5bma
         mv+KS2KWGN21rYPpXabSVtyeh28IMbpZEFmX8xfaPsJVomuFdzoZRrVv6gkEIXcK85oD
         JeoREvJUvPoUx4KXaH4xSmflwQwDkAO+a1OVuSb/YFy8IAyBYB1d8Fp56UyYge9zSxFo
         ZGvEAPpunhNRDndLevlpGpwgQwzohNMtg4y4AuFXmfoxNBKn0O2QiCfkQgv8t49b4cVP
         sEUg==
X-Forwarded-Encrypted: i=1; AJvYcCU9+SeSOOJKs8TOmpAQXdb4urN4OpkD+dCwpC/+lmj6zyR26EeoH9zpN9bdtmx0IdJgNc7cgqouAvpoIccxux/xfJRm
X-Gm-Message-State: AOJu0Yy7VTSAbS9JTH00z1chyOVA2oRWnDuJhxS7qlXoEXivwE+AguV/
	8MekKCJ9oBj+R62DVOv48cjgvi9tE41f8jWfTXZaJs3n6hnKwiCC90A43O7kjyYjRqRWHXcqjfG
	FSwhsDEILcBpc6CWediYBU6AZoE8=
X-Google-Smtp-Source: AGHT+IGGwSmVBGOR53Pr7tk1fOmN59YOyvGMn/PBcB0sggjJ3gADfGDnj2OvAFwcLKbE7oE/rL5ttC2Xat+skuMSdmw=
X-Received: by 2002:a05:6870:164b:b0:259:80dc:13e3 with SMTP id
 586e51a60fabf-25eae7f7b94mr720790fac.23.1720480831322; Mon, 08 Jul 2024
 16:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708204540.4188946-1-andrii@kernel.org> <20240708204540.4188946-2-andrii@kernel.org>
 <9c48d70561d2e7334c17d0c79816b987660c5c84.camel@gmail.com>
In-Reply-To: <9c48d70561d2e7334c17d0c79816b987660c5c84.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 16:20:18 -0700
Message-ID: <CAEf4BzbTDmg_xNjeecyrk1HBh9zFSQZ=p29a58aN41GwnT7LuQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] bpftool: improve skeleton backwards
 compat with old buggy libbpfs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Quentin Monnet <qmo@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:54=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-07-08 at 13:45 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > @@ -878,23 +895,22 @@ codegen_maps_skeleton(struct bpf_object *obj, siz=
e_t map_cnt, bool mmaped, bool
> >
> >               codegen("\
> >                       \n\
> > -                                                                     \=
n\
> > -                             s->maps[%zu].name =3D \"%s\";         \n\
> > -                             s->maps[%zu].map =3D &obj->maps.%s;   \n\
> > +                                                                 \n\
> > +                             map =3D (struct bpf_map_skeleton *)((char=
 *)s->maps + %zu * s->map_skel_sz);\n\
> > +                             map->name =3D \"%s\";                 \n\
> > +                             map->map =3D &obj->maps.%s;           \n\
> >                       ",
> > -                     i, bpf_map__name(map), i, ident);
> > +                     i, bpf_map__name(map), ident);
> >               /* memory-mapped internal maps */
> >               if (mmaped && is_mmapable_map(map, ident, sizeof(ident)))=
 {
> > -                     printf("\ts->maps[%zu].mmaped =3D (void **)&obj->=
%s;\n",
> > -                             i, ident);
> > +                     printf("\tmap->mmaped =3D (void **)&obj->%s;  \n"=
, ident);
>                                                                  ^^^^
>                                              nit: this still prints extra=
 white space

ah, that's just printf(), not codegen(), missed that. I don't want to
send another revision for this. Hopefully whoever applies can just
remove those two spaces, if not it's no big deal either way and we can
fix it up later.

>
> [...]

