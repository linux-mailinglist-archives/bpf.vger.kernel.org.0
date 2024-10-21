Return-Path: <bpf+bounces-42708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCAD9A942B
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 01:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124CF1F217DE
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 23:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E911FF5E3;
	Mon, 21 Oct 2024 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHnrkhqa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283D31E3766;
	Mon, 21 Oct 2024 23:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553342; cv=none; b=UNu707iSgTnL+Lijpil9+ciz5wLi/n/AD8UuDRWSHNfNximYpWhJ1iCaI21Z0BK0/1HZqQvnTutiXhk95h1/5Zd5VSz2+lzuq+CaGGT2pYQgtmHGDErdJ3OFbIUY8A5UMv84Sgo0zloc7N+jGlrGmX9UQSLjgG+tujb+dndlCiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553342; c=relaxed/simple;
	bh=x2H3ahgB5xIvSFbzpAzCQsUV4OlJPhvj2R6p1tI+K3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3P+gpF4s4MAHw7K6KPHEWFB32ruagV8b148R/yQ8vqOQ3sLXMfunV8CTTgLNUG4PDFGK60b287J+ZX9LWdJgCLjmbieOey8k1EE07lWXgciNWzAr3WXH75AyAfgiRC7csKAeSjQFQZm24gDhx9wANmxBnOpyHilNiavIrJZ/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHnrkhqa; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e57d89ffaso3887027b3a.1;
        Mon, 21 Oct 2024 16:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729553340; x=1730158140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0ab/y3NIxWQ5IPwf4tlrWjgA/VWZRdS/usp1PdmtaA=;
        b=iHnrkhqap5K634mmOogO0j3ONfofIj8H1Zg6CY7vmc35bA5Q5FmfDB7OlT3BwC5dx0
         yYvExBpIE5OWte4BY0BwHL4DxIU2JcQX6CnMQygmW1QJAv+zC83xakHDlovIioKO0+ol
         XwDodasG7zJbRBP7a3EO0/UC7ChV9aXLFm/Q/ksIX+EADzxCwEZAvT14m9WrNiTpJHPJ
         lu6/MkPQJv8QwpKjHpcKpt1Sfu2e0zST4gxsXJTLxE/xB4TwlqLBd5cXUNsP+kgggf1t
         958jFLmoKKdOUuVfWJHMKXVCuL3Wck5xaR1K9wV3ySs+ejeVhDy/TQ7zwYdt3Z+29jnT
         oUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729553340; x=1730158140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0ab/y3NIxWQ5IPwf4tlrWjgA/VWZRdS/usp1PdmtaA=;
        b=VLG1pjUbMBVaX1Akq7Hp/Y5wz4V7UcDCpIZ119jpfgE2ZdxPnHvFojtfumEP4kIbGH
         cUQDzreyYkvnisT8BWoYgWzp4d9kB+Lye3TiZ+LaaYi0kbG4u/HoRsrcH3X7NWyfjgvR
         lH/4ECIwWD5vIgQDsHAVB4J9oougHEA97Sqpz6pgk/q5QVsioe50H0I6XH6l01Xis3xZ
         j7Lf0eFhKxyrCqATG0c88G+1r1R9SV0nSmQXRF3nzDV1ospz6Ao4dSwLrRl19w0Je1Pj
         CcqwRdk8Hzhywp2k289sIhw9fWHVoLVDoU95QxWncs7NUfoJe/L3b4sRLL0unG7SlNx5
         FJMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYZGOHTsIkyMkc/Ht40QHVeXmMPrWXBcK5TGbRcXcf3zmMuTUyXcf7tAkfzkG3UvM3eCYpSiks+BjaLlKO@vger.kernel.org, AJvYcCVxvZ/8cLLLru0tHcs52qHUKO/ppxGI/eIbr2CJLGwhj3o5kzNAFS+H0XZVwfqjjpGd9eg=@vger.kernel.org, AJvYcCWuM8s4qDk+ZLfJO7dIX8zkxxyk7MqX/G5bEoHArLlRklQeRqFA5gS5iQQwD4MesL94faWVkD5a@vger.kernel.org, AJvYcCX6fk1U/ZPewCJ7rlevci7cEhSnJtfwLAjvEfHyIhtzqzJHJPnfyeoe+RVqAdJ/onRLqTdlbjdZ651hkdPV@vger.kernel.org
