Return-Path: <bpf+bounces-59878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32676AD06A4
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF757179FC0
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72603287500;
	Fri,  6 Jun 2025 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsHufE6j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5270823
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749227431; cv=none; b=T2ym99UWmI+IT2GMCe8sAJZMIzBpui2f7xGfosFgZjykFFtFcheLiwcQ8C0GLjyxZVSHs6kqTOT3KTW20j5EcC8x8WTI3PIS++rcT/a0ppAcL46jTyaX//AVaqGz5Ravh+tN71CxL/fgOZcbDl1lMQ/dWjFyXliEtFDTl+GAjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749227431; c=relaxed/simple;
	bh=oI/mCailHwwKQdMW2qOYYV5En0qxAv5XvjFB+QVnxbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHClRqhMSQE9mdvF0WDKdfGaoprusv1mYP9jskAS6fnq7yx+fAaqITU/Rh/Rdt6xX6TmxuFvsIyFJOf6uvsGt7NDCKFjyBvNh4vuD3Jaonhontt4CdKrx0S+w7ww8kA7EgwY2KnDcrVmH8YFX9SagCvPtfABPHupmznk66vzfTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsHufE6j; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b170c99aa49so1376542a12.1
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749227429; x=1749832229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDrkv4xBSDG8l5wSzhGuvwwphsjfAZm9QGyAPSCwIEc=;
        b=gsHufE6jhWAfAo+rGVYEt5vgek1C6GF3KApSvqYrFYM+EYKxolOjD9+Q6BiMmmPLFN
         7gNqLplutXuI1o7XrsTRdMGexBXCN1u8+FIt1HXSlRtOXczc9iTck+vZrG77XZ2hd4hQ
         FVyD1ZVGTZ+k7bC0ldtOpJKwGOCpjcCjL1pZglT4dMXI4rUaG92H0S9mHLH5wdfAI9Js
         bnpXdNeB3xOgpHv7pEJWzDzMX27X1jHxJabpahv105nq0V//36L1ChXBqao8W5QklA+4
         xgpsnZ3o7nFmRHMf9RWf67TgpZe5tPpJuU4QNzZrT7Qfhjum4huqsysp6zZTCQIDHEh7
         0LEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749227429; x=1749832229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDrkv4xBSDG8l5wSzhGuvwwphsjfAZm9QGyAPSCwIEc=;
        b=XHZrmWvHhH0VMonRWblYGQwAD5ZxbISamwOvEE/uOF6YeZvQgCYVpgkkPcqq7YGMBW
         byfhJVwmK0ButLx5Rt2m03gUffRZ91SBU8/SBNeKLQTm43WQ0KQ2x/6gF2dBYeW5dzU2
         yhy+wVW6Vga5yzxby1BXcozRPTWwsvrn/PC+KvQtuAa10tS+rOUmUO2R9+N971q87Qg9
         M64L7L7P9aYjlujLH57fxf7S790ObJEu5IL/sahJMDSOZAKS6j8Xfm6VbrFknwo9+7ys
         VgylG6Nk0MorMau7KU/YhumKbAWzZwTv+lmNdK5B47rNC17N3zOqQsNYhFG/vfMPgmO9
         cNVg==
X-Gm-Message-State: AOJu0YzD70YGlHkpTOhjdeFQ0EFRHKfVsTGkte1Q9x5bwnDSv/EImy3C
	bDUMnW1bDfARSUz+EXMivxXDIN5NVusarbRzF86EbGQRIwQq7rF2vb+BhdmFE244tFPEK2M3fqs
	nl0XwjykcYd2npvQz9qvbwee1R1vgpSYUfw==
X-Gm-Gg: ASbGncsGYooXJnB/ufemSPZP2fLMk2ro8qYcBW7uEmMPHyQnKpemgllrZRPMBtxuasQ
	GrkT4kaDgh4rxaJGwoMAz5HcLhSbK9ewkfiXCZcBOvUq96Z8hU5XlzQ2NOTfbifRuklzIh6OwVf
	/H9dr3exlvihaTNLKGtMV8zyK7rVOlYN8avf1wYtS/Sg==
X-Google-Smtp-Source: AGHT+IFF6D+yswqh6E8h5H5I6ovLpnpbFDQHNU41Vny7BYpxXLe8kHgJB3NqKxxeBjMv9wyMJvtEG4wk5bPZsn7EpMI=
X-Received: by 2002:a17:90b:1847:b0:311:eb85:96df with SMTP id
 98e67ed59e1d1-31346b56aedmr7494444a91.17.1749227428615; Fri, 06 Jun 2025
 09:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606032309.444401-1-yonghong.song@linux.dev>
In-Reply-To: <20250606032309.444401-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Jun 2025 09:30:16 -0700
X-Gm-Features: AX0GCFvC7O1uNzeJ1HObZE0dBUyGHq9ZD_pcw6Xlt5WWdO_m1mYkL7EA-sFO_Zg
Message-ID: <CAEf4Bzb+rPo6bfYe71vOzAsqQb4JM6Gu-Hi66qPj0ioF=PFF9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Fix a few test failures with
 arm64 64KB page
To: Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 8:23=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> My local arm64 host has 64KB page size and the VM to run test_progs
> also has 64KB page size. There are a few self tests assuming 4KB page
> and hence failed in my envorinment. Patch 1 tries to reduce long assert

typo: environment

> logs when tail failed. Patches 2-4 fixed three selftest failures.

How come our BPF CI doesn't catch this on aarch64?.. Ihor, any thoughts?

>
> Yonghong Song (4):
>   selftests/bpf: Reduce test_xdp_adjust_frags_tail_grow logs
>   selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB page size
>   selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 64KB
>     page size
>   selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size
>
>  .../selftests/bpf/prog_tests/bpf_mod_race.c    |  2 +-
>  .../testing/selftests/bpf/prog_tests/ringbuf.c |  5 +++--
>  .../selftests/bpf/prog_tests/user_ringbuf.c    |  6 ++++--
>  .../selftests/bpf/prog_tests/xdp_adjust_tail.c | 18 ++++++++++++------
>  .../selftests/bpf/progs/test_ringbuf_write.c   |  5 +++--
>  5 files changed, 23 insertions(+), 13 deletions(-)
>
> --
> 2.47.1
>

