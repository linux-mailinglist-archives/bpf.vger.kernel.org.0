Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A88659ABD
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 17:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiL3Q4y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Dec 2022 11:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiL3Q4w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Dec 2022 11:56:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35D419026
        for <bpf@vger.kernel.org>; Fri, 30 Dec 2022 08:56:51 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qk9so52427470ejc.3
        for <bpf@vger.kernel.org>; Fri, 30 Dec 2022 08:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+PxYAjCz6pA+XOYNcSzCn/iyn9hJ/93qYAJF+05rOU=;
        b=VlFxTem26z2u/IwBfwaENpaYbDNMq1V32rylZj0iXGjK3qU98QF7MSAHKa5q2086XX
         QPMwp+ZLjcgLXkGxYL96L1jSZ/NL43aRah660AJHeMMR+Ob86wtoIlaawXndE5Xvc5Vt
         6D4Kf13Lopec+htmr6gTnmXQFpAbTRTs7bYoZJ8tWRQ6po2rpDNCg5KYImr0n8pvHoeb
         0zLgrqn5N3sXiLTF4MpJ8mIImJOuCkbF+o0lYuhUHfcFy5fTyTGU7aIaKcRhz0y9b1jO
         sG+MrKFO9Hmlt3MdrqTffmITGCfaG74Dur8WVH+alQRI/xnonaztp4j0MKudGtwHdczo
         7Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+PxYAjCz6pA+XOYNcSzCn/iyn9hJ/93qYAJF+05rOU=;
        b=M7CQzmg17wzji8DC96B4kYnx3QDVCk/W2Eqsr96ELLK9HfK8vh5pj7KZu6YctdEby+
         4FDnkwz3PN+lMYwKzUXq3HKEvqzmODQpjyDSMMN9tJYgAWPUWrd0Lq8ZuLS0F/+Jb6nR
         wEb8WwMZkk5G6wQK/4LN9VmVYR78eJaJNINpfRyW6Lrw1UjY1VP8vr04ujuSRKCy7Ff+
         xYGu8aYTmCIVpVIvbjUtnxHgehW97okYQeez8aTp/eh0DXjspNqCXnHBj+Sz8C0E+Yjv
         +jgI8IMn+5E1Mprq3RJbu/YzLYfKR/dA0+SZgRy6+JQpFscbCd49E2EF6ttAVcIA9DaA
         mwUQ==
X-Gm-Message-State: AFqh2koAg/zXZuc9ktY1/1jFK3ZSq0TDbGi/XAwyM6ROAgcZ/Lz2Z+WK
        uEnTuFDPuG73HyTFAKJVluXb3v+ES2THM5+7MAo=
X-Google-Smtp-Source: AMrXdXssHniFOzpZ2KjvM195dfd3+/+XDdVeUDhzqUCvheknkglBSgTUyK1rOq3Fs3E170UI51MTsV/drKDsQmV+Hvc=
X-Received: by 2002:a17:906:f157:b0:7c0:8b4c:e30f with SMTP id
 gw23-20020a170906f15700b007c08b4ce30fmr4017482ejb.502.1672419410089; Fri, 30
 Dec 2022 08:56:50 -0800 (PST)
