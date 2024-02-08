Return-Path: <bpf+bounces-21461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B75A84D729
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4BF2846C1
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 00:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2C6101C3;
	Thu,  8 Feb 2024 00:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkQ+34Os"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E824DF44
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352219; cv=none; b=MCfEQGrwty45x+NIu9B8gXxeMoGBJrM2pxIwkWihmR8orPo3HyTnk97sV8dxzmq4ee9VfvmKZN6agTftq91/HgtVBwO6A8RzN0W+Ifdxot17pMFuLaPnFVxUz6z08ZMCv/Ig9HLc61bo5tMZQJS8L1EvK8H4JlJFbIyBxZMe8Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352219; c=relaxed/simple;
	bh=uzZQVGtAmeJAuDyuWkDiqp38cOeeyZYiQHaMQmg+lg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5cmPnWMO/tUgdykUHEnNg/2bZMNVsPZDmuAgY1RC7oxNFFbaItEojT/ne8LPVmtxybVBHsWOyvacFC6drn0un1cYFPaiVY8YAYL8Nz4x+urbiDwj/3DaTJHR9H0XdSpnTzgbeo9oot1/utl/BCWiloC4Q7DNootImwqTyAY+tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkQ+34Os; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3be6df6bc9bso783956b6e.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 16:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707352216; x=1707957016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy1GwnriVjixaMGiaBgJMxdCM1g7kzqG5u8/jHVbD3g=;
        b=jkQ+34OsYNEEEU8oS663ib6+09gjnP6+vJkbv/GYKy2IRfpgfM05jwf6OoPl/rwnm8
         YAJEA+ulqwC0yK44Y10wCNinciuaQefIvQb42bvmvdk0Md5fJ6eeLQ88bB591wYjI2wE
         cJPk1BNPOG557rCVVxUFVOOTF5rgF8iRO8qbPaO24TMUOeRLYpDGG8ajoy+5NAVcsEAt
         TxlJYPd43Wxb26Y9K5TpAaT12p8s5YWzhbnLSwDl/2OfToFwjWnQcA6A1KZGptzyEvvf
         6MvgDYAkMHYkHPB2O4IPpnsTma5Kj7djpg8YIvyUq8IoaNWUBoPTbmctm/oCahOVDi5M
         AvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707352216; x=1707957016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sy1GwnriVjixaMGiaBgJMxdCM1g7kzqG5u8/jHVbD3g=;
        b=kj3zuxbOvYzAID6E95UcunvWgcpkib8cnvZoGSdJJ7lDkyMwPY0whfpeynpl3NkKpQ
         eMpUsWVChJruexoLmEnP0RUTCWOH2aq15JJkwaGrjb7BPH4p8OzU585PXY4ETfsC781v
         zT9xyM6cl5b4BuDigIF0HO8fy9CnvrnQe5v8M6tgpwrMJdohz3LGVxg+XseATHaB8CDn
         HEa4WMFo8zzAMKjHG8r8SHRAv5IxKmtsQVV4DkzmgvU6p9vh8Pk98JqE2Twle/muj2GR
         FaK+ap8M80g0yvP8Vd/trYxcVzpOjxjrYfhZspknnNyXCmlOdntX4aYV50NQa29S2ASC
         6zEA==
X-Forwarded-Encrypted: i=1; AJvYcCWfKCVM7EBbQp3UbK56ggNImExnBzWQMaRLQ98ZaCDq4bgX4d/Sj1Bo/J+Mn9sIzqHZrtYtdsGYmFUhAwpUtEeFPiBT
X-Gm-Message-State: AOJu0YxgxrbuOn1s/KKvdprOGGbdlYq5/5dMlbEK+DaRiSCFFDZfTstH
	oX3Sp5rFoHWZtjVOs7YNUq5Y25Q1rHZR10dxiDnWnVnQtDNRFnOyBgsNZBK347qGMPrmEPxFvJp
	w6XGRtAiUnrmcPpppmpYgcCd3CIJYrp5k
