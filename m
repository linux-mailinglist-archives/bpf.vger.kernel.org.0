Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DF85AA156
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 23:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiIAVCh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 17:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiIAVCY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 17:02:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F287C1BE8E
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 14:01:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s11so233948edd.13
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=R2yYcqitL/KBT0vcoWc+Jo39BE1BfNEBPnEeetYdHCE=;
        b=IBDYJj+Bn97OpImQPXIZSWAtRExNYhWaIA0p9e/ks3V+J6+EvJQRhTiMBpCxPzJSqU
         5YJbZd3pNvYvs9cry8jP0pxsa0vwnFNIO0L7Ul5kVpDWo6vAuLaHZ147tgugbsRfn1rY
         UayGDfDNq0WoXprWHVhU+zfNlv60asM1Du/RSkfAP4MNYzfxOKyLhN19yIPa8nSxm/hP
         WAImzGtK6fMUBhRE/5a2ZKmKVtQo2kBknhv2saNteV+0SmZTW9llZeegyepZLDstMg1F
         AUMdDF/aMTFBv6PoLOnUuP5BGgoHG1jeGzVsTDcrnasvika3YxpPrEQTTjHiAOvHsHxJ
         n5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=R2yYcqitL/KBT0vcoWc+Jo39BE1BfNEBPnEeetYdHCE=;
        b=1AHNBxA5dj/eeACSHmzzkYEk07jjs+ZnKVvGkLzJWRwoRUHIVixfU4bEYF9HqyPUK6
         XRA6YDoK/y9DXw8T1McT/jeMBD3yWKTM+s1cRNjUHdtoJAh/ePcWEq8Eji3iX+aW0ht1
         0qbwsk01WA5baoVdsV9ZcvbQjrXE5XXbQvDloidm65GbMu00+K9xkRwuawSoJSMJo+mb
         9uWYMN49KhQluq+uxL9ZUrhvs3RTUWIpvYPyE1BfFG4ZQpNEF8Gfc31HEpE9GZ6H7mdh
         gLIwQMETykRT4TssHdsbpwWJVfSFqBhSsyC/IcqAGhrOQLjibCqy/+q25goaFJuXbw0k
         qmYQ==
X-Gm-Message-State: ACgBeo181YsyAouBXTbJPvTBsw8mV2k2fWHI6TfYbgW4jpOL6EZSx499
        gfg8Nmn3SS0KoASNoWdFoQq7CHN/HhQi1DAsXVU=
X-Google-Smtp-Source: AA6agR63fibAv8yLODB01mOrY4lzI8O3nriOYkTKa176SF2B+6q0GusBZp+o7k6spzhR01cL12wqkRrJfe2VOQE5rLI=
X-Received: by 2002:a05:6402:1c84:b0:447:9d79:74fe with SMTP id
 cy4-20020a0564021c8400b004479d7974femr30678343edb.378.1662066097320; Thu, 01
 Sep 2022 14:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220830172759.4069786-1-davemarchevsky@fb.com> <20220830172759.4069786-2-davemarchevsky@fb.com>
In-Reply-To: <20220830172759.4069786-2-davemarchevsky@fb.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 1 Sep 2022 14:01:26 -0700
Message-ID: <CAJnrk1ZpZ1uLtyiaOK5Sij1nANa8xhOsxMq7PKzyKjVEcL0VtA@mail.gmail.com>
Subject: Re: [RFCv2 PATCH bpf-next 01/18] bpf: Add verifier support for custom
 callback return range
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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

On Tue, Aug 30, 2022 at 11:03 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> Verifier logic to confirm that a callback function returns 0 or 1 was
> added in commit 69c087ba6225b ("bpf: Add bpf_for_each_map_elem() helper").
> At the time, callback return value was only used to continue or stop
> iteration.
>
> In order to support callbacks with a broader return value range, such as
> those added further in this series, add a callback_ret_range to
> bpf_func_state. Verifier's helpers which set in_callback_fn will also
> set the new field, which the verifier will later use to check return
> value bounds.
>
> Default to tnum_range(0, 1) instead of using tnum_unknown as a sentinel
> value as the latter would prevent the valid range (0, U64_MAX) being
> used.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  include/linux/bpf_verifier.h | 1 +
>  kernel/bpf/verifier.c        | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 2e3bad8640dc..9c017575c034 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -237,6 +237,7 @@ struct bpf_func_state {
>          */
>         u32 async_entry_cnt;
>         bool in_callback_fn;
> +       struct tnum callback_ret_range;
>         bool in_async_callback_fn;
>
>         /* The following fields should be last. See copy_func_state() */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9bef8b41e737..68bfa7c28048 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1745,6 +1745,7 @@ static void init_func_state(struct bpf_verifier_env *env,
>         state->callsite = callsite;
>         state->frameno = frameno;
>         state->subprogno = subprogno;
> +       state->callback_ret_range = tnum_range(0, 1);
>         init_reg_state(env, state);
>         mark_verifier_state_scratched(env);
>  }
> @@ -6879,6 +6880,7 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
>         __mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
>         __mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
>         callee->in_callback_fn = true;
> +       callee->callback_ret_range = tnum_range(0, 1);

Thanks for removing this restriction for callback functions!

One quick question: is this line above needed? I think in
__check_func_call, we always call init_func_state() first before
calling set_find_vma_callback_state(), so after the init_func_state()
call, the callee->callback_ret_range will already be set to
tnum_range(0,1).

>         return 0;
>  }
>
> @@ -6906,7 +6908,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>         caller = state->frame[state->curframe];
>         if (callee->in_callback_fn) {
>                 /* enforce R0 return value range [0, 1]. */
> -               struct tnum range = tnum_range(0, 1);
> +               struct tnum range = callee->callback_ret_range;
>
>                 if (r0->type != SCALAR_VALUE) {
>                         verbose(env, "R0 not a scalar value\n");
> --
> 2.30.2
>
