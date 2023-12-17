Return-Path: <bpf+bounces-18136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 675C98161C0
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 20:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31DD1F21AFB
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2041481A3;
	Sun, 17 Dec 2023 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DInCiG5j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD18847F5E
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40b5155e154so29085895e9.3
        for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 11:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702840934; x=1703445734; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xev5racof/jfF4ldxnXlZYrgc0gxa2PpwVUBWxCqSu4=;
        b=DInCiG5jo4ScvzIfZw9Itln/gXE4RTsVq0irLR+p2NSU75pHnp+83VcP4MevLMJlvk
         CYUQQ1z9YgaAadUnZ6iHox+0bgfKQ/75MKEctskRGphVYxprIcjIRdIsgBrJLJd9MPkX
         QHbawcyroDfmZlg6AwLitxQYu9yiJdSWAUYWNmpXZY6EvqFAC2ZNUIn7PMDCf/SMC41B
         D7S6i2XAkgxF0O4s2dtAtdTrK1oISxi6iX5OP0Owo1DKvkrNJF/X1HNC0OiAAxeszkV+
         vDbBHwbdkS7+rw75dlGyfaJUHJWpcZcdrBinZ7eRFNtj2D1pzaTPoDIGdK8JWfqvcAOn
         +ilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702840934; x=1703445734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xev5racof/jfF4ldxnXlZYrgc0gxa2PpwVUBWxCqSu4=;
        b=Vkl3TA5h3FUxiUE1w95NBMno4Vn5pIPz5J2gvKYDNnDkhvDR0HIgYqiPdyt7WfV3Av
         /mLsDNwePkwxJ1TUL5DLLGr+19kjAf+8kQPhkZ+oBOfPYGmTi4ZQXPFY79Zlved232Tk
         BnEu7orbM+1oc79vAZbWH11CWpSLoshx/UJOQJMtKXYegCGP9sHcM7yCeVOrN5cVoNXm
         GDdGcPvvrNEcD+BRAcpG+0koxG4baN9Bx0FuuQAuKIbf0zVn2RzH1dQtXDswsmlI8UOb
         g2SOBnZFkcyuPZnS2//9nxtaQoukRqSEL6sCEhn6/BEywkJOAGEnZPguX7WkDhn0ADho
         Dmrw==
X-Gm-Message-State: AOJu0YyAppVZthvitH6fqMUYuH0QsxqgYx+K34YAtPsOtRwSTS4fu9ty
	WNUkP+3YJqMrbn2B03OAXLs=
X-Google-Smtp-Source: AGHT+IEOWI/pyLtwwh6EAvkn/2gXWU/efI7zjwm6xPDXLJFup+4F6+orhZSteZKsWGZXMrUgG3CBrQ==
X-Received: by 2002:a05:600c:4fd6:b0:40b:5e1f:6fe5 with SMTP id o22-20020a05600c4fd600b0040b5e1f6fe5mr7322891wmq.58.1702840933727;
        Sun, 17 Dec 2023 11:22:13 -0800 (PST)
Received: from krava ([83.240.62.111])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b0040c6b667dccsm11939349wmq.25.2023.12.17.11.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 11:22:13 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 17 Dec 2023 20:22:11 +0100
To: Song Liu <song@kernel.org>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, yonghong.song@linux.dev,
	dan.carpenter@linaro.org, olsajiri@gmail.com, asavkov@redhat.com
Subject: Re: [PATCH bpf-next v9 1/4] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <ZX9KY-uouFF1Doz3@krava>
References: <20231215200712.17222-1-9erthalion6@gmail.com>
 <20231215200712.17222-2-9erthalion6@gmail.com>
 <CAPhsuW4VJ-wS_Jh9VCMAvLtbd9djtDikApH4NYCo9+Jgqz8eLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4VJ-wS_Jh9VCMAvLtbd9djtDikApH4NYCo9+Jgqz8eLQ@mail.gmail.com>

