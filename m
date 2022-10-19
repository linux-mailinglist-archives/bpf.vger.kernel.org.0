Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FD9605396
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 01:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiJSXBA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 19:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiJSXAr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 19:00:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944211CB530
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 16:00:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ot12so43485946ejb.1
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 16:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9cZH3ZlbIMUiXtC+f+/LkSdyn8XHQhJZaMnAhFDhqtM=;
        b=CWPSa65ckNw/z7QNCbpprpSCNw7kLS8Z8yMGHVaNg2oSHgJw1f+r+uU9RRyaoyUM3m
         isU/q3pE71FssttbbSuoZsTYr6Ok9Nb1CxHh6l5Ydk4uqU2eljMqqK54EMvUQl6iPZ41
         jjroIF3G5aC3dinwunLrl4GD8PMl7uCafm1aXKflUjFGgBVWXcxvqYbNt9Z63jHIJ65c
         x4O317GL3ak/irCX6WBxtg+981X1356Iv8s8aizDv/ZH4hG/FtwmoKa5xELb8uTgh7zL
         cX+8+t90HdjbjsXESC/uoOiyH+zYEQHsRgM624j/cEl0AdCu8JeQM0eueMcQEmt2F4Gc
         zTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cZH3ZlbIMUiXtC+f+/LkSdyn8XHQhJZaMnAhFDhqtM=;
        b=QmuHpw7N0vgUG9crHuR8DpoHss1P7hzJF9O/fgdC7AP8rldDubdsl/Ef+W1q+koEUr
         6hDtfQW0IVyZPddcpRy+pOzwsVnGKtFtCinOZminomp16OzylyhpKLO8FLa+raDdqtPL
         vGiTlgvj0+5+l2xWZbbSZ33g8xbUfxAlY9czyFruYsRxwSx0Wy7fe/Ga4YbyItKnbb2i
         gcKEhsvlNzvcRH6nXd5BM/V1Kq7kH3DZn4t2mZETvfnBDpwRyFa96APc5zKteKUX+mNd
         5EwTQjUS2fqJDPw0OsXHyZSyTBL3ac2F7kQc3DVvdg72IOkE1LCCeSkiX8PgLOP9CAS2
         9jpQ==
X-Gm-Message-State: ACrzQf3Xqz3K2ndemDDgIaep4nZbbqBBD58YPPGU+ERqDG5fQE7XrZtB
        oz9+MegX4hNg/9d4u0Fl2Zs7UsJpikLGQxOI4F0=
X-Google-Smtp-Source: AMsMyM48VeiYjGEjPxF1LSigPI+YIa6O4TFvdohiq+83i1xw8dgi6luoThdJ825fp71f+owigx59M5xoPScnwmZ/tb4=
X-Received: by 2002:a17:907:a43:b0:77b:ba98:d2f with SMTP id
 be3-20020a1709070a4300b0077bba980d2fmr8810389ejc.270.1666220409043; Wed, 19
 Oct 2022 16:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221018135920.726360-1-memxor@gmail.com> <20221018135920.726360-2-memxor@gmail.com>
In-Reply-To: <20221018135920.726360-2-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Wed, 19 Oct 2022 15:59:57 -0700
Message-ID: <CAJnrk1b+cBapTLcgLk41AQFMsSFOwB6HR4Nu-Wsi3=pzkN+nfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 01/13] bpf: Refactor ARG_PTR_TO_DYNPTR checks
 into process_dynptr_func
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
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

On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
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
> To this end, remove the dependency on bpf_call_arg_meta parameter by
> instead taking the uninit_dynptr_regno by pointer. This is only needed
> to be set to a valid pointer when arg_type has MEM_UNINIT.
>
> Then, reuse this consolidated function in kfunc dynptr handling too.
> Note that for kfuncs, the arg_type constraint of DYNPTR_TYPE_LOCAL has
> been lifted.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h                  |   8 +-
>  kernel/bpf/btf.c                              |  17 +--
>  kernel/bpf/verifier.c                         | 115 ++++++++++--------
>  .../bpf/prog_tests/kfunc_dynptr_param.c       |   5 +-
>  .../bpf/progs/test_kfunc_dynptr_param.c       |  12 --
>  5 files changed, 69 insertions(+), 88 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 9e1e6965f407..a33683e0618b 100644
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
> +int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> +                       enum bpf_arg_type arg_type, int argno,
> +                       u8 *uninit_dynptr_regno);
>
>  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
>  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index eba603cec2c5..1827d889e08a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6486,23 +6486,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>                                                 return -EINVAL;
>                                         }
>
> -                                       if (!is_dynptr_reg_valid_init(env, reg)) {
> -                                               bpf_log(log,
> -                                                       "arg#%d pointer type %s %s must be valid and initialized\n",
> -                                                       i, btf_type_str(ref_t),
> -                                                       ref_tname);
> +                                       if (process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR, i, NULL))

I think it'd be helpful to add a bpf_log statement here that this failed

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
> index 6f6d2d511c06..31c0c999448e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -782,8 +782,7 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>         return true;
>  }
>
> -bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> -                             struct bpf_reg_state *reg)
> +static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state = func(env, reg);
>         int spi = get_spi(reg->off);
> @@ -802,9 +801,8 @@ bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
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
> @@ -5573,6 +5571,65 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
>         return 0;
>  }
>
> +int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> +                       enum bpf_arg_type arg_type, int argno,

Do we need both regno and argno given that regno is always argno +
BPF_REG_1 and in this function we only use the argno param for "argno
+ 1"? I think we could just pass in regno.

> +                       u8 *uninit_dynptr_regno)

nit: this is personal preference, but I think it looks cleaner passing
"struct bpf_call_arg_meta *meta" here instead of "u8
*uninit_dynptr_regno".

> +{
> +       struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
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
> +               if (*uninit_dynptr_regno) {
> +                       verbose(env, "verifier internal error: multiple uninitialized dynptr args\n");
> +                       return -EFAULT;
> +               }
> +
> +               *uninit_dynptr_regno = regno;
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
> @@ -6086,52 +6143,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
> +               if (process_dynptr_func(env, regno, arg_type, arg, &meta->uninit_dynptr_regno))
> +                       return -EACCES;

process_dynptr_func could return -EFAULT so I think we should do "err
= process_dynptr_func(...)" here instead.

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
> 2.38.0
>
