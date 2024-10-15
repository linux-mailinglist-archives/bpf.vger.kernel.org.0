Return-Path: <bpf+bounces-42088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E8E99F5B5
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 20:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378D328144A
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9781B6D1D;
	Tue, 15 Oct 2024 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvz6ElOU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7AF1B6D11;
	Tue, 15 Oct 2024 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017378; cv=none; b=PvEbV3leoBE/rV5RJmkRs8FTsCKDowgjHS2bdC0O6R4m9qdvjEuuJls6B45eTbVHP62SiZAHMWd6nIAzMrdW/sjD7pv3f6K+OFyIwl2teLTo8GYgs6WY/0Vg9Dpm0rMgUhFbmWVhGIX6WBjcYEyhXHyyNOCiWFdvFpkEkg5foH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017378; c=relaxed/simple;
	bh=yNKksyNGQRjEC8ytyREQ7iMJkDnpET9UN4Qt41xw7dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1OlvlR3wiLWQI1YPVEQdPEYEmJlqYM0acubDkKpYMWIggMIgHDNAcahiiBCMBKjkEQmC1dBeB39CCeVHXrKTSN04cD3wG9gGCFsRYBunS3DIcw49mi0hdV8EkYJWqx8aU4yrrAQM0pX01hWXK7NrYcKnvmnzi8K4KYVVx8NrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kvz6ElOU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d51055097so3431444f8f.3;
        Tue, 15 Oct 2024 11:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729017374; x=1729622174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7q5eEEdHL0dWI89V6py6cPKMvtj8RQmT2g6+quRNSkY=;
        b=Kvz6ElOUI2FedJlTpW8cmWRSby/O6Ykzvp1NyI0v+ORPoS+ZLORIof2TEUdhggMZ9P
         gVeqiEULsRYV56rwxuiOFX9LMVR6iK58V0h6eQkaDnaF3/zzZE+oPH0S5mYeUFsWTNJq
         LuUd1OcSVEgKpByP/7NcwIGM6Ad+cV/9yWRlH0R6Ph+9G+dle32p0Z5bkeDJCORfkp5f
         Og1F7uZTSHf4LK9zHO+u72XHd53xwS0Ht73KEgYYHvMYojNWLz+WRloez545+vVcvmAl
         TUSu7jr8VHHl3Y0J8GzyQfDMjUuXgHCb0TBDTjnG+qlph51Sy/9dM9xDIEfIERvvdFYR
         3egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729017374; x=1729622174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7q5eEEdHL0dWI89V6py6cPKMvtj8RQmT2g6+quRNSkY=;
        b=QJ2536u7tBP4v1d8nnoZA01pETsRAHIpGEq/KwEHTqi75jIBqBWgzTu49Fnl6rZBw1
         zCEDrCAs7rtOiftEfkqjE2ykzadcsApNe49+IpqwVM92OeLoRgnIj9Ne0AZbT62v22Dc
         ABmqLoB65grHPEhYly9hA068IZP6lg7XHvsRpFv99/VV9fhLRdDuRSTZW5bk0XAbK6YI
         Mo6L7JOdTNx6odBptaq7JwjUgyViVQTrrl/B/UM4PT9K2WE3Bs6AlnTuvGBMg5v9OtOS
         i+BNy0vSTMBr5opmEvysHrM5cVYsIu07vwEIiNn3VtJCZuuUXAPBJRMGoyGGDVeTRKEK
         zccw==
X-Forwarded-Encrypted: i=1; AJvYcCUzFfL/VZO25RXcppMLm7P9YU9h7e3BtG1+pe7q1MRvwNG7aWOBqOM2eM4r7EOhEvxi49g=@vger.kernel.org, AJvYcCWvib9DiDbqeSoq4dqbeM1lQ+bRqR/vTFrSzj2E/0BidqHvHaC9gMU9ZyJ4AkVkYuAFHohRjeA3u0z8xjeY@vger.kernel.org
X-Gm-Message-State: AOJu0YyMGKz9Nm23F1XDINAvoiOWPWU1ILbiyIg3aPD12XntuVzolp/s
	78W3QbVLj1nLSsrYs1sHiN6SFzGuakfMr20Rqey4UIdQE6mcMD2+0CftYB4B3Uu91BjUQ44yTrY
	nSesyf4st3ugcP5/vlfcZNhXpxOI=
