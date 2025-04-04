Return-Path: <bpf+bounces-55354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B59A7C4FE
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 22:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5283E7A64E0
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 20:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235D522068E;
	Fri,  4 Apr 2025 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPFsC3qu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED618B494;
	Fri,  4 Apr 2025 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743798815; cv=none; b=Uv2ARxWtDWxtIUBhY3vx4fvPhSYjgebJNC83wHUF12qhvThdjeZ053cLqON0/qFzyTuWTlQVtvUGz6G2XEY+Jl10ZVTxFxI5oH0oAtWwEVp2dnQNfp+EmkemXA1O8AxpVxa4k+vK8bXp6Ld2i5q2NdNkq3vSCp9PZ+DpVvI7oPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743798815; c=relaxed/simple;
	bh=2xMTOpHaD6Tq4PduBp3zFPy0iV5QymlDq8gdScBz35k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6gzIdZcaJ9lzpmDaYsoFAKq5WFlscSSdtgMzeNX9JwxYkMb3Juz456DsBJLKRO3hG+xEKYGzcINfZWveXU5JPt+HDJferDCIZOkRnNRwISzmfMvDKkh8Uji5KlCeE267a3Wl1lpi4UeAkECe9SRQOVqm8ZDFSOUUcQhbI6fZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPFsC3qu; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso412313666b.1;
        Fri, 04 Apr 2025 13:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743798812; x=1744403612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6O94xchGE6Ra4ULfDNFEhmXB7lbzxKyrsf60rukico=;
        b=JPFsC3qukfGPOjXz8fsONx0NEmSTNZuPtjSaCfP3UT3/ZkwC3PN6rbdZJP3IpPGvXS
         SCME1QSHCyOwPkxaWahDjW3MNaQHCoF+5H5JY0Uf2BjKk6x+YPmOvx42Y8z+zKdxCiBB
         vfABI2ylvCQ4ORTRC1ScMkaRw+WwTfXobUfUoee2IKH2CUuCApbuVqTlgkOr4QUwpsMI
         HNboAjubnD/oNMQfSuLdqPXJ382w+tN2Zog6BMwLN5oAodFQEwGNsUA8mdqSkwHagOsM
         g36hMVXNVZTBDXtf7o670sMP+gy7p00ypDD3nhCK/7/N65B0IQb1MVX2W5K1CwVu+rmB
         K4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743798812; x=1744403612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6O94xchGE6Ra4ULfDNFEhmXB7lbzxKyrsf60rukico=;
        b=TOPE6hPrxL0e8849PE1Y3bBncN4afTV9ZXp4cJFYiKtpWmqJyuUmcXVaqglWrQz+L6
         15iIIzprBwG6S4k0SkCPbGm23HbucOyduU1PrT/dGI+a/FKY2V4zz0xJi6q+4G9WDIEf
         LZ44PzcqhoLmD9aP9aPBu7wWTv90/E9FPrPbgKGhb0OAZjqjE/GNBvs0CWpqrhSgKReF
         7BcVm0nKa4cefOP6Lp3hbTcPTzxpkz80ylOobDepiAG5H3t4g78YM7XVsUjBxmQKV59R
         Evfgt0ggynBSxB6W3mNsA4nFUGEvj+pkccv+4y6PNwA6Xpk3e/1ynHzg8hQp79UiEjQH
         ygdw==
X-Forwarded-Encrypted: i=1; AJvYcCU+2uTkZwOmjNTEPgXjgnG/1vZ5KSzUI/vJqgahTRyDMF4THVHcG72GGMZFIqaOKzrXCkn7/+ouEnYQw3QE@vger.kernel.org, AJvYcCUcNJnqIu9AkZqAoM5sLQEmWGaWnpUC72OrLAy3mgTPq4FV//TdEJJrw84kqpCfsRGfMsVMMaDBkg2F79UbeQv3q7nc@vger.kernel.org, AJvYcCWB/C16KUM8gWmcpZVgVI1fP9ns+zsmf4gaiPuVR6rPnX5vP4GIlmiLXOVB+5W/AAxMRMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nGATXJteVHfO/Y4gD4aPYDGynDJXHrSoxNNyLIFqSgD1w1cZ
	ALNHvaAJImhLCg/DFeAWJyAeTMpyqEc4PBY1zypdQJU2y/g4eL9cOn+DxOCJ4U+SwfLP13kh9El
	zkkw8eLmEvHC9HxCQCFR4rFzbM+Q=
X-Gm-Gg: ASbGncscKuYlQfDap5xxuglll4g7o8mIJHY+C1GUGwcEDz09iTdTyw0AkWEgg8RsFrC
	5DPorTAUL24EmEe4WoLB7Ch+Cr6ri46kvbZ7g5W3/dZ5so4l6UoZzbsSZGsLq2Nhhe084zk8NW8
	578eeA7OwMfIXDurXsGcK7cUCFQpo10B3magwucBkruw==
X-Google-Smtp-Source: AGHT+IHhZr4vL2yJq+ZUyxUpJe7kYWa2YtibNG/wlE/aYWLozXIBBPOglx5HMQtbZ2THvFyhrIzmivFIkzpKVXC6ds4=
X-Received: by 2002:a17:907:1ca8:b0:ac2:6910:a12f with SMTP id
 a640c23a62f3a-ac7d6e3ce0fmr345768866b.46.1743798811928; Fri, 04 Apr 2025
 13:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320114200.14377-1-jolsa@kernel.org> <20250320114200.14377-11-jolsa@kernel.org>
In-Reply-To: <20250320114200.14377-11-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 4 Apr 2025 13:33:11 -0700
X-Gm-Features: ATxdqUEKShCAghH7mYNzt8B7VsHCVh2-bYrl3TK_wDgvAaUUlneedLO4gOiW1Eo
Message-ID: <CAEf4BzY8z8r5uGEFjtNVm0L2JBwQ1ZPP2gqgsVqheqBkPiJ-9g@mail.gmail.com>
Subject: Re: [PATCH RFCv3 10/23] uprobes/x86: Add support to emulate nop5 instruction
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 4:43=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to emulate nop5 as the original uprobe instruction.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>

This optimization is independent from the sys_uprobe, right? Maybe
send it as a stand-alone patch and let's land it sooner?
Also, how hard would it be to do the same for other nopX instructions?


> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 5ee2cce4c63e..1661e0ab2a3d 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -308,6 +308,11 @@ static int uprobe_init_insn(struct arch_uprobe *aupr=
obe, struct insn *insn, bool
>         return -ENOTSUPP;
>  }
>
> +static int is_nop5_insn(uprobe_opcode_t *insn)
> +{
> +       return !memcmp(insn, x86_nops[5], 5);
> +}
> +
>  #ifdef CONFIG_X86_64
>
>  asm (
> @@ -865,6 +870,11 @@ void arch_uprobe_clear_state(struct mm_struct *mm)
>         hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
>                 destroy_uprobe_trampoline(tramp);
>  }
> +
> +static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
> +{
> +       return is_nop5_insn((uprobe_opcode_t *) &auprobe->insn);
> +}
>  #else /* 32-bit: */
>  /*
>   * No RIP-relative addressing on 32-bit
> @@ -878,6 +888,10 @@ static void riprel_pre_xol(struct arch_uprobe *aupro=
be, struct pt_regs *regs)
>  static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs =
*regs)
>  {
>  }
> +static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
> +{
> +       return false;
> +}
>  #endif /* CONFIG_X86_64 */
>
>  struct uprobe_xol_ops {
> @@ -1109,6 +1123,8 @@ static int branch_setup_xol_ops(struct arch_uprobe =
*auprobe, struct insn *insn)
>                 break;
>
>         case 0x0f:
> +               if (emulate_nop5_insn(auprobe))
> +                       goto setup;
>                 if (insn->opcode.nbytes !=3D 2)
>                         return -ENOSYS;
>                 /*
> --
> 2.49.0
>

