Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3F5B11AA
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 02:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiIHAzm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 20:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiIHAzl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:55:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E627FF81;
        Wed,  7 Sep 2022 17:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 102BFB81F7A;
        Thu,  8 Sep 2022 00:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC353C4347C;
        Thu,  8 Sep 2022 00:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662598537;
        bh=oWOQMuF0fu29N9MYafmfLCSJJq8JuhP7Lxs8zRfFPco=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uK222bEzWbonujXrMTvz2FA1iBufJNaXgcWscDOyWHIOALV4eveN6pt7x3O3/kd0n
         95l2v5fEj4qkCObS3M1zrSQpnnI9QvifeFxrfdA+2ks0BbXsFoF1/xegJKpJpJVzpQ
         xeGr4s5HZCpfe0cY7IwvdwPYISMA30WkH8Ml2BOLLMZMyP1XpumwxlzdUzJhgQgoNQ
         hxNtRkt9KhNEcRsyMoq6ZMU8CBvnBW03ttfLTrkC7iqsqb6rg0fbe/3YluuV7aIzGZ
         FO/W5W8dzXm/cIUwwxZ+IJkBguJaYf2fzwLK2trAtNJKQXUXXgAyYhfmMl9j91dbc0
         FB03E3SCcXb1w==
Received: by mail-wr1-f41.google.com with SMTP id b17so9954391wrq.3;
        Wed, 07 Sep 2022 17:55:37 -0700 (PDT)
X-Gm-Message-State: ACgBeo1qci31TNLgYgiPEDkeuQJQdeCnvbx5jgCKtav57JMPydQbPnK6
        T03wmQn9XQDaU0PdnOmbjyJZkYOGO+c4AUzNijo=
X-Google-Smtp-Source: AA6agR4rrHRfoJI1h9ZXCDZbG2QhOIpL63vBNXHKwye0G+jLc60Mb2pN3QW8jMgz/9Vea161VqEjHyjnv4jSs5MIDyM=
X-Received: by 2002:a5d:6da2:0:b0:228:64cb:5333 with SMTP id
 u2-20020a5d6da2000000b0022864cb5333mr3324928wrs.428.1662598535876; Wed, 07
 Sep 2022 17:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220907155746.1750329-1-punit.agrawal@bytedance.com>
