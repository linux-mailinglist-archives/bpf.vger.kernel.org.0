Return-Path: <bpf+bounces-53929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 290D1A5E8A2
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 00:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E703174B6F
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 23:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824711F12EA;
	Wed, 12 Mar 2025 23:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlmXpJxD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC14D599
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 23:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823164; cv=none; b=oHWFoakbRKPTj6xrasfsh8VElPRv+FnLqwn+xMA6QV0XNeAB3aJ1+1seJpAzOY0TvOfLWWsPVgQrKQ9P8OmhnQHHNzed5hsPalC24XTP6IcRn/YHC8+atx36qeWT+SsGQ23qN/Yet6/3b+M8kQ2bqkk+weYGTR1ezYTsZ/kTSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823164; c=relaxed/simple;
	bh=qXzJUJrN9tvZo6tgq9pC9/2HAfGC1XMN72X23mlwbI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1JmAnNqzOpGho6Rlt8BebBCV6D/kpbpcAqmn84le/SuP28rTr0NvRg6l7/7B/14Kfg3d64bgwRjqkJUVHVC5aCS40GFz2HiHIBln2xKn3MdsqVD8uq2R0PIGyX/lbxuXpprnusG5WWWZ7S9F2mG0QaDjrOeqmCZ+kCF6Q6VAlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlmXpJxD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22435603572so6958975ad.1
        for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 16:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741823162; x=1742427962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAFMjRpKUlMSeu+DFZoljW2RUn5yIfJMfujUP3+eKls=;
        b=OlmXpJxDx3O7FumboTrya2xgdZdxLgUvb3TV9ugSBXG32pcXrBRbaV/UFoWyWRQhRi
         izY4DtA4ETbq/1MLthH4HMq63sOiwktfjF610peP5gBcaTtX7iWKcmNtLD8lET/tPI21
         oWzU/rnIL8ZB053GdmsxeB6XM+4u13IwXZK2KEWPRoPxwObSvcg36U1lsRlM/SLSqNQg
         tu2yhf+Nv8DHcDSTkEydOO8Lh7P1D1rVHNdCZybaRD1yZ+mjF52HRd/lrLEwkptIIgeS
         ZtiggyhxgyhPpWnNcZPWgwwOrYzrsdmdU+/9MHce9fZQfHZ7/15ts1PRAkFKyOBj7JkM
         SvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823162; x=1742427962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAFMjRpKUlMSeu+DFZoljW2RUn5yIfJMfujUP3+eKls=;
        b=wtR2SwDSXSbHtVIwXclGrfdm/km9X5iGQybT0PcmostXM1dUltBq4iQJcYuE+VJXiM
         PGf+QS9faZhlFQTwSBkfViZDxxRCj2JgZY9wkLYGOUgSUNErYsMTHE7zma0ujEwoVR+n
         4wzrx6fA75jNJOInp1VwR0L9c+9b513FXWdVhJ0Lx5FWIlHf58QgrXWjZOqzGGuQwfOM
         Nn/3TTwN+Rv+ZQadfmNernRUAIEpjCe6AMOCCEou48M86gR8omq27/XO/DgznXSMoeZc
         E0eOkhgyXkf+3Pwc/vGeKxgOLod3nNZcUuXhFvh4MwxCPPLcMCqYdfcPKsf2DI7vVuys
         i9Uw==
X-Gm-Message-State: AOJu0YyFvktoBOWHrWbILLe2WiBpHVhpjYcpVUkqFYtnCDEPz8MZuMMV
	C3lHDJzDSvDu7avp4E3DWCYLt5FcuVn9At43zM5L81jtmBz1LReMsucXiJ0xRVg12xQOh9iB6/T
	Ugk63s/6ElNImwI0X4fMI1PW0+hM=
X-Gm-Gg: ASbGncvUgu5MmCEk1BU+50HUzn5i6h5Uxg33d8Y+lhzqR7t8mwbEbqsu7Tni+Kp7gQ2
	8QbNkgHHxWwT6EBaWMucdoceeQ4hgx9pwnYbzhTKk0TXkamcsajlKYCra96sfxcUVpGvsd5Yril
	SDDViUVbS11UU7MJg0kSxEFNhWxFAEBjjDJhlqrKT2yA==
X-Google-Smtp-Source: AGHT+IEkeB3uirWKWIZJFJfWZoscmne5ZFdHbrrTk8jFkhihomMNd1JLeWDGmJnHjB7sFy5v8+DjE59l3gu/zSOKsYg=
X-Received: by 2002:a05:6a00:23cb:b0:736:55ec:ea8b with SMTP id
 d2e1a72fcca58-736e1b3e670mr18278762b3a.24.1741823161670; Wed, 12 Mar 2025
 16:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312083859.1019635-1-vmalik@redhat.com>
