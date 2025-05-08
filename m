Return-Path: <bpf+bounces-57819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A22BAB0684
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 01:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20EFA4C7CF5
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 23:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D50F233129;
	Thu,  8 May 2025 23:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtcAbol0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A3F231A32
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747193; cv=none; b=iDdheM1yOccGfARN0lZfsh+TprCqZxEHD5ePBrNw8Pw7Gqbrnrj5DHwibo78CpGyndyXOC2Hay+sbZe1N4PajmDas4Ud7Hjsy3Uj94mEofuwxg/piRMkOByTubiEQQ2IOc+OaaT9rHkq+nBq75uocwdsXUjID2ibAgMd7L6vNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747193; c=relaxed/simple;
	bh=9I8NTB1UMJ0iKb7ys+UM9FytDDhScL789pVsYqXyvk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqomJzDOEMu3AsSdMA6hfpntuQGOHiBPh9tSmi7FTx5a/LQ2dCNClmMSyJduRRqxuudDovt0WSdszwS/n5Ds93zQw53XmbLXfQyyrgPcKqsqxoc4TSSqS8FC8TzWyio/CzAEzYmnKCgGeuds20fkHo2c218BQl4Uj/2vxuUNq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtcAbol0; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ad221e3e5a2so2868666b.1
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 16:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746747189; x=1747351989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lQOb4/LFar16b4y5DLAWeDx8lnhcgxRxi18JV9ny9Ig=;
        b=ZtcAbol0tGqJKzxO+TyiPdi0rjhTk4JngZoUBC9XxGN1Q30ZQmpcWE771lHRT3URqJ
         IJJrd9Il4z/KG93DYOgtQ9+jzmU/+3tzd2Cr7VyoLCsG2K+2EQi9Cd8VXeM4D6Joyr5N
         DG2pFCJ9nu3PAeSTi8ifxRvDDaHIaVdp+P3d59peYUiJjB7YCTpEBcotvTJu9/Fl8iNG
         J6fn1rxUacEGFgeYgJRhVPTVchHn0gmnL4SgJ7A+4KOqXhF/tovKdZeydUKEjDMU0a2w
         t+sgi6O1v70O9uR0UF+ftLVMkyAEiPf2H3ia6ciF+pQcdrpStetN6BBY8c7gmPvISOPd
         0Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746747189; x=1747351989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQOb4/LFar16b4y5DLAWeDx8lnhcgxRxi18JV9ny9Ig=;
        b=Zwk3ZLs5ryZ3jPslu0rAa/6aSlPJfKFbvbPK9i1bcgbVa403iewCcLWIB5lCTAJxE1
         BsXxnKA0f3+6xffb/DuwwMdOaODug+egbOe8fO7ADp3Tw1jmeOofpgaQzxTgHe05g7f9
         0iHKntzNIhhrvMjcaVcM2/KbF65pg9125M6BwyGmWEGwBE+eMYNCJ4BAs6ofs7GVb9t5
         g/VDqJztAVrNgrGf77yuwPUQVvqgNZNjOmbG2lCmb7B9JWMsGu6/gUTdnh0Pc5dVt90N
         KTJZ0EXJPSiggwCU0aY85W8VwrrTw3J/+I/2vBHXeGVgLaP+VICyM47LTWn+8jwYBfy4
         x6YA==
X-Gm-Message-State: AOJu0YxUZF5FSVKlsal3RKzYhnWiiABVjug8RY5wTbjbUxkh/nrfiJBU
	+5iRF8DpMtHD47sgTuMAsigKt6wkjlHMhrDK6dBheFknItZPQo2Gf6P1vIhIIuVYopIr+F1k/dZ
	34OO+rBUkVye23UnTxjDKSiUtkHI=
X-Gm-Gg: ASbGncsLqyTeeE3NJZbRUu6uhNvp3i48J46poDy5w1od0/DabCu9h8HxUgV/fvxhBIz
	Ft6Ty7M7zCiwZUtFvRenuBaaFFIIX68HuatfUMOjF0tWbrUvgOYWdOQEwI94QHKIeN73y3aFjWI
	qYWVNEBZD6UnKL7xvWaXvF8u5BZn36eU5Im15mMb5v8qgSpF21p7lTkmJa
