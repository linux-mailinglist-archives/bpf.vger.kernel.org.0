Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597156262A0
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 21:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbiKKUOS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 15:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiKKUOR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 15:14:17 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9905EF82;
        Fri, 11 Nov 2022 12:14:16 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id 13so15091822ejn.3;
        Fri, 11 Nov 2022 12:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0/Uknr7+nm9wMAuF/jnGoLItaH2Ut6RvlQgHhDJ7rd0=;
        b=VRD8e7incGFFFuEUPDwybwHSJac12luhz0APKPuT0k3aklxT9mXvwa+c0OJDqx2DNH
         Xp3KQQHG69qgDoEgm6Ug+zNf4I2UY71t2G1clWXV+AxoZcV/dKgSYj82uGeGa+IyNpLm
         6C5yemSj5cW0PcmZFv8tc21du8D38Xn5/VSRzKbzgrcsCYq6ImgUZhJqmsLHx4OIG74H
         dZLqssPYiEjHmTh37K63fTwhvwYo8GsmbGsYt2xA+DJxWhERbEi9WACOC+W547kxTg+9
         WjjgNrNQVR2WSYPjNDJGPannxr2LCZWm4VdwwL/+lCT9o4tL/D6uuc2WpBwiqsarb+NZ
         9dIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/Uknr7+nm9wMAuF/jnGoLItaH2Ut6RvlQgHhDJ7rd0=;
        b=vq4szUElB0uOkAUg4mJYP+0asu6GQMmfWzURIY5ga6rrBhSSua/8XMMDflgowyVWus
         XUXI13uUJveA0SzFEkbF5hyplvLvfPhhluas2O01A9iBuKF/87KHV3TeP+Uz90vIOVoe
         H4IrE0GYrMQx6/1TljMseXfblP6FZmpLJ+3AVIgclxZmTKX64n4+qFIK5SF9sqlAprJZ
         8WRjUu/nEHcgWIASiyvQIQhG9/2f2gWxdmE2CUVKj5ENJwwdVKUDKXTzog6X01nnyAxH
         EXlujakRlBNyWFiykDX2cye6HBVe1mZ5JBYA7v5cPbCsprEFa1CD6B3J8st4S9F91kM8
         8buA==
X-Gm-Message-State: ANoB5pkpHZGXezad0NXsQKbWn54b8X+ZTk8auHyk4NlKAVIQY+9IBR/7
        5PlnO0LqMlLC37pqsaDZrsxdg2fxcjZqwgE65Ik=
X-Google-Smtp-Source: AA0mqf4uCrdbiRi2Rbe08GXCPfAP1KO3SqmDkVjzWCecdf36EGfwlLgmC4kMqVJdHMVImwZsFUVRZOAuFSa2JRNqt7g=
X-Received: by 2002:a17:906:cd0f:b0:78d:99ee:4e68 with SMTP id
 oz15-20020a170906cd0f00b0078d99ee4e68mr3103709ejb.302.1668197581252; Fri, 11
 Nov 2022 12:13:01 -0800 (PST)
MIME-Version: 1.0
References: <20221110122128.105214-1-xukuohai@huawei.com> <83161e5e-5aa4-acdc-630b-95274bfb47d3@bytedance.com>
 <f6d87d0e-4773-d27a-dd50-139307460b4c@huawei.com>
In-Reply-To: <f6d87d0e-4773-d27a-dd50-139307460b4c@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Nov 2022 12:12:49 -0800
Message-ID: <CAEf4BzYG_Rw_vNWK1pX9WJPdWw8c4nxtQPFwisX13iepHT+7KQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: Initialize same number of free nodes for
 each pcpu_freelist
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     wuqiang <wuqiang.matt@bytedance.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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

On Thu, Nov 10, 2022 at 11:00 PM Xu Kuohai <xukuohai@huawei.com> wrote:
>
> On 11/11/2022 11:53 AM, wuqiang wrote:
> > On 2022/11/10 20:21, Xu Kuohai wrote:
> >> pcpu_freelist_populate() initializes nr_elems / num_possible_cpus() + 1
> >> free nodes for some CPUs, and then possibly one CPU with fewer nodes,
> >> followed by remaining cpus with 0 nodes. For example, when nr_elems == 256
> >> and num_possible_cpus() == 32, CPU 0~27 each gets 9 free nodes, CPU 28 gets
> >> 4 free nodes, CPU 29~31 get 0 free nodes, while in fact each CPU should get
> >> 8 nodes equally.
> >>
> >> This patch initializes nr_elems / num_possible_cpus() free nodes for each
> >> CPU firstly, then allocates the remaining free nodes by one for each CPU
> >> until no free nodes left.
> >>
> >> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> >> Acked-by: Yonghong Song <yhs@fb.com>
> >> ---
> >> v4: Remove unneeded min()
> >> v3: Simplify code as suggested by Andrii
> >> v2: Update commit message and add Yonghong's ack
> >> ---
> >>   kernel/bpf/percpu_freelist.c | 26 +++++++++++++-------------
> >>   1 file changed, 13 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
> >> index b6e7f5c5b9ab..27f2c4aff623 100644
> >> --- a/kernel/bpf/percpu_freelist.c
> >> +++ b/kernel/bpf/percpu_freelist.c
> >> @@ -100,22 +100,22 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
> >>                   u32 nr_elems)
> >>   {
> >>       struct pcpu_freelist_head *head;
> >> -    int i, cpu, pcpu_entries;
> >> +    unsigned int cpu, cpu_idx, i, j, n, m;
> >> -    pcpu_entries = nr_elems / num_possible_cpus() + 1;
> >> -    i = 0;
> >> +    n = nr_elems / num_possible_cpus();
> >> +    m = nr_elems % num_possible_cpus();
> >> +
> >> +    cpu_idx = 0;
> >>       for_each_possible_cpu(cpu) {
> >> -again:
> >> -        head = per_cpu_ptr(s->freelist, cpu);
> >> -        /* No locking required as this is not visible yet. */
> >> -        pcpu_freelist_push_node(head, buf);
> >> -        i++;
> >> -        buf += elem_size;
> >> -        if (i == nr_elems)
> >> -            break;
> >> -        if (i % pcpu_entries)
> >> -            goto again;
> >> +        j = n + (cpu_idx < m ? 1 : 0);
> >> +        for (i = 0; i < j; i++) {
> >> +            head = per_cpu_ptr(s->freelist, cpu);
> >
> > Better move it out of "i-loop",
>
> OK, will do
>

I did that while applying. Also added

Fixes: e19494edab82 ("bpf: introduce percpu_freelist")

Please don't forget to add Fixes tag for future patches.

Applied to bpf tree.

> > and rename "j" to a meaningful name to avoid
> > possible misuse.
> >
> The loop is short enough to be readable and "j" is not used elsewhere, so I
> think it's good to keep the name simple.
>
> >> +            /* No locking required as this is not visible yet. */
> >> +            pcpu_freelist_push_node(head, buf);
> >> +            buf += elem_size;
> >> +        }
> >> +        cpu_idx++;
> >>       }
> >>   }
> >
> > .
>
