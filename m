Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CCF59A87F
	for <lists+bpf@lfdr.de>; Sat, 20 Aug 2022 00:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241491AbiHSWW0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 18:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbiHSWWY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 18:22:24 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF57E10E792
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 15:22:23 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z13so2966465ilq.9
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 15:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5SOE9sy8P4yhAnQX1DvTkOl8AAQBdpmOV8I/crXpCEU=;
        b=kxFie1ySDa5yoZorl0KsS5IlzarYii6sLei9cixYPth7HX/iAousZy2E7iRCjeQdqu
         /ull+PTzCLsva/D+Ar05KQEybwCI/WHhDQrUmFh9ssT5LUy0nXBXZD3NPKpYlm070Aul
         m9spjPpqxfuHTMED5y7daZ0hHCI38/fnsXMPSBsXI2z11OG+OraSrWDeCsB+Qdi89ZvC
         XRxtC9vhBG4He6TggmJf19APXd4qiglQ5x1CtKrnSn/Ol2X/jA/l52LDMrUIcpbH5lGO
         erWRLI5fAGgpwaWSHuhFaap+jJNB2zPCi6s2EGBO1l0DIRtBKQ2y3oPPt53pqhs8aKSz
         /TRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5SOE9sy8P4yhAnQX1DvTkOl8AAQBdpmOV8I/crXpCEU=;
        b=bRqaPd6dgsJwxwJLp8UpH6xe5eL4x+D7zKbgKm5cYNdlJI5aKDw+qTebzAod8jYuBi
         KitYxCOxRpH6wXnZENg4hjpdgsWi9p8AGschJTgEiLgSpNbjMI0rwy57a+7ctZ//jVBO
         uX76iiwr2V73B8bbBh5DsC++WCYNoNzI82eNiIlyHDO3ibqKnw80Pi0Dp2JIb4PpDbE6
         i5S03b7iAZYc23ts2n6ebictIbZ+1OwUSmkEKgTgPemKIrkjYMu9nv79Pxhnnpf4ERgq
         V5yUlbtUPUknqXtpKlCkrjcGe1R4/IAiZ+lM/2fLE8/ColSWAzAaLLJA7PX+FnW/7T0F
         iXnA==
X-Gm-Message-State: ACgBeo2tr9o6Al5UnYb390compLoXZI1wPwnF/mnan9iExzaMdiS0LQT
        gK1ssi6B+FusbFS9e7CRkpftxZopH8QNPxCL/Gs=
X-Google-Smtp-Source: AA6agR6lANax76K/CB0G6hxraxR9GmpX3eQUoFFF3VLdHLjhr7IkWMr3s0gUttvlfeTXUnVMnjW3roklWYKgo798Rws=
X-Received: by 2002:a05:6e02:1c04:b0:2df:6b58:5fe8 with SMTP id
 l4-20020a056e021c0400b002df6b585fe8mr4787926ilh.68.1660947742975; Fri, 19 Aug
 2022 15:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com> <20220819214232.18784-14-alexei.starovoitov@gmail.com>
In-Reply-To: <20220819214232.18784-14-alexei.starovoitov@gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sat, 20 Aug 2022 00:21:46 +0200
Message-ID: <CAP01T75MUMKzacdE+AcKqgXy1jA5FyMwKXxiibD0ML3OFSqvsw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 13/15] bpf: Prepare bpf_mem_alloc to be used
 by sleepable bpf programs.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 19 Aug 2022 at 23:43, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
> Then use call_rcu() to wait for normal progs to finish
> and finally do free_one() on each element when freeing objects
> into global memory pool.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

I fear this can make OOM issues very easy to run into, because one
sleepable prog that sleeps for a long period of time can hold the
freeing of elements from another sleepable prog which either does not
sleep often or sleeps for a very short period of time, and has a high
update frequency. I'm mostly worried that unrelated sleepable programs
not even using the same map will begin to affect each other.

Have you considered other options? E.g. we could directly expose
bpf_rcu_read_lock/bpf_rcu_read_unlock to the program and enforce that
access to RCU protected map lookups only happens in such read
sections, and unlock invalidates all RCU protected pointers? Sleepable
helpers can then not be invoked inside the BPF RCU read section. The
program uses RCU read section while accessing such maps, and sleeps
after doing bpf_rcu_read_unlock. They can be kfuncs.

It might also be useful in general, to access RCU protected data from
sleepable programs (i.e. make some sections of the program RCU
protected and non-sleepable at runtime). It will allow use of elements
from dynamically allocated maps with bpf_mem_alloc while not having to
wait for RCU tasks trace grace period, which can extend into minutes
(or even longer if unlucky).

One difference would be that you can pin a lookup across a sleep cycle
with this approach, but not with preallocated maps or the explicit RCU
section above, but I'm not sure it's worth it. It isn't possible now.

>  kernel/bpf/memalloc.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 9e5ad7dc4dc7..d34383dc12d9 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -224,6 +224,13 @@ static void __free_rcu(struct rcu_head *head)
>         atomic_set(&c->call_rcu_in_progress, 0);
>  }
>
> +static void __free_rcu_tasks_trace(struct rcu_head *head)
> +{
> +       struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
> +
> +       call_rcu(&c->rcu, __free_rcu);
> +}
> +
>  static void enque_to_free(struct bpf_mem_cache *c, void *obj)
>  {
>         struct llist_node *llnode = obj;
> @@ -249,7 +256,11 @@ static void do_call_rcu(struct bpf_mem_cache *c)
>                  * from __free_rcu() and from drain_mem_cache().
>                  */
>                 __llist_add(llnode, &c->waiting_for_gp);
> -       call_rcu(&c->rcu, __free_rcu);
> +       /* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
> +        * Then use call_rcu() to wait for normal progs to finish
> +        * and finally do free_one() on each element.
> +        */
> +       call_rcu_tasks_trace(&c->rcu, __free_rcu_tasks_trace);
>  }
>
>  static void free_bulk(struct bpf_mem_cache *c)
> @@ -452,6 +463,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>                 /* c->waiting_for_gp list was drained, but __free_rcu might
>                  * still execute. Wait for it now before we free 'c'.
>                  */
> +               rcu_barrier_tasks_trace();
>                 rcu_barrier();
>                 free_percpu(ma->cache);
>                 ma->cache = NULL;
> --
> 2.30.2
>
