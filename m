Return-Path: <bpf+bounces-7947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ABB77EEED
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 04:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94089281CD2
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 02:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957A639F;
	Thu, 17 Aug 2023 02:07:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C2379
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 02:07:25 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E715E1FD0;
	Wed, 16 Aug 2023 19:07:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b962535808so109687771fa.0;
        Wed, 16 Aug 2023 19:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692238042; x=1692842842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC4zpF/OT6YA+2CRoUOjQ7kJNEGnjM2sXNFacPRsJjo=;
        b=RjDAp0jjwaeqwaS0ynQwfGNgpDZ4cpHxok4189aXBo2FNtLvkGDMNwUhoFbyaX0dhF
         k520Gcwq1gCWh12TzTkDC1GtrczUDrkdKdPsC0HGzsFDFTbZqzKTZJtis8CfoYuJ0y8+
         7leVCV1IX8wrVQkJsbOpkj9HjE7gmSI26mLYDaQ4/0bR/NjxX9ISHcFcBX9X0wf0Q7o4
         Kw+5RGlnc5FgXpt08Ia+L6jG+q/ZaskC13h85NFErG0S+mg3KZJ1gbwLZeLv2PWI2uLh
         usAotWV2FRLxHoRhn5JMyi5Zh7gtnILj/NEcGw5m6pvyMOvm0Oa1bfZBldSjoYo6Iryi
         rJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692238042; x=1692842842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FC4zpF/OT6YA+2CRoUOjQ7kJNEGnjM2sXNFacPRsJjo=;
        b=Vx1duBABoIiQtp+hb0csRgcdyYEKtHLGblGmnpQsLKgbubKA+qbohegX/7qE9Gr5IP
         pxkRKurS2XaE97xLEZbQ6WoejMP7rmkGdi28nQcsxKNtJWzivN6Am3y9z5S9g4TS7not
         cfMkRgW5m16pJxS4KZvblPEyIbkPYYq49VLYwCIRT6PmvZIpDBQY94ADeK3Qq/HDAucu
         YF92ZHWzRZ4Yp3hC42wt+2t2QTI5bwnRApIyt9iqlLZSeXn1wv/pkEeb7NrC8aUvPOL0
         axMwjxICnM83Y60WkgXcBs3oPgyU0VqZEUeYLmrhqN7ie6kQVPVpzFqRBfFrgpNlVdrY
         PDEw==
X-Gm-Message-State: AOJu0YyS4SusDC6ZQiN7Jh/VTo+OmCZF0ar64LdGjI+FTu8YSywtFDXs
	zdqG6guMVjS93aVLqI8pYNLjAiKiFoLdz7e0M1A=
X-Google-Smtp-Source: AGHT+IGW5RhuFYtHcZkxTxlq/sRXrRrlPib3VJn6Oxqk9mxkuGyxY6lpDkIka01jVQffH+IxGkIVUUsZ2stZ8oXf+Kk=
X-Received: by 2002:a2e:b78e:0:b0:2b5:89a6:c12b with SMTP id
 n14-20020a2eb78e000000b002b589a6c12bmr2799704ljo.10.1692238041905; Wed, 16
 Aug 2023 19:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810081319.65668-1-zhouchuyi@bytedance.com> <20230810081319.65668-2-zhouchuyi@bytedance.com>
In-Reply-To: <20230810081319.65668-2-zhouchuyi@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Aug 2023 19:07:10 -0700
Message-ID: <CAADnVQK=7NWbRtJyRJAqy5JwZHRB7s7hCNeGqixjLa4vB609XQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] mm, oom: Introduce bpf_oom_evaluate_task
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, muchun.song@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	wuyun.abel@bytedance.com, robin.lu@bytedance.com, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 1:13=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>  static int oom_evaluate_task(struct task_struct *task, void *arg)
>  {
>         struct oom_control *oc =3D arg;
> @@ -317,6 +339,26 @@ static int oom_evaluate_task(struct task_struct *tas=
k, void *arg)
>         if (!is_memcg_oom(oc) && !oom_cpuset_eligible(task, oc))
>                 goto next;
>
> +       /*
> +        * If task is allocating a lot of memory and has been marked to b=
e
> +        * killed first if it triggers an oom, then select it.
> +        */
> +       if (oom_task_origin(task)) {
> +               points =3D LONG_MAX;
> +               goto select;
> +       }
> +
> +       switch (bpf_oom_evaluate_task(task, oc)) {
> +       case BPF_EVAL_ABORT:
> +               goto abort; /* abort search process */
> +       case BPF_EVAL_NEXT:
> +               goto next; /* ignore the task */
> +       case BPF_EVAL_SELECT:
> +               goto select; /* select the task */
> +       default:
> +               break; /* No BPF policy */
> +       }
> +

I think forcing bpf prog to look at every task is going to be limiting
long term.
It's more flexible to invoke bpf prog from out_of_memory()
and if it doesn't choose a task then fallback to select_bad_process().
I believe that's what Roman was proposing.
bpf can choose to iterate memcg or it might have some side knowledge
that there are processes that can be set as oc->chosen right away,
so it can skip the iteration.

