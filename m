Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BE2674C21
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjATFYI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjATFXp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:23:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D0F7AF3D
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 21:14:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63213B826FF
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 00:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1032EC433AE
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 00:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674174422;
        bh=ROdLTe3LexbexnDR/PGA5NONfhz+ix0AhBH64LjX+J8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uVCeHyrsJEQ8IWopSBnf8u4tb3O3luBDdgeTUGFkJU4OGy5gqAT7xBhTyt/jtoL3e
         H+Ye4r4WcP1RXbkbCogFlsoB+7XqOzMPgrRN3vU1rrsj1bOx9lnR+/AevJRm5PLh/I
         arWE9PjDtWwT/y6EKH4M6eAiwY7LnZIoGKUlw81x1VuKOwkEfGGi9ysYaI7h2enYri
         2cGzBPaEnOdCtcWeeyaqmuE8STvMGMYRl0N9u5+/eHtPL9YjNDovTFibfoVgZvu6rB
         RRJRwSS19W+H0q4eYuFbweMN5aCBpqbymPlwrb50ZvSyfuQBl8xTabgM2vkqqc5QFJ
         /9YxzNLx3O2IA==
Received: by mail-ej1-f52.google.com with SMTP id u19so10072970ejm.8
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 16:27:01 -0800 (PST)
X-Gm-Message-State: AFqh2krvGfskbUhwOVs3EtVMYGRTi8YXIDlYSomqvtV8WMfEQ+psAht7
        Oh5YG5FBv8h1C2KZ9zJ9wsUCoUib+cKpVHmHaRqKrA==
X-Google-Smtp-Source: AMrXdXvQH4nrvVw+xUNYF/o795gSMWU8pL1Yf+iSGHGdXk9VA3BPp09x29rUk7QtWvAa9pzCpDmTYoEDEmNbE/i61tc=
X-Received: by 2002:a17:906:b788:b0:871:3103:a6aa with SMTP id
 dt8-20020a170906b78800b008713103a6aamr1132859ejb.88.1674174420059; Thu, 19
 Jan 2023 16:27:00 -0800 (PST)
MIME-Version: 1.0
References: <CAEiveUd_N8qHy54AS0q90FuUSQ=7mePm8FL88Aw-sY7fT7NqFQ@mail.gmail.com>
 <20230119042244.763779-1-clangllvm@126.com>
In-Reply-To: <20230119042244.763779-1-clangllvm@126.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 20 Jan 2023 01:26:49 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4Wu1DCY=r2OW8X2JsEJQq3Dt=baXKhUcZiAHqaa9dptg@mail.gmail.com>
Message-ID: <CACYkzJ4Wu1DCY=r2OW8X2JsEJQq3Dt=baXKhUcZiAHqaa9dptg@mail.gmail.com>
Subject: Re: [PATCH V2] bpf: security enhancement by limiting the offensive
 eBPF helpers
To:     Yi He <clangllvm@126.com>
Cc:     tixxdz@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev,
        mhiramat@kernel.org, rostedt@goodmis.org, sdf@google.com,
        song@kernel.org, yhs@fb.com, yhs@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 5:25 AM Yi He <clangllvm@126.com> wrote:
>
> The bpf_send_singal, bpf_send_singal_thread and bpf_override_return
> is similar to bpf_write_user and can affect userspace processes.
> Thus, these three helpers should also be restricted by security lockdown.
>
> Signed-off-by: Yi He <clangllvm@126.com>
> ---
>
> Thanks for you reply.
>
> I have studied this problem for months. I would like to give more details to
>  clarify why these two helpers can break the INTEGRITY and should be lockdown.
>
> First, this helpers are only for eBPF tracing programs. LSM-bpf and seccomp do
> not need them. The documents say the two functions are experimental.
> Now the eBPF products (e.g., Cillium, Falco) seldom use them but the evil eBPF
> can abuse them.

This has got nothing to do with breaking integrity.

>
> Second, override_return is similar to bpf_write_user can defintely break the
> INTEGRITY by altering other processes' system call or kernel functions
> (KProbe)'s return code.

Then any fault injection can break integrity? This is another can of
worms waiting to be opened here. It's not productive and doesn't help.
Let's focus on a better / flexible MAC policy here.

