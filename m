Return-Path: <bpf+bounces-21883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F056853B55
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92D41F27E80
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723076088B;
	Tue, 13 Feb 2024 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXurQbXQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B960872
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853239; cv=none; b=eBIefx5qCTnTTlDmSsO26jub7oma87RrJ9wQR5ZwPGbjwmblR0uLue0y7CKZ/bWAr3ol3Urwayna6QNUoONr55RRQwZlERN0BhcjQGd833oEkVH9If1w5C3fo+EfPWymucq/7A9OSeVQ/zybvV4IiyMICl0ZJDgBaMkL1UGrpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853239; c=relaxed/simple;
	bh=EMDZDJ6MELx53K8NB9rlFARuuHR4sMMxiBsl5Bym0oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBCraCbxJUrggnQiI3lLKx42XIVo2hYzqm6TC1q2pG5D0mdNgcKMDoPwuePHowSQifM+K/ju0duIb9IpSuWqu3fReOHlNR2MLfzYwvP5yOi2Lq5S1QxrN0ZFLGixPjJbs9npw7YVP8Y1beMXfqn1P5R1FI4mVWgjaJKOfDAGVmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXurQbXQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8df34835aso65405a12.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 11:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707853237; x=1708458037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRIJP4PHER+Y1XjKhzIxWYDIFSvs1fl6l/TKq1vbQis=;
        b=PXurQbXQQynp54XwwBIvliDbYdjAEcRu8kjLlvPHMtHRRzZnLHP9vB2fk2vEe+NOTA
         LmulSnUUUqDBCRdm7P5sAe4vw8NuIKX4cf6dDmv/uq+QVntDixIGc981iS4tP8T6qOb/
         NHcmqJyo20sXIW2jSJdxuFeqMsK8BZKlVbozac4JWt9HG5QvjZ725WiAI7H5VL+ZsGfW
         TQ+lC2Ei2O7UsZ8RZlqfLhZ0zt6rDS978nd/c7qwpbC5J+Vik0dv0P8ixXqu+nh5o9uX
         UlFbuWW0SdYNWBLGyuQECa42N7B1enkn1pdwvBHlHpFYHKrGdHwQTRgdJS2rJl6IKbkj
         Yhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707853237; x=1708458037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRIJP4PHER+Y1XjKhzIxWYDIFSvs1fl6l/TKq1vbQis=;
        b=kda5s1pqGRFYEvLi6XPTrOz5/LFzCbeTvkocpTOi5yVtPw2/zoxwVUJTS2tEGdsdvC
         NSLd8/oOOcQrvBtSfDNYQefJJPBgl4+k2XRfxCJ9fwJa1+CrycFyhzIe9xybYRMlAyGw
         sCJn1uG7h+H5BbMxmIFcVtngKoJjli2cSbfPtYiASF1C4L+wo7mhs8dL7toIKe0jzYHw
         SldCDDhvE8XlgLZ1lGEbV2lOpuJOntn1ECXSh/cWzlM9xCFhJzVDvQwTBnfbKSemMXn1
         JKpsqCeoQykJ79ZnlyWNvWKflHOMAeyQfOTubi6uy/viaX9871Rm+ixmYj2hbjvP6lZB
         MCWg==
X-Gm-Message-State: AOJu0Yza0a4w4zrykK+sD4a8T2aEYS1je+96VkKqeqmlZWfy10GM5jmU
	qfCK4UmC8ANePjoQkt/aRzSWx8ZZtXmVSsoaYmPe266xDFczKrcVG+L/MgAfq3bE7Katcg7AiZn
	C+s91SsLUi9Qq1rmcNXeTwnZLAm4=
X-Google-Smtp-Source: AGHT+IHONfe4PEvCOGdrGL/RywBm2zBuc+Kba+fswUVN65DWuFyBzONM5UvMvpHp2KuBd5xIYWFyYy9QgfTYU/hAQmc=
X-Received: by 2002:a17:90b:4f8e:b0:296:4e2f:a680 with SMTP id
 qe14-20020a17090b4f8e00b002964e2fa680mr5153292pjb.10.1707853236840; Tue, 13
 Feb 2024 11:40:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208215422.110920-1-yonghong.song@linux.dev> <20240208215427.111319-1-yonghong.song@linux.dev>
In-Reply-To: <20240208215427.111319-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 11:40:25 -0800
Message-ID: <CAEf4BzamGPs45fFTDW4P_Ymm3bZ+Z0yP4JBPZHgefYbc5DgapA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add a negative test for
 stack accounting in jit mode
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 1:54=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> The new test is very similar to test_global_func1.c, but
> is modified to fail on jit mode.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../bpf/prog_tests/test_global_funcs.c        |  3 ++
>  .../selftests/bpf/progs/test_global_func18.c  | 44 +++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func18.=
c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b=
/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> index a3a41680b38e..dccbf2213135 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> @@ -18,6 +18,7 @@
>  #include "test_global_func15.skel.h"
>  #include "test_global_func16.skel.h"
>  #include "test_global_func17.skel.h"
> +#include "test_global_func18.skel.h"
>  #include "test_global_func_ctx_args.skel.h"
>
>  #include "bpf/libbpf_internal.h"
> @@ -140,6 +141,8 @@ void test_test_global_funcs(void)
>  {
>         if (!env.jit_enabled) {
>                 RUN_TESTS(test_global_func1);
> +       } else {
> +               RUN_TESTS(test_global_func18);
>         }
>
>         RUN_TESTS(test_global_func2);
> diff --git a/tools/testing/selftests/bpf/progs/test_global_func18.c b/too=
ls/testing/selftests/bpf/progs/test_global_func18.c
> new file mode 100644
> index 000000000000..d1aa3b2c68fe
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_func18.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <stddef.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +#define MAX_STACK1 (512 - 3 * 32 + 8)
> +#define MAX_STACK2 (3 * 32)
> +
> +__attribute__ ((noinline))

nit: we have __noinline defined, let's use it as a less verbose option?

> +int f1(struct __sk_buff *skb)
> +{
> +       return skb->len;
> +}
> +
> +int f3(int, struct __sk_buff *skb, int);
> +
> +__attribute__ ((noinline))
> +int f2(int val, struct __sk_buff *skb)
> +{
> +       volatile char buf[MAX_STACK1] =3D {};
> +
> +       __sink(buf[MAX_STACK1 - 1]);
> +
> +       return f1(skb) + f3(val, skb, 1);
> +}
> +
> +__attribute__ ((noinline))
> +int f3(int val, struct __sk_buff *skb, int var)
> +{
> +       volatile char buf[MAX_STACK2] =3D {};
> +
> +       __sink(buf[MAX_STACK2 - 1]);
> +
> +       return skb->ifindex * val * var;
> +}
> +
> +SEC("tc")
> +__failure __msg("combined stack size of 3 calls is 528")
> +int global_func18(struct __sk_buff *skb)
> +{
> +       return f1(skb) + f2(2, skb) + f3(3, skb, 4);
> +}
> --
> 2.39.3
>
>

