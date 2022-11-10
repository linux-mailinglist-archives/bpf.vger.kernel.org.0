Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7C0623AC7
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 05:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiKJEGK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 23:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiKJEGI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 23:06:08 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365F720F48;
        Wed,  9 Nov 2022 20:06:03 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id t25so1944796ejb.8;
        Wed, 09 Nov 2022 20:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=broEoXdt1RORQBiw4E0W6sQ7sc1LDhrBYXkzX8MV7dU=;
        b=MhhL7AhcIH5JSSYX4/uG5eIFGmzaru4Q93jwmJ0PVtE+tpK7Dukwu19vxR6LMOu53T
         D77ijPWUyEuM5d9Y+CopZDWewNcBL3S8WXQFy5QHyGPmMktYW8epiJEtLmYh4axrOIBk
         tb21BOBMnQxcg6kCnJi1xUJiAdPoVu2QcIzl7/DXVvdYH2BDSdtAU6H25wTHEqN67pfT
         /xOoIslkTda50mnaWQcrG5kiVri/UT9ZNf5uecZ/rdgLKQfMWSanVHltdjVyIG1cprX0
         4r5LfSR+izL9SD8xG+0Np0WqgqNf64H8nFtfUXDPoklF4z1VRV/WBUMyiwqLrY1r6GMK
         dPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=broEoXdt1RORQBiw4E0W6sQ7sc1LDhrBYXkzX8MV7dU=;
        b=HMGwY7+lWwAbcQhQ8thBFXZt68UrxdUS9WTux4XC+4jIsIc1jJy/2ulCgDmIiuZleb
         W/Bn5MdHi3PYx+jZIPtLFMwXUk1P11uOFH2apSvboUBGa2Z2KQvJigMalarlPzkXr+nO
         YM+cFr204364AchkZAFpnx4emPNFk/cUWx8tQ+MnjMwqbpgn121lg+tntaJb3IctzlKK
         tRvzkdUdPrl58FWG11/YAmvFDmIUuzTf8iVeZrN13lFOfdjKkL2EdUcpHlUhay3+Jhm6
         aL39PJWQiYmRv81P6v+3rWbVG8W3AFuurPQWCstqzspKz5R2V5MuiNj1EtGdLIL/p1/s
         ZcEQ==
X-Gm-Message-State: ACrzQf2lVtudLzE3ylqkscM6zbO35TgzV5SisWNtEbT+RIHa+5ifujv4
        peaUlxtDixz93G2LD1OxTN0ILPPqWzZBlXsgIXI=
X-Google-Smtp-Source: AMsMyM5gfhKEeYJ+fDO/piTkRkzP3Md9j/DgxLolYJWk8S2r8lyNrfg00inpL/ulmvkymthXwIN3niwxx/3PShYB5k8=
X-Received: by 2002:a17:906:11d6:b0:7ad:fd3e:2a01 with SMTP id
 o22-20020a17090611d600b007adfd3e2a01mr39368145eja.545.1668053161605; Wed, 09
 Nov 2022 20:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20221110035039.54859-1-xukuohai@huawei.com>
In-Reply-To: <20221110035039.54859-1-xukuohai@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Nov 2022 20:05:49 -0800
Message-ID: <CAEf4BzYMExNVP353xUmkD=M7_QKDG8Ukm0T7D9aCZG=-GToiaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Initialize same number of free nodes for
 each pcpu_freelist
To:     Xu Kuohai <xukuohai@huawei.com>
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

On Wed, Nov 9, 2022 at 7:33 PM Xu Kuohai <xukuohai@huawei.com> wrote:
>
> pcpu_freelist_populate() initializes nr_elems / num_possible_cpus() + 1
> free nodes for some CPUs, and then possibly one CPU with fewer nodes,
> followed by remaining cpus with 0 nodes. For example, when nr_elems == 256
> and num_possible_cpus() == 32, CPU 0~27 each gets 9 free nodes, CPU 28 gets
> 4 free nodes, CPU 29~31 get 0 free nodes, while in fact each CPU should get
> 8 nodes equally.
>
> This patch initializes nr_elems / num_possible_cpus() free nodes for each
> CPU firstly, then allocates the remaining free nodes by one for each CPU
> until no free nodes left.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
> v3: Simplify code as suggested by Andrii
> v2: Update commit message and add Yonghong's ack
> ---
>  kernel/bpf/percpu_freelist.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
> index b6e7f5c5b9ab..bd60070c079f 100644
> --- a/kernel/bpf/percpu_freelist.c
> +++ b/kernel/bpf/percpu_freelist.c
> @@ -100,22 +100,23 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
>                             u32 nr_elems)
>  {
>         struct pcpu_freelist_head *head;
> -       int i, cpu, pcpu_entries;
> +       unsigned int cpu, cpu_idx, i, j, n, m;
>
> -       pcpu_entries = nr_elems / num_possible_cpus() + 1;
> -       i = 0;
> +       n = nr_elems / num_possible_cpus();
> +       m = nr_elems % num_possible_cpus();
> +
> +       cpu_idx = 0;
>
>         for_each_possible_cpu(cpu) {
> -again:
> -               head = per_cpu_ptr(s->freelist, cpu);
> -               /* No locking required as this is not visible yet. */
> -               pcpu_freelist_push_node(head, buf);
> -               i++;
> -               buf += elem_size;
> -               if (i == nr_elems)
> -                       break;
> -               if (i % pcpu_entries)
> -                       goto again;
> +               j = min(n + (cpu_idx < m ? 1 : 0), nr_elems);

why the min() here?

> +               for (i = 0; i < j; i++) {
> +                       head = per_cpu_ptr(s->freelist, cpu);
> +                       /* No locking required as this is not visible yet. */
> +                       pcpu_freelist_push_node(head, buf);
> +                       buf += elem_size;
> +               }
> +               nr_elems -= j;
> +               cpu_idx++;
>         }
>  }
>
> --
> 2.30.2
>
