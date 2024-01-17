Return-Path: <bpf+bounces-19695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3338582FDEC
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 01:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A01DB24735
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 00:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5F6B658;
	Wed, 17 Jan 2024 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krvYK7ff"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5DEB641;
	Wed, 17 Jan 2024 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705450433; cv=none; b=NzptPl7kHeqxYjjdxLVjIlsVV5sr+Xxc6c88z08yFhYr1Jn90jjSFNq9UjIEvh/vFxJqCpUydpjWOZX2uQ90euUKLEsiOKd46/N3uGT4Ul3LHnPUpqo8tjcoB6kRtQAgPsspBIfDvlqe1eGYMIwmae0r3A8zC4vzwftoce1ooCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705450433; c=relaxed/simple;
	bh=5CVURg/J2C6H0SpmncMW/CibZZprIM+ga7TBw6/ZchA=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=aapg8kZSbwAJkMMBJQs4jV6m+9apm3tvp0XIQy9rMoOa0TxAYsRl3T1vD5RWdUnwklSGALiyJ7WJrer5y3H3+hELKi3KNy3ZqmszGrw44DzV92pB8o4YHHz9dIrZGDCbMJeVa7Xd+pcDR/058kgh3MF4RAx1YHDmj15yIy1heZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krvYK7ff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBA1C433F1;
	Wed, 17 Jan 2024 00:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705450432;
	bh=5CVURg/J2C6H0SpmncMW/CibZZprIM+ga7TBw6/ZchA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=krvYK7ffpvuszS9RcCWlPopKbIqvCfzTtEPVBrtaxDIVzrt8UxO0H1KN3JW0mkmAa
	 H5+W/GrYcF0C5xMbNKA4OAJHrdOa0/+XtCibf53bRv5ZCdxk2qfFnwOGQ/2FaJ80iO
	 LhTnZ6Vi0muBl7CFLjtiemST4EEoUM5VD07FGXM1noZlsBOuWcr+wdC5qs9pMQyDJI
	 8rNZQ1cDNV1G06t/QGwp9Bm2nt4U2Pkm2ERVMtn97YopaGzv9zleCZHnAXo781Pzza
	 2qGeI0e4Tq3ZT1i7Yg5sUI1iINQxyeOJxkXNNhRp9mBsR3Xpc7167JBf+XV/iqXpuK
	 0MctILsTLh7kA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e7b273352so11616067e87.1;
        Tue, 16 Jan 2024 16:13:52 -0800 (PST)
X-Gm-Message-State: AOJu0Yw2QpHAfbpHx1PjxiYUAx1rNCVAai1wMMQDr1j8xRsBJ4CmwoIY
	Vc6rZVatxM0nkxfnW2GT64gPbwB1RBLFZtdM6es=
X-Google-Smtp-Source: AGHT+IEAUMngWaz7FuzJD6IiJp8bUfU+S+QgLVCWNNvFVUC2pD+H2SocC2P9Lj9BY+ok+gCczxCxPwGLSempU1zGSII=
X-Received: by 2002:a05:6512:950:b0:50e:d514:77bd with SMTP id
 u16-20020a056512095000b0050ed51477bdmr1971068lft.18.1705450431071; Tue, 16
 Jan 2024 16:13:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116045030.23739-1-yangtiezhu@loongson.cn> <20240116045030.23739-3-yangtiezhu@loongson.cn>
