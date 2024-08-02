Return-Path: <bpf+bounces-36291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0FF945FC0
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 16:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1681F221D2
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831D62101B7;
	Fri,  2 Aug 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAPImkc6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55AA1C693;
	Fri,  2 Aug 2024 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610750; cv=none; b=p3tAR4ZFUnq5qRp3Rhcwfmd5/OOw+y9EydIVTwmhRpN+5O040x+LMTDtpX3pRTaAL59xtRLL4UMzEUtd1PCgiLrlCkcbC5DcIl6pq2Ie3ILSjs7stxYtw1V2zHc09qckyg3ROitimD76VVspjE2Kf/5d06cVM47NdcTcFApmYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610750; c=relaxed/simple;
	bh=mYvCEvH3+zbxu8wR1gh4uiNJSJQs9Tpyx6Yp0ac69Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuvCdJPRZalT6I0LUI6nwkzr6NxowpjD8Bwu/94p1mi+AcENmynLqpv35Chxy+GoGsIdO1WVO5+4QJhmZHSQXEKpSQlg4+AKF+woqUPy/ZfwexBdPrc+MxQh8lRk1aCbzqezTR040v2CQgSbXZh35fSW1QOGYf5JVuD0xfnLb/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAPImkc6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb566d528aso6290154a91.1;
        Fri, 02 Aug 2024 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722610748; x=1723215548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksrfRIOym81+d/TakLaeIMoPxOokkMxFqhaoqSJd+bc=;
        b=AAPImkc6oh3yf8RljzNszS8Ab2bMh32g1ZIfBbt8UGY+ms1wpoZKRxktzZV0LwdQ+6
         BKOtR4w/TeAucm5ZNapsyhFGlc069z0wr5qcBSVr8Swu/NIqWP2JpaSWGuigfY0VDHZF
         M9ixy6kJNovsCbn5zl/Chd/YTuKaay7Az8V74ZeSUhwI/C9Qm0GTPh/HOnS1yfTVyCOg
         eJEL0YgfrabZKyXc4jSO0Tgs0MjY3MkpIYitzW8DYguqL+IxbpOv/waD22gqdfQVhz5j
         TCLRlPvT6ZeRHMCKJp3xrEIvjSOEltYwBAsrtD7tpwwz9i44L8rh/vPLt6O4Igi+U5Nt
         fdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722610748; x=1723215548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksrfRIOym81+d/TakLaeIMoPxOokkMxFqhaoqSJd+bc=;
        b=Untbs9xmrBKHPdfZOIWukqVZJGgMRTg6PRUPLQuXvec9aFDwhihkQOY+okNvdWM2F6
         aZjUHqOr2xI5aJpdvXkh0+bKV3cLh9tYPCNmKMMZ4BP/JCBlVNiW2/4dBh+ZXrMpnJtV
         Muwucb2Fkz0wBXGdJ3Z+WWfopHZYBGi6ZQg2ppzs8Q3e/h78V61cDE1UhI890SHEJQXy
         6nAQ9LilmTCsukE06B7c5KkvmOECkgtBpcQfxQ62w8EPL3rg8gPy2bn9+4jWm+LbNAO4
         8SXiYsEM7l7PdMqq7u3+ul7ewDpx1bOkLad6zMh4EVTMWZAq/+28BMoxxVvM6lWtKQiF
         ty5A==
X-Forwarded-Encrypted: i=1; AJvYcCUirRHRawuY+MV4K7vjZ7ES/CilSzrqETV+JqR3UpuAwuviKIemslBE6Yx6JDUhleeFyG00fWkqnZAUj+ONesIpD86HElasRTELYcjrHD9Ru+hm0hBa6Lt4Uo6biwsxBeRu5Ta+OmD6ySbhBntxxDuh7nbEeGG6y7GPol+nlnpVFspUXVxy
X-Gm-Message-State: AOJu0Yy6HZ4HSIwmlxAhwqdb5f0KN4Gs05T+Lf04STwaXolhABupnCIJ
	T9M6AvoNlBRBgxlG/lTqBvgjb4OQ7+/oTDB3h2pBRE/xvQyGu4yEu75jqkNi2WGtVxW051511e0
	aPDlcBCuPA5yrRDbhpSpHgi3ELY447w==
X-Google-Smtp-Source: AGHT+IHanotrSNkv2MBBxGfqb8LNgfeYDRyTx4IF0b6ggY2JmMZBm2P2+KAQ4Z9u8JGnEeMlx2lO7h+zfZiaiGu43AI=
X-Received: by 2002:a17:90b:4e8b:b0:2c8:716f:b46e with SMTP id
 98e67ed59e1d1-2cff9449562mr4697128a91.16.1722610747824; Fri, 02 Aug 2024
 07:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-3-andrii@kernel.org>
 <CAEf4BzYZ7yudWK2ff4nZr36b1yv-wRcN+7WM9q2S2tGr6cV=rA@mail.gmail.com> <20240802085040.GA12343@redhat.com>
In-Reply-To: <20240802085040.GA12343@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Aug 2024 07:58:55 -0700
Message-ID: <CAEf4BzY7fBZBJo3PGaDLp6yzpi7S9QTkcirP+Nz03rL2wcU-0A@mail.gmail.com>
Subject: Re: [PATCH 2/8] uprobes: revamp uprobe refcounting and lifetime management
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 1:50=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 08/01, Andrii Nakryiko wrote:
> >
> > > +               /* TODO : cant unregister? schedule a worker thread *=
/
> > > +               WARN(err, "leaking uprobe due to failed unregistratio=
n");
>
> > Ok, so now that I added this very loud warning if
> > register_for_each_vma(uprobe, NULL) returns error, it turns out it's
> > not that unusual for this unregistration to fail.
>
> ...
>
> > So, is there something smarter we can do in this case besides leaking
> > an uprobe (and note, my changes don't change this behavior)?
>
> Something like schedule_work() which retries register_for_each_vma()...

And if that fails again, what do we do? Because I don't think we even
need schedule_work(), we can just keep some list of "pending to be
retried" items and check them after each
uprobe_register()/uprobe_unregister() call. I'm just not clear how we
should handle stubborn cases (but honestly I haven't even tried to
understand all the details about this just yet).

>
> > I can of course just drop the WARN given it's sort of expected now,
>
> Or least replace it with pr_warn() or uprobe_warn(), WARN() certainly
> makes no sense imo...
>

ok, makes sense, will change to uprobe_warn()

> > I don't
> > think that should block optimization work, but just something to keep
> > in mind and maybe fix as a follow up.
>
> Agreed, lets do this separately.
>

yep

> Oleg.
>

