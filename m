Return-Path: <bpf+bounces-30977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1D48D5491
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 23:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0843EB258A2
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1125186280;
	Thu, 30 May 2024 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byba5nJY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DF1181CE6;
	Thu, 30 May 2024 21:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103856; cv=none; b=LyY/qQqzPyoq83hLxBPYP8488KiGKvPOpDForyb+f82LILUG+z0FrafRmgWNSCsptlX1GBUJPUJL7/sXut4Jc5F+E6ykm2q4HYF9jO6/yQErjK6E/f6/eFOCi29DDiMZYeNsH3g0yOg5cU0WXB6N5AcwiGFo2aF6w3ykoUoT5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103856; c=relaxed/simple;
	bh=O3liIuepGCFohB2HpmNX8cU+n1Cpbr4RlTKC6GbZOHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DILPlaKhhUxOHveJ8g2jsc+iD96CErVZT/4Jw0ehI+sr5SOtJRvPCpz/a6KdAnV2SEc8LS0/YRY1qrH0NFqbEePbOiFo5doI76bLXao5xks/JTT2kjNKkNjrQ7AkzVziMMimot7gIusbcVMp8hnJYXA3dh+5WUUE4Mc+ShfPYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byba5nJY; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6818e31e5baso1077420a12.1;
        Thu, 30 May 2024 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717103854; x=1717708654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwQcnSpwYFxUIF/Q60kDgJFYctgBO16yPjwLDCfAzBg=;
        b=byba5nJYJygiYKJ/HRfkFgoMopqmpHfNeSNie3+A9/LmuzyzghU8/h3OYy9tF9QEjG
         KTrf2Kt0UhJ0A/W861tdiXBrDXS3Ll5w74s1h0cmCAkr7FslEcVke3jarD1u/wwQBQvf
         358hmZqYjYonOyvJ2R3q+rAhFvbXmmKjpP1E8XnEjqN5KjcKZLDBI20D4db6Q8HKeYJ3
         KDSZ8LjEYd3fdNMmGgUwQu83isjFcxxZp2z4C2pyNBxBLJkG6VtPgJ5kIBjs4R3DWxps
         KoI0daPSltGYcCAEhhPR/LeOLNwixTK5gxGk1dDfG4T+ot/QALvlQbMCP7gemgcxpuQZ
         Ektw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717103854; x=1717708654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwQcnSpwYFxUIF/Q60kDgJFYctgBO16yPjwLDCfAzBg=;
        b=XdYnE3tYaZ+0Obc6gGm1JShLhqSv+1m4MjXHgNJKrnCvTsabynxs7mLHFl/Z+DFo56
         RIBqOyWv9o08yOwY3NejjimKbIKcH8Bdxo4L0ZX6vu8w6v6sKr8b6fzB+AB0Du3WM32j
         hdbfz7pQpkuCXe2QcJuU9esSWEXXivb6++lx+ws0d5A8ljv45mRi6Jy4QUJbKYVT7i8O
         K+gsCWIXcziKaLYZYvBoWVr79LLo/9qm29cOA2SDxXmfh3GmRBHswP8eUntdl2UsfSdh
         9Qaiy/NUSwpYvVLJoZY5CBKB3FF8BH9p+iZHlDYgCthKuPpHaGji3mNQCFheqISWReNF
         WDew==
X-Forwarded-Encrypted: i=1; AJvYcCUGsUSOzFN6hVKpI52GljHKO5iwpfTFJ5EoK5OZ9rYEQwre2QRMOMKkPXrp3SEE27ct54TAt2ixh8kpUH/0zKI1ySXYbVDg+HCPr0djgxeEyu34kKS7Ax5RVYcanh1rddko
X-Gm-Message-State: AOJu0YxoFV71GxRwS6aO6cftWadP3DTnfbkRVI6QK2bGpTjo8+maeOQx
	yc6RXwYPbXE5F9/WwrdTqsxpG+jpY6s/2gxYPPTS3aAWGH02IjvC5pWcMKNcL9TwdmYBhVyuOU8
	o9N5RzeBfV2n78dWn2U6bJoniUaM=
