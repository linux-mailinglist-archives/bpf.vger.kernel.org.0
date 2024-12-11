Return-Path: <bpf+bounces-46643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2908E9ED0AE
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 17:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A756A28D1CD
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63ED1DBB21;
	Wed, 11 Dec 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCunltOl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0F1D9A42
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932972; cv=none; b=YfX2cSoMrnN7kILGlsTz4lvt/ltz+NAEu1BOcsUv0ZMzc09ZXgxPYgxkkJsc0UWhHGXYPcvExSRQcMuAw3t6DZufQ4FV7fcdxPYoQpIlDfKHPLyVRi7yWUenqrRL+q7gPLSTjKzlMYPm/k86p0II/x4rgdh/QaBpJq1S5qJupuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932972; c=relaxed/simple;
	bh=FM6G14G0yZlnNX/ewVyp0jfMUNgYVlickrHiCTeJjSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgL1yIrqCSf/YuwRay5aLBxvbTSkkhoegt5bmI0rIwsIy800mCgsMBLV3ssMmshdQPJiYgfXggsOGhRmF9vmE7KYtENxZQwz4lLG0SDSr5pKlgGHcNqJ+ib+V/6YHXAgLMhbJpTEUapX4ij62VzOdiD0e81eEW2NryJtwb5b6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCunltOl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so5076485e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 08:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733932969; x=1734537769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfZKiy4SwN6SPC0K8ZTm97hCEmo7EceRbwYp1ch7+wM=;
        b=FCunltOlnwSJ0XpLGzsT9iA/k9TgMUNP/Pv7Pi1iySVr4RzjhCnwYfAUb373UICZVG
         dsewqHwr/veraUhFszhPpEBnl2cSK46kWxK+TMTnXrF1xs0CFUTiGn+rjA/FYDf32299
         B7+3wJVoWWxe86s871Gf5+XyL70btWF/+Cuvs9QnZhtcLWl4l/9woqdqZxwwZMzdiGVi
         O/jm7+wGp/6mh2LnI/clyEYtfPdxdfBrCmurclpdr9agMBqfaIZFbSLyaoMomaboUFcp
         x1bY3u6sOvaTW86iHll/RvnLjPEEgJFFDrKnY5nM6Jy+OYX8sM76Rp8KBxzipMDQtaz+
         4Ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932969; x=1734537769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfZKiy4SwN6SPC0K8ZTm97hCEmo7EceRbwYp1ch7+wM=;
        b=XzYffX80gRv6WmUpyHizdtu8UEH1ijJPOICz1jDC0jumlEYUmkdE5CHHV9Gn1+9XQ9
         ZpVJXfZpYPsqYs6RmXGbPUHkZpxMHtue6vF23avSSX0p3iObJBhv5rrqYLcplgcya3OO
         bKpJk7DwoFgpsgXdtFGmBEJV9AMQV41Gd0q1s2yy/mLHwhqpLVOSC0dFW436z20qL7Gf
         S7OfOpXzQLbFJyvgosMZHLO3rimsCiOviXRHfbQ9RxrcLP8Pf09VPlcs6A4iXZ8vDikM
         Rc+kmkeNcnJW43c1g9VL2cjLWm7Plb+m5E0OUe6HfhYexdk0tqWJNDJfeKhc5XeHO6nt
         9clQ==
X-Gm-Message-State: AOJu0YzSZCsZ4HLZayeMzt50foud8uNQzty5jpvxJH0nE69inFOWex3B
	fGBgsr7+r48sqflLE8BO1fFJkGNe142RfpDoxtV/C6GdTPJd3urxaJCo7PsWNPhpzGwTbJpZN0z
	ZvRB7xxM6e4YCVX+ZYacEppeKuaw=
X-Gm-Gg: ASbGncu9Hw3wz+dv+xhgi1zixr05ZTaGHhcUfLmbs7yDLu0HEEgv3DrSTTYBnZecLJs
	fHo2zukLWP9x/ZH8DratkMgW3CTtF+MluW0eR4rxicrSH5dWBwRM=
X-Google-Smtp-Source: AGHT+IG15DV/Pdnkwz9jk3PDGLDi0ScFVOD7+BECC49VtRtcTBbH172cJEGR+XkkwW18F6ZndajjC2brkI75pz+7gV8=
X-Received: by 2002:a7b:cd15:0:b0:434:ea1a:e30c with SMTP id
 5b1f17b1804b1-4361c80b03fmr26331885e9.13.1733932968558; Wed, 11 Dec 2024
 08:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211020156.18966-1-memxor@gmail.com> <20241211020156.18966-5-memxor@gmail.com>
In-Reply-To: <20241211020156.18966-5-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Dec 2024 08:02:37 -0800
Message-ID: <CAADnVQ+8N0zzRpnejeT5ew+T0KwrEbjEdw6wgJW5aweYbiO7Gw@mail.gmail.com>
Subject: Re: [PATCH bpf v1 4/4] selftests/bpf: Add autogenerated tests for
 raw_tp NULL args
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Manu Bretelle <chantra@meta.com>, Jiri Olsa <jolsa@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:02=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> +cat ../../../../kernel/bpf/btf.c  | grep RAW_TP_NULL_ARGS | grep -v "def=
ine RAW_TP" | ./gen_raw_tp_null.py | tee progs/raw_tp_null.c

This is a serious overkill for something that will be removed soon
when automation to analyse TP_fast_assign() is ready.

> +++ b/tools/testing/selftests/bpf/progs/raw_tp_null.c
> @@ -0,0 +1,417 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +/* WARNING: This file is automatically generated, run gen_raw_tp_null.sh=
 to update! */

let's not.

> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +SEC("tp_btf/sched_pi_setprio")
> +__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
> +int test_raw_tp_null_sched_pi_setprio_arg_2(void *ctx) {
> +    asm volatile("r1 =3D *(u64 *)(r1 +8); r1 =3D *(u64 *)(r1 +0);" ::: _=
_clobber_all);
> +    return 0;
> +}

This one is enough to test it.

Drop all below. They don't add value. Copy paste doesn't improve coverage.

> +
> +SEC("tp_btf/sched_stick_numa")
> +__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
> +int test_raw_tp_null_sched_stick_numa_arg_3(void *ctx) {
> +    asm volatile("r1 =3D *(u64 *)(r1 +16); r1 =3D *(u64 *)(r1 +0);" ::: =
__clobber_all);
> +    return 0;
> +}

...

pw-bot: cr

