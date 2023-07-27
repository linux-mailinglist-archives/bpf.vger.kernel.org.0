Return-Path: <bpf+bounces-6040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B485B764695
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 08:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7967A2820E5
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 06:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BEDA95A;
	Thu, 27 Jul 2023 06:16:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E8F538B
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 06:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672BDC433CA;
	Thu, 27 Jul 2023 06:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690438614;
	bh=0u5dKLdzEDZbgSk/MVboHGJ1y2URwAqm+KVO+8/WIc4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YjMOO7/zK1ptmQ2eJZY2/w1CylXNT51YJPf7GZkK3Avtd16Eidc1G91BrftdPvVyj
	 PL6aMz+yZPq7hWCYLeJ+PYlL3/C4StQB971Lsr7Eepc+66vDP1kADVUlKq/Aro4vBH
	 lOZo0aU7lMGxU01RNg2C+j3g09HfCie5PFqVLcKmRQTab/iGVNOR6h6mTLcW4yZdXw
	 0EGhkSVtk67TMN/kkg2mkgLD1dbvfCfzkAoxpiWe3Wk6b/06QWV1Ht7VY16eacSHIL
	 yc4F/NbDaYXlXp/o8jGSPSsUTcDMo6GyauvyYJSyo5OdXw4HIgD6GfYcDlu46NCvKX
	 cb8Ey2/uFzLbw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so698555a12.2;
        Wed, 26 Jul 2023 23:16:54 -0700 (PDT)
X-Gm-Message-State: ABy/qLYNdtNkR6l/LEHHvyopc8tQhFdJ3NVKHrrNtnkd07vw0jKmPh4K
	0OrXFxNrVSz5MGUpfPcOGqJgpt94LWG8SQhVz2w=
X-Google-Smtp-Source: APBJJlGYnWtVs+fnABK57qFLoh/r+fFmn/JbZgwI3j6LEHG8OqFrjDwoQz1ZzQcxB6MJncvN/eFqINTm625RMLy8zRY=
X-Received: by 2002:a05:6402:31e8:b0:51e:4bd6:ce4a with SMTP id
 dy8-20020a05640231e800b0051e4bd6ce4amr1059655edb.11.1690438612612; Wed, 26
 Jul 2023 23:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230727042125.884988-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20230727042125.884988-1-zhaochenguang@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 27 Jul 2023 14:16:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Vn1Mf8L_+QaCJJaQLLxKe5Sg9tJ4A5KkDuupdnfQHDw@mail.gmail.com>
Message-ID: <CAAhV-H4Vn1Mf8L_+QaCJJaQLLxKe5Sg9tJ4A5KkDuupdnfQHDw@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch/bpf: Enable bpf_probe_read{, str}() on LoongArch
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: kernel@xen0n.name, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued for loongarch-next, thanks.

Huacai

On Thu, Jul 27, 2023 at 12:21=E2=80=AFPM Chenguang Zhao
<zhaochenguang@kylinos.cn> wrote:
>
> Currently nettrace does not work on LoongArch due to missing
> bpf_probe_read{,str}() support, with the error message:
>
>      ERROR: failed to load kprobe-based eBPF
>      ERROR: failed to load kprobe-based bpf
>
> According to commit 0ebeea8ca8a4d ("bpf: Restrict bpf_probe_read{,
> str}() only to archs where they work"), we only need to select
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE to add said support,
> because LoongArch does have non-overlapping address ranges for kernel
> and userspace.
>
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  arch/loongarch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 903096bd87f8..4a156875e9cc 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -11,6 +11,7 @@ config LOONGARCH
>         select ARCH_ENABLE_MEMORY_HOTREMOVE
>         select ARCH_HAS_ACPI_TABLE_UPGRADE      if ACPI
>         select ARCH_HAS_PTE_SPECIAL
> +       select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>         select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>         select ARCH_INLINE_READ_LOCK if !PREEMPTION
>         select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
> --
> 2.25.1
>

