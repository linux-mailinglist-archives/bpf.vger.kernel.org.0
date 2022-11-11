Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0562C62630A
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 21:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiKKUjZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 15:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiKKUjY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 15:39:24 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4EE845FF;
        Fri, 11 Nov 2022 12:39:22 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id t25so15114507ejb.8;
        Fri, 11 Nov 2022 12:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6mZywrIT4mxmQPRJhWF4x6aKBO4TsB+l1a8Gch2fYws=;
        b=IJR+sFHwMtnnLwEy1psWwD6SaMqnQsfL0KVFDoFLWI/lOGM7FU/18/o0BSKzLaGI5Y
         PDCssb++BiAPpxDS9t9dmwVBkZ5wBXigWX8Lip0x7T5qf/kZvnb9LPqL97wE4nqGIhqK
         tl9pSOyo9eh4c9ztiEFmsjfskEC2Vl5FqcW6X1s9Yboabx0/zq4eeFzkesbh4fzRqSYY
         wywFS2orQPhJsXe7kWyrGZ8LiQksGqy9BlfOTihEz8ix7UkpmXJDfHEIWq3DV8vDdBEW
         +yDHTliPh/yBQuB4uCRoolbEh+ClV+pz/vmxOUnPm0nKkymZjs6IBD9FxPGqHkc4PoN1
         bs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mZywrIT4mxmQPRJhWF4x6aKBO4TsB+l1a8Gch2fYws=;
        b=AU6MeswDQhC0VH3AckQggT3EvehauUxyWRXeYpMm7woeSqCxKrtnOFyhGvBMrhyPjs
         OxkGVKvhTYpmaDThvPtm0Dp2yonrxXEWWKXFMYapjimuWlSPPAi93pHD80i+ua1Ur1xK
         ez1C6Xr4KuKFA4ki4DrDmJcaI1W1TpwCPwML4+QmbC/AEYTtzVwroHWe7G+plc9CZkWd
         /nqmRh1sFhYBAOkO8PzS4r4HIjtpjqhWTIs2OJXWT0pKq2T/k91/M7sXp/7K1fuLCQXo
         j3RXiSFPiUl420Mv4/58p5GojpvYCvOYSvy+7gK+jKhqTG9GndeZwoWax9UVYVNy4HDx
         38yg==
X-Gm-Message-State: ANoB5pnmtXiu3Pp+vdzftqCa86ccHflnrNudeHbEczml/ZBD6bTfB0YG
        qwrDs6KDSE/LKpkAmjY9G7EDJB2wuesSVx8b5hw=
X-Google-Smtp-Source: AA0mqf5Az7IKLeiNL0xVNmNbN+DON6QSJc6EuuTMxoTfXCRDN4m63NaY1egPPV9bPbTLd1++bwfSoM9v7elqeI36NuQ=
X-Received: by 2002:a17:906:1b0f:b0:78d:3188:9116 with SMTP id
 o15-20020a1709061b0f00b0078d31889116mr3273528ejg.176.1668199160780; Fri, 11
 Nov 2022 12:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20221111132258.762033-1-xukuohai@huaweicloud.com>
In-Reply-To: <20221111132258.762033-1-xukuohai@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Nov 2022 12:39:08 -0800
Message-ID: <CAEf4Bza8+8xDw9dSafVOswrAgLBGjaO_wcBEf+K+CkDEHubW-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] bpf: Initialize same number of free nodes for
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
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        wuqiang <wuqiang.matt@bytedance.com>
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

On Fri, Nov 11, 2022 at 5:06 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
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
> v5: Move "head = per_cpu_ptr ..." out of the i-loop as suggesetd by wuqiang

I've applied v4 (before seeing v5) with head moved out of innermost
loop. But I do prefer v4 anyways.

> v4: Remove unneeded min()
> v3: Simplify code as suggested by Andrii
> v2: Update commit message and add Yonghong's ack
> ---
>  kernel/bpf/percpu_freelist.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
> index b6e7f5c5b9ab..de336e3dffee 100644
> --- a/kernel/bpf/percpu_freelist.c
> +++ b/kernel/bpf/percpu_freelist.c
> @@ -100,22 +100,19 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
>                             u32 nr_elems)
>  {
>         struct pcpu_freelist_head *head;
> -       int i, cpu, pcpu_entries;
> +       unsigned int cpu_idx = 0, cpu, i, j, n, m;
>
> -       pcpu_entries = nr_elems / num_possible_cpus() + 1;
> -       i = 0;
> +       n = nr_elems / num_possible_cpus();
> +       m = nr_elems % num_possible_cpus();
>
>         for_each_possible_cpu(cpu) {
> -again:
>                 head = per_cpu_ptr(s->freelist, cpu);
> -               /* No locking required as this is not visible yet. */
> -               pcpu_freelist_push_node(head, buf);
> -               i++;
> -               buf += elem_size;
> -               if (i == nr_elems)
> -                       break;
> -               if (i % pcpu_entries)
> -                       goto again;
> +               j = n + (cpu_idx++ < m ? 1 : 0);
> +               for (i = 0; i < j; i++) {
> +                       /* No locking required as this is not visible yet. */
> +                       pcpu_freelist_push_node(head, buf);
> +                       buf += elem_size;
> +               }
>         }
>  }
>
> --
> 2.30.2
>
