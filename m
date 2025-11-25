Return-Path: <bpf+bounces-75503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFACC87602
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A6B04E6A69
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 22:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5682533ADA3;
	Tue, 25 Nov 2025 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zck6HtCi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C433016F9
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110615; cv=none; b=c2/ZSOXjWhyGYUnCFRYDrsJzPbz+PKe9t21JJawby2+mLDABiCPLEyga6P+AZj07phsGA2OjeDnYm4x4I6tsbwehQsp7XQZCvOUv4G2Q44zMQ0/zoliq5ZyvVVslKwMLtNU0g+bOu0ZeeadePmiAg0aA+2jdUOzKNHogkCpP/BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110615; c=relaxed/simple;
	bh=/Nhl3mIYXGJHHFjg3EygYmeUeSdJR0DpH9MQd/PCEXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGEnaY91jFfvqhFU0VcS/t1kSgB/XG71Btb1n4b59bKPmwwAVBLfaaMh75zVe5k1+lBDLfl45YehYhFNBVAXlwbx/rgLfLAafedM4/WDrmfPeg6hZwvD2qbo7eoIOessFqLKVlOIQ9yf4jg2BvzZocUz8OpfgOhOLceBKBhA4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zck6HtCi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2981f9ce15cso72907095ad.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 14:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764110613; x=1764715413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVMrUcori1mIamaeJyLOiP2EJku4pRClbvk7rP/G8rw=;
        b=Zck6HtCik/yVcsNOaqXNh5VgYtXHzTDGM/NAip0Dn8RwpdxdF+t6eKZtEs+rCGvsih
         M3E0VzTs6dJokfWIB221KjYoWe3fUAATUAu+qlKzO1a7pByNegQKqRIhBS59k0XgCR+8
         BTu1SAw04qsIjAAjXq7/N/HMmATIzhuLQxz/2Dw/dBICvJCx9ljZQViX67GJrXnqsoPX
         tOJn6SXlYMXvt1qhsiSOY/xCcecnogINKt/yf24NmKiQuw4MxstoPfOqPkxiNnFh2HRB
         F87gbJqqftBppItG3I49pvdSbgWT4fD16VTresRnf/2BmXWV25UBTHHy6xDSRbwvC0Bz
         48Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764110613; x=1764715413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cVMrUcori1mIamaeJyLOiP2EJku4pRClbvk7rP/G8rw=;
        b=Un2IjbqRySpItF6IP3v3G6EiUI3THoWTZhM5Dux8306SvDusBgPuA4OLY+XRLLKskS
         hvmW0bl6tAOD3tYZ2XVIjGN5hoo31+rTm1dvoPK5v1OgbSLNYl5wR/VaGCNdUxigbxXv
         8BFy1BlIXthpopOMO/g5xWQJQng51Genfmnt88yn3UZahrHyX4oYIClvN44hP+Vy3j9F
         i4ILBeO+WBEfZySTQstSgdCICwFuP0YLc33fyN0j/8UUK01Q3fa8zLkbXwxysMS/UpoV
         nTkVqcmOYiySeq8ubkrpzzPnTvQAAb064fA6YcWkTXH7Qj0BEqzj20mBkSsjeu0LyhC6
         8z+w==
X-Gm-Message-State: AOJu0YxSkf/fxrjaiYAWsoETXnQVakJ4TdEGR44G96y70GUJiT0ipcsY
	O3/5S1jL6WUsRmYP1nYzsIGfKRk98yTsf52/1poOWteVBEOrqoJVJUfoocbzpykLz1nAARJr0v4
	NyzUp78vFrxIUCu5rbp/E3tL9qmCJ1cw=
