Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22667315E1F
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 05:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBJEQB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 23:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhBJEPk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 23:15:40 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2521BC061574
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 20:15:00 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b2so883720lfq.0
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 20:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1wM82AvRPBFo+Lq6SgJQCeBvrjWhSf7sw9LdH2NY68E=;
        b=oCG1ROS5VQt+FRMCFM3vd7EoqNlSxNVHAHWwYPVMKyY5hz6G0kj5bFbnBZ2bm5zmO7
         NcZDJIF1GC5qFB7cmnvFdK8s40BcMnPwTeRa6zzQbQtRfzcNoj7PKBxXViXmQoHVaLit
         yDHlBYa6KR2HT3S+OtaChvMbWc2/PX3fkfTwXqIO9sV5ARjwxdefPUK9UedHNn3K/ePz
         m9al9Lxz4IMl719Cz/lkzTuWZEP+Eo1fU7VBzViSukzVtWQ7jxHSG1/cRiCEM/F9u3AY
         PM4ZlW/wVbpnjLRSVMnxtoBxtiWOD2CATogJ/YWBXBCJAjM9X+AChGe/sHnoC0U8L92S
         QfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wM82AvRPBFo+Lq6SgJQCeBvrjWhSf7sw9LdH2NY68E=;
        b=VaPuuD5p5khUR60pxzvjp5fRUo0oAlotcFr7U6FN7uXMEinXHO7uXPpW8wyijP1Umh
         nkSQ4i5kw16IbUdnKFd0y2TTM3LvuQd6z3tMOQjvsNaCEv7TIAbMeBBj5T1H3aoQsiZ3
         3d6ly4/XrnV1/MHDRXzYS0Bqe4QoklkXPZNOx6oX4iiKpNmcBWb18ZPhKCx0gJE00JiM
         A78lcnU7EeTyLC/cEemWY7+PSPv5PT1x6Zl5yCYklwTDrq8s/EtFLQhW402THusJ69YR
         12VS9x9ZnbaIFRBRfKZ256unbLHEenP/HGzkk59Liyg5WTtgxVnqYQgHcP/RJofCKEWa
         5Y7w==
X-Gm-Message-State: AOAM531YJmeAqQO4kXzVdMhiE/RC6QjAx5+T+nB++tGBto68XjzcLmX6
        KQx1oZVp5d84ag1yhnYgpQyf07/ta5Ctwbgf5l4RCAQ9
X-Google-Smtp-Source: ABdhPJwijn1jXQOOj4N+lAqncLVi2zB/M/qEGHY0Up9qOxVGbkfvilASovER5xl6nuYZY49e1AO04p7/6D7jN+icDTM=
X-Received: by 2002:a05:6512:2254:: with SMTP id i20mr652747lfu.534.1612930498667;
 Tue, 09 Feb 2021 20:14:58 -0800 (PST)
MIME-Version: 1.0
References: <b1792bb3c51eb3e94b9d27e67665d3f2209bba7e.camel@linux.ibm.com>
In-Reply-To: <b1792bb3c51eb3e94b9d27e67665d3f2209bba7e.camel@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Feb 2021 20:14:47 -0800
Message-ID: <CAADnVQJFcFwxEz=wnV=hkie-EDwa8s5JGbBQeFt1TGux1OihJw@mail.gmail.com>
Subject: Re: What should BPF_CMPXCHG do when the values match?
To:     Ilya Leoshkevich <iii@linux.ibm.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Brendan Jackman <jackmanb@google.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 9, 2021 at 4:43 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Hi,
>
> I'm implementing BPF_CMPXCHG for the s390x JIT and noticed that the
> doc, the interpreter and the X64 JIT do not agree on what the behavior
> should be when the values match.
>
> If the operand size is BPF_W, this matters, because, depending on the
> answer, the upper bits of R0 are either zeroed out out or are left
> intact.
>
> I made the experiment based on the following modification to the
> "atomic compare-and-exchange smoketest - 32bit" test on top of commit
> ee5cc0363ea0:
>
> --- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> +++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> @@ -57,8 +57,8 @@
>                 BPF_MOV32_IMM(BPF_REG_1, 4),
>                 BPF_MOV32_IMM(BPF_REG_0, 3),
>                 BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10,
> BPF_REG_1, -4),
> -               /* if (old != 3) exit(4); */
> -               BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
> +               /* if ((u64)old != 3) exit(4); */
> +               BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
>                 BPF_MOV32_IMM(BPF_REG_0, 4),
>                 BPF_EXIT_INSN(),
>                 /* if (val != 4) exit(5); */
>
> and got the following results:
>
> 1) Documentation: Upper bits of R0 are zeroed out - but it looks as if
>    there is a typo and either a period or the word "otherwise" is
>    missing?
>
>    > If they match it is replaced with ``src_reg``, The value that was
>    > there before is loaded back to ``R0``.
>
> 2) Interpreter + KVM: Upper bits of R0 are zeroed out (C semantics)
>
> 3) X64 JIT + KVM: Upper bits of R0 are untouched (cmpxchg semantics)
>
>    => 0xffffffffc0146bc7: lock cmpxchg %edi,-0x4(%rbp)
>       0xffffffffc0146bcc: cmp $0x3,%rax
>    (gdb) p/x $rax
>    0x6bd5720c00000003
>    (gdb) x/d $rbp-4
>    0xffffc90001263d5c: 3
>
>       0xffffffffc0146bc7: lock cmpxchg %edi,-0x4(%rbp)
>    => 0xffffffffc0146bcc: cmp $0x3,%rax
>    (gdb) p/x $rax
>    0x6bd5720c00000003
>
> 4) X64 JIT + TCG: Upper bits of R0 are zeroed out (qemu bug?)
>
>    => 0xffffffffc01441fc: lock cmpxchg %edi,-0x4(%rbp)
>       0xffffffffc0144201: cmp $0x3,%rax
>    (gdb) p/x $rax
>    0x81776ea600000003
>    (gdb) x/d $rbp-4
>    0xffffc90001117d5c: 3
>
>       0xffffffffc01441fc: lock cmpxchg %edi,-0x4(%rbp)
>    => 0xffffffffc0144201: cmp $0x3,%rax
>    (gdb) p/x $rax
>    $3 = 0x3
>
> So which option is the right one? In my opinion, it would be safer to
> follow what the interpreter does and zero out the upper bits.

Wow. What a find!
I thought that all 32-bit x86 ops zero-extend the dest register.
I agree that it's best to zero upper bits for cmpxchg as well.
I wonder whether compilers know about this exceptional behavior.
I believe the bpf backend considers full R0 to be used by bpf's cmpxchg.

Do you know what xchg does on x86? What about arm64 with cas?