On Sat, Dec 16, 2023 at 05:31:21PM -0800, Song Liu wrote:
> On Fri, Dec 15, 2023 at 12:11 PM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> [...]
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index eb447b0a9423..e7393674ab94 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1414,6 +1414,7 @@ struct bpf_prog_aux {
> >         bool dev_bound; /* Program is bound to the netdev. */
> >         bool offload_requested; /* Program is bound and offloaded to the netdev. */
> >         bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp */
> > +       bool attach_tracing_prog; /* true if tracing another tracing program */
> >         bool func_proto_unreliable;
> >         bool sleepable;
> >         bool tail_call_reachable;
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 5e43ddd1b83f..bcc5d5ab0870 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3040,8 +3040,10 @@ static void bpf_tracing_link_release(struct bpf_link *link)
> >         bpf_trampoline_put(tr_link->trampoline);
> >
> >         /* tgt_prog is NULL if target is a kernel function */
> > -       if (tr_link->tgt_prog)
> > +       if (tr_link->tgt_prog) {
> >                 bpf_prog_put(tr_link->tgt_prog);
> > +               link->prog->aux->attach_tracing_prog = false;
> > +       }
> >  }
> >
> >  static void bpf_tracing_link_dealloc(struct bpf_link *link)
> > @@ -3243,6 +3245,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> >                 goto out_unlock;
> >         }
> >
> > +       /* Bookkeeping for managing the prog attachment chain */
> > +       if (tgt_prog &&
> > +           prog->type == BPF_PROG_TYPE_TRACING &&
> > +           tgt_prog->type == BPF_PROG_TYPE_TRACING)
> > +               prog->aux->attach_tracing_prog = true;
> > +
> >         link->tgt_prog = tgt_prog;
> >         link->trampoline = tr;
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8e7b6072e3f4..f8c15ce8fd05 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20077,6 +20077,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >                             struct bpf_attach_target_info *tgt_info)
> >  {
> >         bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
> > +       bool prog_tracing = prog->type == BPF_PROG_TYPE_TRACING;
> >         const char prefix[] = "btf_trace_";
> >         int ret = 0, subprog = -1, i;
> >         const struct btf_type *t;
> > @@ -20147,10 +20148,21 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >                         bpf_log(log, "Can attach to only JITed progs\n");
> >                         return -EINVAL;
> >                 }
> > -               if (tgt_prog->type == prog->type) {
> > -                       /* Cannot fentry/fexit another fentry/fexit program.
> > -                        * Cannot attach program extension to another extension.
> > -                        * It's ok to attach fentry/fexit to extension program.
> > +               if (prog_tracing) {
> > +                       if (aux->attach_tracing_prog) {
> > +                               /*
> > +                                * Target program is an fentry/fexit which is already attached
> > +                                * to another tracing program. More levels of nesting
> > +                                * attachment are not allowed.
> > +                                */
> > +                               bpf_log(log, "Cannot nest tracing program attach more than once\n");
> > +                               return -EINVAL;
> > +                       }
> 
> If we add
> 
> + prog->aux->attach_tracing_prog = true;
> 
> here. We don't need the changes in syscall.c, right?
> 
> IOW, we set attach_tracing_prog at program load time, not attach time.
> 
> Would this work?

I think it'd work.. I can just think of a case where we'd not allow
to attach fentry program (3) to another fentry (2) even if it's not
attached, but just loaded, like:


load (fentry1 -> kernel function)

load (fentry2 -> fentry1)
  fentry2->attach_tracing_prog = true

load (fentry3 -> fentry2)
  if (fentry2->aux->attach_tracing_prog)
    return -EINVAL


I guess it's corner case that does not make much sense, but still it
feels more natural to me to set it in attach time

jirka

> 
> Thanks,
> Song
> 
> > +               } else if (tgt_prog->type == prog->type) {
> > +                       /*
> > +                        * To avoid potential call chain cycles, prevent attaching of a
> > +                        * program extension to another extension. It's ok to attach
> > +                        * fentry/fexit to extension program.

