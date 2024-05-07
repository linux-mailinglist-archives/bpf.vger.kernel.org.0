Return-Path: <bpf+bounces-28952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585648BEE39
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 22:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B541F23C1C
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152252E62C;
	Tue,  7 May 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEQzyG5M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238977E8;
	Tue,  7 May 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114534; cv=none; b=dVp4NfqwptJrCMvuQ0CIw2NhDwTpndkTHNZ/XLqh9TkYcrG4qtCzvGkigm4xfkFaBIieqXJj0SI7vgGfuYXtIJ6Bbts392EjXeR+IUz4Psm/xIvlUC5ztzm2MBJpK9Ua2EKy5l0aYi+i945QLPLobKKdkOCu0+19HCTw51NymGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114534; c=relaxed/simple;
	bh=kCPZuUN4t/5qb5/ns65qHqchFck1pP0QXE79yPvXklg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azyDvpCelzTt4gsn7szp+g3Z4ykWeKQUddEg4gClfEqx+DdlR0+2Zv7T7DKmEhVzBbmcJb+YJIY/cwE/NZBV/ZY+YsnUZsd6zgcOi1Wa9Rumw8Ei2n11vfB+Oddvh+9Ey/NT42bzvmz08b4nniknD70vPV/7U3hPaMw/lZ/FEjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEQzyG5M; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e0a34b2899so50830071fa.3;
        Tue, 07 May 2024 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715114531; x=1715719331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCPZuUN4t/5qb5/ns65qHqchFck1pP0QXE79yPvXklg=;
        b=cEQzyG5MaefWFmhe44Egt57motKriaW5vYpD3mGF2qdJDKEa20JU08c7dNEx4spAvj
         d7+n8nQU7CrTi7E+ZYzat0vrNbXJokDpOqDhzU8Cfs64Ylyc7ks/lYKfvQXufAOcZi87
         0UrsdsvV36ffUJm05LO7C3a+QLZN1FzG22cWajMqsSgAYmsus+iUqzOtKckO1wtcJfKk
         pIsJS0sPS0G6ODmj0Pf+Ojsqe6E2sd7ICi/9ku7NjLrGZ2PHEuxh7cxJSasYjrUTABvb
         b9JGnOFAGo0iyHimm1fA9vOxaEfTMBR/SKxBqBPm5z4W9joUnAYwE14GhjXCwVf60+G0
         RY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715114531; x=1715719331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCPZuUN4t/5qb5/ns65qHqchFck1pP0QXE79yPvXklg=;
        b=r1DK2n6ZdkbezpSo0/6SKuFGRHwlx51pZd64uUzsfvMG5WqNeDhazq7JNQrPnjPbqG
         6lx21zt0uLHMHPwgypPisI5II4Fes6ykTHlvGWM/K5ijVZ6MvBeyVaQ/2lYN9/tm76kb
         W/N002qjP95FeuMCbx7KKHB2YrrL+PVyNkm6vlYHNozvoiAiincYtcd5tVCo48iW8cD2
         vVQ2dLoYJC4E09vhT5egShLVp/WAiY3HZPzTiBYaCrzThY3L0taO5ZfSPEuFVK9PtzTc
         Ta752DyetUfbKaKuz9od0Rr3ttDH0+EJuT6K2qonm8FB7a+AWfRtAeg+uqE2v79OfjXu
         BZzw==
X-Forwarded-Encrypted: i=1; AJvYcCUfaqzJ5ZWpWx89BEqXAOXZkjbRKBwXRbUEc4Y+0QhW6RLiiXsM8Lahm38E9S3u1afQ7H9BQjj9kLLB7cEGZOVE/6KsCAQCp6a+Qwn9+slNSlRu0dz2hXgseyUcGUbYd4yS
X-Gm-Message-State: AOJu0YwxpgmTz37WPRMzImQ+EhR5P5162fmmrBONtBeCqUe33nGPm3rS
	B/OmMnaZ68If4KyKQUv+Wlr8cXIENyMvmV6UnAj12RD2zbNHRkksS+iOnSKiq4AGVHDS8Ac/3Yr
	mEFqrrmY8mMslefDppEPTHfaaaTM=
X-Google-Smtp-Source: AGHT+IHA5tSY5YImS5LpbKiSZZvrmasAH5RUDvfoUhFtaX2IXPP9G3AVss5gyxGDhAh6Lq3HMLfkxmaqovC4uW0nDSo=
X-Received: by 2002:a2e:97c9:0:b0:2e3:ba0e:de12 with SMTP id
 38308e7fff4ca-2e446e82769mr4903291fa.22.1715114531024; Tue, 07 May 2024
 13:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507024952.1590681-1-haiyue.wang@intel.com>
 <CAADnVQK7zD312WRJboMib8HJnNzN=i2FKH2QxkVVy736b7sNTQ@mail.gmail.com> <CAEf4Bzbze5D0M2V9d9q90E_XHCMEUa7oXum=wOCVQ_BAugox7A@mail.gmail.com>
In-Reply-To: <CAEf4Bzbze5D0M2V9d9q90E_XHCMEUa7oXum=wOCVQ_BAugox7A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 May 2024 13:41:59 -0700
Message-ID: <CAADnVQJuL18Zkyyztkmzm54yvq3CuB4bSjoL331cmcnX_kppeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf,arena: Rename the kfunc set variable
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Haiyue Wang <haiyue.wang@intel.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 9:43=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 7, 2024 at 7:36=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, May 6, 2024 at 7:46=E2=80=AFPM Haiyue Wang <haiyue.wang@intel.c=
om> wrote:
> > >
> > > Rename the kfunc set variable to specify the 'arena' function scope,
> > > although the 'UNSPEC' type BPF program is mapped to 'COMMON' hook.
> > >
> > > And there is 'common_kfunc_set' defined for real 'common' function in
> > > file 'kernel/bpf/helpers.c'.
> >
> > I think common_kfunc_set is a better name to describe that these
> > two kfuncs are in a common category.
> > BPF_PROG_TYPE_UNSPEC is a lot less obvious.
> >
> > There are two static common_kfunc_set in helpers.c and arena.c
> > and that's fine.
>
> it is actually confusing when reading/grepping code, though, so why

What's the confusion? Same name static var in different files?
There are tons of such cases in the kernel src tree.

> not have arena_common_kfunc_set and whatever the meaningful
> "qualifier" name for the other one?

arena_common_kfunc_set is certainly better than arena_kfunc_set,
but I don't like to make the precedent to start renaming static vars
because they have the same name.

> >
> > pw-bot: cr

