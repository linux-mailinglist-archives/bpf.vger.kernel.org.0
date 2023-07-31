Return-Path: <bpf+bounces-6395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C65768A5B
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 05:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C2F281580
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 03:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D72264E;
	Mon, 31 Jul 2023 03:33:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D76862D
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 03:33:42 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8083010B
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 20:33:40 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63d30554eefso25193086d6.3
        for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 20:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690774419; x=1691379219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmtBu/paena+7X9GosRg3UhVUls+GHPMi+l1HS6i0RQ=;
        b=dauJgyZ5LDpJdJVeyvBujX+UNpueXlb5E/hcUEE4P33kBRTT79yeFVY9cASB09kU7h
         XH2QbLQ8N5/CNdd4LJcxRUN9pKeWawt8zmc7y6rGtss5eSjRt2qNsZLsT8IF83LOyo77
         t0OcAGS65/rU1h5LZ6sA8PKLnwCAPSpqHSSAVJN0TKDRB+PKXeTW5xerUe1OGOKXb9at
         RGoFeDnV9i7n588u07jw+Vj/xUHSkwzTtsaA5nxsmAKtybBmpZKxb9myUJTYTQPmAgm/
         K+A8b2WtzcjT4Y6ch5IEAAlWq1DlPa4rOWDPvxRBGpUXakdjGhsZONpCis7yPGUk1EV7
         gLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690774419; x=1691379219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmtBu/paena+7X9GosRg3UhVUls+GHPMi+l1HS6i0RQ=;
        b=cXt1rtYRmMYj85GmNG7vSn5oI09JM5ljVxwsxaOINofLdToAN194i2AqbxyACvRYuQ
         ul/h87hW06ufEEDeupCMFvtDeenL9gqo5iOdj1vVGBlE7Lm4UkQy8W5G2K08Y5CrRdcd
         hx58z/wsqcWDkHSpJpmeI1HIoNqV8QMO4caPlwx8tqVsJktbHRMixYmK0tl6K1d0Yafd
         Cn3wAIWIBuiP/WfKx+zkteVUqVtK6MoULo65Sys7dMKS+96NTVBzgkX7vsZWvX/a3OD5
         JKc8kwQKZcQnhayNkpha0vFzjtxxA2Fm261wVn4ytN8deM+pA5Kh5NqYm3GIJHfdjZmM
         JNqQ==
X-Gm-Message-State: ABy/qLaPVUH67U5eS6UQtrU+dzQ5ouYgUu2rrWJbpk8vEtf/QYHHCtXZ
	kBfeQra2XmLrEd3E107ovs+kTPwydC6eltGflKk=
X-Google-Smtp-Source: APBJJlG/tsTcr/A6zpjlGCnsnnAuRHXMDj6g0kaRgpCwx0hIOkEnp1Jd4Gq1YTm/6XM6WdVWlK5tXzF/Qt3YOR1BCNQ=
X-Received: by 2002:a0c:e9c5:0:b0:63c:fd23:e858 with SMTP id
 q5-20020a0ce9c5000000b0063cfd23e858mr8923309qvo.12.1690774419602; Sun, 30 Jul
 2023 20:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230730134223.94496-1-jolsa@kernel.org> <20230730134223.94496-5-jolsa@kernel.org>
In-Reply-To: <20230730134223.94496-5-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 31 Jul 2023 11:33:03 +0800
Message-ID: <CALOAHbCuFwQfgA+DZv0w5CxCP9KyTkZ79h_sqhCcYgFwhHDk5g@mail.gmail.com>
Subject: Re: [PATCHv5 bpf-next 04/28] bpf: Add cookies support for
 uprobe_multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
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

On Sun, Jul 30, 2023 at 9:43=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to specify cookies array for uprobe_multi link.
>
> The cookies array share indexes and length with other uprobe_multi
> arrays (offsets/ref_ctr_offsets).
>
> The cookies[i] value defines cookie for i-the uprobe and will be
> returned by bpf_get_attach_cookie helper when called from ebpf
> program hooked to that specific uprobe.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

