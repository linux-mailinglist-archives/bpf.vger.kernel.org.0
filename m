Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08ED6F0674
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbjD0NOg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 09:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243389AbjD0NOf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 09:14:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C593C29
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 06:14:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2f46348728eso5223360f8f.3
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682601272; x=1685193272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HNYlwac9oZQ+6MXcYebrMYl4V0al9Omj8nMM+PqogVg=;
        b=ARH2yJhf+QrYkkyrhkOyhg7n53FC9JUOi2rAFEOFwICPo1QSooPp90JW3EQc6kisPC
         2ve3Zey3c5hrSMiIeVfUcKY2sVhjQEYgTnl9V4GxyZGRAEmJzu8r3a4U/DteUJMCCtAi
         9pwlGTIhGh98Oc8TH0g2I9DV0FoXiB+jZl+z2TJkJR3IrXqMkTnqCSqjPNVQ77Ky4HUg
         BqitNHyrs0Weyb4Z98sCxVUrPYTzKK+pFkvRUtQae58yVg5BxdYPMmL/1CEEDFIsRFAe
         13be9DV8lQA5z9QMXxZGeVaoyPHIV8F11MGI0pFCQVOalVpFvTapj//BQI+mUcviPArN
         6awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682601272; x=1685193272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNYlwac9oZQ+6MXcYebrMYl4V0al9Omj8nMM+PqogVg=;
        b=RWFZzcVs4wdPC05som0BFPlrqHMSoThI1dAxU1n4YOz8R8/1d4L2xKutFdgMlXV7RA
         VjbWXDUF1wRlp5IkXZ1TgEB/iB0QDpApV5+IwaxPRoU4ZyIEqT+8dqymMA2MKXEcTSE4
         /ceJY1pAs7F8ztknOUV6RFvjpSp3gBGVvt3zlG21k06iwZEo0zwB7hPzfeeILJ+cDe+i
         s4YmTsGNh7do/zJBq1WQrySc51fXOJE5MXsyqgqNl/l8vhyrKNRs8+PeWJMUMn6Efs60
         YQe9jHprSqaenN447q0krDC3nLxtiuJwJdx6FCEhRZ9CPYIS8YOX38utcjDSsbaZuEBP
         YQew==
X-Gm-Message-State: AC+VfDwTYFji1nna5plZoYl9ZZnXypFv0CqR6+DWdwpeESeZiLppG2TD
        KYv7yqJ6KaqtSs4tdSrurCw=
X-Google-Smtp-Source: ACHHUZ66YyLjOr/xvDi6yQKZ1S/Z7MYVoLoLKCuzMKe2hl0i/bfZC0/Xw1Tk6vO8JeliYAZob0BgZQ==
X-Received: by 2002:a5d:4b4a:0:b0:2fb:599b:181e with SMTP id w10-20020a5d4b4a000000b002fb599b181emr1115225wrs.63.1682601271632;
        Thu, 27 Apr 2023 06:14:31 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id jb12-20020a05600c54ec00b003f17003e26esm24564399wmb.15.2023.04.27.06.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 06:14:31 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 27 Apr 2023 15:14:29 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC/PATCH bpf-next 01/20] bpf: Add multi uprobe link
Message-ID: <ZEp1NUQpISWPZCN9@krava>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <20230424160447.2005755-2-jolsa@kernel.org>
 <CAEf4BzZ1C488vfg=Nvqv6wGhm7TEHdG9YEjaEBExYHCLML54cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ1C488vfg=Nvqv6wGhm7TEHdG9YEjaEBExYHCLML54cg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 12:00:10PM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 24, 2023 at 9:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding new multi uprobe link that allows to attach bpf program
