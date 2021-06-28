Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA273B5A97
	for <lists+bpf@lfdr.de>; Mon, 28 Jun 2021 10:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhF1Ipu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Jun 2021 04:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbhF1Ipt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Jun 2021 04:45:49 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCE4C061787
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 01:43:23 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id f13so6866855qtb.6
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 01:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+G0aFIa+dKIdQGhhAX7TYqH/nk+PfE3E5edNbclxiZM=;
        b=SnecMWl5iR/bF/bsX0hSkvINZEErBldRKMwqj/t01OhZmr/rUI6aWOgdV2Z63oUgM8
         6pqllFAquDXwhOQfUujcnQXr2Vdt/TS3VRqpGQQPXN39+8ZaFdMt+w6j7XAiAv7kkBKF
         MkImyUeZ8SQcIaj50jvgoPeP+PjxLMw18cHaiGzDDHYp7DkDVtrgn9+Q5TdbukBrXTEj
         wHo4sHoFMFroy4QnXleLwU4bn4lUpYGQKiJyfeTI9OHRFnv4nno16WIDeej7Bhm6OgYY
         JNPI/h25UQu0S8vBO8Snj9ZCwWPrND4i+29JHGnz0A2KJsTCYh9ntV1ES2Wy3CYa4Gh7
         RqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+G0aFIa+dKIdQGhhAX7TYqH/nk+PfE3E5edNbclxiZM=;
        b=AUiVWYAGZgtm4Ga0QPLU3HdC+7tpoVp14AikR2gpkB3BaRlV7Jp3KxZ4AZtzZ5AmCn
         M6bpyD12daXaISi2u4Fn1C3V61AjUOTpptVxECwOsRYJ9Tie1iNq4+jMV7C4oJAECkyD
         BDnc3MwDnDw52bh81b/k8VIp3iNdT5arncnM+uJeu/tYyYQtqqGp8ntG6JcJFGk3xvbY
         wp14HXP50P2HcgGpVi5HS1m3D4IzaYm+kMKhmwGuIBcblMslqRt9UPUTVCDwONlLspjq
         V1fkqfQG5DS451LhZnZJ5F8KDVNXflDUb16ZFNaYYGd9U2CWbO5TmaMML38BOaCG/FRU
         0EMA==
X-Gm-Message-State: AOAM532elfy7AIcF/m517V0wQ8zPnhY9473yN425xFltOgFhRcS6T+5M
        ECFBY3Hl6T9C//+0/kez0zlyR5vIAIQjAuztQKVd8dqz79pFRg==
X-Google-Smtp-Source: ABdhPJxVs9ovjQ9jj3UPUGVpqeS8rM0QoHg1qqvU59gg0Usr9RQl2QZjr4tMZakv7PIzKG8ZKBTB8VWWRxLoV12CKEw=
X-Received: by 2002:ac8:1090:: with SMTP id a16mr20368058qtj.290.1624869796278;
 Mon, 28 Jun 2021 01:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f034fc05c2da6617@google.com> <000000000000cac82d05c5214992@google.com>
 <20210621224119.GW4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210621224119.GW4397@paulmck-ThinkPad-P17-Gen-1>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 28 Jun 2021 10:43:04 +0200
Message-ID: <CACT4Y+bL26nyHU5Tc4SV7AepPYSt_YZVfhLEMaLncZ2+-OyFCg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in check_all_holdout_tasks_trace
To:     paulmck@kernel.org
Cc:     syzbot <syzbot+7b2b13f4943374609532@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org,
        axboe@kernel.dk, bpf@vger.kernel.org, christian@brauner.io,
        coreteam@netfilter.org, daniel@iogearbox.net, davem@davemloft.net,
        dsahern@kernel.org, fw@strlen.de, jiangshanlai@gmail.com,
        joel@joelfernandes.org, john.fastabend@gmail.com,
        josh@joshtriplett.org, kadlec@netfilter.org, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        mathieu.desnoyers@efficios.com, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        peterz@infradead.org, rcu@vger.kernel.org, rostedt@goodmis.org,
        shakeelb@google.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yanfei.xu@windriver.com,
        yhs@fb.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 22, 2021 at 12:41 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sat, Jun 19, 2021 at 09:54:06AM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit f9006acc8dfe59e25aa75729728ac57a8d84fc32
> > Author: Florian Westphal <fw@strlen.de>
> > Date:   Wed Apr 21 07:51:08 2021 +0000
> >
> >     netfilter: arp_tables: pass table pointer via nf_hook_ops
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10dceae8300000
> > start commit:   0c38740c selftests/bpf: Fix ringbuf test fetching map FD
> > git tree:       bpf-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=12dceae8300000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14dceae8300000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a6380da8984033f1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7b2b13f4943374609532
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1264c2d7d00000
> >
> > Reported-by: syzbot+7b2b13f4943374609532@syzkaller.appspotmail.com
> > Fixes: f9006acc8dfe ("netfilter: arp_tables: pass table pointer via nf_hook_ops")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> I am not seeing any mention of check_all_holdout_tasks_trace() in
> the console output, but I again suggest the following two patches:
>
> 6a04a59eacbd ("rcu-tasks: Don't delete holdouts within trc_inspect_reader()"
> dd5da0a9140e ("rcu-tasks: Don't delete holdouts within trc_wait_for_one_reader()")

Let's tell syzbot about these fixes, then it will tell us if they help or not.

#syz fix: rcu-tasks: Don't delete holdouts within trc_inspect_reader()
