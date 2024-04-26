Return-Path: <bpf+bounces-27940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63828B3CA5
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 18:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A051F239AB
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC375155726;
	Fri, 26 Apr 2024 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AejWEU4N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D469145358;
	Fri, 26 Apr 2024 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148382; cv=none; b=ejktTiorxbQ4dciF45c2GwyyPQIDqClNd8nFwhmeGaNbZMYxleTBjLakP8+ABsMqOYaFD4PBnKwEuXHj9zcQ68Z0buHTSpF8+w5hlVPXsbF8Qrr0u3uyamO39gv8G5cKOQdVKcgBGjoB44o+wNb2xEsla0eAcw/j+hahZ2HwpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148382; c=relaxed/simple;
	bh=HwkL8OKUFGsERkeuj+CuWC1Qzu1zI32HDrHYpOhNy6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfiDnzgaLKlmE72S5KFG61eo26MkL9nqtYoV0Ks0LlwEJkH0iMjA6sN8tItcSba6KrUU5L2jDi/qU/V8o8SS0A3no1RxZARHXitSkPTEZKnAeDxOsKs8Fb5Rm5gXTCTNUx3zXi4NzKAhDbQrwCuHVrl6LFm/8fgIyficSLj/7oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AejWEU4N; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2adce8f7814so2080280a91.0;
        Fri, 26 Apr 2024 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714148380; x=1714753180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wghl8cTYLCsjHaY+1Th9H2ml4EqegJN4rgOdkq35Y4=;
        b=AejWEU4Ng93sXllZcx3GkJh2VFJ5Q3P5/KzpQJmpnjSs1zbgHKthJSkuMx8EoCQvUW
         NvixzBmH2f+7p1QiA818gCyCDSntDxeqD5r/WQsop2BlvASYzlrFEnwzmc+VdTf/ivqd
         oaRYMSlpiCWDQpXCRKdz1OPl2hCSPPrBPBGeg6z9q5OHWniDzJWgYhA0IRw8V8r/u7Mq
         agPFkV4ncWXcJaXaJ20XJzG33MN3TOJ5LF8p8NFP9XD5evFU+6U0wuLuc7lSrUjdm/R3
         o33QsEc4oZVr6v24f3ixCyx6WzKShjH6RlFvKFVGIk3NyqCTcpF/yWWnoUu+H284E/1Q
         RqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714148380; x=1714753180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wghl8cTYLCsjHaY+1Th9H2ml4EqegJN4rgOdkq35Y4=;
        b=lBTSx4OP94CBZdnP38Jdsg7SsxxXlYQXNCbHOjmfPmg27CbXq3zHHBPHfnGtDObqSq
         22CIRx9rix79v6lfI5AVm3eXRT7HiZRePTYBkNhjMMDStIrDOOZsimc/dgFqj8TAUlDM
         8GLVIlc6YS19gGE85kAzvqhBFSehluFFc2JE99FuCW2Qg82xI9Zd74kaCDdPEb4RvybI
         Aq2D1kRcZ3soxt/BDFz8QKrAmQ1iQTRx26ttjBVQ0SBBAcdRpJ3LmFCfg3pn7v490Tkv
         hWZCgQkSAuZFmhJ5134+SaOH6wpY5C4WwhDqBZCjpV/z+SdBJAT9/qGRvXi8L67pkOmw
         yUVw==
X-Forwarded-Encrypted: i=1; AJvYcCWPAhVh0wAOlOUGYyx4XRM0GSpKWXibmmP8SduvsnN/52yliMklOiTeHD2DVmMjKa2PBIiyI7qNeU8yHeYMCQUoOPQPMy37KYy2Ym+ExMiSkGLoaR/e/ty8q/bCNZ03vfDi
X-Gm-Message-State: AOJu0Yxwnd5q3COGlVDbSGQ644DXGgxGJo3Dq8TNKKtVcojdOcl6xWki
	G4rzTOWYiHb3CNPhqFrWQY4XLaJKV2lJwUwJlsrYv6kYL0M1lNHoaPJ0AjWx/Dj0h7a3EN7lTTJ
	8Vu9QCkN8GDLYl/WhcWOdwzX5FvM=
X-Google-Smtp-Source: AGHT+IGP6Roi6SQ4z+nE9oWJpnJiO/4lGi/p2XudzgFog/blWP/iaoK/srxLJoCAQ4ni/kEXGCnym7tKmtfQM16AsRM=
X-Received: by 2002:a17:90a:bb09:b0:2af:3199:ad7a with SMTP id
 u9-20020a17090abb0900b002af3199ad7amr3129966pjr.6.1714148380325; Fri, 26 Apr
 2024 09:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426121349.97651-1-puranjay@kernel.org> <20240426121349.97651-2-puranjay@kernel.org>
In-Reply-To: <20240426121349.97651-2-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 09:19:27 -0700
Message-ID: <CAEf4BzbBBpsuCGgombEj1N8f97iKrMr2WXSoU8jOUfKSqLXnyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] arm64, bpf: add internal-only MOV
 instruction to resolve per-CPU addrs
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai <xukuohai@huawei.com>, 
	Florent Revest <revest@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:14=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> From: Puranjay Mohan <puranjay12@gmail.com>
>
> Support an instruction for resolving absolute addresses of per-CPU
> data from their per-CPU offsets. This instruction is internal-only and
> users are not allowed to use them directly. They will only be used for
> internal inlining optimizations for now between BPF verifier and BPF
> JITs.
>
> Since commit 7158627686f0 ("arm64: percpu: implement optimised pcpu
> access using tpidr_el1"), the per-cpu offset for the CPU is stored in
> the tpidr_el1/2 register of that CPU.
>
> To support this BPF instruction in the ARM64 JIT, the following ARM64
> instructions are emitted:
>
> mov dst, src            // Move src to dst, if src !=3D dst
> mrs tmp, tpidr_el1/2    // Move per-cpu offset of the current cpu in tmp.
> add dst, dst, tmp       // Add the per cpu offset to the dst.
>
> To measure the performance improvement provided by this change, the
> benchmark in [1] was used:
>
> Before:
> glob-arr-inc   :   23.597 =C2=B1 0.012M/s
> arr-inc        :   23.173 =C2=B1 0.019M/s
> hash-inc       :   12.186 =C2=B1 0.028M/s
>
> After:
> glob-arr-inc   :   23.819 =C2=B1 0.034M/s
> arr-inc        :   23.285 =C2=B1 0.017M/s

I still expected a better improvement (global-arr-inc's results
improved more than arr-inc, which is completely different from
x86-64), but it's still a good thing to support this for arm64, of
course.

ack for generic parts I can understand:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> hash-inc       :   12.419 =C2=B1 0.011M/s
>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/arm64/include/asm/insn.h |  7 +++++++
>  arch/arm64/lib/insn.c         | 11 +++++++++++
>  arch/arm64/net/bpf_jit.h      |  6 ++++++
>  arch/arm64/net/bpf_jit_comp.c | 14 ++++++++++++++
>  4 files changed, 38 insertions(+)
>

[...]

