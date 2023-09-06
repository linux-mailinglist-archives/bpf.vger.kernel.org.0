Return-Path: <bpf+bounces-9343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A2B7941BE
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 18:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89631C209DC
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61F110966;
	Wed,  6 Sep 2023 16:55:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D2A46A2
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 16:55:22 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAEB1739;
	Wed,  6 Sep 2023 09:55:20 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so1300611fa.3;
        Wed, 06 Sep 2023 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694019319; x=1694624119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgRmT/51AfHvv+OnqKBshN0QtQQLvJAcOtCOsY0aKOU=;
        b=loB+enym3DctEuoiIoKx7K8tQiEn6OjR6zd/GpwW8wCX2L/InPIyU2XOZT21A3iM3C
         Og6HEThL/tVnsfP6hCE/00dIVwGb2eIHDTZ5qeD7FhV5uphw7KZH3Ctub5Fs3/Kuiq5j
         6OfOjjMLU+mAQQQ8yzbSdsU6F5v2OvXDFIaC/51fjTVbkXgCmowzkJdeawmS6dyAMbll
         JNBODzZNiC7KKDht4FbjY8QBCyQt09nyqtePoDK/DI2XjY/eSWMAksKxXGH3k9iTp3Z/
         5z/lFLzzMmE0M7SA8ePClRyjLXaa8XwrqovAiJ1MS7XfafBsi9B+YHWi42bG7XQVnFzZ
         kcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694019319; x=1694624119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgRmT/51AfHvv+OnqKBshN0QtQQLvJAcOtCOsY0aKOU=;
        b=JfT61atUYX3r8t826nYQSWGXuIFUHUrYgPgBNYqWRgl3VDV2EXKp0B68SuLvGw11oW
         FWO8/6l2H/b5ld4A80rYYy0Li5LNfJVIaOAjUURP9vUBcsqYZhdYfMz6CsNPsQcX11XP
         dGoCjP4kAKaYBO/MKscJvSuwXHLdGgT348U2Oi+kKsevsV3ltoLGYzi7g34VedOc34No
         UT9PWxDByN6C1m2ZUSYreQVb/IsRhy/gNUkDTeVsCpZ1x8Q51QIryU7NDF51xLrahlDb
         LutVWPsslU7J8ECdJmIcYKkrnrOAHGn1rCDxXj5oSHRKig0zqsKBJSQ2Q2BeksdhSuWo
         CKyQ==
X-Gm-Message-State: AOJu0YxK4nD1xYbiKX5QGzORYWRu6OE+QLZCgaETKjwtDJHG/FXltCPw
	XH6w4FsAx0V1Bwo5BoDdu0C1d2I6M+pbxJaw/58=
X-Google-Smtp-Source: AGHT+IF/9g2+P74x+BTWJE2boocwtX+unlBTHW8roXl9veq9bYKAc5YPxx3DReAGzC7Do7nh4RXvhnL3w4lRgHId0+w=
X-Received: by 2002:a2e:9859:0:b0:2bd:1fee:aacf with SMTP id
 e25-20020a2e9859000000b002bd1feeaacfmr2916687ljj.24.1694019318672; Wed, 06
 Sep 2023 09:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
 <20230827072057.1591929-2-zhouchuyi@bytedance.com> <CAADnVQJpZRoOtC0JF7uub+vPY5JZusWmPyjOJQD=eTxUFWOr_A@mail.gmail.com>
 <c4791970-720e-7c1c-0e81-915dbcb23139@bytedance.com>
In-Reply-To: <c4791970-720e-7c1c-0e81-915dbcb23139@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Sep 2023 09:55:07 -0700
Message-ID: <CAADnVQKwTOPry9ETFekWbmRyUWDLNzVJXtG1ec-CJZMMFdii7w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/4] bpf: Introduce css_task open-coded
 iterator kfuncs
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 6, 2023 at 5:37=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com>=
 wrote:
