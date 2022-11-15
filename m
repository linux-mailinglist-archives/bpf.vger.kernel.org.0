Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAA2629124
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 05:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiKOEQC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 23:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiKOEP4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 23:15:56 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764051DF08
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 20:15:53 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ft34so33102372ejc.12
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 20:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=25mVgtKGUkJMTXKF1kyF8wFUjw56pp0SsVm1813ZUUs=;
        b=Ejc46E9PD7+EK+Ec2NBc+EJHgt29xDtAiaM0r/h8JgsXZKDkxenn7xatChyKipukBV
         SMcuZwQiIu0oFURVBY+2kkX0zdzf/aDemdrZOaBcw9t5eW5tHma8QlMQeFtYqydqdHEu
         kh5YvH/5JbDtr77qDLsLVNC8nhcIoW93aAvy0Hfml0eB/YjvqKEe2Ag37GM8hegLh39G
         n4b7i7UJLsJSrAdYbRJIyhip7IIWg0s+OmIHSZpr6sOACdtaxIfPBguT7xeSTo88OuRH
         UxbYbDcs8QpXJo3ANgPW8hMvT8yJdxN1to8A29El2WDbt4YodG9SCs4j5hlZc9doWArL
         c2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25mVgtKGUkJMTXKF1kyF8wFUjw56pp0SsVm1813ZUUs=;
        b=6Q9hgPcmM1dtMX54g4v2jfdoNSIVpd3GTNMeHkwQ/z6IC0adOjoJPv39rBowWlGTXE
         WI3TvCmP6SUarOjdM3omAZFAikf6fZ6ZQm7PPdZRpqnU8J5gNeZfQCIokrME2IuwY3Rx
         eAnrypUdlDdpEuwpsut3Ev7bZptXRGbVZmzgiRdHaxFBIo4RLL+GrmQw1Ci6uABepdp1
         8xhdQaZbpDEAAZ2RutBvc4vYRVTeaE6WiT6zLBu779kEsl4JD+wQpaKE5A5IrojlmaPE
         cyUIX017VGp0Z5a0VKMfTO+TQ4LPxSkZzqAybm8+MlBBeVXK1y4zY+rD0nI4UVgM3JeJ
         Dkag==
X-Gm-Message-State: ANoB5pmFFXc65/55MncFp3IZgsgzbrq11oIlNgBEimRYTz8bTI6/YMTX
        IHSy25sMLOBkKJnLecI8d0fYthGVGlHpRtXFF/w=
X-Google-Smtp-Source: AA0mqf4kItxK5NJE/1teLnL4sWA/DJ58wR77ikwH6D5k5k217uxOADTqCGuImhmN9figMbMAmnR79vvDIiuYU4ep1fQ=
X-Received: by 2002:a17:906:7ca:b0:7ad:934e:95d3 with SMTP id
 m10-20020a17090607ca00b007ad934e95d3mr12359178ejc.393.1668485751777; Mon, 14
 Nov 2022 20:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20221115000130.1967465-1-memxor@gmail.com> <20221115000130.1967465-2-memxor@gmail.com>
In-Reply-To: <20221115000130.1967465-2-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 14 Nov 2022 20:15:40 -0800
Message-ID: <CAJnrk1bGOU-FFS5J=BJHVQh_nVPjWK4w777zL=1fz7LRetu3+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/7] bpf: Refactor ARG_PTR_TO_DYNPTR checks
 into process_dynptr_func
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, David Vernet <void@manifault.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
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

On Mon, Nov 14, 2022 at 4:01 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> ARG_PTR_TO_DYNPTR is akin to ARG_PTR_TO_TIMER, ARG_PTR_TO_KPTR, where
> the underlying register type is subjected to more special checks to
> determine the type of object represented by the pointer and its state
> consistency.
>
> Move dynptr checks to their own 'process_dynptr_func' function so that
> is consistent and in-line with existing code. This also makes it easier
> to reuse this code for kfunc handling.
>
> Then, reuse this consolidated function in kfunc dynptr handling too.
> Note that for kfuncs, the arg_type constraint of DYNPTR_TYPE_LOCAL has
> been lifted.
>
> Acked-by: David Vernet <void@manifault.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Joanne Koong <joannelkoong@gmail.com>

Left a couple of comments below but otherwise LGTM!

