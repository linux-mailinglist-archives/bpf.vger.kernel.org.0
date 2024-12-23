Return-Path: <bpf+bounces-47539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 750BF9FA9A4
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 04:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D099162F14
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 03:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA049155316;
	Mon, 23 Dec 2024 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGSdXo3T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B61B59A;
	Mon, 23 Dec 2024 03:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734923209; cv=none; b=tJMGI+rYd7mG0RJ4dBqlWLTB9XU35bnKF6Hv30WUMOHtnbRmYrQaQtuErfyJKk6NRX1hlztQjufx9smVJCjXOoUwPH9+KAwFuYpWH0oAAO8ib2NXQpu+PN3b7PhnTu3E6KsJWe8JRx39Po59aDM3pTYyFLECFzRYOYjJjATN9Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734923209; c=relaxed/simple;
	bh=/5cOQIV5EO+wRwZFloIhQyJWz25gsXLcTMOzxnXDMnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcE1CBo/tZvTg7cufZyYjBYBI0nt4fFG80nICDh0KpZEetBQiMVGNuoqOnVo1p5Lz5TyaEbVAe49FjOAFO1WNi3Jc9Ou4D3J7ojXKQ/uZ6Wz0PtxD1UNiTOVwUXxLKyBxIYJ0WS21SQu4Som9ztOwxe2i+OQaDTlQ5QvvwuxbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGSdXo3T; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6efe5c1dea4so27862237b3.3;
        Sun, 22 Dec 2024 19:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734923207; x=1735528007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDLS+F1yQuD2upk7EmeHo5UCz999emMAB0fBft9hjxg=;
        b=MGSdXo3TuDZz3VZdXydrYadXmoP8I5NmqnXWNcr7MWm5/W0DmWFoTa9i0uu/jecEnz
         jNV7XnYLbhlFzm01VZlv90lcylLuiHsz6ueI8ETaSjMSJbcpUB/oeNKXTdJwAQ/jmqbv
         wt3KtP5OBxEA54cfPI7XZrrMVkT7kQV+AvmvRUIqpvy3FH1QdOgymV6ijPs36fRY5l1N
         J9D5IHlk6P/YTyOa9brKkTzHoFxEFxsYlJ/ouJl7g1i98ppCl+JYA9R+LIIFqjzwDf+O
         HoweciBrEXNvqBD5Ugizk12TBGIvrkRHCtHrvEkZjbXYNnU1Io2ozE5uynHu+wIRtDUo
         20Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734923207; x=1735528007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDLS+F1yQuD2upk7EmeHo5UCz999emMAB0fBft9hjxg=;
        b=ootoZWu5dROmvApmoiUaxhWYfdKHRT4Xcok70gNMbKaQx2OhV/soBiSyMG5ss1FNrc
         7oMrI080S8s+yE76Ql8zsP8aAL6Jor9OYVMI7W3isCNQubcEsdyCc3y8JR9nG27P+tD1
         mRwvSlCQsCqqQyxqoqwRelJM5Ft5wjzwxKoxRiMJT6tUaAp5VewvXh0K/u7L+cBy47J/
         +wJICfwAsOFKHQZ8pLjyAWELXYfIwF2RMyUulhkgh2VmdTfKpy2b6rf9rgCbg7vXPCeR
         oEldXXFT8dfL88H7rsIUfM4kWlbai+zO1XaNwL5ADyR7M1qGUaHFIbMfC0sXQXoNajtX
         3CpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFKbAiA5hEKqAxS36S1oTpSO37gywUgXKTmC40V21Sgmd52dL8me6RGebE6jO915WudqwLIuQAypyrIZcJ@vger.kernel.org, AJvYcCVeGufW4z4CADHHTyTGv0/WyHZEYUA5k98w0cPEw5AHp9JOuWc6V/1z/rVA1dCCMHHYLBzW7cXOcFa7CjFyDayBXA==@vger.kernel.org, AJvYcCVnRok4EeQd84DQ652GcHtKk7KHJ1e69dAhGSXzyHrc/MTGZ965iZ3nfM2IYdcjKbfvCHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6FxcYdN+ObJPSv2psErKLh9t3f5OTiGwjhjW102usHLSPGTyA
	uQtfLEVbtPpbNkL6mwUmtGSy6/njS3IEPZT6kRzV0IIDSE3t6gdUV7pF4sUNyJBz7zpWawVtSYT
	osreb5mL+a5U7T7v7qrOMlzztUME=