> > to multiple uprobes.
> >
> > Uprobes to attach are specified via new link_create uprobe_multi
> > union:
> >
> >   struct {
> >           __u32           flags;
> >           __u32           cnt;
> >           __aligned_u64   paths;
> >           __aligned_u64   offsets;
> >           __aligned_u64   ref_ctr_offsets;
> >   } uprobe_multi;
> >
> > Uprobes are defined in paths/offsets/ref_ctr_offsets arrays with
> > the same 'cnt' length. Each uprobe is defined with a single index
> > in all three arrays:
> >
> >   paths[idx], offsets[idx] and/or ref_ctr_offsets[idx]
> >
> > The 'flags' supports single bit for now that marks the uprobe as
> > return probe.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/trace_events.h |   6 +
> >  include/uapi/linux/bpf.h     |  14 +++
> >  kernel/bpf/syscall.c         |  16 ++-
> >  kernel/trace/bpf_trace.c     | 231 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 265 insertions(+), 2 deletions(-)
> >
> 
> [...]
> 
> > @@ -4666,10 +4667,21 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
> >                 ret = bpf_perf_link_attach(attr, prog);
> >                 break;
> >         case BPF_PROG_TYPE_KPROBE:
> > +               /* Ensure that program with eBPF_TRACE_UPROBE_MULTI attach type can
> 
> eBPF_TRACE_UPROBE_MULTI :)

will fix ;-)

> 
> > +                * attach only to uprobe_multi link. It has its own runtime context
> > +                * which is specific for get_func_ip/get_attach_cookie helpers.
> > +                */
> > +               if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI &&
> > +                   attr->link_create.attach_type != BPF_TRACE_UPROBE_MULTI) {
> > +                       ret = -EINVAL;
> > +                       goto out;
> > +               }
> 
> as Yonghong pointed out, you check this condition in
> bpf_uprobe_multi_link_attach() already, so why redundant check?

I tried to answer that in here:
  https://lore.kernel.org/bpf/ZEjU0ykZZTHMVlZt@krava/

> 
> >                 if (attr->link_create.attach_type == BPF_PERF_EVENT)
> >                         ret = bpf_perf_link_attach(attr, prog);
> > -               else
> > +               else if (attr->link_create.attach_type == BPF_TRACE_KPROBE_MULTI)
> >                         ret = bpf_kprobe_multi_link_attach(attr, prog);
> > +               else if (attr->link_create.attach_type == BPF_TRACE_UPROBE_MULTI)
> > +                       ret = bpf_uprobe_multi_link_attach(attr, prog);
> >                 break;
> >         default:
> >                 ret = -EINVAL;
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index bcf91bc7bf71..b84a7d01abf4 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/sort.h>
> >  #include <linux/key.h>
> >  #include <linux/verification.h>
> > +#include <linux/namei.h>
> >
> >  #include <net/bpf_sk_storage.h>
> >
> > @@ -2901,3 +2902,233 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
> >         return 0;
> >  }
> >  #endif
> > +
> > +#ifdef CONFIG_UPROBES
> > +struct bpf_uprobe_multi_link;
> > +
> > +struct bpf_uprobe {
> > +       struct bpf_uprobe_multi_link *link;
> > +       struct inode *inode;
> > +       loff_t offset;
> > +       loff_t ref_ctr_offset;
> 
> you seem to need this only during link creation, so we are wasting 8
> bytes here per each instance of bpf_uprobe for no good reason? You
> should be able to easily move this out of bpf_uprobe into a temporary
> array.

right, we just need offset and inode, good catch, will fix

> 
> > +       struct uprobe_consumer consumer;
> > +};
> > +
> > +struct bpf_uprobe_multi_link {
> > +       struct bpf_link link;
> > +       u32 cnt;
> > +       struct bpf_uprobe *uprobes;
> > +};
> > +
> 
> [...]
> 
> > +       if (prog->expected_attach_type != BPF_TRACE_UPROBE_MULTI)
> > +               return -EINVAL;
> > +
> > +       flags = attr->link_create.uprobe_multi.flags;
> > +       if (flags & ~BPF_F_UPROBE_MULTI_RETURN)
> > +               return -EINVAL;
> > +
> > +       upaths = u64_to_user_ptr(attr->link_create.uprobe_multi.paths);
> > +       uoffsets = u64_to_user_ptr(attr->link_create.uprobe_multi.offsets);
> > +       if (!!upaths != !!uoffsets)
> > +               return -EINVAL;
> 
> when having these as NULL would be ok? cnt == 0? or is there some
> valid situation?

ah nope, that needs to be always != NULL, will fix

> 
> > +
> > +       uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
> 
> if upaths is NULL, uref_ctr_offsets should be NULL as well?

we need to fail when upaths is NULL, so that should be taken care of

thanks,
jirka

