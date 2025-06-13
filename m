Return-Path: <bpf+bounces-60553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE45AAD7F67
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F27189035E
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03201D52B;
	Fri, 13 Jun 2025 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqcDmR3W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7AC3C26;
	Fri, 13 Jun 2025 00:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749773201; cv=none; b=MJ+5gr5MFs31pie9KFWEi3CqVzY79xjAu3jRLzPcTUcs+ScMJIZc+NaYmTQs1e5OdLVa5v51PIs9oKWfO5t74eJfDh1aZUQ12fFO7XGStqwh4tUi4OXRDMJfdJ3ONcNmMf5JzpDYFZDp1CteW+0ZCzJMK4EyF9Iiv8TIou1uXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749773201; c=relaxed/simple;
	bh=d0RuPBuCSODcZVIzWEXGOpuiLX63DqP3/tASAAIxyNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXxA1U0FwSXia99N3uwLthYO6rQJbbj+kSmUWDNvrXACLzAt2Lx0digelssL+PjF+/Ss2C/i736AyEf31bWBaiWy6UEGkwYgJ/l3hqx1h/B0+lIoadI1YJfMekp59hYRzVrbTUWppIgWPrDK+RqIoFNpPgNJmCGdH9ChOtH6siU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqcDmR3W; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234d3261631so11271225ad.1;
        Thu, 12 Jun 2025 17:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749773199; x=1750377999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0RuPBuCSODcZVIzWEXGOpuiLX63DqP3/tASAAIxyNg=;
        b=kqcDmR3WAPGwCgwoYRc89Do89m2UihwWZad8jYW2PxBuY5FKEqBBa6vbxbjjb63Its
         lOPf80u3Wai56BhjEI7fdS5UpKXQ2vi7pcRRbSO69zQgAmbgEbAADDY33ueZX2/nE1Ki
         JgUyICIrn7v1YBjenv5Xzfe7eMh+CBUKDQuuVIX+Yq9neldEWafmhe2OAbrhIOJ6P1Qr
         6GGOxJc7UP0u8g6EyqFccytCHrJHuez4RKcGVBDdNqD3fcproDm7bDwYdRyvEJY5kW/0
         uUwiqbV+3dKu/deTpe4+4y3gnLmh9XqvQgIo5iJHFOLhXgdX69aYoALgKHja7bCP8+XR
         wjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749773199; x=1750377999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0RuPBuCSODcZVIzWEXGOpuiLX63DqP3/tASAAIxyNg=;
        b=Ros+UnnoUZWJPI5n4dmXUxNzwjjIOEV52hzN3QOQ1MCuIq7lvPnlr41m2NcmkrAvqw
         zQ3ccHlf1GfhXTa2xlovcI9jGwfqqZ1duShYhg3wZFqnftP7iGSWshaK1L3aT+nnyzop
         vaXLc5DQmqAVtmlyOYak/ZDrTl2cn8ULj1azD6Ue20uOJ/iakDsZoLcKxk1T9psCFHD4
         kx1pZ1+xemHbuYi8GdRF+CROj+ARAHW1p5ocGnYipCUcnhVuu0TW5prsHR+enpmyBF0M
         PGQjZ9HbuyONFV2etcy2naYAgI2HtAo4kKzlaPyTqROQ5NM/cZvxYgcavJwKdg/GoOxh
         3AjA==
X-Forwarded-Encrypted: i=1; AJvYcCUXAJi9clpJjh6qpEfEZqkqfvYSrt09xaqKqjsr2ZhEpauA6B9vv9SMWedSjnfxjy1NIpA=@vger.kernel.org, AJvYcCWmW61MgIN9skJ1ymeFNs/U8zsGkO5n1Z7IH5qYoM9Z6VVSClkrzZnhztxT+X94QYh9jnKaAdRjcNyPSnQLkh58qRTz@vger.kernel.org, AJvYcCXArtR6HSvmu6SRHdlkOMS240+KSnPqCV/U0GJ9ZAFLXZHfYdC7OxuXfZMKCDp8Jhyh3PuUiL+98dkMhEMX@vger.kernel.org
X-Gm-Message-State: AOJu0YywL48QahWdMqbdhbP5gYPp1cdaq4e+1PtSkdpGupMF6FbfCs2g
	Yck5IMHRT7jIb0qOYF1MauSqV3IM3+zYM1fu3oLIDzkD3zum0baXhfyehZIjjL9P8ujL/L1Jq3M
	0lTGWHKI7oEDaziJDcAw54QdpJvjlRuA=
