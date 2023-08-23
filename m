Return-Path: <bpf+bounces-8323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 086EF784D9C
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 02:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C911C20B9C
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 00:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A783219A;
	Wed, 23 Aug 2023 00:06:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750727E
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 00:06:05 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16EDFB
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 17:06:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31aeef88a55so2942047f8f.2
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 17:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692749162; x=1693353962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2t3KsvcCLzyxTErF00blGFJg6Ru9IuSSvUquqHaYCQ=;
        b=Ncn3OEf2CVo9YFmAUUZvoN3I/E48m5gQtRXJ5RI0gee/doTIvps4cMZ3VoiU4kqD/g
         Oy5JoK/mTayGdY6LWxy4qLo2GuTPHuMDr+9yUAIPTZgHG3Gwp5+lo61b9RdtjNg4Vy1f
         aXiU8SfGjJRBMOC+xquCDR7ZEK2IjXNnXC0wptndRoUcRti/7qtF9eBABEF7TFA0jT4Y
         un3LegvOCdObAGB9dMF8Nxc/9xPKA4X1xPih4jo/X/fRi2PBgbX6NizKenQ+zI9Xu5Fx
         hgP6rxXxh5qnF8cbDb6Pq7q6RZWZC2m7LST6AGgz8/TfZL/XiqJrYEr1s2T4c/wydUTs
         hE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692749162; x=1693353962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2t3KsvcCLzyxTErF00blGFJg6Ru9IuSSvUquqHaYCQ=;
        b=UWBZQu0ZKr/el+lz3uaVt69dKIxCqYTTs4OmihG3Mbuoskc14JAvgvkyOvsgqpEqQR
         VqBEfg8Jr/VT4UecLezcId8Z5jAkYQ1oVWsYkX/hQDlXUF6Ke33XRJKiHwcKsRVZod3w
         ahXHgkJxHxuUE1FX5ukn7pzcikHMYLe6E+HIW1S7jw07jY7nSEaiCW2mZSQLIvUv8e+H
         Ci/619/VUiU9uEkDa8X1azwy2g688Z1GSWNNNAiLzx2J2lBM4cPGb2uLJi9seQWIOd6i
         xx3cA2qrgbIx7XxNVpQiZkQLY3fLttLAjMzJB0leTXVct3KCCYaCWBCX/kNNuTBkep5d
         Qd4A==
X-Gm-Message-State: AOJu0YzwOdlqIHsZaAWfZVlBN0vCCMltiRedzE7Sm2NmgBMADR4kOkv4
	yLLiVGuek11yf2rvZWhcWdJ8bP/cKksULKJnNKU=
X-Google-Smtp-Source: AGHT+IHw4LaM+31YcdwqQ16R7JPtmdug00Vj3yhI7NHrWrNWu9N1TVhOCsiYXN4GUiXVdXDTs9z4bcGqjAXWUgq2EbI=
X-Received: by 2002:a5d:4911:0:b0:314:1f6:2c24 with SMTP id
 x17-20020a5d4911000000b0031401f62c24mr8160468wrq.36.1692749162211; Tue, 22
 Aug 2023 17:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822133807.3198625-1-houtao@huaweicloud.com> <20230822133807.3198625-2-houtao@huaweicloud.com>
In-Reply-To: <20230822133807.3198625-2-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Aug 2023 17:05:49 -0700
Message-ID: <CAADnVQKFh9pWp1abrG2KKiZanb+4rzRb3HmzX0snggah3Lq-yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Enable preemption after
 irq_work_raise() in unit_alloc()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 6:06=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> When doing stress test for qp-trie, bpf_mem_alloc() returned NULL
> unexpectedly because all qp-trie operations were initiated from
> bpf syscalls and there was still available free memory. bpf_obj_new()
> has the same problem as shown by the following selftest.
>
> The failure is due to the preemption. irq_work_raise() will invoke
> irq_work_claim() first to mark the irq work as pending and then inovke
> __irq_work_queue_local() to raise an IPI. So when the current task
> which is invoking irq_work_raise() is preempted by other task,
> unit_alloc() may return NULL for preemptive task as shown below:
>
> task A         task B
>
> unit_alloc()
>   // low_watermark =3D 32
>   // free_cnt =3D 31 after alloc
>   irq_work_raise()
>     // mark irq work as IRQ_WORK_PENDING
>     irq_work_claim()
>
>                // task B preempts task A
>                unit_alloc()
>                  // free_cnt =3D 30 after alloc
>                  // irq work is already PENDING,
>                  // so just return
>                  irq_work_raise()
>                // does unit_alloc() 30-times
>                ......
>                unit_alloc()
>                  // free_cnt =3D 0 before alloc
>                  return NULL
>
> Fix it by invoking preempt_disable_notrace() before allocation and
> invoking preempt_enable_notrace() to enable preemption after
> irq_work_raise() completes. An alternative fix is to move
> local_irq_restore() after the invocation of irq_work_raise(), but it
> will enlarge the irq-disabled region. Another feasible fix is to only
> disable preemption before invoking irq_work_queue() and enable
> preemption after the invocation in irq_work_raise(), but it can't
> handle the case when c->low_watermark is 1.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/memalloc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 9c49ae53deaf..83f8913ebb0a 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -6,6 +6,7 @@
>  #include <linux/irq_work.h>
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/memcontrol.h>
> +#include <linux/preempt.h>
>  #include <asm/local.h>
>
>  /* Any context (including NMI) BPF specific memory allocator.
> @@ -725,6 +726,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache =
*c)
>          * Use per-cpu 'active' counter to order free_list access between
>          * unit_alloc/unit_free/bpf_mem_refill.
>          */
> +       preempt_disable_notrace();
>         local_irq_save(flags);
>         if (local_inc_return(&c->active) =3D=3D 1) {
>                 llnode =3D __llist_del_first(&c->free_llist);
> @@ -740,6 +742,12 @@ static void notrace *unit_alloc(struct bpf_mem_cache=
 *c)
>
>         if (cnt < c->low_watermark)
>                  (c);
> +       /* Enable preemption after the enqueue of irq work completes,
> +        * so free_llist may be refilled by irq work before other task
> +        * preempts current task.
> +        */
> +       preempt_enable_notrace();

So this helps qp-trie init, since it's doing bpf_mem_alloc from
syscall context and helps bpf_obj_new from bpf prog, since prog is
non-migrateable, but preemptable. It's not an issue for htab doing
during map_update, since
it's under htab bucket lock.
Let's introduce minimal:
/* big comment here explaining the reason of extra preempt disable */
static void bpf_memalloc_irq_work_raise(...)
{
  preempt_disable_notrace();
  irq_work_raise();
  preempt_enable_notrace();
}

it will have the same effect, right?

