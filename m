Return-Path: <bpf+bounces-265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C26FD119
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 23:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613431C20C60
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 21:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA7419936;
	Tue,  9 May 2023 21:22:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2BE19900
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 21:22:59 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EA2AD07
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 14:22:36 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ac81d2bfbcso69202921fa.3
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683667286; x=1686259286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ajv9QpUfanfbkexQ26NX1nsDcbStniJvIOEJmh8y/k=;
        b=ObE5seF8t9+dC4rTEA8Z2/obRJr0H7K2bvFQFxmq4B0MclLKNMKjbd4y/UroLVqOcU
         CrC1PlzPPbX9UUbh/mbNJcRIJiXI4EF2h/HPnY5XsaPH+aJ7SlmatSxYFPRxdzlriKOl
         flKLM9lWwRrpVIqQLemiGs16D9iEwr2fsRHfLN0FLTbu4J//4FJ7YQoLg+5TqLi+0RTy
         vgTaBtSi6yTWG+xFVEwjPxhndW7R8afJ1tfL1cDyeYs8+v8k/h1dVYc1IQ5DpImIC3p/
         ZmGkJANBq37tbLTQwiwWIQLuEfI/PbLtShNC6XNrZQqqvsa+ui1rsonumgAwBU1g99If
         sm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683667286; x=1686259286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ajv9QpUfanfbkexQ26NX1nsDcbStniJvIOEJmh8y/k=;
        b=kFE9XiWb4tvynfFkD8opqIzJgbRTEDYZaIZkZqv1MS7tONTEKaQs+mvTJyAbvAcS86
         hoQo3dDKYbJS5VOXqHBROPg8jDxvuP9h7flZplpWrUAZWijn2h/Y2Lwjd4vi+Ydv7JtX
         OL7zxhy/SThpWnXvbj9Hv7zmDve2WNx3yvZF4erVEvuWIx/jzS0Bg3V+vbR4juVL0OU3
         oj/03e5NaiDCye3FxE6vO0PhDs0z6sv46QNI6E+NaPh5ssEqXE82aS+jEx/U4Qdnq/p7
         DJtIl2dnDP4WdL2vUCIkKc6J8tAVSAqbe8woke/WgV5P3WYI9jLpfpVIJ8nAOPjiAhfc
         NE/g==
X-Gm-Message-State: AC+VfDwhfgIPKAAnQgNBvTqSU9Ri2LLEqL+V9hzrBZxYv3uymrQNwP3b
	Z9FUYlb8m/asfLhX8iHyEe6f8X88/AG5eGlZgi0=
X-Google-Smtp-Source: ACHHUZ5lfGeQ1x+bdJv+djFm0WtwIGe5L3xVGjdJbtlnDQrAtKWK+MIVTBO3B8/JcfQeXmLm3yDr9jSvhxMTcyNd8YI=
X-Received: by 2002:a2e:9047:0:b0:2ab:143e:e19c with SMTP id
 n7-20020a2e9047000000b002ab143ee19cmr1086728ljg.50.1683667286156; Tue, 09 May
 2023 14:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230424161104.3737-1-laoar.shao@gmail.com> <20230424161104.3737-3-laoar.shao@gmail.com>
 <CAADnVQKr3bmG2FfydcbXjwx5gML7NYjPiDtW+B1D+hc7hmD3QA@mail.gmail.com>
 <CALOAHbCFAV1Tvko1HWhD9CYTqcY_ojP47ZxpWhyi=Sib8+5iWg@mail.gmail.com>
 <CAADnVQKx=dnd8_jaJGcric955MfvaHqKq=WSgVKc4wAWj_fORA@mail.gmail.com> <0d9bbdf6-12b7-a9a3-9bf3-7f67b01c5c3e@oracle.com>
