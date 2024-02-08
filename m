Return-Path: <bpf+bounces-21493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D22284DD43
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 10:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCAC2852C6
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215E16BFD2;
	Thu,  8 Feb 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIXaxPxu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E86BFD1
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385719; cv=none; b=agW1g9QtsH0uJgHdSLLRhL3O73isUcXmFxD1rs06NJBhMXBu8dv/2JJz6x6i6svYW2mdQ0Pi+Ddyy2RJ6YLJ98fwtx5vWjJHKPfLbH31zYH5e4fLtW7EgYcYpcZw05kBLVID8fnjUqJKxhkMZ+R1finqi+RY4gIvbOHnrcEA/fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385719; c=relaxed/simple;
	bh=qOacMU7zq6sy5TmP6sQkNRjUU/DFEfB4azRzOXM+17g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrROIw7VZBnf7wd68vrr4LJF3tN3lYPa9JoMaPkWasp/9eEIE61w17w671O2ii2SvWJzCCVm8s3uuF+abfP7FNXU2/D7gS1GWSmg2OM0SYU5H1C5lMonkO+YfCUQ7plBdNmbv9TzF1TBOkGbAv5rYkMdjwTry6IbI4Y6aSoC3Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIXaxPxu; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6818f3cf006so7461856d6.2
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 01:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707385717; x=1707990517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDVsH9zN6mmQVqPHbLxFkjCvKwYuB66O6yJMaYVTkj0=;
        b=SIXaxPxuO82+d6DgbCUylETMXxYrxB5k3pXri+a3enEHsxFrzRx00t+M6Loq/tceWl
         T9Fiulp3zdZwaQY9kLGytSO22lKLtGHC6x5eNxs5/0FK87W2/qw4wiPwx0G5HZEBTmvi
         VT4aMbuF9CD0mcJxklEpPXdXpGcxCzoTHukeu/PxJTypOLSzMLM8nshLnBplHFPBUsTY
         xQBxZpnp/rIrUR4Ms1594vhx7gNreDjSJZwdc8s03Bg1D0SzsPQfVYTk1dK7izUGgdFK
         Zh8ao7KeF/5vBHG2UhOMXaBV2GKV6qY/Q6nhbrc/8LGItDJbsAG/saI/U9PY8XH2I6yg
         C4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707385717; x=1707990517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDVsH9zN6mmQVqPHbLxFkjCvKwYuB66O6yJMaYVTkj0=;
        b=T0HqoN546faYLbCcKY92qRSDTb8OpNM4Zn3e8jmnD50pYdqPhuBW4/XrP3fF8JWpFR
         gnlUGAfwdn+Tm8cVDA0TBfFjC8IOhG8oXOLfAq8Cg/n0dVTwbY4amItkK6HvcY8cu/FD
         yjsFuxgOffec2x/yNDl4unAtguOuV5ku33AdgiYohGAHA7KrjqbEw/WA8TDEPm0BnaeW
         ZCakRwKX/TplUkqwhsKNwbAUlHeXIcM2e1diTB1UewlCnDy41BWghCvFRyQthiF70HbC
         u9FpXA7f/exE9KNtnlhk2y0/18L5ujbvk4H5nY04PB+SY8MLD3Cx33Ss9pPiobx69w80
         /FGQ==
X-Gm-Message-State: AOJu0YxGkfNY+xx10rqCE5REkUB+Gg4zfOxfn8i8F1dPQvrjN93ItfvE
	9has1xGbCsO19Jl7x591P+LiqoM1Bpw7rZ/kz9usemD9k3WYuwHv5kf89TAMm9gDheE+l0vXmDj
	X+BIoi0w+voKYk2MpvMnJlXM2x3o=
X-Google-Smtp-Source: AGHT+IH4qN2KiweWGjN4bLxiclDGBWphl4xjxfs+2l0067p5DoDe/rHs61/zXqFNoGKD4SwFbTwB4pI3xmfrds3bSgw=
X-Received: by 2002:ad4:5946:0:b0:68c:908e:eae1 with SMTP id
 eo6-20020ad45946000000b0068c908eeae1mr10112029qvb.26.1707385716962; Thu, 08
 Feb 2024 01:48:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208090906.56337-1-laoar.shao@gmail.com> <20240208090906.56337-2-laoar.shao@gmail.com>
 <bbe097d6-b9be-46d1-bc66-630c23d0f9a8@bytedance.com>
In-Reply-To: <bbe097d6-b9be-46d1-bc66-630c23d0f9a8@bytedance.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 8 Feb 2024 17:48:00 +0800
Message-ID: <CALOAHbDTDMogbm-9ch-j9fiUckRrDbFOJZSr0PtK+Nd9HF3Y2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Fix an issue due to uninitialized bpf_iter_task
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 5:41=E2=80=AFPM Chuyi Zhou <zhouchuyi@bytedance.com>=
 wrote:
>
> Hello,
>
> =E5=9C=A8 2024/2/8 17:09, Yafang Shao =E5=86=99=E9=81=93:
> > Failure to initialize it->pos, coupled with the presence of an invalid
> > value in the flags variable, can lead to it->pos referencing an invalid
> > task, potentially resulting in a kernel panic. To mitigate this risk, i=
t's
> > crucial to ensure proper initialization of it->pos to 0.
> >
> > Fixes: c68a78ffe2cb ("bpf: Introduce task open coded iterator kfuncs")
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Chuyi Zhou <zhouchuyi@bytedance.com>
> > ---
> >   kernel/bpf/task_iter.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > index e5c3500443c6..ec4e97c61eef 100644
> > --- a/kernel/bpf/task_iter.c
> > +++ b/kernel/bpf/task_iter.c
> > @@ -978,6 +978,8 @@ __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_t=
ask *it,
> >       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=3D
> >                                       __alignof__(struct bpf_iter_task)=
);
> >
> > +     kit->pos =3D NULL;
> > +
> >       switch (flags) {
> >       case BPF_TASK_ITER_ALL_THREADS:
> >       case BPF_TASK_ITER_ALL_PROCS:
>
> LGTM.
>
> Actually commit c68a78ffe2c ("bpf: Introduce task open coded iterator
> kfuncs") initialize it->pos to NULL. But it seems the following commit
> ac8148d957f5043 ("bpf: bpf_iter_task_next: use next_task(kit->task)
> rather than next_task(kit->pos)") drops this initialization.
>

Thanks for your quick response. Will update the fixes tag in the next versi=
on.

--=20
Regards
Yafang

