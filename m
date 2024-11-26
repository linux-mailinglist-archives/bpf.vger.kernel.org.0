Return-Path: <bpf+bounces-45639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22B79D9DD6
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18A4281F94
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 19:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739561DE3C6;
	Tue, 26 Nov 2024 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSebjkfF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A58F16F0E8;
	Tue, 26 Nov 2024 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648131; cv=none; b=NQKgnaCkfWwgf0lfEDvkpdFqk4Xfr3QA6ba0CXqtvHpodmAEzj4urMEVVqedUyiHQPculIfgwV6Bvp3/RwO53dAZG9tomY/9i/HU9wGkQnDaZVXiIZBrpaoo7T2mXqcYxrc6D7rDb7bj1Ud9HYrOHljWPSvg/Mq/cwOGCcjcApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648131; c=relaxed/simple;
	bh=LSTgT6yRel7vE8iaS/Hr0rILSHO34VaIaO8GTSOQEvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsN+4JgCWI93m49T+J4Qy0JDr3sdB0ggA1YfVpHlp85StRukf0MOJj0V0GVnBA1RYvlqqFzWdwHKI1Z+pZn5WcTok9nZfAcAGqS2NTsFnJVXjpfl7oB0oNiBzCFOSqGNzbFieddzYEB7OnKR28U4HHCti7xhpOA1YzCVCaGaGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSebjkfF; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7eae96e6624so4706389a12.2;
        Tue, 26 Nov 2024 11:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732648129; x=1733252929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzpJHFBf+UwrpTd1/ASOxsImqCiQ35Pf7i1O4FF/kBw=;
        b=ZSebjkfF0HP97kFuj/FczGfsHpmDXyC1Byv4KUqq3/Cba8/ODrMxUXBkn/d79+KTIE
         SdvQQsBhP0MyxaKEe+lhsWrR+mvbYAJUfDutTvQ2jKqWyPpd9qj3gMN4iazHLqTX4W5K
         MGc8P4pwmb4YYzGwJK8j1LqlAcAw+yklKEWOYke+8HNShc90BxYo/hHXK+b8TMZsWnq6
         wLXGfVt6wzDNt+MxJrO4eynMjS7mNY2+aNJV2yWU/iucW25j6T5wzMcd3CvnmbumZYv5
         /MoV1S25HyEXlEnI0Bu4RdBM4eetUJ3qDjx8Vw7R9LX+nBkBczKz+wsqkIX+noa5mXA8
         hRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732648129; x=1733252929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzpJHFBf+UwrpTd1/ASOxsImqCiQ35Pf7i1O4FF/kBw=;
        b=km7ioMz1V6Jz4dXVDNY+mD1UoYkHLQ159/MKgWZvbVYDriEFVuPylM1r6oE8ztJQpj
         ujNdH7rmUFJ9ChJv3/sSRzk97sY0t6wpV2e8Igx52fQ1XrmMPJfayDKG6uNNuAHcm7WA
         lmZFAVSW/bClJoROHVrsSqWe2YqxOb47lexixJlXMbrGoDsZHg3vB56wpPylQdzurSeJ
         0zk8NxE8NPizcEXNfnsEqKlqqJ7RmanG2b7YDB95JeVH+vjd57eyn7BuaDYy+bOR35Gy
         nEdO8J/2Dwcpbl3ePmovAXgq757RdoI2d6jvVG30X31fshtVzq12Nkr7R6cNzmjzQvCr
         wXXw==
X-Forwarded-Encrypted: i=1; AJvYcCW0swR+04viKYbXyp5jMmQoxcn76PIofAD7ebslMfSsT2sWRuCjqvWP2xBsSCvJZpqA7cM=@vger.kernel.org, AJvYcCWolrubydxM2NYAjRiqJ+FUJh+4uVYxrvBlVdhpNU3i7eSVz48PTpdoyA3mV2wYN+LzIJ6QsocqN4RdLQ1raPax2A==@vger.kernel.org, AJvYcCXv6bcKTqqEYPjaoKGPTpUtKT8moWJ3Q3i2f0LK2AYow1ppUtj5dVz3IBFsx5rjsrLC+SovIXrRDklQBdIO@vger.kernel.org
X-Gm-Message-State: AOJu0YzCc0BiNZldE/BGoO9MBXVJqxUiq71KQjfQEF4GE+i5oJau/6t1
	dYrCJbEan80fV/n2QZUyzPjOQpsJ1sTxD/WFs7PZb8wEmfSsbvNW63x/yO7+2BQOoK2PHavWclm
	U/xC+/pc2LuseWDko2ORNoi+depY=
