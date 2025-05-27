Return-Path: <bpf+bounces-59006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1FBAC5742
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 19:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FF44A6AF0
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 17:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56531AF0BB;
	Tue, 27 May 2025 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnEusWYD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4825A627
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367050; cv=none; b=Jmp7Q2QmQgbKnPw24H6xYY/kDJkqmid+VNLFOffKt1KIurqi+ZxD1gnPAtGM+3ENbBrq0++UIHjOHe6A1qOCPT1dBnikxmqpk9MfpRv5kccU39xdHznN6XcvtW8Zf5++JvwAoARGYXimOzp6R+Nklb2dodefbiAxJab1DwT0GOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367050; c=relaxed/simple;
	bh=k4DgVCmMx2v8HH0ZHJD1F+doIXYfILmBPEmEFpjBcSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vt8v/ZzNeeYB5eZYsitBR9056i3muvhyIHtUN9/2eRVIvSDermNDKSudEMRxt/wsNFY0+GJ7smuG1v9+2/xvVqT8Z1UfxU6KMFYUiUbC8d4jSF9RL+DAvQDzEqV7evWjELQYRXDfVmeP8aj4MmD/K6vS3lS5NSgMBw6HfnuykyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnEusWYD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4d152cb44so3333970f8f.2
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748367047; x=1748971847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvviCJ2oYBMbmQA+UTssXwmLgRzGcgpFY4e/ToSCytM=;
        b=HnEusWYD7bhd5DZyU4IYQGiCNx/N54x6hXd7hwymY/iY0Cz1COM0klHqi+FthQnSrK
         CKhaxb9ZwFWIzXutoD62kzbqmWZq4tL6+512+zEPEKQLsSFrOkGsl88ENkWymXn8fuIB
         /9S+E+6pW2kgKgha04D616ebywrmI4ook+wcYAi+tdGvYcpCA1GIP2ME9eYGdjks48Gw
         2/OQ/gtbF0VKOV7djgmo/kckBZQ7qHrzIDAG3y+Kprcmtr1sv74FA4+ux3t3Y9I0nUNn
         DUlRgALFsgHs+1NeXImuMuy/7G+M8o6zjQ/LmmFrtoBLMvKEe3ZcMVek47qeDi8UMaKG
         HjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748367047; x=1748971847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvviCJ2oYBMbmQA+UTssXwmLgRzGcgpFY4e/ToSCytM=;
        b=PYoXARueSXwnsap7orgVXrulSsYdP2gQhkFwkBg77wHtJhFR4uGr1TY+pI/5L2ZxFj
         XcwLxuNxZyEvA3g2qOcCXw+JfWoE+ycZTaidzvOUcNewBYKiS2AytT8ES0Lqz16EFcJ5
         c6Nqgj4TsYPT/LBC8pbWnk+cGGxKtSCao/zDWxlrbJX+lAXQikGtOsVVsHBMqOaara1N
         juxR1BIdROPiknlNBah9roIm6zDqtjlZ3EtTYYTfhoNNKrmAgEio9qIQKoK0jWF6HOgr
         AxziAHpQPZu9YW5S/ZBTV+X3/f7Fy+5/s6hISvq5bv0cJL8ATrCB+h8R1yJLnFDwbUNn
         tnFQ==
X-Gm-Message-State: AOJu0YwEfbPKoVMAJnV1FulKusHy+xBaseJ66GRciCKwrFdsrYzffhP+
	qR2cE4dWNmJIlDiH3aKdKR51P0drswOhtD1G0q9ve55ghLQVb+KDlhsjBbarzeDqrblvVdBDn3g
	NPnKm82dWbnkcR+mN8hcIW3E+oCGnG6s=
X-Gm-Gg: ASbGnctbe/eURVheLrTSFJPV6tbQiisuIBvRg/bG7g2tjoX2vziDcVVKPUDmd1UT29c
	mKk3F16VmhstWsjJeVQi7fLsFd1d5NEnJpy8+DCwbP4P0EqgZiSzXmDZreQoHhXq7S5FmUi9pl2
	seh1DaPmZLJypBpNzu4Zz4YMeAmlERheLViK1JUXIGsHsCUr4Cq+gvOGUNHOc=
X-Google-Smtp-Source: AGHT+IHpupCJ5fajvdOR6sOgLo+LyCVtRkY+u5rDt1WLqkPhX0rbdw1VhtPaVEx8laNn4d/nLR3KgNt3hj9+FApq5K4=
X-Received: by 2002:a05:6000:2893:b0:3a4:e2b9:c7e7 with SMTP id
 ffacd0b85a97d-3a4e2b9c9e4mr2769094f8f.33.1748367046655; Tue, 27 May 2025
 10:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523205316.1291136-1-yonghong.song@linux.dev> <20250523205331.1291734-1-yonghong.song@linux.dev>
In-Reply-To: <20250523205331.1291734-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 May 2025 10:30:35 -0700
X-Gm-Features: AX0GCFuW7DMVeNrQeqgT-QsF8NYTJKGyrJGmBTzJK7xhqdUUAYEpnTMc4LJ-HJw
Message-ID: <CAADnVQJ6mGzvemnmzzwjHTrrCfgymHEN0ZZz=oWNDD=5qSiLpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Add unit tests with
 __bpf_trap() kfunc
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 1:53=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_bpf_trap.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +#if __clang_major__ >=3D 21

I added "&& 0" here to avoid failing the build
on current clang 21.

> +SEC("socket")
> +__description("__builtin_trap with simple c code")
> +__failure __msg("unexpected __bpf_trap() due to uninitialized variable?"=
)
> +void bpf_builtin_trap_with_simple_c(void)
> +{
> +       __builtin_trap();
> +}
> +#endif

