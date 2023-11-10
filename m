Return-Path: <bpf+bounces-14747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 224437E7A5A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 10:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24751C20D34
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 09:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BA4D506;
	Fri, 10 Nov 2023 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ7BIcKm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0DED269
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 09:01:24 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72E7A5F7
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 01:01:21 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso2832754a12.1
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 01:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699606880; x=1700211680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7cQuee20pHdkoBauXFtPx8H12c1Wo89fa07y5J8E2w=;
        b=DJ7BIcKm0xgjEvjhyV2y+DPt2E1dVGa4yeqrX2H54h8DUezNAoNTp5NuIckuJXXS8Z
         1EHp+124In+oB9qXbqPbFC1p+qPt444sO1ioXSUR+sTCsnDnuZFVwoS5dmAcBxq9OoVG
         DPYAJqC6oDZ3tQXwgswQjxsYBboZgMmpMZOnYUo95slYccNO02xXqD+QoFSLYILMbH6u
         Or49ZEmhYURqzPyHnO1DJW/+x+HdxyMgcqX5tKUJPaHODXNJR0l3+TwyJ/zdBVjqWVQm
         ql2x32ykJdBc7wjzmC893TjC+bvBQ3FrifGw2uBMDru77b15D/7n6v+zsARQaos0dkmA
         94XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699606880; x=1700211680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7cQuee20pHdkoBauXFtPx8H12c1Wo89fa07y5J8E2w=;
        b=lqzCplw/BFjm/GQkldK1o2M96XHUNOS5ftgysH3j+nE7LLqenUeL+iwjjEqODKaAvI
         LyovWfBpgkIgeC5QxlzU9/TNP0PFxdJSGHZlvN+VyWcPGZcRfPgOgO8opkWs2VWRJt9N
         YWv/yimAABPnDA8BImhgCzAzmamKqcS/RlPC72uxsW+MydzCeIDPHwA9P8JDWC7Xr4on
         on6ZnU1ZdplTwLSNgyblivOvfkQOafFlZJebwhVkm5t6akuHXISIM+1a2QQ1e50dV1pI
         X1KAC+ChmeQMfiosGxgUZMWULZhujb5cVfVPfciIYWrGqKKWbhILnPPSMllhF1uU21Oq
         QPnA==
X-Gm-Message-State: AOJu0YxIWxBa/DMokpkwZKF5D1/SlsSen0NpTMsmJbHxF9Q8obIhjheC
	5zmocmRV5ozuPN6r4ku3utA=
X-Google-Smtp-Source: AGHT+IF1fAM9H6j6PTVX6V4ryoFzVIiampeNKufa+5+d1TpwnX+mtNAP4kDo2t06oGkbusfPaetQGg==
X-Received: by 2002:a17:907:7da4:b0:9dd:7536:2b0 with SMTP id oz36-20020a1709077da400b009dd753602b0mr5979980ejc.50.1699606879714;
        Fri, 10 Nov 2023 01:01:19 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id m15-20020a1709060d8f00b0099297782aa9sm3603628eji.49.2023.11.10.01.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 01:01:19 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 10 Nov 2023 10:01:17 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCHv2 bpf-next 3/6] bpf: Add link_info support for uprobe
 multi link
Message-ID: <ZU3xXQYLy27ywA3g@krava>
References: <20231109092838.721233-1-jolsa@kernel.org>
 <20231109092838.721233-4-jolsa@kernel.org>
 <CAEf4BzZAh=aW_4bXSJdBZ-UcoCqa0CuejXBdb7+fB9bDP4q+eQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZAh=aW_4bXSJdBZ-UcoCqa0CuejXBdb7+fB9bDP4q+eQ@mail.gmail.com>

On Thu, Nov 09, 2023 at 09:57:03PM -0800, Andrii Nakryiko wrote:

SNIP

> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 52c1ec3a0467..1ea54f3b3f73 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3046,6 +3046,7 @@ struct bpf_uprobe_multi_link {
> >         u32 cnt;
> >         struct bpf_uprobe *uprobes;
> >         struct task_struct *task;
> > +       u32 flags;
> >  };
> >
> >  struct bpf_uprobe_multi_run_ctx {
> > @@ -3085,9 +3086,76 @@ static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
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
> > +       u32 upath_size = info->uprobe_multi.path_size;
> > +       struct bpf_uprobe_multi_link *umulti_link;
> > +       u32 ucount = info->uprobe_multi.count;
> > +       int err = 0, i;
> > +       long left;
> > +
> > +       if (!upath ^ !upath_size)
> > +               return -EINVAL;
> > +
> > +       if (!uoffsets ^ !ucount)
> 
> uoffsets is not the only one that requires ucount, right?

yep, cookies as well

> 
> > +               return -EINVAL;
> > +
> > +       umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> > +       info->uprobe_multi.count = umulti_link->cnt;
> > +       info->uprobe_multi.flags = umulti_link->flags;
> > +       info->uprobe_multi.pid = umulti_link->task ?
> > +                                task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
> > +
> > +       if (upath) {
> > +               char *p, *buf;
> > +
> > +               upath_size = min_t(u32, upath_size, PATH_MAX);
> > +
> > +               buf = kmalloc(upath_size, GFP_KERNEL);
> > +               if (!buf)
> > +                       return -ENOMEM;
> > +               p = d_path(&umulti_link->path, buf, upath_size);
> > +               if (IS_ERR(p)) {
> > +                       kfree(buf);
> > +                       return -ENOSPC;
> > +               }
> > +               left = copy_to_user(upath, p, buf + upath_size - p);
> > +               kfree(buf);
> > +               if (left)
> > +                       return -EFAULT;
> 
> hmm.. I expected the actual path_size to be reported back to the
> user?.. Is there a problem with doing that?

we return back the string, if the string fits in provided buffer it's
terminated with 0 and user space can do strlen on it if needed

> 
> > +       }
> > +
> > +       if (!uoffsets)
> > +               return 0;
> 
> why guard by uoffsets? what if users only wanted cookies? I think each
> array should do its own checking and be independent, no?

I did not think of the use case to get just the cookies (at least not the
one in bpftool), I saw it as optional to offsets, which is mandatory..
but that should be an easy change I think

jirka

> 
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
> > @@ -3276,6 +3344,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >         link->uprobes = uprobes;
> >         link->path = path;
> >         link->task = task;
> > +       link->flags = flags;
> >
> >         bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
> >                       &bpf_uprobe_multi_link_lops, prog);
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 0f6cdf52b1da..05b355da4508 100644
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
> > +                       __u32 path_size;
> > +                       __u32 count; /* in/out: uprobe_multi offsets/ref_ctr_offsets/cookies count */
> > +                       __u32 flags;
> > +                       __u32 pid;
> > +               } uprobe_multi;
> >                 struct {
> >                         __u32 type; /* enum bpf_perf_event_type */
> >                         __u32 :32;
> > --
> > 2.41.0
> >

