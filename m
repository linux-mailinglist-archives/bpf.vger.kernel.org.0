Return-Path: <bpf+bounces-56524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1721CA996EB
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1B51B867F2
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644F428BAA8;
	Wed, 23 Apr 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfHgI4V7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB991E2606;
	Wed, 23 Apr 2025 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430262; cv=none; b=K+80Gz0/TqppfZv079wvCeQrNNbe7+NxAtXLfOZ5mYyRBr6AfJAi0FVzqr1ZuH5dcOqHKBtMzHz9FKQ45cRQtbslhTsRUPHNUtBF0QTFBFFf7T4kf+C2QArzNysFidZJiHnf5mAC8V1mMPJ0V+erQx6E/2t4gzGMjanUaMYPC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430262; c=relaxed/simple;
	bh=iBqZrtUF65GxCBEB/tBmx3CX5f4LbQNLDGq7Zc9HeEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmZhMCf8+00dMA5b32UOa6kQ7cGwa5IbpcmC9PAowEK+ZeZy2jpillf8E3jZFNJqLcAZqF6CJUhq4JYkdXgzz6Om3kIM3BucwNlxnpXspbLWvT4FbN+FI5vTE8s/DqXwiwXhx5y9W3czJf6toCgqMq7x/JUDywPeMqwPgp2usL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfHgI4V7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso25083066b.3;
        Wed, 23 Apr 2025 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745430258; x=1746035058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=te3m5kvvTYT3R1fNk+O6lgZtuB7zTSSbqk9CYuqTNH8=;
        b=cfHgI4V7ZSGFMJZ7HNnYeBZ/5csFizhDDhBtHtL5P/Ndq+moEIvKWuhT16RDsrKnyq
         eiB5Mlp1At/m01PBlspW2Xh6/UUeJ+BgLENnSOoXplXmSHmUMhNFaG4zGiXwFnBi61/r
         JkQgCbVF1IftUFTPdNFDGLCvKKqTtaXK4UO3EDIOcHAE8QSSMC/v17nX2/JBbiM1y64s
         3QK8mVh5ZdW9MZuAcnwAPLEklKtgSXHbfajk2xvT+myaWW3/qJ+feYgvXmJYiFaowpRh
         U9k2CjIB1vgrZGUN+silYVY0bfKx5yUNPu6Lq6XGzsyOdPOHI6iTvMkPcF7IftdtXuRB
         sKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430258; x=1746035058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te3m5kvvTYT3R1fNk+O6lgZtuB7zTSSbqk9CYuqTNH8=;
        b=BhaEshduEOjg4i+nf1WhsKOcHSh2dwdTQilOk9E6LDzdHCjagNjOOJzm7JXHsbtAHt
         ZR8ZhI9dYtoKC7psRWrC0iCUD7cOoTehIhdvM+5vQH/BpVPuScXo+XsdzNgGUgNNjaYX
         SZchMpidwhRFfmh+dyXIe/g2gNF/nYzXKNr8qTeCUN4PyMNtyHPFeqPzfBZrLQIiWjDR
         x2JqauFIGGk6lxuAr/FFmjjejk8ndoswHkZ3gF1ECj+TzuiwjHySktacy2WS5dK/8FRc
         Zsx2WEkg0hIdXah0zDunaHSo5S82hTWdrQY7G04tv3wblMg6AafZGxicbt40abZwDp5b
         6ZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIgbuzeIDDmIIfQ79LrfRxbVvOt71jF6fVHD7wvIUToJ54vWmAyrGg0j2wjrJSJNua/ec=@vger.kernel.org, AJvYcCUMMSL8CXARVsNMYLAF4RBNUAjYTXR4YZiL7LmMY+3o/fy52i6hBETkmO7dWS/9BDC8CFhwh+6BE1D/x7+f@vger.kernel.org, AJvYcCWo4Z2F7qkupa/l++1tnPABioLsuImnEFXm1PcI/+cSyh63S6pHaf3fWqXZ/peIoXImDoBVrROuCoqLyOo9YO42m/0R@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjz+OhSZfatdHVJcBJ+kSav4X1hAlr4tYywo5t25vuRm44g4I1
	eI1ACVo3G3lhL032sAxpetJL5Wpcjn5uGEjL1xiVy3zZYY0JnC1XdATL8yzK0zhg8uHP2a1rQ7F
	WwHQWfFDaYUr2y09uhC/Ti+Fco4w=
X-Gm-Gg: ASbGnct8D5of2pJ0+ZAv/50kM1/9Cwa8NwKntqY50XkbQ9TLD+8QuYB4l+X8dnbPMPb
	JqAvdQfCyImTUgyve8yshX+KXzpVV26pLGIi8FMNt8JxEw7IfrnX+QYRPIENTh8P3aA83kK54B9
	1rvb3XSjKl9fTp5cypYlDAG7LVNRbnfNexk9hIvg==
X-Google-Smtp-Source: AGHT+IGB3SPDItC+6gD8fM3F/cH/O6vPqeY7c3S0HbRaRKqc54QechD95yEyJzGqD+f31CetLXp7OciSn4jm15CqXxY=
X-Received: by 2002:a17:907:60ce:b0:ac7:cfcc:690d with SMTP id
 a640c23a62f3a-ace5525c6fbmr340366b.40.1745430258398; Wed, 23 Apr 2025
 10:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-18-jolsa@kernel.org>
In-Reply-To: <20250421214423.393661-18-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 10:44:04 -0700
X-Gm-Features: ATxdqUG9D5LkDuQUuyKNSLt3iaC9fuF-CZvsCMSmG0lYrDX9BeFFGTJZy-lWPIY
Message-ID: <CAEf4BzYH3EBxswa_6SC7uWDmwSR6RMAZNbuKVqbfzaf3CCorxA@mail.gmail.com>
Subject: Re: [PATCH perf/core 17/22] selftests/bpf: Add optimized usdt variant
 for basic usdt test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 2:47=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding optimized usdt variant for basic usdt test to check that
> usdt arguments are properly passed in optimized code path.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 38 ++++++++++++-------
>  1 file changed, 25 insertions(+), 13 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index 495d66414b57..3a5b5230bfa0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -40,12 +40,19 @@ static void __always_inline trigger_func(int x) {
>         }
>  }
>

[...]

