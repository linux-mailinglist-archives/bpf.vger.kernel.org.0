Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E72135213B
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 23:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhDAVAa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 17:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhDAVAa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 17:00:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D217FC0613E6
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 14:00:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i26so4785884lfl.1
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJmR18/w+fMwO6Yb2gVkTKURwv6CqJcOGUT71kqMlrI=;
        b=GmqgXUDUleq9jIhpm2I0aGgL10ngKBswHjNNV1uG3cu1kUnLcHUvJlM6BGhCrzcpLU
         PCG7SteI70ZNb22s2fpcu5oKT1M82t5gB0YLA6aiSiVy/LwWJH4aWG4P1DTNtS8auoXI
         PKXJ4h9s0xqa/xyxiAGVJhJeegr1BqbhQaV5CTZzbvp3b9aTge5KGWt65y99VlgCndse
         j/hVZdsM+iFQHlaEtujuN98D/SyWGW3KUFOyaakDSxigDudkKb9kJk5wIdRAM4cwyS64
         eMgWWGlCAfUwOhktxQL2ZrjkdmRVlSsEer6Pmcn+IYbqQZBDWmgsE0sqP5+Flrw6Uptu
         KyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJmR18/w+fMwO6Yb2gVkTKURwv6CqJcOGUT71kqMlrI=;
        b=XGpSK87lHUWfWuBoIm4K4xeVIc1RdqM9VTJE3e2/OckU2S/ZEreDoO+x6O6Kd/uso2
         J0RNmHpyxsT/4Hyc6nzP2g71/mDgjFmOypz27Nuil2PnOumoPXaWbxA7+R5W8KLrZxM6
         2apCa8l5Ay5v9P14jUzGmSQD8zkp1/oFpyl4FRoi3l/7rUjaE5RwWVspmDopXSn5gBZm
         zyUn7tt59D2/lp4O0iVUSC4Sbzqwpvvkg3QpPG4QqoIRd1fGV/XgoKk4/kCsgpI1rF0O
         KXajCZGqv2f+7J3QJgNku0hNwos3MevY2MnqBwZmfDs6OWXzaR1ou5LPTMhRBtI3RDQS
         UZjw==
X-Gm-Message-State: AOAM532wPRPmJ+JT51Oh51EFVuGMXssXbEb+uUQwd3wB5znNrayhVklF
        EFsGObBrfvWUeN8Iyrgh03m7PVQQ4/Eim3G/1c/t8GY2
X-Google-Smtp-Source: ABdhPJzUK78shk2d/pmnMTNDMBiVCRQK/IvQBgEja63XRKpQdmLct7lur6b5OlOfV1noDaFqJpPkFrzuogSbrM1lUZU=
X-Received: by 2002:ac2:5ec2:: with SMTP id d2mr6838367lfq.214.1617310828341;
 Thu, 01 Apr 2021 14:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210401000747.3648767-1-davemarchevsky@fb.com>
In-Reply-To: <20210401000747.3648767-1-davemarchevsky@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 1 Apr 2021 14:00:17 -0700
Message-ID: <CAADnVQLik1UD+=+oAW1aq7HXdHwDBewcnYGyVcmZG2r5WT9YKQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: refcount task stack in bpf_get_task_stack
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 31, 2021 at 5:08 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On x86 the struct pt_regs * grabbed by task_pt_regs() points to an
> offset of task->stack. The pt_regs are later dereferenced in
> __bpf_get_stack (e.g. by user_mode() check). This can cause a fault if
> the task in question exits while bpf_get_task_stack is executing, as
> warned by task_stack_page's comment:
>
> * When accessing the stack of a non-current task that might exit, use
> * try_get_task_stack() instead.  task_stack_page will return a pointer
> * that could get freed out from under you.
>
> Taking the comment's advice and using try_get_task_stack() and
> put_task_stack() to hold task->stack refcount, or bail early if it's
> already 0. Incrementing stack_refcount will ensure the task's stack
> sticks around while we're using its data.
>
> I noticed this bug while testing a bpf task iter similar to
> bpf_iter_task_stack in selftests, except mine grabbed user stack, and
> getting intermittent crashes, which resulted in dumps like:
>
>   BUG: unable to handle page fault for address: 0000000000003fe0
>   \#PF: supervisor read access in kernel mode
>   \#PF: error_code(0x0000) - not-present page
>   RIP: 0010:__bpf_get_stack+0xd0/0x230
>   <snip...>
>   Call Trace:
>   bpf_prog_0a2be35c092cb190_get_task_stacks+0x5d/0x3ec
>   bpf_iter_run_prog+0x24/0x81
>   __task_seq_show+0x58/0x80
>   bpf_seq_read+0xf7/0x3d0
>   vfs_read+0x91/0x140
>   ksys_read+0x59/0xd0
>   do_syscall_64+0x48/0x120
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Applied. Thanks
