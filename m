Return-Path: <bpf+bounces-48347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFA4A06BFC
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 04:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3C31674B1
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB15913D52B;
	Thu,  9 Jan 2025 03:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="my1iiEIX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333A210E3;
	Thu,  9 Jan 2025 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736392978; cv=none; b=gfCKxWJI3vG6GLVetTM2D8BWt3R8LMsqshk60wrYkqQJbVH+ZCdjG98DVF5h3yCbykiZUYtrnGQJsRvmXjnktfjfwxz9ItMlg0o5SA70ja9rS7hZBJcobaJ+pBygCHZoilF4jz3D7cVxa7pPkqRaKuqkS2bPfIfBMIWbWWjj0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736392978; c=relaxed/simple;
	bh=UK4Z7qZ2n3DHOwfe1/RSpWrSJ+hABJq4TrbP8dFCHbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iy/SiqgRtWdx9e94lYZHXYiEbxF7Jm0FfpWXtc1Z3O8OXAFS4T48s4rT/nJYszA/KqL/wNW0SKVsHLcKt9E8wJOZwj2QW4xzMaitO+8IlZL39xIaOhRyROGdRvu4tUjV6nyxYBDgaxmCesaTF8hLe9vsPJdYcl0DoIsojp6cR8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=my1iiEIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52A3C4CEE7;
	Thu,  9 Jan 2025 03:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736392977;
	bh=UK4Z7qZ2n3DHOwfe1/RSpWrSJ+hABJq4TrbP8dFCHbo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=my1iiEIXhKbbCPWnQayM2Jb/3gnxaDwAXkWHNpWKa+vWn0OkMn3IPlAS/cXTcFJEA
	 nMCEZBQhNKWHHygacyYEY/upkop0UkXwgrqtpm9pZ5kvcMewJSGZumqTNJi/5N070u
	 Y200NC0tYWn3yzZLCr4zNATvv0p9T9e3jxKqlWSAf3diWoxYt4QqEpDcKhz/qlaxII
	 2VQLz3AO4v6GZ9h54B6fZZfPzF6iL0xjqqCGJIoQPHcTDjdXzFQsfpuGbSbTXc88fK
	 wtuOvcgel2cecwFDrYKuTLknwbZOwMyXY/stJbNr7RhTuvPWkcNuxn6vhImsF7KkeY
	 3JNLFfyuMMrNg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso616883a12.1;
        Wed, 08 Jan 2025 19:22:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+Na0kwo2GmROAVodXWu8IObpuJeuEc24jW8OtLV+BaH9vxinPxEp2VB06OMsYojltiYKVqWbONZrC8A==@vger.kernel.org, AJvYcCUV7tUbXTNPOq48tH8MeGzglloSi5oAsNIZzOnwT5k2A2MbkDA0T9amd9E1Y3nTzv1L5RdKmPOHbOTQzdjtOP+nfbo63H1L@vger.kernel.org, AJvYcCUys0nSnXJ4/Iwjk5mOgQhkv3zj0G5P6n/O8lAW34q6GT0aBXxQk4nYAS6TNJlzUhN9UiFD+v4mJ2zZYDHQ@vger.kernel.org, AJvYcCVE86aLQMGj7HtSbJSYuDxkTg/G+o1BhbW1aTIvnhvdqnUmrKAoKo9NZqa8rLvtFpNJqTcXl/LRcUfeZJuIC2NvPA==@vger.kernel.org, AJvYcCXAM4gVli5NDbpS3rTs9D+oJ9pCQqUIRa+qbRPI5kBioqDOH+R/Hwc/iXOHKddIXQANinA=@vger.kernel.org, AJvYcCXr3q9uc9C8Vm2sntVzbmsaG1E6G/wzeTdeSoS+is7/TpkRAATY6mm+jPr39zNiOLfEcBs4PzvBHmA1@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ1qaC529ag3Qt2G7f2ehJUJAFXp0uTDkLHB68PGtbHFRDuyqT
	YcRVcNiygJ53vARc9h3Uez94W2w1bGbl6vX/sPsO2BVOD9IsJxn+lLN78bkAZ57XeGmNh0uSiyU
	Bzy2wNnBWTbsQe4zG6W9xNCPnV2E=
