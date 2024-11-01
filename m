Return-Path: <bpf+bounces-43766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DCA9B984A
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E3D1F2117F
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FF81CEEA7;
	Fri,  1 Nov 2024 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im6GE9Zn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4A837B
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488771; cv=none; b=FTERtkUHF/bxJObM7FGurxpmlHe6wL+CZ13wfwcc9znQLSFre06sRkQgSvHM843sjO0WtDJufV58uy8b4T4q89krE3C3OEL2rHcAlv/9l1/YYJUM01LDh43WTUyfNkXqmELqDgP3HdAqTYD5ZCOcm7pvWFtAf4Pm2ccsFPTPtFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488771; c=relaxed/simple;
	bh=eM+B4kgORnIpmF/vyreB+CY6yysJdw6P2a7H7hfJRvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dujXIEJ5DgRffZAyDnmFNHygoG8XRGS7XFgm4LTm9AcgGuJZT/aZGtTybeHasHLoPxjPJj2ATDbKQ6X1JqgDl8CF1ACotwL+6wcxZWc2Gebs/4eW9bt+VA/PlsUmTl8Xc6SOdgH7z6gbj/Hp9HZqU7vwTQhv2yA2OjgtYMAgvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im6GE9Zn; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so1761423a91.1
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 12:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730488770; x=1731093570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+xSFts/BN0NWjVwYzgOuYhu5rFylcvhBHBmmQfP2gg=;
        b=im6GE9ZnWLcy6gEWYqgmZJ5/Yu9npL0YJkv61A1JepeArq9qM3pWqhFPXO1Ewiet5g
         uNymZuULURlTzogajZs6swoI9FTo2T/MA24esuYuTX96Bh7+u15d8IYsfQGDgs/qUzEU
         awcvUGVZqVZqS9ZAxLZyfU0Y/wy850Nt7FiReenaDBswv0arhDQx2dwQo8SjvWfM7Z4N
         KlyJb+7FbeTmlVj60M6ktfxWpVf2hTyk1Bez7EpIP9BCVMcA2h/wdP3Gdf+pFplHDcQe
         QWTwcqC4slr874kihj0iIvhcWIJLM6EaPGPT1Bp2eJoTaGwtsOVa0PNV05h1yNsHxtjI
         HETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488770; x=1731093570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+xSFts/BN0NWjVwYzgOuYhu5rFylcvhBHBmmQfP2gg=;
        b=tX6YH8o1dhfJXvClOPELyZ+BjWnSLDXstJ23SbEPA34rkVjiE2fqAA8bco1eBH+6MH
         FVlp5udwO6ozA3YuojXAyd0IIkjPHqvTqLD63ypyiuagfhMGvgk+Lk4sX42QcGb09+7j
         LxPRHei+x70beTvNiW9BnP2B1gyxE47T9gCBkdzdobvT3XDC+RVzsK4Hlv4KAXz9tjmt
         fnzRro0bIJ41tog72W7JflVh9wsxG6fAbEBCP5Ai7qk3WVbZ3hMxaN9VJKqDXyJUFINh
         Yu7CNe/u1fdXp+OezjysF6jUKcSllK3InBINcgg6ulVC5n4PTSrrrELxsHMrPkc8DQam
         /qBg==
X-Gm-Message-State: AOJu0YyjUt7DFqwCiorGbOxg0DPZF3T/1QaX20irSPB8DaUWnSFqlZip
	IVV8SKvRahekLuzCmGjf6Lof+5lSYl1mMedDly5O8gokwrw4+RDkzO1i9PY8cL757EVHxz7RlQa
	K+GgEW7Tttpr1n291V4ZYSn23fqM=
X-Google-Smtp-Source: AGHT+IHGM0JCZ+Ix3ELSgNiWKe4+YN8BDIoRv8GsQLZK6nD+/GDe/RqkZDBNZcVoE/T2bAtrpeeb79FP0RZjf/z0JhQ=
X-Received: by 2002:a17:90b:1208:b0:2e2:bbcd:6cbb with SMTP id
 98e67ed59e1d1-2e92ce2e067mr11971837a91.6.1730488769686; Fri, 01 Nov 2024
 12:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101000017.3424165-1-memxor@gmail.com> <20241101000017.3424165-3-memxor@gmail.com>
