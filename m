Return-Path: <bpf+bounces-13423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC4B7D9A9B
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 16:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5696AB2147C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 13:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8D0358AD;
	Fri, 27 Oct 2023 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlXsilkS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543D18AE4
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 13:59:41 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC956D6
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:59:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9be1ee3dc86so297149066b.1
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698415176; x=1699019976; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xbh6Sn87DtkKwp39TczGoubSeLzxB+6fI+iism+/ArE=;
        b=NlXsilkSQlLwme3NrFrlr5V16HbQKHWzFNq0u95a6wgIhEi6i91SLQffYd44lrBWXZ
         0ouJI5pDMsfHQX9aq/StkTWyG72KjVs5GVoCFJRPAUVdE3ju9dgAQ/lUmjKfoDZzzDri
         qEboGVeVGGf4tLSmddyWwPSDMcycdNdIhu9vtxUsa6Hgwp8hs1zlxRAzL6E6l0RR7N7y
         4jq0kMVhQdTFlIQMJ/cQpYevhVG+4yBUNH+s8I76WbzMo7p8csfuw0v/0F9YUnDqTwuZ
         JgSE43ePQqAyaGe7KImruL3ERUR5kvGHl+H4iFOzfhBSmZ5H9TkM+gIe4XxupdZ2Vgnt
         OMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698415176; x=1699019976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbh6Sn87DtkKwp39TczGoubSeLzxB+6fI+iism+/ArE=;
        b=gj5ELv/4SASx+DVFAH7V6qcAbd4DB3qNDfOXk3QkdI/1k7pELRvY46KcMygk0ERvX0
         cWbiDjS1dg5WzggAQYxSmhhFI2Mr2yd5KHNlmATilvQo9uPAI2089ujgmzgcGckTGNYm
         99jSEo4z7QKqpvFwL38jMClSf9H9aI7wysl59H1h+ZiN5ZXLkxCCeimzPKjsg6mkQWLU
         aLrEeJNzw3as1xIzjbNVzpwfYOEKSWkuza+SZ93x/krayJyqSg459oIVme9EjrkW17T3
         tP12yKAAcSAYVy3KD6LnqJeVAS2CykgDi8ByZlrAWCtbJtKJvSF3iI9y1Tb3wI0sPXCy
         x+kg==
X-Gm-Message-State: AOJu0Yw6R1v0PNKc6MZIJBFKdHOKwv9w/gHu7k/KoR+61S1RU31NXHZ2
	gDQOUwRb17k6RZqpOSSv5l0=
X-Google-Smtp-Source: AGHT+IFmDWyVdgHDJ5jeY7lca62aj9gI3avF8xY0Ibo8ZNoZwL/NSyAIoJlDRxjHIMcWBHWHLx5Mcg==
X-Received: by 2002:a17:907:2d09:b0:9c3:a3f2:4cec with SMTP id gs9-20020a1709072d0900b009c3a3f24cecmr2384675ejc.0.1698415175964;
        Fri, 27 Oct 2023 06:59:35 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id va13-20020a17090711cd00b009b2c5363ebasm1225064ejb.26.2023.10.27.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:59:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 27 Oct 2023 15:59:33 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Add link_info support for uprobe multi
 link
Message-ID: <ZTvCRYi6OMlZYfAz@krava>
References: <20231025202420.390702-1-jolsa@kernel.org>
 <20231025202420.390702-4-jolsa@kernel.org>
 <CALOAHbAZ6=A9j3VFCLoAC_WhgQKU7injMf06=cM2sU4Hi4Sx+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbAZ6=A9j3VFCLoAC_WhgQKU7injMf06=cM2sU4Hi4Sx+Q@mail.gmail.com>