>
> Hello,
>
> =E5=9C=A8 2023/9/6 03:02, Alexei Starovoitov =E5=86=99=E9=81=93:
> > On Sun, Aug 27, 2023 at 12:21=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedanc=
e.com> wrote:
> >>
> >> This Patch adds kfuncs bpf_iter_css_task_{new,next,destroy} which allo=
w
> >> creation and manipulation of struct bpf_iter_css_task in open-coded
> >> iterator style. These kfuncs actually wrapps
> >> css_task_iter_{start,next,end}. BPF programs can use these kfuncs thro=
ugh
> >> bpf_for_each macro for iteration of all tasks under a css.
> >>
> >> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> >> ---
> >>   include/uapi/linux/bpf.h       |  4 ++++
> >>   kernel/bpf/helpers.c           |  3 +++
> >>   kernel/bpf/task_iter.c         | 39 ++++++++++++++++++++++++++++++++=
++
> >>   tools/include/uapi/linux/bpf.h |  4 ++++
> >>   tools/lib/bpf/bpf_helpers.h    |  7 ++++++
> >>   5 files changed, 57 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 60a9d59beeab..2a6e9b99564b 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -7195,4 +7195,8 @@ struct bpf_iter_num {
> >>          __u64 __opaque[1];
> >>   } __attribute__((aligned(8)));
> >>
> >> +struct bpf_iter_css_task {
> >> +       __u64 __opaque[1];
> >> +} __attribute__((aligned(8)));
> >> +
> >>   #endif /* _UAPI__LINUX_BPF_H__ */
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 9e80efa59a5d..cf113ad24837 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -2455,6 +2455,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET=
_NULL)
> >>   BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> >>   BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
> >>   BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> >> +BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
> >> +BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL=
)
> >> +BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> >> index c4ab9d6cdbe9..b1bdba40b684 100644
> >> --- a/kernel/bpf/task_iter.c
> >> +++ b/kernel/bpf/task_iter.c
> >> @@ -823,6 +823,45 @@ const struct bpf_func_proto bpf_find_vma_proto =
=3D {
> >>          .arg5_type      =3D ARG_ANYTHING,
> >>   };
> >>
> >> +struct bpf_iter_css_task_kern {
> >> +       struct css_task_iter *css_it;
> >> +} __attribute__((aligned(8)));
> >> +
> >> +__bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
> >> +               struct cgroup_subsys_state *css, unsigned int flags)
> >> +{
> >> +       struct bpf_iter_css_task_kern *kit =3D (void *)it;
> >> +
> >> +       BUILD_BUG_ON(sizeof(struct bpf_iter_css_task_kern) !=3D sizeof=
(struct bpf_iter_css_task));
> >> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_css_task_kern) !=3D
> >> +                                       __alignof__(struct bpf_iter_cs=
s_task));
> >> +
> >> +       kit->css_it =3D kzalloc(sizeof(struct css_task_iter), GFP_KERN=
EL);
> >> +       if (!kit->css_it)
> >> +               return -ENOMEM;
> >> +       css_task_iter_start(css, flags, kit->css_it);
> >
> > Some of the flags are internal. Like CSS_TASK_ITER_SKIPPED.
> > The kfunc should probably only allow CSS_TASK_ITER_PROCS |
> > CSS_TASK_ITER_THREADED,
> > and not CSS_TASK_ITER_THREADED alone.
> >
> > Since they're #define-s it's not easy for bpf prog to use them.
> > I think would be good to have a pre-patch that converts them to enum,
> > so that bpf prog can take them from vmlinux.h.
> >
> >
> > But the main issue of the patch that it adds this iter to common kfuncs=
.
> > That's not safe, since css_task_iter_*() does spin_unlock_irq() which
> > might screw up irq flags depending on the context where bpf prog is run=
ning.
> > Can css_task_iter internals switch to irqsave/irqrestore?
>
> Yes, I think so. Switching to irqsave/irqrestore is no harm.
>
> > css_set_lock is also global, so the bpf side has to be careful in
> > where it allows to use this iter.
> > bpf_lsm hooks are safe, most of bpf iter-s are safe too.
> > Future bpf-oom hooks are probably safe as well.
> > We probably need an allowlist here.
>
> What should we do if we want to make a allowlist?
> Do you mean we need to check prog_type or attach_type when we call these
> kfuncs in BPF verifier? If so, we should add a new attach_type or
> prog_type for bpf-oom in the feature so we can know the current BPF
> program is hooking for OOM Policy.

bpf-oom type can be added later. Let's make this one work for bpf-lsm
and sleepable iter-s first. See SEC("iter.s

