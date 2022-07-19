Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D56657A861
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 22:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbiGSUj2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 16:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbiGSUjX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 16:39:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314C656BA9
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 13:39:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id z23so29425854eju.8
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 13:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dP5oNISSMt8hruZtocUsEHMimawQBICiTWQcMufe++c=;
        b=CsafMecZoFJQCIwy32qhsVbSyENEVo4/BjmlejNXjwgCr9aBDDUy6bcQW/bfI4OHTD
         NFGtCKL+b2vw0ZAgZPiamqVzvZPHKb8G1Vf++8gJ3w47h0wsH6En1VPKvLSilPs0Ut9E
         KKFLj/UrvgPc6uqvaQwud4/ws76wDVyKR/Ts6ZUGIGHSX4Hq/6hqxJl4jegzrc3pKz/I
         uD+N+2FsiFvj4TH7qByVrClunBKRSUnFs1jV+idCmvh9e8RWppyAbp/PTDFPSH0eFE2N
         h6REsRJpaaGfZWaVuzgcjk8KmErX5evoWk4yIT1rY5JcNUJ1vwGJAkAIqO/XbF4TC84f
         B2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dP5oNISSMt8hruZtocUsEHMimawQBICiTWQcMufe++c=;
        b=F7MB0iQHLfYetL/tkhejjxFACEOKhZ0ZMDlLLRYQa15Q80ZTr3TigK2jG85gzusIh8
         HbW+MiVKmVi4w4QpCoR9FNSGy8pQGucMVfJFzXBEeUNSVFegYwsElH0V6AFn8msqFfy9
         wShYTafbNpZvhsHV1rG4ML6siJjZh5prwiuVqG3YFOTKYfmtUlY06GWv9bFPYI4NrrPN
         X9DJeTB4lXhyQ0EiVsxf5V4j5hChaZd+z9R3ei/OSKbmNA0XAVES9iDuUQIC/ZUKPGre
         AvB7CAnlM0yJlHcNW/TJCseyjVGmlOhvxnwTccZ2IJTkvae3vbdUEkN4EQTXhzD3FFeq
         N+7g==
X-Gm-Message-State: AJIora/+6VlVdmwxDgMthPWZuB/AY+tUYfCLady8BQoIVf7tbEpitotc
        NS/1Z/GLqK3LJh2Wyf4wpGuHyWqAg4jPeyne62o=
X-Google-Smtp-Source: AGRyM1uMsXkyhBSMe2XebsnqbhubQdomlY1GHgYh4DRlkoT0ERyhUimKcMm9rPyZR5Fc8oYaxj/AAWIj9fRSVFwHmv8=
X-Received: by 2002:a17:907:608f:b0:72b:7db9:4dc6 with SMTP id
 ht15-20020a170907608f00b0072b7db94dc6mr31513036ejc.463.1658263160576; Tue, 19
 Jul 2022 13:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220719185853.1650806-1-davemarchevsky@fb.com>
In-Reply-To: <20220719185853.1650806-1-davemarchevsky@fb.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 19 Jul 2022 13:39:09 -0700
Message-ID: <CAJnrk1Zzdng-XLg2cvA5wjGbidKt9=uDCwo0uSBB=nq74AyfrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Cleanup check_refcount_ok
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

On Tue, Jul 19, 2022 at 11:59 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
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
> ---
> No extant helpers fail the helper_multiple_ref_obj_use check (as
> expected). I validated this by adding BPF_FUNC_dynptr_data to
> is_acquire_function check and observing that dynptr selftests failed
> with expected error, then doing the same for is_ptr_cast_function.
>
>  kernel/bpf/verifier.c | 72 +++++++++++++++++--------------------------
>  1 file changed, 28 insertions(+), 44 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c59c3df0fea6..b3e057a9384d 100644
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
nit: for the function name, bpf_dynptr_data doesn't acquire a
reference state, it tracks the dynptr's existing reference state so
that when the dynptr is invalidated, the data slice is invalidated as
well. This is my fault for the misleading comment about "finding the
id of the dynptr we're acquiring a reference to". Maybe something like
"is_dynptr_ref_tracking" would work better as a name?
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
> +               return -EINVAL;
nit: I think -EFAULT here makes more sense because this is an error in
the internal helper function definition
> +       }
> +
>         if (is_ptr_cast_function(func_id)) {
>                 /* For release_reference() */
>                 regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
> @@ -7469,7 +7453,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 regs[BPF_REG_0].id = id;
>                 /* For release_reference() */
>                 regs[BPF_REG_0].ref_obj_id = id;
> -       } else if (func_id == BPF_FUNC_dynptr_data) {
> +       } else if (is_dynptr_acquire_function(func_id)) {
>                 int dynptr_id = 0, i;
>
>                 /* Find the id of the dynptr we're acquiring a reference to */
Do you mind modifying this to "Find the id of the dynptr we're
tracking the reference of"?
> --
> 2.30.2
>
