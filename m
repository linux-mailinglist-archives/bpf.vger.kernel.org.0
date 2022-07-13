Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A287573B3E
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 18:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbiGMQ33 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 12:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbiGMQ33 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 12:29:29 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F1F22BCE
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 09:29:28 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 81-20020a630054000000b0041978b2aa9eso2554830pga.9
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W2FoRQz66ZMDQW8UECCUbWo1YjHSZazJPSQqB2a5JIw=;
        b=VcXZC3GBt2P9wKqqb5QUJ5avXB4OIVk1kVOxcX1zj/liu9QMxk2XYGhC/MBcx9Xcor
         hysoMELji/ROsIPdU18C3gFy43SiN/WtWQIp1ob0RV0I6HIMj6Vnj1oGb7t2K7OsbVTX
         FwLLfIicnuZQtC1nWLX8RgBOJbZ0QxPlSsqHde4Vqx3NbtJTy8pA8pJTzrLMWuEmX9wO
         EbvZqOlsfIOXIKF8H19cxjdpnhwh7++OB5uc6WCHzgHEkM8bM4cT/pK/I0n3T22u1Dtt
         +ElwNeKBYeI6K0RaXKZsSZjkbRhP0pkERKLT1BR00sxs2nSTAUZeoCw7JLQqdBaJui0w
         vMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W2FoRQz66ZMDQW8UECCUbWo1YjHSZazJPSQqB2a5JIw=;
        b=sHbGT0kxTMxzhlpxhjKzHkndzhRppmWEu1LBIitscPbIYMLhXcvfAVfttzZMS2mSzQ
         Kk4Gy1N/kq5oE+HARZUVBWcuWRaUeuUcpIylzG1uXAgaI/QwMaVea9ux8/tzrkvRlMyn
         D1WOAfAgUPXqz8OMzH3aDqDFLosCi6yDMVe8MISAs1gMBsAALNCHhYr25Wm/grLkQGOU
         2SZPxs7DqvppNCZQQz4lPSG3NfP+wq5dXJseiOYz1ewWTRMC1ThH+l5rpexDrrcV+PPU
         LZnekIAhHzM6pCUA9X+X5DcmP7+1IFkN8ZUGwuoqvxYkUpcSWbALWilX02vv3o8nc21j
         ZJtA==
X-Gm-Message-State: AJIora/GPMy8vi44dwspV6p80KuS6sS1VtBel9E1m5HKeF6zK5yVI90g
        xwSHgAlFp1OQIBuE8k3SVrkHVvw=
X-Google-Smtp-Source: AGRyM1tV4WmpjmtwqLPOmIdmtMJm7jjPvauDslfROpq3eHgXPsTCXSXRU4igOiZnuMhdY8nHsPxG0ng=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:ef46:b0:168:bac3:2fd4 with SMTP id
 e6-20020a170902ef4600b00168bac32fd4mr3862198plx.132.1657729768161; Wed, 13
 Jul 2022 09:29:28 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:29:26 -0700
In-Reply-To: <20220713015304.3375777-6-andrii@kernel.org>
Message-Id: <Ys7y5vCoSgiMW/p8@google.com>
Mime-Version: 1.0
References: <20220713015304.3375777-1-andrii@kernel.org> <20220713015304.3375777-6-andrii@kernel.org>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: use BPF_KSYSCALL and
 SEC("ksyscall") in selftests
From:   sdf@google.com
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/12, Andrii Nakryiko wrote:
> Convert few selftest that used plain SEC("kprobe") with arch-specific
> syscall wrapper prefix to ksyscall/kretsyscall and corresponding
> BPF_KSYSCALL macro. test_probe_user.c is especially benefiting from this
> simplification.

That looks super nice! I'm assuming the goal is probably
to get rid of that SYS_PREFIX everywhere eventually? And have a simple
test that exercises fentry/etc parsing?

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   .../selftests/bpf/progs/bpf_syscall_macro.c   |  6 ++---
>   .../selftests/bpf/progs/test_attach_probe.c   | 15 +++++------
>   .../selftests/bpf/progs/test_probe_user.c     | 27 +++++--------------
>   3 files changed, 16 insertions(+), 32 deletions(-)

> diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c  
> b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> index 05838ed9b89c..e1e11897e99b 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> @@ -64,9 +64,9 @@ int BPF_KPROBE(handle_sys_prctl)
>   	return 0;
>   }

> -SEC("kprobe/" SYS_PREFIX "sys_prctl")
> -int BPF_KPROBE_SYSCALL(prctl_enter, int option, unsigned long arg2,
> -		       unsigned long arg3, unsigned long arg4, unsigned long arg5)
> +SEC("ksyscall/prctl")
> +int BPF_KSYSCALL(prctl_enter, int option, unsigned long arg2,
> +		 unsigned long arg3, unsigned long arg4, unsigned long arg5)
>   {
>   	pid_t pid = bpf_get_current_pid_tgid() >> 32;

> diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c  
> b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> index f1c88ad368ef..a1e45fec8938 100644
> --- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
> +++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> @@ -1,11 +1,10 @@
>   // SPDX-License-Identifier: GPL-2.0
>   // Copyright (c) 2017 Facebook

> -#include <linux/ptrace.h>
> -#include <linux/bpf.h>
> +#include "vmlinux.h"
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_tracing.h>
> -#include <stdbool.h>
> +#include <bpf/bpf_core_read.h>
>   #include "bpf_misc.h"

>   int kprobe_res = 0;
> @@ -31,8 +30,8 @@ int handle_kprobe(struct pt_regs *ctx)
>   	return 0;
>   }

> -SEC("kprobe/" SYS_PREFIX "sys_nanosleep")
> -int BPF_KPROBE(handle_kprobe_auto)
> +SEC("ksyscall/nanosleep")
> +int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req,  
> struct __kernel_timespec *rem)
>   {
>   	kprobe2_res = 11;
>   	return 0;
> @@ -56,11 +55,11 @@ int handle_kretprobe(struct pt_regs *ctx)
>   	return 0;
>   }

> -SEC("kretprobe/" SYS_PREFIX "sys_nanosleep")
> -int BPF_KRETPROBE(handle_kretprobe_auto)
> +SEC("kretsyscall/nanosleep")
> +int BPF_KRETPROBE(handle_kretprobe_auto, int ret)
>   {
>   	kretprobe2_res = 22;
> -	return 0;
> +	return ret;
>   }

>   SEC("uprobe")
> diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c  
> b/tools/testing/selftests/bpf/progs/test_probe_user.c
> index 702578a5e496..8e1495008e4d 100644
> --- a/tools/testing/selftests/bpf/progs/test_probe_user.c
> +++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
> @@ -1,35 +1,20 @@
>   // SPDX-License-Identifier: GPL-2.0
> -
> -#include <linux/ptrace.h>
> -#include <linux/bpf.h>
> -
> -#include <netinet/in.h>
> -
> +#include "vmlinux.h"
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
>   #include "bpf_misc.h"

>   static struct sockaddr_in old;

> -SEC("kprobe/" SYS_PREFIX "sys_connect")
> -int BPF_KPROBE(handle_sys_connect)
> +SEC("ksyscall/connect")
> +int BPF_KSYSCALL(handle_sys_connect, int fd, struct sockaddr_in  
> *uservaddr, int addrlen)
>   {
> -#if SYSCALL_WRAPPER == 1
> -	struct pt_regs *real_regs;
> -#endif
>   	struct sockaddr_in new;
> -	void *ptr;
> -
> -#if SYSCALL_WRAPPER == 0
> -	ptr = (void *)PT_REGS_PARM2(ctx);
> -#else
> -	real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
> -	bpf_probe_read_kernel(&ptr, sizeof(ptr), &PT_REGS_PARM2(real_regs));
> -#endif

> -	bpf_probe_read_user(&old, sizeof(old), ptr);
> +	bpf_probe_read_user(&old, sizeof(old), uservaddr);
>   	__builtin_memset(&new, 0xab, sizeof(new));
> -	bpf_probe_write_user(ptr, &new, sizeof(new));
> +	bpf_probe_write_user(uservaddr, &new, sizeof(new));

>   	return 0;
>   }
> --
> 2.30.2

