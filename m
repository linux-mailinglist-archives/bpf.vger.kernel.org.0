Return-Path: <bpf+bounces-15570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0024F7F3648
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311AA1C20DA7
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C45916405;
	Tue, 21 Nov 2023 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dltIvtaU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1CACB
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 10:41:38 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548f6f3cdc9so1847733a12.2
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 10:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700592097; x=1701196897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkN3yzB+ctjHWSXOnp3RvwSgr/T1Rhm8QuPQqazX2xc=;
        b=dltIvtaUQQZux+m6Jgg1fX/FtSBcjPLIezLp+onZsr6OitwFtWfQeycBRaPTC/ykYL
         gHOOqdGu1ho94YRCe7ta+BUTOeXATqo+pvr1FbNq+9ZuWhl6GcRYCzo98+NLKz/TO/VM
         FxJ8Xykgm4XPWxgdZM0l68xjTeqd/Zaa0hetdE3pVVLuLFTwwdYSGJ0N/aJwWwZ5Qrba
         fd4WbOAYUPiy3qxpOXwVgL4DsxGGOXCDKaoNrCsOcnM7PxnfHhWQPh0DYMuZdGp2awNM
         ClD1UrqJrZWqYc3580hqVouNlZIvh4nypqtmxO/8k0t6vzRibB0vrVLmiknm+zgsu5aD
         2lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700592097; x=1701196897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkN3yzB+ctjHWSXOnp3RvwSgr/T1Rhm8QuPQqazX2xc=;
        b=KwwIPW3xfGHl+7My9B5H25a/DQL9BYcA4RSh4vfCOKoK2Go1aGwQA3vVmej0woytSE
         L0gNqH9+Q+Yp7x5m9hS81+hIRnIseo2Y/JGTHweEV0Z3nmtiJvTwSyo3mePzko81nHhA
         zFXnXIrRxfnOTyNTqa6759O5s4ezGZJePb6m4+tIeaWVpfkdbnr0cA+X2YVCvZNY4waD
         q+KYW1ui7hmlqJqRW6wvz7MuyuDc0bLxouzQumHT6p85J9QQGi9NjKPspvuGMdl3k2aH
         FDpgUg/9zlq5m1sNYzkljoFgWOH8IyHo3uGgvTrPSuBGIClvzQCFPfmBAqVK6Xccbuj3
         atvw==
X-Gm-Message-State: AOJu0YyVTccUazpZmst2pKEjZBqmFP513PGH5VurKEtWuo1FhkX5KNJH
	FVF/+l8E6VZdoClzB25OpjYT60+f0vgwWoEdY24=
X-Google-Smtp-Source: AGHT+IHpbTejSukUrzDrwMa82lwwnbMKUATVYqKeh7F17Phd4ZIsORZ3RU9L/LGXjHAUaS9txukYVavi5o8SHja5MOw=
X-Received: by 2002:a17:906:535b:b0:a02:8b23:895d with SMTP id
 j27-20020a170906535b00b00a028b23895dmr1494642ejo.35.1700592096532; Tue, 21
 Nov 2023 10:41:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120145639.3179656-1-jolsa@kernel.org> <20231120145639.3179656-4-jolsa@kernel.org>
