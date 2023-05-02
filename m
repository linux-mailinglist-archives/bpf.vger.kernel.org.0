Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCF76F3C79
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 05:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjEBDkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 23:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjEBDkf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 23:40:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44353581
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 20:40:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ec8133c59eso3886124e87.0
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 20:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682998832; x=1685590832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVVmI3lCj3dHDJEegbPR1TYWFeu4CVUCHd2Aifwt2Es=;
        b=mO4GFaPs6FN2soMWqpodH9Oh6Zpzw1XdO2dR0HaQcyntbmYFMM3Wyb94IUE1uh7rhq
         t9pmmlfIU51HbYTBOp/rx7TJe9/H7QLxla12sQee6zxYevPZG8EPJAeb0av1uykRHkkZ
         c/1L12R3zbaMaDYV3UJm7aGUK7FHZN+AMCOxXeq0wPlbBO93ba/4Fp897h42gg3SD6JT
         gUZCfOoC4yZjvpZyzgQEeHbh3UxzfIxeL9KuqJELLuLmForAgFjYIbBu9X1tsYG7k5yn
         8trUV5lFvurHUGtjm2V6aU/PdoaJCNIuS9XmI1nx4L3vHssshaChJ9bdO66jQN8CK8f4
         +NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682998832; x=1685590832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVVmI3lCj3dHDJEegbPR1TYWFeu4CVUCHd2Aifwt2Es=;
        b=KiGERXzTqw/F81yIUpJQ+jK2SldHuVVQxY7Yq3MBg2idIM0dwVKMRKu+jI6zdIUS1T
         qJlbVhsHQ9xttA+K8VPbqEt+O0IcRjnLb+nGAbDcS68L+ACt4DE7E4d+wy6lNdK+MMgT
         QnkB1CRM4p6a3LR4VCN4M0xPjmqzcaziAaOBgCBYwkGDeVlBhzeQ5Z5iNP9WkbAErc3e
         iIWhY60ZC3ogHBbfttRZP0/FLhYHIMAqRJ6IX127iK16bHIxfK3Lcs3ksDQNy13r5BvW
         LKeihJAlAramJnIVgx24UZqdMNm0OycsbnvAJgjFUSNmFE5A5AeEsHDW0wRdH4Xv/d41
         Korg==
X-Gm-Message-State: AC+VfDwbwlkP5h7M/6yHIcRaWjXXC1Rh5JNPgxu9fgbIIqGCZhvUBVqN
        VYpmKmxtptbn5D3R6DxA81VzWurdYtwMiPvB/fU=
X-Google-Smtp-Source: ACHHUZ6MZm6domVsFdJFTmfNlS9oV4HHwGtdwWdUaQlOAfv1sgdb14v7neMXhGEKMIpCWsn0yRYpnWn4HgYIeXK1GvI=
X-Received: by 2002:a05:6512:403:b0:4f0:c0:7246 with SMTP id
 u3-20020a056512040300b004f000c07246mr4080705lfk.3.1682998831841; Mon, 01 May
 2023 20:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230424161104.3737-1-laoar.shao@gmail.com> <20230424161104.3737-3-laoar.shao@gmail.com>
 <CAADnVQKr3bmG2FfydcbXjwx5gML7NYjPiDtW+B1D+hc7hmD3QA@mail.gmail.com> <CALOAHbCFAV1Tvko1HWhD9CYTqcY_ojP47ZxpWhyi=Sib8+5iWg@mail.gmail.com>
In-Reply-To: <CALOAHbCFAV1Tvko1HWhD9CYTqcY_ojP47ZxpWhyi=Sib8+5iWg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 May 2023 20:40:20 -0700
Message-ID: <CAADnVQKx=dnd8_jaJGcric955MfvaHqKq=WSgVKc4wAWj_fORA@mail.gmail.com>
Subject: pahole issue. Re: [PATCH bpf-next 2/2] fork: Rename mm_init to task_mm_init
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alan,

wdyt on below?

