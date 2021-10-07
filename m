Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E89425B30
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 20:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbhJGTAK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 15:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233866AbhJGTAK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 15:00:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08093610A1;
        Thu,  7 Oct 2021 18:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633633096;
        bh=2AwiKwAfgkQnUVWir+EZWWKtgPpfXPVziWAXH8FRcTQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l/JSvVsKNSTD1V+Z2Us8BPrRTSQeBxo7IJwR3qjbO5GvjtlFm/nIa98ufJ7nmsI1f
         1Zu/63oitEJVuTez7Fshovirl9qdxnAyq9op6pNEPpnaS1dZCFcYo0tGL3HXhoonfS
         NV+8JE+ZlYx/4GzkW8/D1WYxARTO9TZYqcekD6lqSPb6QO94/pRnrjeZ+U5PpUe9Kl
         1ancQJHjkDprC/9lJ2wTD2c+UJ6/kGwDc+TkvXzaYYnzqCY2EnqT832d/3uhx4OKpR
         EaXdoaont6a5rZB6xydqftcqjrdSPCVb+/2JG43plo2Eft2JbJqOKZB5Okjo2eXP9/
         Y8jDCqnNd/Yjg==
Received: by mail-lf1-f50.google.com with SMTP id j21so11030011lfe.0;
        Thu, 07 Oct 2021 11:58:15 -0700 (PDT)
X-Gm-Message-State: AOAM531mru635dYdfEdmwpjSJMo/R5c73TwVme3m9xZzf68m0hd8C5Qi
        /lptS5rMlw21U40GL3ib88p4TOLeVs7DtDUM1eE=
X-Google-Smtp-Source: ABdhPJz6h6oDBLzt4oyAaOokG7cnzpfDffOsDoMXtH47N7C4Fj45sFRXh8Gk/UgIaqJ6c2hjAhGmpMvWxYPSQ0WdksQ=
X-Received: by 2002:ac2:5182:: with SMTP id u2mr5587218lfi.676.1633633094362;
 Thu, 07 Oct 2021 11:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211006175106.GA295227@fuller.cnet> <20211007175037.GA439973@fuller.cnet>
In-Reply-To: <20211007175037.GA439973@fuller.cnet>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 Oct 2021 11:58:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5H4iDghrj1BkBRAP4bXVOGPr_FmObaq5ZWhzs7V+_HBw@mail.gmail.com>
Message-ID: <CAPhsuW5H4iDghrj1BkBRAP4bXVOGPr_FmObaq5ZWhzs7V+_HBw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: introduce helper bpf_raw_read_cpu_clock
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 11:04 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
>
> Add bpf_raw_read_cpu_clock helper, to read architecture specific
> CPU clock. In x86's case, this is the TSC.
>
> This is necessary to synchronize bpf traces from host and guest bpf-programs
> (after subtracting guest tsc-offset from guest timestamps).
>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Could you please
1) give more context on the target use case;
2) add some selftests for the feature?

Thanks,
Song