X-Gm-Gg: ASbGncutXSALH7KXgybvzXDN1GwU6E1CaFcsEj90mD9Nkm8wPQum4etDvCHzI3sjBXV
	idF6eF5l5iFkcBeLDz59A+VqEo+3PnJQHukME
X-Google-Smtp-Source: AGHT+IFyHmlBFyKSpebsq2R1VBIC7wC1QEihc9xcEcoIDXS+5NhDWO0utAKyr0yDMx3ndLs5JtCDSE6d6LCG2StTXsI=
X-Received: by 2002:a05:690c:6911:b0:6ef:96f9:2f48 with SMTP id
 00721157ae682-6f3f823eb81mr90934647b3.37.1734923206592; Sun, 22 Dec 2024
 19:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219183400.350308-1-namhyung@kernel.org>
In-Reply-To: <20241219183400.350308-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Sun, 22 Dec 2024 19:06:35 -0800
Message-ID: <CAH0uvohROTgAN2ugPmSTLzEp-09LcZimCAsB4UbyCYpnwQhOEA@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: Add --syscall-sample option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Thu, Dec 19, 2024 at 10:34=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> This option is to implement the event sampling for system calls in BPF.
> When it's used, it picks up a syscall in the given sampling period and
> discard others.  The period is in msec as it shows the time in msec.
>
>   # perf trace -C 0 --syscall-sample 100 sleep 1
>            ? (         ): fleetspeakd/1828559  ... [continued]: futex()) =
                                           =3D -1 ETIMEDOUT (Connection tim=
ed out)
>        0.050 (100.247 ms): gnome-shell/572531 recvmsg(fd: 10<socket:[3355=
761]>, msg: 0x7ffef8b39d20)                =3D 40
>      100.357 (100.149 ms): pipewire-pulse/572245 read(fd: 5<anon_inode:[e=
ventfd]>, buf: 0x7ffc0b9dc8f0, count: 8)      =3D 8
>      200.553 (100.268 ms): NetworkManager/3424 epoll_wait(epfd: 19<anon_i=
node:[eventpoll]>, events: 0x5607b85bb880, maxevents: 6) =3D 0
>      300.876 (         ): mon/4932 poll(ufds: 0x7fa392784df0, nfds: 1, ti=
meout_msecs: 100)            ...
>      400.901 ( 0.025 ms): TaskCon~ller #/620145 futex(uaddr: 0x7f3fc596fa=
00, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
>      300.876 (100.123 ms): mon/4932  ... [continued]: poll())            =
                                 =3D 0 (Timeout)
>      500.901 ( 0.012 ms): evdefer/2/2335122 futex(uaddr: 0x5640baac5198, =
op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
>      602.701 ( 0.017 ms): Compositor/1992200 futex(uaddr: 0x7f1a51dfdd40,=
 op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
>      705.589 ( 0.017 ms): JS Watchdog/947933 futex(uaddr: 0x7f4cac1d4240,=
 op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
>      812.667 ( 0.027 ms): fix/1985151 futex(uaddr: 0xc0008f7148, op: WAKE=
|PRIVATE_FLAG, val: 1)             =3D 1
>      912.807 ( 0.017 ms): Xorg/572315 setitimer(value: 0x7ffc375d6ba0)   =
                                   =3D 0
>
> The timestamp is kept in a per-cpu array and the allowed task is saved
> in a BPF hash map.  For non-BPF use cases, it won't work so an error
> message would be displayed.
>
>   # perf trace --syscall-sample 100 sleep 1
>   ERROR: --syscall-sample works only for BPF
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2 changes)
> * rename to --syscall-sample and update the description
> * print error when BPF is not available  (Arnaldo)
> * rename to sample_period_ns  (Ian)

Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

