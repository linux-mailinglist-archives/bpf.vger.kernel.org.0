Return-Path: <bpf+bounces-15249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987617EF68D
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 17:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F66A2814E3
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF443EA94;
	Fri, 17 Nov 2023 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7QnD5/P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3566A4
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:47:25 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so298762866b.1
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239644; x=1700844444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlOa0PxruMfZM0o3nplLblXGAOxXcc5rMqLqO7eouQ4=;
        b=b7QnD5/Pr9EDbhsH6TkoqNavcL7k47ZlK7Wjs3b1PjdBx15jFNtRhtzuMETBGLzOSm
         pXnl2QmArZs8+YTbZIX/UanklqhzZP1wgrGi+9FYHDQ6sIh4sIF8vjOZqyHwmkKIFt9g
         lMogNlfAeOIhAEhCeSsyuOOj3hIwjL+oea0SwQIXuGEVQwy9Uxeova4/9Bm6Q4kgNK9y
         5iJ1BEl1i/cfk8Qmlh6kDDM0AiV4vRFV3ZFha878mHmjJv8XoKjUiKuUvLKq2mIpD5ZX
         sq3B0LqbpLSnY0AsedcmrBemMXKABYIiWHG0Vcs8gkC53IBp+IztSNUjV1Qn531gmcd2
         RuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239644; x=1700844444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlOa0PxruMfZM0o3nplLblXGAOxXcc5rMqLqO7eouQ4=;
        b=dsYbXkey3o0uCXsImSi/zDVO9N4eZxaT9ZFKqLSxsNJ9vl2NdwgJa/w8mrqUtA792v
         vrrnDuL6Di7W/nkM6WGq8VAKaOOYI9C75QAjGHQ4BKBkUoSjrWK/nvbE7K62N7aEXO5u
         UPz7cr0PZk9VMvj0DZGJ7y0YZ2LNjpuO13byGOXUY3QnzVux5gsp9d9lMIb5EWLKAUsJ
         LItfu5Pfbc32+5hU8zd0gqA/hSHf8dAzmAdDD8v9o0ThifXMr6HDMDqe7Ya0OFjxt+zE
         e6Efm7iCgJuiIjkUXcCAdqTUhKXFzJJ8SsambsuW0OXliVU8LSCE1bu3AkEcMelRp1BJ
         4tug==
X-Gm-Message-State: AOJu0YzeaTMz+tSZmhXoPP6dZaWCLjNzz63qjtEyS9qJV/0ZucMV0ZNX
	R2J2alg2fGzB49CiseL2OSeyGyY0RCEnl19tyn8=
X-Google-Smtp-Source: AGHT+IHCVficRzcVJErSgc/p5PCUgHCP2Z3dKReCNukiZd4Mhqt9/7X73Q7U2rMV5NIOHN4iGJenHz9KXlc5kgH8tUE=
X-Received: by 2002:a17:906:f8cd:b0:9bf:889e:32a4 with SMTP id
 lh13-20020a170906f8cd00b009bf889e32a4mr14550047ejb.54.1700239644197; Fri, 17
 Nov 2023 08:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-13-eddyz87@gmail.com>
In-Reply-To: <20231116021803.9982-13-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 11:47:13 -0500
Message-ID: <CAEf4BzYd_Dv4fEoPe+n+sRXxHFmYrTs7w45jtYeQByNH521gzA@mail.gmail.com>
Subject: Re: [PATCH bpf 12/12] selftests/bpf: check if max number of bpf_loop
 iterations is tracked
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Check that even if bpf_loop() callback simulation does not converge to
> a specific state, verification could proceed via "brute force"
> simulation of maximal number of callback calls.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../bpf/progs/verifier_iterating_callbacks.c  | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbac=
ks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> index 598c1e984b26..da10ce57da5e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> @@ -164,4 +164,71 @@ int unsafe_find_vma(void *unused)
>         return choice_arr[loop_ctx.i];
>  }
>
> +static int iter_limit_cb(__u32 idx, struct num_context *ctx)
> +{
> +       ctx->i++;
> +       return 0;
> +}
> +
> +SEC("?raw_tp")
> +__success
> +int bpf_loop_iter_limit_ok(void *unused)
> +{
> +       struct num_context ctx =3D { .i =3D 0 };
> +
> +       bpf_loop(1, iter_limit_cb, &ctx, 0);
> +       return choice_arr[ctx.i];
> +}
> +
> +SEC("?raw_tp")
> +__failure __msg("invalid access to map value, value_size=3D2 off=3D2 siz=
e=3D1")
> +int bpf_loop_iter_limit_overflow(void *unused)
> +{
> +       struct num_context ctx =3D { .i =3D 0 };
> +
> +       bpf_loop(2, iter_limit_cb, &ctx, 0);
> +       return choice_arr[ctx.i];
> +}
> +
> +static int iter_limit_level2a_cb(__u32 idx, struct num_context *ctx)
> +{
> +       ctx->i +=3D 100;
> +       return 0;
> +}
> +
> +static int iter_limit_level2b_cb(__u32 idx, struct num_context *ctx)
> +{
> +       ctx->i +=3D 10;
> +       return 0;
> +}
> +
> +static int iter_limit_level1_cb(__u32 idx, struct num_context *ctx)
> +{
> +       ctx->i +=3D 1;
> +       bpf_loop(1, iter_limit_level2a_cb, ctx, 0);
> +       bpf_loop(1, iter_limit_level2b_cb, ctx, 0);
> +       return 0;
> +}
> +
> +SEC("?raw_tp")
> +__success __log_level(2)
> +/* Check that last verified exit from the program visited each
> + * callback expected number of times: one visit per callback for each
> + * top level bpf_loop call.
> + */
> +__msg("r1 =3D *(u64 *)(r10 -16)       ; R1_w=3D111111 R10=3Dfp0 fp-16=3D=
111111")
> +/* Ensure that read above is the last one by checking that there are
> + * no more reads for ctx.i.
> + */
> +__not_msg("r1 =3D *(u64 *)(r10 -16)      ; R1_w=3D")

can't you enforce that we don't go above 111111 just by making sure to
use r1 - 111111 + 1 as an index into choice_arr()?

We can then simplify the patch set by dropping __not_msg() parts (and
can add them separately).


> +int bpf_loop_iter_limit_nested(void *unused)
> +{
> +       struct num_context ctx =3D { .i =3D 0 };
> +
> +       bpf_loop(1, iter_limit_level1_cb, &ctx, 0);
> +       ctx.i *=3D 1000;
> +       bpf_loop(1, iter_limit_level1_cb, &ctx, 0);
> +       return choice_arr[ctx.i % 2];
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.42.0
>

