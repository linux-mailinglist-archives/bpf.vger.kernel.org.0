Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59E3239F48
	for <lists+bpf@lfdr.de>; Mon,  3 Aug 2020 07:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgHCFrC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Aug 2020 01:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgHCFrB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Aug 2020 01:47:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C696C061756
        for <bpf@vger.kernel.org>; Sun,  2 Aug 2020 22:47:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so19296731pgf.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2020 22:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LUoVXyVVEWCpsFCdc6rGrsu4kV/3OpzpyyawtVzuow=;
        b=hdjtIF9vJ2dw4QSSP/DbD+fPExxwh/ApfVuiThIaXdUmU//fR7g+W14RfyvLhc+3j/
         mGtedAY+gn/q+ZdDQyOw3sW1zQmezff0bi5tLcGb13h3XPiCgzX4+hqWyDxl9wEnzl5a
         T0oL0sZXuetxfRxYDlmKdHQVRXiwQZQo78/GS0LGdvAtm9tdlJc8PFgl0NXw4JTV9Z1h
         Tp3pCUGnIyvcZd7MzneczaqfeErhA+iMke1riq+KuUeqSfwrdScPpXubG6ngdhVs+bnZ
         yoMk6Aa9c8sW+2hE48HAue75CnmgvkraARPffqib4B532Ls6ZVykQRvf9sMt2gPnUKw5
         h2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LUoVXyVVEWCpsFCdc6rGrsu4kV/3OpzpyyawtVzuow=;
        b=tkla4Bd3d6zmT6WUD1Fa/Rbxp92pw2u2eUlAIMz7Visw+M+M/IuzwBX32brxhmgzJp
         xERiRx5xDvp6QcMICtmFYF2XlAh7rvimCskEnqABz+vZrEYvKSu60Ruz4jcG1fk9OC7X
         KyQeqRYGlXU8+9MCHSP3snozkzikbp75E6E0XFY9Vy0VNlNYiq9BT1vHlF7T5hBOJ3pN
         niSA1/hxl+RoaxiWfUbz6hAj8RcUnT0Xhw28u1VKPYH3l179LiiYwROWNEmro7tra5Fc
         84MEYRm0mMWzCQSlJ6HNnyUd06KepnE2dW/k5AvldcWlYfesFl+KNIl6ph5XJODBdhjC
         VF8A==
X-Gm-Message-State: AOAM530lqVqvFueIt96IhoyzJcUuYgX4I4ARHtQjl5ru6IhFUU/E6mrO
        KvCLyc/qz+hP7ESGUH9WBz72JbKKQqdI9/9NGzWepQ==
X-Google-Smtp-Source: ABdhPJx27XgkopsCh611bXq2RzCmC+aDDdS6Ml1tYiXoPLZHYb0kW+doJ37XxtaM0zQmEXLFv040MCUCRz0HtCsDJC4=
X-Received: by 2002:a63:cf49:: with SMTP id b9mr13081433pgj.31.1596433620838;
 Sun, 02 Aug 2020 22:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200728064536.24405-1-songmuchun@bytedance.com>
In-Reply-To: <20200728064536.24405-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 3 Aug 2020 13:46:25 +0800
Message-ID: <CAMZfGtUDmQgDySu7OSBNYv5y2_QJfzDcVeYG2eY6-1xYq+t1Uw@mail.gmail.com>
Subject: Re: [PATCH] kprobes: fix NULL pointer dereference at kprobe_ftrace_handler
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org
Cc:     LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ping guys. Any comments or suggestions?

On Tue, Jul 28, 2020 at 2:45 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> We found a case of kernel panic on our server. The stack trace is as
> follows(omit some irrelevant information):
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000080
>   RIP: 0010:kprobe_ftrace_handler+0x5e/0xe0
>   RSP: 0018:ffffb512c6550998 EFLAGS: 00010282
>   RAX: 0000000000000000 RBX: ffff8e9d16eea018 RCX: 0000000000000000
>   RDX: ffffffffbe1179c0 RSI: ffffffffc0535564 RDI: ffffffffc0534ec0
>   RBP: ffffffffc0534ec1 R08: ffff8e9d1bbb0f00 R09: 0000000000000004
>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>   R13: ffff8e9d1f797060 R14: 000000000000bacc R15: ffff8e9ce13eca00
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000080 CR3: 00000008453d0005 CR4: 00000000003606e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    <IRQ>
>    ftrace_ops_assist_func+0x56/0xe0
>    ftrace_call+0x5/0x34
>    tcpa_statistic_send+0x5/0x130 [ttcp_engine]
>
> The tcpa_statistic_send is the function being kprobed. After analysis,
> the root cause is that the fourth parameter regs of kprobe_ftrace_handler
> is NULL. Why regs is NULL? We use the crash tool to analyze the kdump.
>
>   crash> dis tcpa_statistic_send -r
>          <tcpa_statistic_send>: callq 0xffffffffbd8018c0 <ftrace_caller>
>
> The tcpa_statistic_send calls ftrace_caller instead of ftrace_regs_caller.
> So it is reasonable that the fourth parameter regs of kprobe_ftrace_handler
> is NULL. In theory, we should call the ftrace_regs_caller instead of the
> ftrace_caller. After in-depth analysis, we found a reproducible path.
>
>   Writing a simple kernel module which starts a periodic timer. The
>   timer's handler is named 'kprobe_test_timer_handler'. The module
>   name is kprobe_test.ko.
>
>   1) insmod kprobe_test.ko
>   2) bpftrace -e 'kretprobe:kprobe_test_timer_handler {}'
>   3) echo 0 > /proc/sys/kernel/ftrace_enabled
>   4) rmmod kprobe_test
>   5) stop step 2) kprobe
>   6) insmod kprobe_test.ko
>   7) bpftrace -e 'kretprobe:kprobe_test_timer_handler {}'
>
> We mark the kprobe as GONE but not disarm the kprobe in the step 4).
> The step 5) also do not disarm the kprobe when unregister kprobe. So
> we do not remove the ip from the filter. In this case, when the module
> loads again in the step 6), we will replace the code to ftrace_caller
> via the ftrace_module_enable(). When we register kprobe again, we will
> not replace ftrace_caller to ftrace_regs_caller because the ftrace is
> disabled in the step 3). So the step 7) will trigger kernel panic. Fix
> this problem by disarming the kprobe when the module is going away.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/kprobes.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 146c648eb943..503add629599 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2148,6 +2148,13 @@ static void kill_kprobe(struct kprobe *p)
>          * the original probed function (which will be freed soon) any more.
>          */
>         arch_remove_kprobe(p);
> +
> +       /*
> +        * The module is going away. We should disarm the kprobe which
> +        * is using ftrace.
> +        */
> +       if (kprobe_ftrace(p))
> +               disarm_kprobe_ftrace(p);
>  }
>
>  /* Disable one kprobe */
> --
> 2.11.0
>


-- 
Yours,
Muchun
