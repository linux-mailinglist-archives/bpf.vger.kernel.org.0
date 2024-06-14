Return-Path: <bpf+bounces-32194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6294790909C
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 18:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631EC1C2135F
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8272B17FAA4;
	Fri, 14 Jun 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNwwPrxO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8620316DEB8;
	Fri, 14 Jun 2024 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383227; cv=none; b=AJpGljmmjMUDUmpT5dDqJ9LKK+YtMlbnOfIfTla/mJBjcgbyUICjRGcbBWuee7uiW9Lft4Svc/a1y8Q972gGUwcDMUsBIAGinxq92YZtEMFZwyl/HkaEsRoXBM2rKMtEl/fanySBnEkX8+6V+qsLS4OUPAUqCVxItPUv/bSvRnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383227; c=relaxed/simple;
	bh=yejfZKnOtR3JbjBSGM5OWTQp5i/1krtlrjkOlmbwGbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvdQtyd4kFGntCVqhWFsOeZEgjdc29uZh+fxSlK5/ecyyslPpyuN+qfDUB2x5mFDd4xTMlHWgqCag4Fm2G5KvzbO7DV06CZpdER+BYD7FdTQ3MNgg939fKnwfvvr2BaOsqgrqbIFMahBhGvgd/VvIitzFtaAhhBJ1jnIhG//hlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNwwPrxO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3608545debbso497809f8f.1;
        Fri, 14 Jun 2024 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718383224; x=1718988024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cva5ubDay+7L2mSctSJOBdcLAJjx5eNheeoTqcRQMs=;
        b=ZNwwPrxOhwt8ylpwXYmbASD/JtKHdTgFHawjcWkHG8Pw01bTbfRYnUIuV4Lo4pZF7P
         FxOdTHS5NEHxHINOys3VSJbTWuKks8SryYXHeOhnnVkC+eBXr1hhlmMYrEeAM/NZQPVP
         ln2w8iOw8gnDUzqsb7n9Vr2ifLEkgFfclp5jryBIboxKlCvjm9jsySjvUEnqnpZ/Jzjy
         OR7XBrGzyohl6ThKnhDBReeFg/baLymeIhKjCxhdTFWVDVUIzVWknto7XlaIYWcTnu0w
         PYe6sqP6qiopqTBNDCK1fx+Orho4rXOZLlz3ZXvCgIIVpQgZ+g/zx7FX7qYmBajWU04j
         oBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718383224; x=1718988024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cva5ubDay+7L2mSctSJOBdcLAJjx5eNheeoTqcRQMs=;
        b=POcUGWsyIHr89b2JCJhNdcFxGTUZqGBebUSQrTB6YUrIxkMcGRllBSuyCFVCch+ot2
         1jfUsHnWKkjQQX/qrLr0A1Fzip2VoslNchyOZ1Z2zBfRZ4UmUHewic4HNb0HX2Rcd8V8
         C5e1MDf8RxHOygvWrcqVULzp/vCGar/po454+xu4YwvWc+dxkHwT/0FWqhtgS6c59WxD
         gsXxgb8nzShuLFIqvLNmQmb+yXGlduA3RRT/h98+t3gXYGyPyU3+0POvkEWnida5SYqr
         S1ikX6jkUuxFqZZmlVLImtpktLIVyoxn+eE7t0JXleMuVDT27UMgFOB53228Z9q8uZtP
         TAkw==
X-Forwarded-Encrypted: i=1; AJvYcCWrOfH13DU6YeHYQrv8joSP4PkHQkXQPiRVnEBAXIr9uE6LYyutNOcnIcKQcefaiUhbMk6cokyYzp/IAUA//fn22okd4uKJbnlK/wd+yo0EHtHNd4wTXPESv2QoaF6HVGUE
X-Gm-Message-State: AOJu0Yy6PrgSd+iXguY5c5AE0VkrK2rqY+eJ83psRKtPg4dBDIdsPx2G
	bwQwewEqJnoFnwGtTqUD7w1fOv42nDRu0N6aWrfnqDzp5EE0q4RMI+KUbqbAlka0LxNMkKydkvj
	6BYWUKn3H8oooz7UBSxLBTh6FyDY=
X-Google-Smtp-Source: AGHT+IEGRhuND7qmTE5KFh84lubXWjfv+DvC83JjimqS9AxVyzQGDKUQbSXO5q8FTMr6ZJGydn9cWCxC7i1JJtlXAQA=
X-Received: by 2002:a5d:4108:0:b0:35f:2935:7cfd with SMTP id
 ffacd0b85a97d-3607a739eaemr2071929f8f.27.1718383223630; Fri, 14 Jun 2024
 09:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4b875158-1aa7-402e-8861-860a493c49cd@I-love.SAKURA.ne.jp>
 <3e9b2a54-73d4-48cb-a510-d17984c97a45@I-love.SAKURA.ne.jp> <52d3d784-47ad-4190-920b-e5fe4673b11f@I-love.SAKURA.ne.jp>
In-Reply-To: <52d3d784-47ad-4190-920b-e5fe4673b11f@I-love.SAKURA.ne.jp>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Jun 2024 09:40:12 -0700
Message-ID: <CAADnVQLB6Zt1QjW+BeUmQJnWzGeCr7b2r0KKfygsJPzo0Rq+4A@mail.gmail.com>
Subject: Re: [PATCH] bpf: don't call mmap_read_trylock() from IRQ context
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 8:15=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/06/08 20:04, Tetsuo Handa wrote:
> > On 2024/06/08 19:53, Tetsuo Handa wrote:
> >> inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> >
> > Oops, "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage." example wa=
s
> > found at https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D14f01=
79a980000 .
> >
> > Then, do we want to
> >
> > -     if (in_hardirq()) {
> > +     if (!in_task()) {
> >
> > instead?
> >
>
> "inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage." upon unlock from I=
RQ work
> was reported at https://syzkaller.appspot.com/bug?extid=3D40905bca570ae67=
84745 .

imo the issue is elsewhere. syzbot reports:
local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 __mmap_lock_do_trace_released+0x9c/0x620 mm/mmap_lock.c:243
 __mmap_lock_trace_released include/linux/mmap_lock.h:42 [inline]

it complains about:
local_lock(&memcg_paths.lock);
in TRACE_MMAP_LOCK_EVENT.
which looks like a false positive.

