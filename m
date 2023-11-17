Return-Path: <bpf+bounces-15241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB89A7EF685
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 17:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7781C20AF0
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA4C3C47F;
	Fri, 17 Nov 2023 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QegvGBqK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44B1A4
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:46:54 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54394328f65so3139426a12.3
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239613; x=1700844413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcLXbrzSpY1z7JPB3VLCq6ejAgXkaPH7HEfNqOlutPs=;
        b=QegvGBqKPZYCMZWURquJ1tKCQR1/lDRGzj9Q+JYS2iDKYOQmPLyh8a8slj3RfPp4RZ
         hC5EwDFqqKF+KufVhw7UobYNJAj42ZR5qtehGE2JVoFAokLiLQk/nkQFshGLNKs5H4q7
         KFQ4BsCxOM/llH6CpozL0Ng2iV5kMJDmEtx3Yru/b+TxUEUGx2DM6bDeQGszhwSwQsfY
         c0LWQ0mBW0zw1V0IagMOdDbMpZPTF8O+zowxTUucC17dA3MdMPqI5gIkHlF1MFHj5DYd
         SSBkOMZ8iap9nPLR5Op5LDqQ8+SG2w2KB+15Zixl4NMrgZz9hr9l6jgmFENAQf/FkBcv
         rhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239613; x=1700844413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcLXbrzSpY1z7JPB3VLCq6ejAgXkaPH7HEfNqOlutPs=;
        b=O4jh6j+F6Zi0JOkIlhfQ95RGxT9i9PupH/0mEzhAT+HbDPh1rQTw/eefk2/n3RE4my
         PbYcGMl3Sq7CyK0cb/GH33meoHvA0H3KmRqunlKZYwdm2vx6OU8quNilvHZfVlxyZNoW
         6wixnrtMMUtw3wgjOw+lyX0QONGJL/7jrtbbIJ6+wq4u+M3Wo0f1N+sdFtis7FOYOZAV
         pvCia+jrhhPKP692SbLYVd44eyeEvsr5bXJgNmQ0dX7Mbs/nzfEIqJll9j6mmYwDKVCh
         c0FG0uYQZedtSFiQhPuzm+xIbmndki79BuhE94G9l3xt+T9nH3FYd8B2aZKRLfYvO9II
         PjyA==
X-Gm-Message-State: AOJu0Yw+qcF1CrLSXpeYrFCI+ml4GBW0WFO/VL0RJ+lFr0C6YlivQd8S
	zx1PfpGEKvrhklqZcunefCSbyxi7YK8S8JL4uxg=
X-Google-Smtp-Source: AGHT+IGqEaPcAaO84+fZexttwrAN+YYT37PVzCoRaWeFw02Ldrtw5nlR+NxRiU6Ps7v/m4P1Bh7xf5awuhvPnjAHmlg=
X-Received: by 2002:a05:6402:1a36:b0:540:caed:3619 with SMTP id
 be22-20020a0564021a3600b00540caed3619mr14107327edb.24.1700239613180; Fri, 17
 Nov 2023 08:46:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-4-eddyz87@gmail.com>
In-Reply-To: <20231116021803.9982-4-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 11:46:42 -0500
Message-ID: <CAEf4Bza=+t8aS+mfaywe6ozkzYfo-DjH01qicfks4rsYCQs_Dw@mail.gmail.com>
Subject: Re: [PATCH bpf 03/12] selftests/bpf: fix bpf_loop_bench for new
 callback verification scheme
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> The patch a few patches from this one changes logic for callbacks
> handling. While previously callbacks were verified as a single
> function call, new scheme takes into account that callbacks could be
> executed unknown number of times.
>
> This has dire implications for bpf_loop_bench:
>
>     SEC("fentry/" SYS_PREFIX "sys_getpgid")
>     int benchmark(void *ctx)
>     {
>             for (int i =3D 0; i < 1000; i++) {
>                     bpf_loop(nr_loops, empty_callback, NULL, 0);
>                     __sync_add_and_fetch(&hits, nr_loops);
>             }
>             return 0;
>     }
>
> W/o callbacks change for verifier it merely represents 1000 calls to
> empty_callback(). However, with callbacks change things become
> exponential:
> - i=3D0: state exploring empty_callback is scheduled with i=3D0 (a);
> - i=3D1: state exploring empty_callback is scheduled with i=3D1;
>   ...
> - i=3D999: state exploring empty_callback is scheduled with i=3D999;
> - state (a) is popped from stack;
> - i=3D1: state exploring empty_callback is scheduled with i=3D1;
>   ...

would this still happen if you use an obfuscated zero initializer for i?

int zero =3D 0; /* global var */

...


for (i =3D zero; i < 1000; i++) {
     ...
}

>
> Avoid this issue by rewriting outer loop as bpf_loop().
> Unfortunately, this adds a function call to a loop at runtime, which
> negatively affects performance:
>
>             throughput               latency
>    before:  149.919 =C2=B1 0.168 M ops/s, 6.670 ns/op
>    after :  137.040 =C2=B1 0.187 M ops/s, 7.297 ns/op
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_loop_bench.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>

Either way, it doesn't seem like a big deal to me.

Acked-by: Andrii Nakryiko <andrii@kernel.org>



> diff --git a/tools/testing/selftests/bpf/progs/bpf_loop_bench.c b/tools/t=
esting/selftests/bpf/progs/bpf_loop_bench.c
> index 4ce76eb064c4..d461746fd3c1 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_loop_bench.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_loop_bench.c
> @@ -15,13 +15,16 @@ static int empty_callback(__u32 index, void *data)
>         return 0;
>  }
>
> +static int outer_loop(__u32 index, void *data)
> +{
> +       bpf_loop(nr_loops, empty_callback, NULL, 0);
> +       __sync_add_and_fetch(&hits, nr_loops);
> +       return 0;
> +}
> +
>  SEC("fentry/" SYS_PREFIX "sys_getpgid")
>  int benchmark(void *ctx)
>  {
> -       for (int i =3D 0; i < 1000; i++) {
> -               bpf_loop(nr_loops, empty_callback, NULL, 0);
> -
> -               __sync_add_and_fetch(&hits, nr_loops);
> -       }
> +       bpf_loop(1000, outer_loop, NULL, 0);
>         return 0;
>  }
> --
> 2.42.0
>