X-Google-Smtp-Source: AGHT+IE4tZcwjlIK0ZjoV3mK8y4/qf2Rvzx5itXTUvqKcrWs9eCIHm3hSbg6OoA8/znTqDqElp2h5eztY73UyfpqyFY=
X-Received: by 2002:a5d:4d8c:0:b0:37d:33ab:de30 with SMTP id
 ffacd0b85a97d-37d5fec99e4mr8386614f8f.8.1729017373640; Tue, 15 Oct 2024
 11:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015113915.12623-1-yangtiezhu@loongson.cn> <20241015113915.12623-5-yangtiezhu@loongson.cn>
In-Reply-To: <20241015113915.12623-5-yangtiezhu@loongson.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Oct 2024 11:36:02 -0700
Message-ID: <CAADnVQK6wgy0e5nW220sSDXzxkKcga8zpCDqKmDd=8xdooP37g@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] bpf, core: Add weak arch_prepare_goto()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:50=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> The objtool program needs to analysis the control flow of each
> object file generated by compiler toolchain, it needs to know
> all the locations that a branch instruction may jump into.
>
> In the past, objtool only works on x86, where objtool can find
> the relocation against the nearest instruction before the jump
> instruction, which points to the goto table, because there is
> only one table jump instruction even if there is more than one
> computed goto in a function such as ___bpf_prog_run().
>
> In fact, the compiler behaviors are different for various archs.
> On RISC machines (for example LoongArch) this approach does not
> work: with -fsection-anchors (often enabled at -O1 or above) the
> relocation entry may actually points to the section anchor instead
> of the table. Furthermore, objdump kernel/bpf/core.o shows that
> there are many table jump instructions in ___bpf_prog_run() with
> more than one computed gotos, but there are no relocations which
> actually points to the table for some table jump instructions on
> LoongArch.
>
> For the jump table of switch cases, a GCC patch "LoongArch: Add
> support to annotate tablejump" has been merged into the upstream
> mainline, it makes life much easier with the additional section
> ".discard.tablejump_annotate" which stores the jump info as pairs
> of addresses, each pair contains the address of jump instruction
> and the address of jump table.
>
> For the jump table of computed gotos, it is indeed not so easy
> to implement in the compiler, especially if there is more than
> one computed goto in a function.
>
> Without the help of compiler, in order to figure out the address
> of goto table by interpreting the LoongArch machine code, add a
> function arch_prepare_goto() for goto table, it is an empty weak
> definition and is only overridden by archs that have special
> requirements.
>
> This is preparation for later patch on LoongArch, there is no any
> effect for the other archs with this patch.
>
> Suggested-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  kernel/bpf/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 5e77c58e0601..81e5d42619d5 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1706,6 +1706,14 @@ bool bpf_opcode_in_insntable(u8 code)
>  }
>
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> +/*
> + * This symbol is an empty weak definition and is only overridden
> + * by archs that have special requirements.
> + */
> +#ifndef arch_prepare_goto
> +#define arch_prepare_goto()
> +#endif
> +
>  /**
>   *     ___bpf_prog_run - run eBPF program on a given context
>   *     @regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
> @@ -1743,6 +1751,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct =
bpf_insn *insn)
>  #define CONT_JMP ({ insn++; goto select_insn; })
>
>  select_insn:
> +       arch_prepare_goto();
>         goto *jumptable[insn->code];

That looks fragile. There is no guarantee that compiler will keep
asm statement next to indirect goto.
It has all rights to move/copy such goto around.
There are other parts in the kernel which are not annotated either:
drm_exec_retry_on_contention(),
drivers/misc/lkdtm/cfi.c

You're arguing that it's hard to properly in the compiler,
but that's the only option. It has to be done by the compiler.

