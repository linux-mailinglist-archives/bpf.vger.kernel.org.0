Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39B0A17859B
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 23:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgCCW0W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 17:26:22 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38074 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgCCW0W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 17:26:22 -0500
Received: by mail-qk1-f196.google.com with SMTP id h22so5142407qke.5;
        Tue, 03 Mar 2020 14:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wagrVCzS/XTiayLok4nktlIE6b9GM+kU+mOoA/5BUNQ=;
        b=Imebv53X2yi2WO2vBjXJnc2vvyk3l9qMBZXaUJaOUOgVd0pHdwWbRO8ViUIGKuFEya
         k3cBuospCwoqTF8lPuQofzal2lkaGUwsaw96sH1TrytGrqawdqkvDq2op7vcPso25yq2
         iZi3BsykiP20586JqH3pd3J+M5kx/F39T0F2Ef6RpPyvGQnwFEYFeTF2i0TfnwlgBz7O
         3uUutbiMzQc9XD4rZmBXqfTuWctktVmS+kssFTpj+n7FuBzvkXGZhUOiDun2ND+/VVCr
         b4vnW/SVEMNvgqMN50J/CfTUcFMTnIdaC/TpVcnCK/J5jBUwQZjkNTOZaAMr+zmaoOS9
         OxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wagrVCzS/XTiayLok4nktlIE6b9GM+kU+mOoA/5BUNQ=;
        b=eBLJZ4dgXs08JOqjGf8GmdBHDIpV/p+89HgXRxTZReC5QP8fGayuaABmNAlp60d/ex
         CIVznFW6DWkNX20mGgzx6Ht8OjueSoau1YIiqnxmCdPWZRA56NA2OU2Rz+NBt1Sb7X+z
         Y9CkBPpOeKlpTKr5+0DvJUgtVm2SbzFtHE1Z+ktOURuQPRTBRJYdQ8zTDCa4nEmXQHfR
         QQ38kCwfQFPRlDem315QcxUbQvrCbSAUQsWTbf7Z5nipYRjeZzU1+VzpuIIZTItJ0ogT
         Ki641z1+y8D1/ngFn1TmvvHU0pEI6IwxxzAQeufjwXm27wJ/4RmC+XAGvsf16HleTgQj
         rxJg==
X-Gm-Message-State: ANhLgQ16hO1Jl4bGguS6Q640LzEaBds4m0GrSb4CAB7vnEP6KGUYScbG
        +wOW64ABfrZoeGuI/J+ARbHhHjG/4RUeOuBpcFM=
X-Google-Smtp-Source: ADFU+vvV2oNfqztGhuZHjThFr3r5hmgjU00PGxySl8X9BewWNLNQv3zc5Elq9UNraKBA9K6n4/Y9SqH3Z3Fj4IK0I18=
X-Received: by 2002:a05:620a:99d:: with SMTP id x29mr231581qkx.39.1583274380969;
 Tue, 03 Mar 2020 14:26:20 -0800 (PST)
MIME-Version: 1.0
References: <20200303140950.6355-1-kpsingh@chromium.org> <20200303140950.6355-3-kpsingh@chromium.org>
In-Reply-To: <20200303140950.6355-3-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Mar 2020 14:26:09 -0800
Message-ID: <CAEf4BzZJ2E2rmyz7k4F7s=EXPbaAX7XncvUcHukX_FYDWeD7BA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/7] bpf: JIT helpers for fmod_ret progs
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 3, 2020 at 6:13 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> * Split the invoke_bpf program to prepare for special handling of
>   fmod_ret programs introduced in a subsequent patch.
> * Move the definition of emit_cond_near_jump and emit_nops as they are
>   needed for fmod_ret.
> * Refactor branch target alignment into its own function
>   align16_branch_target.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 158 ++++++++++++++++++++----------------
>  1 file changed, 90 insertions(+), 68 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 15c7d28bc05c..475e354c2e88 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1361,35 +1361,100 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
>                          -(stack_size - i * 8));
>  }
>

[...]

> +
> +/* From Intel 64 and IA-32 Architectures Optimization
> + * Reference Manual, 3.4.1.4 Code Alignment, Assembly/Compiler
> + * Coding Rule 11: All branch targets should be 16-byte
> + * aligned.
> + */
> +static void align16_branch_target(u8 **pprog)
> +{
> +       u8 *target, *prog = *pprog;
> +
> +       target = PTR_ALIGN(prog, 16);
> +       if (target != prog)
> +               emit_nops(&prog, target - prog);
> +       if (target != prog)
> +               pr_err("calcultion error\n");

this wasn't in the original code, do you feel like it's more important
to check this and print error?

also typo: calculation error, but then it's a bit brief and
uninformative message. So I don't know, maybe just drop it?

> +}
> +
> +static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
> +{
> +       u8 *prog = *pprog;
> +       int cnt = 0;
> +       s64 offset;
> +
> +       offset = func - (ip + 2 + 4);
> +       if (!is_simm32(offset)) {
> +               pr_err("Target %p is out of range\n", func);
> +               return -EINVAL;
> +       }
> +       EMIT2_off32(0x0F, jmp_cond + 0x10, offset);
> +       *pprog = prog;
> +       return 0;
> +}
> +

[...]
