Return-Path: <bpf+bounces-22808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEBC86A202
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501D8B2927E
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219F114F977;
	Tue, 27 Feb 2024 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1UxZhsV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038105B1E2;
	Tue, 27 Feb 2024 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071090; cv=none; b=F79plAVlQhX/B8xac+FodXmJI5pBwiEOQfj8TKU1caROYXlZGhSvEV6UXEU69FW1GnQNuIbvDE1wc/QwFQxiFECcjzun9rKC+LBfK+LqpXUBniUrMxfGsPlbevjuJhydD9dsINzTLNSN/c/00QnYscX6MYhuzq0BfE98hwrigBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071090; c=relaxed/simple;
	bh=qZHbzzuKfkdyK1Ir+hOj1hvrx+08TuV6H84bv5TzcNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pp/1Yt0KeZU1jr+4+40e1E2Flb1VYA56Xm2NTvV5ChsAE63zl3ZgMFIx4g740bIu8ZRDV2UPCgHmMSsjvKYzpEi9rkcF0lCI1idwMm6n+vEGWUIgkNXZ07oXP9vaioTc0Lg6/pwLrOyhyIKmeuVsHV76HIR+JLkX9elvhHaCilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1UxZhsV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4129e8bc6c8so27828015e9.2;
        Tue, 27 Feb 2024 13:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071087; x=1709675887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb5fd1YKI19CwE/2xsKe1ke/vgyXTopoQaaPB8EDAjc=;
        b=i1UxZhsV7MJQNVE2+1qqwR1k6h9ZUdKcxWavGOVuT72022B9GVU1p/u1kbReB+Yq0K
         vh0FvnOX6PBUZN3Aee3YWRYz5N0x1mQ7n6gmgDdx4qN0pOG3tNQfNomhXWaGSPBMNQu2
         U5zwQNDKZVIfTRxz6NmMqH7oaMPSQfz4A8rDTIFBGeYATQEWpSe5iy2sHegoxSOxrTo1
         GtprnoRGW3vUPpFLk+hDv44hnrfZpr2Nfyd13CkW6XqApTLtxsb5mwzjlcMbzwRE6ybO
         85Sev4Cp4eQ1JdehKfUZN/rtX/FKUxq20GiDDoUleDQtpvSs9CnvtHCYIs1NCqRSe6fV
         9VyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071087; x=1709675887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eb5fd1YKI19CwE/2xsKe1ke/vgyXTopoQaaPB8EDAjc=;
        b=jOvfNQee4ZEmIuNfe66wbgVTbkHFA8OE6AgN4NHWHut2D7dxI+pKEU8oRuYP6klBzD
         988Qn6iMmef4swJr56OpJG7GR1dhfDC3hcQ6xkRL2luYFQypB/gjH2p6LljSpqf5TJcN
         W+TvEGCRvxYg9ZMHVT9C64sI6Yfqa4Vi50S5dfPayj7nOyO807fzpT3PLDpZ+cQFTgqU
         zbNpD8IBNaY+UAwe8xzIho3MZCCm30fuF5DTw02eDyeK0sKAJDmzzWFNPz3c7hM9DFt9
         kO+KTczWNydjQ4MwfsxrpYI1TwQS49Y6WNqQ4J5zG4lCFoZFszgfqm7Jm/lyWhJYZAxF
         dNLw==
X-Forwarded-Encrypted: i=1; AJvYcCXAjUjA2NnsFUT44bqzNZ6vddjXGklnmfEI8d1GYULKXYkLOlaa5XpraiE87Kir978MryJ4O6t82TfJbL29wMAWD4rXXzYC7u+LvP5ncIA1QUyXiH8FrdhlMBCUNG/YXiPH
X-Gm-Message-State: AOJu0YyKN4aL8wTstniEP80YOxj37LjCnmpz0WFAju+YfIOb6/uo0+nC
	pvCduuI/Bj53rTWdea6pkHf27XAq7PFo7jN6NBWaKgM7/ZrFIJVkhB5dreYOJfKIvJDtBC3E6al
	EQokoC1AJTbY7xFZxtZ2Jvp6QLpI=
X-Google-Smtp-Source: AGHT+IHkCIrDM8z6qvHeOnYtDl40GEZ+l7G7uW3Nl3V7f3gsPjHPchxsEC0GTs7ghTyqxGJ0Rzd3LVxyVU5USFRjvPs=
X-Received: by 2002:a05:600c:4e86:b0:412:a21b:5bf8 with SMTP id
 f6-20020a05600c4e8600b00412a21b5bf8mr5286577wmq.3.1709071087093; Tue, 27 Feb
 2024 13:58:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125225.72796-1-puranjay12@gmail.com> <20240201125225.72796-2-puranjay12@gmail.com>
 <ZdegTX9x2ye-7xIt@arm.com> <CAADnVQLGGTshMiQAWwJ9UzrEVDR4Z8yk+ki9pUqKLgcH0DRAjA@mail.gmail.com>
 <Zd4jlPW2H7EvdlfM@arm.com> <Zd4lggegV2MeD3jP@arm.com>
In-Reply-To: <Zd4lggegV2MeD3jP@arm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Feb 2024 13:57:55 -0800
Message-ID: <CAADnVQKYZdAmh3V_259adfcMsRRGBrXR4k=yJ2heVMQ+AuQ8Xg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] arm64: stacktrace: Implement
 arch_bpf_stack_walk() for the BPF JIT
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Will Deacon <will@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:10=E2=80=AFAM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Tue, Feb 27, 2024 at 06:01:56PM +0000, Catalin Marinas wrote:
> > On Thu, Feb 22, 2024 at 06:04:35PM -0800, Alexei Starovoitov wrote:
> > > On Thu, Feb 22, 2024 at 11:28=E2=80=AFAM Catalin Marinas
> > > <catalin.marinas@arm.com> wrote:
> > > > On Thu, Feb 01, 2024 at 12:52:24PM +0000, Puranjay Mohan wrote:
> > > > > This will be used by bpf_throw() to unwind till the program marke=
d as
> > > > > exception boundary and run the callback with the stack of the mai=
n
> > > > > program.
> > > > >
> > > > > This is required for supporting BPF exceptions on ARM64.
> > > > >
> > > > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > > > ---
> > > > >  arch/arm64/kernel/stacktrace.c | 26 ++++++++++++++++++++++++++
> > > > >  1 file changed, 26 insertions(+)
> > [...]
> > > > I guess you want this to be merged via the bpf tree?
> > >
> > > We typically take bpf jit patches through bpf-next, since
> > > we do cross arch jits refactoring from time to time,
> > > but nothing like this is pending for this merge window,
> > > so if you want it to go through arm64 tree that's fine with us.
> >
> > I don't have any preference. I can add it on top of the other arm64
> > patches if there are no dependencies on it from your side.
>
> Actually, it depends on patches in bpf-next AFAICT (it doesn't apply
> cleanly on top of vanilla -rc3). So please take the patches through the
> bpf tree.

Ok. Took it into bpf-next.

Please take a look at these Puranjay's patchset:

https://patchwork.kernel.org/project/netdevbpf/cover/20240221145106.105995-=
1-puranjay12@gmail.com/

It's a pretty nice performance improvement.

