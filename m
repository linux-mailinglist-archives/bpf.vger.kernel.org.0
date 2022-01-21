Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECFB49660B
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 20:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiAUTxw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 14:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiAUTxw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 14:53:52 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EF4C06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:53:52 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id d14so8551373ila.1
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOpk2o2HWT/29BVoVuo7VnK9EOUJ/Pjiu8mXfN0rIaY=;
        b=bFZjv063fSP8nPtHtwp9plf2uezXJpnMJNbPzYaRq+JhLgESkdS5LDQsZ8tV7YeFhR
         k7RlHqxLwhvSCz33HIH/FQxMmn2MoA2LJTTZX54q+nIV8S3QT+KXQMGzk9llxiZVdKbC
         bKbkCfVYv5H/gAfFIysRfyewKnpHNEvVaRwhA1s682HNJQGNApRQQf96wpC0/1NXgzXl
         LqqE0guaS3bp/1NcJh+8FL3AjYlGa4StNZ+StZDr4mpFg7CrEbDSDvEhZjxqKJJ3UoD6
         UfgpDmvHwW3F43Ct1GOVp8c7eyaIdCwm9693de6GrbI4YUSqRAosJoHGzLsDC09mk3GG
         FdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOpk2o2HWT/29BVoVuo7VnK9EOUJ/Pjiu8mXfN0rIaY=;
        b=Ec5EeRW/5+C53hTQSWm69Riajr7cboNwAwJI4817Q5Nu+TwyBJ8YQMtUA3oV72LofV
         6ax0774+nNdZ0b3/e5bfu+7aiR/XzU7bHKooImmcE2XqWLuRDwYm0JqPuwoJxXF5HzBw
         3Dp/h9PnhYhoehi/K4rJErSO73/y9M6X/3G7Uren0nlEIGhsXrK+t3EVTKAlLeqpdzZM
         fB0eSm0hl4wqmSItmyCgQIU3K3kFOYBryasuvo/MfRHMZL6Y6KidSoCfXKesypr0JPm4
         khtfMIrukZBoN9E2y9exMJiy/JZFnsUlI7j4GAzV6VaePOQ6zWjmmdSBNgqxHqdL/utY
         7oxg==
X-Gm-Message-State: AOAM53294S9/EOci6YzRr8gAK6fsIQ1QaR59+Ta3NfQHHhn1eciZO3G5
        PdxdoGai3YRrOTDzBz0U+BDjVPzrGmGb9ltI7g/MxG9d
X-Google-Smtp-Source: ABdhPJwUUSeqWNK/CDPYGo5/tPkDa6vVuxeAMfNsBS5ODax4a42iGp3IrJdtZtPkDsezdj8UTeFI85hKJtih6xmOWdc=
X-Received: by 2002:a05:6e02:1748:: with SMTP id y8mr3086695ill.305.1642794831641;
 Fri, 21 Jan 2022 11:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220121193047.3225019-1-kennyyu@fb.com>
 <20220121193047.3225019-2-kennyyu@fb.com>
