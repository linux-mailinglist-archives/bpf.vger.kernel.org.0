Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3A8468D09
	for <lists+bpf@lfdr.de>; Sun,  5 Dec 2021 20:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbhLETqe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Dec 2021 14:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhLETqd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Dec 2021 14:46:33 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661FBC061714
        for <bpf@vger.kernel.org>; Sun,  5 Dec 2021 11:43:06 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id d10so25594249ybn.0
        for <bpf@vger.kernel.org>; Sun, 05 Dec 2021 11:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AVM4yIRDu8U1dh9ScIMMlKQ5XzVTFXT9XFu1gd2wUw=;
        b=lzcMgoVA6+rR1Hk6zU9pS0fGfwbM6WyFw32lpPIqF3JRxU9vfFdCDGP2RD9rK5rj6J
         XdrxwqJ3xUvM7B+81yuGpGgHQWHFrpn0m2rxNcc+pf9b3ndn+2bMtLkax6a4GYT7pCZJ
         Jbbn4kxzQtOsjxu3eNdLwp98+7LMcJmwQAwE/XGd+4kOEkRsR4pmwCJcR00MbQQBd1Ml
         3CgMaLsj4lYnwq7qu9vfbYIkVMdPjRFGGee5E3rxehx4rWhYNzouNOCdyE/HWWVyDCp9
         /BsUUe8Hnc+ZjalYuvXM+IgTX9fAxBSA7AESuW1E4r4mX+RYs397i4HV5jszYU7ytFi2
         8cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AVM4yIRDu8U1dh9ScIMMlKQ5XzVTFXT9XFu1gd2wUw=;
        b=jA7AhDiwq0Y8HwhWi7tTEeQF5ZppEzMygORCgptAvlHBzd/2DLoxnrOCcxfBNr1Kbf
         NlmuUm73/djRUXRksO1xWh+Vz+VHPHnCAoIZn+Q4DkJz+AgBhEpv+wMo5u3gb1q6Yj+m
         PD5pilKaxTjO6EfWMC6Mz/DQTweFnOgwww4yH+Iv2N3LlHOaZm1uEcu5CYLx74VRRuWk
         TNAhEvXtsWFZGl69+1+Ps5R0TbYDWulVP1xK+RMfzvSCcNgKU4zuu7evlAwICWBZT8Dt
         T7bTFWlDEZ9v1bKHgz36ccxQcNB7THlMp7qrdPO1urn/SfW/2ngm/tnPAhHwDMh3tcAb
         gOZA==
X-Gm-Message-State: AOAM533h6dp5jKYo0LX9PXONbUW5/2Qb1oQX6tl2bVxTQi2PKcBq8gSS
        Y8OVSquw/8Tj/MzHDAUZzYziIC4cHcCVebR0vXY=
X-Google-Smtp-Source: ABdhPJyjBLK/pKjPU9Mg4BYrhAQWUVxR5ofqDdc5O9YAliKyxF5oP+aIdP0WZ5edsiMP1keXMJH6Z1cES3ds/6hYn9c=
X-Received: by 2002:a25:6d4:: with SMTP id 203mr37843383ybg.83.1638733385574;
 Sun, 05 Dec 2021 11:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20211204194623.27779-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20211204194623.27779-1-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 5 Dec 2021 11:42:54 -0800
