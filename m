Return-Path: <bpf+bounces-6029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09DB764376
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 03:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A9F282054
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 01:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320D215B5;
	Thu, 27 Jul 2023 01:42:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3477C
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 01:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC14C433C8;
	Thu, 27 Jul 2023 01:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690422172;
	bh=fnyD6OA/d3s1ns0TdP0ragt14ud6rvUe8gaOSFG9Xis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jTCWd/B5ufFb66j65JX4gQqtRFhJIASJOyKF0W2fTymwPeWZsPKVhuFpGRoCu1ETw
	 L3eptu5be5CR3eEZvfBUEE6BtkSUe9Bw88z/4xBPeIJtfzrWKgaddCUWcIQx5Hu1Ao
	 w505jfZiGHsxF+wDAuYJd/gLigChV31jIphry54HsLlLuzd13ofJZCXcbBdu++UOgz
	 Ms1v6FK4c8ck/LkPpQXV0PaLPVeXMFFRmQepkO2zFY49yaPKWfUjlNdc3+vg6EjtyZ
	 1spKhu59rdRhaJlUX09lWZbHuDajLSZ+h3V3c6/ntDGpS90oDJj5Q/axAKXqvl8m6w
	 pIZ23lXWm06ew==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso706025e87.0;
        Wed, 26 Jul 2023 18:42:52 -0700 (PDT)
X-Gm-Message-State: ABy/qLYWa3g2qS168zuvmyMPMWevnRo2KMfLimvREo6bN5lbg0/TwaQF
	RWJoZe6vtXfAYpKAQ/WJrVR2sMD3+rBvjdxXtLE=
X-Google-Smtp-Source: APBJJlEn7GDtajpdztTUz0vSEGQIXdTAPROIGyBvbE/CFlfx6C330B9ytc1hr3TXbd6Uc4zNKYm2knSsOcB7rZbv/8U=
X-Received: by 2002:ac2:5e6a:0:b0:4f8:49a8:a0e2 with SMTP id
 a10-20020ac25e6a000000b004f849a8a0e2mr444073lfr.16.1690422170176; Wed, 26 Jul
 2023 18:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726062902.566312-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20230726062902.566312-1-zhaochenguang@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 27 Jul 2023 09:42:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5avspxtEQ7_bEXoLGK5q3AK0-nbw9JGs6QttkmLG5dYA@mail.gmail.com>
Message-ID: <CAAhV-H5avspxtEQ7_bEXoLGK5q3AK0-nbw9JGs6QttkmLG5dYA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: eBPF: Restrict bpf_probe_read{, str}() only to
 archs where they work
To: zhaochenguang <zhaochenguang@kylinos.cn>
Cc: kernel@xen0n.name, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Usually, your E-mail format should be
Chenguang Zhao <zhaochenguang@kylinos.cn>

Huacai

On Wed, Jul 26, 2023 at 2:29=E2=80=AFPM zhaochenguang <zhaochenguang@kylino=
s.cn> wrote:
>
> When we run nettrace on LoongArch, there is a problem that
> ERROR: failed to load kprobe-based eBPF
> ERROR: failed to load kprobe-based bpf
>
> Because ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE dose not exist,
> so we enable it.
>
> The patch reference upstream id 0ebeea8ca8a4d1d453ad299aef0507dab04f6e8d.
>
> Signed-off-by: zhaochenguang <zhaochenguang@kylinos.cn>
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
>

