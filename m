Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76E94E3620
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 02:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbiCVBtW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 21:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbiCVBtW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 21:49:22 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149023981E
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 18:47:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q5so22154211ljb.11
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 18:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Xl2erIvKhM99kadSqHfho9UljKJYpvV6ZuxE52JHBE=;
        b=N9AFB8t+XuWl9wYn/QpVQ089GyMGh6gmoS0581/oyllTDWDwTMNgDeydFBi7oaXB7A
         UWiuPkyeGbRnVGt9SpDvdPyWbIrkVnAnLtor/nwvjUg6gj2RyeUbdL+oDgDgam69tbjD
         zASah5OLLpOoV65tM0sUdpJvovn/cQh8U3QUp6B5Bmo98fcW9l7m86FsLg1Q2lS96CQ4
         8UiQ24hjI5qgXjzoME6neEbLjANXKHU84m0iD7rpWp1W88aOPHJi7tWRDFlSxvGnMj9Q
         rufRJTl3g6+Yuf08ajJPuZrF5N2z3GQbxhOCrv6AytUtx+Gm5pf1HNt2iFHW4+MvDqst
         PMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Xl2erIvKhM99kadSqHfho9UljKJYpvV6ZuxE52JHBE=;
        b=xeU3BgHX8UmsnkAhlWi0Y4zGEbqTfL5igcfb9io8ikdplx5Ip31Nv8IVy5sH3QFQOv
         p/1qvJ7mUqeor9xEcmOd9us2j3vypNA+NEjqJK6CU/8FxfNiAWwjr6g2fqUKl8ZcNjm3
         iij1LEjDpq4VGeL2lSkHgk79G4RAe9jzX2m70dwLZfmrcJZ8BKHEANgOs4rd/Wa7lrIK
         oCwHYnjC/UFo1+UQLHxgVftRCg6CSjJ0w0gGhjdz2OpaF4TQifJw+WF/K7t6ICRlEEf9
         lJ8Ly1tjo3N8xOQm0hvru8orKJmvHAkrwDmd4fr2c+FrlPc8ncdUwkMxXkk+DuNFKjO1
         2bVQ==
X-Gm-Message-State: AOAM533S+prEVNDBN1G0iS7YpgJDbBnOdLaUmvYuTLHQ/gXo/8PTAfTM
        R5EjEOdM1c8p+sKAb9lpxaZ2gBYsBo9KMzK7NZo=
X-Google-Smtp-Source: ABdhPJwqfzOSkdcppJvyghHiDfYNBJPsQE/5DgHznRJlm9gyT3iFakj8MIrTaBLAB7ChlU9csvVeAXkHkSY9uKaS1+g=
X-Received: by 2002:a2e:b946:0:b0:244:beb1:72b2 with SMTP id
 6-20020a2eb946000000b00244beb172b2mr17322195ljs.240.1647913671291; Mon, 21
 Mar 2022 18:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220320155510.671497-1-memxor@gmail.com> <20220320155510.671497-5-memxor@gmail.com>
In-Reply-To: <20220320155510.671497-5-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 21 Mar 2022 18:47:40 -0700
Message-ID: <CAJnrk1amRmvAWSqDzeC=sOVL7_iTqbC8z0B7oXXSni9xqsK_Ww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/13] bpf: Indicate argument that will be
 released in bpf_func_proto
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
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

On Sun, Mar 20, 2022 at 6:34 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Add a few fields for each arg (argN_release) that when set to true,
> tells verifier that for a release function, that argument's register
> will be the one for which meta.ref_obj_id will be set, and which will
> then be released using release_reference. To capture the regno,
> introduce a release_regno field in bpf_call_arg_meta.
>
> This would be required in the next patch, where we may either pass NULL
> or a refcounted pointer as an argument to the release function
> bpf_kptr_xchg. Just releasing only when meta.ref_obj_id is set is not
> enough, as there is a case where the type of argument needed matches,
> but the ref_obj_id is set to 0. Hence, we must enforce that whenever
> meta.ref_obj_id is zero, the register that is to be released can only
> be NULL for a release function.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h   | 10 ++++++++++
>  kernel/bpf/ringbuf.c  |  2 ++
>  kernel/bpf/verifier.c | 39 +++++++++++++++++++++++++++++++++------
>  net/core/filter.c     |  1 +
>  4 files changed, 46 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f35920d279dd..48ddde854d67 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -487,6 +487,16 @@ struct bpf_func_proto {
>                 };
>                 u32 *arg_btf_id[5];
>         };
> +       union {
> +               struct {
> +                       bool arg1_release;
> +                       bool arg2_release;
> +                       bool arg3_release;
> +                       bool arg4_release;
> +                       bool arg5_release;
> +               };
> +               bool arg_release[5];
> +       };

Instead of having the new fields "argx_release" for each arg, what are
your thoughts on using PTR_RELEASE as an "enum bpf_type_flag" to the
existing "argx_type" field? For example, instead of

     .arg1_type      = ARG_PTR_TO_ALLOC_MEM,
     .arg1_release   = true,

