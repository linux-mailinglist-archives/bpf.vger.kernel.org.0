Return-Path: <bpf+bounces-8266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6A478470A
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 18:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229662810C9
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12431DDD4;
	Tue, 22 Aug 2023 16:23:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B81D2E6
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:23:59 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1FB137
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 09:23:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bbbda48904so54444871fa.2
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 09:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692721436; x=1693326236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQCfpSR4TDAdf6w29FDSnIUdPZuw5Hwl7d/nzoP+dVE=;
        b=GiCL5m3VTPYECgPekV2bohHfjdO8/236Z7LK90dYqTsSOwCGNMGa2JEQ6rezTBD3KX
         jLZTg7R7NMWWk6/kTylBpjlXpWcBEJo/Iq0w7UMTTHycRCQaigo6vOs8T8kYiTOEB73y
         dlBQFnGeQEzXZRzxLUmVzWc5OJvVqVovqWh99SgDCWO6wZw7Mzuxt9Zzy38E4M5SCpBT
         vk0OFwMTGBbqNg93IuESnITGgwQ4pZQemN+pacIlxhflp990zT7K8Jt5L0OBPUt4gN0c
         r+NvHI2e1FBfu63gJ8NY7srEPrpjAbtZfRF/3HNzxztZ/MWn5nL+zOkFZfYNFHKEfNRg
         2yFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692721436; x=1693326236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQCfpSR4TDAdf6w29FDSnIUdPZuw5Hwl7d/nzoP+dVE=;
        b=RHr/adIt7e9WvzHDdhKbdrAUJ27GsrRY5CXizgEcfXtM9JmLm99tkQcrkGbPbGC/vR
         Jl0zv7/8iiJKRCmGjoeWY1GOZ5fsJlAs6/wEg52bVafHg7WO7OmjS4TjHE6VLPJRB2QV
         94O+Zwqq6yI+MsC6bAxVS/fhhpDCYjXrrGZbd/idDMWrJsA01eUQl4Wq0WowFwgmEiXd
         0lOFJqGj5Ajq6b6zHFqfLjFthHwLdedLTVCEyW/G8WhofFOoBpUNQccsOg+q/LoHRNTA
         Mg1C2rirFszAg87DUiAmOca5N6qS5ni8/AtYd6C++xnFfj5u1iBdaDVSwj4UG2NF4afp
         gBBw==
X-Gm-Message-State: AOJu0YxLFc/ZSOLnuOaj5jWVomM642kK5GSMhHUTylxJ/BgkoVziXqcA
	taurGA7nd4cuv1CU2eDBMjATF8MCH81vnQtgOCo=
X-Google-Smtp-Source: AGHT+IFAKBc+xysRe6RuNIRCS7bZ4qwH2Rkskhrxa79iGIpVQ35NwBr4VmvdfVD7WByhjTX3WYkQl524owIky8h5SlI=
X-Received: by 2002:a2e:9808:0:b0:2b5:8bb9:4dd6 with SMTP id
 a8-20020a2e9808000000b002b58bb94dd6mr8705957ljj.12.1692721435369; Tue, 22 Aug
 2023 09:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <20230809114116.3216687-9-memxor@gmail.com>
In-Reply-To: <20230809114116.3216687-9-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Aug 2023 09:23:44 -0700
Message-ID: <CAADnVQKb8fmOGcL2HYDOXG8_KWqkea+T9+MiBD3NHuAbhXP0dA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/14] bpf: Prevent KASAN false positive with bpf_throw
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrey, Dmitry,

Please help review this patch.


On Wed, Aug 9, 2023 at 4:43=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> The KASAN stack instrumentation when CONFIG_KASAN_STACK is true poisons
> the stack of a function when it is entered and unpoisons it when
> leaving. However, in the case of bpf_throw, we will never return as we
> switch our stack frame to the BPF exception callback. Later, this
> discrepancy will lead to confusing KASAN splats when kernel resumes
> execution on return from the BPF program.
>
> Fix this by unpoisoning everything below the stack pointer of the BPF
> program, which should cover the range that would not be unpoisoned. An
> example splat is below:
>
> BUG: KASAN: stack-out-of-bounds in stack_trace_consume_entry+0x14e/0x170
> Write of size 8 at addr ffffc900013af958 by task test_progs/227
>
> CPU: 0 PID: 227 Comm: test_progs Not tainted 6.5.0-rc2-g43f1c6c9052a-dirt=
y #26
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-2.fc39=
 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x4a/0x80
