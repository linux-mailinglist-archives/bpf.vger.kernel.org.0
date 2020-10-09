Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D550289AA8
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 23:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391639AbgJIVbl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 17:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391457AbgJIVas (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 17:30:48 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFF3C0613D5
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 14:30:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id h24so15125107ejg.9
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 14:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbFcqf/DjvQ4JWXqdwx2qoDcjZm2i9Wcon6pZeNDz5o=;
        b=ZG7/cR3DKUuQ/RPLGoR9GRiVD5sFiQY9qmvwtKGyjQ7dUx6cRoXQxPJrsofVX4GvT8
         +bHrvlkc1QdE5fUuR+B4/jEqIhD96HiZRW7ovaFsuN3fEZ+QZA4WfW7Zoh4Ks3/JQ0EC
         foiF78nQ6mvg4w1M98iFAIEqKbJDxwbcU0l389avKqsHHsxkP1F73Y3V7TTlMKHaLOCS
         Dm4YqX7AZSogV5VQASZlZfU5CJKMZXVuwmHApTvWmqpz+YKzBi4/BWNPCESa5p7ZbAdQ
         xYthw3ucPw0eXtEwmhEb7cEy71fk2ZQJ7DXR2iGsteCPu+HY7ggdx/mX75DxDqxJz9QQ
         OIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbFcqf/DjvQ4JWXqdwx2qoDcjZm2i9Wcon6pZeNDz5o=;
        b=RCYN8/IuE8nR0OHi6IBpADHS3a03Df0VpfOM7POZ1/nJwXXsWBeOBS5t4NfCCdM3gu
         TYTDQigwpugU8y1+dVtxsQRESc7Nd5RmJ1fKmJGdFArXbLOsWjoV2RlLB2GwvD3HCbSM
         J/aSAfSfpxF7DgL2bsNUa+hpolxFeE7If6UzM3Coib5vbZd7lUmjW5XpUfb/xP7t/gl0
         HpvLE6ORiOhtEWKWmDxLSLdW7PevSZp5HKe7DdWXxhdDv+RYDMl+mG+VpC58hccVbzQ8
         bQOJf6bTNd9ZAgXuAF7kj+C2XDHB1s0yvjWqadL/haeWoaggddhTgkqYmej448gDFaZl
         uc7w==
X-Gm-Message-State: AOAM533tyr+vdTEMHLm/CRPDIIGCXSM22Qk0PMsUL4qNVuP8eCkf0Vo4
        J/E+kd+3fGyBLZ2JuUdFBAIDBJbwehS/6gH/ePO6xw==
X-Google-Smtp-Source: ABdhPJyVuDxjo0a1CY6IfHFSG0IBKbx7nRGluOc+6dUadBRHkjJq4TYQS4jlWBBOaj1ul7WftAzGnhhHBZG2FVIDTO8=
X-Received: by 2002:a17:906:86c3:: with SMTP id j3mr16811843ejy.493.1602279044763;
 Fri, 09 Oct 2020 14:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602263422.git.yifeifz2@illinois.edu> <1a40458d081ce0d5423eb0282210055496e28774.1602263422.git.yifeifz2@illinois.edu>
In-Reply-To: <1a40458d081ce0d5423eb0282210055496e28774.1602263422.git.yifeifz2@illinois.edu>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 9 Oct 2020 23:30:18 +0200
Message-ID: <CAG48ez1eUfjNPVKeYbk28On9WOaDBysR-=7sYDM-Q=nCzwXcDA@mail.gmail.com>
Subject: Re: [PATCH v4 seccomp 2/5] seccomp/cache: Add "emulator" to check if
 filter is constant allow
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 9, 2020 at 7:15 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>
> From: YiFei Zhu <yifeifz2@illinois.edu>
>
> SECCOMP_CACHE will only operate on syscalls that do not access
> any syscall arguments or instruction pointer. To facilitate
> this we need a static analyser to know whether a filter will
> return allow regardless of syscall arguments for a given
> architecture number / syscall number pair. This is implemented
> here with a pseudo-emulator, and stored in a per-filter bitmap.
>
> In order to build this bitmap at filter attach time, each filter is
> emulated for every syscall (under each possible architecture), and
> checked for any accesses of struct seccomp_data that are not the "arch"
> nor "nr" (syscall) members. If only "arch" and "nr" are examined, and
> the program returns allow, then we can be sure that the filter must
> return allow independent from syscall arguments.
>
> Nearly all seccomp filters are built from these cBPF instructions:
>
> BPF_LD  | BPF_W    | BPF_ABS
> BPF_JMP | BPF_JEQ  | BPF_K
> BPF_JMP | BPF_JGE  | BPF_K
> BPF_JMP | BPF_JGT  | BPF_K
> BPF_JMP | BPF_JSET | BPF_K
> BPF_JMP | BPF_JA
> BPF_RET | BPF_K
> BPF_ALU | BPF_AND  | BPF_K
>
> Each of these instructions are emulated. Any weirdness or loading
> from a syscall argument will cause the emulator to bail.
>
> The emulation is also halted if it reaches a return. In that case,
> if it returns an SECCOMP_RET_ALLOW, the syscall is marked as good.
>
> Emulator structure and comments are from Kees [1] and Jann [2].
>
> Emulation is done at attach time. If a filter depends on more
> filters, and if the dependee does not guarantee to allow the
> syscall, then we skip the emulation of this syscall.
>
> [1] https://lore.kernel.org/lkml/20200923232923.3142503-5-keescook@chromium.org/
> [2] https://lore.kernel.org/lkml/CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com/
[...]
> @@ -682,6 +693,150 @@ seccomp_prepare_user_filter(const char __user *user_filter)
>         return filter;
>  }
>
> +#ifdef SECCOMP_ARCH_NATIVE
> +/**
> + * seccomp_is_const_allow - check if filter is constant allow with given data
> + * @fprog: The BPF programs
> + * @sd: The seccomp data to check against, only syscall number are arch
> + *      number are considered constant.

nit: s/syscall number are arch number/syscall number and arch number/

> + */
> +static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> +                                  struct seccomp_data *sd)
> +{
> +       unsigned int insns;
> +       unsigned int reg_value = 0;
> +       unsigned int pc;
> +       bool op_res;
> +
> +       if (WARN_ON_ONCE(!fprog))
> +               return false;
> +
> +       insns = bpf_classic_proglen(fprog);

bpf_classic_proglen() is defined as:

#define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))

so this is wrong - what you want is the number of instructions in the
program, what you actually have is the size of the program in bytes.
Please instead check for `pc < fprog->len` in the loop condition.

> +       for (pc = 0; pc < insns; pc++) {
> +               struct sock_filter *insn = &fprog->filter[pc];
> +               u16 code = insn->code;
> +               u32 k = insn->k;
[...]

> +       }
> +
> +       /* ran off the end of the filter?! */
> +       WARN_ON(1);
> +       return false;
> +}
