Return-Path: <bpf+bounces-15247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41E97EF68A
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 17:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F56E1F27037
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 16:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB11E3EA91;
	Fri, 17 Nov 2023 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaXSnGm+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F82BA4
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:47:16 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54366784377so3146056a12.3
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239635; x=1700844435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AePp0lExAVBSOjqkUgaUASU2q0Shu5acpmBsMvVr5lE=;
        b=GaXSnGm+4Be1oNc4dwbf5gAXNqJ3mPQOlCLYTTSDxldxtSgy9kxhWL43K94nJ6clFn
         Nsh5uw7fAi08MjUhHEJoLn42Ga6G1Ody0BDDAiIrvbZS6Joi2kblRIqGbYt7Q/cc/txj
         ixO6DGbZGS1U2PXrTfgGLQS5wHF0fkbR6CsxfNgRydBW6OBvGPWURqMDwK7dlI3ylbxi
         xCg+asChEjESMw0yo+Wu8pe8isE8tsnglmcpkU3PRU0sd+gssKVduVX+wCeeq8OOve8+
         II5msmddCtY/2VR+9CZb/5mZiGuYSYRDZX4q0qsXW3Z0GHMLOZ0A3SD6xcxniVLI1UvO
         bsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239635; x=1700844435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AePp0lExAVBSOjqkUgaUASU2q0Shu5acpmBsMvVr5lE=;
        b=ar37h5BGetAmhmmUmGgh+8+GIl5LsPmg7VaN8LdO3t8QTh/EgvPNaU8cahOVJ4zFFK
         yg57IkME2uoXYNEU70DNNiGg5dvaBkC2l19Jd+G0tCvRqxGb1BZkgjMLHO8ypEHwtiFb
         d9wo1MYydPXZ5Fl63tr3F8gTkIw2/jGOPyvLBHRDHJWvxNzWVKBBpf8KP0jEZzp6mmam
         1ZYknGuGuEJAVVouvYT+YLpor3mOxSEO2vfyI4JpaQHbdiwv03jgmsAn9Pb4fQsbt3wY
         nRYgsgQdwxH3wiXKSXgwEenO3VDbQapcDziHiT3J/YMtMTf50it/xYg+C4dReneYoni4
         w6dA==
X-Gm-Message-State: AOJu0YyrlOw48lj8B6V0WZcdVyhNC78Q9p5jQ8qu8GyQWqMZ3x27Ggvl
	oHfyI/usDlSojTnt9cV2uJKnwBq+cpNXmvwF4anBRWGm
X-Google-Smtp-Source: AGHT+IE+rXXd9tJ2Ubho/33z0oxQm9MbDRsP0xmemC0uqDudjbqvKgnS2C8DlhGuboGThTnRBWQLtdEgc9yGQQlG/NY=
X-Received: by 2002:aa7:c957:0:b0:52f:b00a:99be with SMTP id
 h23-20020aa7c957000000b0052fb00a99bemr15114014edt.33.1700239634965; Fri, 17
 Nov 2023 08:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-10-eddyz87@gmail.com>
In-Reply-To: <20231116021803.9982-10-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 11:47:03 -0500
Message-ID: <CAEf4BzZ+rMakBnBKnqOCsxM4XqSfraaqaEE1wdfrhAwLOP1x6A@mail.gmail.com>
Subject: Re: [PATCH bpf 09/12] selftests/bpf: test widening for iterating callbacks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> A test case to verify that imprecise scalars widening is applied to
> callback bodies on repetative iteration.

typo: repetitive? repeating? successive? subsequent?

>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../bpf/progs/verifier_iterating_callbacks.c  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbac=
ks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> index fa9429f77a81..598c1e984b26 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> @@ -25,6 +25,7 @@ struct buf_context {
>
>  struct num_context {
>         __u64 i;
> +       __u64 j;
>  };
>
>  __u8 choice_arr[2] =3D { 0, 1 };
> @@ -69,6 +70,25 @@ int unsafe_on_zero_iter(void *unused)
>         return choice_arr[loop_ctx.i];
>  }
>
> +static int widening_cb(__u32 idx, struct num_context *ctx)
> +{
> +       ++ctx->i;
> +       return 0;
> +}
> +
> +SEC("?raw_tp")
> +__success
> +int widening(void *unused)
> +{
> +       struct num_context loop_ctx =3D { .i =3D 0, .j =3D 1 };
> +
> +       bpf_loop(100, widening_cb, &loop_ctx, 0);
> +       /* loop_ctx.j is not changed during callback iteration,
> +        * verifier should not apply widening to it.
> +        */
> +       return choice_arr[loop_ctx.j];

would the test be a bit more interesting if you use loop_ctx.i here?
`return choice_arr[loop_ctx.i & 1];` ?



> +}
> +
>  static int loop_detection_cb(__u32 idx, struct num_context *ctx)
>  {
>         for (;;) {}
> --
> 2.42.0
>

