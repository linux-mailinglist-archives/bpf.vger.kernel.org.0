Return-Path: <bpf+bounces-14635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF447E7369
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 22:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607AA1F20F3B
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 21:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035F2374DE;
	Thu,  9 Nov 2023 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIZz4dl4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512F24A17
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 21:09:57 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F547D54
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 13:09:57 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5094cb3a036so1702579e87.2
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 13:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699564195; x=1700168995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRyfqVKMjFpV8z0fL6kFt54MybPlj9VC5bM2icGskxw=;
        b=GIZz4dl4JHuqSKePMx8r/vN9oUw8+7HexjbHwJZL17j14QmFbA1KgLtc/DPUDOrsI5
         Tj94JX2lPtvTxG1beNHcWw2gC04fjG8udvLaBqruOLmlLU1Vhua4dTX2hrwyl9/zZgES
         eeXA4vZnzyRJxShE7mmmWWWMXjDcuq7H8XvdP0Wym91B48hwjqHseEjrsoDWn+NEEIMr
         so1c4est4fzZ9+6OkiXxNeyS/hizx3Vh3NBUvtVEj7ti5yBVb4I8IMqS71jMgHNPm0l5
         n1nftazHxiia/IX1ObDkXyuGqNY1OqC2S2ND0iCnops3j2BA/M16LkONT8kFOnqFsr39
         F3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699564195; x=1700168995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRyfqVKMjFpV8z0fL6kFt54MybPlj9VC5bM2icGskxw=;
        b=J1+UmHOcSHqL20UxE0DY+aqaUvJeKdNGHrcb4lkIF3J80oBc7jJ0CYPdHzcWvEoYyt
         BK8emz73kK4Exep43WjbBDKwr6nOoAgu9ml/Bpu4WYMAha5z+kiZUVHlPHgRcWL2XOpv
         xWE5jWKiVm0kL6bdHrDVNZ+LpVn/ZsJhRFedwL+xDtkpoc8JNqqx0e9RoTPuBA0W6kHK
         3JzGWcO8wajhdc8fBc5WZFZ1JhJeoP53irzUk2Yg0jtcgGmA3hpCumr9PY3rS7kestIC
         OWBRWII0FQQLqWkbB7WFWJaXDjq5U4sq87o2wyaCLoThCkBQeEIIRhpZP8vQ7njWID2y
         spsw==
X-Gm-Message-State: AOJu0YzfQEDzgGgauB0fWUf0KGMMT43urXU8NzHq36HA9B0EkjHSba4q
	2NIokLvZ7187kCnGdvaysqI4VC1is0AebowDKBc=
X-Google-Smtp-Source: AGHT+IHcVwBzzNxWhdQVjxysY4Dh+1S8SbLFupIr4Icq2rdeBYUIHb0m1ZmUge6EUsufo7pIhtmuSfPKQqSRuRVrw3Q=
X-Received: by 2002:a19:2d05:0:b0:508:19be:fb2e with SMTP id
 k5-20020a192d05000000b0050819befb2emr2078078lfj.58.1699564194947; Thu, 09 Nov
 2023 13:09:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109053029.1403552-1-yonghong.song@linux.dev>
 <6bf022a8cfd8c821ec0a8370fa85bcfd806c8be7.camel@gmail.com> <8576d3dd-28af-45c2-b72c-30105a451da9@linux.dev>
