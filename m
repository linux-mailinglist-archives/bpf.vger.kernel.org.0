Return-Path: <bpf+bounces-13849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2327DE807
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 23:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB76B21013
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DD21B296;
	Wed,  1 Nov 2023 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/XfQ2QW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6498F6130
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 22:21:52 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D936211D
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 15:21:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so469043a12.2
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698877308; x=1699482108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hKO352Xlc8yqFINjq99IEYr5+Rs7MbLLbX/HF5a4d0=;
        b=E/XfQ2QW/EB9pzoJit1AX3WiyJywj/dvlPeSVUykDruSulhHWN1+UOWp7BMItkCAQ0
         RZAtHH063KTAgf0NLUlR8ndfoUKoHK766QTZcA+3M6RXlqI+pLq++Hz3eZ/7OQ21crt5
         /ZoKb9RK9veV2UVq5peegDslK3ZmcmWgP19kN6DpMjezulX+yLubKbF6zjzKBUo+qh9u
         tkGyJi4pIQwkX7JiwvrJcI3p9HZsaQs3N5OvLtCZvaQfQMMHAXvNxnOWjKGhVETNkbit
         VS4A+D0sHGpQES8EqOW8oOR1C8DBL4wjUEhHiUOGv8x0vGUUzANjnSKIjOo8ir+/NAg/
         7etQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698877308; x=1699482108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hKO352Xlc8yqFINjq99IEYr5+Rs7MbLLbX/HF5a4d0=;
        b=MJbG/Ut2hY6TnruBPTT5N5aY8pqqtkHdCoq6qT8N5nmsp2sGQDUro/s2T/19/bpZqj
         k1Ktzdka0Q7KpmU/FLW2IUN5A+tYzAXsnKqb9gBPExsg7Zo/QB0csaTRfrRxzNFrPqMG
         BcZl5UTKQvInlzX2XihH0Pt93M4bhiqMGKE7UcF9Dq50sHLY+4ipreKzAoRaeaPjG72h
         Jo9dJjp7uQ9flppqyBrm44Mxoq7BTQ/R07v6wVCm13dKFsEJ9f4CXRAp/a5KfSIPfSDX
         O7FvzOTW8JKssS1WdVWoq+YhVwAmQ4zNBwEgnVAaLVCv1pzamCjivK7uFiYb2m7dlwXs
         UGTg==
X-Gm-Message-State: AOJu0YyK6LlR+Xj/uz11hiMpNeZueVTGrsH+Sa3YULEC8JGLhQkR/HBw
	wS/FMlIdM9gLrpVA7xf/EaRMVx3FBvl/cCTjVIg=
X-Google-Smtp-Source: AGHT+IGPGd2jEYfjlKuxx0VSx1Su5gd1Y/Ah9mSCqs3dW7osys7k703AnXUvqJ10ry35Xe3paafBtO36gjFsINsajN0=
X-Received: by 2002:a17:906:fd89:b0:9b9:a1dd:5105 with SMTP id
 xa9-20020a170906fd8900b009b9a1dd5105mr3463926ejb.50.1698877308113; Wed, 01
 Nov 2023 15:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-4-jolsa@kernel.org>
In-Reply-To: <20231025202420.390702-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 15:21:36 -0700
Message-ID: <CAEf4Bzbi8EgT-CC9jS69sV2whk1Dnr-WV5mRyCs=W3JxOMvtWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Add link_info support for uprobe multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 1:24=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
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
> +                       __u32 path_max; /* in/out: uprobe_multi path size=
 */

people already called out that path_size makes for a better name, I agree

> +                       __u32 count;    /* in/out: uprobe_multi offsets/r=
ef_ctr_offsets/cookies count */

otherwise we'd have to call this count_max :)

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

on attach we do

task =3D get_pid_task(find_vpid(pid), PIDTYPE_PID);

So on attachment we take pid in user's namespace, is that right? It's
kind of asymmetrical that we return the global PID back? Should we try
to convert PID to user's namespace instead?

> +
> +       if (upath) {
> +               if (upath_max > PATH_MAX)
> +                       return -E2BIG;

no need to fail here, as pointed out elsewhere

> +               buf =3D kmalloc(upath_max, GFP_KERNEL);

here we can allocate min(PATH_MAX, upath_max)

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

it would be good to still return actual counts for out parameters, no?

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

[...]

