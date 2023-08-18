Return-Path: <bpf+bounces-8042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04F278051D
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 06:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611042822D4
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 04:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A52F4B;
	Fri, 18 Aug 2023 04:34:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A878B624
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 04:34:48 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE5930F3;
	Thu, 17 Aug 2023 21:34:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so7109911fa.1;
        Thu, 17 Aug 2023 21:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692333285; x=1692938085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z5Rvs4S3mkFHAgJim+KMXVdycv/Q7lggQvlYexbi0w=;
        b=L8wArv91zGw4G5kuSF84/L1VmS0cHLQuCBEsFDRej93w1REiEFTolJMJffGQ67obov
         aXDnVRSn8BQ0+xnZO+7bLtqVWrK7VbDJ3sf79elZXAytTBIRV4xjHiAkCknbdj/mvtId
         zj6seOOv22dAjHUvCZYHSGZv3BbcOfIDiChK6BVWBnkkvhX0InZtq9hyZ3/5guzXnkHJ
         2p0sGuNr990k1xu/SnryM7tEF/TAbc2EE7Lb1P2VzRlPpT2hee0t++YBKa042o1O59wX
         vNN3NZuWQHHtNGU9sixjUkSLHnSBVSF+Asa4ZZQK6jz42xIDYQrHiiOmG3qBPeZcuySV
         G/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692333285; x=1692938085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z5Rvs4S3mkFHAgJim+KMXVdycv/Q7lggQvlYexbi0w=;
        b=SpRatUPBwOdTsXuXXlAvZR6Oyw1jYXrJwEHqkDqkoufkTrrEoQwHf/REuFgQHyLI82
         ZjQxHCsTuHpqpwWoKyCG7n08FDdpH4h4FaSM8L0+ZiuuuSIgJd3ickCuqnFjcZVYEVYi
         OnwxrZr3vGollNk2u2O2PgDWXFv09TswrPSFNek8wOoGmmEabUgXCVtFEWKYaeZ/G8qK
         phwYXz6SRrB/ySPKPwBhU5lCAdGsPjLv9AiXO65AuOiwRNbAY9zAkPBIVEfqps6Vo166
         QsRv+kyMU+qLEXM58/1PrESyZHRb6ELSb3trAfS8mlER0FLORM5o6bMcmoWiqnB1wQ/Z
         Q+yA==
X-Gm-Message-State: AOJu0Yzy8wS/mxANDR2pLbw1ScJI8H11CaxjwTtf+LEdj5nWsj4CjFkW
	S/l/aOhUQPnQN4THJQYzlGHROH1e2GXoPG6IMUU=
X-Google-Smtp-Source: AGHT+IGBJ/ClrasU4Y9FmOc75yCtUr+JftemvoKrDGa/zxjVs6kSfpechQInE5cMJu99Y9Zda8HMK/zWynByCjwkTQI=
X-Received: by 2002:a05:651c:14d:b0:2b6:ecdd:16cf with SMTP id
 c13-20020a05651c014d00b002b6ecdd16cfmr774844ljd.40.1692333284930; Thu, 17 Aug
 2023 21:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-2-zhouchuyi@bytedance.com> <CAADnVQK=7NWbRtJyRJAqy5JwZHRB7s7hCNeGqixjLa4vB609XQ@mail.gmail.com>
 <93627e45-dc67-fd31-ef43-a93f580b0d6e@bytedance.com> <CAADnVQKThM=vL7qpR05Ky6ReDrtuUxz_0SEZ+Bsc+E4=_A_u+g@mail.gmail.com>
 <a24fc514-38dd-c4bb-322f-08a6f46767f4@bytedance.com>
In-Reply-To: <a24fc514-38dd-c4bb-322f-08a6f46767f4@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Aug 2023 21:34:33 -0700
Message-ID: <CAADnVQKHvR1LUD+ZDX545ZVFea3fuHyuPWQERcsNtY7HNHUFtg@mail.gmail.com>
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