On Thu, Apr 27, 2023 at 4:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Tue, Apr 25, 2023 at 5:13=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 24, 2023 at 9:12=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > The kernel will panic as follows when attaching fexit to mm_init,
> > >
> > > [   86.549700] ------------[ cut here ]------------
> > > [   86.549712] BUG: kernel NULL pointer dereference, address: 0000000=
000000078
> > > [   86.549713] #PF: supervisor read access in kernel mode
> > > [   86.549715] #PF: error_code(0x0000) - not-present page
> > > [   86.549716] PGD 10308f067 P4D 10308f067 PUD 11754e067 PMD 0
> > > [   86.549719] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > [   86.549722] CPU: 9 PID: 9829 Comm: main_amd64 Kdump: loaded Not ta=
inted 6.3.0-rc6+ #12
> > > [   86.549725] RIP: 0010:check_preempt_wakeup+0xd1/0x310
> > > [   86.549754] Call Trace:
> > > [   86.549755]  <TASK>
> > > [   86.549757]  check_preempt_curr+0x5e/0x70
> > > [   86.549761]  ttwu_do_activate+0xab/0x350
> > > [   86.549763]  try_to_wake_up+0x314/0x680
> > > [   86.549765]  wake_up_process+0x15/0x20
> > > [   86.549767]  insert_work+0xb2/0xd0
> > > [   86.549772]  __queue_work+0x20a/0x400
> > > [   86.549774]  queue_work_on+0x7b/0x90
> > > [   86.549778]  drm_fb_helper_sys_imageblit+0xd7/0xf0 [drm_kms_helper=
]
> > > [   86.549801]  drm_fbdev_fb_imageblit+0x5b/0xb0 [drm_kms_helper]
> > > [   86.549813]  soft_cursor+0x1cb/0x250
> > > [   86.549816]  bit_cursor+0x3ce/0x630
> > > [   86.549818]  fbcon_cursor+0x139/0x1c0
> > > [   86.549821]  ? __pfx_bit_cursor+0x10/0x10
> > > [   86.549822]  hide_cursor+0x31/0xd0
> > > [   86.549825]  vt_console_print+0x477/0x4e0
> > > [   86.549828]  console_flush_all+0x182/0x440
> > > [   86.549832]  console_unlock+0x58/0xf0
> > > [   86.549834]  vprintk_emit+0x1ae/0x200
> > > [   86.549837]  vprintk_default+0x1d/0x30
> > > [   86.549839]  vprintk+0x5c/0x90
> > > [   86.549841]  _printk+0x58/0x80
> > > [   86.549843]  __warn_printk+0x7e/0x1a0
> > > [   86.549845]  ? trace_preempt_off+0x1b/0x70
> > > [   86.549848]  ? trace_preempt_on+0x1b/0x70
> > > [   86.549849]  ? __percpu_counter_init+0x8e/0xb0
> > > [   86.549853]  refcount_warn_saturate+0x9f/0x150
> > > [   86.549855]  mm_init+0x379/0x390
> > > [   86.549859]  bpf_trampoline_6442453440_0+0x23/0x1000
> > > [   86.549862]  mm_init+0x5/0x390
> > > [   86.549865]  ? mm_alloc+0x4e/0x60
> > > [   86.549866]  alloc_bprm+0x8a/0x2e0
> > > [   86.549869]  do_execveat_common.isra.0+0x67/0x240
> > > [   86.549872]  __x64_sys_execve+0x37/0x50
> > > [   86.549874]  do_syscall_64+0x38/0x90
> > > [   86.549877]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > >
> > > The reason is that when we attach the btf id of the function mm_init =
we
> > > actually attach the mm_init defined in init/main.c rather than the
> > > function defined in kernel/fork.c. That can be proved by parsing
> > > /sys/kernel/btf/vmlinux:
> > >
> > > [2493] FUNC 'initcall_blacklist' type_id=3D2477 linkage=3Dstatic
> > > [2494] FUNC_PROTO '(anon)' ret_type_id=3D21 vlen=3D1
> > >         'buf' type_id=3D57
> > > [2495] FUNC 'early_randomize_kstack_offset' type_id=3D2494 linkage=3D=
static
> > > [2496] FUNC 'mm_init' type_id=3D118 linkage=3Dstatic
> > > [2497] FUNC 'trap_init' type_id=3D118 linkage=3Dstatic
> > > [2498] FUNC 'thread_stack_cache_init' type_id=3D118 linkage=3Dstatic
> > >
> > > From the above information we can find that the FUNCs above and below
> > > mm_init are all defined in init/main.c. So there's no doubt that the
> > > mm_init is also the function defined in init/main.c.
> > >
> > > So when a task calls mm_init and thus the bpf trampoline is triggered=
 it
> > > will use the information of the mm_init defined in init/main.c. Then =
the
> > > panic will occur.
> > >
> > > It seems that there're issues in btf, for example it is unnecessary t=
o
> > > generate btf for the functions annonated with __init. We need to impr=
ove
> > > btf. However we also need to change the function defined in
> > > kernel/fork.c to task_mm_init to better distinguish them. After it is
> > > renamed to task_mm_init, the /sys/kernel/btf/vmlinux will be:
> > >
> > > [13970] FUNC 'mm_alloc' type_id=3D13969 linkage=3Dstatic
> > > [13971] FUNC_PROTO '(anon)' ret_type_id=3D204 vlen=3D3
> > >         'mm' type_id=3D204
> > >         'p' type_id=3D197
> > >         'user_ns' type_id=3D452
> > > [13972] FUNC 'task_mm_init' type_id=3D13971 linkage=3Dstatic
> > > [13973] FUNC 'coredump_filter_setup' type_id=3D3804 linkage=3Dstatic
> > > [13974] FUNC_PROTO '(anon)' ret_type_id=3D197 vlen=3D2
> > >         'orig' type_id=3D197
> > >         'node' type_id=3D21
> > > [13975] FUNC 'dup_task_struct' type_id=3D13974 linkage=3Dstatic
> > >
> > > And then attaching task_mm_init won't panic. Improving the btf will b=
e
> > > handled later.
> >
> > We're not going to hack the kernel to workaround pahole issue.
> > Let's fix pahole instead.
> > cc-ing Alan for ideas.
>
> Any comment on it, Alan ?
> I think we can just skip generating BTF for the functions in
> __section(".init.text"),  as these functions will be freed after
> kernel init. There won't be use cases for them.
>
> --
> Regards
> Yafang