In-Reply-To: <20231120145639.3179656-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 Nov 2023 10:41:24 -0800
Message-ID: <CAEf4BzY0EpOorNs2Vm0ijeYsL7doAf4-mQBoz6y1xpWb2bWY6Q@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 3/6] bpf: Add link_info support for uprobe
 multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 6:57=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
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
>  kernel/trace/bpf_trace.c       | 72 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 10 +++++
>  3 files changed, 92 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 7a5498242eaa..a63b5eb7f9ec 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6562,6 +6562,16 @@ struct bpf_link_info {
>                         __u32 flags;
>                         __u64 missed;
>                 } kprobe_multi;
> +               struct {
> +                       __aligned_u64 path;
> +                       __aligned_u64 offsets;
> +                       __aligned_u64 ref_ctr_offsets;
> +                       __aligned_u64 cookies;
> +                       __u32 path_size; /* in/out: real path size on suc=
cess */
> +                       __u32 count; /* in/out: uprobe_multi offsets/ref_=
ctr_offsets/cookies count */
> +                       __u32 flags;
> +                       __u32 pid;
> +               } uprobe_multi;
>                 struct {
>                         __u32 type; /* enum bpf_perf_event_type */
>                         __u32 :32;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index ad0323f27288..ca453b642819 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3044,6 +3044,7 @@ struct bpf_uprobe_multi_link {
>         u32 cnt;
>         struct bpf_uprobe *uprobes;
>         struct task_struct *task;
> +       u32 flags;

this fits better after cnt to avoid increasing the size of
bpf_uprobe_multi_link, please it move up

>  };
>
>  struct bpf_uprobe_multi_run_ctx {
> @@ -3083,9 +3084,79 @@ static void bpf_uprobe_multi_link_dealloc(struct b=
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
> +       u32 upath_size =3D info->uprobe_multi.path_size;
> +       struct bpf_uprobe_multi_link *umulti_link;
> +       u32 ucount =3D info->uprobe_multi.count;
> +       int err =3D 0, i;
> +       long left;
> +
> +       if (!upath ^ !upath_size)
> +               return -EINVAL;
> +
> +       if ((uoffsets || uref_ctr_offsets || ucookies) && !ucount)
> +               return -EINVAL;
> +
> +       umulti_link =3D container_of(link, struct bpf_uprobe_multi_link, =
link);
> +       info->uprobe_multi.count =3D umulti_link->cnt;
> +       info->uprobe_multi.flags =3D umulti_link->flags;
> +       info->uprobe_multi.pid =3D umulti_link->task ?
> +                                task_pid_nr_ns(umulti_link->task, task_a=
ctive_pid_ns(current)) : 0;
> +
> +       if (upath) {
> +               char *p, *buf;
> +
> +               upath_size =3D min_t(u32, upath_size, PATH_MAX);
> +
> +               buf =3D kmalloc(upath_size, GFP_KERNEL);
> +               if (!buf)
> +                       return -ENOMEM;
> +               p =3D d_path(&umulti_link->path, buf, upath_size);
> +               if (IS_ERR(p)) {
> +                       kfree(buf);
> +                       return -ENOSPC;
> +               }
> +               upath_size =3D buf + upath_size - p;
> +               left =3D copy_to_user(upath, p, upath_size);
> +               kfree(buf);
> +               if (left)
> +                       return -EFAULT;
> +               info->uprobe_multi.path_size =3D upath_size - 1 /* NULL *=
/;

why subtract zero terminating byte? I think we should drop this -1 and
return filled out buffer content size, including zero terminator.


> +       }
> +
> +       if (!uoffsets && !ucookies && !uref_ctr_offsets)
> +               return 0;
> +
> +       if (ucount < umulti_link->cnt)
> +               err =3D -ENOSPC;
> +       else
> +               ucount =3D umulti_link->cnt;
> +
> +       for (i =3D 0; i < ucount; i++) {
> +               if (uoffsets &&
> +                   put_user(umulti_link->uprobes[i].offset, uoffsets + i=
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
> @@ -3274,6 +3345,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
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
> index 7a5498242eaa..a63b5eb7f9ec 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6562,6 +6562,16 @@ struct bpf_link_info {
>                         __u32 flags;
>                         __u64 missed;
>                 } kprobe_multi;
> +               struct {
> +                       __aligned_u64 path;
> +                       __aligned_u64 offsets;
> +                       __aligned_u64 ref_ctr_offsets;
> +                       __aligned_u64 cookies;
> +                       __u32 path_size; /* in/out: real path size on suc=
cess */
> +                       __u32 count; /* in/out: uprobe_multi offsets/ref_=
ctr_offsets/cookies count */
> +                       __u32 flags;
> +                       __u32 pid;
> +               } uprobe_multi;
>                 struct {
>                         __u32 type; /* enum bpf_perf_event_type */
>                         __u32 :32;
> --
> 2.42.0
>

