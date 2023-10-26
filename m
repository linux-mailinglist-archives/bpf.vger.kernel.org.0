Return-Path: <bpf+bounces-13310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A94F7D8219
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 13:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE4B4B21382
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 11:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE3A2D7A9;
	Thu, 26 Oct 2023 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXDhx/78"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F1812B69
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 11:58:06 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E151A6
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 04:58:04 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d134a019cso5592976d6.3
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 04:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698321484; x=1698926284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTW+CPaCz7fgBCgR7sIBmPo0Eum46EXPkolrFn59hho=;
        b=BXDhx/789sQvi3ssiYvAmI3IaZWXjqhsTaWMEE6UoJw0soajs7nbYnSJ2VJ5a3ZuoE
         96Gt/e3ryT2mJayoQaMxtdwPDpJ3rOcM546tJCR0TKigwx+NjqExwFIghPlo/ZeqCrKK
         PVS1hboIf++zzmU7MFMYNO0IztJluoFr2W2VENw8DIQeB/LwacgboYDKUY4/SPDxO96h
         a6Jhe/7Bd92mA2oaM4AR+DqcY4EyHDjvzMe4o08aHv0vHv0LawR4ciPAqIH2pvhH1KCx
         N+RVSvFgHhbNGmt5uyolt5q1qOAuPMew54gkRtPfdQ7excM6AEDZy8hNjDcUfTvhvbJU
         1s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698321484; x=1698926284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTW+CPaCz7fgBCgR7sIBmPo0Eum46EXPkolrFn59hho=;
        b=RqbWM3qgkyEJSGzUD7himIu+CvmDOFjnFL7E+CK2vInZFrqqfmkFpPUBvRRjC3Y5HK
         kIhNmT0OGjzGyNMiQzg5qdAEXG7EroKYJVt6oCbPAR9tdITkGJdmIV234Hwwak1ZM+jK
         Jlqa2dsxOa6XGg5DKWC8H7hY8jSWifLUahQayMD0kJ6lP8/xPg9vXfWrWtVEqbd1gThM
         lYKF5lLSJhafPjjxubQwTg+tQgl/aXnJSf5U0y77NcuBw52wBew+JG+saZ1mwdGeZ3Ql
         BNYyKOs0Pq4HraaoXJJyyl5+bW63OMfsjkXt7b8NO2HxuwtPRChqLcGBwo7p4ShW+OmA
         5m8g==
X-Gm-Message-State: AOJu0YyzrPn9FIY4uY+0aonJq7T4dDyYZ2AELlo4AvefkKmf60n5ULvs
	0kVlR2x92EN/StXCgahnwaFk8UcaZMtRf3QJ0xQ=
X-Google-Smtp-Source: AGHT+IFKZLRCoB9Q/NziNbMTXX+nwZZSatP6KZi/GN739tm3hlhN0DPmsXykq4oFd3j5ZuLtqqUwk+JtRRKdcV0Lshc=
X-Received: by 2002:a05:6214:5186:b0:66d:1021:5e8d with SMTP id
 kl6-20020a056214518600b0066d10215e8dmr21443088qvb.10.1698321483911; Thu, 26
 Oct 2023 04:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-4-jolsa@kernel.org>
