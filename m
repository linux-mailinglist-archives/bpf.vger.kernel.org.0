Return-Path: <bpf+bounces-13612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 497347DBBE7
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 15:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9021C20AB2
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE15217990;
	Mon, 30 Oct 2023 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJsmxQBZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E2A168AA
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 14:36:25 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD22EA
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 07:36:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso433953766b.1
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698676582; x=1699281382; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hdp8a16yVP/eFeva5pD/g3n6pmkUiO1VdpC+VJFItaU=;
        b=HJsmxQBZAgPOcyagdOcQM2UZR4NlG3SYsdlquq78PUKTw3k4YVt37iRYYf92DG5hjy
         JQIQV3R5W7+nrC9+2v9bQB+YrQzzPsBntFJmKQjiuDPIsKdVR0b/58vE/6hbneUAJNTS
         ekKdnVAGQMAPLKF5icLALH8VHbFpadVN32SUXMZwyHit8elwjz+7dXvvIA+pbZdpaUg0
         HNy5gxazP6y09oq65EFodOr0FhgMDlxAlcO9c1GLkLJFa8QGP+9lV8pqh1eIMqwOrV/d
         bgWAhzv4p2HdRxZTBiw8QMJLYy7vGBXw6aOOsHZtbgcyvH+7v4ZWZ/vKl+eTdEW1jZxV
         Cpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676582; x=1699281382;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hdp8a16yVP/eFeva5pD/g3n6pmkUiO1VdpC+VJFItaU=;
        b=FWTLe0PiIZgRSFyEWxzaLIxbLPi+ymuA38lobWkoVqv/z4YTYMg9Jln0wFqSsqkynQ
         8oq6JOjhtMYQctoTzj46hfQf5rPuN6RyK3J3q2rjLf0wm2gnvfoeeUy3oaAsCIc2MtTS
         Zy+EogulM+5c4pfkvhmKtz4poRw5ckak3Y2jlx51BpdJ58di15XLiEfQriL+AIW7jMG3
         USu36vpS2hYpPOoIRNSmTCvNE0/7ZUlRr02jsQB/THFdJOpplWPjRjGml3zPPmNaozhL
         w9OrytrZVmR5d7VCrhQehwPkEnU/xlyMNps0MAga2O534vFj+equmJpsecIUTWwccjih
         /eUA==
X-Gm-Message-State: AOJu0YyaOjY7p/OfspS7rexivIXQQTdqo4l0lTfCrPso/cmtIEL7rcyH
	cewVZhwNBqQUlBKutnQQUok=
X-Google-Smtp-Source: AGHT+IHqdStRXx2hnmsnVXGSP9UQfq0oFMdWWtR29bvjSKn0Nz3+65n5m9nX1OQ7dAGHnQMRtSghTA==
X-Received: by 2002:a17:906:48c3:b0:9d4:84b6:8709 with SMTP id d3-20020a17090648c300b009d484b68709mr1176079ejt.58.1698676581679;
        Mon, 30 Oct 2023 07:36:21 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id jt21-20020a170906dfd500b0099bd1ce18fesm6158914ejc.10.2023.10.30.07.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:36:20 -0700 (PDT)
Message-ID: <905f4ae9a5d9fe1a030d7e7442e980e9d49e00b9.camel@gmail.com>
Subject: Re: [RFC bpf 2/2] selftests/bpf: precision tracking test for
 BPF_ALU | BPF_TO_BE | BPF_END
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andriin@fb.com>,  Alexei Starovoitov <ast@kernel.org>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,  John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>
Date: Mon, 30 Oct 2023 16:36:19 +0200
In-Reply-To: <20231030132145.20867-3-shung-hsi.yu@suse.com>
References: <20231030132145.20867-1-shung-hsi.yu@suse.com>
	 <20231030132145.20867-3-shung-hsi.yu@suse.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-30 at 21:21 +0800, Shung-Hsi Yu wrote:
> Add a test written with inline assembly to check that the verifier does
> not incorrecly use the src_reg field of a BPF_ALU | BPF_TO_BE | BPF_END
> instruction.
>=20
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>=20
> This is the first time I'm writing a selftest so there's a lot of
> question I can't answer myself. Looking for suggestions regarding:
>=20
> 1. Whether BPF_NEG and other BPF_END cases should be tested as well