On Thu, Oct 26, 2023 at 07:57:27PM +0800, Yafang Shao wrote:
> On Thu, Oct 26, 2023 at 4:24 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to get uprobe_link details through bpf_link_info
> > interface.
> >
> > Adding new struct uprobe_multi to struct bpf_link_info to carry
> > the uprobe_multi link details.
> >
> > The uprobe_multi.count is passed from user space to denote size
> > of array fields (offsets/ref_ctr_offsets/cookies). The actual
> > array size is stored back to uprobe_multi.count (allowing user
> > to find out the actual array size) and array fields are populated
> > up to the user passed size.
> >
> > All the non-array fields (path/count/flags/pid) are always set.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       | 10 +++++
> >  kernel/trace/bpf_trace.c       | 68 ++++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 10 +++++
> >  3 files changed, 88 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 0f6cdf52b1da..960cf2914d63 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6556,6 +6556,16 @@ struct bpf_link_info {
> >                         __u32 flags;
> >                         __u64 missed;
> >                 } kprobe_multi;
> > +               struct {
> > +                       __aligned_u64 path;
> > +                       __aligned_u64 offsets;
> > +                       __aligned_u64 ref_ctr_offsets;
> > +                       __aligned_u64 cookies;
> 
> The bpf cookie for the perf_event link is exposed through
> 'pid_iter.bpf.c,' while the cookies for the tracing link and
> kprobe_multi link are not exposed at all. This inconsistency can be
> confusing. I believe it would be better to include all of them in the
> link_info. The reason is that 'pid_iter' depends on the task holding
> the links, which may not exist. However, I think we handle this in a
> separate patchset. What do you think?

right, I think we should add cookies for both kprobe_multi
and tracing link, I'll add that in new version

thanks,
jirka

> 
> > +                       __u32 path_max; /* in/out: uprobe_multi path size */
> > +                       __u32 count;    /* in/out: uprobe_multi offsets/ref_ctr_offsets/cookies count */
> > +                       __u32 flags;
> > +                       __u32 pid;
> > +               } uprobe_multi;
> >                 struct {
> >                         __u32 type; /* enum bpf_perf_event_type */
> >                         __u32 :32;
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 843b3846d3f8..9f8ad19a1a93 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3042,6 +3042,7 @@ struct bpf_uprobe_multi_link {
> >         u32 cnt;
> >         struct bpf_uprobe *uprobes;
> >         struct task_struct *task;
> > +       u32 flags;
> >  };
> >
> >  struct bpf_uprobe_multi_run_ctx {
> > @@ -3081,9 +3082,75 @@ static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
> >         kfree(umulti_link);
> >  }
> >
> > +static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
> > +                                               struct bpf_link_info *info)
> > +{
> > +       u64 __user *uref_ctr_offsets = u64_to_user_ptr(info->uprobe_multi.ref_ctr_offsets);
> > +       u64 __user *ucookies = u64_to_user_ptr(info->uprobe_multi.cookies);
> > +       u64 __user *uoffsets = u64_to_user_ptr(info->uprobe_multi.offsets);
> > +       u64 __user *upath = u64_to_user_ptr(info->uprobe_multi.path);
> > +       u32 upath_max = info->uprobe_multi.path_max;
> > +       struct bpf_uprobe_multi_link *umulti_link;
> > +       u32 ucount = info->uprobe_multi.count;
> > +       int err = 0, i;
> > +       char *p, *buf;
> > +       long left;
> > +
> > +       if (!upath ^ !upath_max)
> > +               return -EINVAL;
> > +
> > +       if (!uoffsets ^ !ucount)
> > +               return -EINVAL;
> > +
> > +       umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> > +       info->uprobe_multi.count = umulti_link->cnt;
> > +       info->uprobe_multi.flags = umulti_link->flags;
> > +       info->uprobe_multi.pid = umulti_link->task ?
> > +                                task_pid_nr(umulti_link->task) : (u32) -1;
> > +
> > +       if (upath) {
> > +               if (upath_max > PATH_MAX)
> > +                       return -E2BIG;
> > +               buf = kmalloc(upath_max, GFP_KERNEL);
> > +               if (!buf)
> > +                       return -ENOMEM;
> > +               p = d_path(&umulti_link->path, buf, upath_max);
> > +               if (IS_ERR(p)) {
> > +                       kfree(buf);
> > +                       return -ENOSPC;
> > +               }
> > +               left = copy_to_user(upath, p, buf + upath_max - p);
> > +               kfree(buf);
> > +               if (left)
> > +                       return -EFAULT;
> > +       }
> > +
> > +       if (!uoffsets)
> > +               return 0;
> > +
> > +       if (ucount < umulti_link->cnt)
> > +               err = -ENOSPC;
> > +       else
> > +               ucount = umulti_link->cnt;
> > +
> > +       for (i = 0; i < ucount; i++) {
> > +               if (put_user(umulti_link->uprobes[i].offset, uoffsets + i))
> > +                       return -EFAULT;
> > +               if (uref_ctr_offsets &&
> > +                   put_user(umulti_link->uprobes[i].ref_ctr_offset, uref_ctr_offsets + i))
> > +                       return -EFAULT;
> > +               if (ucookies &&
> > +                   put_user(umulti_link->uprobes[i].cookie, ucookies + i))
> > +                       return -EFAULT;
> > +       }
> > +
> > +       return err;
> > +}
> > +
> >  static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
> >         .release = bpf_uprobe_multi_link_release,
> >         .dealloc = bpf_uprobe_multi_link_dealloc,
> > +       .fill_link_info = bpf_uprobe_multi_link_fill_link_info,
> >  };
> >
> >  static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> > @@ -3272,6 +3339,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >         link->uprobes = uprobes;
> >         link->path = path;
> >         link->task = task;
> > +       link->flags = flags;
> >
> >         bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
> >                       &bpf_uprobe_multi_link_lops, prog);
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 0f6cdf52b1da..960cf2914d63 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -6556,6 +6556,16 @@ struct bpf_link_info {
> >                         __u32 flags;
> >                         __u64 missed;
> >                 } kprobe_multi;
> > +               struct {
> > +                       __aligned_u64 path;
> > +                       __aligned_u64 offsets;
> > +                       __aligned_u64 ref_ctr_offsets;
> > +                       __aligned_u64 cookies;
> > +                       __u32 path_max; /* in/out: uprobe_multi path size */
> > +                       __u32 count;    /* in/out: uprobe_multi offsets/ref_ctr_offsets/cookies count */
> > +                       __u32 flags;
> > +                       __u32 pid;
> > +               } uprobe_multi;
> >                 struct {
> >                         __u32 type; /* enum bpf_perf_event_type */
> >                         __u32 :32;
> > --
> > 2.41.0
> >
> 
> 
> -- 
> Regards
> Yafang

