Return-Path: <bpf+bounces-5583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BB675BFF3
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 09:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57071C215F9
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 07:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE872119;
	Fri, 21 Jul 2023 07:39:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1480C20F2
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 07:39:24 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4399F19A1
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 00:39:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98e39784a85so586144566b.1
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 00:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689925154; x=1690529954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rxXZ1eXepheovIxg2nH7TH4U8cdrBDpK9SlkNcVTG8I=;
        b=jcSy7C19yt1TQ+mHmaLI4M762y/TC7/xLB1nzYUB12W6VjzpXr38xYN5j1k6oeobL+
         3q9UOfSc6sW8KStOvGH091Um9cgbB4yJwEFKPVjuTbAyaodLQzvLCkdfpX9qONEe8MQS
         cjVZSDOc9xooxhbZjuu61S/35KAbFZusxDB0PP7shxGIYKFczBbHQDRIQMWhNn08BZTr
         GiQE0gjFug63OCMchgoxtWraXaSRKL7Drmi9mN9X1DaI4VTvWpXSk75P19ut+oJ7H4FD
         bR5A5Ou3pJDEu/O8lZ9OqXYi8Mp5NxCIqIgaW1eWBWQjTOW8+JazK0c87k5UUYSIgquK
         uWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689925154; x=1690529954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxXZ1eXepheovIxg2nH7TH4U8cdrBDpK9SlkNcVTG8I=;
        b=DnW/MJYc9xCEIoJXI1DiSmF1jLRAlClE3LxorcGPNtkFYe2yYI5fE3JoocQ1LonN3a
         QqM5NzuN0oZr6IxTVVXnqpHnA8s2ngIT1OiXVRqQSvEc4hrQlUvPL6Uvvj3tcFAp4eP3
         2tYZO7CDCPED/PnoEYj7MxLky5o7UH8x2bl+XjBhLnoOBk1P4dgMXglIb+VzbrrTm3kx
         Ql8QM92yZeaTlSWi+yvnIF9grgR5yQnf9gHyFeCx0AwCBxemx2H+Ue/DTAhS4gF18/Qy
         J0YBiNt5aDACTYC8oWK4dQWKhR/UTWm+M2RpXATjiE8EHwitmzlTjtRnZGfoog3GCVoe
         +YQQ==
X-Gm-Message-State: ABy/qLZFrLr1MmbJ+0S6Or5K3/RANH1lljJShKUVHAaRrz69wNOSVM8y
	oj/AFU/5ETKm20FvgsljCdg=
X-Google-Smtp-Source: APBJJlEq1V1D0fCpnyMkFqqUj367V9Y4g2jUDgclnZZHFEHa29DaadvgfOOcojA5xVbRiMRs9AYljg==
X-Received: by 2002:a17:906:7381:b0:994:13c3:2f89 with SMTP id f1-20020a170906738100b0099413c32f89mr1237602ejl.27.1689925154103;
        Fri, 21 Jul 2023 00:39:14 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id b10-20020a170906038a00b009929ab17bdfsm1749629eja.168.2023.07.21.00.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:39:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 21 Jul 2023 09:39:11 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv4 bpf-next 04/28] bpf: Add cookies support for
 uprobe_multi link
Message-ID: <ZLo2HxPhYqyce7g1@krava>
References: <20230720113550.369257-1-jolsa@kernel.org>
 <20230720113550.369257-5-jolsa@kernel.org>
 <CALOAHbDYX5mEB=uMKKyeXkC+eNt=E3ah2ahjvJnXv8hFMpzR2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDYX5mEB=uMKKyeXkC+eNt=E3ah2ahjvJnXv8hFMpzR2Q@mail.gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 10:18:27AM +0800, Yafang Shao wrote:
> On Thu, Jul 20, 2023 at 7:36 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to specify cookies array for uprobe_multi link.
> >
> > The cookies array share indexes and length with other uprobe_multi
> > arrays (offsets/ref_ctr_offsets).
> >
> > The cookies[i] value defines cookie for i-the uprobe and will be
> > returned by bpf_get_attach_cookie helper when called from ebpf
> > program hooked to that specific uprobe.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       |  1 +
> >  kernel/bpf/syscall.c           |  2 +-
> >  kernel/trace/bpf_trace.c       | 45 +++++++++++++++++++++++++++++++---
> >  tools/include/uapi/linux/bpf.h |  1 +
> >  4 files changed, 44 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index e764af513425..c6fbb0f948f4 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1604,6 +1604,7 @@ union bpf_attr {
> >                                 __aligned_u64   path;
> >                                 __aligned_u64   offsets;
> >                                 __aligned_u64   ref_ctr_offsets;
> > +                               __aligned_u64   cookies;
> >                                 __u32           cnt;
> >                                 __u32           flags;
> >                         } uprobe_multi;
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index f4c6a265731e..840b622b7db1 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -4832,7 +4832,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
> >         return err;
> >  }
> >
> > -#define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
> > +#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.cookies
> 
> Shouldn't it be :
> 
> #define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.flags ?
> 
> other than that, this patch looks good.

ugh, I changed order of fields and forgot to update last fields,
will fix that in next version

thanks,
jirka