In-Reply-To: <20240116045030.23739-3-yangtiezhu@loongson.cn>
From: Song Liu <song@kernel.org>
Date: Tue, 16 Jan 2024 16:13:39 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6oojz09GNxD92AY_32GN5YD2YZZtTzMT4MENs9q6mKdA@mail.gmail.com>
Message-ID: <CAPhsuW6oojz09GNxD92AY_32GN5YD2YZZtTzMT4MENs9q6mKdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Skip callback tests if jit
 is disabled in test_verifier
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 8:50=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> If CONFIG_BPF_JIT_ALWAYS_ON is not set and bpf_jit_enable is 0, there
> exist 6 failed tests.
>
>   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>   [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
>   [root@linux bpf]# ./test_verifier | grep FAIL
>   #106/p inline simple bpf_loop call FAIL
>   #107/p don't inline bpf_loop call, flags non-zero FAIL
>   #108/p don't inline bpf_loop call, callback non-constant FAIL
>   #109/p bpf_loop_inline and a dead func FAIL
>   #110/p bpf_loop_inline stack locations for loop vars FAIL
>   #111/p inline bpf_loop call in a big program FAIL
>   Summary: 768 PASSED, 15 SKIPPED, 6 FAILED
>
> The test log shows that callbacks are not allowed in non-JITed programs,
> interpreter doesn't support them yet, thus these tests should be skipped
> if jit is disabled, copy some check functions from the other places under
> tools directory, and then handle this case in do_test_single().
>
> With this patch:
>
>   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>   [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
>   [root@linux bpf]# ./test_verifier | grep FAIL
>   Summary: 768 PASSED, 21 SKIPPED, 0 FAILED
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/bpf/test_verifier.c | 23 +++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
> index 1a09fc34d093..02c4a0bbdc5e 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -74,6 +74,7 @@
>                     1ULL << CAP_BPF)
>  #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
>  static bool unpriv_disabled =3D false;
> +static bool jit_disabled;
>  static int skips;
>  static bool verbose =3D false;
>  static int verif_log_level =3D 0;
> @@ -1355,6 +1356,16 @@ static bool is_skip_insn(struct bpf_insn *insn)
>         return memcmp(insn, &skip_insn, sizeof(skip_insn)) =3D=3D 0;
>  }
>
> +static bool is_ldimm64_insn(struct bpf_insn *insn)
> +{
> +       return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
> +}
> +
> +static bool insn_is_pseudo_func(struct bpf_insn *insn)
> +{
> +       return is_ldimm64_insn(insn) && insn->src_reg =3D=3D BPF_PSEUDO_F=
UNC;
> +}
> +

These two functions are duplicated from libbpf_internal.h and libbpf.c.
It will be good to reuse them. We will need something like the following
to include libbpf_internal.h and fix "poisoned" errors.

Thanks,
Song

diff --git i/tools/testing/selftests/bpf/test_verifier.c
w/tools/testing/selftests/bpf/test_verifier.c
index 98107e0452d3..7528a6b41623 100644
--- i/tools/testing/selftests/bpf/test_verifier.c
+++ w/tools/testing/selftests/bpf/test_verifier.c
@@ -41,6 +41,7 @@
 #include "test_btf.h"
 #include "../../../include/linux/filter.h"
 #include "testing_helpers.h"
+#include "bpf/libbpf_internal.h"

 #ifndef ENOTSUPP
 #define ENOTSUPP 524
@@ -1143,8 +1144,8 @@ static void do_test_fixup(struct bpf_test *test,
enum bpf_prog_type prog_type,
                } while (*fixup_map_xskmap);
        }
        if (*fixup_map_stacktrace) {
-               map_fds[12] =3D create_map(BPF_MAP_TYPE_STACK_TRACE, sizeof=
(u32),
-                                        sizeof(u64), 1);
+               map_fds[12] =3D create_map(BPF_MAP_TYPE_STACK_TRACE,
sizeof(__u32),
+                                        sizeof(__u64), 1);
                do {
                        prog[*fixup_map_stacktrace].imm =3D map_fds[12];
                        fixup_map_stacktrace++;
@@ -1203,7 +1204,7 @@ static void do_test_fixup(struct bpf_test *test,
enum bpf_prog_type prog_type,
        }
        if (*fixup_map_reuseport_array) {
                map_fds[19] =3D __create_map(BPF_MAP_TYPE_REUSEPORT_SOCKARR=
AY,
-                                          sizeof(u32), sizeof(u64), 1, 0);
+                                          sizeof(__u32), sizeof(__u64), 1,=
 0);
                do {
                        prog[*fixup_map_reuseport_array].imm =3D map_fds[19=
];
                        fixup_map_reuseport_array++;

