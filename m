Return-Path: <bpf+bounces-56470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57504A97B83
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 02:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A1B1B61022
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 00:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E4E186A;
	Wed, 23 Apr 2025 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYPFRrVD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7336C;
	Wed, 23 Apr 2025 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745366663; cv=none; b=ZYoIYVhpHtk9xrRCNdatsry0tkdXU/KJGHW6wQEa625Qnuurlnf59pwYaFsR8Nwoflxkgb/JSgk+QtypgD4Scg5NAYJ52BQQgDHXa42PHqwMbkn455JdOk3l7vWJf6yVHD9Sb2Y6tt1SOme5Eo9n/+TOWBXK7XqpxLgQBbojWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745366663; c=relaxed/simple;
	bh=BZo/G59s6S+BHayR3/xtxP0kXq8pzNz1u0UoxP950eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IS/+VYls8Wg3ShWAlqi+Y2+1/mL/RsTt65u54YufXxkGWzcKgP00YZl916Y3iJNBmZiK9OEdZcPwYvrAueScwnpYVMxst02n8EHERyZI63WbzOM/K67+3rQw9JaEK1N8IUVj1NyO52Wg5rJE5/XoFKXK0GJfac0Zoiahz3hvHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYPFRrVD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2279915e06eso60591685ad.1;
        Tue, 22 Apr 2025 17:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745366661; x=1745971461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXu4w9pPx+Kr1S9nGHzN+1+D+Przp9aQ+m0xBhYke/I=;
        b=LYPFRrVDBAqxPGz/Ap/M3RrpGd7l3XYlLHkhfYLMBJZMFxF8GkjUWvcP3m/75cfvmF
         N58mDot9ugwd6J7mvHhXUGWO/pdYw28PHD3ntGxk8ZtQBQZDc8ek2XEoYCJGpeYhQYm5
         o01VMnzq4bTOusoiJlUPJyL9f/SPeJcdk4W6MFgiFuOCZYUf1ptXiTiV73qGt6bH3fx0
         FYAE6wyPgUd4/cvm90VZOlgD0cPGrGbgvHNrzPW3P70/p6AhTFhGfehWlpgXajzRy2cp
         0toULr67+XmfjgIfypnXC2WLkgsH2T+2zXFeYBBfjm8YIS47UJx/RE1ZqEKhEmda8a7p
         rpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745366661; x=1745971461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXu4w9pPx+Kr1S9nGHzN+1+D+Przp9aQ+m0xBhYke/I=;
        b=EFku8O0g7gbpJgneTDwvk1ihXOPFhtQgIixo4+bP4WLOsNhwvCBQEUK21oO162u/AF
         XuyVCANUDAhRUWooX+lKtCcVv4N4JgNYmLVQ5e1I9f1AhfE1wuFQf7AuUyj+D+Sv0V6K
         NCRkgqex6ApdrF1zJgbJ22eNUfmjCterTPIwu6FDEzQHYIUhm2kbc4qwMVjmjlk6Od20
         ricHFmEIVTYvp8YfRAFG49gDa1XHvybhFHDKWc9Lt8K5zHHMCgFc1DEsfdE2kC0ACJXG
         qqcoVzTVyQbaV8CKEEo73SDgtgnuUr9Y07b+Rz8nHDaro7FOgiT/pSjw+YI9x/RPEm4R
         c4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4iYIlBCbyUPDHVROwLY7tzL0ZpWNNnz8BXVKKQHVrOV73Csh6CewanMLHzqRO3SHpshq03hvZUYHXCyu9@vger.kernel.org, AJvYcCW7niwkpQFiCNVCuxk9aoDC5mROyVQMXdE8gwoVI3aexXcttSQWbRX7oInT7ygPvIDs/CDRHaRYETmrkc24ZYz+PpWk@vger.kernel.org, AJvYcCXSv+GJ90rNYrWP/aFHjSmwOhaMOy/sVTiaKloz3+HNL27qsmQKVWp9wHz2xa4lZ0A97sU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2CTHaOIcPfjd7CwUG0l1M4UHayscENHmXESFlg0LpbzjCHiQg
	DIlvi0aTQ/P4BNGM5ENAqwMuq6KPZ+9v4RyljZ48EuaQl1rb2fLjeXGtqbQjGkf0zrDNy9TUh41
	YYExZBZvmBaDJZvcLIhu83HMCD3A=
