Return-Path: <bpf+bounces-39383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7B89725D5
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 01:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BA2285A77
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 23:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9918E375;
	Mon,  9 Sep 2024 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCzRQDs4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFB188CC1;
	Mon,  9 Sep 2024 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925549; cv=none; b=TEopuM2jNsSa3y3PGeefAPvIDCrs8mkhzCTTsUBjWf1B+29Oo19M5to16hkMuC9uYgfyJWyqXwqWoIBlq/GvRXNm8HXQKWNEe2mj44nJr954D3C4MeY553Oq9+lhA2ptdlgqHoz+sWcRVHp1ddXlOh5dFkTPGBQ4yxBSaU9FFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925549; c=relaxed/simple;
	bh=8TieTUj8yNunIisvHC6SVD0F4bHTLWsVzNt9QH1QCAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMV4RyAcBZb60Wjqi+bu+JOgJ45FCxGl42qhLL5Sc7E1ygC6rGMxRQuqjnIDgj33c1LsiSF2p1U/YUhYY86Yhzbm7CVIxryYetQvtsj6vTXjUr1AalrmJGeaqVc6qgwFf7zPB5KZUAODmqoElrWgmuo564oP4gpofUogxY+Ck9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCzRQDs4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d89229ac81so3864338a91.0;
        Mon, 09 Sep 2024 16:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725925547; x=1726530347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE8Ef1RHSANPFN8kyXXXo8buZmOBW6nLFJGcsBhANOo=;
        b=dCzRQDs4QLkBKt7mvcj+1LJ785Nq4Cpr201rqz0XmpPLAS/UknyKKCscT3aStTKWXA
         0WqCXtB6bDXN0T8McwFC1kggCelESxh52TnoNJ9mHiOJiFPjBXE9pg8G/g9B6Ec8ugS7
         6hNgGF3jpXKVsbHSlFFD40thdnlJfnTJzGZpxgE6MQKsqzl3eeOT8wUxRSnBrhZmuSv4
         3KSi1bdOyWnUa1zZkqqMPINgbdmpqwRAAtyhh2TZr9N91VU5pYhIZ+ndmLd2N7ZXUnEU
         2lRn3JtKTWDMQyqRDs59Agm2a4fbNCJ+ze83KIXQfZP4yENr5l+/4vGuaJ4opuZGdlxf
         4uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725925547; x=1726530347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE8Ef1RHSANPFN8kyXXXo8buZmOBW6nLFJGcsBhANOo=;
        b=A4TwESSR7DZmeWJtHEeV5wMsd14o1ieq8GNpCHuHECf0OsChkz9QIPaojzU4Vz+HQJ
         9j90EHqrZ7zC1Pctg4lrQZqWdFnF8pbuJc4RlNMj6Q5hc5gGHy4QvusMSB9354lx9kjm
         ey9ZUN55I91O5+7ufrBwdgXb7875uj8ruB6angYqSXWeWlhIKUaSV8rwbi9VznJ2fKT3
         jq4gb9kqIn9cjtwqh4eSwLCsMSNcpvdT3mz+HOXKhasq9YmMWYDm6D2V+S2jD66bspWn
         YgekG/SkvT92SQx1ohAnAjYj2hxMeesm9u69S3HJ/XkYEKC4KtlxC9QE8hBKXxoDCapk
         PGow==
X-Forwarded-Encrypted: i=1; AJvYcCUB2ljbGSWkbTeoYqbNvII+OO8K3IGwVc81rkKqzxSdAwqP0zwyjrrc/IDueroU4yRFKxfqrksI7diinCM+G7Fvwnsr@vger.kernel.org, AJvYcCVewO5SLv646lVuVCrsw5mdGSEUCIdy5vhHX0/pA2HlXFsABlsySAJz2mrFBbrUswSeRLMjy6PgwuZ1W4Fj@vger.kernel.org, AJvYcCVkd3Qn998Y3wqSnjCWIZg3WeDXHCmwej18ur9TEpyuDx29ApUcZVI0nsylIo9Rtjh1i6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbNmNLD1kBfVGjRnpdSs99UyuthdDOncyW8ME2d25Oi+1LORVO
	Mk8QbDjC+7vK1nwyy8l2WwrCmqSsdskhzlttYgM6vWwBDu8uciC321oyIEeZ8tr4PfYptYQIFAU
	uGr3n477lQyOQyxW9vDbKv9OQBVY=
X-Google-Smtp-Source: AGHT+IFy8iO6NDQxjo7C4DvOJI/qE2VJmOdAKa/i2Ne4MuTYnSDbTrb9fGcUeuLyxxPI4/8398KTmS0qT7aE8A1rpjY=
X-Received: by 2002:a17:90a:e150:b0:2d4:bf3:428e with SMTP id
 98e67ed59e1d1-2dad50f3f3cmr17124736a91.37.1725925547397; Mon, 09 Sep 2024
 16:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909074554.2339984-1-jolsa@kernel.org> <20240909074554.2339984-6-jolsa@kernel.org>
In-Reply-To: <20240909074554.2339984-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 16:45:35 -0700
Message-ID: <CAEf4BzZQA4Sy+7mWzCM1zeWCZh8PM3OQqoLAMPWd+4dA4D=KoA@mail.gmail.com>
Subject: Re: [PATCHv3 5/7] selftests/bpf: Add uprobe session test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 12:47=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding uprobe session test and testing that the entry program
> return value controls execution of the return probe program.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 47 ++++++++++++
>  .../bpf/progs/uprobe_multi_session.c          | 71 +++++++++++++++++++
>  2 files changed, 118 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_sessio=
n.c
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

(also note Stanislav's change of email, please don't cc his old email)

[...]

