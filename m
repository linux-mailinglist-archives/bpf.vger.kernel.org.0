Return-Path: <bpf+bounces-102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABB36F7D57
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 08:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480FE280FBD
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 06:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8899F4C71;
	Fri,  5 May 2023 06:58:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426DED1
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 06:58:28 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9995AD1F
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 23:58:26 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so1258297a12.2
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 23:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683269906; x=1685861906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZDZ1+PjAiEZQtoPwEy9pwtEVxFqufFD3zBczSh3kD0=;
        b=StEakw9a6lVCtkkEDv+4BvHR6Wxf2jL87YZFGjZTg8SLV7DE4N46KkWbEKPf4uwZAt
         HCa1BPcXKaZhaEW8+73m04vnLkvuSEl6BXzAph2jE7xGC727EywReRr63soA21KEw9P7
         PzCf1n51YIDbT3i0eLwu/sJxZYDOxqFr1fjg0IRUxqJF8bz8aipGOqkA6gzuKx88fh4r
         vcyb5VL/BJBJWkbyPfgMLVpQ3VL7I2FGfaQKslLoJd1UXiCW2xOsHUgA9afEBOtWRnvY
         oujpFKRrLeopu4RIEJONocyherWKTyiUh/+G/pvjPnl31dBJTRRWGgiQSHt+ENpuX+DW
         xqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683269906; x=1685861906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZDZ1+PjAiEZQtoPwEy9pwtEVxFqufFD3zBczSh3kD0=;
        b=OCPmjHvdO4ShrLHB/LoBHbqW2yNNvGm/wCV2wWXoZqgIAoXDByg4YObUCZn7TCGP8E
         OmGfeSPTl9ZlWij75dLhGnayd/E11C2zZr78RvQ/BkF0uMmORno9lSZ6SqAzi7wAI4z8
         S2wcSX7c7ExouKZtcLXOwFIPr2fJdxv97CM8Zpv/W6v+rNKWE74D7HcOUXCtZjKu/V0V
         ToDkslhlXw6xIe009OzJtMz1vNlthOpvJHUuOIjWam/M85gRITYtroEJkFiMGDKb/HHU
         RU2yY6oxSOe8YLJ9dTv8vVoOGIQxFP4QBrXnxDZtAuDb8RKhv30ViQel6BjoBEe2Zq1G
         aePg==
X-Gm-Message-State: AC+VfDygW4k2Sv7BplTEWRlpHCTADYU1Q/wO/MKezCtiLHCs8lAjnxiG
	26l3l4rLhDCXNsTFv1vMjKkLiw3pIQtIqV9im2VbwQ==
X-Google-Smtp-Source: ACHHUZ4SWTqEC3IZtUTnvtU12URfI9P+BglBCPYWIN5VCnI4J1XVYn4ycqypNKlFeDZEtmxQ2wltXFiQol+b2xk4IO8=
X-Received: by 2002:a17:90b:390e:b0:24e:3254:5d94 with SMTP id
 ob14-20020a17090b390e00b0024e32545d94mr426092pjb.40.1683269905994; Thu, 04
 May 2023 23:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230505060818.60037-1-zhoufeng.zf@bytedance.com> <20230505060818.60037-2-zhoufeng.zf@bytedance.com>
In-Reply-To: <20230505060818.60037-2-zhoufeng.zf@bytedance.com>
From: Hao Luo <haoluo@google.com>
Date: Thu, 4 May 2023 23:58:14 -0700
Message-ID: <CA+khW7g_gq1N=cNHC-5WG2nZ8a-wHSpwg_fc5=dQpkweGvROqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Add bpf_task_under_cgroup() kfunc
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com, 
	shuah@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 11:08=E2=80=AFPM Feng zhou <zhoufeng.zf@bytedance.co=
m> wrote:
>
<...>
> ---
>  kernel/bpf/helpers.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index bb6b4637ebf2..453cbd312366 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2149,6 +2149,25 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 =
cgid)
>                 return NULL;
>         return cgrp;
>  }
> +
> +/**
> + * bpf_task_under_cgroup - wrap task_under_cgroup_hierarchy() as a kfunc=
, test
> + * task's membership of cgroup ancestry.
> + * @task: the task to be tested
> + * @ancestor: possible ancestor of @task's cgroup
> + *
> + * Tests whether @task's default cgroup hierarchy is a descendant of @an=
cestor.
> + * It follows all the same rules as cgroup_is_descendant, and only appli=
es
> + * to the default hierarchy.
> + */
> +__bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
> +                                      struct cgroup *ancestor)
> +{
> +       if (unlikely(!ancestor || !task))
> +               return -EINVAL;
> +
> +       return task_under_cgroup_hierarchy(task, ancestor);
> +}
>  #endif /* CONFIG_CGROUPS */
>

I wonder in what situation a null 'task' or 'ancestor' can be passed.
Please call out in the comment that the returned value can be a
negative error, so that writing if(bpf_task_under_cgroup()) may cause
surprising results.

Hao