X-Gm-Gg: ASbGncuDACKAZemHDyuM0x1TTLYTyXCV+5pZ6HrJXt09L7R6uWja2XNNaKqHYmwfpF3
	dZS2iI6RSK2ufrayl7KzqVer8wj2Ar+zpII6006i6laoN1+8h5B0Ph6sbdRkzxa3ZT15FYGggAL
	63hxdgXtBuXteRwKs7BhMU5GngOJP5XF8OfhG6JQ==
X-Google-Smtp-Source: AGHT+IF8Bg8vh3xC8a7IVBgHtW8YtNX2T2ZN5iRNghTR+Nj69mTzZgVkKcnkjztIXbQgHIEWxF6f1xmUBjHf7x5Fzew=
X-Received: by 2002:a17:903:187:b0:223:5a6e:b2c with SMTP id
 d9443c01a7336-22c5359e362mr251869355ad.17.1745366661134; Tue, 22 Apr 2025
 17:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-11-jolsa@kernel.org>
In-Reply-To: <20250421214423.393661-11-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Apr 2025 17:04:03 -0700
X-Gm-Features: ATxdqUHnSKvxVSFi0oZ_ikom7TYU-ux59CWhIVrji3hIk4ENCJlLNa37iH0xDbQ
Message-ID: <CAEf4BzbJJuKY+eTaDvwhgmp9jBqYXoLWinBY8vK0oYh0irC07Q@mail.gmail.com>
Subject: Re: [PATCH perf/core 10/22] uprobes/x86: Add support to optimize uprobes
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 2:46=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Putting together all the previously added pieces to support optimized
> uprobes on top of 5-byte nop instruction.
>
> The current uprobe execution goes through following:
>
>   - installs breakpoint instruction over original instruction
>   - exception handler hit and calls related uprobe consumers
>   - and either simulates original instruction or does out of line single =
step
>     execution of it
>   - returns to user space
>
> The optimized uprobe path does following:
>
>   - checks the original instruction is 5-byte nop (plus other checks)
>   - adds (or uses existing) user space trampoline with uprobe syscall
>   - overwrites original instruction (5-byte nop) with call to user space
>     trampoline
>   - the user space trampoline executes uprobe syscall that calls related =
uprobe
>     consumers
>   - trampoline returns back to next instruction
>
> This approach won't speed up all uprobes as it's limited to using nop5 as
> original instruction, but we plan to use nop5 as USDT probe instruction
> (which currently uses single byte nop) and speed up the USDT probes.
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
> The uprobe is un-optimized in arch specific set_orig_insn call.
>
> The instruction overwrite is x86 arch specific and needs to go through 3 =
updates:
> (on top of nop5 instruction)
>
>   - write int3 into 1st byte
>   - write last 4 bytes of the call instruction
>   - update the call instruction opcode
>
> And cleanup goes though similar reverse stages:
>
>   - overwrite call opcode with breakpoint (int3)
>   - write last 4 bytes of the nop5 instruction
>   - write the nop5 first instruction byte
>
> We do not unmap and release uprobe trampoline when it's no longer needed,
> because there's no easy way to make sure none of the threads is still
> inside the trampoline. But we do not waste memory, because there's just
> single page for all the uprobe trampoline mappings.
>
> We do waste frame on page mapping for every 4GB by keeping the uprobe
> trampoline page mapped, but that seems ok.
>
> We take the benefit from the fact that set_swbp and set_orig_insn are
> called under mmap_write_lock(mm), so we can use the current instruction
> as the state the uprobe is in - nop5/breakpoint/call trampoline -
> and decide the needed action (optimize/un-optimize) based on that.
>
> Attaching the speed up from benchs/run_bench_uprobes.sh script:
>
> current:
>         usermode-count :  152.604 =C2=B1 0.044M/s
>         syscall-count  :   13.359 =C2=B1 0.042M/s
> -->     uprobe-nop     :    3.229 =C2=B1 0.002M/s
>         uprobe-push    :    3.086 =C2=B1 0.004M/s
>         uprobe-ret     :    1.114 =C2=B1 0.004M/s
>         uprobe-nop5    :    1.121 =C2=B1 0.005M/s
>         uretprobe-nop  :    2.145 =C2=B1 0.002M/s
>         uretprobe-push :    2.070 =C2=B1 0.001M/s
>         uretprobe-ret  :    0.931 =C2=B1 0.001M/s
>         uretprobe-nop5 :    0.957 =C2=B1 0.001M/s
>
> after the change:
>         usermode-count :  152.448 =C2=B1 0.244M/s
>         syscall-count  :   14.321 =C2=B1 0.059M/s
>         uprobe-nop     :    3.148 =C2=B1 0.007M/s
>         uprobe-push    :    2.976 =C2=B1 0.004M/s
>         uprobe-ret     :    1.068 =C2=B1 0.003M/s
> -->     uprobe-nop5    :    7.038 =C2=B1 0.007M/s
>         uretprobe-nop  :    2.109 =C2=B1 0.004M/s
>         uretprobe-push :    2.035 =C2=B1 0.001M/s
>         uretprobe-ret  :    0.908 =C2=B1 0.001M/s
>         uretprobe-nop5 :    3.377 =C2=B1 0.009M/s
>
> I see bit more speed up on Intel (above) compared to AMD. The big nop5
> speed up is partly due to emulating nop5 and partly due to optimization.
>
> The key speed up we do this for is the USDT switch from nop to nop5:
>         uprobe-nop     :    3.148 =C2=B1 0.007M/s
>         uprobe-nop5    :    7.038 =C2=B1 0.007M/s
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/include/asm/uprobes.h |   7 +
>  arch/x86/kernel/uprobes.c      | 281 ++++++++++++++++++++++++++++++++-
>  include/linux/uprobes.h        |   6 +-
>  kernel/events/uprobes.c        |  15 +-
>  4 files changed, 301 insertions(+), 8 deletions(-)
>

