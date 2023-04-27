Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686A06F050E
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 13:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243706AbjD0LfX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 07:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243152AbjD0LfW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 07:35:22 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418064ECB
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 04:35:21 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-74de9ce136cso394443385a.1
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 04:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682595320; x=1685187320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QENmgqijtQ7Lze6rVY9lo5aD++tfVhipzceIpocc7WU=;
        b=aegjBXupufAtvHDtpwCZYf9IWfkGYTgU0PQMWFI3n07wlULLXVzqQJ60f5N4vmHCeh
         LAQKadbNBd3eWf164Jq/LLe+A9Bwpsp1G3a3eGOcI3UfTqsCqDXkpRfS6BLrS4Bs71HN
         3vbK5ldfztsdW6mN60r0fzqHpWlC8L6dWXuhOppHWhX00W/eWR831Qsr+xErq6eUUfmg
         qGly3ufaT0RIA2BE5frmB8xtXWou/BvQ87RehKUBdiPqkGiye/Gni+Cq1ojc4meAESJH
         NL/s8vyeMplbZKyh7H8H979aDLCwXk0+JFx7wn+aN89lYG/ZxScHCSpWvah2zTvO+4tQ
         aGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682595320; x=1685187320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QENmgqijtQ7Lze6rVY9lo5aD++tfVhipzceIpocc7WU=;
        b=ao0jmJdPLGYOW+zb5AcZnek2UF/LtAaPPwp2wEygA/f2exqQN4UgXRWP/FBaPx9IAy
         bSbeMLKgFsn30uiMbW1XHdOvmH5rMaDR0RK8kPguD+HXrdIXja3ob/PSLszDa3cSmDjD
         R6adjl5K54LigqgtmrqoYmxHzCxew/gWvOcQ/owsxDWiY9dzya8Vaysd+JdtXhspIU5L
         cfnrBvbS9HlsodgOwV8qAAH5Wi2gcupm1w8FTwNCK4sr8BGDNSW6GNgqM12kD3f5uXci
         36JUiF2is8xl8O65EpsWCB4nqNZDaM/BvSA6gqn2nQ2aU/yrsrZonYRrPRsj1g+h80PD
         l7xw==
X-Gm-Message-State: AC+VfDxBWsGf5cZWE1xuDQn4nmR6b8cGvb4rA1hDAFocwHqWuGAufM17
        EVEJ00/0AhUMZ5OZkMmOdjnZkiikO8N+lkXIaUA=
X-Google-Smtp-Source: ACHHUZ4zY9gFpM6iuDJTJ61OjMKBhjgRyQyi4vQ1KgkMUvUSvR81KHA/eWb99m7s9HbACnaDTn9kK1B2DeIksVkR5SM=
X-Received: by 2002:ad4:5cc4:0:b0:5c9:a0ce:df0c with SMTP id
 iu4-20020ad45cc4000000b005c9a0cedf0cmr1628507qvb.22.1682595320368; Thu, 27
 Apr 2023 04:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230424161104.3737-1-laoar.shao@gmail.com> <20230424161104.3737-3-laoar.shao@gmail.com>
 <CAADnVQKr3bmG2FfydcbXjwx5gML7NYjPiDtW+B1D+hc7hmD3QA@mail.gmail.com>
In-Reply-To: <CAADnVQKr3bmG2FfydcbXjwx5gML7NYjPiDtW+B1D+hc7hmD3QA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 27 Apr 2023 19:34:44 +0800
Message-ID: <CALOAHbCFAV1Tvko1HWhD9CYTqcY_ojP47ZxpWhyi=Sib8+5iWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] fork: Rename mm_init to task_mm_init
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
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

