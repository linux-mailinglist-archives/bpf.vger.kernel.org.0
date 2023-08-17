Return-Path: <bpf+bounces-7952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E412A77EF7E
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 05:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E151C21096
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 03:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5593580C;
	Thu, 17 Aug 2023 03:23:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C16802
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 03:23:09 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58CB268F;
	Wed, 16 Aug 2023 20:23:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ba0f27a4c2so109167911fa.2;
        Wed, 16 Aug 2023 20:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692242586; x=1692847386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gi9uHKL0iQrTkC3F4e7Afx1qQgxObPV8bi6KYeWyUPU=;
        b=gWjLJfFa2B5/SBzEoe1+n3DC8U1pjdTff5Vl+I7MiFF3mDbhN8sFSrGVnbrG+61ZyG
         YssIkH7dWUfg77Ix0DzS1GzkkTVuQpGlXAW1TP9H7heGa2phTi685FVl/alJ5C+CFNVp
         lWobkTfcSzHjfeiY1KWs/2pud3D4RJLl5O4MgTO/Qgergbn9YrIOdczzTUl6vLsjFVGh
         f71JLvd2zua1RTRQ7q5/tOtRT/dpFrbAFj6F34eo+icdivbNRjYwlpPr1I8m8XjCBVze
         3A+IBV+0ic/xzMlEw3mNA3GKmiOkSz6p/J7N6bi7Ytb0muHx0z0dDUKgQerUNdlw7kEg
         cDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692242586; x=1692847386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi9uHKL0iQrTkC3F4e7Afx1qQgxObPV8bi6KYeWyUPU=;
        b=MtHKfmeaUP9XPu0Ifmylmr3UAyyXDDmcYrS+5oMCsCEyl7ZGNjhv88jRJ5yxceYN1p
         C3rv31DZZv1B58GMf3MkkOLLJ8CyoQvrHfA/m0VgLW1sT9GgFtSaCHCr9f0HiRqJpyki
         6+ZfyIlbtkMmoOIHkj2S0pbVhnz56igIE8V/v45vNtT9Fhnoi2qNS6KqoqepSBBJZdOP
         JEOEuvpj1IOinyuTnPc8acv/oq+mjocux+quVwfe8oZ3irEtAyLMT5twHu3esqsPiEtC
         7hT/cZsBSxtpCzPLlGx9TM+9RDxn8bZkqs2ygUxbl+FbH92JPYlPQc4VVSBIArKvtdR/
         WjEQ==
X-Gm-Message-State: AOJu0Yx1q6YMf1DiRXep14mniCDuuqqUDnF0zZped5LKXiY6fYXSGIK3
	5WIAYSGtJ38Mvi236kJmVN46dOWnnXXVHmJIjTE=
X-Google-Smtp-Source: AGHT+IEwik2Hp8ICK3Q2ykk/jAbc6u2IngzXk0Gz9hjB7UOZjtWQAxYJSDXDjXNW6P9dQUjpvkLfBnyZNBr2Ds4WIKM=
X-Received: by 2002:a2e:3e1a:0:b0:2bb:96df:13e1 with SMTP id
 l26-20020a2e3e1a000000b002bb96df13e1mr2790319lja.46.1692242585724; Wed, 16
 Aug 2023 20:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-2-zhouchuyi@bytedance.com> <CAADnVQK=7NWbRtJyRJAqy5JwZHRB7s7hCNeGqixjLa4vB609XQ@mail.gmail.com>
 <93627e45-dc67-fd31-ef43-a93f580b0d6e@bytedance.com>
In-Reply-To: <93627e45-dc67-fd31-ef43-a93f580b0d6e@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Aug 2023 20:22:54 -0700
Message-ID: <CAADnVQKThM=vL7qpR05Ky6ReDrtuUxz_0SEZ+Bsc+E4=_A_u+g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] mm, oom: Introduce bpf_oom_evaluate_task
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, wuyun.abel@bytedance.com, 
	robin.lu@bytedance.com, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 7:51=E2=80=AFPM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> Hello,
>
> =E5=9C=A8 2023/8/17 10:07, Alexei Starovoitov =E5=86=99=E9=81=93:
> > On Thu, Aug 10, 2023 at 1:13=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance=
.com> wrote:
> >>   static int oom_evaluate_task(struct task_struct *task, void *arg)
> >>   {
> >>          struct oom_control *oc =3D arg;
> >> @@ -317,6 +339,26 @@ static int oom_evaluate_task(struct task_struct *=
task, void *arg)
> >>          if (!is_memcg_oom(oc) && !oom_cpuset_eligible(task, oc))
> >>                  goto next;
> >>
> >> +       /*
> >> +        * If task is allocating a lot of memory and has been marked t=
o be
> >> +        * killed first if it triggers an oom, then select it.
> >> +        */
> >> +       if (oom_task_origin(task)) {
> >> +               points =3D LONG_MAX;
> >> +               goto select;
> >> +       }
> >> +
> >> +       switch (bpf_oom_evaluate_task(task, oc)) {
> >> +       case BPF_EVAL_ABORT:
> >> +               goto abort; /* abort search process */
> >> +       case BPF_EVAL_NEXT:
> >> +               goto next; /* ignore the task */
> >> +       case BPF_EVAL_SELECT:
> >> +               goto select; /* select the task */
> >> +       default:
> >> +               break; /* No BPF policy */
> >> +       }
> >> +
> >
> > I think forcing bpf prog to look at every task is going to be limiting
> > long term.
> > It's more flexible to invoke bpf prog from out_of_memory()
> > and if it doesn't choose a task then fallback to select_bad_process().
> > I believe that's what Roman was proposing.
> > bpf can choose to iterate memcg or it might have some side knowledge
> > that there are processes that can be set as oc->chosen right away,
> > so it can skip the iteration.
>
> IIUC, We may need some new bpf features if we want to iterating
> tasks/memcg in BPF, sush as:
> bpf_for_each_task
> bpf_for_each_memcg
> bpf_for_each_task_in_memcg
> ...
>
> It seems we have some work to do first in the BPF side.
> Will these iterating features be useful in other BPF scenario except OOM
> Policy?

Yes.
Use open coded iterators though.
Like example in
https://lore.kernel.org/all/20230810183513.684836-4-davemarchevsky@fb.com/

bpf_for_each(task_vma, vma, task, 0) { ... }
will safely iterate vma-s of the task.
Similarly struct css_task_iter can be hidden inside bpf open coded iterator=
.