MIME-Version: 1.0
References: <20221230113832.22938-1-xiangxia.m.yue@gmail.com>
In-Reply-To: <20221230113832.22938-1-xiangxia.m.yue@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 30 Dec 2022 08:56:38 -0800
Message-ID: <CAADnVQJUF1_1bUgu7VoehdH7f04zZ6bP=o1tLYeyTsAbNY7giw@mail.gmail.com>
Subject: Re: [bpf-next] bpf, x86_64: fix JIT to dump the valid insn
To:     xiangxia.m.yue@gmail.com
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 30, 2022 at 3:38 AM <xiangxia.m.yue@gmail.com> wrote:
>
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>
> With bpf_jit_binary_pack_finalize invoked, we copy
> rw_header to header and then image/insn is valid.
>
> Write a test BPF prog which include subprog:
>
> $ llvm-objdump -d subprog.o
> Disassembly of section .text:
> 0000000000000000 <subprog>:
>        0:       18 01 00 00 73 75 62 70 00 00 00 00 72 6f 67 00 r1 = 29114459903653235 ll
>        2:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 8) = r1
>        3:       bf a1 00 00 00 00 00 00 r1 = r10
>        4:       07 01 00 00 f8 ff ff ff r1 += -8
>        5:       b7 02 00 00 08 00 00 00 r2 = 8
>        6:       85 00 00 00 06 00 00 00 call 6
>        7:       95 00 00 00 00 00 00 00 exit
> Disassembly of section raw_tp/sys_enter:
> 0000000000000000 <entry>:
>        0:       85 10 00 00 ff ff ff ff call -1
>        1:       b7 00 00 00 00 00 00 00 r0 = 0
>        2:       95 00 00 00 00 00 00 00 exit
>
> Without this patch, kernel print message:
> [  580.775387] flen=8 proglen=51 pass=3 image=ffffffffa000c20c from=kprobe-load pid=1643
> [  580.777236] JIT code: 00000000: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> [  580.779037] JIT code: 00000010: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> [  580.780767] JIT code: 00000020: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> [  580.782568] JIT code: 00000030: cc cc cc
>
> $ bpf_jit_disasm
> 51 bytes emitted from JIT compiler (pass:3, flen:8)
> ffffffffa000c20c + <x>:
>    0:   int3
>    1:   int3
>    2:   int3
>    3:   int3
>    4:   int3
>    5:   int3
>    ...
>
> To fix this issue:
> [  260.016071] flen=3 proglen=20 pass=1 image=ffffffffa000c11c from=kprobe-load pid=1568
> [  260.018094] JIT code: 00000000: 0f 1f 44 00 00 66 90 55 48 89 e5 e8 38 00 00 00
> [  260.020124] JIT code: 00000010: 31 c0 c9 c3
> [  260.021229] flen=8 proglen=51 pass=1 image=ffffffffa000c164 from=kprobe-load pid=1568
> [  260.023132] JIT code: 00000000: 0f 1f 44 00 00 66 90 55 48 89 e5 48 81 ec 08 00
> [  260.025129] JIT code: 00000010: 00 00 48 bf 73 75 62 70 72 6f 67 00 48 89 7d f8
> [  260.027199] JIT code: 00000020: 48 89 ef 48 83 c7 f8 be 08 00 00 00 e8 9e 19 1d
> [  260.029226] JIT code: 00000030: e1 c9 c3
>
> $ bpf_jit_disasm
> 51 bytes emitted from JIT compiler (pass:1, flen:8)
> ffffffffa000c164 + <x>:
>    0:   nopl   0x0(%rax,%rax,1)
>    5:   xchg   %ax,%ax
>    7:   push   %rbp
>    8:   mov    %rsp,%rbp
>    b:   sub    $0x8,%rsp
>   12:   movabs $0x676f7270627573,%rdi
>   1c:   mov    %rdi,-0x8(%rbp)
>   20:   mov    %rbp,%rdi
>   23:   add    $0xfffffffffffffff8,%rdi
>   27:   mov    $0x8,%esi
>   2c:   callq  0xffffffffe11d19cf
>   31:   leaveq
>   32:   retq
>
> $ bpf_jit_disasm
> 20 bytes emitted from JIT compiler (pass:1, flen:3)
> ffffffffa000c11c + <x>:
>    0:   nopl   0x0(%rax,%rax,1)
>    5:   xchg   %ax,%ax
>    7:   push   %rbp
>    8:   mov    %rsp,%rbp
>    b:   callq  0x0000000000000048
>   10:   xor    %eax,%eax
>   12:   leaveq
>   13:   retq
>
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Hou Tao <houtao1@huawei.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 36ffe67ad6e5..4e017102cc16 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2543,9 +2543,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>                 cond_resched();
>         }
>
> -       if (bpf_jit_enable > 1)
> -               bpf_jit_dump(prog->len, proglen, pass + 1, image);
> -
>         if (image) {
>                 if (!prog->is_func || extra_pass) {
>                         /*
> @@ -2561,6 +2558,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>                                 goto out_image;
>                         }
>
> +                       if (bpf_jit_enable > 1)
> +                               bpf_jit_dump(prog->len, proglen, pass + 1, image);
> +

bpf_jit_enable==2 is broken.
Please delete it from everywhere including docs.
Use bpftool prog dump instead.