X-Gm-Gg: ASbGncuRgXVymIvlDGhTeOUd9eWJTS3f2K0sAuHqzNo5aQ3Mc+LUAkWibtawa4znbGu
	0VpnxxcvN0qngN07tgGtge493aDZnS2s8R1yFqPk0xCd4uwfqGHD8h8pjo7jicMsBZQD/F2lXEY
	rWEjrmGXSGZ2wkHW41DV3eLuUn9jwn2yDluyT9fPhbdRZvNrdPBkncmwFBFA0=
X-Google-Smtp-Source: AGHT+IEPSLsTexGUKwbGZB+a2Mn+hEIdnHaQwmU6KUzaqp938CS+7Eeo1eX8520vbqupCXYDLWrets8alAP3ZKxaAPY=
X-Received: by 2002:a17:903:1a0c:b0:22e:62f0:885f with SMTP id
 d9443c01a7336-2365dc0c4ebmr14191995ad.40.1749773199120; Thu, 12 Jun 2025
 17:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611154859.259682-1-chen.dylane@linux.dev>
 <CAEf4Bzbn=RVhMOR7RapYwi+s8gbVS=1msOuZ7MhPvgz8zHiE9w@mail.gmail.com>
 <CAADnVQJ8cVi4KyJqWgEfyWYs+zSYQ73PevrNszPkisrdPSjYMg@mail.gmail.com>
 <CAEf4BzayBd9e5c9fiEPgDKPoRm-E4uB_u__xKcRpXDz18kNnkA@mail.gmail.com> <CAADnVQKw2u9y-Cf+8idB0bZ0v-p6BtuyRV=JpmN4to3_1Z6GEA@mail.gmail.com>
In-Reply-To: <CAADnVQKw2u9y-Cf+8idB0bZ0v-p6BtuyRV=JpmN4to3_1Z6GEA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 17:06:25 -0700
X-Gm-Features: AX0GCFtzlARaYcK7r342SFEPGz5cXS3H7NHCUuu0m_82OyNKtt6PfeiRsBWeHuc
Message-ID: <CAEf4BzbScdvawnTZ7364bXxU2QpW_ooCB-tjohBgC4WSvFigFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: clear user buf when bpf_d_path failed
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:56=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 12, 2025 at 4:27=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jun 12, 2025 at 2:40=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jun 12, 2025 at 2:29=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Jun 11, 2025 at 8:49=E2=80=AFAM Tao Chen <chen.dylane@linux=
.dev> wrote:
> > > > >
> > > > > The bpf_d_path() function may fail. If it does,
> > > > > clear the user buf, like bpf_probe_read etc.
> > > > >
> > > >
> > > > But that doesn't mean we *have to* do memset(0) for bpf_d_path(),
> > > > though. Especially given that path buffer can be pretty large (4KB)=
.
> > > >
> > > > Is there an issue you are trying to address with this, or is it mor=
e
> > > > of a consistency clean up? Note, that more or less recently we made
> > > > this zero filling behavior an option with an extra flag
> > > > (BPF_F_PAD_ZEROS) for newer APIs. And if anything, bpf_d_path() is
> > > > more akin to variable-sized string probing APIs rather than
> > > > fixed-sized bpf_probe_read* family.
> > >
> > > All old helpers had this BPF_F_PAD_ZEROS behavior
> > > (or rather should have had).
> > > So it makes sense to zero in this helper too for consistency.
> > > I don't share performance concerns. This is an error path.
> >
> > It's just a bizarre behavior as it stands right now.
> >
> > On error, you'll have a zeroed out buffer, OK, good so far.
> >
> > On success, though, you'll have a buffer where first N bytes are
> > filled out with good path information, but then the last sizeof(buf) -
> > N bytes would be, effectively, garbage.
> >
> > All in all, you can't use that buffer as a key for hashmap looking
> > (because of leftover non-zeroed bytes at the end), yet on error we
> > still zero out bytes for no apparently useful reason.
> >
> > And then for the bpf_path_d_path(). What do we do about that one? It
> > doesn't have zeroing out either in the error path, nor in the success
> > path. So just more inconsistency all around.
>
> Consistency with bpf_path_d_path() kfunc is indeed missing.
>
> Ok, since you insist, dropped this patch, and force pushed.

Great, thank you!