Message-ID: <CAEf4BzZz=QSEqGWQaqjh73Mjd0Zk+f2vsDN0Goa+k3ooefHYDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Add debug mode for gen_loader.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 4, 2021 at 11:46 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Make -d flag functional for gen_loader style program loading.
>
> For example:
> $ bpftool prog load -L -d test_d_path.o
> ... // will print:
> libbpf: loading ./test_d_path.o
> libbpf: elf: section(3) fentry/security_inode_getattr, size 280, link 0, flags 6, type=1
> ...
> libbpf: prog 'prog_close': found data map 0 (test_d_p.bss, sec 7, off 0) for insn 30
> libbpf: gen: load_btf: size 5376
> libbpf: gen: map_create: test_d_p.bss idx 0 type 2 value_type_id 118
> libbpf: map 'test_d_p.bss': created successfully, fd=0
> libbpf: gen: map_update_elem: idx 0
> libbpf: sec 'fentry/filp_close': found 1 CO-RE relocations
> libbpf: record_relo_core: prog 1 insn[15] struct file 0:1 final insn_idx 15
> libbpf: gen: prog_load: type 26 insns_cnt 35 progi_idx 0
> libbpf: gen: find_attach_tgt security_inode_getattr 12
> libbpf: gen: prog_load: type 26 insns_cnt 37 progi_idx 1
> libbpf: gen: find_attach_tgt filp_close 12
> libbpf: gen: finish 0
> ... // at this point libbpf finished generating loader program
>    0: (bf) r6 = r1
>    1: (bf) r1 = r10
>    2: (07) r1 += -136
>    3: (b7) r2 = 136
>    4: (b7) r3 = 0
>    5: (85) call bpf_probe_read_kernel#113
>    6: (05) goto pc+104
> ... // this is the assembly dump of the loader program
>  390: (63) *(u32 *)(r6 +44) = r0
>  391: (18) r1 = map[idx:0]+5584
>  393: (61) r0 = *(u32 *)(r1 +0)
>  394: (63) *(u32 *)(r6 +24) = r0
>  395: (b7) r0 = 0
>  396: (95) exit
> err 0  // the loader program was loaded and executed successfully
> (null)
> func#0 @0
> ...  // CO-RE in the kernel logs:
> CO-RE relocating STRUCT file: found target candidate [500]
> prog '': relo #0: kind <byte_off> (0), spec is [8] STRUCT file.f_path (0:1 @ offset 16)
> prog '': relo #0: matching candidate #0 [500] STRUCT file.f_path (0:1 @ offset 16)
> prog '': relo #0: patched insn #15 (ALU/ALU64) imm 16 -> 16
> vmlinux_cand_cache:[11]file(500),
> module_cand_cache:
> ... // verifier logs when it was checking test_d_path.o program:
> R1 type=ctx expected=fp
> 0: R1=ctx(id=0,off=0,imm=0) R10=fp0
> ; int BPF_PROG(prog_close, struct file *file, void *id)
> 0: (79) r6 = *(u64 *)(r1 +0)
> func 'filp_close' arg0 has btf_id 500 type STRUCT 'file'
> 1: R1=ctx(id=0,off=0,imm=0) R6_w=ptr_file(id=0,off=0,imm=0) R10=fp0
> ; pid_t pid = bpf_get_current_pid_tgid() >> 32;
> 1: (85) call bpf_get_current_pid_tgid#14
>
> ... // if there are multiple programs being loaded by the loader program
> ... // only the last program in the elf file will be printed, since
> ... // the same verifier log_buf is used for all PROG_LOAD commands.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/bpf/bpftool/prog.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index e47e8b06cc3d..b9f42e9e9067 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1779,12 +1779,14 @@ static int try_loader(struct gen_loader_opts *gen)
>         ctx = alloca(ctx_sz);
>         memset(ctx, 0, ctx_sz);
>         ctx->sz = ctx_sz;
> -       ctx->log_level = 1;
> -       ctx->log_size = log_buf_sz;
> -       log_buf = malloc(log_buf_sz);
> -       if (!log_buf)
> -               return -ENOMEM;
> -       ctx->log_buf = (long) log_buf;
> +       if (verifier_logs) {
> +               ctx->log_level = 1 + 2 + 4;
> +               ctx->log_size = log_buf_sz;
> +               log_buf = malloc(log_buf_sz);

if verifier_logs is false, log_buf will now be left uninitialized and
passed like that into free(log_buf), crashing or corrupting memory.
I've fixed it up by NULL initializaing and pushed to bpf-next.

> +               if (!log_buf)
> +                       return -ENOMEM;
> +               ctx->log_buf = (long) log_buf;
> +       }
>         opts.ctx = ctx;
>         opts.data = gen->data;
>         opts.data_sz = gen->data_sz;
> @@ -1793,9 +1795,9 @@ static int try_loader(struct gen_loader_opts *gen)
>         fds_before = count_open_fds();
>         err = bpf_load_and_run(&opts);
>         fd_delta = count_open_fds() - fds_before;
> -       if (err < 0) {
> +       if (err < 0 || verifier_logs) {
>                 fprintf(stderr, "err %d\n%s\n%s", err, opts.errstr, log_buf);
> -               if (fd_delta)
> +               if (fd_delta && err < 0)
>                         fprintf(stderr, "loader prog leaked %d FDs\n",
>                                 fd_delta);
>         }
> --
> 2.30.2
>
