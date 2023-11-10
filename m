Return-Path: <bpf+bounces-14731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAF37E793F
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF5C281829
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD7163C9;
	Fri, 10 Nov 2023 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwr7N+lH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840163C0
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:24:33 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F556F96
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:24:32 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso2741640a12.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 22:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699597471; x=1700202271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w1OTs2iAZ4CoeDnNHFBWFK7vy9O5uKp89JlpLVHQZA=;
        b=Kwr7N+lH5DPxg5lVRgbQ1OcoEP8XNTXMMc1fFrb+uSfeCiq6d+LTOQqyTk+ll+kEaH
         avkvdTAyuVFNKqGcRKfRIXKJEl6pjt4vKY3zUom420PLefYOWXRi/LbeNXSXafbclLPv
         DbmQc9pNKOaxpe2aEqbEG5ug6kC97nPFNTjyWt+RygtozLS7KJzHHwOX9+R/cLJogF51
         scPE1bbG/S88VCcboyuBq/qQ5SrFAmhU2USkMlL2qzK2SzoAv0+zmJkZFBX6uWuyUVgP
         F0wxHSxID+ikpTgif50sNANEQeWDTH3BgzGRQ6HfyhH1hUviP1/jVphpSP9UIC47uzAE
         SyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597471; x=1700202271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3w1OTs2iAZ4CoeDnNHFBWFK7vy9O5uKp89JlpLVHQZA=;
        b=J2wcNBhTwSnsnXz2H2KxoOEziPFyKlbdFPq22KXeUfaZotSa/GVw4+eNqrH+TJ8Yrf
         axOMP0k9juo5BoGyBQA1yp0D09nrDv+dwfx/0h5k0x8YCq66VdUKX/wcGlez6ZQlCH8+
         kkjxDzYOjdibKhGCk+ZkrRS7UgAQiFbnOXmQAabPuQAMrBgCsrp08AAF23q77CfmfMYC
         HCc3qLHknBegrOTjoQSoQ7gkDhT3o7Jych01ZFL+NFbKVWqDXmRPx54DJJGjsjZfP2I6
         1BGePJ8tG/Tno2lQNO1LHkI+PGvmBNASP6+D/n5ds1JT4KRioLFOu8O6ojEDV2zXG6ag
         9orQ==
X-Gm-Message-State: AOJu0Yx5DFAYjvvVhuUTwLZt/IG4Ik70ZGBaBL3EOYfCFCxSyruqxsVw
	WfN6EM0GTwBpXnXHylKimsco0gkDi5Aifm74+QnwKJFz
X-Google-Smtp-Source: AGHT+IEpd6g4nAawsF47GQN8OT0PIpG0wXYjZxbCnqqgFy14gI57JIY3lXmyHlwXEQxdKRz53j53XRwrp8KckqKyUWU=
X-Received: by 2002:a17:907:7255:b0:9de:dc3d:3b2 with SMTP id
 ds21-20020a170907725500b009dedc3d03b2mr6255491ejc.16.1699595834871; Thu, 09
 Nov 2023 21:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109092838.721233-1-jolsa@kernel.org> <20231109092838.721233-4-jolsa@kernel.org>
In-Reply-To: <20231109092838.721233-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 21:57:03 -0800
Message-ID: <CAEf4BzZAh=aW_4bXSJdBZ-UcoCqa0CuejXBdb7+fB9bDP4q+eQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 3/6] bpf: Add link_info support for uprobe
 multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 1:29=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
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
>  kernel/trace/bpf_trace.c       | 69 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 10 +++++
>  3 files changed, 89 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0f6cdf52b1da..05b355da4508 100644
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
> +                       __u32 path_size;
> +                       __u32 count; /* in/out: uprobe_multi offsets/ref_=
ctr_offsets/cookies count */
> +                       __u32 flags;
> +                       __u32 pid;
> +               } uprobe_multi;
>                 struct {
>                         __u32 type; /* enum bpf_perf_event_type */
>                         __u32 :32;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 52c1ec3a0467..1ea54f3b3f73 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3046,6 +3046,7 @@ struct bpf_uprobe_multi_link {
>         u32 cnt;
>         struct bpf_uprobe *uprobes;
>         struct task_struct *task;
> +       u32 flags;
>  };
>
>  struct bpf_uprobe_multi_run_ctx {
> @@ -3085,9 +3086,76 @@ static void bpf_uprobe_multi_link_dealloc(struct b=
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
> +       if (!uoffsets ^ !ucount)

uoffsets is not the only one that requires ucount, right?

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
> +               left =3D copy_to_user(upath, p, buf + upath_size - p);
> +               kfree(buf);
> +               if (left)
> +                       return -EFAULT;

hmm.. I expected the actual path_size to be reported back to the
user?.. Is there a problem with doing that?

> +       }
> +
> +       if (!uoffsets)
> +               return 0;

why guard by uoffsets? what if users only wanted cookies? I think each
array should do its own checking and be independent, no?

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
> @@ -3276,6 +3344,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
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
> index 0f6cdf52b1da..05b355da4508 100644
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
> +                       __u32 path_size;
> +                       __u32 count; /* in/out: uprobe_multi offsets/ref_=
ctr_offsets/cookies count */
> +                       __u32 flags;
> +                       __u32 pid;
> +               } uprobe_multi;
>                 struct {
>                         __u32 type; /* enum bpf_perf_event_type */
>                         __u32 :32;
> --
> 2.41.0
>