X-Gm-Gg: ASbGncurRYQAXJ7DMwzCRJNrShbK0lfeC/MDqKk46IybHNlHnlVuF8xmsnkGWUK8yit
	CwABbgqX5M/X9+XGZE8yqGOpv4zSKQo1E/j+8bP8wHaQ1Aaix6vOCu2W+lopNt98OX6X3au3pVF
	V0kKQXaih8QNQf4PgDRVa+0lQcdlAEEgzxYDt1oW6IpbsGd7RENyVhf7PE8r6BlwHZSETn3NAQr
	5UezVM1UjPKYo9byr5ZJCQVpwW4tTSiPKNz/AmVudPDsQBox5W57ON3AcHq/BN5FMQ8StGOhtCI
	qILwMW2wKMI=
X-Google-Smtp-Source: AGHT+IEIXW0bJtFY6fBiBfGeQC5yH/czaAj2wo9rlJL3fHEdtl/Tr3I/+PPIwGRCv6tUVuOs4JGXiZrhojYZTOuidXU=
X-Received: by 2002:a17:90b:4b84:b0:340:ba29:d3b6 with SMTP id
 98e67ed59e1d1-34733e6c89fmr17055678a91.6.1764110613389; Tue, 25 Nov 2025
 14:43:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119043739.1860428-1-hoyeon.lee@suse.com>
In-Reply-To: <20251119043739.1860428-1-hoyeon.lee@suse.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Nov 2025 14:43:20 -0800
X-Gm-Features: AWmQ_bnRM1RtbO-FP8JP9v9A4ffp0WSyeJFZokaOzGcZKQJuatArGzGeKGqHx-s
Message-ID: <CAEf4Bzbjbd-_3d2rpL1D72hngwNbSAbyPQDOn9fv0X4zpEcCCw@mail.gmail.com>
Subject: Re: [bpf-next] selftests/bpf: propagate LLVM toolchain into
 runqslower sub-make
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 8:38=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse.com> wr=
ote:
>
> The runqslower build invokes a nested make, but the selected LLVM

I think runqslower in kernel repo has long since served its purpose.
There is no point in maintaining its Makefile. The tool itself lives
in BCC repo. Its original purpose was to show real-world BPF-based
tooling end-to-end setup and implementation. BPF, libbpf, entire BPF
ecosystem has evolved and grown, I think we can remove runqslower now.
Do you mind just sending a patch dropping it instead?

pw-bot: cr


> toolchain (via LLVM=3D-<version>) is not propagated. This causes the
> sub-make to call the system-default 'clang' and 'llvm-strip' even when
> a specific LLVM version is intended.
>
>     # LLVM=3D-20 V=3D1 make -C tools/testing/selftests/bpf
>     ...
>     make -C tools/bpf/runqslower ...
>     clang -g -O2 --target=3Dbpfel -I... -c runqslower.bpf.c -o runqslower=
.bpf.o && \
>           llvm-strip -g runqslower.bpf.o
>     /bin/sh: 1: clang: not found
>
>     (expected: clang-20 and llvm-strip-20)
>
> Propagate CLANG and LLVM_STRIP to the sub-make to ensure LLVM version
> consistency across all builds.
>
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 1 +
>  tools/testing/selftests/lib.mk       | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 34ea23c63bd5..79ab69920dca 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -306,6 +306,7 @@ endif
>
>  $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT=
)
>         $(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower      =
      \
> +                   CLANG=3D$(CLANG) LLVM_STRIP=3D$(LLVM_STRIP)          =
          \
>                     OUTPUT=3D$(RUNQSLOWER_OUTPUT) VMLINUX_BTF=3D$(VMLINUX=
_BTF)     \
>                     BPFTOOL_OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/          =
        \
>                     BPFOBJ_OUTPUT=3D$(BUILD_DIR)/libbpf/                 =
        \
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib=
.mk
> index a448fae57831..f14255b2afbd 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -8,6 +8,7 @@ LLVM_SUFFIX :=3D $(LLVM)
>  endif
>
>  CLANG :=3D $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
> +LLVM_STRIP :=3D $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
>
>  CLANG_TARGET_FLAGS_arm          :=3D arm-linux-gnueabi
>  CLANG_TARGET_FLAGS_arm64        :=3D aarch64-linux-gnu
> --
> 2.51.1
>
>

