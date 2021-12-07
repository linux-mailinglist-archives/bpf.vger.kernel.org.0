Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F746BD8F
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 15:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhLGO2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 09:28:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237755AbhLGO2i (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Dec 2021 09:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638887108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tO2ffYJaUFeq9MC5LppQwfM85DTINtXQ1WDdDxd5NeE=;
        b=IKyGHrOJ/YzjcGL/K8JLrcHWhPpwk4p/+HgOKd60c06aQ2Z4Mw6vStkD7NUiFCTXQVp+PS
        yd9WGQz3g5b6PB1jO4usDRzBEgRKXDlUqXCcbwngPaoW0oepe1yuS5HKT2UcBDCalN3P8c
        7+qh4/GOjVtN08/TMtvPe1IbYBtQkSM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-jhJCE1coOjaSFQ3sxQzNpg-1; Tue, 07 Dec 2021 09:25:07 -0500
X-MC-Unique: jhJCE1coOjaSFQ3sxQzNpg-1
Received: by mail-ed1-f71.google.com with SMTP id q17-20020aa7da91000000b003e7c0641b9cso11547385eds.12
        for <bpf@vger.kernel.org>; Tue, 07 Dec 2021 06:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tO2ffYJaUFeq9MC5LppQwfM85DTINtXQ1WDdDxd5NeE=;
        b=WSRHtu7MY3zMJvIbuJWAkhpL9p6Zx8LosSeDegfyN+QyA3ZB12guTZNvIh1Qc2aPBx
         s7t6HOfnTOQ2uKptEWeJeUl0HX98+x5si1bf3WfF8sUsmdp4IJGgGIofvTbHdVbbI1cV
         fjKkqLVDgHPcrn33KjVHYQ+0eJCdcSmhTggdSTvwhFFvAX5H+LKVaIR5lfuP/NoS6KGa
         47dt67WhrGUvC82C50lha8LiIf0xb6vw3y+1U22DECcRSD4clVHFCvaGYNAKDdvXfazb
         cNOkSdlpJl69RmNx/R3gqEyFc5eAtN+MXZT4DToEUBTdU9OnQJPqk07l0uNUxYYozVEl
         GXBQ==
X-Gm-Message-State: AOAM53026PJDNZYUWWenNihqEdwN0k7k4A6H0W//hGVmDtU39zHYgawA
        qMBYFl1AqHkX2wedE/dFgB88Mvy2Xkd7iwLKXsbjxecclVoa1+MsEIZuuC8iKM3xiqhbjRkSkz8
        8dqgKBAjvdLQn
X-Received: by 2002:a17:907:2a09:: with SMTP id fd9mr52795523ejc.550.1638887105950;
        Tue, 07 Dec 2021 06:25:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzV+XBimS/bnrGku4z7Sy6kKdEbHEuYfeNNEEF4JPPRNMFzspjOkHRMu6Awy8HXuHYHgvBIXg==
X-Received: by 2002:a17:907:2a09:: with SMTP id fd9mr52795495ejc.550.1638887105747;
        Tue, 07 Dec 2021 06:25:05 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id z6sm11072424edc.76.2021.12.07.06.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 06:25:05 -0800 (PST)
Date:   Tue, 7 Dec 2021 15:25:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH bpf-next 1/3] bpf, x64: Replace some stack_size usage
 with offset variables
Message-ID: <Ya9uv+KdwKiTXt6/@krava>
References: <20211204140700.396138-1-jolsa@kernel.org>
 <20211204140700.396138-2-jolsa@kernel.org>
 <CAEf4BzYGKW1mJ28TtL3iD5-AcDb+Ua0aqPAdnPjtbneEZqyr2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYGKW1mJ28TtL3iD5-AcDb+Ua0aqPAdnPjtbneEZqyr2A@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 06, 2021 at 01:41:15PM -0800, Andrii Nakryiko wrote:
> On Sat, Dec 4, 2021 at 6:07 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > As suggested by Andrii, adding variables for registers and ip
> > address offsets, which makes the code more clear, rather than
> > abusing single stack_size variable for everything.
> >
> > Also describing the stack layout in the comment.
> >
> > There is no function change.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 42 ++++++++++++++++++++++++-------------
> >  1 file changed, 28 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 1d7b0c69b644..b106e80e8d9c 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1941,7 +1941,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> >                                 void *orig_call)
> >  {
> >         int ret, i, nr_args = m->nr_args;
> > -       int stack_size = nr_args * 8;
> > +       int regs_off, ip_off, stack_size = nr_args * 8;
> >         struct bpf_tramp_progs *fentry = &tprogs[BPF_TRAMP_FENTRY];
> >         struct bpf_tramp_progs *fexit = &tprogs[BPF_TRAMP_FEXIT];
> >         struct bpf_tramp_progs *fmod_ret = &tprogs[BPF_TRAMP_MODIFY_RETURN];
> > @@ -1956,14 +1956,33 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> >         if (!is_valid_bpf_tramp_flags(flags))
> >                 return -EINVAL;
> >
> > +       /* Generated trampoline stack layout:
> > +        *
> > +        * RBP + 8         [ return address  ]
> > +        * RBP + 0         [ RBP             ]
> > +        *
> > +        * RBP - 8         [ return value    ]  BPF_TRAMP_F_CALL_ORIG or
> > +        *                                      BPF_TRAMP_F_RET_FENTRY_RET flags
> > +        *
> > +        *                 [ reg_argN        ]  always
> > +        *                 [ ...             ]
> > +        * RBP - regs_off  [ reg_arg1        ]
> > +        *
> 
> I think it's also worth mentioning that context passed into
> fentry/fexit programs are pointing here (makes it a bit easier to
> track those ctx[-1] and ctx[-2] in the next patch.

ok, jirka

> 
> 
> > +        * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
> > +        */
> > +
> >         /* room for return value of orig_call or fentry prog */
> >         save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
> >         if (save_ret)
> >                 stack_size += 8;
> >
> > +       regs_off = stack_size;
> > +
> >         if (flags & BPF_TRAMP_F_IP_ARG)
> >                 stack_size += 8; /* room for IP address argument */
> >
> > +       ip_off = stack_size;
> > +
> 
> [...]
> 

