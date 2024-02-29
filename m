Return-Path: <bpf+bounces-22972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F402486BC8A
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A9A288613
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B079E7FE;
	Thu, 29 Feb 2024 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHvh6R4B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12EA28
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165405; cv=none; b=sbWG1TuNZ5xu1foWN2aED2uwayq3FwjOSUrsUVtM/B4gQmPUzYRMQYINO3kfOG/9EpWtwXMuMFiX6XzNrv68J56nutFuW+AhxkaZI5wEDne9K65KyD8dhYmwKSzdr7Kk2DjvoF1BxX48dJRHDISpQERJQ4TFzqpjY9XwiKhQ59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165405; c=relaxed/simple;
	bh=lFxvTyx3pk2vpm0oj/qq0ehIHx1iKySNvCHYFuJzCiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tczfgfd7NCal8lBgsffKFYbg1vD+78HKkxGBBmvW0gHKwpDv68V5Ur4lKRdz4WremW1MGS45iabMFXpOhoLrt6XSyVXYFp5homgt3jdehGNO6+rQummWo6EvfWrOrAmH9oCX3Bbkm9vonpNfk/VileSmubAs3vWU0M8EgUKQsN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHvh6R4B; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29ae4c7da02so197613a91.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709165403; x=1709770203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/FflViZ6/g2Fedu+3NoZSifwZWX4wShr2vmN384RCA=;
        b=XHvh6R4BPiCWoe+kvQNpNv7v1eiIIlJCTx53V0m7oOf7wGHVZEs+mcH5Sdd2yzbthz
         DqPxOxlndJGW36PyNzlVPk7JkSJN93vn3Uk7rVTTntv5xQxkJzdcErPTE+jy1O0SBQ3G
         g8pQ+FKZBADkTUQYIlANcFNBgAEScPxOIkH8WNs4/TS042QvUj7xuJu1Hj4AWcvAnt52
         Gz/Gyy1WLN9NSpblq6kSUYHsxUPuSRoqhvc0/w56IH2TKke4HfHVMEx9qWmT0ZK+TnxD
         SaJzc0yzKX2dGP4iH06Qj6BlF+b7jinortLKvq38w+AVavEUH1VutZyx8ptahZscmXI5
         kdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165403; x=1709770203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/FflViZ6/g2Fedu+3NoZSifwZWX4wShr2vmN384RCA=;
        b=ikwUvwgxpnOYzllVGqxsi0k1q/MkTe9hoaiUVjt92nbkHS4bm7wgG7lzoy6OOD3enf
         igm1d7gkXE/IO0DEp+7i++0/slYS1+vLeorH/3uAbhwxGMHCY7fMMiBo85Kb7xJ5p+zo
         y7cy2fxoXtHlkb5ENxjzPPz+dUl8Rwid6o0oxqi//O1fu/YG5kjuxZBhiZKaVZo43qu6
         WxarfWezvVjussiZnFm4jU0vjohptvFWwpQu1PI+ujw/iYbFU3h9mIkwDGINGhOTY7SD
         VhlejT9T/1vFBJsUGfIM6ntLKDG09n9MJORbmzUQq6wweHmWTnyRBurK1cj0c0uacN5Y
         tlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0E+dFUiAeDSBE9qlHbi8Qlm0W9SpE12VMlpxOezO+/ENTd1XX1eGnyzpE6lcq90pMn2SPJ3qi5db2kgN7Qz/HthJY
X-Gm-Message-State: AOJu0YzI7WyyCd1puqLXvez65Y/agsnzuvkCFr5nMkc1m1qutVGkReoi
	NqVHQjebuqp9mq615RZMxiWUrEUqx2kl+/1AuwezGLaQCSel/zVMWqUG/XR5lqscZjwbq8Md/Go
	T6lBfo8zNi1bivZQaSEJ1lS/ou+M=
X-Google-Smtp-Source: AGHT+IH6Kvxnq0ZfYgtEbe7HeWaz5C3WtG195l1dpTXlY4jwbygI4M36QH+3CuOr9+7FDYd2mkwXgv8fw/e5sISrJW4=
X-Received: by 2002:a17:90a:ca8d:b0:29a:7efc:4720 with SMTP id
 y13-20020a17090aca8d00b0029a7efc4720mr740316pjt.31.1709165402603; Wed, 28 Feb
 2024 16:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227010432.714127-1-thinker.li@gmail.com> <20240227010432.714127-5-thinker.li@gmail.com>
 <CAEf4BzZFdyq1U2wNP4oZJy8MZrNPhp8zXFoC7mJwu=WYx_hCkg@mail.gmail.com>
 <7c5359e7-737d-495b-b96b-22134776d3db@gmail.com> <e72f726f-b815-4dee-b5da-63ee97082df6@gmail.com>
In-Reply-To: <e72f726f-b815-4dee-b5da-63ee97082df6@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 16:09:50 -0800
Message-ID: <CAEf4BzZSx7XJ4gmq=omjuw0u=CZpQFS=u1iHipOHg+PQN899Xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/6] bpftool: generated shadow variables for
 struct_ops maps.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, quentin@isovalent.com, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 2:28=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 2/28/24 13:21, Kui-Feng Lee wrote:
> > Will fix most of issues.
> >
> > On 2/28/24 10:25, Andrii Nakryiko wrote:
> >> On Mon, Feb 26, 2024 at 5:04=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail=
.com>
> >> wrote:
> >>>
> >>> + * type. Accessing them through the generated names may unintentiona=
lly
> >>> + * corrupt data.
> >>> + */
> >>> +static int gen_st_ops_shadow_type(struct btf *btf, const char *ident=
,
> >>> +                                 const struct bpf_map *map)
> >>> +{
> >>> +       int err;
> >>> +
> >>> +       printf("\t\tstruct {\n");
> >>
> >> would it be useful to still name this type? E.g., if it is `struct
> >> bpf_struct_ops_tcp_congestion_ops in vmlinux BTF` we can name this one
> >> as <skeleton-name>__bpf_struct_ops_tcp_congestion_ops. We have a
> >> similar pattern for bss/data/rodata sections, having names is useful.
> >
> > If a user defines several struct_ops maps with the same name and type i=
n
> > different files, it can cause name conflicts. Unless we also prefix the
> > name with the name of the skeleton. I am not sure if it is a good idea
> > to generate such long names. If a user want to refer to the type, he
> > still can use typeof(). WDYT?
>
> I misread your words. So, you were saying to prefix the skeleton name,
> not map names. It is doable.

I did say to prefix with skeleton name, but *that* actually can lead
to a conflict if you have two struct_ops maps that use the same BTF
type. On the other hand, map names are unique, they are forced to be
global symbols, so there is no way for them to conflict (it would be
link-time error).

How about we append both skeleton name, map name, and map's underlying
BTF type? So:

<skel>__<map>__bpf_struct_ops_tcp_congestion_ops

?

Is there any problem with having a long name?

>
> >
> >>
> >>> +
> >>> +       err =3D walk_st_ops_shadow_vars(btf, ident, map);
> >>> +       if (err)
> >>> +               return err;
> >>> +
> >>> +       printf("\t\t} *%s;\n", ident);
> >>> +
> >>> +       return 0;
> >>> +}
> >>> +

