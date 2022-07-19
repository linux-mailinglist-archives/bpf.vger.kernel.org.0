Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A677257A9DA
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 00:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiGSWcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 18:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiGSWcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 18:32:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50C44F68F
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 15:32:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id oy13so29788452ejb.1
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 15:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWjhM8lMVkY4AOyb/Rxc7hAqnlouK+BwqQhqy2XA2Nc=;
        b=WhSSPG4LfKyG3t6pnChXfA9kaIHGH0bDX+87POpYXSQpkydy8ZJfIVLYmp9b5ibgCE
         GwqfRCfJk7yC5oKLgkNQM37ZGDgZ/F8gJnF5N1vkPOAwyiAc6iYYNPlnVO4Aj+Qvo03i
         e5gEf+KMnov9dVkwlYEJYWNU42so/YvBCfkSlwJDXqPh2/ihLCjJCn33OM5hJGsRHAw8
         N/qfeXthv58cRO6rsXpVflM3Ks7xO3u8WNGBkoDEipokBhrNzJhJNi2rLkty+FHk8lXT
         eSQT5WaYVyCMokxXXkVjCbPW6Hy1+kItTci3VsyaRsBHALgyeJAiWox6gxQYXJbYean2
         Z29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWjhM8lMVkY4AOyb/Rxc7hAqnlouK+BwqQhqy2XA2Nc=;
        b=3RbxqxS2CbphVzvch+41szoR9PqV7aVJ61yPKF6SgtelTcVOF4P09aDDGz9hJ4tdCc
         QSFz2r4dQkrvbNtJukhLq5z3Cj2GAst6REIQ4yFb0L/ifWz12N4bl1egmpeX2EJjdmP7
         rxsqb30Gxhdo+VSRoF44Q82aTHHNsig4OrUVxKk0XJfPOxRpuRr/fYzEudv/TMhrx7X5
         BKS4yJF7/nKsetiqX95Rbt5xbz58QeUjs5vFLdFt8OFi3TWpgRMAcW7EySyp9u27I6zV
         7hObu9fH72WL3zlGJd23zKK/0puM3iYHm7qRmMje/eA8tbmu/I1nev2zPIjYtVdmooHH
         Q8vg==
X-Gm-Message-State: AJIora+mByzYjrODNiAfZCsBiubp1nzitKH2UM5o/hk7FImsRaJB2ALp
        nbxV1MpXmGXi17fKAQVINCcMmFPSR9nGtvF842s=
X-Google-Smtp-Source: AGRyM1tcXU9ymmYjq+1rwrlLqDHxDvgQlqHCaYLnuWefpW9XY745++6SOIsDqRfgw+jrMsvtYY0qHPsB6dV5DMN4738=
X-Received: by 2002:a17:907:a40f:b0:72b:64ee:5b2f with SMTP id
 sg15-20020a170907a40f00b0072b64ee5b2fmr34168567ejc.268.1658269923122; Tue, 19
 Jul 2022 15:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220719215536.2787530-1-davemarchevsky@fb.com>
In-Reply-To: <20220719215536.2787530-1-davemarchevsky@fb.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 19 Jul 2022 15:31:51 -0700
Message-ID: <CAJnrk1ZWZ3MAG5S1A5xwYspGcpMkL5SW-LpS_4j5cr5Ze+Fa7A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Cleanup check_refcount_ok
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>
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

On Tue, Jul 19, 2022 at 2:55 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> Discussion around a recently-submitted patch provided historical
> context for check_refcount_ok [0]. Specifically, the function and its
> helpers - may_be_acquire_function and arg_type_may_be_refcounted -
> predate the OBJ_RELEASE type flag and the addition of many more helpers
> with acquire/release semantics.
>
> The purpose of check_refcount_ok is to ensure:
>   1) Helper doesn't have multiple uses of return reg's ref_obj_id
>   2) Helper with release semantics only has one arg needing to be
>   released, since that's tracked using meta->ref_obj_id
>
> With current verifier, it's safe to remove check_refcount_ok and its
> helpers. Since addition of OBJ_RELEASE type flag, case 2) has been
> handled by the arg_type_is_release check in check_func_arg. To ensure
> case 1) won't result in verifier silently prioritizing one use of
> ref_obj_id, this patch adds a helper_multiple_ref_obj_use check which
> fails loudly if a helper passes > 1 test for use of ref_obj_id.
>
>   [0]: lore.kernel.org/bpf/20220713234529.4154673-1-davemarchevsky@fb.com
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Thanks for cleaning up this logic, Dave!