In-Reply-To: <20250312083859.1019635-1-vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 12 Mar 2025 16:45:49 -0700
X-Gm-Features: AQ5f1Jpv6ICrqaSprelupasPL8TRxhyIcnhRUc5Btzos2-xAUGXMjWf-weYPRwI
Message-ID: <CAEf4BzY38E5LW0KudDF5OC5v72k6QTYkpRdZWjMUUzUTW2TQuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix string read in strncmp benchmark
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 1:39=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> The strncmp benchmark uses the bpf_strncmp helper and a hand-written
> loop to compare two strings. The values of the strings are filled from
> userspace. One of the strings is non-const (in .bss) while the other is
> const (in .rodata) since that is the requirement of bpf_strncmp.
>
> The problem is that in the hand-written loop, Clang optimizes the reads
> from the const string to always return 0 which breaks the benchmark.
>
> Mark the const string as volatile to avoid that.
>
> The effect can be seen on the strncmp-no-helper variant.
>
> Before this change:
>
>     # ./bench strncmp-no-helper
>     Setting up benchmark 'strncmp-no-helper'...
>     Benchmark 'strncmp-no-helper' started.
>     Iter   0 (8440.107us): hits    0.000M/s (  0.000M/prod), drops    0.0=
00M/s, total operations    0.000M/s
>     Iter   1 (73909.374us): hits    0.000M/s (  0.000M/prod), drops    0.=
000M/s, total operations    0.000M/s
>     Iter   2 (-8140.994us): hits    0.000M/s (  0.000M/prod), drops    0.=
000M/s, total operations    0.000M/s
>     Iter   3 (3094.474us): hits    0.000M/s (  0.000M/prod), drops    0.0=
00M/s, total operations    0.000M/s
>     Iter   4 (-2828.468us): hits    0.000M/s (  0.000M/prod), drops    0.=
000M/s, total operations    0.000M/s
>     Iter   5 (2635.595us): hits    0.000M/s (  0.000M/prod), drops    0.0=
00M/s, total operations    0.000M/s
>     Iter   6 (-306.478us): hits    0.000M/s (  0.000M/prod), drops    0.0=
00M/s, total operations    0.000M/s
>     Summary: hits    0.000 =C2=B1 0.000M/s (  0.000M/prod), drops    0.00=
0 =C2=B1 0.000M/s, total operations    0.000 =C2=B1 0.000M/s
>
> After this change:
>
>     # ./bench strncmp-no-helper
>     Setting up benchmark 'strncmp-no-helper'...
>     Benchmark 'strncmp-no-helper' started.
>     Iter   0 (21180.011us): hits    5.320M/s (  5.320M/prod), drops    0.=
000M/s, total operations    5.320M/s
>     Iter   1 (-692.499us): hits    5.246M/s (  5.246M/prod), drops    0.0=
00M/s, total operations    5.246M/s
>     Iter   2 (-704.751us): hits    5.332M/s (  5.332M/prod), drops    0.0=
00M/s, total operations    5.332M/s
>     Iter   3 (62057.929us): hits    5.299M/s (  5.299M/prod), drops    0.=
000M/s, total operations    5.299M/s
>     Iter   4 (-7981.421us): hits    5.303M/s (  5.303M/prod), drops    0.=
000M/s, total operations    5.303M/s
>     Iter   5 (3500.341us): hits    5.306M/s (  5.306M/prod), drops    0.0=
00M/s, total operations    5.306M/s
>     Iter   6 (-3851.046us): hits    5.264M/s (  5.264M/prod), drops    0.=
000M/s, total operations    5.264M/s
>     Summary: hits    5.338 =C2=B1 0.147M/s (  5.338M/prod), drops    0.00=
0 =C2=B1 0.000M/s, total operations    5.338 =C2=B1 0.147M/s
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/testing/selftests/bpf/progs/strncmp_bench.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/strncmp_bench.c b/tools/te=
sting/selftests/bpf/progs/strncmp_bench.c
> index 18373a7df76e..92a828a1ebea 100644
> --- a/tools/testing/selftests/bpf/progs/strncmp_bench.c
> +++ b/tools/testing/selftests/bpf/progs/strncmp_bench.c
> @@ -9,7 +9,7 @@
>
>  /* Will be updated by benchmark before program loading */
>  const volatile unsigned int cmp_str_len =3D 1;
> -const char target[STRNCMP_STR_SZ];
> +const volatile char target[STRNCMP_STR_SZ];
>
>  long hits =3D 0;
>  char str[STRNCMP_STR_SZ];
> @@ -17,7 +17,7 @@ char str[STRNCMP_STR_SZ];
>  char _license[] SEC("license") =3D "GPL";
>
>  static __always_inline int local_strncmp(const char *s1, unsigned int sz=
,
> -                                        const char *s2)
> +                                        const volatile char *s2)

this will be a bit unfair to local_strncmp(), as now you'll be forcing
the compiler to re-read s1[i] twice, right? What if we do:


diff --git a/tools/testing/selftests/bpf/progs/strncmp_bench.c
b/tools/testing/selftests/bpf/progs/strncmp_bench.c
index 18373a7df76e..f47bf88f8d2a 100644
--- a/tools/testing/selftests/bpf/progs/strncmp_bench.c
+++ b/tools/testing/selftests/bpf/progs/strncmp_bench.c
@@ -35,7 +35,10 @@ static __always_inline int local_strncmp(const char
*s1, unsigned int sz,
 SEC("tp/syscalls/sys_enter_getpgid")
 int strncmp_no_helper(void *ctx)
 {
-       if (local_strncmp(str, cmp_str_len + 1, target) < 0)
+       const char *target_str =3D target;
+
+       barrier_var(target_str);
+       if (local_strncmp(str, cmp_str_len + 1, target_str) < 0)
                __sync_add_and_fetch(&hits, 1);
        return 0;
 }


that will prevent compiler optimization as well and won't force us to
do all those casts?

pw-bot: cr


>  {
>         int ret =3D 0;
>         unsigned int i;
> @@ -43,7 +43,7 @@ int strncmp_no_helper(void *ctx)
>  SEC("tp/syscalls/sys_enter_getpgid")
>  int strncmp_helper(void *ctx)
>  {
> -       if (bpf_strncmp(str, cmp_str_len + 1, target) < 0)
> +       if (bpf_strncmp(str, cmp_str_len + 1, (const char *)target) < 0)
>                 __sync_add_and_fetch(&hits, 1);
>         return 0;
>  }
> --
> 2.48.1
>

