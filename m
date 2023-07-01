Return-Path: <bpf+bounces-3836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F215744667
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 05:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8291C20C61
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 03:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84231857;
	Sat,  1 Jul 2023 03:40:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4317F2
	for <bpf@vger.kernel.org>; Sat,  1 Jul 2023 03:40:48 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030284C21
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 20:40:44 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76731802203so224558385a.3
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 20:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688182844; x=1690774844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CX6rCJ5Yo/6wCEC4Y2ob0QL2urlqOCuJzLzRjKlqLCY=;
        b=YXJXfn/KHDTeLT3RhLaB0MC6cRFAJuuGRU36Tls+0oYHcirY+JHjX309jbrsrkbZmN
         JPbFWXVE1a1pxS4ue+bJpAQAH6ZIQYSOFyw4tstVEFlb8LLPjXVZLn7MCdhSL+vVptyq
         o6mcPPdfW1Kv9T3kTIUX8x6aW1+8gYLDknY7IVOs8r+hhYDu3+HJ2fIRkFDC1aiHUA4j
         CzU5t8Zf23W979tCb56ga+9zSGqfgYbuNt58TPkctoCVHf5S58PuBJXANvrzUJq3XyTn
         v8vSopFAPX89BV5Ff7jZdMr2+NIoK7n9i1fkmBPm3edARjm2ZVeRAazoMmCCwJp4elSX
         +LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688182844; x=1690774844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CX6rCJ5Yo/6wCEC4Y2ob0QL2urlqOCuJzLzRjKlqLCY=;
        b=AjG+em5+9vbOXMXJrlpExIgEflu1DAl+5amSJvSmG5EjpuD2tgWnqXzCfMsyiwdE4b
         rXZxCfKHJ9h4KXOZxtA/0FfY0J+xqeWyy4C3QzHNBKMenlgL2F2BA1WfCFa/XjQHC7Nb
         SbVR5xRktuxlXEcCNl5LvV+rtLjt66QPSq/r/7VT/KR92LhD06JeBivdKAoig6YSpyBc
         Zr3BjTJ1u9+JNNA2OY1kwMNMNSkLrv+zt2CgOEuINQjMLOHlWTXgvuMQEyRS4A3cOcgT
         mOWVxNT4zBTNuiJhXzoVQlCqutNJO7xjwEiSRncQED9ZKwQl687JHEom98N3FCuoVuri
         pPTA==
X-Gm-Message-State: ABy/qLYO+LrmhNr/LIKniJxR+ER0hXD6Yhfw0Q6G1qtnqUhoy9iFbr2e
	H3EM7nmyPsLG+5urbZ4jmyycu0w7MQJenRJmYLqsmnFjRsd4qQ==
X-Google-Smtp-Source: APBJJlHNL4k5oSFeAsVau3JBLLxn9A/moHL7g3j7JpAfmXBmmWwTooHHa/VHPm/K5poS933FWbcr0ikjZ7yizqGsXWs=
X-Received: by 2002:a05:6214:d69:b0:630:2117:9628 with SMTP id
 9-20020a0562140d6900b0063021179628mr6198062qvs.8.1688182843903; Fri, 30 Jun
 2023 20:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-4-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-4-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 1 Jul 2023 11:40:05 +0800
Message-ID: <CALOAHbDOdvNvFUMgQGvCVELKbbX4m6sokxqwdk1qwKMCzBCokA@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 03/26] bpf: Add cookies support for
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 4:34=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
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
> ---
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           |  2 +-
>  kernel/trace/bpf_trace.c       | 45 +++++++++++++++++++++++++++++++---
>  tools/include/uapi/linux/bpf.h |  1 +
>  4 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a236139f08ce..4103f395593b 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1592,6 +1592,7 @@ union bpf_attr {
>                                 __aligned_u64   path;
>                                 __aligned_u64   offsets;
>                                 __aligned_u64   ref_ctr_offsets;
> +                               __aligned_u64   cookies;

Could you pls. explain why the 'cookies' is defined as a pointer ? Are
there real use cases to define different cookies for different probes
in a single uprobe_multi ?  Why can't we just use one cookie for all
probes?  Per my understanding, the cookie is used to identify the user
or the application, rather than each probe.

We also defined it the same way in kprobe_multi...


>                         } uprobe_multi;
>                 };
>         } link_create;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3b0582a64ce4..affad356c603 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4680,7 +4680,7 @@ static int bpf_map_do_batch(const union bpf_attr *a=
ttr,
>         return err;
>  }
>
> -#define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
> +#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.cookies
>  static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>  {
>         struct bpf_prog *prog;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a0b9d034300f..4657df8f884e 100644
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
> @@ -2930,6 +2946,7 @@ struct bpf_uprobe_multi_link;
>  struct bpf_uprobe {
>         struct bpf_uprobe_multi_link *link;
>         loff_t offset;
> +       u64 cookie;
>         struct uprobe_consumer consumer;
>  };
>
> @@ -2943,6 +2960,7 @@ struct bpf_uprobe_multi_link {
>  struct bpf_uprobe_multi_run_ctx {
>         struct bpf_run_ctx run_ctx;
>         unsigned long entry_ip;
> +       struct bpf_uprobe *uprobe;
>  };
>
>  static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *=
uprobes,
> @@ -2986,6 +3004,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprob=
e,
>         struct bpf_uprobe_multi_link *link =3D uprobe->link;
>         struct bpf_uprobe_multi_run_ctx run_ctx =3D {
>                 .entry_ip =3D entry_ip,
> +               .uprobe =3D uprobe,
>         };
>         struct bpf_prog *prog =3D link->link.prog;
>         bool sleepable =3D prog->aux->sleepable;
> @@ -3032,6 +3051,14 @@ uprobe_multi_link_ret_handler(struct uprobe_consum=
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
> @@ -3040,6 +3067,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>         struct bpf_link_primer link_primer;
>         struct bpf_uprobe *uprobes =3D NULL;
>         unsigned long __user *uoffsets;
> +       u64 __user *ucookies;
>         void __user *upath;
>         u32 flags, cnt, i;
>         struct path path;
> @@ -3059,7 +3087,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
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
> @@ -3069,6 +3097,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
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
> @@ -3101,6 +3130,10 @@ int bpf_uprobe_multi_link_attach(const union bpf_a=
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
> @@ -3158,4 +3191,8 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
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
> index a236139f08ce..4103f395593b 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1592,6 +1592,7 @@ union bpf_attr {
>                                 __aligned_u64   path;
>                                 __aligned_u64   offsets;
>                                 __aligned_u64   ref_ctr_offsets;
> +                               __aligned_u64   cookies;
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

