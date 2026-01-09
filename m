Return-Path: <bpf+bounces-78424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F755D0C899
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 00:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABE213010078
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 23:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A0933A033;
	Fri,  9 Jan 2026 23:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnON3o7B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22633A9CF
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768001134; cv=none; b=rhBYCTSlDcD0i3n2o+z6dk9KFY4ZXTrT46JoaGHcu4XHuYs2K9K8quiI26wUBsuWssHNd/JBwPA30snEaIqxIW+GufQSSBNlkoc99dxxY5ZDYurb7NMIG62H1BsNCKSTbhagQldpiX84aBHZ5aLQP15ucpYIZcSbBSMq+fMQ/3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768001134; c=relaxed/simple;
	bh=u7obPu1pBmzU0WGrbzd5pVmCa0nTdZyqTHXFpTUeBuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0y/mDWA+HdpwwcZgYCXoW0P4Wz1jyPmgwUcnJSH687sDpuYSa2qrZQwQcTKzHR4VV6utzvpJrqEItZtdLnPJX+doYfFuA2KEtdXKEsy81sscLB855LlA6e6bSAt/Y+t+EELobvbpYiUfHCNkjwuWSn5xpQ7WxxUVbI74ap24CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnON3o7B; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2818362a12.3
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 15:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768001130; x=1768605930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCUQNo7mxSC8vkmePvOCKj2aGkP0nJSpQiMFJJI16iQ=;
        b=mnON3o7BDYo95GaLThE9HZXUSqSGXzDoLKWtVP/hyg38TB9pqkkBKaBODlinySZwLI
         RQrWKwftL0wUlS7qFju2TB0qWRPAt0929VH61Wc26hWwGblCHJHlgcCzNrOf2H0DTkCK
         FR/zKnROgIFgC2TrtjEPOqDmnyT713pyevyx9CI0z7rQmarIT0CqzSB7ghADjeJ0E+b6
         rvaS+U0xmp4v3NeHzbHU3p9NIcl9q3NmCpO7/jlETni92hYegzkFvFEmNCvKS0OU0l9Z
         XbrB4d9ZVDfVvSIsJJyfT1lyVGUxW+UBY38hidethHuVBuGQ3WMJmQsE3cGb/Q4aWwhc
         nelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768001130; x=1768605930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nCUQNo7mxSC8vkmePvOCKj2aGkP0nJSpQiMFJJI16iQ=;
        b=WB/ZZHm/IOl1Pd7xbH6yOEa+4cFsveJ6bSHTjm+J6l/54kKYMClH3pQxmDA2GfP67X
         vPr6AZ745R2r1aWtHbcgZpVHFD3c9jkhM1mrfCaGZswS634vNYLS/KOWohXFJjJ277DG
         XP6n5lXg/cnOessvk3Cgq3U+7eta3LZMRsJ6WRjdGIPwroi3yERqeCNE50KCgq4LTbg/
         +XEtPXNY0vgiTXFG5nyxKYPGSk4DnUJmp/hVKd1G9r2U6oZFMTsz2Yvq7w4p5ismSoAm
         BN5l0YQuG+KyypVU2wUWP7JUBa1W0tNW3HiIwg/WfeeFMBPIX9SqLooUcqhSt0HqB4B8
         eTEg==
X-Forwarded-Encrypted: i=1; AJvYcCXHMMRXQKkpoPQaSC9arVTCNO4du3Yx7/CN0GJSUk+VUtwsai9y2I/CCAkBVj3MlbcPl70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqvyLFpGSkQrhKuxbBnj6d0aGRM2SzsBfn7ZB9o7GIbWs/G+nD
	9whDIf7mN6E9+CJocqJjXq8+mvQomSMEX8/uIwMgdYuMIuap71tGk3l7n90axC0mJ3hsCdEV0Zs
	SDaNByra0WCNzZcFjh7rS2BC3Ltbb7Zk=
X-Gm-Gg: AY/fxX79ZtopMkbQeJz76iwbh8l8rlayW2yHgGdQrYmGFysHWZC6aakShMQbeY/LXKz
	OVSBBDau+7couUaxFIC11hFJCbCjYwzJ/uW5sE4aga36B38mPpt0HGRTKqfEzfYBSIDRNYDC8uW
	tQEXRWVnUgdy9ZppqJs1kScGqQCB4flk7u9tzJQVpAbBCE0/f4GfuCAmfYDhsf+DKNe9sNreEx2
	KSTAKt/NHMr/8KefPDC0Hr3r1mn5xi0e6j0dz78jSPjPEETyhJN6dK6GfOVr1aC+8FKc9eaRKtD
	lvZxO3p7
