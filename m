Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E090C4563EC
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 21:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhKRUSH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 15:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhKRUSG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 15:18:06 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C34EC061574
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 12:15:06 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id j77so780530ybg.6
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 12:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MI8AehGrVQH5jcKA4GQdrzRDlpG92nDDochuxjNeOeE=;
        b=db20ykvNw0t089fJY+8hcih7CffiPqlKDZ+B9Fbi9c52C4v6M0s+wLBeOG0Xl0wRaD
         q8sZGSpHixpvsNwvGFTMbvQ6Hw9KajaUxedTn8u2qA+FDJ5KyQqfuok+p9GA5SMCc4js
         Ck6yrM1OaW9dGklo+N/9yy9oAaB3X7yvTd8FbOZJS8ACVZiXreJ9IWs80EoEPu5RKZgg
         yiHJFkV64TtebG5p6HwEjG04dBxOMC2nawlKq5170spn5gqu12YiJNJ2cd+F+p6K4Umm
         YHSY1c19OHZ6xhPI8pQhkQsgSf0yxKYx1H+RNk3iQWLpzqsVBjZSpbpbEPN1znuvpef0
         gKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MI8AehGrVQH5jcKA4GQdrzRDlpG92nDDochuxjNeOeE=;
        b=oehniYlXiHpk04F+kx80FKnvIVACoJbjeZcAJ9OFyVvDRrBINKP4Bv9q4wbGpQoH2c
         72kRCQArT3WwhocQ5CcV4+DoHDunXNLvjRIqP64EqEvZ1i7HtMmoPwsjXnNa5TKPjITO
         hRzIWX9/yehZsc6K0VSbUVcSbkXADPOUNRKXZHLeY1cBgnojrVxdsRtbCGTGnSkwGTwD
         iMR+h8o8ZFArzSqC/IrdB6TZS6R36gdfbTqrp8eCoZCHmV3xj68j0XV7oIpgaA4yhAaO
         ZTvpPP7ti2QqQ9GVYlYFXCcdwKJfY7PNHlNQfASIlILLrpFIMWXuu1yQbFBsa0+anuog
         0XgA==
X-Gm-Message-State: AOAM530F3tIxNgs6wpXKIDtfyEud8WpEn1L1BjP4Y3OwOBMw+0zAMmAt
        dZOPMaPMk+LbKtqtm5NRgSSFpB3vqvJG5a2p3Ok=
X-Google-Smtp-Source: ABdhPJxZuCUdqzq5BDUdHpJQhuPrlOUB+RwIh0MwzDhDNL2OSs5gd+e+Tj4/RFCQ6rwQ182lR9qnPc3qAetoeSFOBEs=
X-Received: by 2002:a25:d187:: with SMTP id i129mr30103264ybg.2.1637266505587;
 Thu, 18 Nov 2021 12:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20211118010404.2415864-1-joannekoong@fb.com> <20211118010404.2415864-2-joannekoong@fb.com>
In-Reply-To: <20211118010404.2415864-2-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Nov 2021 12:14:54 -0800
Message-ID: <CAEf4BzZV-n9uSM1kDONLfn0jLz50OkjXqy=avZ2oE4dhxVm9gQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add bpf_for_each helper
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 17, 2021 at 5:06 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patch adds the kernel-side and API changes for a new helper
> function, bpf_for_each:
>
> long bpf_for_each(u32 nr_interations, void *callback_fn,
> void *callback_ctx, u64 flags);

foreach in other languages are usually used when you are iterating
elements of some data structure or stream of data, so the naming feels
slightly off. bpf_loop() for bpf_for_range() seems to be more directly
pointing to what's going on. My 2 cents, it's subjective, of course.


>
> bpf_for_each invokes the "callback_fn" nr_iterations number of times
> or until the callback_fn returns 1.

As Toke mentioned, we don't really check 1. Enforcing it on verifier
side is just going to cause more troubles for users and doesn't seem
important. I can see two ways to define the semantics, with error
propagation and without.

For error propagation, we can define:
  - >0, break and return number of iterations performed in total;
  - 0, continue to next iteration, if no more iterations, return
number of iterations performed;
  - <0, break and return that error value (but no way to know at which
iteration this happened, except through custom context);

Or we can make it simpler and just:
  - 0, continue;
  - != 0, break;
  - always return number of iterations performed.


No strong preferences on my side, I see benefits to both ways.

