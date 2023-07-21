Return-Path: <bpf+bounces-5575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1075375BC98
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 04:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D90C28211B
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 02:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CF1639;
	Fri, 21 Jul 2023 02:56:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624D7F
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 02:56:36 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDE21998
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 19:56:34 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-634f59e7d47so11673696d6.2
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 19:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689908193; x=1690512993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4l3FcwZQwNRo78mDXcfGJMvzY5mnCBfbM8Ay44arfM=;
        b=icEi7qbcIjQ+AEhvgDlycu1qyLQ3vHXtQtGatMj7moQdjgg3Ta9uTFwDkOv9panmtY
         v4IbC4W/zatz80Zotn04m26SEfZjaQ+JJSxnfplS0FYdKBXXijZjwgUgM4QUxt7QzW2u
         gfJtyR8JTb5DlN19M4o7m/Zu6GyhTOBlQ1vHyzDPyfm6Bwj07K1kIS3+bn9SS7zM1Wsl
         IAbgVvFLm7bosPxJ9bNZmFHRqMicvqFL5uv1zSYXCphZliqXK0EmH0VpR1yAp4HyDYAS
         YnxZ7kHNbg/qXlO9OhQZJFIwImZsl4OEgAYlQY5lK3SbZmSOWOfLDPj7vj7lsAmS2mgO
         WFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689908193; x=1690512993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4l3FcwZQwNRo78mDXcfGJMvzY5mnCBfbM8Ay44arfM=;
        b=bFkuKWYWVyYXJiEH/OpGp89XLbu64wzFf62KzFhRD7gm5fV21LD1PfBa3uHWEA0GwS
         d2E3Jk8FSV/DhhIQxbzIeK2nIZ7qI4uCsfAgWXgDqtVR8vZxvKAqJ7ZAc+wOT3lnTF8y
         7ypBY0vRchP/PI76qXt5VsOvdHSiw1qaT8CjOIY0aDi8HAGWk49yP+njwjj/4425XYZs
         qql2I4uJYaovtNJqr4o5yA3bdqq0a3wImOw+MiRpw5jRCrsAZAIC6uxMR+G0oHKr9+rm
         0j7x26z7oB0EZix64KbvTfr4e8VH9IYE25SREFAQCxTFy3awkUf7mrJarz3DIkvUeIte
         MWpw==
X-Gm-Message-State: ABy/qLbHrVSf41k7Hd2JgCgpm16r7nBsBGCGlw5ST+hJG4QgII0GT7Dv
	95Dza4YSoyyYg7djEuokBDkxTtqLRaVhj4CIYEY=
X-Google-Smtp-Source: APBJJlE14NGbRkYMaPJOGVbNMRxCnMFsmu0GazyYkfJ5ISfH6Ed2jcK+y65Q5N9mse4ME+5Pdtpu+sEJSEM4iV1P0nM=
X-Received: by 2002:a0c:ee8a:0:b0:63c:639c:4184 with SMTP id
 u10-20020a0cee8a000000b0063c639c4184mr760749qvr.21.1689908193635; Thu, 20 Jul
 2023 19:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720113550.369257-1-jolsa@kernel.org> <20230720113550.369257-6-jolsa@kernel.org>
In-Reply-To: <20230720113550.369257-6-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 21 Jul 2023 10:55:57 +0800
Message-ID: <CALOAHbB3_qTzi+2_0=pFjyDXFUh_MGMJt6gz7eh0Z=He4guPow@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 05/28] bpf: Add pid filter support for
 uprobe_multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 7:36=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to specify pid for uprobe_multi link and the uprobes
> are created only for task with given pid value.

Is it possible to use tgid as the filter?
It would be helpful when we uprobe a library file but want to filter
out a multi-threaded task only.
There's an inherit attr in perf_event_open, but it can only apply to
newly created children, so we can't filter the tgid in uprobe.
If we can support it in uprobe_multi, that would be more useful.

