Return-Path: <bpf+bounces-76387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B13CB1F46
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 06:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBBB030F19FC
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 05:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A178B2FF166;
	Wed, 10 Dec 2025 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6BfMXLH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31644277011
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 05:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765344027; cv=none; b=LkdaVEy4pv7851SJvJx0Q7KnE3iB28XOklG/B0jBnPwa8PcJu1TMD4E4w/KzsW8jyCtj/L/SsCzClRXZBPu0NcZXXgRWOurL+3XOvGbmybYI5lPfrxHVgzYc0KyUJXsi4z8HZoqifhiI5LxT+n4omltbLA0DxUYarFEQuuZv6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765344027; c=relaxed/simple;
	bh=36JAm4JT2uwBM+bb3O6Q9SIhA21ce2+gIQYNjKTV3ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9nCskCKU7rtJHy1trEFvE46FaOiUbIqYSKfHoYxvtkC8pfER7PhjJEpjx+T66CcMF6rtA6txUe3eOQrhaASx7CBg24tAP35MogQKPp/8RJr2t+y4kX1QXJs/LC/ZvPbFB1WBrGBwgZ57VNHExUKr82vVuy6ZmOY7HjBRKGFhco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6BfMXLH; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3ed151e8fc3so3854416fac.2
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 21:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765344024; x=1765948824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MI57r/4C01JUyGYeR4BSsNymItfnMrs+OYwPSvLtYs=;
        b=R6BfMXLH4yIfjrrYAGVvEffvHJrqEFqHRP9VqrCZXsphIhCO+bRWsJljoRgPopeGBe
         iUB7hKToHlv8gepilIgWkqepKVrt2a66YAIiHYB0bm+SXkJ/IUi++R509z5TYWu0LB/L
         u7l2yrxyfN5KKmvtJbYA7pU0zTytchhgLait2kc0nZKUOKyHA3T6j8u5sBfNDMJ+y6u0
         ksNOzVhDLR+KJzRFqsLrKlHWEwv7bLcdsnSsRjg0Zh2ZBW9phLvifbTg0E/9TmaHmhYv
         8I3EN/9tUi0he2OWevVnLjJeVLwD2nJS6z9ehnfpSEhHhLzB28AgUBPs03jWIYkOr0Te
         4WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765344024; x=1765948824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+MI57r/4C01JUyGYeR4BSsNymItfnMrs+OYwPSvLtYs=;
        b=cbQ1nzmU3kcnAijiHRkpLS5yKtyV6doqu/HEG5DSYGCtbk1sFEA8VeY2EbPBFDrcyg
         G/uBV0OCJ+ziE1AU862H72ZtCHs+1k9mEfGuDsKXmsbik4/Zr0ZTGhQ31IR9QYqf7NVa
         MZg8N8nqmwuLzdcRYY7KFx/tnv2uqQXiw3BjDzjac/+zOVcHPZE1QAZZjAsxYOZHXmLB
         CJsEUCrS+1GLj8tCtwca2jUf8kaKz5VEWQyM0TocUY1PZIqQcALLCEjmJmp+33iTc5jq
         sEXdvwdGdX6DxpgBQvlFYRqXcyc2ew3r0knpeLFvbyWFHnN5NaGM+L+NpQ4GtELIzmkV
         ptoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO46lWnVgzuJtOWGwbwJFbaIVUDbNCKgp7TuXYfd0U3aEawPgH8j8N83urF7ovIw+Vhaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl6Ddb6ipP4BLqqqMdwitNZ3FhOBYJG+bs5Itzz5wSFhR//V3O
	4EjW0kiiiuaDi9eOLKozvfWU8H8lwbaLRGv80Mg9Ejg74IZ+ikzr5a1gutR/5Fe6EMJ4WeWJuHT
	9D2YGnFpJqrE7A2LIic8dAr8gM4CcrEBmmbfv
X-Gm-Gg: AY/fxX7Jq/HHtZqSCu/yCrT77KhuMqAagySDCLP2zuP6XBbCB29TeBucm93RY/zjABR
	+jPE1yLTzRM8uTo6ZzPwNMG2teJTw2gNCnuQxNQ9MvBURbq0BMFHGow7lPBf+eE8xygNh/G5E1u
	YDgt9AcFkpLv9Qyf3fqFGMWJeSEJQUoL2kFniTsoe/RIPdaKWMPsVh0wyXF4Rl9tgLXFe6r10ta
	DVSZ4N24tC7hD2oG5Ey8Kfzst6eIhFmvO7qrD+LNe6kY9ozqHoqwanpNe+R/aXFuYuoSLY=
X-Google-Smtp-Source: AGHT+IHhKhJmFdS8xyCy6z3Pkylyl7fWGqizcviH0fzd0aI4tvxpR8T/c7m8hrtKlyhMuKPzpw1y2E2oRE3Z7worROM=
X-Received: by 2002:a05:6870:1b13:b0:3ec:3c21:9301 with SMTP id
 586e51a60fabf-3f5bd978f9bmr1020661fac.9.1765344024262; Tue, 09 Dec 2025
 21:20:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209093405.1309253-1-duanchenghao@kylinos.cn> <20251209093405.1309253-3-duanchenghao@kylinos.cn>
In-Reply-To: <20251209093405.1309253-3-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 10 Dec 2025 13:20:12 +0800
X-Gm-Features: AQt7F2qWYB7VvJgjzUwsobmq_rC5o9JSMEkf2SA8b1drgVcmKcM81PVXKQ8gQ_k
Message-ID: <CAEyhmHTtEE6cnm18_WC+d+o4RnLUw+BUUNL54R6d9W2b868+LA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] LoongArch: Enable BPF exception fixup for specific
 ADE subcode
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: yangtiezhu@loongson.cn, chenhuacai@kernel.org, kernel@xen0n.name, 
	zhangtianyang@loongson.cn, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, guodongtai@kylinos.cn, 
	youling.tang@linux.dev, jianghaoran@kylinos.cn, vincent.mc.li@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 5:34=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos.=
cn> wrote:
>
> This patch allows the LoongArch BPF JIT to handle recoverable memory
> access errors generated by BPF_PROBE_MEM* instructions.
>
> When a BPF program performs memory access operations, the instructions
> it executes may trigger ADEM exceptions. The kernel=E2=80=99s built-in BP=
F
> exception table mechanism (EX_TYPE_BPF) will generate corresponding
> exception fixup entries in the JIT compilation phase; however, the
> architecture-specific trap handling function needs to proactively call
> the common fixup routine to achieve exception recovery.
>
> do_ade(): fix EX_TYPE_BPF memory access exceptions for BPF programs,
> ensure safe execution.
>

Which bpf prog triggers this code path ? Why didn't we trigger it before ?

> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  arch/loongarch/kernel/traps.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.=
c
> index da5926fead4a..9ca8aacc82b8 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -534,8 +534,13 @@ asmlinkage void noinstr do_fpe(struct pt_regs *regs,=
 unsigned long fcsr)
>
>  asmlinkage void noinstr do_ade(struct pt_regs *regs)
>  {
> -       irqentry_state_t state =3D irqentry_enter(regs);
> +       irqentry_state_t state;
> +       unsigned int esubcode =3D FIELD_GET(CSR_ESTAT_ESUBCODE, regs->csr=
_estat);
> +
> +       if ((esubcode =3D=3D 1) && fixup_exception(regs))
> +               return;
>
> +       state =3D irqentry_enter(regs);
>         die_if_kernel("Kernel ade access", regs);
>         force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)regs->csr_badv=
addr);
>
> --
> 2.25.1
>