X-Gm-Gg: ASbGncv7jk8HHAdboy3aenNmla2W/U/nBPRZWi1bnVlEprEbAQe8U1eWuHifpQkHtni
	gXjvzhv+LeDdxhsk0Qr/tr0cVmOvNBvliNVXzYZjeZvW0nak=
X-Google-Smtp-Source: AGHT+IHcYrRCh6RNI0uiagGqqkaq3FZL8c+Kw3Z8YZqY6vK95MlFLapo/aFhwibPheHhsonc+9ZqeeDqk3LMLFpN7X0=
X-Received: by 2002:a05:6a21:670f:b0:1e0:d5fb:6fa9 with SMTP id
 adf61e73a8af0-1e0e0baf8b9mr790086637.31.1732648128845; Tue, 26 Nov 2024
 11:08:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106193208.290067-1-bjorn@kernel.org> <87r076nikd.fsf@all.your.base.are.belong.to.us>
 <Zz7Ng9CzrF_ciAz-@google.com> <6a960374-0cd2-4de9-8fc6-c8fe21097b6b@kernel.org>
In-Reply-To: <6a960374-0cd2-4de9-8fc6-c8fe21097b6b@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Nov 2024 11:08:36 -0800
Message-ID: <CAEf4BzbY6E4cfFKvnjjXYX=03yGdMa6oLAAca8JXSh9e6b-6iw@mail.gmail.com>
Subject: Re: [PATCH] tools: Override makefile ARCH variable if defined, but empty
To: Quentin Monnet <qmo@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	David Abdurachmanov <davidlt@rivosinc.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 3:30=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> 2024-11-20 22:04 UTC-0800 ~ Namhyung Kim <namhyung@kernel.org>
> > On Wed, Nov 20, 2024 at 02:25:22PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> >> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
> >>
> >>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >>>
> >>> There are a number of tools (bpftool, selftests), that require a
> >>> "bootstrap" build. Here, a bootstrap build is a build host variant of
> >>> a target. E.g., assume that you're performing a bpftool cross-build o=
n
> >>> x86 to riscv, a bootstrap build would then be an x86 variant of
> >>> bpftool. The typical way to perform the host build variant, is to pas=
s
> >>> "ARCH=3D" in a sub-make. However, if a variable has been set with a
> >>> command argument, then ordinary assignments in the makefile are
> >>> ignored.
> >>>
> >>> This side-effect results in that ARCH, and variables depending on ARC=
H
> >>> are not set.
> >>>
> >>> Workaround by overriding ARCH to the host arch, if ARCH is empty.
> >>>
> >>> Fixes: 8859b0da5aac ("tools/bpftool: Fix cross-build")
> >>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >
> > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>
>
> Acked-by: Quentin Monnet <qmo@kernel.org>
>
>
> >> Arnaldo/Palmer/Quentin:
> >>
> >> A bit unsure what tree this patch should go. It's very important for t=
he
> >> RISC-V builds, so maybe via Palmer's RISC-V tree?
> >
> > I think it'd be best to route this through the bpf tree as it seems the
> > main target is bpftool.  But given the size and the scope of the change=
,
> > it should be fine with perf-tools or RISC-V tree.
>
>
> The bpf tree would make sense to me as well (but I don't merge patches
> myself; let me Cc BPF maintainers).

Doesn't seem like this file is owned by anyone specific, I guess it's
fine to route it through BPF due to bpftool? Should this be bpf or
bpf-next? Also, please resend targeting the right tree, so BPF CI can
test this.

>
> Quentin

