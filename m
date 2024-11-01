Return-Path: <bpf+bounces-43776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA099B98E1
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C20B222AE
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFE11D0F50;
	Fri,  1 Nov 2024 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJj8tdKU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11251CEAB5
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490416; cv=none; b=unEcrPvTCRoUvdkXKOb6+ONezr9cVXtN2zJKkGkH8fwPvXjgDLCE0LFU0MSnhGIeSuAKtYV6LYwah2leGJum8+mneUv1jDSD0DVO0CLSsWtbhPgsar0bs1tQTThAyLEY8lbnmLH+3ghHWPRW5ZOlSEZSqrM8GoxD4xf+PZ8H7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490416; c=relaxed/simple;
	bh=TxbT9eNnZTYLQsyQJIopoKv803llp4mbfh2k1X/QDNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ca9k/6VV78FlH+fD44g3gIAHSDuQ0tfOIgagbSsmLFwE/8h+MjErLAZzyRr5Lpy6vejr2Hxi/TjSu8u7L4bFvqhYLdDwnyCSP7s7I7x++otOl0UvCkXECXj5fUChtvB9KXLRW746XpeA3AJ2RrMIlzEYARE257/QCe1NSRd7VS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJj8tdKU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea68af2f62so1797370a12.3
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730490414; x=1731095214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bL82FBjmxnjlpjrlRs7TO6Nc1TczWuc4HNGfpdtb3gs=;
        b=aJj8tdKUD/+xA7QJqxjCIIYnRqMK+s1JIz7lfB08oS1DezVayXZVvaJ4zibM2L1wy6
         zxuNGfAqIDcBdJd3qLX70jrwigaMcBUJl2TlBk8two3CyYdGR+CdMvcU5iMArf40ZQ/K
         T0jutJLmHeMUyLrYEEtYNyaQKuiNdMQbFlb2Rwsdy/0i4GaUsL/KllQYxr1B4yjrCH0B
         a9vaPgTsAxTarRm/LTvicbZBcp0jarsAzzAgwDelLwnnaJThI3h/BP5kkOHo4tEevjGV
         D/jnd6sev6hEKoo4bKZapKY8+DByMnjVDVcFykHBu5CE2Ic1pRVjJkh6DEz1lydv/e3K
         JjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730490414; x=1731095214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bL82FBjmxnjlpjrlRs7TO6Nc1TczWuc4HNGfpdtb3gs=;
        b=AdcbhncD2Mt9IEGYekhwHT6jMYVm6v23/VmHL03ZhFs7mWfEHV77FT12slW33DWcTB
         4R+14z9MdUK1po0el2t26cgKVOC5qEDznMpusrsteDeJqft3rgtK62d0niOcPrP2MAP1
         bUGClsOo/dImso1WqyMFOWN+8jsdjfNAi6cxzMHuGp7mJ1i2nxHcx6lhHtQmiwVHttS/
         vWM8Nmsny7HjeCKen0TsQ3YCXJ+SDVlAZh3/hCtYvgtyf8PRQYVEfS8Sbx2NBVvR15FN
         p0CUeKNHGbnX5b0yRVSymGCiGutROSj2Sk8brnA5ob5G6BdMOpYsRFEECiGteYozD83i
         hSMQ==
X-Gm-Message-State: AOJu0YxK1yt1iOTXceH1zN4dKt2JR5yxBMFN1vaZ6FQq+uUVgwNe9kbq
	AnmQspMqflu7cLw8bDQhvASyLgR7QLNEX097Z1urqovM01jP+yJAier4y8yuEZjBjHa1pkg1oOx
	iS8qhNu/TrVbJHM7/rB+d4/evymk=
X-Google-Smtp-Source: AGHT+IHVy1MtvpTpsPQ3fWpVCO5Jxlx08iRgoeZhw6R9LEiZ/AcWNwdq++9rbnKvq10lU5lxQIZO7YpaoeujOtY1/TU=
X-Received: by 2002:a17:90b:3886:b0:2e2:ebbb:760c with SMTP id
 98e67ed59e1d1-2e94c2bd744mr6486608a91.11.1730490414349; Fri, 01 Nov 2024
 12:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730449390.git.vmalik@redhat.com>
In-Reply-To: <cover.1730449390.git.vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 12:46:42 -0700
Message-ID: <CAEf4Bzaf4SpcL6cV+VNxfiqifhM=7e_sY5YyBCZKVJqdvxqqQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] selftests/bpf: Improve building with extra
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:38=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wro=
te:
>
> When trying to build BPF selftests with additional compiler and linker
> flags, we're running into multiple problems. This series addresses all
> of them:
>
> - CFLAGS are not passed to sub-makes of bpftool and libbpf. This is a
>   problem when compiling with PIE as libbpf.a ends up being non-PIE and
>   cannot be linked with other binaries (patch #1).
>
> - bpftool Makefile runs `llvm-config --cflags` and appends the result to
>   CFLAGS. The result typically contains `-D_GNU_SOURCE` which may be
>   already set in CFLAGS. That causes a compilation error (patch #2).
>
> - Some GCC flags are not supported by Clang but there are binaries which
>   are always built with Clang but reuse user-defined CFLAGS. When CFLAGS
>   contain such flags, compilation fails (patch #3).
>
> Changelog:
> ----------
> v2 -> v3:
> - resolve conflicts between patch #1 and 4192bb294f80 ("selftests/bpf:
>   Provide a generic [un]load_module helper")
> - add Quentin's and Jiri's acks for patches #2 and #3
>
> v1 -> v2:
> - cover forgotten case in patch#1 (noted by Eduard)
> - remove -D_GNU_SOURCE unconditionally in patch#2 (suggested by Andrii)
> - rewrite patch#3 to just add -Wno-unused-command-line-argument
>   (suggested by Andrii)
>
> Viktor Malik (3):
>   selftests/bpf: Allow building with extra flags
>   bpftool: Prevent setting duplicate _GNU_SOURCE in Makefile
>   selftests/bpf: Disable warnings on unused flags for Clang builds
>

I've applied the last two patches, they seem to be independent from
the first, right?


>  tools/bpf/bpftool/Makefile           |  6 ++++-
>  tools/testing/selftests/bpf/Makefile | 36 +++++++++++++++++++---------
>  2 files changed, 30 insertions(+), 12 deletions(-)
>
> --
> 2.47.0
>
>