In-Reply-To: <20220121193047.3225019-2-kennyyu@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Jan 2022 11:53:40 -0800
Message-ID: <CAEf4BzYfQ4EbSa+c1-G0x_Zh4L6=TbutmH3qndTmv7wb2dAf1w@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/3] bpf: Add bpf_copy_from_user_task() helper
To:     Kenny Yu <kennyyu@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Gabriele <phoenix1987@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 21, 2022 at 11:31 AM Kenny Yu <kennyyu@fb.com> wrote:
>
> This adds a helper for bpf programs to read the memory of other
> tasks. This also adds the ability for bpf iterator programs to
> be sleepable.
>
> This changes `bpf_iter_run_prog` to use the appropriate synchronization for
> sleepable bpf programs. With sleepable bpf iterator programs, we can no
> longer use `rcu_read_lock()` and must use `rcu_read_lock_trace()` instead
> to protect the bpf program.
>
> As an example use case at Meta, we are using a bpf task iterator program
> and this new helper to print C++ async stack traces for all threads of
> a given process.
>
> Signed-off-by: Kenny Yu <kennyyu@fb.com>
> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       | 10 ++++++++++
>  kernel/bpf/bpf_iter.c          | 20 ++++++++++++++-----
>  kernel/bpf/helpers.c           | 35 ++++++++++++++++++++++++++++++++++
>  kernel/trace/bpf_trace.c       |  2 ++
>  tools/include/uapi/linux/bpf.h | 10 ++++++++++
>  6 files changed, 73 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 80e3387ea3af..5917883e528b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2229,6 +2229,7 @@ extern const struct bpf_func_proto bpf_kallsyms_lookup_name_proto;
>  extern const struct bpf_func_proto bpf_find_vma_proto;
>  extern const struct bpf_func_proto bpf_loop_proto;
>  extern const struct bpf_func_proto bpf_strncmp_proto;
> +extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
>
>  const struct bpf_func_proto *tracing_prog_func_proto(
>    enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index fe2272defcd9..d82d9423874d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5049,6 +5049,15 @@ union bpf_attr {
>   *             This helper is currently supported by cgroup programs only.
>   *     Return
>   *             0 on success, or a negative error in case of failure.
> + *
> + * long bpf_copy_from_user_task(void *dst, u32 size, const void *user_ptr, struct task_struct *tsk, u64 flags)
> + *     Description
> + *             Read *size* bytes from user space address *user_ptr* in *tsk*'s
> + *             address space, and stores the data in *dst*. *flags* is not
> + *             used yet and is provided for future extensibility. This helper
> + *             can only be used by sleepable programs.

"On error dst buffer is zeroed out."? This is an explicit guarantee.

> + *     Return
> + *             0 on success, or a negative error in case of failure.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5239,6 +5248,7 @@ union bpf_attr {
>         FN(get_func_arg_cnt),           \
>         FN(get_retval),                 \
>         FN(set_retval),                 \
> +       FN(copy_from_user_task),        \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index b7aef5b3416d..110029ede71e 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -5,6 +5,7 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/filter.h>
>  #include <linux/bpf.h>
> +#include <linux/rcupdate_trace.h>
>
>  struct bpf_iter_target_info {
>         struct list_head list;
> @@ -684,11 +685,20 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
>  {
>         int ret;
>
> -       rcu_read_lock();
> -       migrate_disable();
> -       ret = bpf_prog_run(prog, ctx);
> -       migrate_enable();
> -       rcu_read_unlock();
> +       if (prog->aux->sleepable) {
> +               rcu_read_lock_trace();
> +               migrate_disable();
> +               might_fault();
> +               ret = bpf_prog_run(prog, ctx);
> +               migrate_enable();
> +               rcu_read_unlock_trace();
> +       } else {
> +               rcu_read_lock();
> +               migrate_disable();
> +               ret = bpf_prog_run(prog, ctx);
> +               migrate_enable();
> +               rcu_read_unlock();
> +       }
>

I think this sleepable bpf_iter change deserves its own patch. It has
nothing to do with bpf_copy_from_user_task() helper.

>         /* bpf program can only return 0 or 1:
>          *  0 : okay
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 01cfdf40c838..3bc37016fad0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -16,6 +16,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/proc_ns.h>
>  #include <linux/security.h>
> +#include <linux/btf_ids.h>
>
>  #include "../../lib/kstrtox.h"
>
> @@ -671,6 +672,40 @@ const struct bpf_func_proto bpf_copy_from_user_proto = {
>         .arg3_type      = ARG_ANYTHING,
>  };
>
> +BPF_CALL_5(bpf_copy_from_user_task, void *, dst, u32, size,
> +          const void __user *, user_ptr, struct task_struct *, tsk, u64, flags)
> +{
> +       int ret;
> +
> +       /* flags is not used yet */
> +       if (flags)
> +               return -EINVAL;
> +
> +       ret = access_process_vm(tsk, (unsigned long)user_ptr, dst, size, 0);
> +       if (ret >= 0) {
> +               if (ret == size)
> +                       ret = 0;

is there a point in calling access_process_vm() with size == 0? It
would validate that get_task_mm() succeeds, but that's pretty much it?
So maybe instead just exit early if size is zero? It will be also less
convoluted logic:

if (size == 0)
    return 0;
if (access_process_vm(...)) {
    memset(0);
    return -EFAULT;
}
return 0;

> +               else {
> +                       /* If partial read, clear all bytes and return error */
> +                       memset(dst, 0, size);
> +                       ret = -EFAULT;
> +               }
> +       }
> +       return ret;
> +}
> +

[...]