>
> A few things to please note:
> ~ The "u64 flags" parameter is currently unused but is included in
> case a future use case for it arises.
> ~ In the kernel-side implementation of bpf_for_each (kernel/bpf/bpf_iter.c),
> bpf_callback_t is used as the callback function cast.
> ~ A program can have nested bpf_for_each calls but the program must
> still adhere to the verifier constraint of its stack depth (the stack depth
> cannot exceed MAX_BPF_STACK))
> ~ The next patch will include the tests and benchmark
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       | 23 +++++++++++++++++++++++
>  kernel/bpf/bpf_iter.c          | 32 ++++++++++++++++++++++++++++++++
>  kernel/bpf/helpers.c           |  2 ++
>  kernel/bpf/verifier.c          | 28 ++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 23 +++++++++++++++++++++++
>  6 files changed, 109 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6deebf8bf78f..d9b69a896c91 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2107,6 +2107,7 @@ extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
>  extern const struct bpf_func_proto bpf_task_storage_get_proto;
>  extern const struct bpf_func_proto bpf_task_storage_delete_proto;
>  extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
> +extern const struct bpf_func_proto bpf_for_each_proto;
>  extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
>  extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
>  extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index bd0c9f0487f6..ea5098920ed2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4750,6 +4750,28 @@ union bpf_attr {
>   *             The number of traversed map elements for success, **-EINVAL** for
>   *             invalid **flags**.
>   *
> + * long bpf_for_each(u32 nr_iterations, void *callback_fn, void *callback_ctx, u64 flags)
> + *     Description
> + *             For **nr_iterations**, call **callback_fn** function with
> + *             **callback_ctx** as the context parameter.
> + *             The **callback_fn** should be a static function and
> + *             the **callback_ctx** should be a pointer to the stack.
> + *             The **flags** is used to control certain aspects of the helper.
> + *             Currently, the **flags** must be 0.
> + *
> + *             long (\*callback_fn)(u32 index, void \*ctx);
> + *
> + *             where **index** is the current index in the iteration. The index
> + *             is zero-indexed.
> + *
> + *             If **callback_fn** returns 0, the helper will continue to the next
> + *             iteration. If return value is 1, the helper will skip the rest of
> + *             the iterations and return. Other return values are not used now.
> + *
> + *     Return
> + *             The number of iterations performed, **-EINVAL** for invalid **flags**
> + *             or a null **callback_fn**.
> + *
>   * long bpf_snprintf(char *str, u32 str_size, const char *fmt, u64 *data, u32 data_len)
>   *     Description
>   *             Outputs a string into the **str** buffer of size **str_size**
> @@ -5105,6 +5127,7 @@ union bpf_attr {
>         FN(sock_from_file),             \
>         FN(check_mtu),                  \
>         FN(for_each_map_elem),          \
> +       FN(for_each),                   \

you can't change the order of the function definitions, this breaks
ABI, please add it at the end

>         FN(snprintf),                   \
>         FN(sys_bpf),                    \
>         FN(btf_find_by_name_kind),      \
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index b2ee45064e06..cb742c50898a 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -714,3 +714,35 @@ const struct bpf_func_proto bpf_for_each_map_elem_proto = {
>         .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
>         .arg4_type      = ARG_ANYTHING,
>  };
> +
> +BPF_CALL_4(bpf_for_each, u32, nr_iterations, void *, callback_fn, void *, callback_ctx,
> +          u64, flags)
> +{
> +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
> +       u64 err;
> +       u32 i;
> +

I wonder if we should have some high but reasonable number of
iteration limits. It would be too easy for users to cause some
overflow and not notice it, and then pass 4bln iterations and freeze
the kernel. I think limiting to something like 1mln or 8mln might be
ok. Thoughts?


> +       if (flags)
> +               return -EINVAL;
> +
> +       for (i = 0; i < nr_iterations; i++) {
> +               err = callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0);
> +               /* return value: 0 - continue, 1 - stop and return */
> +               if (err) {

nit: not really error (at least in the current semantics), "ret" would
be more appropriate

> +                       i++;
> +                       break;
> +               }
> +       }
> +
> +       return i;
> +}
> +

[...]

>  static int set_timer_callback_state(struct bpf_verifier_env *env,
>                                     struct bpf_func_state *caller,
>                                     struct bpf_func_state *callee,
> @@ -6482,6 +6503,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                         return -EINVAL;
>         }
>
> +       if (func_id == BPF_FUNC_for_each) {
> +               err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> +                                       set_for_each_callback_state);
> +               if (err < 0)
> +                       return -EINVAL;
> +       }
> +

we should convert these ifs (they are not even if elses!) into a
switch. And move if (err < 0) return err; outside. It will only keep
growing.

>         if (func_id == BPF_FUNC_timer_set_callback) {
>                 err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
>                                         set_timer_callback_state);

[...]
