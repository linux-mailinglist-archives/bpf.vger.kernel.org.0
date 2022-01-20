Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A949B49566F
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 23:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347687AbiATWqB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 17:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbiATWqB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 17:46:01 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5F9C061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 14:46:01 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y22so8790180iof.7
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJNXuzGS446sE7ZaZ7dnEJV+n/c9tNM7Iytj94hEdjc=;
        b=dDOVXsl0/0FpY91ZkCUaxE1GuXRtFbeMhnn61QqGOHf9o18krmt2gciCNRdaqiKfyq
         fNpLgxX60WHZGtR3dNLXGU8yfKUBh9SEWl3zzCIohBfTrvYZi5Vn5ehNJAK64ITW3bnu
         7+Nk5744MtwOcfnw6QCqIBEdSrluD0IQhkxPi90xrWcW9ckBEgJlS6xZqGlSigbiKIa8
         DcmqWxoWrtR47g7JMNLcpPutZom2RltXdlfFvObgzJUqwLJaNiqIuHIntxVDH7nw52kM
         b4tAopmd5ru8e1287KKZYtsxdPmX/qVu44l1i2rAXo0u7JvWGCeedhWjUbLC8m15ny53
         zl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJNXuzGS446sE7ZaZ7dnEJV+n/c9tNM7Iytj94hEdjc=;
        b=C2LEiKSA+Z3a2pdtDAv9LrrqQHy0t4alSAHEqLbiFQfw6rE6ctW+aoGQxNye8yl28y
         5V9y+kbz+qdSF5cf7sYQERTePtBajBuUtWDfHYLwxJ/Lftu7t7jFMamUeZbG3Z5rTgAp
         1BNesLegLn/6UXIOhEVyNnI6R/EGZQUzZPBiC5LIyvgBMLqvhBcLSWNZA2gEQ8eZWSGC
         yGxsJaLwO67L7DDyoQGv+8ppN0r5q5nUDGrATJJDploMZqCMkP4cnJj9EHJ37zSPXuVU
         cLEOnlotcjNN7giWmEMHbIPPMMeH4sIxjhY7muz4GeE8eky8D4MF3mzDNI9damjsDKq4
         tAfA==
X-Gm-Message-State: AOAM532yop/cSR3hcGjRNVOlqYdoAmyHFad8d6Mv1/4zn7bYCaYbrg+j
        Q/17gBMaZzM/NZZ/OFaG7Z16i1HskI5cZO4i/6g=
X-Google-Smtp-Source: ABdhPJxznJilLJTsK5rV7qP9R8DeFsIY6IsnpTlKddgnM3cyzbiezVWVsyR5DRniyH40Sybi3vkQxKTqtSQ66BenY4s=
X-Received: by 2002:a6b:c891:: with SMTP id y139mr535918iof.63.1642718760343;
 Thu, 20 Jan 2022 14:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220120172942.246805-1-kennyyu@fb.com>
 <20220120172942.246805-2-kennyyu@fb.com>
