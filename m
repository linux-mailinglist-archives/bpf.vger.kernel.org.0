Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51EC1785BA
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 23:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCCWiL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 17:38:11 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34846 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgCCWiL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 17:38:11 -0500
Received: by mail-qk1-f195.google.com with SMTP id 145so5197812qkl.2;
        Tue, 03 Mar 2020 14:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88lKfSfxqeKfW9gPmeZNxU/n5BEhm6ow0JX/FjM1ow0=;
        b=Eea/ossAaGke+BXBqhzBcqWt7LcYZFg+xJy+lW2C2M2TgoHjybgnVxdmtMzivSYm6f
         rDA8MYlpP2JV7LM+hN4Wqv78PCUnLlLHYkciQHGyLh02hFZ/OVNhKPB39a+/LFsPpPEF
         EwEJIKoNuEQdPeRP9V0BhSYq2ZeNFTbXaAPLIgoSw8pwj7SP5bGy29QbA3Ec1ZrThLQ1
         ylzofUVzUdYcGB3u62u5OOr4owR8TLDxaM1EiJyiaebVQaKCeWek0Rj9vfM3FB62abLS
         fe2Y+flireZmGdceY3SBZr2li29R3VktpJN8RRQH2o14wpSFXHDvlwJmhAhj36rznadq
         WQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88lKfSfxqeKfW9gPmeZNxU/n5BEhm6ow0JX/FjM1ow0=;
        b=NNDHx+UgdGocl7pIO8Y3PYp+L+OW3ttgvEFM3sDuTpGvRhHUIpbbCbXyLWssCeyIGx
         mbVNZIxr5+eWXy3Ep164grHupch8D4NS5ImY5Y4c5QOC5b8Rw1Ww9oXjafcqSyb9bvYm
         SlAVbQMMxneSyDoFYalwvR1dS8CyR1TTTp6FRBjkJeUpoNbCbHPkVs1hf2F0rbNG/VAF
         xMwnbNnOLRv0C0/rfNjo/W6iXjdm2XCvCJH6SUxsAvmYr2S17eca8X1KEZZGDVTpTAvm
         s+/J+NQfqSWVPykE7FJrBPCQz5Jom3OQ6ELznMK8kLLYZd4aUuILXXT94wP9JXGZoWsl
         BpuQ==
X-Gm-Message-State: ANhLgQ2HS2H4NyARHip0O+klRVzrj4k2Xy2ARj+0JoRFAR3aeVDeVI/X
        cGBF/wmKrnE9AoHKu3TVevpJMR5DWkDumskDDtQ=
X-Google-Smtp-Source: ADFU+vvegmGWnsIiWRqtrOWlAq083f+jCj/g1rN8KnGNlDatrhclHcbcOE/PPvDweniboXXOP0dPiikYM09L0uigyDw=
X-Received: by 2002:a05:620a:99d:: with SMTP id x29mr270802qkx.39.1583275090204;
 Tue, 03 Mar 2020 14:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20200303140950.6355-1-kpsingh@chromium.org> <20200303140950.6355-4-kpsingh@chromium.org>
In-Reply-To: <20200303140950.6355-4-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Mar 2020 14:37:58 -0800
Message-ID: <CAEf4BzZVV12WoHDnQSfOKpndr3qVLEAz8itMcdqnQq8Q4njc0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: Introduce BPF_MODIFY_RETURN
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

On Tue, Mar 3, 2020 at 6:12 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> When multiple programs are attached, each program receives the return
> value from the previous program on the stack and the last program
> provides the return value to the attached function.
>
> The fmod_ret bpf programs are run after the fentry programs and before
> the fexit programs. The original function is only called if all the
> fmod_ret programs return 0 to avoid any unintended side-effects. The
> success value, i.e. 0 is not currently configurable but can be made so
> where user-space can specify it at load time.
>
> For example:
>
> int func_to_be_attached(int a, int b)
> {  <--- do_fentry
>
> do_fmod_ret:
>    <update ret by calling fmod_ret>
>    if (ret != 0)
>         goto do_fexit;
>
> original_function:
>
>     <side_effects_happen_here>
>
> }  <--- do_fexit
>
> The fmod_ret program attached to this function can be defined as:
>
> SEC("fmod_ret/func_to_be_attached")
> BPF_PROG(func_name, int a, int b, int ret)

same as on cover letter, return type is missing

> {
>         // This will skip the original function logic.
>         return 1;
> }
>
> The first fmod_ret program is passed 0 in its return argument.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  arch/x86/net/bpf_jit_comp.c    | 96 ++++++++++++++++++++++++++++++++--
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/btf.c               |  3 +-
>  kernel/bpf/syscall.c           |  1 +
>  kernel/bpf/trampoline.c        |  5 +-
>  kernel/bpf/verifier.c          |  1 +
>  tools/include/uapi/linux/bpf.h |  1 +
>  8 files changed, 103 insertions(+), 6 deletions(-)
>

[...]

>
> +       if (fmod_ret->nr_progs) {
> +               branches = kcalloc(fmod_ret->nr_progs, sizeof(u8 *),
> +                                  GFP_KERNEL);
> +               if (!branches)
> +                       return -ENOMEM;
> +               if (invoke_bpf_mod_ret(m, &prog, fmod_ret, stack_size,
> +                                      branches))

branches leaks here

> +                       return -EINVAL;
> +       }
> +
>         if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -               if (fentry->nr_progs)
> +               if (fentry->nr_progs || fmod_ret->nr_progs)
>                         restore_regs(m, &prog, nr_args, stack_size);
>
>                 /* call original function */
> @@ -1573,6 +1649,14 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,

there is early return one line above here, you need to free branches
in that case to not leak memory

So I guess it's better to do goto cleanup approach at this point?

>                 emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
>         }
>
> +       if (fmod_ret->nr_progs) {
> +               align16_branch_target(&prog);
> +               for (i = 0; i < fmod_ret->nr_progs; i++)
> +                       emit_cond_near_jump(&branches[i], prog, branches[i],
> +                                           X86_JNE);
> +               kfree(branches);
> +       }
> +

[...]
