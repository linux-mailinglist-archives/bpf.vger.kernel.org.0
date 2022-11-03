Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC1A617F82
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 15:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKCO3S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 10:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKCO3I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 10:29:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AEB10BB
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 07:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C91C61EF7
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1304C43141
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667485744;
        bh=gSdCmuMQNhjb8pll0/0ROcrc4EJjUBK8K4IdeHiVv3E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fe3GzoXWjLZFhb0GnIaHEoneC09dp+gIMxs+oLxuGhYOYnGRuij0jFN52d5NUNeGH
         jo1QrnjVjwx08Xi+Z5c+EgKlsl6nMAq7xocTWwM+Ig7+uryj1dM9K9yMSIwrmkRcR3
         SpZnTELHQEKap8n76mdm8oUW1pgUawlXaHimsh86vPUGoMaZE2oW2seq+iL6Kx9bhL
         YDcSkaEtAVVMVRXzXdodznwcMACaFN4B1xk6nw+IMTVj9OjLOMidw/KR/Yx7pCDSzh
         rArxrPFHRH0ITCEjtnDBLqxbnY97W3YVAQo8TCUhkCFJgRLLZJmz7QI16QrGpMq/Wp
         iBiT4nrCFg/wQ==
Received: by mail-lj1-f170.google.com with SMTP id d20so2398100ljc.12
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 07:29:04 -0700 (PDT)
X-Gm-Message-State: ACrzQf1kdRtKDLTpJnMT9t/+BCPrySyEpnqfYMqN1b1OAf3KLxCcZvmU
        NjQJdSvoO6p+qPmwTVyjXM7nqritpooaewJoXGd2tw==
X-Google-Smtp-Source: AMsMyM6tqFT4mCsRO9wAoZ8HwvmLJMjTYWza9kJqu75GrQgNhxGsd3CQVKKjkBAxGt4Tue2e6gG49w98QCOmdHuz2ow=
X-Received: by 2002:a05:651c:33c:b0:277:e2b:de4a with SMTP id
 b28-20020a05651c033c00b002770e2bde4amr11452027ljp.55.1667485742742; Thu, 03
 Nov 2022 07:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221103072102.2320490-1-yhs@fb.com> <20221103072113.2322563-1-yhs@fb.com>
