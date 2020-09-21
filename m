Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A662F2734F8
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 23:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIUVdw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 17:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgIUVdw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 17:33:52 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58393C061755
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 14:33:52 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id b142so11322303ybg.9
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 14:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uh4dN80ODjX2BJ3W0OcdX0nUI+nlOLWbggJxRiw/dlQ=;
        b=aszlkzJ6M8sANnmqq4i/73hkBgAWunBjjRRab2nPHNUXEWnDA2VgM2J6VjRQxmKMIa
         4s9CxCssBaIt89cmrBujoKZ86DRntY/Z9VV1tNjuiC7RN7QVy89hFKevJwQ5VRLIVpwD
         U1Mk8dac9s8iCOKfwYryVMt6UGDptCfcvP9ogR2v9X6xVpody3mDIx9BppHFnKqD1hd8
         0zyRmuwWIyuTuk4zOTyJ9LW6YAfjjLsHBPklohsrWIYwScvQiR3Qv3ETtrU7jDEqQGtK
         Jge+YurNUMbpgzC/ccim3zMmRyTxrY0UwKpaWAp0fyc164ZfzgLD84cNmWLoIDg0/y9S
         u3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uh4dN80ODjX2BJ3W0OcdX0nUI+nlOLWbggJxRiw/dlQ=;
        b=cktXR1zHomiihW9seMYkiqKzmduSMGltlq9q4DIceCHnadUO1YSkYtl2a19XEgqXqB
         84uEx87xCXMXbgwyNwVXTa0ear24bzhDja4/pR4OzWqv55eq2GvMDpj3Dq8nnLuwHnBY
         5gtZZK+CLeCP1S9aUtRnVTkIN9NfbhNITZxLExz9n04EX7+7BIkbuklTBuJXLiAdiQVz
         d09ZqIPFtSRgii5uzPdWhymrNMVSkyUXYKVPQfcPS3AZvGSJkelu3rv/CTyJuojvz0aW
         2nlqlVazo/r1SrLDslwoygGUV6lvinpnkKrxNcwnOwJ/gKi7a9+PHuiAMtW78HC2K2o3
         RQ9Q==
X-Gm-Message-State: AOAM533ow+A8SZxEfnQeH2yBuIBvcboh13KlDD42exKSPQ/OIjHJDbvf
        xbObx0HuZyUrxs3iP4KIBbFsbTL02nGtie7hpEl4xPdVKEKNBg==
X-Google-Smtp-Source: ABdhPJzTVfXkDDjxFkZhgJp1q9tdBi4+aZk3j5VS1KwQww+q3qrSs/EjcSWGxv4e4xiVb18W++HYJHDBFadn0VZtb2k=
X-Received: by 2002:a25:4446:: with SMTP id r67mr2594719yba.459.1600724031576;
 Mon, 21 Sep 2020 14:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200920144547.56771-1-xhao@linux.alibaba.com> <20200920144547.56771-4-xhao@linux.alibaba.com>
In-Reply-To: <20200920144547.56771-4-xhao@linux.alibaba.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Sep 2020 14:33:40 -0700
Message-ID: <CAEf4BzZaY+4m3mAZLjfE+ew5saDtWiS5dxrXNJU0W01mDU6GPQ@mail.gmail.com>
Subject: Re: [bpf-next 3/3] samples/bpf: Add soft irq execution time statistics
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 20, 2020 at 7:47 AM Xin Hao <xhao@linux.alibaba.com> wrote:
>
> This patch is aimed to count the execution time of
> each soft irq and it supports log2 histogram display.
>
> Soft irq counts:
>      us              : count    distribution
>
>      0 -> 1          : 151      |****************************************|
>      2 -> 3          : 86       |**********************                  |
>      4 -> 7          : 59       |***************                         |
>      8 -> 15         : 20       |*****                                   |
>     16 -> 31         : 3        |                                        |
>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---

I assume you saw softirqs tools ([0]) from libbpf-tools in BCC, right?
Could you mention in the commit message how this tool is different and
why there is a need for another one?

BTW, if you are interested in contributing more and making samples/bpf
better overall, consider looking at adding BPF skeleton integration
into samples/bpf, similarly to how all libbpf-tools use skeletons.

  [0] https://github.com/iovisor/bcc/pull/3076

