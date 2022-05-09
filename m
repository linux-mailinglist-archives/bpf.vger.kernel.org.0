Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19E85204D8
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbiEITCW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 15:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240421AbiEITCU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 15:02:20 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95E2281356
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 11:58:24 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id o190so16343295iof.10
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bM3pcTuBhNW+/AknWbXNfe6Sw2NbV2ReSbRGaCj6xck=;
        b=YbCgF7FU6k9q93cJFiaXinNsqFDqGepqkH3dcQYU2KZhskr2tyUbXZPm023gK1T1oz
         QRMAEuIi5PELwHNB5I8L3Pl4APd5/d8GUmxDXzEobxidI3rXvio07r91D7NPvpwz5py0
         8o5BAweRK+N8UhSC4vf/s41Wqd6UykMJUY82M6ABNDeL3coiLVZiF8uo6Be+5MMdFTej
         aroJwzd+Secp6ASxhYbUczkILzRF3Ueqeft0Gd6trUJs9uTVfcJ3xUp4Zw975FbyNyDI
         wR4qHTusGtowUrcnn3cfnfO+wV7CJDE4RyCsZ1NjWfGiSnmpAOlTFZdf8nitFZ94EVni
         3EgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bM3pcTuBhNW+/AknWbXNfe6Sw2NbV2ReSbRGaCj6xck=;
        b=v2M6IuJKAdMdvA1fQzZFz08Il1Q6dkRobOanhViZgbt3oVtm51Bd/duL1NALXR+71j
         HTbvjFx/ofgTG5PUbXbVcNKKLjI0FnH+YliIXgTtrbJurvjsVd8UlNz2UwwDsLyJPong
         TRaMlXGWuN8PV3zVyxeYqYokpgF09wtFUwzotRqLopAQl6+rXBVmMnx4vAyyBYBJP1ly
         RFuDgPB+6wDHbsGx3IxZBQD32ndJYcUtTiW/HddzivPtndJG7Df69Kp/4ZUlC3tskrEY
         U4ECdgVmSnZFBD9RPLDHKGVTzydK4vgiIPFjaxDalj3X9CPZ/X8//kIizYNCYh1+Hh46
         mZ+A==
X-Gm-Message-State: AOAM532MZ6sfQ7L6DLBUBS4bpPUQ561IfpsbgheCd4/m852d6y3dn2rb
        RvrtMyNAJEoEsvQctoBDw4txd5gAOO4Tb6FvNC4=
X-Google-Smtp-Source: ABdhPJwTrwwQvWc/9Qruckp2XENNp17XIUcEX3hSDecRP6Q395vDQHzTEb/T1+OhW+lghisaJJDTB4mErg3FFX+3ay0=
X-Received: by 2002:a05:6602:1683:b0:64f:ba36:d3cf with SMTP id
 s3-20020a056602168300b0064fba36d3cfmr6963916iow.144.1652122704016; Mon, 09
 May 2022 11:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220508032117.2783209-1-kuifeng@fb.com> <20220508032117.2783209-4-kuifeng@fb.com>
In-Reply-To: <20220508032117.2783209-4-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 11:58:13 -0700
Message-ID: <CAEf4BzYitV038g5SW1DexVuxH1YNgdgfKs_yV+ExbRPuy++N3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 3/5] bpf, x86: Attach a cookie to fentry/fexit/fmod_ret/lsm.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 7, 2022 at 8:21 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Pass a cookie along with BPF_LINK_CREATE requests.
>
> Add a bpf_cookie field to struct bpf_tracing_link to attach a cookie.
> The cookie of a bpf_tracing_link is available by calling
> bpf_get_attach_cookie when running the BPF program of the attached
> link.
>
> The value of a cookie will be set at bpf_tramp_run_ctx by the
> trampoline of the link.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c    | 12 ++++++++++--
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  9 +++++++++
>  kernel/bpf/bpf_lsm.c           | 17 +++++++++++++++++
>  kernel/bpf/syscall.c           | 12 ++++++++----
>  kernel/bpf/trampoline.c        |  7 +++++--
>  kernel/trace/bpf_trace.c       | 17 +++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  9 +++++++++
>  8 files changed, 76 insertions(+), 8 deletions(-)
>

LGTM with a suggestion for some follow up clean up.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index bf4576a6938c..52a5eba2d5e8 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1764,13 +1764,21 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>                            struct bpf_tramp_link *l, int stack_size,
>                            bool save_ret)
>  {
> +       u64 cookie = 0;
>         u8 *prog = *pprog;
>         u8 *jmp_insn;
>         int ctx_cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
>         struct bpf_prog *p = l->link.prog;
>
> -       /* mov rdi, 0 */
> -       emit_mov_imm64(&prog, BPF_REG_1, 0, 0);
> +       if (l->link.type == BPF_LINK_TYPE_TRACING) {

It would probably be nicer to put cookie field into struct
bpf_tramp_link instead so that the JIT compiler doesn't have to do
this special handling. It also makes sense that struct bpf_trampoline
*trampoline is moved into struct bpf_tramp_link itself (given
trampoline is always there for bpf_tramp_link).

> +               struct bpf_tracing_link *tr_link =
> +                       container_of(l, struct bpf_tracing_link, link);
> +
> +               cookie = tr_link->cookie;
> +       }
> +
> +       /* mov rdi, cookie */
> +       emit_mov_imm64(&prog, BPF_REG_1, (long) cookie >> 32, (u32) (long) cookie);
>
>         /* Prepare struct bpf_tramp_run_ctx.
>          *

[...]