> 
> 
> >  static int link_create(union bpf_attr *attr, bpfptr_t uattr)
> >  {
> >         struct bpf_prog *prog;
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 10284fd46f98..d73a47bd2bbd 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -87,6 +87,8 @@ static int bpf_btf_printf_prepare(struct btf_ptr *ptr, u32 btf_ptr_size,
> >  static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx);
> >  static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
> >
> > +static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx);
> > +
> >  /**
> >   * trace_call_bpf - invoke BPF program
> >   * @call: tracepoint event
> > @@ -1099,6 +1101,18 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_kmulti = {
> >         .arg1_type      = ARG_PTR_TO_CTX,
> >  };
> >
> > +BPF_CALL_1(bpf_get_attach_cookie_uprobe_multi, struct pt_regs *, regs)
> > +{
> > +       return bpf_uprobe_multi_cookie(current->bpf_ctx);
> > +}
> > +
> > +static const struct bpf_func_proto bpf_get_attach_cookie_proto_umulti = {
> > +       .func           = bpf_get_attach_cookie_uprobe_multi,
> > +       .gpl_only       = false,
> > +       .ret_type       = RET_INTEGER,
> > +       .arg1_type      = ARG_PTR_TO_CTX,
> > +};
> > +
> >  BPF_CALL_1(bpf_get_attach_cookie_trace, void *, ctx)
> >  {
> >         struct bpf_trace_run_ctx *run_ctx;
> > @@ -1545,9 +1559,11 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >                         &bpf_get_func_ip_proto_kprobe_multi :
> >                         &bpf_get_func_ip_proto_kprobe;
> >         case BPF_FUNC_get_attach_cookie:
> > -               return prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ?
> > -                       &bpf_get_attach_cookie_proto_kmulti :
> > -                       &bpf_get_attach_cookie_proto_trace;
> > +               if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI)
> > +                       return &bpf_get_attach_cookie_proto_kmulti;
> > +               if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI)
> > +                       return &bpf_get_attach_cookie_proto_umulti;
> > +               return &bpf_get_attach_cookie_proto_trace;
> >         default:
> >                 return bpf_tracing_func_proto(func_id, prog);
> >         }
> > @@ -2973,6 +2989,7 @@ struct bpf_uprobe_multi_link;
> >  struct bpf_uprobe {
> >         struct bpf_uprobe_multi_link *link;
> >         loff_t offset;
> > +       u64 cookie;
> >         struct uprobe_consumer consumer;
> >  };
> >
> > @@ -2986,6 +3003,7 @@ struct bpf_uprobe_multi_link {
> >  struct bpf_uprobe_multi_run_ctx {
> >         struct bpf_run_ctx run_ctx;
> >         unsigned long entry_ip;
> > +       struct bpf_uprobe *uprobe;
> >  };
> >
> >  static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
> > @@ -3029,6 +3047,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> >         struct bpf_uprobe_multi_link *link = uprobe->link;
> >         struct bpf_uprobe_multi_run_ctx run_ctx = {
> >                 .entry_ip = entry_ip,
> > +               .uprobe = uprobe,
> >         };
> >         struct bpf_prog *prog = link->link.prog;
> >         bool sleepable = prog->aux->sleepable;
> > @@ -3075,6 +3094,14 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
> >         return uprobe_prog_run(uprobe, func, regs);
> >  }
> >
> > +static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
> > +{
> > +       struct bpf_uprobe_multi_run_ctx *run_ctx;
> > +
> > +       run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
> > +       return run_ctx->uprobe->cookie;
> > +}
> > +
> >  int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> >  {
> >         struct bpf_uprobe_multi_link *link = NULL;
> > @@ -3083,6 +3110,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >         struct bpf_link_primer link_primer;
> >         struct bpf_uprobe *uprobes = NULL;
> >         unsigned long __user *uoffsets;
> > +       u64 __user *ucookies;
> >         void __user *upath;
> >         u32 flags, cnt, i;
> >         struct path path;
> > @@ -3102,7 +3130,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >
> >         /*
> >          * path, offsets and cnt are mandatory,
> > -        * ref_ctr_offsets is optional
> > +        * ref_ctr_offsets and cookies are optional
> >          */
> >         upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
> >         uoffsets = u64_to_user_ptr(attr->link_create.uprobe_multi.offsets);
> > @@ -3112,6 +3140,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >                 return -EINVAL;
> >
> >         uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
> > +       ucookies = u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
> >
> >         name = strndup_user(upath, PATH_MAX);
> >         if (IS_ERR(name)) {
> > @@ -3144,6 +3173,10 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >         }
> >
> >         for (i = 0; i < cnt; i++) {
> > +               if (ucookies && __get_user(uprobes[i].cookie, ucookies + i)) {
> > +                       err = -EFAULT;
> > +                       goto error_free;
> > +               }
> >                 if (uref_ctr_offsets && __get_user(ref_ctr_offsets[i], uref_ctr_offsets + i)) {
> >                         err = -EFAULT;
> >                         goto error_free;
> > @@ -3201,4 +3234,8 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >  {
> >         return -EOPNOTSUPP;
> >  }
> > +static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
> > +{
> > +       return 0;
> > +}
> >  #endif /* CONFIG_UPROBES */
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 659afbf9bb8b..492072ef5029 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -1604,6 +1604,7 @@ union bpf_attr {
> >                                 __aligned_u64   path;
> >                                 __aligned_u64   offsets;
> >                                 __aligned_u64   ref_ctr_offsets;
> > +                               __aligned_u64   cookies;
> >                                 __u32           cnt;
> >                                 __u32           flags;
> >                         } uprobe_multi;
> > --
> > 2.41.0
> >
> >
> 
> 
> -- 
> Regards
> Yafang