X-Google-Smtp-Source: AGHT+IF2vfwWk/hX1fppoOgb3+DWHmntV4ZAONyRFvI6o1pxOXRZKk7PnjDU1irlzVBy8ipamhJ7KiIEeYXxp0Ftx84=
X-Received: by 2002:a05:6402:3225:b0:5d3:bab1:513f with SMTP id
 4fb4d7f45d1cf-5d972e178cbmr4906639a12.18.1736392976133; Wed, 08 Jan 2025
 19:22:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com> <20250108-perf_syscalltbl-v6-3-7543b5293098@rivosinc.com>
In-Reply-To: <20250108-perf_syscalltbl-v6-3-7543b5293098@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 9 Jan 2025 11:22:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQFq41rpBMsEodungBHPbzd2zn9F02fB6dJxnYAr81HJg@mail.gmail.com>
X-Gm-Features: AbW1kvaPnl9RqcyhYmWgfOMmK2I_eaC06_BB36DSFhf4vdK4RFvF9kDCvTmwHLc
Message-ID: <CAJF2gTQFq41rpBMsEodungBHPbzd2zn9F02fB6dJxnYAr81HJg@mail.gmail.com>
Subject: Re: [PATCH v6 03/16] perf tools: csky: Support generic syscall headers
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 10:36=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> csky uses the generic syscall table, use that in perf instead of
> requiring libaudit.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
LGTM! Thx

For c-sky part.

Acked-by: Guo Ren <guoren@kernel.org>

> ---
>  tools/perf/Makefile.perf                              | 2 +-
>  tools/perf/arch/csky/entry/syscalls/Kbuild            | 2 ++
>  tools/perf/arch/csky/entry/syscalls/Makefile.syscalls | 3 +++
>  tools/perf/arch/csky/include/syscall_table.h          | 2 ++
>  4 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 44b9e33b9568f638ba12ad688833fdb661c16c16..3fe47bd21c0ea39473c584c82=
383ca5d4daf580f 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -311,7 +311,7 @@ FEATURE_TESTS :=3D all
>  endif
>  endif
>  # architectures that use the generic syscall table
> -generic_syscall_table_archs :=3D riscv arc
> +generic_syscall_table_archs :=3D riscv arc csky
>  ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
>  include $(srctree)/tools/perf/scripts/Makefile.syscalls
>  endif
> diff --git a/tools/perf/arch/csky/entry/syscalls/Kbuild b/tools/perf/arch=
/csky/entry/syscalls/Kbuild
> new file mode 100644
> index 0000000000000000000000000000000000000000..11707c481a24ecf4e220e51eb=
1aca890fe929a13
> --- /dev/null
> +++ b/tools/perf/arch/csky/entry/syscalls/Kbuild
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +syscall-y +=3D syscalls_32.h
> diff --git a/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls b/tool=
s/perf/arch/csky/entry/syscalls/Makefile.syscalls
> new file mode 100644
> index 0000000000000000000000000000000000000000..ea2dd10d0571df464574a9c02=
32ada0ac1f79a3f
> --- /dev/null
> +++ b/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +syscall_abis_32 +=3D csky time32 stat64 rlimit
> diff --git a/tools/perf/arch/csky/include/syscall_table.h b/tools/perf/ar=
ch/csky/include/syscall_table.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..4c942821662d95216765b176a=
84d5fc7974e1064
> --- /dev/null
> +++ b/tools/perf/arch/csky/include/syscall_table.h
> @@ -0,0 +1,2 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <asm/syscalls_32.h>
>
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren

