Return-Path: <bpf+bounces-46909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C219F183A
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE3D1680B5
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B39119992C;
	Fri, 13 Dec 2024 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMh14QoB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B271193086;
	Fri, 13 Dec 2024 21:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734127124; cv=none; b=be5Ru5KC8dc6c4traRPP+KyW1yeHREDj53wClUpPBIzuws77zggJVfCzsr8BpqA4dgvLvJ8V6pPP2wghP2drKsn9SALkahzHJtODQLUrAgTnvRlkkpDMiuat+rSbficK6dIvrtwl0RWoxrNXyN4duBHw90l1+9Df2Od0mDKSn7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734127124; c=relaxed/simple;
	bh=6IAQZGa0GZIInzyIlONp5PcMY86BGx8S0+adIFtCNa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Exhqa7dGQoDbPDtgyGytGDoMI5P6Imcp/aoOapnadHSQrOJFvpTLkfdxlUd13cxFfZphjejRqrdbtnmKunSYKbmOtan7gbRFcuQZP4NKjS3Y3Ic8KrDr52tjMd2NY5gaatIWBaHrqhLe8+2DFC67UDLQv0490PoLsJUBoDHMjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMh14QoB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso1158181a12.3;
        Fri, 13 Dec 2024 13:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734127122; x=1734731922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVIQfn2DuUe+t1JDFpP5D8sI2DkLpoJC4fJAHJRvOMU=;
        b=ZMh14QoB4nQOutK4rCaFByeDYgdrfmDwIPNFXYJYUQP2Q1tvcxf9R27SOubMuYas7B
         zEMha9OnudAdxhaHLyFiT2F+SAQIkkkyiXDu93AsTU3m9bwSkrobViPUSF1SFHAEv7Gq
         MgFqdcv+1it8X86YR8FLMA1is2PFr7YtWOB5hiA+FrlrxIBj70Iddio4dpAqL8U1lwXd
         DLKeplso3C5jNvxyZFNwrDLLYpwzWGPLQWq1GAqkNEmJ6336R5YSLAy9ixpQuqWLB9ON
         ff+V3u7KRNSYthfECH4mgvM9zUw0PXXaCs5AZ0pvAvPMcXLelkJByF+ALyp9Zj6BwaQh
         wAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734127122; x=1734731922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVIQfn2DuUe+t1JDFpP5D8sI2DkLpoJC4fJAHJRvOMU=;
        b=Pk3mrGXtSb6PpF3QzdQsRTN0o3xM24xp+lp/yO4XJ9/ICpCWFV0S/lN8+ALT61G/x4
         x+IUQXsG5lyKEz7HZdonnRumicVRo8xq238+UvzU3FOZw3BqLg68Cg99KZcs6tQLdbfD
         KvDRHQ4YfzWKXAkub0BQ510dPAplcL7NYqzgmxmj/bli+qIdOskoqm3Z6Q0zMcjkU+Gp
         bEM/Sm5Mn0IXkppNFIW7TsZ91Duz/Mk1o6wR4tLq1ThGLo/i4BW8ieHI2jgBHqpoYNPD
         6Nc2/1E0ctvT6bNPLWL61PMGuqh4Nx+TLzksuHaTTRzpaCDyCTwD77JYzqdD4ZqI6UJL
         5YDA==
X-Forwarded-Encrypted: i=1; AJvYcCVXEyJGZ0h4h7BLS+YVdE4rC+dvZEfO34gQx26Geib2dCI5sm7qWf+IHXvrqnsE85jUKHuNTTeWUVIub+YxYYtIrvDO@vger.kernel.org, AJvYcCWT7DaW1FZOxv1i0I44JKxoMiNW1LUFjoJ1HDre0fu87aO728KCgzM82mP1q7NBUg/bkeFLy8qA8sBYIl/Y@vger.kernel.org, AJvYcCXyA87cz3WdvTMDNsfFrSoNoz6Evb+phuFhF2BhVXkS4su74655N7xExwqUyFt2pGWdSNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYfUmwwdN6roNUZ12KIhEBd9bp0y8wsL3rImzh521FqFZYEbH+
	5rsbO6xcqA4fy4NpsDkNoV7fyYkdI4OLMlLzdwMyAoVTlKtgCvSvYTy+jVkmuLYHdy7ObqwlEvH
	J7IDp2gHsQvUF9fqu23eDmk8or4U=
X-Gm-Gg: ASbGncvagIgu4MaaWH7UbsGv93f0sqYmr6hFeZDR3gIZwBEuJOaH5MP8PKXZSA6bSZP
	b2crrbgxml537BGaCZyI+uYE6NJdGN5k6IIyuqAU6pkaAEWBrFoixiQ==
X-Google-Smtp-Source: AGHT+IF+np7+MGQLZekM1wW2FQOl6BZ2baG5TgM67xIGmUpNRq5tCWCGtEdQ2jirTg5BTCLpNknyvdPWG4YCBnJBFxI=
X-Received: by 2002:a17:90b:3803:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-2f2901b55acmr6836479a91.35.1734127122292; Fri, 13 Dec 2024
 13:58:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org> <20241211133403.208920-9-jolsa@kernel.org>
In-Reply-To: <20241211133403.208920-9-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Dec 2024 13:58:28 -0800
Message-ID: <CAEf4BzYZP_eQDS-rH_Ekb+RjWS-fi_BqJNYq-tpnAcR2yLA_1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize uprobes
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Putting together all the previously added pieces to support optimized
> uprobes on top of 5-byte nop instruction.
>
> The current uprobe execution goes through following:
>   - installs breakpoint instruction over original instruction
>   - exception handler hit and calls related uprobe consumers
>   - and either simulates original instruction or does out of line single =
step
>     execution of it
>   - returns to user space
>
> The optimized uprobe path
>
>   - checks the original instruction is 5-byte nop (plus other checks)
>   - adds (or uses existing) user space trampoline and overwrites original
>     instruction (5-byte nop) with call to user space trampoline
>   - the user space trampoline executes uprobe syscall that calls related =
uprobe
>     consumers
>   - trampoline returns back to next instruction
>
> This approach won't speed up all uprobes as it's limited to using nop5 as
> original instruction, but we could use nop5 as USDT probe instruction (wh=
ich
> uses single byte nop ATM) and speed up the USDT probes.
>
> This patch overloads related arch functions in uprobe_write_opcode and
> set_orig_insn so they can install call instruction if needed.
>
> The arch_uprobe_optimize triggers the uprobe optimization and is called a=
fter
> first uprobe hit. I originally had it called on uprobe installation but t=
hen
> it clashed with elf loader, because the user space trampoline was added i=
n a
> place where loader might need to put elf segments, so I decided to do it =
after
> first uprobe hit when loading is done.
>
> We do not unmap and release uprobe trampoline when it's no longer needed,
> because there's no easy way to make sure none of the threads is still
> inside the trampoline. But we do not waste memory, because there's just
> single page for all the uprobe trampoline mappings.
>
> We do waste frmae on page mapping for every 4GB by keeping the uprobe
> trampoline page mapped, but that seems ok.
>
> Attaching the speed up from benchs/run_bench_uprobes.sh script:
>
> current:
>
>      uprobe-nop     :    3.281 =C2=B1 0.003M/s
>      uprobe-push    :    3.085 =C2=B1 0.003M/s
>      uprobe-ret     :    1.130 =C2=B1 0.000M/s
>  --> uprobe-nop5    :    3.276 =C2=B1 0.007M/s
>      uretprobe-nop  :    1.716 =C2=B1 0.016M/s
>      uretprobe-push :    1.651 =C2=B1 0.017M/s
>      uretprobe-ret  :    0.846 =C2=B1 0.006M/s
>  --> uretprobe-nop5 :    3.279 =C2=B1 0.002M/s
>
> after the change:
>
>      uprobe-nop     :    3.246 =C2=B1 0.004M/s
>      uprobe-push    :    3.057 =C2=B1 0.000M/s
>      uprobe-ret     :    1.113 =C2=B1 0.003M/s
>  --> uprobe-nop5    :    6.751 =C2=B1 0.037M/s
>      uretprobe-nop  :    1.740 =C2=B1 0.015M/s
>      uretprobe-push :    1.677 =C2=B1 0.018M/s
>      uretprobe-ret  :    0.852 =C2=B1 0.005M/s
>  --> uretprobe-nop5 :    6.769 =C2=B1 0.040M/s
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/include/asm/uprobes.h |   7 ++
>  arch/x86/kernel/uprobes.c      | 168 ++++++++++++++++++++++++++++++++-
>  include/linux/uprobes.h        |   1 +
>  kernel/events/uprobes.c        |   8 ++
>  4 files changed, 181 insertions(+), 3 deletions(-)
>

[...]

> +
> +int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, struct page *=
page,
> +                             unsigned long vaddr, uprobe_opcode_t *new_o=
pcode,
> +                             int nbytes)
> +{
> +       uprobe_opcode_t old_opcode[5];
> +       bool is_call, is_swbp, is_nop5;
> +
> +       if (!test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags))
> +               return uprobe_verify_opcode(page, vaddr, new_opcode);
> +
> +       /*
> +        * The ARCH_UPROBE_FLAG_CAN_OPTIMIZE flag guarantees the followin=
g
> +        * 5 bytes read won't cross the page boundary.
> +        */
> +       uprobe_copy_from_page(page, vaddr, (uprobe_opcode_t *) &old_opcod=
e, 5);
> +       is_call =3D is_call_insn((uprobe_opcode_t *) &old_opcode);
> +       is_swbp =3D is_swbp_insn((uprobe_opcode_t *) &old_opcode);
> +       is_nop5 =3D is_nop5_insn((uprobe_opcode_t *) &old_opcode);
> +
> +       /*
> +        * We allow following trasitions for optimized uprobes:
> +        *
> +        *   nop5 -> swbp -> call
> +        *   ||      |       |
> +        *   |'--<---'       |
> +        *   '---<-----------'
> +        *
> +        * We return 1 to ack the write, 0 to do nothing, -1 to fail writ=
e.
> +        *
> +        * If the current opcode (old_opcode) has already desired value,
> +        * we do nothing, because we are racing with another thread doing
> +        * the update.
> +        */
> +       switch (nbytes) {
> +       case 5:
> +               if (is_call_insn(new_opcode)) {
> +                       if (is_swbp)
> +                               return 1;
> +                       if (is_call && !memcmp(new_opcode, &old_opcode, 5=
))
> +                               return 0;
> +               } else {
> +                       if (is_call || is_swbp)
> +                               return 1;
> +                       if (is_nop5)
> +                               return 0;
> +               }
> +               break;
> +       case 1:
> +               if (is_swbp_insn(new_opcode)) {
> +                       if (is_nop5)
> +                               return 1;
> +                       if (is_swbp || is_call)
> +                               return 0;
> +               } else {
> +                       if (is_swbp || is_call)
> +                               return 1;
> +                       if (is_nop5)
> +                               return 0;
> +               }
> +       }
> +       return -1;

nit: -EINVAL?

> +}
> +
> +bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes)
> +{
> +       return nbytes =3D=3D 5 ? is_call_insn(insn) : is_swbp_insn(insn);
> +}
> +

[...]