It is probably good to test BPF_NEG, unfortunately verifier does not
track range information for BPF_NEG, so I ended up with the following
contraption:

SEC("?raw_tp")
__success __log_level(2)
__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 3: (bf) r1 =3D r10")
__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 2: (55) if r2 !=3D 0=
xfffffff8 goto pc+2")
__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 1: (87) r2 =3D -r2")
__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 0: (b7) r2 =3D 8")
__naked int bpf_neg(void)
{
	asm volatile (
		"r2 =3D 8;"
		"r2 =3D -r2;"
		"if r2 !=3D -8 goto 1f;"
		"r1 =3D r10;"
		"r1 +=3D r2;"
	"1:"
		"r0 =3D 0;"
		"exit;"
		::: __clobber_all);
}

Also, maybe it's good to test bswap version of BPF_END (CPU v4
instruction) for completeness, e.g. as follows:

#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
	(defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && \
	__clang_major__ >=3D 18

...
		"r2 =3D bswap16 r2;"
...

#endif


> 2. While the suggested way of writing BPF assembly is with inline
>    assembly[0], as done here, maybe it is better to have this test case
>    added in verifier/precise.c and written using macro instead?
>    The rational is that ideally we want the selftest to be backport to
>    the v5.3+ stable kernels alongside the fix, but __msg macro used here
>    is only available since v6.2.

As far as I understand we want to have new tests written in assembly,
but let's wait for Alexei or Andrii to comment.

>=20
> 0: https://lore.kernel.org/bpf/CAADnVQJHAPid9HouwMEnfwDDKuy8BnGia269KSbby=
2gA030OBg@mail.gmail.com/
>=20
>  .../selftests/bpf/prog_tests/verifier.c       |  2 ++
>  .../selftests/bpf/progs/verifier_precision.c  | 29 +++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_precision.=
c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index e3e68c97b40c..e5c61aa6604a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -46,6 +46,7 @@
>  #include "verifier_movsx.skel.h"
>  #include "verifier_netfilter_ctx.skel.h"
>  #include "verifier_netfilter_retcode.skel.h"
> +#include "verifier_precision.skel.h"
>  #include "verifier_prevent_map_lookup.skel.h"
>  #include "verifier_raw_stack.skel.h"
>  #include "verifier_raw_tp_writable.skel.h"
> @@ -153,6 +154,7 @@ void test_verifier_meta_access(void)          { RUN(v=
erifier_meta_access); }
>  void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
>  void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_c=
tx); }
>  void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_r=
etcode); }
> +void test_verifier_precision(void)            { RUN(verifier_precision);=
 }
>  void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map=
_lookup); }
>  void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack);=
 }
>  void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writ=
able); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/too=
ls/testing/selftests/bpf/progs/verifier_precision.c
> new file mode 100644
> index 000000000000..9236994387bf
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023 SUSE LLC */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +int vals[] SEC(".data.vals") =3D {1, 2, 3, 4};
> +
> +SEC("?raw_tp")
> +__success __log_level(2)
> +__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 5: (bf) r1 =3D r6=
")
> +__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 4: (57) r2 &=3D 3=
")
> +__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 3: (dc) r2 =3D be=
16 r2")
> +__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 2: (b7) r2 =3D 0"=
)
> +__naked int bpf_end(void)
> +{
> +	asm volatile (
> +		"r2 =3D 0;"
> +		"r2 =3D be16 r2;"
> +		"r2 &=3D 0x3;"
> +		"r1 =3D %[vals];"
> +		"r1 +=3D r2;"
> +		"r0 =3D *(u32 *)(r1 + 0);"
> +		"exit;"
> +		:
> +		: __imm_ptr(vals)
> +		: __clobber_common);
> +}

Note: there are a simpler ways to force r2 precise, e.g. add it to r10:

SEC("?raw_tp")
__success __log_level(2)
__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 2: (57) r2 &=3D 3")
__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 1: (dc) r2 =3D be16 =
r2")
__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 0: (b7) r2 =3D 0")
__naked int bpf_end(void)
{
	asm volatile (
		"r2 =3D 0;"
		"r2 =3D be16 r2;"
		"r2 &=3D 0x3;"
		"r1 =3D r10;"
		"r1 +=3D r2;"
		"r0 =3D 0;"
		"exit;"
		::: __clobber_all);
}

