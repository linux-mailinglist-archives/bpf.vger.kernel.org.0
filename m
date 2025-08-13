Return-Path: <bpf+bounces-65563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CB3B255F3
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 23:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A5D77A7C09
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 21:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6EF2D061E;
	Wed, 13 Aug 2025 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIe81U+a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3424F271A71
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121921; cv=none; b=T1P+h41PVwbUghnQsznQZUv946dKKFNhkt031nbLQyshm1BVE3NpByC1gEY/idUsXzvLU8J4plBqH/d8b0W2A0Fiv2LHblkWSvWqVO2tLdrpMQ6Y+jZ/tj3FhJtReS8rfMTpKueBy0K2UnahRHV5OkhKI+k+QB6/1G+9ItqJPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121921; c=relaxed/simple;
	bh=KXR1Zjh+nWwdCxU8qtIiqIzvtO0XGyRu8ZGINeQHTT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZptLqpWQIr6ydLKcczCYW7ldEP/p597coWb74xqo3V2jwmmcjXpmg5j4Sc1M+AM+ElLwn0ihfAR4iboqIsqM8bx02ST9DvkcMgDDR/eNtAZbeWCVUoNLDRYErPM5DzA1c0/pUZgfEFCUhkeSUzG1cO67XxrGhVOgv7fFLns+ZpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIe81U+a; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-323267b7dfcso362823a91.1
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 14:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755121918; x=1755726718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXR1Zjh+nWwdCxU8qtIiqIzvtO0XGyRu8ZGINeQHTT4=;
        b=kIe81U+aUJ7VHdN2DrcCeAYL05kuoq2YFC9YGyJiejKETsKWDmklYiwt4mzUooVXXa
         QYkxOBetnVa4ZbGlRM1mbZAOaY8ELGkjKUAHZEZEH/xMafvP9Eq86ubW9GRtXG22ov2f
         cTE9egCW5+Ruis2w6HU4SNwIxW+GUGNoakVxr8G/Z4ZldBIGMXc9v6UzIkB5X/OErJjd
         dKfXD9XuJQhrgmxHG1368Pq2MWKRwCRIxJtKO5NyRfGtMt6gzFuhfU/xxJt7VOad7UWu
         UvaG6X+HWkAJh1A7Rg7GFY44SYv3kh3ZOjZgch5XGKeskL0/bJy96LeHHd1fjWj3KCwv
         y5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121918; x=1755726718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXR1Zjh+nWwdCxU8qtIiqIzvtO0XGyRu8ZGINeQHTT4=;
        b=NdyGc6ctOua5fNHf5nxeLT+dIJrXRgu2A+6WwbiYtuzTSGg+haVvh1JLrBpodzI3aE
         FGKsV7MBUd2QjumKb/SjpcA2rqsmf4E9+k+jRed8yxXyHlIRCycz/j2Tc4zGpC2svpLT
         xpOS2PoJ7FSHLIjQCXakCZjIclHOIsT/5tjhG753LR0z2A/xVyMRdr8pGy8x1svU2eKI
         crRRq2quHZX9wvaZEDszxyMwaWxXWhZhSSp49FmvVCLfMmf+qUFpbj69sJn399nLidmW
         2mtCl5kCUTRUJ4M9fCoFO5GPXsEINWYG4J1uOmzzeKZWt14aHjrT+M8R7L7s8pb9nvVJ
         zZVA==
X-Forwarded-Encrypted: i=1; AJvYcCXw1aCS0Veb+njBzwq6RkP4rzzACHVV6ZdRmer70n6HRtPBMYTdlsFRUNkpyY0B/SYoF0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuWWlAhyeu9RQVb8hrQ2cRjUhVqvitspZ7dpy0e9uzj6JbhdJ4
	rptWUlzOwp7Cw9Vmqun57Pe6zH3xupmjnvTWt2XA7PJAbhCK0R39V1whrBeIE9kwaZ0fpziQEzK
	R5LS+PtnHAj7uu5sAMm59VUmVbyWj39c=
X-Gm-Gg: ASbGncuZNBEeNZOz1eykLnpF09Qw/CuSMUTqFFvUj23D9BH99iZ8r9+utiFKHuHBuxW
	J+mDG5qMyCF0VCrA49gXxQonsvA7BMskMubY4NmNcB0Jn1pTy8qbv5u+v4B/LOHocwrD4zReYNn
	mtiivB9SQ1Jkthmf0YES8jdzIebattw3nds7BO669LUWAJxBSds0Q2pYDK03C1/r2cfWGLyJjqP
	RUEHiz8LVPDDgEg2tBUrwWz2JKnP7muLw==
X-Google-Smtp-Source: AGHT+IFVvbneY2BLhmqLRr93sCw9Z6YjVSsjT4OKY5wccUi9poeCdL0Uez8i4v5zxhq3i32rhnWUG2eW5b2ELPNJwDo=
X-Received: by 2002:a17:90a:d00c:b0:312:e731:5a6b with SMTP id
 98e67ed59e1d1-32327aa73f7mr1104107a91.32.1755121918339; Wed, 13 Aug 2025
 14:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811212026.310901-1-mykyta.yatsenko5@gmail.com> <c3d641238a669ed2426abdbfa0d7a0f568f7a0fe.camel@gmail.com>
In-Reply-To: <c3d641238a669ed2426abdbfa0d7a0f568f7a0fe.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Aug 2025 14:51:43 -0700
X-Gm-Features: Ac12FXx5x_m5J516FH_cF3rAhb--ki3lJfX9-o7k7ZDvg6dBvzFLBnIwITPwcOQ
Message-ID: <CAEf4BzYVhhX3N0uCB+kOm+yeP_j7bC-mfoDbSdAB5WDq1_=W+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add BPF program dump in veristat
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 2:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-08-11 at 22:20 +0100, Mykyta Yatsenko wrote:
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > This patch adds support for dumping BPF program instructions directly
> > from veristat.
> > While it is already possible to inspect BPF program dump using bpftool,
> > it requires multiple commands. During active development, it's common
> > for developers to use veristat for testing verification. Integrating
> > instruction dumping into veristat reduces the need to switch tools and
> > simplifies the workflow.
> > By making this information more readily accessible, this change aims
> > to streamline the BPF development cycle and improve usability for
> > developers.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
>
> I have a feature request for this:
> generate local labels for branch and call targets.
> E.g. as in the tools/testing/selftests/bpf/jit_disasm_helpers.c.
> Or as in llvm-objdump -d --symbolize-operands.

should we teach bpftool that?

>
> That aside, it looks like the code is very similar to bpftool's
> xlated_dumper.c. Is there a way to share the code?
> There would be now three places where xlated program is printed:
> - bpftool
> - veristat
> - selftests (this one does not handle ksyms, but it would be nice if it c=
ould)

I was going to ask the question if veristat should just delegate all
this functionality to bpftool using popen() (it's very likely you'll
have bpftool installed if you have veristat), but I guess if we can
share more code between bpftool and veristat, it's fine as well. As it
stands right now, it does seem like a lot of duplication and we'll
just have to maintain two copies of the same logic, which isn't great.

> Should we add something like this to libbpf itself?

I'd rather not, doesn't seem like it's that essential to be part of libbpf.=
..

[...]