could we do something like

     .arg1_type      = ARG_PTR_TO_ALLOC_MEM | PTR_RELEASE

In the verifier, we could determine whether an argument register
releases a reference by checking whether this PTR_RELEASE flag is set.

Would this be a little cleaner? Curious to hear your thoughts.


>         int *ret_btf_id; /* return value btf_id */
>         bool (*allowed)(const struct bpf_prog *prog);
>  };
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 710ba9de12ce..f40ce718630e 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -405,6 +405,7 @@ const struct bpf_func_proto bpf_ringbuf_submit_proto = {
>         .func           = bpf_ringbuf_submit,
>         .ret_type       = RET_VOID,
>         .arg1_type      = ARG_PTR_TO_ALLOC_MEM,
> +       .arg1_release   = true,
>         .arg2_type      = ARG_ANYTHING,
>  };
>
> @@ -418,6 +419,7 @@ const struct bpf_func_proto bpf_ringbuf_discard_proto = {
>         .func           = bpf_ringbuf_discard,
>         .ret_type       = RET_VOID,
>         .arg1_type      = ARG_PTR_TO_ALLOC_MEM,
> +       .arg1_release   = true,
>         .arg2_type      = ARG_ANYTHING,
>  };
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 744b7362e52e..b8cd34607215 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -245,6 +245,7 @@ struct bpf_call_arg_meta {
>         struct bpf_map *map_ptr;
>         bool raw_mode;
>         bool pkt_access;
> +       u8 release_regno;
>         int regno;
>         int access_size;
>         int mem_size;
> @@ -6101,12 +6102,31 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
>         return true;
>  }
>
> -static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
> +static bool check_release_regno(const struct bpf_func_proto *fn, int func_id,
> +                               struct bpf_call_arg_meta *meta)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(fn->arg_release); i++) {
> +               if (fn->arg_release[i]) {
> +                       if (!is_release_function(func_id))
> +                               return false;
> +                       if (meta->release_regno)
> +                               return false;
> +                       meta->release_regno = i + 1;
> +               }
> +       }
> +       return !is_release_function(func_id) || meta->release_regno;
> +}
> +
> +static int check_func_proto(const struct bpf_func_proto *fn, int func_id,
> +                           struct bpf_call_arg_meta *meta)
>  {
>         return check_raw_mode_ok(fn) &&
>                check_arg_pair_ok(fn) &&
>                check_btf_id_ok(fn) &&
> -              check_refcount_ok(fn, func_id) ? 0 : -EINVAL;
> +              check_refcount_ok(fn, func_id) &&
> +              check_release_regno(fn, func_id, meta) ? 0 : -EINVAL;
>  }
>
>  /* Packet data might have moved, any old PTR_TO_PACKET[_META,_END]
> @@ -6785,7 +6805,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>         memset(&meta, 0, sizeof(meta));
>         meta.pkt_access = fn->pkt_access;
>
> -       err = check_func_proto(fn, func_id);
> +       err = check_func_proto(fn, func_id, &meta);
>         if (err) {
>                 verbose(env, "kernel subsystem misconfigured func %s#%d\n",
>                         func_id_name(func_id), func_id);
> @@ -6818,8 +6838,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                         return err;
>         }
>
> +       regs = cur_regs(env);
> +
>         if (is_release_function(func_id)) {
> -               err = release_reference(env, meta.ref_obj_id);
> +               err = -EINVAL;
> +               if (meta.ref_obj_id)
> +                       err = release_reference(env, meta.ref_obj_id);
> +               /* meta.ref_obj_id can only be 0 if register that is meant to be
> +                * released is NULL, which must be > R0.
> +                */
> +               else if (meta.release_regno && register_is_null(&regs[meta.release_regno]))
> +                       err = 0;

If I'm understanding this correctly, in this patch we will call
check_release_regno on every function to determine if any / which of
the argument registers release a reference. Given that in the majority
of cases the function will not be a release function, what are your
thoughts on moving that check to be within the scope of this if
function? So if it is a release function, and meta.ref_obj_id is not
set, then we do the checking for which argument register is a release
register and whether that register is null. Curious to hear your
thoughts.


>                 if (err) {
>                         verbose(env, "func %s#%d reference has not been acquired before\n",
>                                 func_id_name(func_id), func_id);
> @@ -6827,8 +6856,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 }
>         }
>
> -       regs = cur_regs(env);
> -
>         switch (func_id) {
>         case BPF_FUNC_tail_call:
>                 err = check_reference_leak(env);
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 03655f2074ae..17eff4731b06 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6622,6 +6622,7 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
>         .gpl_only       = false,
>         .ret_type       = RET_INTEGER,
>         .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> +       .arg1_release   = true,
>  };
>
>  BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
> --
> 2.35.1
>