In-Reply-To: <8576d3dd-28af-45c2-b72c-30105a451da9@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 13:09:43 -0800
Message-ID: <CAADnVQ+bv81EXqcwej8N8cSRjnEoEEOthWYooc5XoDNCVQzPbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix pyperf180 compilation failure
 with llvm18
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 11:55=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 11/9/23 3:47 AM, Eduard Zingerman wrote:
> > On Wed, 2023-11-08 at 21:30 -0800, Yonghong Song wrote:
> >> With latest llvm18 (main branch of llvm-project repo), when building b=
pf selftests,
> >>      [~/work/bpf-next (master)]$ make -C tools/testing/selftests/bpf L=
LVM=3D1 -j
> >>
> >> The following compilation error happens:
> >>      fatal error: error in backend: Branch target out of insn range
> >>      ...
> >>      Stack dump:
> >>      0.      Program arguments: clang -g -Wall -Werror -D__TARGET_ARCH=
_x86 -mlittle-endian
> >>        -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/inc=
lude
> >>        -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/y=
hs/work/bpf-next/tools/include/uapi
> >>        -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include -=
idirafter
> >>        /home/yhs/work/llvm-project/llvm/build.18/install/lib/clang/18/=
include -idirafter /usr/local/include
> >>        -idirafter /usr/include -Wno-compare-distinct-pointer-types -DE=
NABLE_ATOMICS_TESTS -O2 --target=3Dbpf
> >>        -c progs/pyperf180.c -mcpu=3Dv3 -o /home/yhs/work/bpf-next/tool=
s/testing/selftests/bpf/pyperf180.bpf.o
> >>      1.      <eof> parser at end of file
> >>      2.      Code generation
> >>      ...
> >>
> >> The compilation failure only happens to cpu=3Dv2 and cpu=3Dv3. cpu=3Dv=
4 is okay
> >> since cpu=3Dv4 supports 32-bit branch target offset.
> >>
> >> The above failure is due to upstream llvm patch [1] where some inlinin=
g behavior
> >> are changed in llvm18.
> >>
> >> To workaround the issue, previously all 180 loop iterations are fully =
unrolled.
> >> Now, the fully unrolling count is changed to 90 for llvm18 and later. =
This reduced
> >> some otherwise long branch target distance, and fixed the compilation =
failure.
> >>
> >>    [1] https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5=
720c607313a566eebb16e
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > Can confirm, the issue is present on clang main w/o this patch and
> > disappears after this patch.
> >
> > Yonghong, is there a way to keep original UNROLL_COUNT if cpuv4 is used=
?
>
> I thought about this but a little bit lazy so not giving it enough throug=
ht.
> But since you mentioned this, I think adding a macro to indicate cpu vers=
ion
> by llvm is a good idea. This will give bpf developers some flexibility to
> add new features (new cpu variant) or workaround bugs (for a particular c=
pu variant
> but not impacting others if they are fine), etc.
>
> So here is the llvm patch: https://github.com/llvm/llvm-project/pull/7185=
6

Great idea. Commented on the diff.

> With the above llvm patch, the following code change should work:
>
> diff --git a/tools/testing/selftests/bpf/progs/pyperf180.c b/tools/testin=
g/selftests/bpf/progs/pyperf180.c
> index c39f559d3100..2473845d1ee2 100644
> --- a/tools/testing/selftests/bpf/progs/pyperf180.c
> +++ b/tools/testing/selftests/bpf/progs/pyperf180.c
> @@ -1,4 +1,18 @@
>   // SPDX-License-Identifier: GPL-2.0
>   // Copyright (c) 2019 Facebook
>   #define STACK_MAX_LEN 180
> +
> +/* llvm upstream commit at llvm18
> + *   https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c=
607313a566eebb16e
> + * changed inlining behavior and caused compilation failure as some bran=
ch
> + * target distance exceeded 16bit representation which is the maximum fo=
r
> + * cpu v1/v2/v3. Macro __bpf_cpu_version__ is implemented in llvm18 to s=
pecify
> + * which cpu version is used for compilation. So we can set a smaller
> + * unroll_count if __bpf_cpu_version__ is less than 4, which reduced
> + * some branch target distances and resolved the compilation failure.
> + */
> +#if defined(__bpf_cpu_version__) && __bpf_cpu_version__ < 4

probably should be combined with __clang_major__ >=3D 18 check too.

> +#define UNROLL_COUNT 90
> +#endif
> +
>   #include "pyperf.h"
>
>
> >
> > Tested-by: Eduard Zingerman <eddyz87@gmail.com>