Acked-by: Joanne Koong <joannelkoong@gmail.com>
> ---
> No extant helpers fail the helper_multiple_ref_obj_use check (as
> expected). I validated this by adding BPF_FUNC_dynptr_data to
> is_acquire_function check and observing that dynptr selftests failed
> with expected error, then doing the same for is_ptr_cast_function.
>
> v1 -> v2: lore.kernel.org/bpf/20220719185853.1650806-1-davemarchevsky@fb.com
>   * EFAULT instead of EINVAL, minor edit to dynptr acquire comment (Joanne)
>   * Add Martin Acked-by
>
>  kernel/bpf/verifier.c | 74 +++++++++++++++++--------------------------
>  1 file changed, 29 insertions(+), 45 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c59c3df0fea6..0bc35fbd78d9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -467,25 +467,11 @@ static bool type_is_rdonly_mem(u32 type)
>         return type & MEM_RDONLY;
>  }
>
> -static bool arg_type_may_be_refcounted(enum bpf_arg_type type)
> -{
> -       return type == ARG_PTR_TO_SOCK_COMMON;
> -}
> -
>  static bool type_may_be_null(u32 type)
>  {
>         return type & PTR_MAYBE_NULL;
>  }
>
> -static bool may_be_acquire_function(enum bpf_func_id func_id)
> -{
> -       return func_id == BPF_FUNC_sk_lookup_tcp ||
> -               func_id == BPF_FUNC_sk_lookup_udp ||
> -               func_id == BPF_FUNC_skc_lookup_tcp ||
> -               func_id == BPF_FUNC_map_lookup_elem ||
> -               func_id == BPF_FUNC_ringbuf_reserve;
> -}
> -
>  static bool is_acquire_function(enum bpf_func_id func_id,
>                                 const struct bpf_map *map)
>  {
> @@ -518,6 +504,26 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
>                 func_id == BPF_FUNC_skc_to_tcp_request_sock;
>  }
>
> +static bool is_dynptr_acquire_function(enum bpf_func_id func_id)
nit: I think this should be renamed to something like
"is_dynptr_ref_tracking" because bpf_dynptr_data doesn't acquire a
reference state. Using "acquire" in the name might be a bit confusing
here.
> +{
> +       return func_id == BPF_FUNC_dynptr_data;
> +}
> +
> +static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
> +                                       const struct bpf_map *map)
> +{
> +       int ref_obj_uses = 0;
> +
> +       if (is_ptr_cast_function(func_id))
> +               ref_obj_uses++;
> +       if (is_acquire_function(func_id, map))
> +               ref_obj_uses++;
> +       if (is_dynptr_acquire_function(func_id))
> +               ref_obj_uses++;
> +
> +       return ref_obj_uses > 1;
> +}
> +
>  static bool is_cmpxchg_insn(const struct bpf_insn *insn)
>  {
>         return BPF_CLASS(insn->code) == BPF_STX &&
> @@ -6453,33 +6459,6 @@ static bool check_arg_pair_ok(const struct bpf_func_proto *fn)
>         return true;
>  }
>
> -static bool check_refcount_ok(const struct bpf_func_proto *fn, int func_id)
> -{
> -       int count = 0;
> -
> -       if (arg_type_may_be_refcounted(fn->arg1_type))
> -               count++;
> -       if (arg_type_may_be_refcounted(fn->arg2_type))
> -               count++;
> -       if (arg_type_may_be_refcounted(fn->arg3_type))
> -               count++;
> -       if (arg_type_may_be_refcounted(fn->arg4_type))
> -               count++;
> -       if (arg_type_may_be_refcounted(fn->arg5_type))
> -               count++;
> -
> -       /* A reference acquiring function cannot acquire
> -        * another refcounted ptr.
> -        */
> -       if (may_be_acquire_function(func_id) && count)
> -               return false;
> -
> -       /* We only support one arg being unreferenced at the moment,
> -        * which is sufficient for the helper functions we have right now.
> -        */
> -       return count <= 1;
> -}
> -
>  static bool check_btf_id_ok(const struct bpf_func_proto *fn)
>  {
>         int i;
> @@ -6503,8 +6482,7 @@ static int check_func_proto(const struct bpf_func_proto *fn, int func_id,
>  {
>         return check_raw_mode_ok(fn) &&
>                check_arg_pair_ok(fn) &&
> -              check_btf_id_ok(fn) &&
> -              check_refcount_ok(fn, func_id) ? 0 : -EINVAL;
> +              check_btf_id_ok(fn) ? 0 : -EINVAL;
>  }
>
>  /* Packet data might have moved, any old PTR_TO_PACKET[_META,_END]
> @@ -7457,6 +7435,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>         if (type_may_be_null(regs[BPF_REG_0].type))
>                 regs[BPF_REG_0].id = ++env->id_gen;
>
> +       if (helper_multiple_ref_obj_use(func_id, meta.map_ptr)) {
> +               verbose(env, "verifier internal error: func %s#%d sets ref_obj_id more than once\n",
> +                       func_id_name(func_id), func_id);
> +               return -EFAULT;
> +       }
> +
>         if (is_ptr_cast_function(func_id)) {
>                 /* For release_reference() */
>                 regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
> @@ -7469,10 +7453,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 regs[BPF_REG_0].id = id;
>                 /* For release_reference() */
>                 regs[BPF_REG_0].ref_obj_id = id;
> -       } else if (func_id == BPF_FUNC_dynptr_data) {
> +       } else if (is_dynptr_acquire_function(func_id)) {
>                 int dynptr_id = 0, i;
>
> -               /* Find the id of the dynptr we're acquiring a reference to */
> +               /* Find the id of the dynptr we're tracking the reference of */
>                 for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
>                         if (arg_type_is_dynptr(fn->arg_type[i])) {
>                                 if (dynptr_id) {
> --
> 2.30.2
>