X-Google-Smtp-Source: AGHT+IHfdl0DFFsHTVhHGn4++xm9XHvLJknpf551hc1xetbMq7EEy0O5Y6tQKD9GLsiH/IFDZTNgO/HkHtmxCHtZE78=
X-Received: by 2002:a05:6a20:a10c:b0:366:5d1a:c736 with SMTP id
 adf61e73a8af0-3898f88f211mr9018589637.9.1768001130450; Fri, 09 Jan 2026
 15:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev> <20260109184852.1089786-6-ihor.solodrai@linux.dev>
In-Reply-To: <20260109184852.1089786-6-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 15:25:16 -0800
X-Gm-Features: AQt7F2qzahhwWoxdH0F1ChmrKpOGZlbkzZ4pxxwq63_4u0Nd-h9NKx5gelr7ptA
Message-ID: <CAEf4BzZfuqpdwghCZ_TJJyt3Dm=xCBJLz3H0bbtabgToNV7V+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 05/10] selftests/bpf: Add tests for KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 10:49=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> Add trivial end-to-end tests to validate that KF_IMPLICIT_ARGS flag is
> properly handled by both resolve_btfids and the verifier.
>
> Declare kfuncs in bpf_testmod. Check that bpf_prog_aux pointer is set
> in the kfunc implementation. Verify that calls with implicit args and
> a legacy case all work.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  .../bpf/prog_tests/kfunc_implicit_args.c      | 10 +++++
>  .../selftests/bpf/progs/kfunc_implicit_args.c | 41 +++++++++++++++++++
>  .../selftests/bpf/test_kmods/bpf_testmod.c    | 26 ++++++++++++
>  3 files changed, 77 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_implicit=
_args.c
>  create mode 100644 tools/testing/selftests/bpf/progs/kfunc_implicit_args=
.c
>

[...]

> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +extern int bpf_kfunc_implicit_arg(int a) __weak __ksym;
> +extern int bpf_kfunc_implicit_arg_impl(int a, void *aux__prog) __weak __=
ksym; // illegal

C++ comment

> +extern int bpf_kfunc_implicit_arg_legacy(int a, int b) __weak __ksym;
> +extern int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, void *aux__p=
rog) __weak __ksym;
> +
> +char _license[] SEC("license") =3D "GPL";
> +

[...]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 1c41d03bd5a1..503451875d33 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1136,6 +1136,10 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_o=
ps_args *args)
>  __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, =
u32 id);
>  __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *a=
rgs, void *aux_prog);
>
> +__bpf_kfunc int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux);
> +__bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_p=
rog_aux *aux);
> +__bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, void *a=
ux__prog);
> +
>  BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
> @@ -1178,6 +1182,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilog=
ue, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10)
>  BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1)
>  BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_impl)
> +BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy_impl)

(irrelevant, now that I saw patch #8 discussion, but for the future
the point will stand and we can decide how resolve_btfids handles this
upfront)

I'm wondering, should we add KF_IMPLICIT_ARGS to legacy xxx_impl
kfuncs as well to explicitly mark them to resolve_btfids as legacy
implementations? And if we somehow find xxx_impl without it, then
resolve_btfids complains louds and fails, this should never happen?



>  BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
>
>  static int bpf_testmod_ops_init(struct btf *btf)
> @@ -1669,6 +1676,25 @@ int bpf_kfunc_multi_st_ops_test_1_impl(struct st_o=
ps_args *args, void *aux__prog
>         return ret;
>  }
>
> +int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux)
> +{
> +       if (aux && a > 0)
> +               return a;
> +       return -EINVAL;
> +}
> +
> +int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux=
)
> +{
> +       if (aux)
> +               return a + b;
> +       return -EINVAL;
> +}
> +
> +int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, void *aux__prog)
> +{
> +       return bpf_kfunc_implicit_arg_legacy(a, b, aux__prog);
> +}
> +
>  static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
>  {
>         struct bpf_testmod_multi_st_ops *st_ops =3D
> --
> 2.52.0
>

