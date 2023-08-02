Return-Path: <bpf+bounces-6664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDE776C2F7
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2468281B8A
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E484CA44;
	Wed,  2 Aug 2023 02:34:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0937E6
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 02:34:36 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD2E1B2
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 19:34:35 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7658430eb5dso602915585a.2
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 19:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690943674; x=1691548474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/sAaDq7MwrlgCYm2a+42wECNrywWRYAso8taIqmOLI=;
        b=rAYF/oi8iQCG+0ym7Y0q5ETJ9KxKzxiQIyrQosMYoAKqRRx5dXc0eWHgc1EDb05VKc
         4x1LyyK1khuJWVMNLCABFqqHdpYEO8zqhoy2VV+38nj1yuklLK7RhsQDENMxxFlrjeCY
         dMv5IFraUtnZhg3yH/8Tvt4gxPACFEw9OqNpa5mU2jPVDuRvFcyyqaq1rZUq/zMew4+L
         WyhO5GLTGrYu+EOTAbCi7UQPuqRoupLbWD8kNjkP5CORkUVxBA58BqhDcmLwGx3EJAep
         a40/bVcfWToUdigp++V5W/4yEaV9FbUSYA/j09zQnMEE1STVv0oufYB3hg0bH6bkRUEG
         0FTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690943674; x=1691548474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/sAaDq7MwrlgCYm2a+42wECNrywWRYAso8taIqmOLI=;
        b=DgMmI9YoxCJbpYQg1rucN8UOj8Pw3BYfZFAsV4lTCiYsKcM3W7DxfdfJAYGqhlaps+
         paA+QeKmfF8MrkHcJhYfxPWqQ3jwegs71EURQ8/guSAxqKMydjSbutajeHswkoN/xEVR
         /zJy7arhWsaVnoJkshYEjq96RhN92SDSg1/Ly4J+KZl5FMpt58xljCKtOCJMZoaS+h0Q
         NG/S0TowBSjkXq1pEkjODpLaJOqplQgshoCn79kS05MhbGCjXeri11jx8R94UpOu5ys4
         dcd/Sfm6MMqEH7FzM9eYcJMJ7lbXQQ9cL04tNLyQHb0/nElSzh3UIRp1+hCvofVno4Sz
         dHsw==
X-Gm-Message-State: ABy/qLaFPvGFLnWW0dR2NLHcRKurterdWWiJsskYg/Jsj3aRXIi/urbU
	/nxfOWfjknrBZqp+AF9NhnY1e5xmLjO7Uo9RutA=
X-Google-Smtp-Source: APBJJlFnS1CCx4rx3RcbsVVPWAfJyIz8Kwdo1VEA7cPQ3kNsRpE/qeplV6d9R0pMxtSqAlkMJQmm9XPCMdZtcYe4mZI=
X-Received: by 2002:a05:6214:57cb:b0:63d:1aed:72ee with SMTP id
 lw11-20020a05621457cb00b0063d1aed72eemr14967022qvb.64.1690943674359; Tue, 01
 Aug 2023 19:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801142912.55078-1-laoar.shao@gmail.com> <3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev>
In-Reply-To: <3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 2 Aug 2023 10:33:58 +0800
Message-ID: <CALOAHbAnyorNdYAp1FretQcqEp_j6mQ93ATwx02auLTYnL_0KQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Add new bpf helper bpf_for_each_cpu
To: yonghong.song@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 1:53=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 8/1/23 7:29 AM, Yafang Shao wrote:
> > Some statistic data is stored in percpu pointer but the kernel doesn't
> > aggregate it into a single value, for example, the data in struct
> > psi_group_cpu.
> >
> > Currently, we can traverse percpu data using for_loop and bpf_per_cpu_p=
tr:
> >
> >    for_loop(nr_cpus, callback_fn, callback_ctx, 0)
> >
> > In the callback_fn, we retrieve the percpu pointer with bpf_per_cpu_ptr=
().
> > The drawback is that 'nr_cpus' cannot be a variable; otherwise, it will=
 be
> > rejected by the verifier, hindering deployment, as servers may have
> > different 'nr_cpus'. Using CONFIG_NR_CPUS is not ideal.
> >
> > Alternatively, with the bpf_cpumask family, we can obtain a task's cpum=
ask.
> > However, it requires creating a bpf_cpumask, copying the cpumask from t=
he
> > task, and then parsing the CPU IDs from it, resulting in low efficiency=
.
> > Introducing other kfuncs like bpf_cpumask_next might be necessary.
> >
> > A new bpf helper, bpf_for_each_cpu, is introduced to conveniently trave=
rse
> > percpu data, covering all scenarios. It includes
> > for_each_{possible, present, online}_cpu. The user can also traverse CP=
Us
> > from a specific task, such as walking the CPUs of a cpuset cgroup when =
the
> > task is in that cgroup.
>
> The bpf subsystem has adopted kfunc approach. So there is no bpf helper
> any more.

Could you pls. share some background why we made this decision ?

> You need to have a bpf_for_each_cpu kfunc instead.
> But I am wondering whether we should use open coded iterator loops
>     06accc8779c1  bpf: add support for open-coded iterator loops

The usage of open-coded iterator for-loop is almost the same with
bpf_loop, except that it can start from a non-zero value.

>
> In kernel, we have a global variable
>     nr_cpu_ids (also in kernel/bpf/helpers.c)
> which is used in numerous places for per cpu data struct access.
>
> I am wondering whether we could have bpf code like
>     int nr_cpu_ids __ksym;
>
>     struct bpf_iter_num it;
>     int i =3D 0;
>
>     // nr_cpu_ids is special, we can give it a range [1, CONFIG_NR_CPUS].
>     bpf_iter_num_new(&it, 1, nr_cpu_ids);
>     while ((v =3D bpf_iter_num_next(&it))) {
>            /* access cpu i data */
>            i++;
>     }
>     bpf_iter_num_destroy(&it);
>
>  From all existing open coded iterator loops, looks like
> upper bound has to be a constant. We might need to extend support
> to bounded scalar upper bound if not there.

Currently the upper bound is required by both the open-coded for-loop
and the bpf_loop. I think we can extend it.

It can't handle the cpumask case either.

    for_each_cpu(cpu, mask)

In the 'mask', the CPU IDs might not be continuous. In our container
environment, we always use the cpuset cgroup for some critical tasks,
but it is not so convenient to traverse the percpu data of this cpuset
cgroup.  We have to do it as follows for this case :

That's why we prefer to introduce a bpf_for_each_cpu helper. It is
fine if it can be implemented as a kfunc.

--=20
Regards
Yafang