X-Google-Smtp-Source: AGHT+IHJJRpTN5dazboFae3JisWxJBMw6ZMSt3u5MzJQ4kb/XH6d+9BOvXif8R0nS383veUBzRvANvAW/Fcrom1Lkrs=
X-Received: by 2002:a05:6808:2e8b:b0:3be:d052:f211 with SMTP id
 gt11-20020a0568082e8b00b003bed052f211mr11888534oib.39.1707352216397; Wed, 07
 Feb 2024 16:30:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130230510.791-1-git@brycekahle.com> <9b054832-3469-4659-9484-00bcfef87563@isovalent.com>
 <CALvGib8u_owyjKCWcD3ZrFTkUw6dwE2Aev6nG2AD+D++b+R77A@mail.gmail.com>
 <CAEf4Bza=mroJ6+zhK-fCKLutuH_1z9ESeJs+BHbNbCrATrwRdA@mail.gmail.com>
 <dfcd6c3b-dbaa-4e72-acc5-89aed8a836f9@app.fastmail.com> <CAEf4BzZMmbV4H2vLeYO0tm50VV9evLDnUTM69=P7z41v1jY7gw@mail.gmail.com>
 <CALvGib8LtTY8qBN+tvZTzb_GKNOX4R9YEUxkOL0ghuQmjG8Yqg@mail.gmail.com> <c4624866-894f-4340-ac97-41bbb683c149@linux.dev>
In-Reply-To: <c4624866-894f-4340-ac97-41bbb683c149@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Feb 2024 16:30:04 -0800
Message-ID: <CAEf4BzZ94O0=PGczhtCMc+-T1DoNUV1rG5TsfFq1qFahbMptyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen min_core_btf
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Bryce Kahle <bryce.kahle@datadoghq.com>, Bryce Kahle <git@brycekahle.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 2:38=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 2/7/24 10:51 AM, Bryce Kahle wrote:
> > On Mon, Feb 5, 2024 at 10:21=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> 3) btf__dedup() will deduplicate everything, so that only unique type
> >> definitions remain.
> >>
> A random thought about another way.
> At module side, we keep
>    - module btf
>    - another section (e.g. .BTF.extra) to keep minimum kernel-side
>      types which directly used by module btf
>
>    for example, module btf has
>      struct foo {
>        struct task_struct *t;
>      }
>      module btf encoding will have id, say 20,
>      for 'struct task_struct' which is at that time
>      the id in linux kernel.
>    Then the module .BTF.extra contains
>      id 20: struct task_struct type encoding
>      there is no need to encode more types beyond pointers.
>      this can be simpler or more complex depending
>      on what to do during module load.
>
> When a module load:
>    For each .BTF.extra entry, trying to match
>    the corresponding types in the current kernel.
>    The type in the current type should have same
>    size as the one in .BTF.extra if otherwise
>    layout in the module btf may change.
>
>    If new kernel type can be used for module BTF,
>    simply replace the old id with new id in module BTF.
>
>    Otherwise, type mismatch may happen and the corresponding
>    module btf type should be invalidated.

Yes, I agree, see my reply to Alan. I'm just unsure how strict we want
to be and whether we need to record fields of expected vmlinux BTF
types. Or if just recording expected size would be enough (to ensure
correct memory layout if base BTF type is embedded into module BTF
type).

Perhaps, if BTF type is referenced from some "trusted" BTF type (used
by kfunc, or in BTF ID set) we might want to enforce strict
compatibility, but for any other type just make sure that size is
correct (if it matters at all; i.e., if base BTF type is referenced by
pointer only, we don't even need to check size).

WDYT?

>
> > Since minimization only keeps used struct and union members, couldn't
> > you have two internal types from different modules which conflict and
> > end up using the wrong offset?
> >
> > Example:
> > in module M:
> > struct S {
> > ... // other unused members
> > int x; // offset 12 (for example)
> > }
> >
> > in module N:
> > struct S {
> > ... // other unused members
> > int x; // offset 20 (something different from S.x in module M)
> > }
> >

