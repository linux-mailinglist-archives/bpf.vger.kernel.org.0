Return-Path: <bpf+bounces-28961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EA68BEED2
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 23:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7141C21D06
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29E974433;
	Tue,  7 May 2024 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a119qRZz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0224E71B5C;
	Tue,  7 May 2024 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715116851; cv=none; b=MzwkaxJKx3hbE1LO47mqQkE76PLKOQkVyUB4q/wh2vZMNmhFqb9o3dLXd4Bn+p2f/TI9g3GbUBixXgCgZWGk6b7xO72ZzVgjSNrtjsQYiDQ8S8DTT0J8LAcY+VgJXcC2bFFIDHO3LSmqGd+ud28QcV4EMggEC/mvsRw6i3wIAz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715116851; c=relaxed/simple;
	bh=Kwx9xza8wFQSSk9Mi6u/zxm4gN8TurT0J8NxtgGk5Xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4ouPtELg3XqM0MdmCnvYRKDYLMCLNdiVvtms/4cSjxWenWWrcBdKt+xABcsvIE5fyw8l3wyVHY/oBeGS1PhCwTIxQOBgBcPfrd+JJVBquoYWflp6m9wYA4dFzqKrC0CGHSWieVh1fPA4/sD4uvIXChgAoO+vK96vakZn1xyqrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a119qRZz; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso720600666b.2;
        Tue, 07 May 2024 14:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715116848; x=1715721648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kwx9xza8wFQSSk9Mi6u/zxm4gN8TurT0J8NxtgGk5Xs=;
        b=a119qRZz+VppvV+gbh9KYGwws/E2UNXWJZcmcXVtqVCusr5AwLSm4yl5et4u6WJ7mG
         7tg7JuxIRioEDbbxKEHpzfsp2DfgtD0EebfbEvzTYp+kq83b1E9Se4X4GimnZmE7Tb+M
         wbfbyNAjzL04n3Q6ZjHbAsi+mT1fwCPbSp+FDBrfdd5rUOsw9C85KbWzlTJO2Q5QTtTd
         HIq31xjG+yodnV63KlxdD4l9RGcupFoCGMy+Xt6L3ak0wPgMv+EkmzaGYsdmNqUrd0NO
         dt6JgAcgPRDdEpY5b4D7Zs5fKd4IWk9UDrZeARXWylPdRJjY3HTsBAPt1ynOBvwvflcH
         3oIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715116848; x=1715721648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kwx9xza8wFQSSk9Mi6u/zxm4gN8TurT0J8NxtgGk5Xs=;
        b=M9+cMLPjhY3KsSpZVwAFXCeDCyUh9x/06M8uKhRWw2xJHQdrHBHTI71vMHQYeKx8Ia
         PZfrrhCgf8DS4gH0r1K13c/Gz12aRiu8bs4QcBRvw63H/BGlCx9n6et3Dv+3uE3nXq3w
         Alo5uZqeF/qLvtSZDUlVBjFwBqakPNgFw7rwVQ82nNoy2Yc/6uA638wxJIvJOg6GWD1r
         CVvux+KBMNVtI1tEEws2+KLtlUHoSs03bHb678j/3WfjJBna1fAihievciIngwQfzod2
         1MYVOcbHPI+lP8I2oviBzB1xZEmPbb08Y45ppGufInmWjbeQnwJgdk7vW9/VY0RjCvyb
         LGWA==
X-Forwarded-Encrypted: i=1; AJvYcCWbKOo6K5wH8XQ2b0recJrCyrtBFYZ7RjSu3A/L9Vvz3ZU8RE8AUWfKm8lwdIx5wJ9qj2gWTFMOPHgVlw1jYGMyNlefuAgsaS0AHTB8oEScXIk27syfCCltLITikH0FuY3T
X-Gm-Message-State: AOJu0YxeVONTDo47LADUsjOBt9sGIXvqi5blMstm2U+tPHfq5x1xx7Vn
	71wFaXHcG4l6TnQo7X+KgmjHdeWou/qwiqTWCl5++OLGHfQhZU6YKndjqIP7p+Aqo4uYKRiLQx1
	PXSjhN1u/gLyJ8B5RQlLEgDF6iqo=
X-Google-Smtp-Source: AGHT+IGTpIQDXjFez4jJHhp4fDDnRSiKC0e+zsGKX5MOu3R7bOUzpIfpjjgTy29z5CnMN3VO6I8bFYVIq3qhuqG+IiA=
X-Received: by 2002:a17:906:65c9:b0:a59:c8bf:1269 with SMTP id
 a640c23a62f3a-a59fb9690eamr35514166b.37.1715116848061; Tue, 07 May 2024
 14:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507024952.1590681-1-haiyue.wang@intel.com>
 <CAADnVQK7zD312WRJboMib8HJnNzN=i2FKH2QxkVVy736b7sNTQ@mail.gmail.com>
 <CAEf4Bzbze5D0M2V9d9q90E_XHCMEUa7oXum=wOCVQ_BAugox7A@mail.gmail.com> <CAADnVQJuL18Zkyyztkmzm54yvq3CuB4bSjoL331cmcnX_kppeA@mail.gmail.com>
In-Reply-To: <CAADnVQJuL18Zkyyztkmzm54yvq3CuB4bSjoL331cmcnX_kppeA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 14:20:32 -0700
Message-ID: <CAEf4BzZaGcLTOBL=5nPWx22PKFOD7yg2a-qzV3dJ85S9hpCGjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf,arena: Rename the kfunc set variable
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Haiyue Wang <haiyue.wang@intel.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 1:42=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 7, 2024 at 9:43=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, May 7, 2024 at 7:36=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, May 6, 2024 at 7:46=E2=80=AFPM Haiyue Wang <haiyue.wang@intel=
.com> wrote:
> > > >
> > > > Rename the kfunc set variable to specify the 'arena' function scope=
,
> > > > although the 'UNSPEC' type BPF program is mapped to 'COMMON' hook.
> > > >
> > > > And there is 'common_kfunc_set' defined for real 'common' function =
in
> > > > file 'kernel/bpf/helpers.c'.
> > >
> > > I think common_kfunc_set is a better name to describe that these
> > > two kfuncs are in a common category.
> > > BPF_PROG_TYPE_UNSPEC is a lot less obvious.
> > >
> > > There are two static common_kfunc_set in helpers.c and arena.c
> > > and that's fine.
> >
> > it is actually confusing when reading/grepping code, though, so why
>
> What's the confusion? Same name static var in different files?

Not in general, but in this case it's arena-specific kfuncs for all
program types, and it's initialized with &arena_kfuncs, so it would be
matching to have some "arena" mention in the name. But it's minor,
let's keep it.

> There are tons of such cases in the kernel src tree.
>
> > not have arena_common_kfunc_set and whatever the meaningful
> > "qualifier" name for the other one?
>
> arena_common_kfunc_set is certainly better than arena_kfunc_set,
> but I don't like to make the precedent to start renaming static vars
> because they have the same name.
>
> > >
> > > pw-bot: cr