In-Reply-To: <20231025202420.390702-4-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 26 Oct 2023 19:57:27 +0800
Message-ID: <CALOAHbAZ6=A9j3VFCLoAC_WhgQKU7injMf06=cM2sU4Hi4Sx+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Add link_info support for uprobe multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 4:24=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to get uprobe_link details through bpf_link_info
> interface.
>
> Adding new struct uprobe_multi to struct bpf_link_info to carry
> the uprobe_multi link details.
>
> The uprobe_multi.count is passed from user space to denote size
> of array fields (offsets/ref_ctr_offsets/cookies). The actual
> array size is stored back to uprobe_multi.count (allowing user
> to find out the actual array size) and array fields are populated
> up to the user passed size.
>
> All the non-array fields (path/count/flags/pid) are always set.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/bpf.h       | 10 +++++
>  kernel/trace/bpf_trace.c       | 68 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 10 +++++
>  3 files changed, 88 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0f6cdf52b1da..960cf2914d63 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6556,6 +6556,16 @@ struct bpf_link_info {
>                         __u32 flags;
>                         __u64 missed;
>                 } kprobe_multi;
> +               struct {
> +                       __aligned_u64 path;
> +                       __aligned_u64 offsets;
> +                       __aligned_u64 ref_ctr_offsets;
> +                       __aligned_u64 cookies;

The bpf cookie for the perf_event link is exposed through
'pid_iter.bpf.c,' while the cookies for the tracing link and
kprobe_multi link are not exposed at all. This inconsistency can be
confusing. I believe it would be better to include all of them in the
link_info. The reason is that 'pid_iter' depends on the task holding
the links, which may not exist. However, I think we handle this in a
separate patchset. What do you think?

> +                       __u32 path_max; /* in/out: uprobe_multi path size=
 */
> +                       __u32 count;    /* in/out: uprobe_multi offsets/r=
ef_ctr_offsets/cookies count */
> +                       __u32 flags;
> +                       __u32 pid;
> +               } uprobe_multi;
>                 struct {
>                         __u32 type; /* enum bpf_perf_event_type */
>                         __u32 :32;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 843b3846d3f8..9f8ad19a1a93 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3042,6 +3042,7 @@ struct bpf_uprobe_multi_link {
>         u32 cnt;
>         struct bpf_uprobe *uprobes;
>         struct task_struct *task;
> +       u32 flags;
>  };
>
>  struct bpf_uprobe_multi_run_ctx {
> @@ -3081,9 +3082,75 @@ static void bpf_uprobe_multi_link_dealloc(struct b=
pf_link *link)
>         kfree(umulti_link);
>  }
>
> +static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *l=
ink,
> +                                               struct bpf_link_info *inf=
o)
> +{
> +       u64 __user *uref_ctr_offsets =3D u64_to_user_ptr(info->uprobe_mul=
ti.ref_ctr_offsets);
> +       u64 __user *ucookies =3D u64_to_user_ptr(info->uprobe_multi.cooki=
es);
> +       u64 __user *uoffsets =3D u64_to_user_ptr(info->uprobe_multi.offse=
ts);
> +       u64 __user *upath =3D u64_to_user_ptr(info->uprobe_multi.path);
> +       u32 upath_max =3D info->uprobe_multi.path_max;
> +       struct bpf_uprobe_multi_link *umulti_link;
> +       u32 ucount =3D info->uprobe_multi.count;
> +       int err =3D 0, i;
> +       char *p, *buf;
> +       long left;
> +
> +       if (!upath ^ !upath_max)
> +               return -EINVAL;
> +
> +       if (!uoffsets ^ !ucount)
> +               return -EINVAL;
> +
> +       umulti_link =3D container_of(link, struct bpf_uprobe_multi_link, =
link);
> +       info->uprobe_multi.count =3D umulti_link->cnt;
> +       info->uprobe_multi.flags =3D umulti_link->flags;
> +       info->uprobe_multi.pid =3D umulti_link->task ?
> +                                task_pid_nr(umulti_link->task) : (u32) -=
1;
> +
> +       if (upath) {
> +               if (upath_max > PATH_MAX)
> +                       return -E2BIG;
> +               buf =3D kmalloc(upath_max, GFP_KERNEL);
> +               if (!buf)
> +                       return -ENOMEM;
> +               p =3D d_path(&umulti_link->path, buf, upath_max);
> +               if (IS_ERR(p)) {
> +                       kfree(buf);
> +                       return -ENOSPC;
> +               }
> +               left =3D copy_to_user(upath, p, buf + upath_max - p);
> +               kfree(buf);
> +               if (left)
> +                       return -EFAULT;
> +       }
> +
> +       if (!uoffsets)
> +               return 0;
> +
> +       if (ucount < umulti_link->cnt)
> +               err =3D -ENOSPC;
> +       else
> +               ucount =3D umulti_link->cnt;
> +
> +       for (i =3D 0; i < ucount; i++) {
> +               if (put_user(umulti_link->uprobes[i].offset, uoffsets + i=
))
> +                       return -EFAULT;
> +               if (uref_ctr_offsets &&
> +                   put_user(umulti_link->uprobes[i].ref_ctr_offset, uref=
_ctr_offsets + i))
> +                       return -EFAULT;
> +               if (ucookies &&
> +                   put_user(umulti_link->uprobes[i].cookie, ucookies + i=
))
> +                       return -EFAULT;
> +       }
> +
> +       return err;
> +}
> +
>  static const struct bpf_link_ops bpf_uprobe_multi_link_lops =3D {
>         .release =3D bpf_uprobe_multi_link_release,
>         .dealloc =3D bpf_uprobe_multi_link_dealloc,
> +       .fill_link_info =3D bpf_uprobe_multi_link_fill_link_info,
>  };
>
>  static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> @@ -3272,6 +3339,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>         link->uprobes =3D uprobes;
>         link->path =3D path;
>         link->task =3D task;
> +       link->flags =3D flags;
>
>         bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
>                       &bpf_uprobe_multi_link_lops, prog);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 0f6cdf52b1da..960cf2914d63 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6556,6 +6556,16 @@ struct bpf_link_info {
>                         __u32 flags;
>                         __u64 missed;
>                 } kprobe_multi;
> +               struct {
> +                       __aligned_u64 path;
> +                       __aligned_u64 offsets;
> +                       __aligned_u64 ref_ctr_offsets;
> +                       __aligned_u64 cookies;
> +                       __u32 path_max; /* in/out: uprobe_multi path size=
 */
> +                       __u32 count;    /* in/out: uprobe_multi offsets/r=
ef_ctr_offsets/cookies count */
> +                       __u32 flags;
> +                       __u32 pid;
> +               } uprobe_multi;
>                 struct {
>                         __u32 type; /* enum bpf_perf_event_type */
>                         __u32 :32;
> --
> 2.41.0
>


--=20
Regards
Yafang