On Thu, Aug 17, 2023 at 8:30=E2=80=AFPM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> Hello,
> =E5=9C=A8 2023/8/17 11:22, Alexei Starovoitov =E5=86=99=E9=81=93:
> > On Wed, Aug 16, 2023 at 7:51=E2=80=AFPM Chuyi Zhou <zhouchuyi@bytedance=
.com> wrote:
> >>
> >> Hello,
> >>
> >> =E5=9C=A8 2023/8/17 10:07, Alexei Starovoitov =E5=86=99=E9=81=93:
> >>> On Thu, Aug 10, 2023 at 1:13=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedan=
ce.com> wrote:
> >>>>    static int oom_evaluate_task(struct task_struct *task, void *arg)
> >>>>    {
> >>>>           struct oom_control *oc =3D arg;
> >>>> @@ -317,6 +339,26 @@ static int oom_evaluate_task(struct task_struct=
 *task, void *arg)
> >>>>           if (!is_memcg_oom(oc) && !oom_cpuset_eligible(task, oc))
> >>>>                   goto next;
> >>>>
> >>>> +       /*
> >>>> +        * If task is allocating a lot of memory and has been marked=
 to be
> >>>> +        * killed first if it triggers an oom, then select it.
> >>>> +        */
> >>>> +       if (oom_task_origin(task)) {
> >>>> +               points =3D LONG_MAX;
> >>>> +               goto select;
> >>>> +       }
> >>>> +
> >>>> +       switch (bpf_oom_evaluate_task(task, oc)) {
> >>>> +       case BPF_EVAL_ABORT:
> >>>> +               goto abort; /* abort search process */
> >>>> +       case BPF_EVAL_NEXT:
> >>>> +               goto next; /* ignore the task */
> >>>> +       case BPF_EVAL_SELECT:
> >>>> +               goto select; /* select the task */
> >>>> +       default:
> >>>> +               break; /* No BPF policy */
> >>>> +       }
> >>>> +
> >>>
> >>> I think forcing bpf prog to look at every task is going to be limitin=
g
> >>> long term.
> >>> It's more flexible to invoke bpf prog from out_of_memory()
> >>> and if it doesn't choose a task then fallback to select_bad_process()=
.
> >>> I believe that's what Roman was proposing.
> >>> bpf can choose to iterate memcg or it might have some side knowledge
> >>> that there are processes that can be set as oc->chosen right away,
> >>> so it can skip the iteration.
> >>
> >> IIUC, We may need some new bpf features if we want to iterating
> >> tasks/memcg in BPF, sush as:
> >> bpf_for_each_task
> >> bpf_for_each_memcg
> >> bpf_for_each_task_in_memcg
> >> ...
> >>
> >> It seems we have some work to do first in the BPF side.
> >> Will these iterating features be useful in other BPF scenario except O=
OM
> >> Policy?
> >
> > Yes.
> > Use open coded iterators though.
> > Like example in
> > https://lore.kernel.org/all/20230810183513.684836-4-davemarchevsky@fb.c=
om/
> >
> > bpf_for_each(task_vma, vma, task, 0) { ... }
> > will safely iterate vma-s of the task.
> > Similarly struct css_task_iter can be hidden inside bpf open coded iter=
ator.
> OK. I think the following APIs whould be useful and I am willing to
> start with these in another bpf-next RFC patchset:
>
> 1. bpf_for_each(task). Just like for_each_process(p) in kernel to
> itearing all tasks in the system with rcu_read_lock().
>
> 2. bpf_for_each(css_task, task, css). It works like
> css_task_iter_{start, next, end} and would be used to iterating
> tasks/threads under a css.
>
> 3. bpf_for_each(descendant_css, css, root_css, {PRE, POST}). It works
> like css_next_descendant_{pre, post} to iterating all descendant.
>
> If you have better ideas or any advice, please let me know.

Sounds great. Such 3 new iterators are unrelated to oom discussion and
can be developed/landed in parallel.
They will be useful in other bpf programs.