In-Reply-To: <20220120172942.246805-2-kennyyu@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Jan 2022 14:45:49 -0800
Message-ID: <CAEf4BzbEqSh36mFsrwtMYD6c-=LcJ3XbJsEa1ZatLdWkB+3mtQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] bpf: Add bpf_access_process_vm() helper
To:     Kenny Yu <kennyyu@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Gabriele <phoenix1987@gmail.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 20, 2022 at 9:30 AM Kenny Yu <kennyyu@fb.com> wrote:
>
> This adds a helper for bpf programs to access the memory of other
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
>  include/uapi/linux/bpf.h       | 11 +++++++++++
>  kernel/bpf/bpf_iter.c          | 20 +++++++++++++++-----
>  kernel/bpf/helpers.c           | 23 +++++++++++++++++++++++
>  kernel/trace/bpf_trace.c       |  2 ++
>  tools/include/uapi/linux/bpf.h | 11 +++++++++++
>  6 files changed, 63 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index dce54eb0aae8..29f174c08126 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2220,6 +2220,7 @@ extern const struct bpf_func_proto bpf_kallsyms_lookup_name_proto;
>  extern const struct bpf_func_proto bpf_find_vma_proto;
>  extern const struct bpf_func_proto bpf_loop_proto;
>  extern const struct bpf_func_proto bpf_strncmp_proto;
> +extern const struct bpf_func_proto bpf_access_process_vm_proto;
>
>  const struct bpf_func_proto *tracing_prog_func_proto(
>    enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index fe2272defcd9..2ac56e2512df 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5049,6 +5049,16 @@ union bpf_attr {
>   *             This helper is currently supported by cgroup programs only.
>   *     Return
>   *             0 on success, or a negative error in case of failure.
> + *
> + * long bpf_access_process_vm(void *dst, u32 size, const void *user_ptr, struct task_struct *tsk, u64 flags)
> + *     Description
> + *             Read *size* bytes from user space address *user_ptr* in *tsk*'s
> + *             address space, and stores the data in *dst*. *flags* is not
> + *             used yet and is provided for future extensibility. This is a
> + *             wrapper of **access_process_vm**\ ().
> + *     Return
> + *             The number of bytes written to the buffer, or a negative error
> + *             in case of failure.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5239,6 +5249,7 @@ union bpf_attr {
>         FN(get_func_arg_cnt),           \
>         FN(get_retval),                 \
>         FN(set_retval),                 \
> +       FN(access_process_vm),          \
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
>         /* bpf program can only return 0 or 1:
>          *  0 : okay
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 01cfdf40c838..9d7e86edc48e 100644
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
> @@ -671,6 +672,28 @@ const struct bpf_func_proto bpf_copy_from_user_proto = {
>         .arg3_type      = ARG_ANYTHING,
>  };
>
> +BPF_CALL_5(bpf_access_process_vm, void *, dst, u32, size,
> +          const void __user *, user_ptr, struct task_struct *, tsk,
> +          u64, flags)
> +{
> +       /* flags is not used yet */
> +       if (flags)
> +               return -EINVAL;
> +       return access_process_vm(tsk, (unsigned long)user_ptr, dst, size, 0);
> +}
> +
> +const struct bpf_func_proto bpf_access_process_vm_proto = {
> +       .func           = bpf_access_process_vm,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_PTR_TO_UNINIT_MEM,
> +       .arg2_type      = ARG_CONST_SIZE_OR_ZERO,
> +       .arg3_type      = ARG_ANYTHING,
> +       .arg4_type      = ARG_PTR_TO_BTF_ID,
> +       .arg4_btf_id    = &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
> +       .arg5_type      = ARG_ANYTHING
> +};
> +
>  BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
>  {
>         if (cpu >= nr_cpu_ids)
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 21aa30644219..1a6a81ce2e36 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1257,6 +1257,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>                 return &bpf_find_vma_proto;
>         case BPF_FUNC_trace_vprintk:
>                 return bpf_get_trace_vprintk_proto();
> +       case BPF_FUNC_access_process_vm:
> +               return prog->aux->sleepable ? &bpf_access_process_vm_proto : NULL;
>         default:
>                 return bpf_base_func_proto(func_id);
>         }
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index fe2272defcd9..2ac56e2512df 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5049,6 +5049,16 @@ union bpf_attr {
>   *             This helper is currently supported by cgroup programs only.
>   *     Return
>   *             0 on success, or a negative error in case of failure.
> + *
> + * long bpf_access_process_vm(void *dst, u32 size, const void *user_ptr, struct task_struct *tsk, u64 flags)
> + *     Description
> + *             Read *size* bytes from user space address *user_ptr* in *tsk*'s
> + *             address space, and stores the data in *dst*. *flags* is not
> + *             used yet and is provided for future extensibility. This is a
> + *             wrapper of **access_process_vm**\ ().
> + *     Return
> + *             The number of bytes written to the buffer, or a negative error
> + *             in case of failure.

wait, can it read less than *size* and return success?

bpf_probe_read_kernel() returns:

0 on success, or a negative error in case of failure.

Let's be consistent. Returning the number of read bytes makes more
sense in cases when we don't know the amount of bytes to be actually
read ahead of time (e.g., when reading zero-terminated strings).

BTW, should we also add a C string reading helper as well, just like
there is bpf_probe_read_user_str() and bpf_probe_read_user()?

Another thing, I think it's important to mention that this helper can
be used only from sleepable BPF programs.

And not to start the bikeshedding session, but we have
bpf_copy_from_user(), wouldn't something like
bpf_copy_from_user_{vm,process,remote}() be more in line and less
surprising for BPF users. BTW, "access" implies writing just as much
as reading, so using "access" in the sense of "read" seems wrong and
confusing.


>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5239,6 +5249,7 @@ union bpf_attr {
>         FN(get_func_arg_cnt),           \
>         FN(get_retval),                 \
>         FN(set_retval),                 \
> +       FN(access_process_vm),          \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> --
> 2.30.2
>
