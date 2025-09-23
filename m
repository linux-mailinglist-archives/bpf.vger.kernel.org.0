Return-Path: <bpf+bounces-69472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F21EB9753F
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 21:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7467C19C8743
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 19:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483AC3043B9;
	Tue, 23 Sep 2025 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRuk6BEA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D491DF72C
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655438; cv=none; b=ZacVLVFGl3RzQLDMN95Goc6aQDABOFVM3ogL67VW3xyCJvEG2cCKQYmbYf7g0PYzCZiwtsACBUU/jeNdMp2hdnO/57DjX7HvD3us5cybrqBwL/rHMLc+fp5Syyy+aTjBSFIi53TZhC0E9eJNY+WHBW6zAB+1Do1/B3A5X3VXZZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655438; c=relaxed/simple;
	bh=LRBey+Wso4WI7nXLbVLoJP/j9B8XR/yd5YE842494Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZEO7C355bO52kdexgV9apXrRHfHDF2NpJzcMllKXfu1pTzVtCW2o8M1Js9U9Yz/K85QUcn3si+hZSo3U0l5ON71ghcHFy7sgN8eQIXMdDCs/7C6hebSo52ZB/O3+PchsInZK15slF+TcB2nvt316OpiLrZsbeoNbKQUILK5CNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRuk6BEA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e23a6617dso8563325e9.0
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758655435; x=1759260235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRBey+Wso4WI7nXLbVLoJP/j9B8XR/yd5YE842494Og=;
        b=WRuk6BEAyG5qd/meHhAM7eAqaL4r5/fTvTQySSK8FWKMWz/phX3T8Bmp5q/Eq0P/Hy
         BY01guXAPPgv8Ar/955Q2cy0dFp0spY0ubCvaE9qllh5ppuue09ewDd7vBAK9mEz9g/m
         uZ+EFqLTh2Xh67Fcfj7u4QKfuDTUrpam5XWflOds4o9hSPM6vOsq2k3qyZjA0fIt0tF9
         7AELidGe1q03KzEBdwXFv4J8PcdVHeYgXNc3Jr05WkF+L5uc8OUUb+MnCqyVgP9329BP
         +2nJQ1cP+bM72QQOzpVnJ1v01Bp6QVcUiK4DvXykNtzaq2554VYieYn2d+d2rVPBis2S
         6MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655435; x=1759260235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRBey+Wso4WI7nXLbVLoJP/j9B8XR/yd5YE842494Og=;
        b=HK8PhnV77kEZprLadWYVMtH6QkBsC2Mm15goDS4jQvNkVOocUkiJ2K9kHOgToYiHT5
         YNVKhqUDuaK8F2lYZIeOqAXWECC4yPFZ50ImU7Lo1kI4Fa1pzLjIQ5lWrTENtNf94gQz
         NgqVtR/KupKuTNWTIOFKwdweO5N96958HvY6HIabg9HnuaE1v18Xoapv+il16PwA4h2a
         4Krge9II09B1NQNGKNcX8WTO7xo9AaVw6PfptmGK1xZ4uimqYPYU47NCSLggGW+a0H+3
         6kP3ugo5ZdF5WRE6MIcI4Ar+50KM0/KZWNpX+1oLQHgMLJWCSBqRXvXaKlhEO8QLrD8t
         DduQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1DKMIW9FO/11MKGq2HXscOoaFpz2QECfXP+kQUI3sOrnOQ650DiFGiLxk1GfmrhU9YtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSWjGkRFkuffYnItXdD6wV1KT0zY9bUgNIW4QD0Q10gtbe7/j6
	kz4lnKOHfZS2wf8L5OMHAJQHXisPQC+U4zQKct1prwZT9cxyA4bPfbTCA/6UDBTLRNjqysqaskF
	ZStBx1hCqMptZLWy9vccEoIVWHzk/C+I=
X-Gm-Gg: ASbGncuckZuSDLBU0jlP8uivTOTrtrUCVFNQjbSqdWkwCL+33YHNHbf2H2dc/4J/zOC
	IL4ITxvn4rf5Zjfb2GhYggphn0ZqTOSXM2gsW4M62yTg4mC/1e2/4y8IxuBtmvjklrzr+0l2hVu
	T2TtHjr48Hrt8JKcZn5gXfDzFWE/niLZZVHHupnWR/THTjsQ5n8cacemK8xYOH6pp845Vwnlww6
	UN3Rls=
X-Google-Smtp-Source: AGHT+IEROyvN89zXwrTLvHEBfh+lTjpX1gLN5zjZ4UthmYExEG2GOLLm8ftHboFI82Own50+u3ZOPpnUc08RGvIFLxs=
X-Received: by 2002:a05:6000:2f84:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-405cb7bb76bmr3258549f8f.43.1758655435354; Tue, 23 Sep 2025
 12:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922095705.252519-1-dongml2@chinatelecom.cn>
 <CAPhsuW7THs9G+QV5_g+tMvXTAqVJ7jha-m70f675e9phK1Pryg@mail.gmail.com> <CADxym3b=hU4DuuhA_DAs6VYNUTp7spTsTWamMaxDGSxjoiuwbg@mail.gmail.com>
In-Reply-To: <CADxym3b=hU4DuuhA_DAs6VYNUTp7spTsTWamMaxDGSxjoiuwbg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Sep 2025 12:23:44 -0700
X-Gm-Features: AS18NWASmv7blurpmrNo9VunWCEk5u9gzididl1CMRVq8cti29RRJ98n7ZkNCbQ
Message-ID: <CAADnVQLZMwNUF0PwoCyLUC6tWVuyx80qJF692VgnGoJVm_M=eQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: remove is_return in struct bpf_session_run_ctx
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:11=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Mon, Sep 22, 2025 at 10:08=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> >
> > On Mon, Sep 22, 2025 at 11:57=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > >
> > > The "data" in struct bpf_session_run_ctx is always 8-bytes aligned.
> > > Therefore, we can store the "is_return" to the last bit of the "data"=
,
> > > which can make bpf_session_run_ctx 8-bytes aligned and save memory.
> >
> > Does this really save anything? AFAICT, bpf_session_run_ctx is
> > only allocated on the stack. Therefore, we don't save any memory
> > unless there is potential risk of stack overflow.
>
> Hi, Song. My original intention is to save the usage of the
> stack to prevent potential stack overflow,

8 bytes won't matter, but wasting 8 bytes for 1 bit is indeed annoying.

> especially when we
> trace all the kernel functions with kprobe-multi.

What do you mean? kprobe-multi won't recurse,
so tracing all or a few functions is the same concern
from stack overflow pov, no ?

> The most thing for me is that the unaligned field in the struct
> looks very awkward, and it consumes 8-bytes only for a bit.

let's keep it as-is. If stack overflow is indeed an issue we need
a generic way to detect it and prevent it.
We've been thinking whether vmap stack guard pages
can become JIT's extable-like things, so when stack overflow
happens we unwind stack and stop bpf prog instead of panicing.

