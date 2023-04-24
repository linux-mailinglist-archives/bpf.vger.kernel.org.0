Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E976ED69A
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 23:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjDXVOB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 17:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjDXVOA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 17:14:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CA21B3
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 14:13:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ec8ce03818so5348991e87.3
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 14:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682370837; x=1684962837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7GEVYbtXhXO+nRGUfnLKWG891wdYWANyi+uJWCcJWk=;
        b=jOTEP1dGu3bpvAsh0pXpZ01IGQDCLsz5Mg5UvDXG85mtz9V6FBfwzDKCaELovleZtG
         35Obcn7eNuS8RglV2IcXuW5MwNTSsZNI7xE8VMuQPGlEkfKRN29VnQcXsUwb4Lq5SeqZ
         yrWmeD45b3F9Epw8m29UZRk0q4sWIY9W2KAYbOX+lzz4iM0+i+1v6o2eUnJbkohhIsL7
         jhvIOwZpi7vpoNSjzjubPiLpEg/oebi+UWpviSgfLpqQjrDamFzifNuI/MCN5V9FtIL3
         BXEvnv6BqGaOmh/Zf5E2JrLXBDzsaNty+Io9abaIDi0WgH7AnOX36mSRll7J1O6h6+5F
         V+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682370837; x=1684962837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7GEVYbtXhXO+nRGUfnLKWG891wdYWANyi+uJWCcJWk=;
        b=SQacJhpSEN6G+m8/gfkxwxzgxCuykod3hivciKI6WHEj4x94L9Eud54UJBUvLP8Xn0
         PCtqPz1bxL7u2rCjNpeKF3t6C1Xu1o6Cj5sUjchEASK+O9gwIyIRsSeemmcWJlxmHpKr
         0DRozp56Zdwo/xpgnfYrYlWiV05o2CasxycCE13Owa7lIruQvyO36DxplL9hWrJLRGVk
         lm9XNr/9EguqdhRt25xQCL/6wpSUrNQaWXv50n91kQY71FSRbvXbyPATKuZqAkOho1vV
         C8f8fVUJEBQG9ulLAF8XhYgkNwGJc536GyiZTYmb2mWU38v29x4fthkmZlPuZOP/HDWl
         w+HQ==
X-Gm-Message-State: AAQBX9fO5mXbUn0/Q5MMOx109c9tcqtMwUdC/EQWAu0haO6faaMEAN99
        qvj+fVpZA+FQCFnSkZX6RjxS0pTuZuL9beTddLU=
X-Google-Smtp-Source: AKy350ZPrTBewNiw8vjlPOIcUuX/hirrfhOXep9sFFiZ5eq6jJcXRtcUwoqKP2xDicXnnUgFOx/jau0m2gx6qUGP2SQ=
X-Received: by 2002:ac2:494f:0:b0:4db:d97:224d with SMTP id
 o15-20020ac2494f000000b004db0d97224dmr3805310lfi.19.1682370837053; Mon, 24
 Apr 2023 14:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230424161104.3737-1-laoar.shao@gmail.com> <20230424161104.3737-3-laoar.shao@gmail.com>
In-Reply-To: <20230424161104.3737-3-laoar.shao@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 24 Apr 2023 14:13:45 -0700
Message-ID: <CAADnVQKr3bmG2FfydcbXjwx5gML7NYjPiDtW+B1D+hc7hmD3QA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] fork: Rename mm_init to task_mm_init
To:     Yafang Shao <laoar.shao@gmail.com>,
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

