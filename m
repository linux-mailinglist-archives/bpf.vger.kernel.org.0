Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7170F3B4195
	for <lists+bpf@lfdr.de>; Fri, 25 Jun 2021 12:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhFYK1M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Jun 2021 06:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhFYK1L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Jun 2021 06:27:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEC6C061766
        for <bpf@vger.kernel.org>; Fri, 25 Jun 2021 03:24:51 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e22so7208785pgv.10
        for <bpf@vger.kernel.org>; Fri, 25 Jun 2021 03:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KwSMGzrjG0d9zXmhqtipfkU8z6/nsyvvAQ1+pXQ/ew=;
        b=ytg97sPLtLPlJKWLEx+0YPHiyXOnx7jFacu45wsLZEPjJZ5SC9J0ntLvABE/zEFnAK
         CFk//6RYn8Yn6i+2U+3/XkHZ0xRonpMnqxp50+ot4Xb1XJBMN6SUuJjRu00tSW34J9D2
         GN5p7jZ0x9nEchXgQTJ6XU6FvQBczKdRkRKcxuECopGBo7SJdabh35JsPBvLHLebYGR7
         +dLBEPBS7B4y8Frhn2lfd45ju+vgNvpqikZGGdbgzZFwIj33CDmn/eVDsTCxhNMWVCDg
         GJp2qbK3QV3InaYwhgRA4qqCCpzCN7645bE6aVWCGe7IXZpQmhZk0RvqcweU0vTt2Tv6
         nP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KwSMGzrjG0d9zXmhqtipfkU8z6/nsyvvAQ1+pXQ/ew=;
        b=GjfDpz7V21PyEVBlKKSN0g7FJacN0edXxqx1c3l+8jW1N6z6A/ZH7T7C5NGZJ6cODg
         O7M/LqJkdSQsqF+wkK6o1pi7pB/GuIUyf84BGOnJUFfBJh+G7k1Lyia2Qa9CI1o9hDtG
         giX6Ct4h1STOWEqho6Mh9iRdtS2WtG6U/QYaPee+M/ukQ7MAPJ/FK7P0RhOV3OXxzIx4
         0LI0XF74dapTb3mcgU85wLNewUHv/Fjjp73bW2tacKZjmFJ77gByDaFqSiRAdKM53B0j
         0GKPqCy7VqLzRcsSi2y4VP3sYGqKA2+VgFp79GPDGWp6QjG+axr1yRLedyNJBeB2VgnR
         3DiA==
X-Gm-Message-State: AOAM531AOMQ9FwcKrpr3dlgpfr+WeIEii0A917qOKb0dRl0YEztWsTpN
        lZYxcRcHowRqbT/IwL0naZ845I2KWz8iuxSqCcKDXA==
X-Google-Smtp-Source: ABdhPJyXI8BHwWlE/zuSM4O5ASeaXOtu7t2Eju1dY+edUACoe9WILvtdmQJi9HmeRopa1iEWCoLBpfbA6UmKpq9zgMU=
X-Received: by 2002:a65:63ce:: with SMTP id n14mr8930484pgv.273.1624616690717;
 Fri, 25 Jun 2021 03:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210625084748.18128-1-wangqiang.wq.frank@bytedance.com>
In-Reply-To: <20210625084748.18128-1-wangqiang.wq.frank@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 25 Jun 2021 18:24:12 +0800
Message-ID: <CAMZfGtWPi4CuVOtmUpy2N9J_mvp+5=gSAFvqV1nmvDKP+CAvQA@mail.gmail.com>
Subject: Re: [Phishing Risk] [PATCH] kprobe: fix kretprobe stack backtrace
To:     Qiang Wang <wangqiang.wq.frank@bytedance.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>, kpsingh@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 25, 2021 at 4:49 PM Qiang Wang
<wangqiang.wq.frank@bytedance.com> wrote:
>
> We found that we couldn't get the correct kernel stack from
> kretprobe. For example:
>
> bpftrace -e 'kr:submit_bio {print(kstack)}'
> Attaching 1 probe...
>
>         kretprobe_trampoline+0
>
>         kretprobe_trampoline+0
>
> The problem is caused by the wrong instruction register which
> points to the address of kretprobe_trampoline in regs.
> So we set the real return address in instruction register.
> Finally, we tested and successfully fixed it.
>
> bpftrace -e 'kr:submit_bio {print(kstack)}'
> Attaching 1 probe...
>
>         ext4_mpage_readpages+475
>         read_pages+139
>         page_cache_ra_unbounded+417
>         filemap_get_pages+245
>         filemap_read+169
>         __kernel_read+327
>         bprm_execve+648
>         do_execveat_common.isra.39+409
>         __x64_sys_execve+50
>         do_syscall_64+54
>         entry_SYSCALL_64_after_hwframe+68
>
> Reported-by: Chengming Zhou <zhouchengming@bytedance.com>
> Signed-off-by: Qiang Wang <wangqiang.wq.frank@bytedance.com>

Seems like a bug. Maybe we should add a "Fixes" tag here.

> ---
>  kernel/kprobes.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 745f08fdd..1130381ca 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1899,6 +1899,9 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
>         current->kretprobe_instances.first = node->next;
>         node->next = NULL;
>
> +       /* Kretprobe handler expects address is the real return address */
> +       instruction_pointer_set(regs, (unsigned long)correct_ret_addr);
> +
>         /* Run them..  */
>         while (first) {
>                 ri = container_of(first, struct kretprobe_instance, llist);
> --
> 2.20.1
>