>
> ---
>
> v2:
> - drop redundant addition to bpf_tracing_func_proto (Song Liu)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index ab83c22d274e..832bb1f65f28 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -95,6 +95,7 @@ config X86
>         select ARCH_HAS_UBSAN_SANITIZE_ALL
>         select ARCH_HAS_DEBUG_WX
>         select ARCH_HAS_ZONE_DMA_SET if EXPERT
> +       select ARCH_HAS_BPF_RAW_CPU_CLOCK
>         select ARCH_HAVE_NMI_SAFE_CMPXCHG
>         select ARCH_MIGHT_HAVE_ACPI_PDC         if ACPI
>         select ARCH_MIGHT_HAVE_PC_PARPORT
> diff --git a/arch/x86/include/asm/bpf_raw_cpu_clock.h b/arch/x86/include/asm/bpf_raw_cpu_clock.h
> new file mode 100644
> index 000000000000..6951c399819e
> --- /dev/null
> +++ b/arch/x86/include/asm/bpf_raw_cpu_clock.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_BPF_RAW_CPU_CLOCK_H_
> +#define _ASM_X86_BPF_RAW_CPU_CLOCK_H_
> +
> +static inline unsigned long long read_raw_cpu_clock(void)
> +{
> +       return rdtsc_ordered();
> +}
> +
> +#endif /* _ASM_X86_BPF_RAW_CPU_CLOCK_H_ */
> diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
> index 3eff08d7b8e5..844a44ff508d 100644
> --- a/drivers/media/rc/bpf-lirc.c
> +++ b/drivers/media/rc/bpf-lirc.c
> @@ -105,6 +105,8 @@ lirc_mode2_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>                 return &bpf_ktime_get_ns_proto;
>         case BPF_FUNC_ktime_get_boot_ns:
>                 return &bpf_ktime_get_boot_ns_proto;
> +       case BPF_FUNC_read_raw_cpu_clock:
> +               return &bpf_read_raw_cpu_clock_proto;
>         case BPF_FUNC_tail_call:
>                 return &bpf_tail_call_proto;
>         case BPF_FUNC_get_prandom_u32:
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d604c8251d88..b6cb426085fb 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2058,6 +2058,7 @@ extern const struct bpf_func_proto bpf_get_numa_node_id_proto;
>  extern const struct bpf_func_proto bpf_tail_call_proto;
>  extern const struct bpf_func_proto bpf_ktime_get_ns_proto;
>  extern const struct bpf_func_proto bpf_ktime_get_boot_ns_proto;
> +extern const struct bpf_func_proto bpf_read_raw_cpu_clock_proto;
>  extern const struct bpf_func_proto bpf_get_current_pid_tgid_proto;
>  extern const struct bpf_func_proto bpf_get_current_uid_gid_proto;
>  extern const struct bpf_func_proto bpf_get_current_comm_proto;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6fc59d61937a..52191791b089 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4037,6 +4037,13 @@ union bpf_attr {
>   *     Return
>   *             Current *ktime*.
>   *
> + * u64 bpf_read_raw_cpu_clock(void)
> + *     Description
> + *             Return the architecture specific CPU clock value.
> + *             For x86, this is the TSC clock.
> + *     Return
> + *             *CPU clock value*
> + *
>   * long bpf_seq_printf(struct seq_file *m, const char *fmt, u32 fmt_size, const void *data, u32 data_len)
>   *     Description
>   *             **bpf_seq_printf**\ () uses seq_file **seq_printf**\ () to print
> @@ -5089,6 +5096,7 @@ union bpf_attr {
>         FN(task_pt_regs),               \
>         FN(get_branch_snapshot),        \
>         FN(trace_vprintk),              \
> +       FN(read_raw_cpu_clock),         \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index a82d6de86522..5815db157220 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -21,6 +21,10 @@ config HAVE_EBPF_JIT
>  config ARCH_WANT_DEFAULT_BPF_JIT
>         bool
>
> +# Used by archs to tell they support reading raw CPU clock
> +config ARCH_HAS_BPF_RAW_CPU_CLOCK
> +       bool
> +
>  menu "BPF subsystem"
>
>  config BPF_SYSCALL
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index b6c72af64d5d..8e2359dfd582 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2345,6 +2345,8 @@ const struct bpf_func_proto bpf_get_numa_node_id_proto __weak;
>  const struct bpf_func_proto bpf_ktime_get_ns_proto __weak;
>  const struct bpf_func_proto bpf_ktime_get_boot_ns_proto __weak;
>  const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto __weak;
> +const struct bpf_func_proto bpf_read_raw_cpu_clock_proto __weak;
> +
>
>  const struct bpf_func_proto bpf_get_current_pid_tgid_proto __weak;
>  const struct bpf_func_proto bpf_get_current_uid_gid_proto __weak;
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1ffd469c217f..90b9e5efaf65 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -18,6 +18,10 @@
>
>  #include "../../lib/kstrtox.h"
>
> +#ifdef CONFIG_ARCH_HAS_BPF_RAW_CPU_CLOCK
> +#include <asm/bpf_raw_cpu_clock.h>
> +#endif
> +
>  /* If kernel subsystem is allowing eBPF programs to call this function,
>   * inside its own verifier_ops->get_func_proto() callback it should return
>   * bpf_map_lookup_elem_proto, so that verifier can properly check the arguments
> @@ -168,6 +172,21 @@ const struct bpf_func_proto bpf_ktime_get_boot_ns_proto = {
>         .ret_type       = RET_INTEGER,
>  };
>
> +BPF_CALL_0(bpf_read_raw_cpu_clock)
> +{
> +#ifdef CONFIG_ARCH_HAS_BPF_RAW_CPU_CLOCK
> +       return read_raw_cpu_clock();
> +#else
> +       return sched_clock();
> +#endif
> +}
> +
> +const struct bpf_func_proto bpf_read_raw_cpu_clock_proto = {
> +       .func           = bpf_read_raw_cpu_clock,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +};
> +
>  BPF_CALL_0(bpf_ktime_get_coarse_ns)
>  {
>         return ktime_get_coarse_ns();
> @@ -1366,6 +1385,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>                 return &bpf_ktime_get_boot_ns_proto;
>         case BPF_FUNC_ktime_get_coarse_ns:
>                 return &bpf_ktime_get_coarse_ns_proto;
> +       case BPF_FUNC_read_raw_cpu_clock:
> +               return &bpf_read_raw_cpu_clock_proto;
>         case BPF_FUNC_ringbuf_output:
>                 return &bpf_ringbuf_output_proto;
>         case BPF_FUNC_ringbuf_reserve:
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 6fc59d61937a..52191791b089 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -4037,6 +4037,13 @@ union bpf_attr {
>   *     Return
>   *             Current *ktime*.
>   *
> + * u64 bpf_read_raw_cpu_clock(void)
> + *     Description
> + *             Return the architecture specific CPU clock value.
> + *             For x86, this is the TSC clock.
> + *     Return
> + *             *CPU clock value*
> + *
>   * long bpf_seq_printf(struct seq_file *m, const char *fmt, u32 fmt_size, const void *data, u32 data_len)
>   *     Description
>   *             **bpf_seq_printf**\ () uses seq_file **seq_printf**\ () to print
> @@ -5089,6 +5096,7 @@ union bpf_attr {
>         FN(task_pt_regs),               \
>         FN(get_branch_snapshot),        \
>         FN(trace_vprintk),              \
> +       FN(read_raw_cpu_clock),         \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>
