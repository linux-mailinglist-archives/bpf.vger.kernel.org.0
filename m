Return-Path: <bpf+bounces-69687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF76B9E87E
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 12:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDE81BC1727
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 10:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106302EA179;
	Thu, 25 Sep 2025 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="me7MDBbx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB652882B6
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794477; cv=none; b=FPt4EoF+2WT/mNviZH2FynsXWSkSLw+RjtXYwSBgT9JhiNDrZF1clb7BvN9VHvvlB47ux820dsbloI7qiRg4q9TMnMHNQDf+h9BcwZysiG22WQuNwa8yDDblw9/uV/gTycMzO3+CZS5MCPIqjSBTIRwrn3NO3UGzTYXAR2LWVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794477; c=relaxed/simple;
	bh=MmaMbvm0BD9NGLBFscAIFMVqjCmdg8rnqQ4WZdh20jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYEZrzTX0piqOE6rBC15iYT6CMHUuUf+A1xwYYihEO1XyLdOLwJs4cqGeu8lECtrkwJWB3IB7eYgiGcGMy/ZF4rqckQ5pnHwD+MNz8SFxfJRGDQwrxHMvYYevyv1cMC1BRoPxErF1dMfk6GxiUhFgztQQckn1bgkUFRLyt3aRTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=me7MDBbx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso493944f8f.3
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758794474; x=1759399274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ua5lAPnVTXrXgCW85PYKdWzoS2UhfrJn6AOwiqTs+L0=;
        b=me7MDBbxXUkYk/48dM6L9kTINAkz84AfsffG60w0KJNtx+nUhhY4FmKUe6Jxn+crey
         vwnxtgb9oK7oH18SfMCxe6x6Pby2cafFqcH90iVfo3sm1+sUfO/8t7z+yAJrKS/JT5eO
         Yw8SZk98nZKQo5sM2S8SO3jZBO0FtSLbJ2c4rN98oia5IzrO6OxKedsT27UHZ4siTGvU
         qm8OZLLUCPtWgfuaxAgwHfdSAoiUPJO2N+HJR3jFUMsbwcVbRnPhibW8RCTYFvargrzH
         LQHqlfQvXHyefM0VGiAsjmd3j+RrspBg9Na2TwlRvXbm+Gjf4i5SvI+L95NlMrfm4Pgl
         DBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758794474; x=1759399274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ua5lAPnVTXrXgCW85PYKdWzoS2UhfrJn6AOwiqTs+L0=;
        b=aI8lOIO7fL9EaTmsisymBGfB96Ht04ux9AkLnXgyjmGPC0T2oiKt0citfPYQri144t
         CMOFWPADT+KAK/wKNYLTLbflOun8UWq0Z+Z3F/dTLFRWHOmI6U2p8OPSM57eGV1Kzyb1
         4g6GfM/lftYjj+I6vUD71We26x+x4ptnfNUzSPVhAJNb1ierlzCAu1ihdPYAj2y2y+UR
         KE+Ttr2rpC0QafS7kZI7NOYQe4XgHLcoD5tDuS+MDRHiqzuzHuW5xod7cue8VMB6XDN4
         DRQOzVd2D544o1hU8bZjGPlF+m0Tm7VkEieox8Rr9I1Xv2fCxKTl+9LsqPNo5C0OK1lw
         E7tQ==
X-Gm-Message-State: AOJu0YyUyFS99YfpuRQNOLwj4qzXeWOXBKejXuUJB8TMoW3mYk61v1SI
	ycExD1NDgSCOGJZBlhZtxflo48AAbg61GViY9+EkW+OkxK2I1V8/aJJ+f2+d+iqWJEJ0Dshz5tu
	IVTXtei0RIZ8uoOt1QcknXP+kdNDp3YM=
X-Gm-Gg: ASbGncuRrO3zt2qpNCqFiuSERuK5wO7Vxuw4hVijYnpjS3g5waGPslL0rX/n18VRMwe
	4J8iAGWT/qXUMtz/noNgGC8BFLbgFucVcDIV7PlUn+JcOlEgmOEYLRP/W54Y8ibYwrlVvW4KBSt
	e04O+tMmwdogO6n51wivkYM5+MsgTM0nTUm9AdCudV9c3VbhV09rWh7myhShN6CoqU07wBUF2sQ
	FwQfQ==
X-Google-Smtp-Source: AGHT+IGtR2czsdkyEmAICV40coZ6c28sg3u9AZr4AKSP8hxkY5faznN8s+d+okKrk1LIYnfpOO2+/acK3rYiukENt30=
X-Received: by 2002:a5d:588c:0:b0:3ee:15b9:97c4 with SMTP id
 ffacd0b85a97d-40e4cc63177mr2528966f8f.52.1758794474154; Thu, 25 Sep 2025
 03:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev> <20250924211716.1287715-6-ihor.solodrai@linux.dev>
In-Reply-To: <20250924211716.1287715-6-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Sep 2025 11:01:03 +0100
X-Gm-Features: AS18NWBuk_kSerlDHBMCegasZ7D_viImTdL1RG35VfP-zH03EO5RnHpv-wkb75c
Message-ID: <CAADnVQLVeZd0JOz-GBgZfi=t5kvtH_z1Ri2w6b-AW7DHgEBv5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/6] bpf: mark bpf_stream_vprink kfunc with KF_IMPLICIT_PROG_AUX_ARG
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, dwarves <dwarves@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 10:17=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> Update bpf_stream_vprink macro in libbpf and fix call sites in

't' is missing in bpf_stream_vprintk().

> the relevant selftests.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  kernel/bpf/helpers.c                            | 2 +-
>  kernel/bpf/stream.c                             | 3 +--
>  tools/lib/bpf/bpf_helpers.h                     | 4 ++--
>  tools/testing/selftests/bpf/progs/stream_fail.c | 6 +++---
>  4 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6b46acfec790..875195a0ea72 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4378,7 +4378,7 @@ BTF_ID_FLAGS(func, bpf_strnstr);
>  #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
>  BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>  #endif
> -BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS | KF_IMPLICIT_PRO=
G_AUX_ARG)

This kfunc will be in part of 6.17 release in a couple days,
so backward compat work is necessary.
I don't think we can just remove the arg.

> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -316,7 +316,7 @@ enum libbpf_tristate {
>  })
>
>  extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const=
 void *args,
> -                             __u32 len__sz, void *aux__prog) __weak __ks=
ym;
> +                             __u32 len__sz) __weak __ksym;

CI is complaining of conflicting types for 'bpf_stream_vprintk',
since it's using pahole master.
It will stop complaining once pahole changes are merged,
but this issue will affect all developers until they
update pahole.
Not sure how to keep backward compat.

