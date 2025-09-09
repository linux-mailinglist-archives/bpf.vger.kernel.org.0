Return-Path: <bpf+bounces-67950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D139EB508FD
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 00:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2991C23D1C
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 22:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5356526FD9D;
	Tue,  9 Sep 2025 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ4rU6pa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8CE1D5160
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757458166; cv=none; b=AIIem0QMG0T+zND58nUy6DdadBMEQJchRcaGagpXYUCWIJV2aVGj+m2Af+rP+xK0RqySpEAn9niEPTD4Mlcw9B6NW9SDGTBN5kbjgTEc+g7fCdAjmTTHNi1el4xuo5AYw24GC8yujl+4HyjcJ7BagC3flUdsfPfuUu/iUWZhhNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757458166; c=relaxed/simple;
	bh=oYeLpezi2lygDvODxkiIBdCltlAqXF8CbaBfrHFenWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ul7uTkGGB2NjMUQORBqx05GvihtshLrftltKuyTYM/ECetuA0JwzPQC7zJ7EI7nkov+IzObJW4Af4I1OQfJaIdLODv7u4AfnGrmNPOFnaG5kCOHmW5PUST9FJN4Ke2rHX+TxwPhO0S8vqsrUK72Lz8J11rN1JaBVzS8jfFEfT5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZ4rU6pa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45df7ca2955so641865e9.3
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757458163; x=1758062963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6e/XTG5ZmHW3GVSLoAa4gsJf4tjLmx2jEYye+e9nvU=;
        b=hZ4rU6paVCiuFOsIstsnbpTSf5/ENS3jvIp5H/ZltFVYXX0AMvtZCD5O1wRulaoAyP
         hCsFcMEkSDxfLQGn8z1yxCyINsCmtRZh30LK4NwZwox859MqC+m4V/IWES1tX7VdSHC+
         Yr037lQLIs7s1Vf7HcLL6S7uJl004/FYPbIsEYiV8t3BiIxRE2DMvXch2cx0j14ILA58
         CzC80q4WqZ/zYPtYP/mWvy5tRBn2wXbLPHc1jbYx237ZZ5jeB8DyRXfl6dm9gzykdLix
         WE+pFsgJ9rp0IiwOpmPxqWrfftGrzVLieKZFGQWtcrDlUVoS6B6Xz5GaeUUkUK/T76cj
         LrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757458163; x=1758062963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6e/XTG5ZmHW3GVSLoAa4gsJf4tjLmx2jEYye+e9nvU=;
        b=oeIYD4P0iFOdhwpKnTJqd0HlsXuoQmNMFaH03m1wr5Y65jn7K6SEJZyl4ye91kvUnT
         MezglEmxfJp0KZC76xndgeHHbZxQKAkbG4msgvotDNgOE8kDhWbvPWtABmN//9oYIMLB
         EMOmqvZSq0i9JrRpy4hUojvd5AtP5SymhLLhu3SemsxfugA9dIDYY/QHhEkUdcOcF+d6
         q2lIvZivq4sDODANRPNVr7agEBl9BSwkMTThxwNcXN4udoTUHH/VyVx/1hsirLQDM6RW
         ol5H+MqINANsUHEmTdFI+sS4H7L+A1Y8WsqudtD7hMBYblIUlSES01w4FwNtjKeDrIfh
         YHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU95eYJ3Zi7cnOjbtb1cX92GMOoxV0yOPVk7AToSEOvRbB9+bFspvsE5bgx6c11ViDEa7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoSgZTWVH1LRhxp/buMiXTOFjXutnW7MvfKz3n8m3l/A+qXzHb
	4MauVorzra4czIZ9bOkKDD9Myf7NcD1Xyslsm9Dbnr6W0AggrdhcxCz2heScI6iqvjRxstchwql
	wEvdMuUxdOV/ek2FTIC1KwKPV0BuFoTw=