In-Reply-To: <20241101000017.3424165-3-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 12:19:17 -0700
Message-ID: <CAEf4BzY0ury4nWGOrjk1V2qK5+e1GT3b=i9eLLS42QB_QfNVyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for raw_tp null handling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Jiri Olsa <olsajiri@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 5:00=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Ensure that trusted PTR_TO_BTF_ID accesses perform PROBE_MEM handling in
> raw_tp program. Without the previous fix, this selftest crashes the
> kernel due to a NULL-pointer dereference. Also ensure that dead code
> elimination does not kick in for checks on the pointer.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../bpf/bpf_testmod/bpf_testmod-events.h      |  8 ++++++
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 ++
>  .../selftests/bpf/prog_tests/raw_tp_null.c    | 25 +++++++++++++++++
>  .../testing/selftests/bpf/progs/raw_tp_null.c | 27 +++++++++++++++++++
>  4 files changed, 62 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
>  create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h=
 b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
> index 6c3b4d4f173a..aeef86b3da74 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
> @@ -40,6 +40,14 @@ DECLARE_TRACE(bpf_testmod_test_nullable_bare,
>         TP_ARGS(ctx__nullable)
>  );
>
> +struct sk_buff;
> +
> +DECLARE_TRACE(bpf_testmod_test_raw_tp_null,
> +       TP_PROTO(struct sk_buff *skb),
> +       TP_ARGS(skb)
> +);
> +
> +
>  #undef BPF_TESTMOD_DECLARE_TRACE
>  #ifdef DECLARE_TRACE_WRITABLE
>  #define BPF_TESTMOD_DECLARE_TRACE(call, proto, args, size) \
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 8835761d9a12..4e6a9e9c0368 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -380,6 +380,8 @@ bpf_testmod_test_read(struct file *file, struct kobje=
ct *kobj,
>
>         (void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
>
> +       (void)trace_bpf_testmod_test_raw_tp_null(NULL);
> +
>         struct_arg3 =3D kmalloc((sizeof(struct bpf_testmod_struct_arg_3) =
+
>                                 sizeof(int)), GFP_KERNEL);
>         if (struct_arg3 !=3D NULL) {
> diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c b/tools=
/testing/selftests/bpf/prog_tests/raw_tp_null.c
> new file mode 100644
> index 000000000000..b9068fee7d8a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#include <test_progs.h>
> +#include "raw_tp_null.skel.h"
> +
> +void test_raw_tp_null(void)
> +{
> +       struct raw_tp_null *skel;
> +
> +       skel =3D raw_tp_null__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "raw_tp_null__open_and_load"))
> +               return;
> +
> +       skel->bss->tid =3D gettid();

this is not available everywhere, we just recently had a fix. Other
tests call syscall() directly. It might be time to add macro in one of
the helpers headers, though. But that can be done as a separate clean
up patch outside of this change (there is enough to review and
discuss)

> +
> +       if (!ASSERT_OK(raw_tp_null__attach(skel), "raw_tp_null__attach"))
> +               goto end;
> +
> +       ASSERT_OK(trigger_module_test_read(2), "trigger testmod read");
> +       ASSERT_EQ(skel->bss->i, 3, "invocations");
> +
> +end:
> +       raw_tp_null__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null.c b/tools/test=
ing/selftests/bpf/progs/raw_tp_null.c
> new file mode 100644
> index 000000000000..c7c9ad4ec3b7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/raw_tp_null.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +int tid;
> +int i;
> +
> +SEC("tp_btf/bpf_testmod_test_raw_tp_null")
> +int BPF_PROG(test_raw_tp_null, struct sk_buff *skb)
> +{
> +       if (bpf_get_current_task_btf()->pid =3D=3D tid) {

nit: avoid unnecessary nesting. Check condition and return early. Also
seems nicer to have task_struct local variable for this, tbh:

struct task_struct *t =3D bpf_get_current_task_btf();

if (t->pid !=3D tid)
    return 0;

/* the rest follows, unnested */

> +               i =3D i + skb->mark + 1;
> +
> +               /* If dead code elimination kicks in, the increment below=
 will
> +                * be removed. For raw_tp programs, we mark input argumen=
ts as
> +                * PTR_MAYBE_NULL, so branch prediction should never kick=
 in.
> +                */
> +               if (!skb)
> +                       i +=3D 2;
> +       }
> +
> +       return 0;
> +}
> --
> 2.43.5
>