In-Reply-To: <20221103072113.2322563-1-yhs@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 3 Nov 2022 15:28:51 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6ASmpYPmenN6NMpThiJiXF2ggQR+sjaE5DATRFTp64eQ@mail.gmail.com>
Message-ID: <CACYkzJ6ASmpYPmenN6NMpThiJiXF2ggQR+sjaE5DATRFTp64eQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Add bpf_rcu_read_lock/unlock helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 3, 2022 at 8:21 AM Yonghong Song <yhs@fb.com> wrote:
>
> Add bpf_rcu_read_lock() and bpf_rcu_read_unlock() helpers.
> Both helpers are available to all program types with
> CAP_BPF capability.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h            |  2 ++
>  include/uapi/linux/bpf.h       | 14 ++++++++++++++
>  kernel/bpf/core.c              |  2 ++
>  kernel/bpf/helpers.c           | 26 ++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
>  5 files changed, 58 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8d948bfcb984..a9bda4c91fc7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2554,6 +2554,8 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
>  extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>  extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>  extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
> +extern const struct bpf_func_proto bpf_rcu_read_lock_proto;
> +extern const struct bpf_func_proto bpf_rcu_read_unlock_proto;
>
>  const struct bpf_func_proto *tracing_prog_func_proto(
>    enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 94659f6b3395..e86389cd6133 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5481,6 +5481,18 @@ union bpf_attr {
>   *             0 on success.
>   *
>   *             **-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * void bpf_rcu_read_lock(void)
> + *     Description
> + *             Call kernel rcu_read_lock().

Simple wrapper around rcu_read_lock() and maybe explain where and how
it is supposed to
be used.

e.g. the verifier will check if __rcu pointers are being accessed with
bpf_rcu_read_lock in
sleepable programs.

Calling the helper from a non-sleepable program is inconsequential,
but maybe we can even
avoid exposing it to non-sleepable programs?

> + *     Return
> + *             None.
> + *
> + * void bpf_rcu_read_unlock(void)
> + *     Description
> + *             Call kernel rcu_read_unlock().
> + *     Return
> + *             None.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
>         FN(unspec, 0, ##ctx)                            \
> @@ -5695,6 +5707,8 @@ union bpf_attr {
>         FN(user_ringbuf_drain, 209, ##ctx)              \
>         FN(cgrp_storage_get, 210, ##ctx)                \
>         FN(cgrp_storage_delete, 211, ##ctx)             \
> +       FN(rcu_read_lock, 212, ##ctx)                   \
> +       FN(rcu_read_unlock, 213, ##ctx)                 \
>         /* */
>
>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 9c16338bcbe8..26858b579dfc 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2627,6 +2627,8 @@ const struct bpf_func_proto bpf_map_lookup_percpu_elem_proto __weak;
>  const struct bpf_func_proto bpf_spin_lock_proto __weak;
>  const struct bpf_func_proto bpf_spin_unlock_proto __weak;
>  const struct bpf_func_proto bpf_jiffies64_proto __weak;
> +const struct bpf_func_proto bpf_rcu_read_lock_proto __weak;
> +const struct bpf_func_proto bpf_rcu_read_unlock_proto __weak;
>
>  const struct bpf_func_proto bpf_get_prandom_u32_proto __weak;
>  const struct bpf_func_proto bpf_get_smp_processor_id_proto __weak;
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 124fd199ce5c..f19416dc8ad1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1273,6 +1273,28 @@ static const struct bpf_func_proto bpf_timer_start_proto = {
>         .arg3_type      = ARG_ANYTHING,
>  };
>
> +BPF_CALL_0(bpf_rcu_read_lock) {
> +       rcu_read_lock();
> +       return 0;
> +}
> +
> +const struct bpf_func_proto bpf_rcu_read_lock_proto = {
> +       .func           = bpf_rcu_read_lock,
> +       .gpl_only       = false,
> +       .ret_type       = RET_VOID,
> +};
> +
> +BPF_CALL_0(bpf_rcu_read_unlock) {
> +       rcu_read_unlock();
> +       return 0;
> +}
> +
> +const struct bpf_func_proto bpf_rcu_read_unlock_proto = {
> +       .func           = bpf_rcu_read_unlock,
> +       .gpl_only       = false,
> +       .ret_type       = RET_VOID,
> +};
> +
>  static void drop_prog_refcnt(struct bpf_hrtimer *t)
>  {
>         struct bpf_prog *prog = t->prog;
> @@ -1627,6 +1649,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>                 return &bpf_spin_lock_proto;
>         case BPF_FUNC_spin_unlock:
>                 return &bpf_spin_unlock_proto;
> +       case BPF_FUNC_rcu_read_lock:
> +               return &bpf_rcu_read_lock_proto;
> +       case BPF_FUNC_rcu_read_unlock:
> +               return &bpf_rcu_read_unlock_proto;
>         case BPF_FUNC_jiffies64:
>                 return &bpf_jiffies64_proto;
>         case BPF_FUNC_per_cpu_ptr:
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 94659f6b3395..e86389cd6133 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5481,6 +5481,18 @@ union bpf_attr {
>   *             0 on success.
>   *
>   *             **-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * void bpf_rcu_read_lock(void)
> + *     Description
> + *             Call kernel rcu_read_lock().
> + *     Return
> + *             None.
> + *
> + * void bpf_rcu_read_unlock(void)
> + *     Description
> + *             Call kernel rcu_read_unlock().
> + *     Return
> + *             None.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
>         FN(unspec, 0, ##ctx)                            \
> @@ -5695,6 +5707,8 @@ union bpf_attr {
>         FN(user_ringbuf_drain, 209, ##ctx)              \
>         FN(cgrp_storage_get, 210, ##ctx)                \
>         FN(cgrp_storage_delete, 211, ##ctx)             \
> +       FN(rcu_read_lock, 212, ##ctx)                   \
> +       FN(rcu_read_unlock, 213, ##ctx)                 \
>         /* */
>
>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> --
> 2.30.2
>

On Thu, Nov 3, 2022 at 8:21 AM Yonghong Song <yhs@fb.com> wrote:
>
> Add bpf_rcu_read_lock() and bpf_rcu_read_unlock() helpers.
> Both helpers are available to all program types with
> CAP_BPF capability.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h            |  2 ++
>  include/uapi/linux/bpf.h       | 14 ++++++++++++++
>  kernel/bpf/core.c              |  2 ++
>  kernel/bpf/helpers.c           | 26 ++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
>  5 files changed, 58 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8d948bfcb984..a9bda4c91fc7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2554,6 +2554,8 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
>  extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>  extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>  extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
> +extern const struct bpf_func_proto bpf_rcu_read_lock_proto;
> +extern const struct bpf_func_proto bpf_rcu_read_unlock_proto;
>
>  const struct bpf_func_proto *tracing_prog_func_proto(
>    enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 94659f6b3395..e86389cd6133 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5481,6 +5481,18 @@ union bpf_attr {
>   *             0 on success.
>   *
>   *             **-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * void bpf_rcu_read_lock(void)
> + *     Description
> + *             Call kernel rcu_read_lock().
> + *     Return
> + *             None.
> + *
> + * void bpf_rcu_read_unlock(void)
> + *     Description
> + *             Call kernel rcu_read_unlock().
> + *     Return
> + *             None.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
>         FN(unspec, 0, ##ctx)                            \
> @@ -5695,6 +5707,8 @@ union bpf_attr {
>         FN(user_ringbuf_drain, 209, ##ctx)              \
>         FN(cgrp_storage_get, 210, ##ctx)                \
>         FN(cgrp_storage_delete, 211, ##ctx)             \
> +       FN(rcu_read_lock, 212, ##ctx)                   \
> +       FN(rcu_read_unlock, 213, ##ctx)                 \
>         /* */
>
>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 9c16338bcbe8..26858b579dfc 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2627,6 +2627,8 @@ const struct bpf_func_proto bpf_map_lookup_percpu_elem_proto __weak;
>  const struct bpf_func_proto bpf_spin_lock_proto __weak;
>  const struct bpf_func_proto bpf_spin_unlock_proto __weak;
>  const struct bpf_func_proto bpf_jiffies64_proto __weak;
> +const struct bpf_func_proto bpf_rcu_read_lock_proto __weak;
> +const struct bpf_func_proto bpf_rcu_read_unlock_proto __weak;
>
>  const struct bpf_func_proto bpf_get_prandom_u32_proto __weak;
>  const struct bpf_func_proto bpf_get_smp_processor_id_proto __weak;
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 124fd199ce5c..f19416dc8ad1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1273,6 +1273,28 @@ static const struct bpf_func_proto bpf_timer_start_proto = {
>         .arg3_type      = ARG_ANYTHING,
>  };
>
> +BPF_CALL_0(bpf_rcu_read_lock) {
> +       rcu_read_lock();
> +       return 0;
> +}
> +
> +const struct bpf_func_proto bpf_rcu_read_lock_proto = {
> +       .func           = bpf_rcu_read_lock,
> +       .gpl_only       = false,
> +       .ret_type       = RET_VOID,
> +};
> +
> +BPF_CALL_0(bpf_rcu_read_unlock) {
> +       rcu_read_unlock();
> +       return 0;
> +}
> +
> +const struct bpf_func_proto bpf_rcu_read_unlock_proto = {
> +       .func           = bpf_rcu_read_unlock,
> +       .gpl_only       = false,
> +       .ret_type       = RET_VOID,
> +};
> +
>  static void drop_prog_refcnt(struct bpf_hrtimer *t)
>  {
>         struct bpf_prog *prog = t->prog;
> @@ -1627,6 +1649,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>                 return &bpf_spin_lock_proto;
>         case BPF_FUNC_spin_unlock:
>                 return &bpf_spin_unlock_proto;
> +       case BPF_FUNC_rcu_read_lock:
> +               return &bpf_rcu_read_lock_proto;
> +       case BPF_FUNC_rcu_read_unlock:
> +               return &bpf_rcu_read_unlock_proto;
>         case BPF_FUNC_jiffies64:
>                 return &bpf_jiffies64_proto;
>         case BPF_FUNC_per_cpu_ptr:
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 94659f6b3395..e86389cd6133 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5481,6 +5481,18 @@ union bpf_attr {
>   *             0 on success.
>   *
>   *             **-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * void bpf_rcu_read_lock(void)
> + *     Description
> + *             Call kernel rcu_read_lock().
> + *     Return
> + *             None.
> + *
> + * void bpf_rcu_read_unlock(void)
> + *     Description
> + *             Call kernel rcu_read_unlock().
> + *     Return
> + *             None.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
>         FN(unspec, 0, ##ctx)                            \
> @@ -5695,6 +5707,8 @@ union bpf_attr {
>         FN(user_ringbuf_drain, 209, ##ctx)              \
>         FN(cgrp_storage_get, 210, ##ctx)                \
>         FN(cgrp_storage_delete, 211, ##ctx)             \
> +       FN(rcu_read_lock, 212, ##ctx)                   \
> +       FN(rcu_read_unlock, 213, ##ctx)                 \
>         /* */
>
>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> --
> 2.30.2
>
