Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5157E55A427
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 00:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiFXWDc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 18:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiFXWDa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 18:03:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25ED29809
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 15:03:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g26so7313056ejb.5
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 15:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3f3QCII6TZAgPp2xDGE3Bt8q0cwOwMBvDGKytDSQqY=;
        b=bdMTLL1ZnlQFQUuv0z3hS9/EmINwjgdCFIQ7Ly76uL/WAfVFDCF2SDMOsC1yJ4kT+Q
         cUYA6PmaxoUFH73rpFEymLSNIN+dD8sCTjUKUfjSl+QEPlJZLLWXxmj+uQK6doh2k4BS
         zRQv4JjUSIcpfmc+zYt0BsZ6VIfVHvgxAUNJ1eBxxdWYuUwuocNlXvHHIej5nPsl7ACZ
         z2nJAQEALTAEa+yRkeiicTFL+4VDIpM2qfBtb/yao39tExUqFra2FUlHDwz5Bjrej1Ty
         Z2l/Xwpg+lyPI9KcDaX551SbJ4QXqUbATW1ulwq2YiixovquESU3f0JSMGMkM0MdRFZG
         vy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3f3QCII6TZAgPp2xDGE3Bt8q0cwOwMBvDGKytDSQqY=;
        b=ikfsW2FzTiS34Up1J8T1BGj+sAzHebp3nIENNWeic7IvZQt8Uz3ISSuphLGZrIXQgv
         fscHuIrVgFbg4AR2QuCqb7IF6t5w5rX/i8Kc43HN0xGT1oAs56rVY6WQIzo6iOzUwSPc
         /yuozd8eFnCHQjcZNhHtiO+iWEEaqPwPB+Xrp+QAX+n3+7T6zAI1pa9pd/MkAxYrnHN5
         nfPnlPUqv37KOx3wBkAOUIqXWZsv5wHcBwf5Hi/wJLA7hnUPU9/mzuBsjfjTwGzZfWFm
         Jof4hA3A1dM2A5QzDrcyrjMIiy50hT0AZBzH8p6gaQmHE+XEDexvdXPvNovCYQBWGjvs
         g4FQ==
X-Gm-Message-State: AJIora+TaoKYKZNcgavlo6O7OVY2WXEtISErqjRMNXzorklBYUCsofbj
        D7k2O/X9X6xvLGWE1KkZSKBETj7nkbTKeRX+BsQ=
X-Google-Smtp-Source: AGRyM1tX5+bRNjz5hLb8ytLRvcxaSK9rzhm4dqPMclnVlAXvZsNkq9QF8Wa1dS5HJOnuENjCrerEWZ4LbXAaA8Tkeug=
X-Received: by 2002:a17:906:9b92:b0:722:f705:759d with SMTP id
 dd18-20020a1709069b9200b00722f705759dmr1089637ejc.745.1656108200159; Fri, 24
 Jun 2022 15:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220624045636.3668195-1-kpsingh@kernel.org> <20220624045636.3668195-3-kpsingh@kernel.org>
In-Reply-To: <20220624045636.3668195-3-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Jun 2022 15:03:08 -0700
Message-ID: <CAEf4Bza_ZWmFN0YreF7Oqj+jerGkydcJc9bKe=+DDT0LJAZLCw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/5] bpf: kfunc support for ARG_PTR_TO_CONST_STR
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
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

On Thu, Jun 23, 2022 at 9:56 PM KP Singh <kpsingh@kernel.org> wrote:
>
> kfuncs can handle pointers to memory when the next argument is
> the size of the memory that can be read and verify these as
> ARG_CONST_SIZE_OR_ZERO
>
> Similarly add support for string constants (const char *) and
> verify it similar to ARG_PTR_TO_CONST_STR.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf_verifier.h |  2 +
>  kernel/bpf/btf.c             | 25 ++++++++++
>  kernel/bpf/verifier.c        | 89 +++++++++++++++++++++---------------
>  3 files changed, 78 insertions(+), 38 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 81b19669efba..f6d8898270d5 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -560,6 +560,8 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
>                              u32 regno);
>  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>                    u32 regno, u32 mem_size);
> +int check_const_str(struct bpf_verifier_env *env,
> +                   const struct bpf_reg_state *reg, int regno);
>
>  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
>  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 668ecf61649b..b31e8d8f2d4d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6162,6 +6162,23 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
>         return true;
>  }
>
> +static bool btf_param_is_const_str_ptr(const struct btf *btf,
> +                                      const struct btf_param *param)
> +{
> +       const struct btf_type *t;
> +
> +       t = btf_type_by_id(btf, param->type);
> +       if (!btf_type_is_ptr(t))
> +               return false;
> +
> +       t = btf_type_by_id(btf, t->type);
> +       if (BTF_INFO_KIND(t->info) != BTF_KIND_CONST)
> +               return false;
> +
> +       t = btf_type_skip_modifiers(btf, t->type, NULL);

nit: this looks a bit fragile, you assume CONST comes first and then
skip the rest of modifiers (including typedefs). Maybe either make it
more permissive and then check that CONST is somewhere there in the
chain (you'll have to open-code btf_type_skip_modifiers() loop), or
make it more restrictive and say that it has to be `const char *` and
nothing else (no volatile, no restrict, no typedefs)?

> +       return !strcmp(btf_name_by_offset(btf, t->name_off), "char");
> +}
> +

[...]
