Return-Path: <bpf+bounces-10184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F487A2809
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 22:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7461C20B12
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 20:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5C71B281;
	Fri, 15 Sep 2023 20:25:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA0410947
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 20:25:36 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3F32703;
	Fri, 15 Sep 2023 13:25:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-403012f27e1so26789435e9.1;
        Fri, 15 Sep 2023 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694809530; x=1695414330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIpYKgze7l+4kxt1H4ShRKX1dLLu6xyjGygZfgTzVnI=;
        b=icqbDhBrxpoXaDTB9GXlyDfU7To5JzmT/Ju285ozn1a7hb8zvUXbfaWaUYaXsZTgGU
         ys9xSEU8uDGvej9UXTbhlU6jVuIpk72zKT9k28vRpG4f7CBuqlDAVSLl5qbA0hOxv9PQ
         z6oYAjAuyfHVH1wJo5mTr9rBPH3Y0Lbol3c4C3AdCO8BGslmK45ATfnHsC8we+nOSg7c
         LPMCs5e7DAmrEG9CrsbNtJvFDP8UFsN5xRacVyYZFkEZp6q5RgUXv6mtyHZXXVxBn0TT
         c+Bi7Wx99JUH/HNSLm0SL9W/L6PM7yGIePjQD0w5FC4wC42JtZffHTMCFjjwv3p4WRhU
         mX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694809530; x=1695414330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIpYKgze7l+4kxt1H4ShRKX1dLLu6xyjGygZfgTzVnI=;
        b=jk6O0RydNyeYGKWKDs2prkoi3W0TsPrNfLni9i+t8dVTXW/Vselq89bLpAzpSrZelh
         4yTc/KjcohlFV15/k240rz4j4GJyahborUrybeCoJsRX5+B4lCPN91pgtDzq4lFqvLap
         eP9pNFY6CALhWFfBH8M4HJrKZaxwJp7B4Cl1Apgqc2YX+GSFKRqm1L/YH204UGAHQvKO
         /ptrSSy2qJpAI63XWVPLHrE3uTbEmMEB55+jS1CEzvaSLZKIBokdBRGxB9XSbO6bKuSX
         2FHnkS65eyGFhf2g4D+9Gde9yLIk5bMl/lrdmZgkl5g5n0UggnwRCSNSx0AaLxznatOF
         5w/Q==
X-Gm-Message-State: AOJu0Yy7tidOKhfVcnF1+5dtweR9jfqPE3wkuiGmhMq6HKE7ZCrtK89k
	Uk4Q/ScSYsjl/+UOfuUSS2DEBuwg26BYjiPl3ely+QYJmdQ=
X-Google-Smtp-Source: AGHT+IG9s5SGn1Iitdi65l5D5QpKcBg4gsnqw516p5ES4HtgkralaS7E1nXYs0UJnfktXmPsryviKO4Z2Xlz+dflCpI=
X-Received: by 2002:adf:fb08:0:b0:31f:e534:2d6f with SMTP id
 c8-20020adffb08000000b0031fe5342d6fmr1961692wrr.11.1694809529639; Fri, 15 Sep
 2023 13:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-5-zhouchuyi@bytedance.com> <CAEf4BzY4qabpk3SD-GA5n5++REcXCxTtA4ythsR9HKHtGi33xA@mail.gmail.com>
 <8f27e07e-e23c-af80-90eb-b1123e1f68cd@bytedance.com>