In-Reply-To: <20220907155746.1750329-1-punit.agrawal@bytedance.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 7 Sep 2022 17:55:23 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6+D0bfoPZdQ0j-NtCvgMED4YF-LyqXTQQHo+x7tw3yug@mail.gmail.com>
Message-ID: <CAPhsuW6+D0bfoPZdQ0j-NtCvgMED4YF-LyqXTQQHo+x7tw3yug@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Simplify code by using for_each_cpu_wrap()
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        zhoufeng.zf@bytedance.com, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 7, 2022 at 8:58 AM Punit Agrawal
<punit.agrawal@bytedance.com> wrote:
>
> In the percpu freelist code, it is a common pattern to iterate over
> the possible CPUs mask starting with the current CPU. The pattern is
> implemented using a hand rolled while loop with the loop variable
> increment being open-coded.
>
> Simplify the code by using for_each_cpu_wrap() helper to iterate over
> the possible cpus starting with the current CPU. As a result, some of
> the special-casing in the loop also gets simplified.
>
> No functional change intended.
>
> Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
> ---
> v1 -> v2:
> * Fixed the incorrect transformation changing semantics of __pcpu_freelist_push_nmi()
>
> Previous version -
> v1: https://lore.kernel.org/all/20220817130807.68279-1-punit.agrawal@bytedance.com/
>
>  kernel/bpf/percpu_freelist.c | 48 ++++++++++++------------------------
>  1 file changed, 16 insertions(+), 32 deletions(-)
>
> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
> index 00b874c8e889..b6e7f5c5b9ab 100644
> --- a/kernel/bpf/percpu_freelist.c
> +++ b/kernel/bpf/percpu_freelist.c
> @@ -58,23 +58,21 @@ static inline void ___pcpu_freelist_push_nmi(struct pcpu_freelist *s,
>  {
>         int cpu, orig_cpu;
>
> -       orig_cpu = cpu = raw_smp_processor_id();
> +       orig_cpu = raw_smp_processor_id();
>         while (1) {
> -               struct pcpu_freelist_head *head;
> +               for_each_cpu_wrap(cpu, cpu_possible_mask, orig_cpu) {
> +                       struct pcpu_freelist_head *head;
>
> -               head = per_cpu_ptr(s->freelist, cpu);
> -               if (raw_spin_trylock(&head->lock)) {
> -                       pcpu_freelist_push_node(head, node);
> -                       raw_spin_unlock(&head->lock);
> -                       return;
> +                       head = per_cpu_ptr(s->freelist, cpu);
> +                       if (raw_spin_trylock(&head->lock)) {
> +                               pcpu_freelist_push_node(head, node);
> +                               raw_spin_unlock(&head->lock);
> +                               return;
> +                       }
>                 }
> -               cpu = cpumask_next(cpu, cpu_possible_mask);
> -               if (cpu >= nr_cpu_ids)
> -                       cpu = 0;

I personally don't like nested loops here. Maybe we can keep
the original while loop and use cpumask_next_wrap()?

Thanks,
Song

>
>                 /* cannot lock any per cpu lock, try extralist */
> -               if (cpu == orig_cpu &&
> -                   pcpu_freelist_try_push_extra(s, node))
> +               if (pcpu_freelist_try_push_extra(s, node))
>                         return;
>         }
>  }
> @@ -125,13 +123,12 @@ static struct pcpu_freelist_node *___pcpu_freelist_pop(struct pcpu_freelist *s)
>  {
>         struct pcpu_freelist_head *head;
>         struct pcpu_freelist_node *node;
> -       int orig_cpu, cpu;
> +       int cpu;
>
> -       orig_cpu = cpu = raw_smp_processor_id();
> -       while (1) {
> +       for_each_cpu_wrap(cpu, cpu_possible_mask, raw_smp_processor_id()) {
>                 head = per_cpu_ptr(s->freelist, cpu);
>                 if (!READ_ONCE(head->first))
> -                       goto next_cpu;
> +                       continue;
>                 raw_spin_lock(&head->lock);
>                 node = head->first;
>                 if (node) {
> @@ -140,12 +137,6 @@ static struct pcpu_freelist_node *___pcpu_freelist_pop(struct pcpu_freelist *s)
>                         return node;
>                 }
>                 raw_spin_unlock(&head->lock);
> -next_cpu:
> -               cpu = cpumask_next(cpu, cpu_possible_mask);
> -               if (cpu >= nr_cpu_ids)
> -                       cpu = 0;
> -               if (cpu == orig_cpu)
> -                       break;
>         }
>
>         /* per cpu lists are all empty, try extralist */
> @@ -164,13 +155,12 @@ ___pcpu_freelist_pop_nmi(struct pcpu_freelist *s)
>  {
>         struct pcpu_freelist_head *head;
>         struct pcpu_freelist_node *node;
> -       int orig_cpu, cpu;
> +       int cpu;
>
> -       orig_cpu = cpu = raw_smp_processor_id();
> -       while (1) {
> +       for_each_cpu_wrap(cpu, cpu_possible_mask, raw_smp_processor_id()) {
>                 head = per_cpu_ptr(s->freelist, cpu);
>                 if (!READ_ONCE(head->first))
> -                       goto next_cpu;
> +                       continue;
>                 if (raw_spin_trylock(&head->lock)) {
>                         node = head->first;
>                         if (node) {
> @@ -180,12 +170,6 @@ ___pcpu_freelist_pop_nmi(struct pcpu_freelist *s)
>                         }
>                         raw_spin_unlock(&head->lock);
>                 }
> -next_cpu:
> -               cpu = cpumask_next(cpu, cpu_possible_mask);
> -               if (cpu >= nr_cpu_ids)
> -                       cpu = 0;
> -               if (cpu == orig_cpu)
> -                       break;
>         }
>
>         /* cannot pop from per cpu lists, try extralist */
> --
> 2.35.1
>
