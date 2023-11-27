Return-Path: <bpf+bounces-15961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5367FA93D
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 404B6B21083
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 18:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E80358BB;
	Mon, 27 Nov 2023 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGHmdEGV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8411A1
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 10:49:54 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a00cbb83c80so634396866b.0
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 10:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701110993; x=1701715793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC1/1Ly7dYLfGmB8PqMUwU+jBCCIQ+KSicEDDatCNdE=;
        b=YGHmdEGVrUDqCYX9Qf/T0RUpFlGdV22p1BBUUzM1L3CPaFgjYxstaHRQRTNCmOBNQ/
         /Wy+bIDh3j/c5ucK7H3kU3ORrqo4cgPpANKWvm4uPV6k67jqf7CRYeNHlA3doiiiq/+V
         rw9m3HhsrjTuSFA3RT77sGbVMA6UAT5NpuQ1Ms+gVSXbT7pEaIQF9EDaY0eZ3eibnUjQ
         SgOxJjyveY5KPDCu2OgiFDj9DwHWBRFLxcV/Fb7MgKaI1jTZ5Jiu1ZeIWVu53P0mDlNR
         vAVSYKr0j9co+Iz95FZ686PEY2vnqMW02MxuL4vBCAIM2sdMhXQqkcj1mJWG8UV4Mu8w
         iw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701110993; x=1701715793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PC1/1Ly7dYLfGmB8PqMUwU+jBCCIQ+KSicEDDatCNdE=;
        b=o5UCPCY1zNu/np8hgkHutnNuUNtLE7ev8Kgr306TefpJkV52N3MrYnlyESPoo4Md85
         ssuhhthKVHxfpfVMowQdyUXpcawVrkmb8BBb3vDfPL5AR1Sbn7tWmWdBbO09vN6pH1Fz
         6n8EYWzDStJsn7qJPHVS5+jdnHAJ1leeNOlhZ0QBSFJ4FlIw7b+DY5DAqXsYFwQbNM+m
         FGdXDCXXlgo0O20j+ZfJmln6kfh9FqQqVcXL3+OjcA+6o75D94aoLjg2VwBrbaAM5/dM
         RYmLiXfF8UT3cnZyHrL+iNuambY5w3YRbSs49Gb8wsG0gomPcpSE7rnXESNhzN2o7vG6
         t1Eg==
X-Gm-Message-State: AOJu0YzgShgbsJ1azLYSpXN7BbpqtWPt3CEIfoxuRghgqfVMHkI6yIMt
	68ghqP+RVACnuZO96ePkgEXzMMWcqggjOm1mK5ngMZ4kNDw=
X-Google-Smtp-Source: AGHT+IF4hqMvXyAl1ImHhcFPoz7dqVW/Vy8PqYeY6WUD4X6yfMzadvlJ4NyhPzxZLggBDvAICcIO6pwCw5YXla3CIhE=
X-Received: by 2002:a17:906:10dc:b0:9be:7b67:1674 with SMTP id
 v28-20020a17090610dc00b009be7b671674mr9723778ejv.3.1701110993041; Mon, 27 Nov
 2023 10:49:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127050342.1945270-1-yonghong.song@linux.dev>
In-Reply-To: <20231127050342.1945270-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Nov 2023 10:49:41 -0800
Message-ID: <CAEf4BzZYydzYLCyPYxsUQ1OhMnnHw7f+mmErzNQFXubZCj8t9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix a few selftest failures due to llvm18 change
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 9:04=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> With latest upstream llvm18, the following test cases failed:
>   $ ./test_progs -j
>   #13/2    bpf_cookie/multi_kprobe_link_api:FAIL
>   #13/3    bpf_cookie/multi_kprobe_attach_api:FAIL
>   #13      bpf_cookie:FAIL
>   #77      fentry_fexit:FAIL
>   #78/1    fentry_test/fentry:FAIL
>   #78      fentry_test:FAIL
>   #82/1    fexit_test/fexit:FAIL
>   #82      fexit_test:FAIL
>   #112/1   kprobe_multi_test/skel_api:FAIL
>   #112/2   kprobe_multi_test/link_api_addrs:FAIL
>   ...
>   #112     kprobe_multi_test:FAIL
>   #356/17  test_global_funcs/global_func17:FAIL
>   #356     test_global_funcs:FAIL
>
> Further analysis shows llvm upstream patch [1] is responsible
> for the above failures. For example, for function bpf_fentry_test7()
> in net/bpf/test_run.c, without [1], the asm code is:
>   0000000000000400 <bpf_fentry_test7>:
>      400: f3 0f 1e fa                   endbr64
>      404: e8 00 00 00 00                callq   0x409 <bpf_fentry_test7+0=
x9>
>      409: 48 89 f8                      movq    %rdi, %rax
>      40c: c3                            retq
>      40d: 0f 1f 00                      nopl    (%rax)
> and with [1], the asm code is:
>   0000000000005d20 <bpf_fentry_test7.specialized.1>:
>     5d20: e8 00 00 00 00                callq   0x5d25 <bpf_fentry_test7.=
specialized.1+0x5>
>     5d25: c3                            retq
> and <bpf_fentry_test7.specialized.1> is called instead of <bpf_fentry_tes=
t7>
> and this caused test failures for #13/#77 etc. except #356.
>
> For test case #356/17, with [1] (progs/test_global_func17.c)),
> the main prog looks like:
>   0000000000000000 <global_func17>:
>        0:       b4 00 00 00 2a 00 00 00 w0 =3D 0x2a
>        1:       95 00 00 00 00 00 00 00 exit
> which passed verification while the test itself expects a verification
> failure.
>
> Let us add 'barrier_var' style asm code in both places to prevent
> function specialization which caused selftests failure.
>
>   [1] https://github.com/llvm/llvm-project/pull/72903
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  net/bpf/test_run.c                                     | 2 +-
>  tools/testing/selftests/bpf/progs/test_global_func17.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index c9fdcc5cdce1..711cf5d59816 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -542,7 +542,7 @@ struct bpf_fentry_test_t {
>
>  int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
>  {
> -       asm volatile ("");
> +       asm volatile ("": "+r"(arg));
>         return (long)arg;
>  }
>
> diff --git a/tools/testing/selftests/bpf/progs/test_global_func17.c b/too=
ls/testing/selftests/bpf/progs/test_global_func17.c
> index a32e11c7d933..5de44b09e8ec 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_func17.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_func17.c
> @@ -5,6 +5,7 @@
>
>  __noinline int foo(int *p)
>  {
> +       barrier_var(p);
>         return p ? (*p =3D 42) : 0;
>  }
>

I recently stumbled upon no_clone ([0]) and no_ipa ([1]) attributes.
Should we consider using those here instead?

  [0] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#in=
dex-noclone-function-attribute
  [1] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#in=
dex-noipa-function-attribute


> --
> 2.34.1
>

