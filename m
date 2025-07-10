Return-Path: <bpf+bounces-62889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58849AFFAE2
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 09:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6EB177F46
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 07:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB67328936C;
	Thu, 10 Jul 2025 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld+S2lcg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083528751F;
	Thu, 10 Jul 2025 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132558; cv=none; b=TrghbSL5mROnI5iIxOCMAtTTCxYBULtIFHggvkKLcqMl/7Xn9pTNgm/O9cHa0T3fcUqbTJvDqe2sb5eHR8UtjJ3KSTq+IDyQ7lUfM8LFBjlBCMwlXYzcAt9ubFAgoOmhNIupCf6qQsMV27tUD2HbhS5cuB3oe+79pgChVqfdKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132558; c=relaxed/simple;
	bh=lLFwpKOTsYuOe3kYj8LTN41RY9+dACj4r9I2JiSYunA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPmTe292pj4YKVbF3fXYNaz2zYBefh2EGMWWd1pJRt3ayDFJsRFUi4IhYuubkqmIn+eyGT28r4S/6daI/W+yj2Xt5oA74F1vy5PKLq1dNM4JmIEKccq1Qsp+H5uJE4/eylfegkeG1Ny6YKGgosAWexNYn6M7t1Cf55zHRCkbDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld+S2lcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3731C4CEF6;
	Thu, 10 Jul 2025 07:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752132557;
	bh=lLFwpKOTsYuOe3kYj8LTN41RY9+dACj4r9I2JiSYunA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ld+S2lcgBvZq1Iq9vx/pcngfPg+dijinRCQEiWAZOJM2x/igpXg0bnrfD5JJjP+Oo
	 VkUmwqq1wCSLoQaD8Vy8zSTmYZvSClWYUKo939JFrmoJWJqGd8e94GDIO7/OEgx7CE
	 zXO5BpV1h1hwDrkBQ2eD8fTLMFM2iTrsxA+bI0nR9s5+lkEhsqz7ufsFeqyGWh9Dmq
	 gRPS9taD9els0g9K6x7UywAg60TOfud28IL4Zeo0ElMhichJQCB08ldca3YAIaSBi9
	 41AGrW4TjQ1N4agzJDLreidoi5aewE40K69bL7wdib4uS1jLh+dvK6whNcglIPQwZr
	 UCpxj5JMptPMA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so1416359a12.1;
        Thu, 10 Jul 2025 00:29:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0G8rf/xsfBsmIGRvu+d65B/kERdS6Ja9x91w0qepYi1rTfzt+DxgboCSctIETxpv7HuG1qNZWapR6X3t5@vger.kernel.org, AJvYcCUACdIbXUUyRuOZ93D7dAq9nPUpWOVon5p9z99CUgLrxibAkbiakNRyHfcx9NOvuw58j44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQt9ehcPgd9TstFqSK8RZe11e74xLeXwWc/Uut8SUUBY3BbeTi
	egKdHrQWOpEm1w84z5JhX8ASPfCW2Dvuk1WTgy/8cc0iYKCQp+7C1EwS88DL5N2ThF5OtrcvKh8
	hfnktQCYhef80ptZZUgmtzC361zFMIxE=
X-Google-Smtp-Source: AGHT+IHzof8NaUfDdDnP7TgtCX5h262vfE6qHIFSIrx9RdxqYzOXcxPfAw96KImBWf81z7VoI6U5h02DfQeD3ddfSYQ=
X-Received: by 2002:a05:6402:2696:b0:60c:6a8d:8511 with SMTP id
 4fb4d7f45d1cf-611c1da3fb7mr1963630a12.12.1752132555470; Thu, 10 Jul 2025
 00:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709055029.723243-1-duanchenghao@kylinos.cn>
In-Reply-To: <20250709055029.723243-1-duanchenghao@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 10 Jul 2025 15:29:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5EWp+h0R=YuTivEZEK0diDT+U2u--RPdhtYYr_KB4Z4Q@mail.gmail.com>
X-Gm-Features: Ac12FXxigZp079odwKaNADsHQGhn0sj-dnFuYku5Zvn7n6k1t9iVXJEdm5hKmcI
Message-ID: <CAAhV-H5EWp+h0R=YuTivEZEK0diDT+U2u--RPdhtYYr_KB4Z4Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Support trampoline for LoongArch
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, hengqi.chen@gmail.com, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu and Hengqi,

Could you please pay some time to review this series? I hope it can be
merged to 6.17.

Huacai

On Wed, Jul 9, 2025 at 1:50=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos.=
cn> wrote:
>
> v3:
> 1. Patch 0003 adds EXECMEM_BPF memory type to the execmem subsystem.
>
> 2. Align the size calculated by arch_bpf_trampoline_size to page
> boundaries.
>
> 3. Add the flush icache operation to larch_insn_text_copy.
>
> 4. Unify the implementation of bpf_arch_xxx into the patch
> "0004-LoongArch-BPF-Add-bpf_arch_xxxxx-support-for-Loong.patch".
>
> 5. Change the patch order. Move the patch
> "0002-LoongArch-BPF-Update-the-code-to-rename-validate_.patch" before
> "0005-LoongArch-BPF-Add-bpf-trampoline-support-for-Loon.patch".
>
> -----------------------------------------------------------------------
> Historical Version:
> v2:
> 1. Change the fixmap in the instruction copy function to set_memory_xxx.
>
> 2. Change the implementation method of the following code.
>         - arch_alloc_bpf_trampoline
>         - arch_free_bpf_trampoline
>         Use the BPF core's allocation and free functions.
>
>         - bpf_arch_text_invalidate
>         Operate with the function larch_insn_text_copy that carries
>         memory attribute modifications.
>
> 3. Correct the incorrect code formatting.
>
> URL for version v2:
> https://lore.kernel.org/all/20250618105048.1510560-1-duanchenghao@kylinos=
.cn/
> ---------
> v1:
> Support trampoline for LoongArch. The following feature tests have been
> completed:
>         1. fentry
>         2. fexit
>         3. fmod_ret
>
> TODO: The support for the struct_ops feature will be provided in
> subsequent patches.
>
> URL for version v1:
> https://lore.kernel.org/all/20250611035952.111182-1-duanchenghao@kylinos.=
cn/
> -----------------------------------------------------------------------
>
> Chenghao Duan (5):
>   LoongArch: Add the function to generate the beq and bne assembly
>     instructions.
>   LoongArch: BPF: Update the code to rename validate_code to
>     validate_ctx.
>   LoongArch: BPF: Add EXECMEM_BPF memory to execmem subsystem
>   LoongArch: BPF: Add bpf_arch_xxxxx support for Loongarch
>   LoongArch: BPF: Add bpf trampoline support for Loongarch
>
>  arch/loongarch/include/asm/inst.h |   3 +
>  arch/loongarch/kernel/inst.c      |  60 ++++
>  arch/loongarch/mm/init.c          |   6 +
>  arch/loongarch/net/bpf_jit.c      | 491 +++++++++++++++++++++++++++++-
>  arch/loongarch/net/bpf_jit.h      |   6 +
>  5 files changed, 565 insertions(+), 1 deletion(-)
>
> --
> 2.43.0
>
>