just minor nits, LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> +int set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> +            unsigned long vaddr)
> +{
> +       if (should_optimize(auprobe)) {
> +               bool optimized =3D false;
> +               int err;
> +
> +               /*
> +                * We could race with another thread that already optimiz=
ed the probe,
> +                * so let's not overwrite it with int3 again in this case=
.
> +                */
> +               err =3D is_optimized(vma->vm_mm, vaddr, &optimized);
> +               if (err || optimized)
> +                       return err;

IMO, this is a bit too clever, I'd go with plain

if (err)
    return err;
if (optimized)
    return 0; /* we are done */

(and mirror set_orig_insn() structure, consistently)


> +       }
> +       return uprobe_write_opcode(vma, vaddr, UPROBE_SWBP_INSN, true);
> +}
> +
> +int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vm=
a,
> +                 unsigned long vaddr)
> +{
> +       if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags)) {
> +               struct mm_struct *mm =3D vma->vm_mm;
> +               bool optimized =3D false;
> +               int err;
> +
> +               err =3D is_optimized(mm, vaddr, &optimized);
> +               if (err)
> +                       return err;
> +               if (optimized)
> +                       WARN_ON_ONCE(swbp_unoptimize(auprobe, vma, vaddr)=
);
> +       }
> +       return uprobe_write_opcode(vma, vaddr, *(uprobe_opcode_t *)&aupro=
be->insn, false);
> +}
> +
> +static int __arch_uprobe_optimize(struct mm_struct *mm, unsigned long va=
ddr)
> +{
> +       struct uprobe_trampoline *tramp;
> +       struct vm_area_struct *vma;
> +       int err =3D 0;
> +
> +       vma =3D find_vma(mm, vaddr);
> +       if (!vma)
> +               return -1;

this is EPERM, will be confusing to debug... why not -EINVAL?

> +       tramp =3D uprobe_trampoline_get(vaddr);
> +       if (!tramp)
> +               return -1;

ditto

> +       err =3D swbp_optimize(vma, vaddr, tramp->vaddr);
> +       if (WARN_ON_ONCE(err))
> +               uprobe_trampoline_put(tramp);
> +       return err;
> +}
> +

[...]