>
> > Then solution should be toward restricting eBPF in container, there is already
> > sysctl, per process seccomp, LSM + bpf LSM for that.
> Yes, the solution is for restricting eBPF in container. But a fine-gained access
> control is required, such as assigning different eBPF privilege to various containers,
> rather than just disable eBPF in a container.
>
You might want to reconsider your threat model about allowing partial
unprivileged access to eBPF, even if it's partial access. What you are
eventually going to run into is side channel attacks (please look at
the recent side channel issues exploited with unprivileged eBPF and
you don't need "offensive helpers" for these).

> The mechanisms you mententioned do not properly sovle the problem.
> sysctl can only disable the unprivielge
> users to access eBPF via the kernel.unprivileged_bpf_disabled flag. The untrusted eBPF
> are installed by privielge users inside a container but can harm the whole system and
> other shared-kernel containers.
> seccomp also can only disable the bpf system call to totally disable eBPF while we may
> need to selectively enable the benign features of eBPF and disallow the offensive features
> which may be abused.
> LSM + bpf LSM can implement this functionality. However, it is difficult to identify
> a process from a container [1] as at many LSM hooks, we can only get a process's pid and

It's not difficult. The core primitive is that the container manager
generates a unique ID per process and sets it on the task blob / local
storage (this can be flexible on what a definition of a container is
in your runtime [i.e a mix and match of different namespace ids)].
This can then be passed on the subprocesses via LSM hooks

>  name which can be forged by the mailicous program. A correct way is to use the inode number
>  to set policy for benign processes. Moreover, the LSM bpf's overhead is unacceptable.

BPF LSM is the worst case, but all LSMs have overhead.  I hear you and
here's my series to address this overhead.

https://lore.kernel.org/bpf/20230119231033.1307221-1-kpsingh@kernel.org/T/#t
[hasn't been delivered fully by vger yet] so I resent it as
https://lore.kernel.org/linux-security-module/20230120000818.1324170-3-kpsingh@kernel.org/T/#t
and, as of now, between them they have most of the patches.

>
> [1]. https://blog.doyensec.com/2022/10/11/ebpf-bypass-security-monitoring.html
>
> > Those are more or less same as bpf sending signal. Supervisors are using
> > seccomp to ret kill process and/or sending signals. Where will you draw the
> > line? should we go restrict those too? IMHO this does not relate to lockdown.
> > I don't see that much difference between a seccomp kill and ebpf signal.
>
> The bpf_send_singal is different to any other signal sending functions as it
> enables a eBPF tracing program from a container to kill any processes
> (even the privielge proceess) of the host or other containers.
> Supervisors and seccomp can only kill its child process. Other signal sending
> do not need to be restricted as they can not be used inside a container to kill
> any processes outside of a container.
>
> > This reasoning will kill any effort to improve sandbox mechanisms that are
> > moving some functionality from seccomp ret kill to a more flexible and
> > transparent bpf-LSM model where privileged installs the sandbox. Actually,
> > we are already doing this and beside eBPF flexibility and transparency
> > (change policy at runtime without restart) from a _user perspective_
> We will try to implement alternative mechanisms for constrained eBPF
> features only since the LSM-bpf have shortages in both flexibility and
>  performance.
>
> This patch is only for blocking the offensive features of eBPF and avoiding them
> affecting the INTEGRITY of the container, given that the evil eBPF can abuse these
> helpers to affect any processes running in inside or outside of the container,
> sharing the same kernel.

This has got nothing to do with kernel integrity. Please don't try to
shoe-horn your policy requirements into integrity.

If you really want to go with your threat model and allow partially
available unprivileged BPF, this should be done via BPF LSM. The
kernel should not try to adjust its definition of integrity based on a
rather questionable threat model. Let's fix the LSM overhead and
unblock flexibility for your use-case.

- KP


>
> [1]. https://github.com/Gui774ume/krie/blob/master/ebpf/krie/hooks/lsm.h
>
>  include/linux/security.h | 2 ++
>  kernel/trace/bpf_trace.c | 9 ++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5b67f208f..42420e620 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -123,6 +123,8 @@ enum lockdown_reason {
>         LOCKDOWN_DEBUGFS,
>         LOCKDOWN_XMON_WR,
>         LOCKDOWN_BPF_WRITE_USER,
> +       LOCKDOWN_BPF_SEND_SIGNAL,
> +       LOCKDOWN_BPF_OVERRIDE_RETURN,
>         LOCKDOWN_DBG_WRITE_KERNEL,
>         LOCKDOWN_RTAS_ERROR_INJECTION,
>         LOCKDOWN_INTEGRITY_MAX,
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c8..fdb94868d 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1463,9 +1463,11 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>                 return &bpf_cgrp_storage_delete_proto;
>  #endif
>         case BPF_FUNC_send_signal:
> -               return &bpf_send_signal_proto;
> +               return security_locked_down(LOCKDOWN_BPF_SEND_SIGNAL) < 0 ?
> +                      NULL : &bpf_send_signal_proto;
>         case BPF_FUNC_send_signal_thread:
> -               return &bpf_send_signal_thread_proto;
> +               return security_locked_down(LOCKDOWN_BPF_SEND_SIGNAL) < 0 ?
> +                      NULL : &bpf_send_signal_thread_proto;
>         case BPF_FUNC_perf_event_read_value:
>                 return &bpf_perf_event_read_value_proto;
>         case BPF_FUNC_get_ns_current_pid_tgid:
> @@ -1531,7 +1533,8 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>                 return &bpf_get_stack_proto;
>  #ifdef CONFIG_BPF_KPROBE_OVERRIDE
>         case BPF_FUNC_override_return:
> -               return &bpf_override_return_proto;
> +               return security_locked_down(LOCKDOWN_BPF_OVERRIDE_RETURN) < 0 ?
> +                      NULL : &bpf_override_return_proto;
>  #endif
>         case BPF_FUNC_get_func_ip:
>                 return prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ?
> --
> 2.25.1
>