>
> Using the consumer.filter filter callback for that, so the task gets
> filtered during the uprobe installation.
>
> We still need to check the task during runtime in the uprobe handler,
> because the handler could get executed if there's another system
> wide consumer on the same uprobe (thanks Oleg for the insight).
>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           |  2 +-
>  kernel/trace/bpf_trace.c       | 33 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  1 +
>  4 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c6fbb0f948f4..7b6badd4c166 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1607,6 +1607,7 @@ union bpf_attr {
>                                 __aligned_u64   cookies;
>                                 __u32           cnt;
>                                 __u32           flags;
> +                               __u32           pid;
>                         } uprobe_multi;
>                 };
>         } link_create;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 840b622b7db1..2bf986c86f2f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4832,7 +4832,7 @@ static int bpf_map_do_batch(const union bpf_attr *a=
ttr,
>         return err;
>  }
>
> -#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.cookies
> +#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.pid
>  static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>  {
>         struct bpf_prog *prog;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d73a47bd2bbd..d5f30747378a 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2998,6 +2998,7 @@ struct bpf_uprobe_multi_link {
>         struct bpf_link link;
>         u32 cnt;
>         struct bpf_uprobe *uprobes;
> +       struct task_struct *task;
>  };
>
>  struct bpf_uprobe_multi_run_ctx {
> @@ -3023,6 +3024,8 @@ static void bpf_uprobe_multi_link_release(struct bp=
f_link *link)
>
>         umulti_link =3D container_of(link, struct bpf_uprobe_multi_link, =
link);
>         bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, u=
multi_link->cnt);
> +       if (umulti_link->task)
> +               put_task_struct(umulti_link->task);
>  }
>
>  static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
> @@ -3054,6 +3057,9 @@ static int uprobe_prog_run(struct bpf_uprobe *uprob=
e,
>         struct bpf_run_ctx *old_run_ctx;
>         int err =3D 0;
>
> +       if (link->task && current !=3D link->task)
> +               return 0;
> +
>         might_fault();
>
>         migrate_disable();
> @@ -3076,6 +3082,16 @@ static int uprobe_prog_run(struct bpf_uprobe *upro=
be,
>         return err;
>  }
>
> +static bool
> +uprobe_multi_link_filter(struct uprobe_consumer *con, enum uprobe_filter=
_ctx ctx,
> +                        struct mm_struct *mm)
> +{
> +       struct bpf_uprobe *uprobe;
> +
> +       uprobe =3D container_of(con, struct bpf_uprobe, consumer);
> +       return uprobe->link->task->mm =3D=3D mm;
> +}
> +
>  static int
>  uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *r=
egs)
>  {
> @@ -3109,12 +3125,14 @@ int bpf_uprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
>         unsigned long *ref_ctr_offsets =3D NULL;
>         struct bpf_link_primer link_primer;
>         struct bpf_uprobe *uprobes =3D NULL;
> +       struct task_struct *task =3D NULL;
>         unsigned long __user *uoffsets;
>         u64 __user *ucookies;
>         void __user *upath;
>         u32 flags, cnt, i;
>         struct path path;
>         char *name;
> +       pid_t pid;
>         int err;
>
>         /* no support for 32bit archs yet */
> @@ -3158,6 +3176,15 @@ int bpf_uprobe_multi_link_attach(const union bpf_a=
ttr *attr, struct bpf_prog *pr
>                 goto error_path_put;
>         }
>
> +       pid =3D attr->link_create.uprobe_multi.pid;
> +       if (pid) {
> +               rcu_read_lock();
> +               task =3D get_pid_task(find_vpid(pid), PIDTYPE_PID);
> +               rcu_read_unlock();
> +               if (!task)
> +                       goto error_path_put;
> +       }
> +
>         err =3D -ENOMEM;
>
>         link =3D kzalloc(sizeof(*link), GFP_KERNEL);
> @@ -3192,11 +3219,15 @@ int bpf_uprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
>                         uprobes[i].consumer.ret_handler =3D uprobe_multi_=
link_ret_handler;
>                 else
>                         uprobes[i].consumer.handler =3D uprobe_multi_link=
_handler;
> +
> +               if (pid)
> +                       uprobes[i].consumer.filter =3D uprobe_multi_link_=
filter;
>         }
>
>         link->cnt =3D cnt;
>         link->uprobes =3D uprobes;
>         link->path =3D path;
> +       link->task =3D task;
>
>         bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
>                       &bpf_uprobe_multi_link_lops, prog);
> @@ -3225,6 +3256,8 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>         kvfree(ref_ctr_offsets);
>         kvfree(uprobes);
>         kfree(link);
> +       if (task)
> +               put_task_struct(task);
>  error_path_put:
>         path_put(&path);
>         return err;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 492072ef5029..8e163ed0be9a 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1607,6 +1607,7 @@ union bpf_attr {
>                                 __aligned_u64   cookies;
>                                 __u32           cnt;
>                                 __u32           flags;
> +                               __u32           pid;
>                         } uprobe_multi;
>                 };
>         } link_create;
> --
> 2.41.0
>
>


--=20
Regards
Yafang

