Return-Path: <bpf+bounces-67327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3BCB428A4
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 20:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565203AAC8E
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 18:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C879D3629A5;
	Wed,  3 Sep 2025 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkKzpzwC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF67080D;
	Wed,  3 Sep 2025 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924021; cv=none; b=vGwDVn8PuMFzLoCG9GJNS70C+/m8P0Qq9qPXBZFq2Om0hesiqtvffmNDUV4EnzQufzV5qA4G/NW96LTLXaltWy3vkAjOOsamDn1eaHtI1uEEup0EL3uxZNc5vrtOwOwK3Ek8UrSq3zPckeRuivUvMKa0A6oM1kSw0culJ/2SLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924021; c=relaxed/simple;
	bh=RkCLVUm+VgOwpMKBClxS3j3qJZ5e/WWIbWbR5Bx5iFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoX3JJAIxOrp9ptk/EbKs+4I/jm6nu560O+4MyyyGTK6r7MwTxk4dRZNR+4gHMLdITxeNpJpRZ4f8mZFy4iks6T0ZCsjAwa0Z4deWLkL3N/7AuUjJPq47r7gKSxJP5sSdVXERL09WIqx93WJwr2WmZ+6t7yE181KNVZHWhSu1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkKzpzwC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77238a3101fso170100b3a.0;
        Wed, 03 Sep 2025 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756924019; x=1757528819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoqojG11OHkQISj5q0OcGSIF6PQ5yOqHBvHUpFUBBLM=;
        b=AkKzpzwCq3fOf4DqIHxPI1OyJwAkubkZ2T3dU0zTG/q1plm0JDNWm1nYBOndXEtK6Y
         6LwZuk+UtVnd0Jqkq2BG73jEOcainNzJRpOVo5xidrsiALFhXYsER1H/siobOa2sxxOx
         NYwydH6vnTfFq+zOLvMilt9mxz8DFySZxIYR0TGZFVN7llElY8Oyy6Er3ifmznztoRrE
         JzoDaHvcXv0LDCh6kZOj4XgaM4sXf6v6QoCbqfr27L2xN0WiWgmjD8UyfHNLHwzn8c9z
         3CVCXSRmnt0Yx0UgCZaP9vDOPpvY08dyG0VWguKBzS+T2zuk3cO1mBqstufGBhpiVPBI
         jdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756924019; x=1757528819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoqojG11OHkQISj5q0OcGSIF6PQ5yOqHBvHUpFUBBLM=;
        b=LuBGSZTQTq2j0Yh++cdXf5zKFaHmw+L3luuWpxU19oUnBKwGHWxZANnJNWb0VkFuJZ
         iG9LppUhKkcebMA1I67sQ3VNaOJfcFV+sSFmWLXTkqeuHSZmWESn7I0X+upVCpWr4fRz
         3EDzDRoAAh/qs9+LBpOAgzLbhgNE+5c4W4KgPXU5i2oYDHPpqXIF5zX9VI7qg87UQ/+r
         ZRnJ3xashZBuCtAMaEWZO+9fUQ6Im3JUfbYKLT0aQcppAJl+ASTDfZZb7gnWmZMrdA5y
         KYLWwDv/r5vPZpMpMl9TWHHT/SmGxu6Wl7hS3nQ3n9zgsuzDjmoMkb+bv6Hk3h2zpj1w
         DnFg==
X-Forwarded-Encrypted: i=1; AJvYcCUpNC+robxb0W8wGIKtE9t0c0IXiFU+zDCdCeyJ8OqjUEAeh4PK5b777kuhu6+3HfcCfaehAmzUYslfpW5fNzxAiX2E@vger.kernel.org, AJvYcCVZ0cI0U5oaKd1T/iN7/2QwEuLdvCHa1A08TpXdyigSu8rvDvcwYt3D/v1BIa97y8P1OsK/NtoztNeHGqeU@vger.kernel.org, AJvYcCXyD7Q8pn8Ki5bMntdWlTXxF5lRKZ5UBCJGfx8N5jEtS3nuNbLyW83Nj/kK+gGjU0aLTvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1+vhqdtBVKntUjXqGkeSA1cuFu4MzlGdIW4Fto8cnSCjPjjkI
	lF69U+bAUmv7Yg8ChnkglWDJ2gtNPGYh/ce5xEooSkOFVdn8I3mjQxW0AYA0NHdlDMrdf1o9Ww+
	KLFdiOKqMbgiGan7aUkQKKMfTQRcTUi4=
X-Gm-Gg: ASbGncsiB9L9uP/8C21zzYexkDo1IE124g9dqs3IPpnmOfwVPO1ns/g4XAEIXmKS+iM
	8vyv6nzO1V81G4Lg7SJ7mhNnp9nSlfIpR6wtDtrA3mEW1QS5/FCF2eK4JN1n1uvyJ9TmMkVy5lX
	Qs16mn7VJIDs2OpnqmVpdRLwEBzHDCdWePb3FrFinqLbwwOGxhXJkxj+WWIcL4jkBg77jzsEnwQ
	yhtKCgoOiSjkIA3068LhTY=
X-Google-Smtp-Source: AGHT+IFgN2FUXZavbPeV9BKbJ7/eI0glYRzG78d+xwWBDtnYXKTVD20iLZJVasGCDV1CXsMDO7Hapk0kbA3BbAaJOI8=
X-Received: by 2002:a17:903:234a:b0:248:cd0b:3426 with SMTP id
 d9443c01a7336-24944a460c6mr248501325ad.20.1756924019230; Wed, 03 Sep 2025
 11:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902143504.1224726-1-jolsa@kernel.org> <20250902143504.1224726-8-jolsa@kernel.org>
In-Reply-To: <20250902143504.1224726-8-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Sep 2025 11:26:47 -0700
X-Gm-Features: Ac12FXz1My-dnKSo13TXTJx2Lt0P_uhhsDDW7OL8yKRB2Q5QGJtg2HXASRzwTow
Message-ID: <CAEf4BzaT+fAMqFXDMFV1tiRSu0vTy3btcx1TS8FyawSe0TQ95g@mail.gmail.com>
Subject: Re: [PATCH perf/core 07/11] libbpf: Add support to attach generic
 unique uprobe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 7:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to attach unique generic uprobe by adding the 'unique'
> bool flag to struct bpf_uprobe_opts.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 29 ++++++++++++++++++++++++-----
>  tools/lib/bpf/libbpf.h |  4 +++-
>  2 files changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1f613a5f95b6..aac2bd4fb95e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11045,11 +11045,19 @@ static int determine_uprobe_retprobe_bit(void)
>         return parse_uint_from_file(file, "config:%d\n");
>  }
>
> +static int determine_uprobe_unique_bit(void)
> +{
> +       const char *file =3D "/sys/bus/event_source/devices/uprobe/format=
/unique";
> +
> +       return parse_uint_from_file(file, "config:%d\n");
> +}

perf event-based attachment is legacy and libbpf will automatically
try to use BPF_LINK_CREATE, so I don't think we need to add this at
all.

But I also feel like we don't really need any special thing for
"exclusive uprobe", because ultimately we just want to let uprobe
override user registers, which we can allow for normal uprobes, as I
mentioned in the other email.

[...]

