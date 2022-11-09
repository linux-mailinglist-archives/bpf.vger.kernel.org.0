Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4546237CF
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 00:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKIX4l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 18:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKIX4k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 18:56:40 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A907248C8;
        Wed,  9 Nov 2022 15:56:39 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id f27so1062428eje.1;
        Wed, 09 Nov 2022 15:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X8ZabQXw9a7xVIqLfVqjSQX/8s7xHM951Bj29jk3yjQ=;
        b=g8fuL8nkbAwDlqEh7qSgybKdAU5JtJJRJps3oMeDKEbgVazR6rNnI2X2336gWjetZe
         +ZPCnPwWyPG+vzFoSfW9OUdEtqsOJ2WNNsJXSHqJveu2lnJaPcr2olcIqbCN/ZEHGHov
         YDhOmiVC+xpvQj1jWyPlHdXEiu95o+CwFbIQWp6PhzoufwmZgmswTKlAYIRHOVC/hj8y
         K3jokp9c7pFnSuOOjf8y+OeBqGF02avaEeAoKMyAcslfR4ju+SNL3ccAGs5sT6UsKf2H
         Ju7ecOfgQzWC3to3zmQZzsirtGwzNnInPj6PsO+op/Y8uidHFhucW1Q1Nj7fsgnpgCSU
         T+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8ZabQXw9a7xVIqLfVqjSQX/8s7xHM951Bj29jk3yjQ=;
        b=PZkpLQB1ZlD0dnuwFX3rbUuAn+U4Fd4beYEgJjsupnkbCuEaJu1MQDRLt5vHo2TOVS
         +udU6EDLB1sl/z0y2rrQskkkVUlUfXB9vakjLRzlNgO4FVP6wgynDvnYGp/egqTriOJO
         7MNU8OUYgolx0o7Wel4tZofGHKwm9+fl6ETsLU31T+7i4OxPx8e38okjZoHlGcphQ9hj
         UlpgxwtWhAvktf8SEwOcQLcIwn8wNsMDhr/0EMl0LiHfbpSMsEpncagY9UpKrQwyJcHG
         5BZXt2PTcIhdYKMRaqL4p3/2Ns1ntPO83X43m8N2Pp1Ql6d6BeG7bXU1Xk9V1OoFohhJ
         TLng==
X-Gm-Message-State: ANoB5pn6TDArLi+KMoe022wSyQkc8JPEkbRNzvDOi2B0Dk2W7dbwTcHG
        DomAQaaD2I+ec/Tcm5Oeems0LnDaK0bAflKBwlk=
X-Google-Smtp-Source: AA0mqf6zq6H3aJHxtLvSF5RR6sfEC6PrC4fozPDi2eYgM0lPn7OrTwK2Toc2ZWPBv29HbpL+Vco3XhuMKm755Di25is=
X-Received: by 2002:a17:906:4e86:b0:7ae:8d01:81f8 with SMTP id
 v6-20020a1709064e8600b007ae8d0181f8mr4103711eju.115.1668038197930; Wed, 09
 Nov 2022 15:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20221108142207.4079521-1-xukuohai@huaweicloud.com>
In-Reply-To: <20221108142207.4079521-1-xukuohai@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Nov 2022 15:56:26 -0800
Message-ID: <CAEf4BzYjkP_xjaEErXwe5mG9pV+HQHKwY3hTamKH6zQTZrobLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Initialize same number of free nodes for
 each pcpu_freelist
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 8, 2022 at 6:05 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> pcpu_freelist_populate() initializes nr_elems / num_possible_cpus() + 1
> free nodes for some CPUs, and then possibly one CPU with fewer nodes,
> followed by remaining cpus with 0 nodes. For example, when nr_elems == 256
> and num_possible_cpus() == 32, if CPU 0 is the current cpu, CPU 0~27
> each gets 9 free nodes, CPU 28 gets 4 free nodes, CPU 29~31 get 0 free
> nodes, while in fact each CPU should get 8 nodes equally.
>
> This patch initializes nr_elems / num_possible_cpus() free nodes for each
> CPU firstly, then allocates the remaining free nodes by one for each CPU
> until no free nodes left.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
> v2: Update commit message and add Yonghong's ack
> ---
>  kernel/bpf/percpu_freelist.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
> index b6e7f5c5b9ab..89e84f7381cc 100644
> --- a/kernel/bpf/percpu_freelist.c
> +++ b/kernel/bpf/percpu_freelist.c
> @@ -100,12 +100,15 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
>                             u32 nr_elems)
>  {
>         struct pcpu_freelist_head *head;
> -       int i, cpu, pcpu_entries;
> +       int i, cpu, pcpu_entries, remain_entries;
> +
> +       pcpu_entries = nr_elems / num_possible_cpus();
> +       remain_entries = nr_elems % num_possible_cpus();
>
> -       pcpu_entries = nr_elems / num_possible_cpus() + 1;
>         i = 0;
>
>         for_each_possible_cpu(cpu) {
> +               int j = i + pcpu_entries + (remain_entries-- > 0 ? 1 : 0);
>  again:
>                 head = per_cpu_ptr(s->freelist, cpu);
>                 /* No locking required as this is not visible yet. */
> @@ -114,7 +117,7 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
>                 buf += elem_size;
>                 if (i == nr_elems)
>                         break;
> -               if (i % pcpu_entries)
> +               if (i < j)
>                         goto again;
>         }

this loop's logic is quite hard to follow, if we are fixing it, can we
simplify it maybe? something like:

int cpu, cpu_idx, i, j, n, m;

n = nr_elems / num_possible_cpus();
m = nr_elems % num_possible_cpus();

for_each_possible_cpu(cpu) {
    i = n + (cpu_idx < m ? 1 : 0);
    for (j = 0; j < i; j++) {
        head = per_cpu_ptr(s->freelist, cpu);
        pcpu_freelist_push_node(head, buf);
        buf += elem_size;
    }
    cpu_idx++;
}


no gotos, no extra ifs: for each cpu we determine correct number of
elements to allocate, then just allocate them in a straightforward
loop

>  }
> --
> 2.30.2
>
