Return-Path: <bpf+bounces-14795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB207E8307
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 20:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695871F20F29
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814FA3AC1E;
	Fri, 10 Nov 2023 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBehu542"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C818E09
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 19:46:01 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97FD4C03
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 11:45:56 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9d2d8343dc4so401075166b.0
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699645555; x=1700250355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXUfuyheQWgRx0ueN78mTwBQ95UTPLt/Tl2SnMtYTnA=;
        b=UBehu542iiT5OVrlDbO2BWL+DnnbTRykkhYnJxJyMLAZIL554eV1pXb372Ct2LYY/N
         0Qy1uXwstmdb+5bgzjW94FktupmT07ESsZI6NIpC3W8qQohAXUk3Vh2zZz9lOBKhez5T
         Alx24sTdf52gwLsvEvCY0WrlNBqKTEXEoayyabmHvEbq5v52s7DU2GtpJJFjpWtCktwr
         w37sUq9660w4DJHtwi0WBvnOnx2fxCde7tOle33fxNN6OEjaJtH9URcDVFHHmxCAmzt2
         M3AU1MEAiLW+I+Z+jHV7wa5gkv2Ps9Q6TnBr5GNwmdEW0wMUkLjGNANKvkI90ozPpBjK
         RbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699645555; x=1700250355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXUfuyheQWgRx0ueN78mTwBQ95UTPLt/Tl2SnMtYTnA=;
        b=is0H0oyaznI9+MBeQST8ugobvwHLV2RrPVW9SgAgvzpeluL4VMqxe4sUgOtINjnKPZ
         3GUDku761sw3PYMstb1BMnQBGPSoKuaOXRaQzB39VfbN29Lud3pVhOMuX6DJIjQ8yrrj
         OG4koyZCBSNb1TrHhXCdcE6ygATcSnSNqGIfM/LltRdU0x++2eUri/0hay/o0yUK+gNt
         Gl8DFN32r7TbVs0VzUMLj2s98qblrDioddFwoce/jBj+LLsfbkME71haYD0eeRdG1a+B
         h8bu42GZhFNF3Zknh8FcszXK2cA1vBJBNB148WgdmnH9Br1sPrUS70qdQcjDSTzX3ZOE
         iYEg==
X-Gm-Message-State: AOJu0YznXSPJFwgaLoXaMOJSMpBOJHe0m7sRM/ENs9EPdoTTUfgzW/uQ
	jIfRrN1ZKrw5qr7t7/irEuM0y7Ecb5fdlqhqLLY=
X-Google-Smtp-Source: AGHT+IHgb/lu34IcCttSY6UC2B7tFjZMZHcyt7EBAR6IXVa0jvoV6gr7ZfIdr5P7RI6zs2jR8bso5NRvNHd9oSYoWG0=
X-Received: by 2002:a17:906:2515:b0:9a5:9038:b1e7 with SMTP id
 i21-20020a170906251500b009a59038b1e7mr7094ejb.36.1699645554878; Fri, 10 Nov
 2023 11:45:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110193644.3130906-1-yonghong.song@linux.dev>
In-Reply-To: <20231110193644.3130906-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Nov 2023 11:45:43 -0800
Message-ID: <CAEf4BzbAfXiqWCp4yZHqtxsQqje7kuRVODatG4E_a4_zqAK5CQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix pyperf180 compilation
 failure with clang18
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 11:37=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> With latest clang18 (main branch of llvm-project repo), when building bpf=
 selftests,
>     [~/work/bpf-next (master)]$ make -C tools/testing/selftests/bpf LLVM=
=3D1 -j
>
> The following compilation error happens:
>     fatal error: error in backend: Branch target out of insn range
>     ...
>     Stack dump:
>     0.      Program arguments: clang -g -Wall -Werror -D__TARGET_ARCH_x86=
 -mlittle-endian
>       -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include
>       -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/w=
ork/bpf-next/tools/include/uapi
>       -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include -idir=
after
>       /home/yhs/work/llvm-project/llvm/build.18/install/lib/clang/18/incl=
ude -idirafter /usr/local/include
>       -idirafter /usr/include -Wno-compare-distinct-pointer-types -DENABL=
E_ATOMICS_TESTS -O2 --target=3Dbpf
>       -c progs/pyperf180.c -mcpu=3Dv3 -o /home/yhs/work/bpf-next/tools/te=
sting/selftests/bpf/pyperf180.bpf.o
>     1.      <eof> parser at end of file
>     2.      Code generation
>     ...
>
> The compilation failure only happens to cpu=3Dv2 and cpu=3Dv3. cpu=3Dv4 i=
s okay
> since cpu=3Dv4 supports 32-bit branch target offset.
>
> The above failure is due to upstream llvm patch [1] where some inlining b=
ehavior
> are changed in clang18.
>
> To workaround the issue, previously all 180 loop iterations are fully unr=
olled.
> The bpf macro __BPF_CPU_VERSION__ (implemented in clang18 recently) is us=
ed to avoid
> unrolling changes if cpu=3Dv4. If __BPF_CPU_VERSION__ is not available an=
d the
> compiler is clang18, the unrollng amount is unconditionally reduced.
>
>   [1] https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c=
607313a566eebb16e
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/progs/pyperf180.c | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/pyperf180.c b/tools/testin=
g/selftests/bpf/progs/pyperf180.c
> index c39f559d3100..42c4a8b62e36 100644
> --- a/tools/testing/selftests/bpf/progs/pyperf180.c
> +++ b/tools/testing/selftests/bpf/progs/pyperf180.c
> @@ -1,4 +1,26 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2019 Facebook
>  #define STACK_MAX_LEN 180
> +
> +/* llvm upstream commit at clang18
> + *   https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c=
607313a566eebb16e
> + * changed inlining behavior and caused compilation failure as some bran=
ch
> + * target distance exceeded 16bit representation which is the maximum fo=
r
> + * cpu v1/v2/v3. Macro __BPF_CPU_VERSION__ is later implemented in clang=
18
> + * to specify which cpu version is used for compilation. So a smaller
> + * unroll_count can be set if __BPF_CPU_VERSION__ is less than 4, which
> + * reduced some branch target distances and resolved the compilation fai=
lure.
> + *
> + * To capture the case where a developer/ci uses clang18 but the corresp=
onding
> + * repo checkpoint does not have __BPF_CPU_VERSION__, a smaller unroll_c=
ount
> + * will be set as well to prevent potential compilation failures.
> + */
> +#ifdef __BPF_CPU_VERSION__
> +#if __BPF_CPU_VERSION__ < 4
> +#define UNROLL_COUNT 90
> +#endif
> +#elif __clang_major__ =3D=3D 18
> +#define UNROLL_COUNT 90
> +#endif
> +

can it be written as one if?

#if (defined(__BPF_CPU_VERSION__) && __BPF_CPU_VERSION__ < 4) ||
__clang_major >=3D 18


?

>  #include "pyperf.h"
> --
> 2.34.1
>
>

