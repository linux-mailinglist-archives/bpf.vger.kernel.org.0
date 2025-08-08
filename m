Return-Path: <bpf+bounces-65264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0864FB1EA42
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 16:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB5D3B4B85
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A9827EFFD;
	Fri,  8 Aug 2025 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="PZj0p3P5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FFA246BCD
	for <bpf@vger.kernel.org>; Fri,  8 Aug 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662888; cv=none; b=dHHhH0YCq60bo5IfIbctaRdqGX8PP/birnJnWZ9MHpY0RKJLlNoNih2PsJKDPSH/0vzbYRd2u8I8oBC/bSb91xuD6htozHtMwGG9o2bNCRBZTE8+tQ6MmuJsgm8kgyl2LpO3jagfnp8duRi+rpIb5upEVmZJHZcOgQdoFhzW5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662888; c=relaxed/simple;
	bh=guHzSvaBeM/USIv5SatPspIVxLVMpHFVg5Q5uwqdIbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjEm2wqEJUQpfH4kHubgl5xP2MMMLHwmykGFBWRWwOFQQcnQZxsJoER/MqJuDbEEgb1ikk2r+s0Ellp1gmqU4kuPHEVv6iufE7fCe02wWb4dZg3YVkSXc61i65LrD/YjzmxebPjrV+Mp8CNGvQVuH6v1vcqgwrEVE23zhjDk2UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=PZj0p3P5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23ffdea3575so15041925ad.2
        for <bpf@vger.kernel.org>; Fri, 08 Aug 2025 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1754662886; x=1755267686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guHzSvaBeM/USIv5SatPspIVxLVMpHFVg5Q5uwqdIbc=;
        b=PZj0p3P5CBkpC1ECOz705VGFb8J6RNwNlXIudjLxUC7dW8mRAUK741EnSstTlbl79W
         j2NuDXxtVb8wAAe+GsljSTGc4JNhg6tPJeXLJCSena9bj7oR0yHhOE6HjwvNCLwXxlGt
         XNxUUza85f4MQBE+tnGrqiY1/yolvyryy19/SZLwUaO6ouNfZTRp060znR6ZEqaW3oCz
         SdYFPb2g3pG1LyChwiQH+E1pEv1MEOtlzlub24n7r6YCH7Eav0NRMK9iWCX3BgiD/Yrt
         SrOA6FqtAqE2j4dI06vYGeY4frLBiBLjCUC3VEzzMuRUUBQ8TjKxRud0ctjHkrH7aqWK
         /XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754662886; x=1755267686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guHzSvaBeM/USIv5SatPspIVxLVMpHFVg5Q5uwqdIbc=;
        b=TKm+Tufq9ADn5jDcvHXYpYlOkteZYZul4eMqBna877afoUWiXpcblhA/yVPC8a+5nL
         6tIGkhvcpgHgdvucfUVktDJk9TU36JP0u4ZlQ4qiPCkPeLNit4+pViPf2fRe7yW4Bgus
         49J8T+32AHgGyBgwYxP6s0YpD7otyik1eyCXJTzumoPGXmm4XSodsdvJjW/viPL5BxF9
         7Br6HjPn3fwmeLz6t64/ufy/y2QOzyJ1bm56hoP+yxva2MB2zpqahsPtmc9hj//CeQVp
         wt16jH847knSptA3Pzzqxj88zdXrOUkDOhPcF48r6jndG4wMOoG5U318jdeVkLH+q8mm
         mTWw==
X-Forwarded-Encrypted: i=1; AJvYcCVQvUT8gayXMELvmlMcDsyODsYZpTZyGGpEioScVewliXOnn8QbEqhrJIR43MmYOZQx3yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziqyHn5hCVv27ErdSzAoHvQ/Zt0a9yZQ6TLK3vVEL+EbAUR2vA
	XRyGE5lte7z5R+x4hJ0ZCWqTbgVImWxGk0euOEp9uj/j2wbbDjpzVAQVrnpd8BOQUKbOKZI4Cy/
	PJrGmgJQNSE7qY/qIFMdkvh4T2MouAfLGwbcOud/zMQ==
X-Gm-Gg: ASbGnct6K31pMhrP7kUGLJ/AUQ1Hum99KO8NKcYxxaukudHmccKu7S4zvrpoabNWFrP
	HgojHf1dTV9P8/jZMXoay/J8E0bKqYqrodrukfr7FwLKUXQdcfppgSYUVbL7G60UKtffrjXrmyx
	UY6NxrNvy/w922LDvz9poah4fQzDbJmAJb7/5mZjKK+FHGXwOKHoikc55rqCzwvHUEz9EmyhJO1
	+cKTBe22PfF9MAXIJ6+Y8ooCL94fhbvMw==
X-Google-Smtp-Source: AGHT+IFmZBg5ZwAP49VEb5vbGDIowxD/ct5MdC1b9On5aGdv3/h76JvUwtRiU/cQG4Jpl3vV708BLdqG7GyflYMwLpo=
X-Received: by 2002:a17:902:fc8f:b0:242:b42b:1335 with SMTP id
 d9443c01a7336-242c2059ca6mr52927975ad.22.1754662886384; Fri, 08 Aug 2025
 07:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722150152.1158205-1-matt@readmodwrite.com>
 <CAADnVQ+rLJwKVbhd6LyGxDQwGUfg9EANcA5wOpA3C3pjaLdRQw@mail.gmail.com>
 <CAENh_SS2R3aQByV_=WRCO=ZHknk_+pV7RhXA4qx5OGMBN1SnOA@mail.gmail.com> <CAADnVQLnicTicjJhH8gUJK+mpngg5rVoJuQGMiypwtmyC01ZOw@mail.gmail.com>
In-Reply-To: <CAADnVQLnicTicjJhH8gUJK+mpngg5rVoJuQGMiypwtmyC01ZOw@mail.gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Fri, 8 Aug 2025 15:21:15 +0100
X-Gm-Features: Ac12FXx7v-SSukGf47arwGF9TbWihsALELCDJDlaUcJ6XfDaJwfnJlT_e7TVQHE
Message-ID: <CAENh_SRxK56Xr1=4MX4GhZuc0GF4z5+Q8VueTK0LDLj3wg_zXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add LPM trie microbenchmarks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 5:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> well, random-key update when the map is full is also quite different from
> random-key update when the map is empty.
>
> Instead doing an update from user space do timed ops:
> 1 start with empty map, update (aka insert) all keys sequentially
> 2 lookup all sequentially
> 3 delete all sequentially
> 4 update (aka insert) all sequentially
> 5 lookup random
> 6 update random
> 7 delete all random
>
> The elapsed time for 1 and 4 should be exactly the same.
> While all others might have differences,
> but all can be compared to each other and reasoned about.

Having both sequential and random access for the benchmarks is fine,
but as far as I can tell the scheme you propose is not how the bpf
bench framework is implemented.

Plus, handing off a map between subtests is brittle and prone to
error. What if I just want to investigate the sequential access update
time? The cost of the most expensive op (probably delete) is going to
dwarf all over timings making it difficult to separate them and this
scheme is going to be susceptible to noise if I can't crank up the
number of iterations without altering the number of entries in the
map. Microbenchmarks mitigate noise/run-to-run variance by doing a
single op over and over again.

I agree we need a better approach to timing deletes than what I
suggested but I don't think is it.

