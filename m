Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015636CA634
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjC0Npj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 09:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjC0Npi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 09:45:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1EF3AB9
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 06:45:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o11so8499690ple.1
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679924737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJYat/OBKPlhrBvlVSiX+cYLX7uPzYOmPoJGAwFMYP8=;
        b=c8DDzec8ogkak3/p0BlqZSepFag547rKGPdjuTAX5X32hQivR0IV+iVkHJABfAdWw5
         pFqoKiXQ6PAlO6fjrmgm0aemmwZfVxshTVQlgh7k4JdDmmkS30dkWdReSeKUJ0by12O1
         T9GRqBSa+STVYNO618z30FjGQY0hemF/nBBAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679924737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJYat/OBKPlhrBvlVSiX+cYLX7uPzYOmPoJGAwFMYP8=;
        b=RiisGoS22bjJNRili2mB94uxgzx26Lhw9QxipMTNK87bhkUceC8FVM7nAMJ5I4EKrD
         s5+vZvSPVxA10/5M/EIytE6lmWlF5sFMmvFnP6v5tPTzXFlPRTwEnpSTrzlkE5DZ3iMm
         UlQDVEg9sTpLRQsh8STh3eUHzNKWeH7h+q1FTkmsBHxJRESj2VBY5aKAAGtZA3zcxEod
         6Mxl2fjkq2NtXPkVwly2zjv5HPZ1aWDiytp5hT51ttb5U6/lkcVQOhtIzVL5jGnsE4vl
         2X3fRteT7vBalB8R35f6pFT3eQVNTGGln5QZrEujnQNTfSAP0BSoYembHfFjWtPqWQBb
         iEFA==
X-Gm-Message-State: AAQBX9dhdt0knhdsZ5BGu3b035b6FEH0mAfzFyVfBedGXDFYpNa3wGtu
        FoNiucdjwCkfCs8aKDQJFJbZ/stgAMS11Fd/BxTYWQ==
X-Google-Smtp-Source: AKy350ac6Y/WA5U5dDL9X/qIqPL7m4OuRZw+njnUq5vlFiOwn9zF/SCV4r1JZArawOqTUtqCxkvbbNoKS7guJJ2F26E=
X-Received: by 2002:a17:902:c20c:b0:19f:3cc1:e3be with SMTP id
 12-20020a170902c20c00b0019f3cc1e3bemr4230898pll.12.1679924736698; Mon, 27 Mar
 2023 06:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230324171451.2752302-1-revest@chromium.org> <20230324171451.2752302-4-revest@chromium.org>