In-Reply-To: <8f27e07e-e23c-af80-90eb-b1123e1f68cd@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Sep 2023 13:25:18 -0700
Message-ID: <CAEf4BzaFaf4K7T5QxXrSYQjWSg+2fqNP8bTud7TJcg3etGrR=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] bpf: Introduce css_descendant open-coded
 iterator kfuncs
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 4:57=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> Hello.
>
> =E5=9C=A8 2023/9/15 07:26, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Tue, Sep 12, 2023 at 12:02=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedanc=
e.com> wrote:
> >>
> >> This Patch adds kfuncs bpf_iter_css_{pre,post}_{new,next,destroy} whic=
h
> >> allow creation and manipulation of struct bpf_iter_css in open-coded
> >> iterator style. These kfuncs actually wrapps css_next_descendant_{pre,
> >> post}. BPF programs can use these kfuncs through bpf_for_each macro fo=
r
> >> iteration of all descendant css under a root css.
> >>
> >> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> >> ---
> >>   include/uapi/linux/bpf.h       |  8 +++++
> >>   kernel/bpf/helpers.c           |  6 ++++
> >>   kernel/bpf/task_iter.c         | 53 ++++++++++++++++++++++++++++++++=
++
> >>   tools/include/uapi/linux/bpf.h |  8 +++++
> >>   tools/lib/bpf/bpf_helpers.h    | 12 ++++++++
> >>   5 files changed, 87 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index befa55b52e29..57760afc13d0 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -7326,4 +7326,12 @@ struct bpf_iter_process {
> >>          __u64 __opaque[1];
> >>   } __attribute__((aligned(8)));
> >>
> >> +struct bpf_iter_css_pre {
> >> +       __u64 __opaque[2];
> >> +} __attribute__((aligned(8)));
> >> +
> >> +struct bpf_iter_css_post {
> >> +       __u64 __opaque[2];
> >> +} __attribute__((aligned(8)));
> >> +
> >>   #endif /* _UAPI__LINUX_BPF_H__ */
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 9b7d2c6f99d1..ca1f6404af9e 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -2510,6 +2510,12 @@ BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, K=
F_ITER_DESTROY)
> >>   BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
> >>   BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL=
)
> >>   BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
> >> +BTF_ID_FLAGS(func, bpf_iter_css_pre_new, KF_ITER_NEW)
> >> +BTF_ID_FLAGS(func, bpf_iter_css_pre_next, KF_ITER_NEXT | KF_RET_NULL)
> >> +BTF_ID_FLAGS(func, bpf_iter_css_pre_destroy, KF_ITER_DESTROY)
> >> +BTF_ID_FLAGS(func, bpf_iter_css_post_new, KF_ITER_NEW)
> >> +BTF_ID_FLAGS(func, bpf_iter_css_post_next, KF_ITER_NEXT | KF_RET_NULL=
)
> >> +BTF_ID_FLAGS(func, bpf_iter_css_post_destroy, KF_ITER_DESTROY)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> >> index 9d1927dc3a06..8963fc779b87 100644
> >> --- a/kernel/bpf/task_iter.c
> >> +++ b/kernel/bpf/task_iter.c
> >> @@ -880,6 +880,59 @@ __bpf_kfunc void bpf_iter_process_destroy(struct =
bpf_iter_process *it)
> >>   {
> >>   }
> >>
> >> +struct bpf_iter_css_kern {
> >> +       struct cgroup_subsys_state *root;
> >> +       struct cgroup_subsys_state *pos;
> >> +} __attribute__((aligned(8)));
> >> +
> >> +__bpf_kfunc int bpf_iter_css_pre_new(struct bpf_iter_css_pre *it,
> >> +               struct cgroup_subsys_state *root)
> >
> > similar to my comment on previous patches, please see
> > kernel/bpf/cgroup_iter.c for iter/cgroup iterator program. Let's stay
> > consistent. We have one iterator that accepts parameters defining
> > iteration order and starting cgroup. Unless there are some technical
> > reasons we can't follow similar approach with this open-coded iter,
> > let's use the same approach. We can even reuse
> > BPF_CGROUP_ITER_DESCENDANTS_PRE, BPF_CGROUP_ITER_DESCENDANTS_POST,
> > BPF_CGROUP_ITER_ANCESTORS_UP enums.
> >
>
> I know your concern. It would be nice if we keep consistent with
> kernel/bpf/cgroup_iter.c
>
> But this patch actually want to support iterating css
> (cgroup_subsys_state) not cgroup (css is more low lever).
> With css_iter we can do something like
> "for_each_mem_cgroup_tree/cpuset_for_each_descendant_pre"
> in BPF Progs which is hard for cgroup_iter. In the future we can use
> this iterator to plug some customizable policy in other resource control
> system.

That's fine if it's not exactly cgroup iter and returns a different
kernel object. But let's at least consistently use
BPF_CGROUP_ITER_DESCENDANTS_PRE/BPF_CGROUP_ITER_DESCENDANTS_POST/BPF_CGROUP=
_ITER_ANCESTORS_UP
approach as a way to specify iteration order?

>
> BTW, what I did in RFC actually very similar with the approach of
> cgroup_iter.
> (https://lore.kernel.org/all/20230827072057.1591929-4-zhouchuyi@bytedance=
.com/).
>
> Thanks.

