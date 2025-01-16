Return-Path: <bpf+bounces-49115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1173A143B2
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 22:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980AA165E3F
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AAD2419E2;
	Thu, 16 Jan 2025 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYI2sJi3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9761D6193;
	Thu, 16 Jan 2025 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061241; cv=none; b=YTZ1vbZb8PoDoBen+01qK1zIcw6mdta/589q7m4x7K9hJ35OlRnJp3wmVh6Z0rzYaNjcb02tkdvx1yRFDKKrBBMkLpxWlDpy7pWPt9W7hEl1KwlM02z+rfcvzVrJeXUJcUEgiILZeNvKh9eKFjxVH9lhKADKtSiLc+QHWwkaw4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061241; c=relaxed/simple;
	bh=1eAfv9L2hLpECuyxU1bvy0uE+A45ie3+m2g+8+4qe2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Skz1PnbG3Jok7Fs0ALPV7wC/MYlG6zME/adYUmEjfIfyEAUtUZi7TNatZOOURtYgtCfm32rJ7Tk91Vt78R/2tCvB7NwvV+IkpTmcM/Vq2NGzoUsTYqhlPupA7SGn9zEZB/F8A/zsnx49XdjLcRZkaycVFjHO9IfscpPjwl2ncaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYI2sJi3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso1142063f8f.1;
        Thu, 16 Jan 2025 13:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737061238; x=1737666038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEZwMwnpyuZGrAHo3lxspJHdMpLV0CSXGZ6be/MsXRE=;
        b=VYI2sJi3Q20sm0iB/eTkTmGqZEhMx8jbL0vPQjsPOBs69O2RQipVlMUicTxBmTmUtp
         b4VE9lfAnHsnFlCmmyiXFPbjmn1MS+Op0QXFg0EtqalO9fP8SoUYJYWbwVsyk+H8Hfgb
         kSaBwfNPkSSLAlP22KCaPOFaSLtfYkpYGlL02jeoi+0FtBDaNPoAt0XbnhpvvtGLaP1k
         sM8d7r/hLEQnvHydMv7RpCBc5TRFxBg9gq85iINCX49hjegcWCYz14LXm7tR2/3nGWFR
         +ls2mDwwHvAYVgmp0rcgjY0KeQrcGr1eLPnscaQG3eD8E8BGX8O8Oj5ov30W+/acr6TC
         Ck3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737061238; x=1737666038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEZwMwnpyuZGrAHo3lxspJHdMpLV0CSXGZ6be/MsXRE=;
        b=HCV3NQf1/HLQ92AbM+1Bj7217Kn7rjQ76lZshhpG7lLvVxRq0R45v/IfUlgBKGK22u
         eU07l8MVpkXyCFawjSp2cUf9VY2U/5fxE6fyLC/b0gQWIUR4VHFPJoi6Ge2/JN0dBxVh
         oQtN9bgnjXQTORSNanUTw2QEag+xH1q3t/aoeAMSEdcCbKwuOoPa/DGw7fZ8N73GkLlA
         lP/yw3OJUv9rjB+1Tn23vIxfIixDrfJv5v6Mq299NFpuZ897ubifun4s3PhHBnIQAzTh
         BNwjbnNq4yO/EXxakp2eZ4z86RD9MSld8JKumrHuAXFcQ/RtZq/2lmaBvMSPvAu4H4Yr
         Tazw==
X-Forwarded-Encrypted: i=1; AJvYcCVVR9Oi/EbCDUiaHOGZcP4bFQEZKKHKPuOOe0c3gs/3qYovSmqnpDqKp8TUfveca0c8HIm2wThUu/P64W7l@vger.kernel.org, AJvYcCXbdWFoyqPhwubs3LZszwJOzHNjhQXtDwbyTIO7ATJS2y5s8pzD6HZ/OB2HqDHMsB6AypI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXcOkH0HrWJQqyIQk6Xj2wv8Yk7hgzF8xdaFPrZDEHaYsXmv6y
	862NxVfFIQkDq5CxZppY5k1dzpMs6ZH7kw5oGD0AswCYBG/GppcXQHPAD6UklqeO+CpvRVmrOUe
	Ii5t5HF5vsaXlP15IBklAC1hdRN8=
X-Gm-Gg: ASbGncvx3d78gLlxOPiETOtoLr00DDyTKc2wkNAZpIYOsUbrgrhNcv/SUlPiFnKvWKr
	ZO2GwFQOCAQXqj6jVsQQfdv5RVslNMlK9X+ixdiT69Uy9hL6iAQbsoA==
X-Google-Smtp-Source: AGHT+IEIrQUFeI3uqJFvcX3/pS7zSvrNkCdyN4hjnvZefCrP5/ye6g2r0QxZ5gEYdj+XUTiYV/0n+FFWftH41Le9Uc8=
X-Received: by 2002:a05:6000:1788:b0:382:3c7b:9ae with SMTP id
 ffacd0b85a97d-38bf56633damr101946f8f.16.1737061237719; Thu, 16 Jan 2025
 13:00:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop> <20250116202112.3783327-13-paulmck@kernel.org>
In-Reply-To: <20250116202112.3783327-13-paulmck@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 16 Jan 2025 13:00:24 -0800
X-Gm-Features: AbW1kvZVIf5fTe6o8gv7XTK1cZ3uCY5UFJ3WJctyZVyqkGagF84pg1f4Wa3ngO0
Message-ID: <CAADnVQ+fz7DQ9O=4F-4NNo1J7=dkiDAfYa+Fc5WXBK0yH0f=TQ@mail.gmail.com>
Subject: Re: [PATCH rcu 13/17] srcu: Add SRCU-fast readers
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 12:21=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> +/*
> + * Counts the new reader in the appropriate per-CPU element of the
> + * srcu_struct.  Returns a pointer that must be passed to the matching
> + * srcu_read_unlock_fast().
> + *
> + * Note that this_cpu_inc() is an RCU read-side critical section either
> + * because it disables interrupts, because it is a single instruction,
> + * or because it is a read-modify-write atomic operation, depending on
> + * the whims of the architecture.
> + */
> +static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct src=
u_struct *ssp)
> +{
> +       struct srcu_ctr __percpu *scp =3D READ_ONCE(ssp->srcu_ctrp);
> +
> +       RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_r=
ead_lock_fast().");
> +       this_cpu_inc(scp->srcu_locks.counter); /* Y */
> +       barrier(); /* Avoid leaking the critical section. */
> +       return scp;
> +}

This doesn't look fast.
If I'm reading this correctly,
even with debugs off RCU_LOCKDEP_WARN() will still call
rcu_is_watching() and this doesn't look cheap or fast.