> ---
>  include/linux/bpf_verifier.h                  |   8 +-
>  kernel/bpf/btf.c                              |  17 +--
>  kernel/bpf/verifier.c                         | 116 ++++++++++--------
>  .../bpf/prog_tests/kfunc_dynptr_param.c       |   5 +-
>  .../bpf/progs/test_kfunc_dynptr_param.c       |  12 --
>  5 files changed, 70 insertions(+), 88 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 1a32baa78ce2..a69b6d49d40c 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -593,11 +593,9 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
>                              u32 regno);
>  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>                    u32 regno, u32 mem_size);
> -bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> -                             struct bpf_reg_state *reg);
> -bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> -                            struct bpf_reg_state *reg,
> -                            enum bpf_arg_type arg_type);
> +struct bpf_call_arg_meta;
> +int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> +                       enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta);
>
>  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
>  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 5579ff3a5b54..d02ae2f4249b 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6575,23 +6575,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>                                                 return -EINVAL;
>                                         }
>
> -                                       if (!is_dynptr_reg_valid_init(env, reg)) {
> -                                               bpf_log(log,
> -                                                       "arg#%d pointer type %s %s must be valid and initialized\n",
> -                                                       i, btf_type_str(ref_t),
> -                                                       ref_tname);
> +                                       if (process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR, NULL))
>                                                 return -EINVAL;
> -                                       }
> -
> -                                       if (!is_dynptr_type_expected(env, reg,
> -                                                       ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
> -                                               bpf_log(log,
> -                                                       "arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
> -                                                       i, btf_type_str(ref_t),
> -                                                       ref_tname);
> -                                               return -EINVAL;
> -                                       }
> -
>                                         continue;
>                                 }
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 07c0259dfc1a..56f48ab9827f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -784,8 +784,7 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>         return true;
>  }
>
> -bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> -                             struct bpf_reg_state *reg)
> +static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state = func(env, reg);
>         int spi = get_spi(reg->off);
> @@ -804,9 +803,8 @@ bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
>         return true;
>  }
>
> -bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> -                            struct bpf_reg_state *reg,
> -                            enum bpf_arg_type arg_type)
> +static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +                                   enum bpf_arg_type arg_type)
>  {
>         struct bpf_func_state *state = func(env, reg);
>         enum bpf_dynptr_type dynptr_type;
> @@ -5694,6 +5692,66 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
>         return 0;
>  }
>
> +int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> +                       enum bpf_arg_type arg_type,
> +                       struct bpf_call_arg_meta *meta)
> +{
> +       struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> +       int argno = regno - 1;

I think we can just get rid of argno here and replace every instance
of argno in this function with regno

> +
> +       /* We only need to check for initialized / uninitialized helper
> +        * dynptr args if the dynptr is not PTR_TO_DYNPTR, as the
> +        * assumption is that if it is, that a helper function
> +        * initialized the dynptr on behalf of the BPF program.
> +        */
> +       if (base_type(reg->type) == PTR_TO_DYNPTR)
> +               return 0;
> +       if (arg_type & MEM_UNINIT) {
> +               if (!is_dynptr_reg_valid_uninit(env, reg)) {
> +                       verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> +                       return -EINVAL;
> +               }
> +
> +               /* We only support one dynptr being uninitialized at the moment,
> +                * which is sufficient for the helper functions we have right now.
> +                */
> +               if (meta->uninit_dynptr_regno) {
> +                       verbose(env, "verifier internal error: multiple uninitialized dynptr args\n");
> +                       return -EFAULT;
> +               }
> +
> +               meta->uninit_dynptr_regno = regno;
> +       } else {
> +               if (!is_dynptr_reg_valid_init(env, reg)) {
> +                       verbose(env,
> +                               "Expected an initialized dynptr as arg #%d\n",
> +                               argno + 1);
> +                       return -EINVAL;
> +               }
> +
> +               if (!is_dynptr_type_expected(env, reg, arg_type)) {
> +                       const char *err_extra = "";
> +
> +                       switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> +                       case DYNPTR_TYPE_LOCAL:
> +                               err_extra = "local";
> +                               break;
> +                       case DYNPTR_TYPE_RINGBUF:
> +                               err_extra = "ringbuf";
> +                               break;
> +                       default:
> +                               err_extra = "<unknown>";
> +                               break;
> +                       }
> +                       verbose(env,
> +                               "Expected a dynptr of type %s as arg #%d\n",
> +                               err_extra, argno + 1);
> +                       return -EINVAL;
> +               }
> +       }
> +       return 0;
> +}
> +
>  static bool arg_type_is_mem_size(enum bpf_arg_type type)
>  {
>         return type == ARG_CONST_SIZE ||
> @@ -6197,52 +6255,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                 err = check_mem_size_reg(env, reg, regno, true, meta);
>                 break;
>         case ARG_PTR_TO_DYNPTR:
> -               /* We only need to check for initialized / uninitialized helper
> -                * dynptr args if the dynptr is not PTR_TO_DYNPTR, as the
> -                * assumption is that if it is, that a helper function
> -                * initialized the dynptr on behalf of the BPF program.
> -                */
> -               if (base_type(reg->type) == PTR_TO_DYNPTR)
> -                       break;
> -               if (arg_type & MEM_UNINIT) {
> -                       if (!is_dynptr_reg_valid_uninit(env, reg)) {
> -                               verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> -                               return -EINVAL;
> -                       }
> -
> -                       /* We only support one dynptr being uninitialized at the moment,
> -                        * which is sufficient for the helper functions we have right now.
> -                        */
> -                       if (meta->uninit_dynptr_regno) {
> -                               verbose(env, "verifier internal error: multiple uninitialized dynptr args\n");
> -                               return -EFAULT;
> -                       }
> -
> -                       meta->uninit_dynptr_regno = regno;
> -               } else if (!is_dynptr_reg_valid_init(env, reg)) {
> -                       verbose(env,
> -                               "Expected an initialized dynptr as arg #%d\n",
> -                               arg + 1);
> -                       return -EINVAL;
> -               } else if (!is_dynptr_type_expected(env, reg, arg_type)) {
> -                       const char *err_extra = "";
> -
> -                       switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> -                       case DYNPTR_TYPE_LOCAL:
> -                               err_extra = "local";
> -                               break;
> -                       case DYNPTR_TYPE_RINGBUF:
> -                               err_extra = "ringbuf";
> -                               break;
> -                       default:
> -                               err_extra = "<unknown>";
> -                               break;
> -                       }
> -                       verbose(env,
> -                               "Expected a dynptr of type %s as arg #%d\n",
> -                               err_extra, arg + 1);
> -                       return -EINVAL;
> -               }
> +               if (process_dynptr_func(env, regno, arg_type, meta))
> +                       return -EACCES;