On Tue, Apr 25, 2023 at 5:13=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 24, 2023 at 9:12=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > The kernel will panic as follows when attaching fexit to mm_init,
> >
> > [   86.549700] ------------[ cut here ]------------
> > [   86.549712] BUG: kernel NULL pointer dereference, address: 000000000=
0000078
> > [   86.549713] #PF: supervisor read access in kernel mode
> > [   86.549715] #PF: error_code(0x0000) - not-present page
> > [   86.549716] PGD 10308f067 P4D 10308f067 PUD 11754e067 PMD 0
> > [   86.549719] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [   86.549722] CPU: 9 PID: 9829 Comm: main_amd64 Kdump: loaded Not tain=
ted 6.3.0-rc6+ #12
> > [   86.549725] RIP: 0010:check_preempt_wakeup+0xd1/0x310
> > [   86.549754] Call Trace:
> > [   86.549755]  <TASK>
> > [   86.549757]  check_preempt_curr+0x5e/0x70
> > [   86.549761]  ttwu_do_activate+0xab/0x350
> > [   86.549763]  try_to_wake_up+0x314/0x680
> > [   86.549765]  wake_up_process+0x15/0x20
> > [   86.549767]  insert_work+0xb2/0xd0
> > [   86.549772]  __queue_work+0x20a/0x400
> > [   86.549774]  queue_work_on+0x7b/0x90
> > [   86.549778]  drm_fb_helper_sys_imageblit+0xd7/0xf0 [drm_kms_helper]
> > [   86.549801]  drm_fbdev_fb_imageblit+0x5b/0xb0 [drm_kms_helper]
> > [   86.549813]  soft_cursor+0x1cb/0x250
> > [   86.549816]  bit_cursor+0x3ce/0x630
> > [   86.549818]  fbcon_cursor+0x139/0x1c0
> > [   86.549821]  ? __pfx_bit_cursor+0x10/0x10
> > [   86.549822]  hide_cursor+0x31/0xd0
> > [   86.549825]  vt_console_print+0x477/0x4e0
> > [   86.549828]  console_flush_all+0x182/0x440
> > [   86.549832]  console_unlock+0x58/0xf0
> > [   86.549834]  vprintk_emit+0x1ae/0x200
> > [   86.549837]  vprintk_default+0x1d/0x30
> > [   86.549839]  vprintk+0x5c/0x90
> > [   86.549841]  _printk+0x58/0x80
> > [   86.549843]  __warn_printk+0x7e/0x1a0
> > [   86.549845]  ? trace_preempt_off+0x1b/0x70
> > [   86.549848]  ? trace_preempt_on+0x1b/0x70
> > [   86.549849]  ? __percpu_counter_init+0x8e/0xb0
> > [   86.549853]  refcount_warn_saturate+0x9f/0x150
> > [   86.549855]  mm_init+0x379/0x390
> > [   86.549859]  bpf_trampoline_6442453440_0+0x23/0x1000
> > [   86.549862]  mm_init+0x5/0x390
> > [   86.549865]  ? mm_alloc+0x4e/0x60
> > [   86.549866]  alloc_bprm+0x8a/0x2e0
> > [   86.549869]  do_execveat_common.isra.0+0x67/0x240
> > [   86.549872]  __x64_sys_execve+0x37/0x50
> > [   86.549874]  do_syscall_64+0x38/0x90
> > [   86.549877]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >
> > The reason is that when we attach the btf id of the function mm_init we
> > actually attach the mm_init defined in init/main.c rather than the
> > function defined in kernel/fork.c. That can be proved by parsing
> > /sys/kernel/btf/vmlinux:
> >
> > [2493] FUNC 'initcall_blacklist' type_id=3D2477 linkage=3Dstatic
> > [2494] FUNC_PROTO '(anon)' ret_type_id=3D21 vlen=3D1
> >         'buf' type_id=3D57
> > [2495] FUNC 'early_randomize_kstack_offset' type_id=3D2494 linkage=3Dst=
atic
> > [2496] FUNC 'mm_init' type_id=3D118 linkage=3Dstatic
> > [2497] FUNC 'trap_init' type_id=3D118 linkage=3Dstatic
> > [2498] FUNC 'thread_stack_cache_init' type_id=3D118 linkage=3Dstatic
> >
> > From the above information we can find that the FUNCs above and below
> > mm_init are all defined in init/main.c. So there's no doubt that the
> > mm_init is also the function defined in init/main.c.
> >
> > So when a task calls mm_init and thus the bpf trampoline is triggered i=
t
> > will use the information of the mm_init defined in init/main.c. Then th=
e
> > panic will occur.
> >
> > It seems that there're issues in btf, for example it is unnecessary to
> > generate btf for the functions annonated with __init. We need to improv=
e
> > btf. However we also need to change the function defined in
> > kernel/fork.c to task_mm_init to better distinguish them. After it is
> > renamed to task_mm_init, the /sys/kernel/btf/vmlinux will be:
> >
> > [13970] FUNC 'mm_alloc' type_id=3D13969 linkage=3Dstatic
> > [13971] FUNC_PROTO '(anon)' ret_type_id=3D204 vlen=3D3
> >         'mm' type_id=3D204
> >         'p' type_id=3D197
> >         'user_ns' type_id=3D452
> > [13972] FUNC 'task_mm_init' type_id=3D13971 linkage=3Dstatic
> > [13973] FUNC 'coredump_filter_setup' type_id=3D3804 linkage=3Dstatic
> > [13974] FUNC_PROTO '(anon)' ret_type_id=3D197 vlen=3D2
> >         'orig' type_id=3D197
> >         'node' type_id=3D21
> > [13975] FUNC 'dup_task_struct' type_id=3D13974 linkage=3Dstatic
> >
> > And then attaching task_mm_init won't panic. Improving the btf will be
> > handled later.
>
> We're not going to hack the kernel to workaround pahole issue.
> Let's fix pahole instead.
> cc-ing Alan for ideas.

Any comment on it, Alan ?
I think we can just skip generating BTF for the functions in
__section(".init.text"),  as these functions will be freed after
kernel init. There won't be use cases for them.

--=20
Regards
Yafang