X-Gm-Gg: ASbGncv+BMKXGGMVh56aMNNn708CC+K6OIUbRSXtfcFyW+GTt+VoXABFkNo4JQZweCS
	NqW52k68GAH16yUyF8MeKNg4qMoePHOzCkzs7sYQ1Sr2mCV53SSmURPTp7MciGUc+e8ZJwmT14Q
	Lvjf1LmurZlJFiS+l+aBeOOxS0QGCSuk/nhfRg6xf/PVmN04WTbYDI5Wiqtf/jsUfkSqTyJW8W1
	LNRZZt0cA0DUWqpzbzrzc2DQfx83NU6t7Ek
X-Google-Smtp-Source: AGHT+IHhASld7eYwkECOX6jRyQfBuwToM/lIkeMyqqLXH/wDmy8nzANfz/IGkcHu9M1VC7S64zJfGexoJpPYLZw4v1I=
X-Received: by 2002:a05:600c:4695:b0:45d:d2a6:ad8d with SMTP id
 5b1f17b1804b1-45dddeefa0emr104932945e9.29.1757458163342; Tue, 09 Sep 2025
 15:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908044025.77519-1-leon.hwang@linux.dev> <20250908044025.77519-2-leon.hwang@linux.dev>
 <b0505a919d39e8151d0e14d9e41950f19d3807e0.camel@gmail.com>
 <603b37f4ef1a3ccbb661eaf11f56da9144bdcb66.camel@gmail.com> <aL9bvqeEfDLBiv5U@google.com>
In-Reply-To: <aL9bvqeEfDLBiv5U@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Sep 2025 15:49:12 -0700
X-Gm-Features: AS18NWBYHBMG17K0WfJFCWijU0kNB9dP1UyRQG600j7sCq9XuSCOnMHYd-X1CCM
Message-ID: <CAADnVQ+G4u1vM7OUUKaos+jyG6FF8-72t8rMKyqRoa7nuF8xFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject bpf_timer for PREEMPT_RT
To: Peilin Ye <yepeilin@google.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:42=E2=80=AFPM Peilin Ye <yepeilin@google.com> wrot=
e:
>
> Hi all,
>
> > > > [   35.955287] BUG: sleeping function called from invalid context a=
t kernel/locking/spinlock_rt.c:48
>
> FWIW, I was able to reproduce this pr_err() after enabling
> CONFIG_PREEMPT_RT and CONFIG_DEBUG_ATOMIC_SLEEP.
>
> On Mon, Sep 08, 2025 at 12:29:42PM -0700, Eduard Zingerman wrote:
> > On Mon, 2025-09-08 at 12:20 -0700, Eduard Zingerman wrote:
> > > On Mon, 2025-09-08 at 12:40 +0800, Leon Hwang wrote:
> > > > When enable CONFIG_PREEMPT_RT, the kernel will panic when run timer
> > > > selftests by './test_progs -t timer':
> >
> > Related discussions:
>
> [1]
> > - https://lore.kernel.org/bpf/b634rejnvxqu6knjqlijosxrcnxbbpagt4de4pl6e=
nv6dwldz2@hoofqufparh5/T/
> > - https://lore.kernel.org/bpf/lhmdi6npaxqeuaumjhmq24ckpul7ufopwzxjbsezh=
epguqkxag@wolz4r2fazu2/T/
>
> [...]
>
> > > The error is reported because of the kmalloc call in the __bpf_async_=
init, right?
> > > Instead of disabling timers for PREEMPT_RT, would it be possible to
> > > switch implementation to use kernel/bpf/memalloc.c:bpf_mem_alloc() in=
stead?
>
> Just in case - actually there was a patch that does this:
>
> [2] https://lore.kernel.org/bpf/20250905061919.439648-1-yepeilin@google.c=
om/

Though switch to bpf_mem_alloc() kinda fixes it,
it's too late for this release and it's not a complete fix for RT,
so I think it's better to disable it in the verifier like this patch does.

Leon, pls respin targeting bpf tree.
Also trim the commit log. It's too verbose and not quite correct.
"kernel will panic"
That's true only if you have panic-on-warn set.
Just say that the kernel will warn.

pw-bot: cr