X-Gm-Message-State: AOJu0YxhPVSX6MiEBBrOcAWtvywYj/2UmTa9wGfJMfmpMLCWQ62qP6iU
	c7nppeMrm/4GBJP/uWagxUqwfrIGyjFZYOR6c7RqPyNdXK1yarc5FqYr64CyAQQjN7p+4WSic0H
	LQMTcstJWsfLPuWuATyaSwKdIBQc=
X-Google-Smtp-Source: AGHT+IE+UiBdod8YrP4CWXmEaQOA8OoWyHHG8IWleRCcBhZxXsjPZXGjvcba7orZTZIub5J+BX3UYq9GPtRAU8ZvLAE=
X-Received: by 2002:a05:6a00:9282:b0:71e:587d:f268 with SMTP id
 d2e1a72fcca58-71edbbc153bmr2117649b3a.4.1729553340212; Mon, 21 Oct 2024
 16:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021122112.101513-1-puranjay@kernel.org> <20241021122112.101513-5-puranjay@kernel.org>
In-Reply-To: <20241021122112.101513-5-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 16:28:47 -0700
Message-ID: <CAEf4BzY1LgCF1VOoAQkMdDTx87C0mfyftMvhvVU4GpsFc6fw5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Add benchmark for
 bpf_csum_diff() helper
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, 
	Helge Deller <deller@gmx.de>, Jakub Kicinski <kuba@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Mykola Lysenko <mykolal@fb.com>, netdev@vger.kernel.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paolo Abeni <pabeni@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 5:22=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Add a microbenchmark for bpf_csum_diff() helper. This benchmark works by
> filling a 4KB buffer with random data and calculating the internet
> checksum on different parts of this buffer using bpf_csum_diff().
>
> Example run using ./benchs/run_bench_csum_diff.sh on x86_64:
>
> [bpf]$ ./benchs/run_bench_csum_diff.sh
> 4                    2.296 =C2=B1 0.066M/s (drops 0.000 =C2=B1 0.000M/s)
> 8                    2.320 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)
> 16                   2.315 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> 20                   2.318 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> 32                   2.308 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)
> 40                   2.300 =C2=B1 0.029M/s (drops 0.000 =C2=B1 0.000M/s)
> 64                   2.286 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> 128                  2.250 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> 256                  2.173 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> 512                  2.023 =C2=B1 0.055M/s (drops 0.000 =C2=B1 0.000M/s)

you are not benchmarking bpf_csum_diff(), you are benchmarking how
often you can call bpf_prog_test_run(). Add some batching on the BPF
side, these numbers tell you that there is no difference between
calculating checksum for 4 bytes and for 512, that didn't seem strange
to you?

pw-bot: cr

>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile          |   2 +
>  tools/testing/selftests/bpf/bench.c           |   4 +
>  .../selftests/bpf/benchs/bench_csum_diff.c    | 164 ++++++++++++++++++
>  .../bpf/benchs/run_bench_csum_diff.sh         |  10 ++
>  .../selftests/bpf/progs/csum_diff_bench.c     |  25 +++
>  5 files changed, 205 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_csum_diff.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_csum_dif=
f.sh
>  create mode 100644 tools/testing/selftests/bpf/progs/csum_diff_bench.c
>

[...]

> +
> +static void csum_diff_setup(void)
> +{
> +       int err;
> +       char *buff;
> +       size_t i, sz;
> +
> +       sz =3D sizeof(ctx.skel->rodata->buff);
> +
> +       setup_libbpf();
> +
> +       ctx.skel =3D csum_diff_bench__open();
> +       if (!ctx.skel) {
> +               fprintf(stderr, "failed to open skeleton\n");
> +               exit(1);
> +       }
> +
> +       srandom(time(NULL));
> +       buff =3D ctx.skel->rodata->buff;
> +
> +       /*
> +        * Set first 8 bytes of buffer to 0xdeadbeefdeadbeef, this is lat=
er used to verify the
> +        * correctness of the helper by comparing the checksum result for=
 0xdeadbeefdeadbeef that
> +        * should be 0x3b3b
> +        */
> +
> +       *(u64 *)buff =3D 0xdeadbeefdeadbeef;
> +
> +       for (i =3D 8; i < sz; i++)
> +               buff[i] =3D '1' + random() % 9;

so, you only generate 9 different values for bytes, why? Why not full
byte range?

> +
> +       ctx.skel->rodata->buff_len =3D args.buff_len;
> +
> +       err =3D csum_diff_bench__load(ctx.skel);
> +       if (err) {
> +               fprintf(stderr, "failed to load skeleton\n");
> +               csum_diff_bench__destroy(ctx.skel);
> +               exit(1);
> +       }
> +}
> +

[...]