>  samples/bpf/Makefile        |  3 ++
>  samples/bpf/soft_irq_kern.c | 87 ++++++++++++++++++++++++++++++++++++
>  samples/bpf/soft_irq_user.c | 88 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 178 insertions(+)
>  create mode 100644 samples/bpf/soft_irq_kern.c
>  create mode 100644 samples/bpf/soft_irq_user.c
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index f87ee02073ba..0774f0fb8bdf 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -53,6 +53,7 @@ tprogs-y += task_fd_query
>  tprogs-y += xdp_sample_pkts
>  tprogs-y += ibumad
>  tprogs-y += hbm
> +tprogs-y += soft_irq
>
>  # Libbpf dependencies
>  LIBBPF = $(TOOLS_PATH)/lib/bpf/libbpf.a
> @@ -109,6 +110,7 @@ task_fd_query-objs := bpf_load.o task_fd_query_user.o $(TRACE_HELPERS)
>  xdp_sample_pkts-objs := xdp_sample_pkts_user.o $(TRACE_HELPERS)
>  ibumad-objs := bpf_load.o ibumad_user.o $(TRACE_HELPERS)
>  hbm-objs := bpf_load.o hbm.o $(CGROUP_HELPERS)
> +soft_irq-objs := bpf_load.o soft_irq_user.o $(TRACE_HELPERS)
>
>  # Tell kbuild to always build the programs
>  always-y := $(tprogs-y)
> @@ -170,6 +172,7 @@ always-y += ibumad_kern.o
>  always-y += hbm_out_kern.o
>  always-y += hbm_edt_kern.o
>  always-y += xdpsock_kern.o
> +always-y += soft_irq_kern.o
>
>  ifeq ($(ARCH), arm)
>  # Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
> diff --git a/samples/bpf/soft_irq_kern.c b/samples/bpf/soft_irq_kern.c
> new file mode 100644
> index 000000000000..e63f829cf7c7
> --- /dev/null
> +++ b/samples/bpf/soft_irq_kern.c
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + */
> +
> +#include <uapi/linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <uapi/linux/ptrace.h>
> +#include <uapi/linux/perf_event.h>
> +#include <linux/version.h>
> +#include <linux/sched.h>
> +#include "common_kern.h"
> +
> +typedef struct key {
> +       u32 pid;
> +       u32 cpu;
> +} irqkey_t;
> +
> +typedef struct val {
> +       u64 ts;
> +       u32 vec;
> +} val_t;
> +
> +typedef struct delta_irq {
> +       u64 delta;
> +    u32 value;
> +} delta_irq_t;

kernel style generally discourages unnecessary typedefs, I think
following that is a good idea. I'm not sure those typedefs provide
much value and they save only few letters when typing.

> +
> +struct bpf_map_def SEC("maps") start = {
> +       .type = BPF_MAP_TYPE_HASH,
> +       .key_size = sizeof(irqkey_t),
> +       .value_size = sizeof(val_t),
> +       .max_entries = 1000,
> +};
> +
> +struct soft_irq {
> +       u64 pad;
> +    u32 vec;
> +};


it's a good idea to keep empty line between type declarations and
variables/functions

> +SEC("tracepoint/irq/softirq_entry")
> +int entryirq(struct soft_irq *ctx)
> +{
> +    irqkey_t entry_key = {};
> +       val_t val = {};
> +
> +       entry_key.pid = bpf_get_current_pid_tgid();
> +    entry_key.cpu = bpf_get_smp_processor_id();
> +
> +       val.ts = bpf_ktime_get_ns();
> +       val.vec = ctx->vec;
> +
> +       bpf_map_update_elem(&start, &entry_key, &val, BPF_ANY);
> +       return 0;
> +}
> +
> +struct bpf_map_def SEC("maps") over = {
> +       .type = BPF_MAP_TYPE_HASH,
> +       .key_size = sizeof(irqkey_t),
> +       .value_size = sizeof(delta_irq_t),
> +       .max_entries = 10000,
> +};

same

> +SEC("tracepoint/irq/softirq_exit")
> +int exitirq(struct soft_irq *ctx)
> +{
> +    irqkey_t entry_key = {};
> +       delta_irq_t delta_val = {};
> +       val_t *valp;
> +
> +       entry_key.pid = bpf_get_current_pid_tgid();
> +    entry_key.cpu = bpf_get_smp_processor_id();
> +
> +       valp = bpf_map_lookup_elem(&start, &entry_key);
> +       if (valp) {
> +               delta_val.delta = (bpf_ktime_get_ns() - valp->ts) / 1000; /* us */
> +               delta_val.value = log2l(delta_val.delta);
> +
> +               bpf_map_update_elem(&over, &entry_key, &delta_val, BPF_ANY);
> +               bpf_map_delete_elem(&start, valp);
> +       }
> +
> +       return 0;
> +}

here as well

> +char _license[] SEC("license") = "GPL";
> +u32 _version SEC("version") = LINUX_VERSION_CODE;

[...]