X-Google-Smtp-Source: AGHT+IHl8wkfVKgwLInhye/evtiMGniqi/43wcg8sILOeYzYZH2vA0iqQwN2OKj5p3Ya+XOlcON1CYKb23jyweMS32E=
X-Received: by 2002:a17:90b:1e0f:b0:2bf:ebf5:c9d4 with SMTP id
 98e67ed59e1d1-2c1abc46ae3mr3489777a91.42.1717103854098; Thu, 30 May 2024
 14:17:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522114755.318238-1-masahiroy@kernel.org> <20240522114755.318238-4-masahiroy@kernel.org>
In-Reply-To: <20240522114755.318238-4-masahiroy@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 May 2024 14:17:22 -0700
Message-ID: <CAEf4BzZ4JvrnXYdE7YP06b574b5QKiU-asy_jtnP=JGH-5uR3g@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: merge temp vmlinux for CONFIG_DEBUG_INFO_BTF
 and CONFIG_KALLSYMS
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 4:48=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> CONFIG_DEBUG_INFO_BTF=3Dy requires one additional link step.
> (.tmp_vmlinux.btf)
>
> CONFIG_KALLSYMS=3Dy requires two additional link steps.
> (.tmp_vmlinux.kallsyms1 and .tmp_vmlinux.kallsyms2)
>
> Enabling both requires three additional link steps.
>
> When CONFIG_DEBUG_INFO_BTF=3Dy and CONFIG_KALLSYMS=3Dy, the build step lo=
oks
> as follows:
>
>     KSYMS   .tmp_vmlinux.kallsyms0.S
>     AS      .tmp_vmlinux.kallsyms0.o
>     LD      .tmp_vmlinux.btf             # temp vmlinux for BTF
>     BTF     .btf.vmlinux.bin.o
>     LD      .tmp_vmlinux.kallsyms1       # temp vmlinux for kallsyms step=
 1
>     NM      .tmp_vmlinux.kallsyms1.syms
>     KSYMS   .tmp_vmlinux.kallsyms1.S
>     AS      .tmp_vmlinux.kallsyms1.o
>     LD      .tmp_vmlinux.kallsyms2       # temp vmlinux for kallsyms step=
 2
>     NM      .tmp_vmlinux.kallsyms2.syms
>     KSYMS   .tmp_vmlinux.kallsyms2.S
>     AS      .tmp_vmlinux.kallsyms2.o
>     LD      vmlinux                      # final vmlinux
>
> This is redundant because the BTF generation and the kallsyms step 1 can
> be performed against the same temporary vmlinux.
>
> When both CONFIG_DEBUG_INFO_BTF and CONFIG_KALLSYMS are enabled, we can
> reduce the number of link steps.
>
> The build step will look as follows:
>
>     KSYMS   .tmp_vmlinux0.kallsyms.S
>     AS      .tmp_vmlinux0.kallsyms.o
>     LD      .tmp_vmlinux1                # temp vmlinux for BTF and kalls=
yms step 1
>     BTF     .tmp_vmlinux1.btf.o
>     NM      .tmp_vmlinux1.syms
>     KSYMS   .tmp_vmlinux1.kallsyms.S
>     AS      .tmp_vmlinux1.kallsyms.o
>     LD      .tmp_vmlinux2                # temp vmlinux for kallsyms step=
 2
>     NM      .tmp_vmlinux2.syms
>     KSYMS   .tmp_vmlinux2.kallsyms.S
>     AS      .tmp_vmlinux2.kallsyms.o
>     LD      vmlinux                      # final link
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>

LGTM, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  scripts/link-vmlinux.sh | 45 +++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>

[...]