LGTM!
Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           |  2 +-
>  kernel/trace/bpf_trace.c       | 45 +++++++++++++++++++++++++++++++---
>  tools/include/uapi/linux/bpf.h |  1 +
>  4 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f112a0b948f3..2b6cd7d1c165 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1639,6 +1639,7 @@ union bpf_attr {
>                                 __aligned_u64   path;
>                                 __aligned_u64   offsets;
>                                 __aligned_u64   ref_ctr_offsets;
> +                               __aligned_u64   cookies;
>                                 __u32           cnt;
>                                 __u32           flags;
>                         } uprobe_multi;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 75c83300339e..98459fb34ff7 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4883,7 +4883,7 @@ static int bpf_map_do_batch(const union bpf_attr *a=
ttr,
>         return err;
>  }
>
> -#define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
> +#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.flags
>  static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>  {
>         struct bpf_prog *prog;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 10284fd46f98..d73a47bd2bbd 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -87,6 +87,8 @@ static int bpf_btf_printf_prepare(struct btf_ptr *ptr, =
u32 btf_ptr_size,
>  static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx);
>  static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
>
> +static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx);
> +
>  /**
>   * trace_call_bpf - invoke BPF program
>   * @call: tracepoint event
> @@ -1099,6 +1101,18 @@ static const struct bpf_func_proto bpf_get_attach_=
cookie_proto_kmulti =3D {
>         .arg1_type      =3D ARG_PTR_TO_CTX,
>  };
>
> +BPF_CALL_1(bpf_get_attach_cookie_uprobe_multi, struct pt_regs *, regs)
> +{
> +       return bpf_uprobe_multi_cookie(current->bpf_ctx);
> +}
> +
> +static const struct bpf_func_proto bpf_get_attach_cookie_proto_umulti =
=3D {
> +       .func           =3D bpf_get_attach_cookie_uprobe_multi,
> +       .gpl_only       =3D false,
> +       .ret_type       =3D RET_INTEGER,
> +       .arg1_type      =3D ARG_PTR_TO_CTX,
> +};
> +
>  BPF_CALL_1(bpf_get_attach_cookie_trace, void *, ctx)
>  {
>         struct bpf_trace_run_ctx *run_ctx;
> @@ -1545,9 +1559,11 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
>                         &bpf_get_func_ip_proto_kprobe_multi :
>                         &bpf_get_func_ip_proto_kprobe;
>         case BPF_FUNC_get_attach_cookie:
> -               return prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE=
_MULTI ?
> -                       &bpf_get_attach_cookie_proto_kmulti :
> -                       &bpf_get_attach_cookie_proto_trace;
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE_MU=
LTI)
> +                       return &bpf_get_attach_cookie_proto_kmulti;
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_MU=
LTI)
> +                       return &bpf_get_attach_cookie_proto_umulti;
> +               return &bpf_get_attach_cookie_proto_trace;
>         default:
>                 return bpf_tracing_func_proto(func_id, prog);
>         }
> @@ -2973,6 +2989,7 @@ struct bpf_uprobe_multi_link;
>  struct bpf_uprobe {
>         struct bpf_uprobe_multi_link *link;
>         loff_t offset;
> +       u64 cookie;
>         struct uprobe_consumer consumer;
>  };
>
> @@ -2986,6 +3003,7 @@ struct bpf_uprobe_multi_link {
>  struct bpf_uprobe_multi_run_ctx {
>         struct bpf_run_ctx run_ctx;
>         unsigned long entry_ip;
> +       struct bpf_uprobe *uprobe;
>  };
>
>  static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *=
uprobes,
> @@ -3029,6 +3047,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprob=
e,
>         struct bpf_uprobe_multi_link *link =3D uprobe->link;
>         struct bpf_uprobe_multi_run_ctx run_ctx =3D {
>                 .entry_ip =3D entry_ip,
> +               .uprobe =3D uprobe,
>         };
>         struct bpf_prog *prog =3D link->link.prog;
>         bool sleepable =3D prog->aux->sleepable;
> @@ -3075,6 +3094,14 @@ uprobe_multi_link_ret_handler(struct uprobe_consum=
er *con, unsigned long func, s
>         return uprobe_prog_run(uprobe, func, regs);
>  }
>
> +static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
> +{
> +       struct bpf_uprobe_multi_run_ctx *run_ctx;
> +
> +       run_ctx =3D container_of(current->bpf_ctx, struct bpf_uprobe_mult=
i_run_ctx, run_ctx);
> +       return run_ctx->uprobe->cookie;
> +}
> +
>  int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_=
prog *prog)
>  {
>         struct bpf_uprobe_multi_link *link =3D NULL;
> @@ -3083,6 +3110,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>         struct bpf_link_primer link_primer;
>         struct bpf_uprobe *uprobes =3D NULL;
>         unsigned long __user *uoffsets;
> +       u64 __user *ucookies;
>         void __user *upath;
>         u32 flags, cnt, i;
>         struct path path;
> @@ -3102,7 +3130,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>
>         /*
>          * path, offsets and cnt are mandatory,
> -        * ref_ctr_offsets is optional
> +        * ref_ctr_offsets and cookies are optional
>          */
>         upath =3D u64_to_user_ptr(attr->link_create.uprobe_multi.path);
>         uoffsets =3D u64_to_user_ptr(attr->link_create.uprobe_multi.offse=
ts);
> @@ -3112,6 +3140,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>                 return -EINVAL;
>
>         uref_ctr_offsets =3D u64_to_user_ptr(attr->link_create.uprobe_mul=
ti.ref_ctr_offsets);
> +       ucookies =3D u64_to_user_ptr(attr->link_create.uprobe_multi.cooki=
es);
>
>         name =3D strndup_user(upath, PATH_MAX);
>         if (IS_ERR(name)) {
> @@ -3144,6 +3173,10 @@ int bpf_uprobe_multi_link_attach(const union bpf_a=
ttr *attr, struct bpf_prog *pr
>         }
>
>         for (i =3D 0; i < cnt; i++) {
> +               if (ucookies && __get_user(uprobes[i].cookie, ucookies + =
i)) {
> +                       err =3D -EFAULT;
> +                       goto error_free;
> +               }
>                 if (uref_ctr_offsets && __get_user(ref_ctr_offsets[i], ur=
ef_ctr_offsets + i)) {
>                         err =3D -EFAULT;
>                         goto error_free;
> @@ -3201,4 +3234,8 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>  {
>         return -EOPNOTSUPP;
>  }
> +static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
> +{
> +       return 0;
> +}
>  #endif /* CONFIG_UPROBES */
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index f112a0b948f3..2b6cd7d1c165 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1639,6 +1639,7 @@ union bpf_attr {
>                                 __aligned_u64   path;
>                                 __aligned_u64   offsets;
>                                 __aligned_u64   ref_ctr_offsets;
> +                               __aligned_u64   cookies;
>                                 __u32           cnt;
>                                 __u32           flags;
>                         } uprobe_multi;
> --
> 2.41.0
>


--=20
Regards
Yafang