X-Google-Smtp-Source: AGHT+IHh8cjFwE2KibeYkd8A9txQvzWc1ZgUrs0/hr/BehAfNihTeE45MCtkS+ksS1B9XpXeuFgjeoRmP76EtISBE1Y=
X-Received: by 2002:a17:907:9717:b0:ad2:db4:2a8f with SMTP id
 a640c23a62f3a-ad21929333fmr142391866b.48.1746747189283; Thu, 08 May 2025
 16:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-4-memxor@gmail.com>
 <45fb527a493c7aae4307512cda0ded0efb1dd563.camel@gmail.com>
In-Reply-To: <45fb527a493c7aae4307512cda0ded0efb1dd563.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 9 May 2025 01:32:32 +0200
X-Gm-Features: AX0GCFtRlTQSaThe3Gq9XjkQy54lgpcUvQ-QLN4SYIF86_BzRAC17VMfTiKsYLI
Message-ID: <CAP01T76zRb71JYt4GeQ+8Kp9LwTqmZ7xQkAvjakFe-Oyh-kNYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 03/11] bpf: Add function to extract program
 source info
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 May 2025 at 22:15, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:
> > Prepare a function for use in future patches that can extract the file
> > info, line info, and the source line number for a given BPF program
> > provided it's program counter.
> >
> > Only the basename of the file path is provided, given it can be
> > excessively long in some cases.
> >
> > This will be used in later patches to print source info to the BPF
> > stream. The source line number is indicated by the return value, and the
> > file and line info are provided through out parameters.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Hi Kumar,
>
> I did a silly test for this function by calling it for every ip in the
> program at the and of the program load. See patch at the end of the
> email. The goal was to compare its output with output of the `bpftool
> prog dump jited`.
>
> Next, I used pyperf600_iter.bpf.o as a guinea pig:
>
>   bpftool prog load <kernel>/tools/testing/selftests/bpf/pyperf600_iter.bpf.o /sys/fs/bpf/dbg-prog
>   bpftool prog dump jited pinned /sys/fs/bpf/dbg-prog
>
> Overall, the bpftool output looks coherent to what is shown by printk.
> However, I see an off-by-one difference, e.g.:
>
>   // bpftool output
>
>   void * get_thread_state(void * tls_base, PidData * pidData):
>   bpf_prog_2af5b1ca414a1163_get_thread_state:
>   ; static void *get_thread_state(void *tls_base, PidData *pidData)
>      0: endbr64
>      ...
>   ; bpf_probe_read_user(&key, sizeof(key), (void*)(long)pidData->tls_key_addr);
>     1f: movl    4(%rsi), %edx
>     ...
>   ; bpf_probe_read_user(&key, sizeof(key), (void*)(long)pidData->tls_key_addr);
>     29: movl    $4, %esi
>     ...
>   ; tls_base + 0x310 + key * 0x10 + 0x08);
>     33: movl    -12(%rbp), %edi
>     ...
>   ; bpf_probe_read_user(&thread_state, sizeof(thread_state),
>     52: movl    $8, %esi
>     ...
>   ; return thread_state;
>     5f: movq    -8(%rbp), %rax
>     ...
>
>   // printk
>
>   [  114.506237] func[2] jited_len=106
>   [  114.506306] ip=0, file='(null)', line='(null)', line_num=-2
>   [  114.506395] ip=1, file='pyperf.h', line='static void *get_thread_state(void *tls_base, PidData *pidData)', line_num=77
>   [  114.506571] ip=20, file='pyperf.h', line='bpf_probe_read_user(&key, sizeof(key), (void*)(long)pidData->tls_key_addr);', line_num=82
>   [  114.506765] ip=34, file='pyperf.h', line='tls_base + 0x310 + key * 0x10 + 0x08);', line_num=84
>   [  114.506919] ip=53, file='pyperf.h', line='bpf_probe_read_user(&thread_state, sizeof(thread_state),', line_num=83
>   [  114.507096] ip=60, file='pyperf.h', line='return thread_state;', line_num=85
>
> Note that ip for each printk entry is +1 compared to bpftool output.
>
> Also, there is a BUG splat from KASAN in the end:
>
>   [    2.343160] ==================================================================
>   [    2.343277] BUG: KASAN: slab-out-of-bounds in bpf_prog_get_file_line (kernel/bpf/core.c:3213)
>   [    2.343397] Read of size 4 at addr ffff88810b5ea810 by task veristat/145
>   [    2.343496]
>   [    2.343542] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-3.fc41 04/01/2014
>   [    2.343544] Call Trace:
>   ...
>   [    2.343592] bpf_prog_get_file_line (kernel/bpf/core.c:3213)
>   [    2.343598] ?bpf_prog_2af5b1ca414a1163_get_thread_state+0x64/0x6a 85
>   [    2.343602] bpf_prog_load (kernel/bpf/syscall.c:3014)
>   ...
>   [    2.343686]
>   [    2.346851] Allocated by task 145:
>   [    2.346912] kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:68)
>   [    2.346974] __kasan_kmalloc (mm/kasan/common.c:398)
>   [    2.347036] __kvmalloc_node_noprof (mm/slub.c:4342 mm/slub.c:5026)
>   [    2.347117] check_btf_info (kernel/bpf/verifier.c:17908 kernel/bpf/verifier.c:18120)
>   [    2.347179] bpf_check (kernel/bpf/verifier.c:24004)
>   [    2.347240] bpf_prog_load (kernel/bpf/syscall.c:2971)
>   [    2.347301] __sys_bpf (kernel/bpf/syscall.c:5897)
>   [    2.347363] __x64_sys_bpf (kernel/bpf/syscall.c:5958 kernel/bpf/syscall.c:5956 kernel/bpf/syscall.c:5956)
>   [    2.347423] do_syscall_64 (arch/x86/entry/syscall_64.c:0)
>   [    2.347484] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>   [    2.347566]
>   [    2.347607] The buggy address belongs to the object at ffff88810b5ea000
>   [    2.347607]  which belongs to the cache kmalloc-4k of size 4096
>   [    2.347782] The buggy address is located 0 bytes to the right of
>   [    2.347782]  allocated 2064-byte region [ffff88810b5ea000, ffff88810b5ea810)
>
> Am I doing something stupid or there is an issue?
>
> --- 8< -------------------------------------------
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 4664ab5e8cc7..467ae79f77a1 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3188,6 +3188,7 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
>
> +__attribute__((optnone)) // to see line numbers after decode_stacktrace
>  int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep, const char **linep)
>  {
>         int idx = -1, insn_start, insn_end, len;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 64c3393e8270..d1777b8c5558 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3001,6 +3001,23 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>         err = bpf_prog_new_fd(prog);
>         if (err < 0)
>                 bpf_prog_put(prog);
> +       for (int fidx = 0; fidx < prog->aux->func_cnt; ++fidx) {
> +               struct bpf_prog *fprog = prog->aux->func[fidx];
> +               int line_num, prev_line_num;
> +               const char *filep, *linep;
> +
> +               prev_line_num = -1;
> +               printk("func[%d] jited_len=%d\n", fidx, fprog->jited_len);
> +               for (u32 ip = 0; ip < fprog->jited_len; ++ip) {
> +                       filep = NULL;
> +                       linep = NULL;
> +                       line_num = bpf_prog_get_file_line(fprog, (u64)fprog->bpf_func + ip, &filep, &linep);
> +                       if (line_num != prev_line_num)
> +                               printk("ip=%x, file='%s', line='%s', line_num=%d\n",
> +                                      ip, filep, linep, line_num);
> +                       prev_line_num = line_num;
> +               }
> +       }
>         return err;
> ------------------------------------------- >8 ---
>

Thanks for trying it out, the ip slip is probably because we get the
return address at runtime so it's always trailing the actual ip of
what called into us.
I will look into the KASAN error / off-by-one.