>  print_report+0xcf/0x670
>  ? arch_stack_walk+0x79/0x100
>  kasan_report+0xda/0x110
>  ? stack_trace_consume_entry+0x14e/0x170
>  ? stack_trace_consume_entry+0x14e/0x170
>  ? __pfx_stack_trace_consume_entry+0x10/0x10
>  stack_trace_consume_entry+0x14e/0x170
>  ? __sys_bpf+0xf2e/0x41b0
>  arch_stack_walk+0x8b/0x100
>  ? __sys_bpf+0xf2e/0x41b0
>  ? bpf_prog_test_run_skb+0x341/0x1c70
>  ? bpf_prog_test_run_skb+0x341/0x1c70
>  stack_trace_save+0x9b/0xd0
>  ? __pfx_stack_trace_save+0x10/0x10
>  ? __kasan_slab_free+0x109/0x180
>  ? bpf_prog_test_run_skb+0x341/0x1c70
>  ? __sys_bpf+0xf2e/0x41b0
>  ? __x64_sys_bpf+0x78/0xc0
>  ? do_syscall_64+0x3c/0x90
>  ? entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>  kasan_save_stack+0x33/0x60
>  ? kasan_save_stack+0x33/0x60
>  ? kasan_set_track+0x25/0x30
>  ? kasan_save_free_info+0x2b/0x50
>  ? __kasan_slab_free+0x109/0x180
>  ? kmem_cache_free+0x191/0x460
>  ? bpf_prog_test_run_skb+0x341/0x1c70
>  kasan_set_track+0x25/0x30
>  kasan_save_free_info+0x2b/0x50
>  __kasan_slab_free+0x109/0x180
>  kmem_cache_free+0x191/0x460
>  bpf_prog_test_run_skb+0x341/0x1c70
>  ? __pfx_bpf_prog_test_run_skb+0x10/0x10
>  ? __fget_light+0x51/0x220
>  __sys_bpf+0xf2e/0x41b0
>  ? __might_fault+0xa2/0x170
>  ? __pfx___sys_bpf+0x10/0x10
>  ? lock_release+0x1de/0x620
>  ? __might_fault+0xcd/0x170
>  ? __pfx_lock_release+0x10/0x10
>  ? __pfx_blkcg_maybe_throttle_current+0x10/0x10
>  __x64_sys_bpf+0x78/0xc0
>  ? syscall_enter_from_user_mode+0x20/0x50
>  do_syscall_64+0x3c/0x90
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> RIP: 0033:0x7f0fbb38880d
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d
> 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d=
 f3 45 12 00 f7 d8 64
> 89 01 48
> RSP: 002b:00007ffe13907de8 EFLAGS: 00000206 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007ffe13908708 RCX: 00007f0fbb38880d
> RDX: 0000000000000050 RSI: 00007ffe13907e20 RDI: 000000000000000a
> RBP: 00007ffe13907e00 R08: 0000000000000000 R09: 00007ffe13907e20
> R10: 0000000000000064 R11: 0000000000000206 R12: 0000000000000003
> R13: 0000000000000000 R14: 00007f0fbb532000 R15: 0000000000cfbd90
>  </TASK>
>
> The buggy address belongs to stack of task test_progs/227
> KASAN internal error: frame info validation failed; invalid marker: 0
>
> The buggy address belongs to the virtual mapping at
>  [ffffc900013a8000, ffffc900013b1000) created by:
>  kernel_clone+0xcd/0x600
>
> The buggy address belongs to the physical page:
> page:00000000b70f4332 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x11418f
> flags: 0x2fffe0000000000(node=3D0|zone=3D2|lastcpupid=3D0x7fff)
> page_type: 0xffffffff()
> raw: 02fffe0000000000 0000000000000000 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffffc900013af800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc900013af880: 00 00 00 f1 f1 f1 f1 00 00 00 f3 f3 f3 f3 f3 00
> >ffffc900013af900: 00 00 00 00 00 00 00 00 00 00 00 f1 00 00 00 00
>                                                     ^
>  ffffc900013af980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc900013afa00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Disabling lock debugging due to kernel taint
>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/kasan.h | 2 ++
>  kernel/bpf/helpers.c  | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 819b6bc8ac08..7a463f814db2 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -283,8 +283,10 @@ static inline bool kasan_check_byte(const void *addr=
ess)
>
>  #if defined(CONFIG_KASAN) && defined(CONFIG_KASAN_STACK)
>  void kasan_unpoison_task_stack(struct task_struct *task);
> +asmlinkage void kasan_unpoison_task_stack_below(const void *watermark);
>  #else
>  static inline void kasan_unpoison_task_stack(struct task_struct *task) {=
}
> +static inline void kasan_unpoison_task_stack_below(const void *watermark=
) {}
>  #endif
>
>  #ifdef CONFIG_KASAN_GENERIC
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index af4add1e3a31..64a07232c58f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -22,6 +22,7 @@
>  #include <linux/security.h>
>  #include <linux/btf_ids.h>
>  #include <linux/bpf_mem_alloc.h>
> +#include <linux/kasan.h>
>
>  #include "../../lib/kstrtox.h"
>
> @@ -2463,6 +2464,11 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>                 WARN_ON_ONCE(!ctx.aux->exception_boundary);
>         WARN_ON_ONCE(!ctx.bp);
>         WARN_ON_ONCE(!ctx.cnt);
> +       /* Prevent KASAN false positives for CONFIG_KASAN_STACK by unpois=
oning
> +        * deeper stack depths than ctx.sp as we do not return from bpf_t=
hrow,
> +        * which skips compiler generated instrumentation to do the same.
> +        */
> +       kasan_unpoison_task_stack_below((void *)ctx.sp);
>         ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
>  }
>
> --
> 2.41.0
>