In-Reply-To: <0d9bbdf6-12b7-a9a3-9bf3-7f67b01c5c3e@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 May 2023 14:21:15 -0700
Message-ID: <CAADnVQKeSmeC1RR1CJ=r4=sLrBwTH3UnPHhy-Pm_DeGOrDor1g@mail.gmail.com>
Subject: Re: pahole issue. Re: [PATCH bpf-next 2/2] fork: Rename mm_init to task_mm_init
To: Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 9, 2023 at 11:44=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 02/05/2023 04:40, Alexei Starovoitov wrote:
> > Alan,
> >
> > wdyt on below?
> >
>
> apologies, missed this; see below..
>
> > On Thu, Apr 27, 2023 at 4:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> >>
> >> On Tue, Apr 25, 2023 at 5:13=E2=80=AFAM Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >>>
> >>> On Mon, Apr 24, 2023 at 9:12=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> >>>>
> >>>> The kernel will panic as follows when attaching fexit to mm_init,
> >>>>
> >>>> [   86.549700] ------------[ cut here ]------------
> >>>> [   86.549712] BUG: kernel NULL pointer dereference, address: 000000=
0000000078
> >>>> [   86.549713] #PF: supervisor read access in kernel mode
> >>>> [   86.549715] #PF: error_code(0x0000) - not-present page
> >>>> [   86.549716] PGD 10308f067 P4D 10308f067 PUD 11754e067 PMD 0
> >>>> [   86.549719] Oops: 0000 [#1] PREEMPT SMP NOPTI
> >>>> [   86.549722] CPU: 9 PID: 9829 Comm: main_amd64 Kdump: loaded Not t=
ainted 6.3.0-rc6+ #12
> >>>> [   86.549725] RIP: 0010:check_preempt_wakeup+0xd1/0x310
> >>>> [   86.549754] Call Trace:
> >>>> [   86.549755]  <TASK>
> >>>> [   86.549757]  check_preempt_curr+0x5e/0x70
> >>>> [   86.549761]  ttwu_do_activate+0xab/0x350
> >>>> [   86.549763]  try_to_wake_up+0x314/0x680
> >>>> [   86.549765]  wake_up_process+0x15/0x20
> >>>> [   86.549767]  insert_work+0xb2/0xd0
> >>>> [   86.549772]  __queue_work+0x20a/0x400
> >>>> [   86.549774]  queue_work_on+0x7b/0x90
> >>>> [   86.549778]  drm_fb_helper_sys_imageblit+0xd7/0xf0 [drm_kms_helpe=
r]
> >>>> [   86.549801]  drm_fbdev_fb_imageblit+0x5b/0xb0 [drm_kms_helper]
> >>>> [   86.549813]  soft_cursor+0x1cb/0x250
> >>>> [   86.549816]  bit_cursor+0x3ce/0x630
> >>>> [   86.549818]  fbcon_cursor+0x139/0x1c0
> >>>> [   86.549821]  ? __pfx_bit_cursor+0x10/0x10
> >>>> [   86.549822]  hide_cursor+0x31/0xd0
> >>>> [   86.549825]  vt_console_print+0x477/0x4e0
> >>>> [   86.549828]  console_flush_all+0x182/0x440
> >>>> [   86.549832]  console_unlock+0x58/0xf0
> >>>> [   86.549834]  vprintk_emit+0x1ae/0x200
> >>>> [   86.549837]  vprintk_default+0x1d/0x30
> >>>> [   86.549839]  vprintk+0x5c/0x90
> >>>> [   86.549841]  _printk+0x58/0x80
> >>>> [   86.549843]  __warn_printk+0x7e/0x1a0
> >>>> [   86.549845]  ? trace_preempt_off+0x1b/0x70
> >>>> [   86.549848]  ? trace_preempt_on+0x1b/0x70
> >>>> [   86.549849]  ? __percpu_counter_init+0x8e/0xb0
> >>>> [   86.549853]  refcount_warn_saturate+0x9f/0x150
> >>>> [   86.549855]  mm_init+0x379/0x390
> >>>> [   86.549859]  bpf_trampoline_6442453440_0+0x23/0x1000
> >>>> [   86.549862]  mm_init+0x5/0x390
> >>>> [   86.549865]  ? mm_alloc+0x4e/0x60
> >>>> [   86.549866]  alloc_bprm+0x8a/0x2e0
> >>>> [   86.549869]  do_execveat_common.isra.0+0x67/0x240
> >>>> [   86.549872]  __x64_sys_execve+0x37/0x50
> >>>> [   86.549874]  do_syscall_64+0x38/0x90
> >>>> [   86.549877]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >>>>
> >>>> The reason is that when we attach the btf id of the function mm_init=
 we
> >>>> actually attach the mm_init defined in init/main.c rather than the
> >>>> function defined in kernel/fork.c. That can be proved by parsing
> >>>> /sys/kernel/btf/vmlinux:
> >>>>
> >>>> [2493] FUNC 'initcall_blacklist' type_id=3D2477 linkage=3Dstatic
> >>>> [2494] FUNC_PROTO '(anon)' ret_type_id=3D21 vlen=3D1
> >>>>         'buf' type_id=3D57
> >>>> [2495] FUNC 'early_randomize_kstack_offset' type_id=3D2494 linkage=
=3Dstatic
> >>>> [2496] FUNC 'mm_init' type_id=3D118 linkage=3Dstatic
> >>>> [2497] FUNC 'trap_init' type_id=3D118 linkage=3Dstatic
> >>>> [2498] FUNC 'thread_stack_cache_init' type_id=3D118 linkage=3Dstatic
> >>>>
> >>>> From the above information we can find that the FUNCs above and belo=
w
> >>>> mm_init are all defined in init/main.c. So there's no doubt that the
> >>>> mm_init is also the function defined in init/main.c.
> >>>>
> >>>> So when a task calls mm_init and thus the bpf trampoline is triggere=
d it
> >>>> will use the information of the mm_init defined in init/main.c. Then=
 the
> >>>> panic will occur.
> >>>>
> >>>> It seems that there're issues in btf, for example it is unnecessary =
to
> >>>> generate btf for the functions annonated with __init. We need to imp=
rove
> >>>> btf. However we also need to change the function defined in
> >>>> kernel/fork.c to task_mm_init to better distinguish them. After it i=
s
> >>>> renamed to task_mm_init, the /sys/kernel/btf/vmlinux will be:
> >>>>
> >>>> [13970] FUNC 'mm_alloc' type_id=3D13969 linkage=3Dstatic
> >>>> [13971] FUNC_PROTO '(anon)' ret_type_id=3D204 vlen=3D3
> >>>>         'mm' type_id=3D204
> >>>>         'p' type_id=3D197
> >>>>         'user_ns' type_id=3D452
> >>>> [13972] FUNC 'task_mm_init' type_id=3D13971 linkage=3Dstatic
> >>>> [13973] FUNC 'coredump_filter_setup' type_id=3D3804 linkage=3Dstatic
> >>>> [13974] FUNC_PROTO '(anon)' ret_type_id=3D197 vlen=3D2
> >>>>         'orig' type_id=3D197
> >>>>         'node' type_id=3D21
> >>>> [13975] FUNC 'dup_task_struct' type_id=3D13974 linkage=3Dstatic
> >>>>
> >>>> And then attaching task_mm_init won't panic. Improving the btf will =
be
> >>>> handled later.
> >>>
> >>> We're not going to hack the kernel to workaround pahole issue.
> >>> Let's fix pahole instead.
> >>> cc-ing Alan for ideas.
> >>
> >> Any comment on it, Alan ?
> >> I think we can just skip generating BTF for the functions in
> >> __section(".init.text"),  as these functions will be freed after
> >> kernel init. There won't be use cases for them.
> >>
>
> won't the pahole v1.25 changes help here; can you try applying
>
> https://lore.kernel.org/bpf/1675949331-27935-1-git-send-email-alan.maguir=
e@oracle.com/
>
> ...and build using pahole; this should eliminate any functions
> with inconsistent prototypes via
>
>       --skip_encoding_btf_inconsistent_proto
>         Do not encode functions with multiple inconsistent prototypes or
>         unexpected register use for their parameters, where  the  regis=
=E2=80=90
>         ters used do not match calling conventions.
>
>
> I'll check this at my end too.
>
> Alexei, if this works should we look at applying the above
> again to bpf-next? If so I'll resend the patch.

I've lost the track with pahole fixes.
Did Arnaldo re-tag pahole 1.25 or released 1.26 with the fixes?

Alan,
please submit a fresh patch for bpf-next to enable
--skip_encoding_btf_inconsistent_proto, so it can go through CI.
I cannot test all combinations manually.

Thanks!