Should this return -EACCES or propagate the error from process_dynptr_func?

>                 break;
>         case ARG_CONST_ALLOC_SIZE_OR_ZERO:
>                 if (!tnum_is_const(reg->var_off)) {
> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> index c210657d4d0a..fc562e863e79 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> @@ -18,10 +18,7 @@ static struct {
>         const char *expected_verifier_err_msg;
>         int expected_runtime_err;
>  } kfunc_dynptr_tests[] = {
> -       {"dynptr_type_not_supp",
> -        "arg#0 pointer type STRUCT bpf_dynptr_kern points to unsupported dynamic pointer type", 0},
> -       {"not_valid_dynptr",
> -        "arg#0 pointer type STRUCT bpf_dynptr_kern must be valid and initialized", 0},
> +       {"not_valid_dynptr", "Expected an initialized dynptr as arg #1", 0},
>         {"not_ptr_to_stack", "arg#0 pointer type STRUCT bpf_dynptr_kern not to stack", 0},
>         {"dynptr_data_null", NULL, -EBADMSG},
>  };
> diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> index ce39d096bba3..f4a8250329b2 100644
> --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> @@ -32,18 +32,6 @@ int err, pid;
>
>  char _license[] SEC("license") = "GPL";
>
> -SEC("?lsm.s/bpf")
> -int BPF_PROG(dynptr_type_not_supp, int cmd, union bpf_attr *attr,
> -            unsigned int size)
> -{
> -       char write_data[64] = "hello there, world!!";
> -       struct bpf_dynptr ptr;
> -
> -       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(write_data), 0, &ptr);
> -
> -       return bpf_verify_pkcs7_signature(&ptr, &ptr, NULL);
> -}
> -
>  SEC("?lsm.s/bpf")
>  int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size)
>  {
> --
> 2.38.1
>
