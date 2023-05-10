Return-Path: <bpf+bounces-278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8336FD806
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 09:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4B2280F2A
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 07:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA186129;
	Wed, 10 May 2023 07:19:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1CA814
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 07:19:34 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0CC5FD4
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 00:19:32 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50db7f0a1b4so2761184a12.3
        for <bpf@vger.kernel.org>; Wed, 10 May 2023 00:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683703171; x=1686295171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qUE3wLjg1jKrBHNudNXU4bD0xMxdjrrSu+UQ9MyWMg=;
        b=UQa5aMuEw2rp5MbyMKCzXo56z/iWovBO7eRyRHaE56t3njS6i8iRKDF9pK34yQh7MA
         9k87EVhC4xn8vUzcWszOY4gVb2kSaL6iT52P2Plsxl/21pt/7tcHgb4XZI5Yp4B/cmyr
         zDTjuEb2eyJ2vnPabNZMmF6VsfAKAL+UnK3EmQhPjAk8aQfQNZgmwNNHE+I5wNdAqX0F
         VefYNfUuuH0j2P87BxyOzw9MA5t5dkB3ZSqebxrtleNzDLmiQI87nUaUZ03NayRWkAIY
         QzL9NDSRbs6M9/G0a7Jbg8Hq0RLNj4SStvzujTLqLmJ+16DQz5aEOQjuCrPWiFGHIRx4
         MO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683703171; x=1686295171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qUE3wLjg1jKrBHNudNXU4bD0xMxdjrrSu+UQ9MyWMg=;
        b=UdQaez7aexCPQ61+Bs90EbhG41yncxz/9Lvt+kpmPAyJ/D1XsnTeu6wiP1zCdNIHIY
         T/6tQWcR6w/q38Qp5Jp6AI+p96fs8ysP1YfwnSgrMy1t0Ua6oj4ikxJDZxWqWbBXmKl3
         5xQabj7GNq50ppuxF3aRBoWMhoNB1Pj9ovc8Nz4GntSVjQJNC0QNlB1wJqxCbYuHkjRS
         oWaZW32yLJICmtgekWH7KaPszAnRKKssjZJrZAJzftVjZNi+wtIxvjO6RQTnUa1uWcoR
         Vl7EMZufyQF5A2KCcrBKcHynjxu921DUA1pJ8BBli5xBEzVlLfBYi9kzAHbth5vR8ZZm
         9h1A==
X-Gm-Message-State: AC+VfDzTGw3YeY/Pw5hbX3JcXcjMVZ78D1UGirLjlx9QFnVrrP9gCWO0
	YvGrExCXAjIqhoowpfcg6eOEEZ4NIlFcBxhvWmQ=
X-Google-Smtp-Source: ACHHUZ7E9uXGMrNmuX4FNh97rAr4ummqWtaDvph7eme+28V/Az/aW/IjxjIOIMf79mSMX8ju1tNoCDS9vaghX+/EVjA=
X-Received: by 2002:a05:6402:641:b0:50c:161b:9152 with SMTP id
 u1-20020a056402064100b0050c161b9152mr13227041edx.13.1683703170723; Wed, 10
 May 2023 00:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509132433.2FSY_6t7@linutronix.de>
In-Reply-To: <20230509132433.2FSY_6t7@linutronix.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 May 2023 00:19:18 -0700
Message-ID: <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
Subject: Re: [RFC PATCH] bpf: Remove in_atomic() from bpf_link_put().
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 9, 2023 at 6:24=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> bpf_free_inode() is invoked as a RCU callback. Usually RCU callbacks are
> invoked within softirq context. By setting rcutree.use_softirq=3D0 boot
> option the RCU callbacks will be invoked in a per-CPU kthread with
> bottom halves disabled which implies a RCU read section.
>
> On PREEMPT_RT the context remains fully preemptible. The RCU read
> section however does not allow schedule() invocation. The latter happens
> in mutex_lock() performed by bpf_trampoline_unlink_prog() originated
> from bpf_link_put().
>
> Remove the context checks and use the workqueue unconditionally.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Please see [0] and corresponding revert commit. We do want
bpf_link_free() to happen synchronously if it's caused by close()
syscall.

f00f2f7fe860 ("Revert "bpf: Fix potential call bpf_link_free() in
atomic context"")

  [0] https://lore.kernel.org/bpf/CAEf4BzZ9zwA=3DSrLTx9JT50OeM6fVPg0Py0Gx+K=
9ah2we8YtCRA@mail.gmail.com/

> The warning can be observed as:
> | BUG: sleeping function called from invalid context at kernel/locking/rt=
mutex_api.c:510
> | in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 47, name: rcuc/3
> | preempt_count: 0, expected: 0
> | RCU nest depth: 2, expected: 0
> | CPU: 3 PID: 47 Comm: rcuc/3 Tainted: G            E      v6.3-rt12 #1
> | Hardware name: Supermicro X9SCL/X9SCM/X9SCL/X9SCM, BIOS 2.3a 01/06/2021
> | Call Trace:
> |  <TASK>
> |  dump_stack_lvl+0x43/0x60
> |  __might_resched+0x137/0x190
> |  mutex_lock+0x1a/0x50
> |  bpf_trampoline_unlink_prog+0x1b/0x100
> |  bpf_tracing_link_release+0x12/0x40
> |  bpf_link_free+0x70/0x90
> |  bpf_free_inode+0x3e/0x80
> |  rcu_core+0x4ff/0x7c0
> |  rcu_cpu_kthread+0xa9/0x2f0
> |  smpboot_thread_fn+0x141/0x2c0
> |  kthread+0x110/0x130
> |  ret_from_fork+0x2c/0x50
> |  </TASK>
>
>  kernel/bpf/syscall.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 14f39c1e573ee..0adaa1bfbb0d2 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2785,12 +2785,8 @@ void bpf_link_put(struct bpf_link *link)
>         if (!atomic64_dec_and_test(&link->refcnt))
>                 return;
>
> -       if (in_atomic()) {
> -               INIT_WORK(&link->work, bpf_link_put_deferred);
> -               schedule_work(&link->work);
> -       } else {
> -               bpf_link_free(link);
> -       }
> +       INIT_WORK(&link->work, bpf_link_put_deferred);
> +       schedule_work(&link->work);
>  }
>  EXPORT_SYMBOL(bpf_link_put);
>
> --
> 2.40.1
>
>