On Mon, Apr 24, 2023 at 9:12=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> The kernel will panic as follows when attaching fexit to mm_init,
>
> [   86.549700] ------------[ cut here ]------------
> [   86.549712] BUG: kernel NULL pointer dereference, address: 00000000000=
00078
> [   86.549713] #PF: supervisor read access in kernel mode
> [   86.549715] #PF: error_code(0x0000) - not-present page
> [   86.549716] PGD 10308f067 P4D 10308f067 PUD 11754e067 PMD 0
> [   86.549719] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   86.549722] CPU: 9 PID: 9829 Comm: main_amd64 Kdump: loaded Not tainte=
d 6.3.0-rc6+ #12
> [   86.549725] RIP: 0010:check_preempt_wakeup+0xd1/0x310
> [   86.549754] Call Trace:
> [   86.549755]  <TASK>
> [   86.549757]  check_preempt_curr+0x5e/0x70
> [   86.549761]  ttwu_do_activate+0xab/0x350
> [   86.549763]  try_to_wake_up+0x314/0x680
> [   86.549765]  wake_up_process+0x15/0x20
> [   86.549767]  insert_work+0xb2/0xd0
> [   86.549772]  __queue_work+0x20a/0x400
> [   86.549774]  queue_work_on+0x7b/0x90
> [   86.549778]  drm_fb_helper_sys_imageblit+0xd7/0xf0 [drm_kms_helper]
> [   86.549801]  drm_fbdev_fb_imageblit+0x5b/0xb0 [drm_kms_helper]
> [   86.549813]  soft_cursor+0x1cb/0x250
> [   86.549816]  bit_cursor+0x3ce/0x630
> [   86.549818]  fbcon_cursor+0x139/0x1c0
> [   86.549821]  ? __pfx_bit_cursor+0x10/0x10
> [   86.549822]  hide_cursor+0x31/0xd0
> [   86.549825]  vt_console_print+0x477/0x4e0
> [   86.549828]  console_flush_all+0x182/0x440
> [   86.549832]  console_unlock+0x58/0xf0
> [   86.549834]  vprintk_emit+0x1ae/0x200
> [   86.549837]  vprintk_default+0x1d/0x30
> [   86.549839]  vprintk+0x5c/0x90
> [   86.549841]  _printk+0x58/0x80
> [   86.549843]  __warn_printk+0x7e/0x1a0
> [   86.549845]  ? trace_preempt_off+0x1b/0x70
> [   86.549848]  ? trace_preempt_on+0x1b/0x70
> [   86.549849]  ? __percpu_counter_init+0x8e/0xb0
> [   86.549853]  refcount_warn_saturate+0x9f/0x150
> [   86.549855]  mm_init+0x379/0x390
> [   86.549859]  bpf_trampoline_6442453440_0+0x23/0x1000
> [   86.549862]  mm_init+0x5/0x390
> [   86.549865]  ? mm_alloc+0x4e/0x60
> [   86.549866]  alloc_bprm+0x8a/0x2e0
> [   86.549869]  do_execveat_common.isra.0+0x67/0x240
> [   86.549872]  __x64_sys_execve+0x37/0x50
> [   86.549874]  do_syscall_64+0x38/0x90
> [   86.549877]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
> The reason is that when we attach the btf id of the function mm_init we
> actually attach the mm_init defined in init/main.c rather than the
> function defined in kernel/fork.c. That can be proved by parsing
> /sys/kernel/btf/vmlinux:
>
> [2493] FUNC 'initcall_blacklist' type_id=3D2477 linkage=3Dstatic
> [2494] FUNC_PROTO '(anon)' ret_type_id=3D21 vlen=3D1
>         'buf' type_id=3D57
> [2495] FUNC 'early_randomize_kstack_offset' type_id=3D2494 linkage=3Dstat=
ic
> [2496] FUNC 'mm_init' type_id=3D118 linkage=3Dstatic
> [2497] FUNC 'trap_init' type_id=3D118 linkage=3Dstatic
> [2498] FUNC 'thread_stack_cache_init' type_id=3D118 linkage=3Dstatic
>
> From the above information we can find that the FUNCs above and below
> mm_init are all defined in init/main.c. So there's no doubt that the
> mm_init is also the function defined in init/main.c.
>
> So when a task calls mm_init and thus the bpf trampoline is triggered it
> will use the information of the mm_init defined in init/main.c. Then the
> panic will occur.
>
> It seems that there're issues in btf, for example it is unnecessary to
> generate btf for the functions annonated with __init. We need to improve
> btf. However we also need to change the function defined in
> kernel/fork.c to task_mm_init to better distinguish them. After it is
> renamed to task_mm_init, the /sys/kernel/btf/vmlinux will be:
>
> [13970] FUNC 'mm_alloc' type_id=3D13969 linkage=3Dstatic
> [13971] FUNC_PROTO '(anon)' ret_type_id=3D204 vlen=3D3
>         'mm' type_id=3D204
>         'p' type_id=3D197
>         'user_ns' type_id=3D452
> [13972] FUNC 'task_mm_init' type_id=3D13971 linkage=3Dstatic
> [13973] FUNC 'coredump_filter_setup' type_id=3D3804 linkage=3Dstatic
> [13974] FUNC_PROTO '(anon)' ret_type_id=3D197 vlen=3D2
>         'orig' type_id=3D197
>         'node' type_id=3D21
> [13975] FUNC 'dup_task_struct' type_id=3D13974 linkage=3Dstatic
>
> And then attaching task_mm_init won't panic. Improving the btf will be
> handled later.

We're not going to hack the kernel to workaround pahole issue.
Let's fix pahole instead.
cc-ing Alan for ideas.