In-Reply-To: <20230324171451.2752302-4-revest@chromium.org>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 27 Mar 2023 15:45:25 +0200
Message-ID: <CABRcYmLZTo0NmdUHf0TtVVx5Pzgx2=R1TjkF4yio4z4NzpUFeA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: ftrace: Add direct call trampoline samples support
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 24, 2023 at 6:15=E2=80=AFPM Florent Revest <revest@chromium.org=
> wrote:
>
> The ftrace samples need per-architecture trampoline implementations
> to save and restore argument registers around the calls to
> my_direct_func* and to restore polluted registers (eg: x30).
>
> These samples also include <asm/asm-offsets.h> which, on arm64, is not
> necessary and redefines previously defined macros (resulting in
> warnings) so these includes are guarded by !CONFIG_ARM64.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  arch/arm64/Kconfig                          |  2 ++
>  samples/ftrace/ftrace-direct-modify.c       | 32 ++++++++++++++++++
>  samples/ftrace/ftrace-direct-multi-modify.c | 36 +++++++++++++++++++++
>  samples/ftrace/ftrace-direct-multi.c        | 22 +++++++++++++
>  samples/ftrace/ftrace-direct-too.c          | 25 ++++++++++++++
>  samples/ftrace/ftrace-direct.c              | 23 +++++++++++++
>  6 files changed, 140 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f3503d0cc1b8..c2bf28099abd 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -194,6 +194,8 @@ config ARM64
>                     !CC_OPTIMIZE_FOR_SIZE)
>         select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
>                 if DYNAMIC_FTRACE_WITH_ARGS
> +       select HAVE_SAMPLE_FTRACE_DIRECT
> +       select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
>         select HAVE_EFFICIENT_UNALIGNED_ACCESS
>         select HAVE_FAST_GUP
>         select HAVE_FTRACE_MCOUNT_RECORD
> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrac=
e-direct-modify.c
> index 25fba66f61c0..32ed0e1f8699 100644
> --- a/samples/ftrace/ftrace-direct-modify.c
> +++ b/samples/ftrace/ftrace-direct-modify.c
> @@ -2,7 +2,9 @@
>  #include <linux/module.h>
>  #include <linux/kthread.h>
>  #include <linux/ftrace.h>
> +#ifndef CONFIG_ARM64
>  #include <asm/asm-offsets.h>
> +#endif
>
>  extern void my_direct_func1(void);
>  extern void my_direct_func2(void);
> @@ -96,6 +98,36 @@ asm (
>
>  #endif /* CONFIG_S390 */
>
> +#ifdef CONFIG_ARM64
> +
> +asm (
> +"      .pushsection    .text, \"ax\", @progbits\n"
> +"      .type           my_tramp1, @function\n"
> +"      .globl          my_tramp1\n"
> +"   my_tramp1:"
> +"      sub     sp, sp, #16\n"

Oh, one thing I realize only now: I haven't properly tested this
series on a machine with BTI enabled.

All these sample trampolines should have a BTI C here.

Also, from a quick look, after adding -cpu max to my QEMU test setup,
there seem to be other BTI related errors. I'll investigate them
further and send a v4 that addresses them properly.

> +"      stp     x9, x30, [sp]\n"
> +"      bl      my_direct_func1\n"
> +"      ldp     x30, x9, [sp]\n"
> +"      add     sp, sp, #16\n"
> +"      ret     x9\n"
> +"      .size           my_tramp1, .-my_tramp1\n"
> +
> +"      .type           my_tramp2, @function\n"
> +"      .globl          my_tramp2\n"
> +"   my_tramp2:"
> +"      sub     sp, sp, #16\n"
> +"      stp     x9, x30, [sp]\n"
> +"      bl      my_direct_func2\n"
> +"      ldp     x30, x9, [sp]\n"
> +"      add     sp, sp, #16\n"
> +"      ret     x9\n"
> +"      .size           my_tramp2, .-my_tramp2\n"
> +"      .popsection\n"
> +);
> +
> +#endif /* CONFIG_ARM64 */
> +
>  static struct ftrace_ops direct;
>
>  static unsigned long my_tramp =3D (unsigned long)my_tramp1;
> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace=
/ftrace-direct-multi-modify.c
> index f72623899602..0ba40891d43e 100644
> --- a/samples/ftrace/ftrace-direct-multi-modify.c
> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> @@ -2,7 +2,9 @@
>  #include <linux/module.h>
>  #include <linux/kthread.h>
>  #include <linux/ftrace.h>
> +#ifndef CONFIG_ARM64
>  #include <asm/asm-offsets.h>
> +#endif
>
>  extern void my_direct_func1(unsigned long ip);
>  extern void my_direct_func2(unsigned long ip);
> @@ -103,6 +105,40 @@ asm (
>
>  #endif /* CONFIG_S390 */
>
> +#ifdef CONFIG_ARM64
> +
> +asm (
> +"      .pushsection    .text, \"ax\", @progbits\n"
> +"      .type           my_tramp1, @function\n"
> +"      .globl          my_tramp1\n"
> +"   my_tramp1:"
> +"      sub     sp, sp, #32\n"
> +"      stp     x9, x30, [sp]\n"
> +"      str     x0, [sp, #16]\n"
> +"      bl      my_direct_func1\n"
> +"      ldp     x30, x9, [sp]\n"
> +"      ldr     x0, [sp, #16]\n"
> +"      add     sp, sp, #32\n"
> +"      ret     x9\n"
> +"      .size           my_tramp1, .-my_tramp1\n"
> +
> +"      .type           my_tramp2, @function\n"
> +"      .globl          my_tramp2\n"
> +"   my_tramp2:"
> +"      sub     sp, sp, #32\n"
> +"      stp     x9, x30, [sp]\n"
> +"      str     x0, [sp, #16]\n"
> +"      bl      my_direct_func2\n"
> +"      ldp     x30, x9, [sp]\n"
> +"      ldr     x0, [sp, #16]\n"
> +"      add     sp, sp, #32\n"
> +"      ret     x9\n"
> +"      .size           my_tramp2, .-my_tramp2\n"
> +"      .popsection\n"
> +);
> +
> +#endif /* CONFIG_ARM64 */
> +
>  static unsigned long my_tramp =3D (unsigned long)my_tramp1;
>  static unsigned long tramps[2] =3D {
>         (unsigned long)my_tramp1,
> diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace=
-direct-multi.c
> index 1547c2c6be02..0b072e763c97 100644
> --- a/samples/ftrace/ftrace-direct-multi.c
> +++ b/samples/ftrace/ftrace-direct-multi.c
> @@ -4,7 +4,9 @@
>  #include <linux/mm.h> /* for handle_mm_fault() */
>  #include <linux/ftrace.h>
>  #include <linux/sched/stat.h>
> +#ifndef CONFIG_ARM64
>  #include <asm/asm-offsets.h>
> +#endif
>
>  extern void my_direct_func(unsigned long ip);
>
> @@ -66,6 +68,26 @@ asm (
>
>  #endif /* CONFIG_S390 */
>
> +#ifdef CONFIG_ARM64
> +
> +asm (
> +"      .pushsection    .text, \"ax\", @progbits\n"
> +"      .type           my_tramp, @function\n"
> +"      .globl          my_tramp\n"
> +"   my_tramp:"
> +"      sub     sp, sp, #32\n"
> +"      stp     x9, x30, [sp]\n"
> +"      str     x0, [sp, #16]\n"
> +"      bl      my_direct_func\n"
> +"      ldp     x30, x9, [sp]\n"
> +"      ldr     x0, [sp, #16]\n"
> +"      add     sp, sp, #32\n"
> +"      ret     x9\n"
> +"      .size           my_tramp, .-my_tramp\n"
> +"      .popsection\n"
> +);
> +
> +#endif /* CONFIG_ARM64 */
>  static struct ftrace_ops direct;
>
>  static int __init ftrace_direct_multi_init(void)
> diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-d=
irect-too.c
> index f28e7b99840f..5606b7ad1950 100644
> --- a/samples/ftrace/ftrace-direct-too.c
> +++ b/samples/ftrace/ftrace-direct-too.c
> @@ -3,7 +3,9 @@
>
>  #include <linux/mm.h> /* for handle_mm_fault() */
>  #include <linux/ftrace.h>
> +#ifndef CONFIG_ARM64
>  #include <asm/asm-offsets.h>
> +#endif
>
>  extern void my_direct_func(struct vm_area_struct *vma,
>                            unsigned long address, unsigned int flags);
> @@ -70,6 +72,29 @@ asm (
>
>  #endif /* CONFIG_S390 */
>
> +#ifdef CONFIG_ARM64
> +
> +asm (
> +"      .pushsection    .text, \"ax\", @progbits\n"
> +"      .type           my_tramp, @function\n"
> +"      .globl          my_tramp\n"
> +"   my_tramp:"
> +"      sub     sp, sp, #48\n"
> +"      stp     x9, x30, [sp]\n"
> +"      stp     x0, x1, [sp, #16]\n"
> +"      str     x2, [sp, #32]\n"
> +"      bl      my_direct_func\n"
> +"      ldp     x30, x9, [sp]\n"
> +"      ldp     x0, x1, [sp, #16]\n"
> +"      ldr     x2, [sp, #32]\n"
> +"      add     sp, sp, #48\n"
> +"      ret     x9\n"
> +"      .size           my_tramp, .-my_tramp\n"
> +"      .popsection\n"
> +);
> +
> +#endif /* CONFIG_ARM64 */
> +
>  static struct ftrace_ops direct;
>
>  static int __init ftrace_direct_init(void)
> diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direc=
t.c
> index d81a9473b585..7e20529ef132 100644
> --- a/samples/ftrace/ftrace-direct.c
> +++ b/samples/ftrace/ftrace-direct.c
> @@ -3,7 +3,9 @@
>
>  #include <linux/sched.h> /* for wake_up_process() */
>  #include <linux/ftrace.h>
> +#ifndef CONFIG_ARM64
>  #include <asm/asm-offsets.h>
> +#endif
>
>  extern void my_direct_func(struct task_struct *p);
>
> @@ -63,6 +65,27 @@ asm (
>
>  #endif /* CONFIG_S390 */
>
> +#ifdef CONFIG_ARM64
> +
> +asm (
> +"      .pushsection    .text, \"ax\", @progbits\n"
> +"      .type           my_tramp, @function\n"
> +"      .globl          my_tramp\n"
> +"   my_tramp:"
> +"      sub     sp, sp, #32\n"
> +"      stp     x9, x30, [sp]\n"
> +"      str     x0, [sp, #16]\n"
> +"      bl      my_direct_func\n"
> +"      ldp     x30, x9, [sp]\n"
> +"      ldr     x0, [sp, #16]\n"
> +"      add     sp, sp, #32\n"
> +"      ret     x9\n"
> +"      .size           my_tramp, .-my_tramp\n"
> +"      .popsection\n"
> +);
> +
> +#endif /* CONFIG_ARM64 */
> +
>  static struct ftrace_ops direct;
>
>  static int __init ftrace_direct_init(void)
> --
> 2.40.0.348.gf938b09366-goog
>
