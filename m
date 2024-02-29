Return-Path: <bpf+bounces-23034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3917886C6B3
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 11:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A545E1F22C0D
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 10:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B63454FB5;
	Thu, 29 Feb 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijbGa53f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F343D6214D
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202034; cv=none; b=RcXGGUkufRW1KS8fcaDl/jxWjBY1JqMermv45s6NX61feCjr910JNzxJY0p0Qxslk3RKKq8PCLYjn5CI54S2uC/Y7YMivrVxDmCwvfZb+HlJDCUFZIVxNuad5H+iMhrHyDbWGTY3qFEa7gMVeWX2hBfYdTW4mq8laNr1Cjo5JvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202034; c=relaxed/simple;
	bh=mYz4CTxgODtFa3/UNVonsY/fkN/Vnwlw3/2VZxizYYQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKmfb9OQghETaqZ5o4Y1/zLTtBDczfC3NGXK6qOt3N/7Ab/DWZnzqiUX7WfW4qz93y1Aey7duE4QBDveoYRhqnAu9iUf6WJsIjnX4+Ig0uWSlglgytnHJLMHFgsnknuf1J+s2w+AnkzmPoczoxhA/YHFj3ToX3obLGmh76onNTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijbGa53f; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33dcad9e3a2so467786f8f.3
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 02:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709202031; x=1709806831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U3LQvMd6bTdeOp+RR5pNzCv+VURRxJw7mgrps+/vIJ0=;
        b=ijbGa53fYlhfUkSJDZxWHGIF1YTknNSZLcxDVTL+pgyrya9TS5PHvbsg1WwB/AWPgU
         g4OgqKf0N+zzIh/rZqemxyRzieCod4iFdXETMWrHXbHRUKu/2fszX0nrRrZIyGOWfDFf
         L664hOfK1uXhSHJenX0w3qUDcLcOi0ZMT4avsdX8jQdlXV5a7EeZiN8eX7M6W3WTlicP
         d5UfWi6wcvbEix8/4SRSRr4VwwnDJ4MBS3udOR9om4pg5Erl3P/RBcLDayIvrzrX0vuz
         b96lVtwdEb2RyncGjdiGU6AbElphUPGnr0qtUbGZZB6jLuCj2OMqRB1fusbIHZL8vrmJ
         t3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709202031; x=1709806831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3LQvMd6bTdeOp+RR5pNzCv+VURRxJw7mgrps+/vIJ0=;
        b=HG6xHj4VUEJe5I7cAtm5K/xLx9DNfwlu9CIxgrcnysA5i7xcqjTlbV/X+8boNbl+KW
         p7vraA3Qfij0gS1xA6VGtygt++nH/k/gCIuigQ8+O4PxhiE8vl66Se9HjGiZPThlP4Ik
         VPEylwoIqTP3tmCeukGGIwGahRKwX52HNbTCZmsOAVnEuZzeb2B+UEuKD67sZ79XYtME
         OZWceCtwm+vgEH3w4NhHavOHeWxKw0aze7Ybhrv2UvjNSsqGdodmLTqkenwcmlw4aZpU
         BjqFZ+l/XJuGmvAEgJEoN+R7S4FIW/TZKyBAO7qhSulCrPDXwGMiZbkSor2zDfzoqwZh
         oyRA==
X-Forwarded-Encrypted: i=1; AJvYcCXkplmi+JmYXxxkEAjR/Er6On5/fAiMjSV9u36Vk0EG9kHy+ww5rZNy5gi/ij54c/YzmvxhIFD+wMYJ/e66k80ZMCiJ
X-Gm-Message-State: AOJu0Yxr0GTye0wGl3rW//jyjgLRrD/JL9oLPb9sfDHGsaATfwlpmWrD
	DJh0BfDazzY9Qq63RIPl/1vgC4fa12ACZjpUNYAZN+a66+d3NnkA
X-Google-Smtp-Source: AGHT+IH4RbcnxPxETLLx2zqq3rlt12OTB3QSYivg3HMT/mjDSeY3TO2JS06bvNPO/3lJPJNEiKGtxA==
X-Received: by 2002:adf:e543:0:b0:33d:815a:47c with SMTP id z3-20020adfe543000000b0033d815a047cmr996455wrm.24.1709202031005;
        Thu, 29 Feb 2024 02:20:31 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d59c6000000b0033d926bf7b5sm1391081wry.76.2024.02.29.02.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:20:30 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 29 Feb 2024 11:20:28 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH RFCv2 bpf-next 1/4] bpf: Add support for kprobe multi
 wrapper attach
Message-ID: <ZeBabPhubblcoLC3@krava>
References: <20240228090242.4040210-1-jolsa@kernel.org>
 <20240228090242.4040210-2-jolsa@kernel.org>
 <CAEf4BzYdSdk79CcwfUpWyvYYfiVWYDDTRFtL=oSCArZwOt-kew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYdSdk79CcwfUpWyvYYfiVWYDDTRFtL=oSCArZwOt-kew@mail.gmail.com>

On Wed, Feb 28, 2024 at 05:23:05PM -0800, Andrii Nakryiko wrote:
> On Wed, Feb 28, 2024 at 1:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to attach bpf program for entry and return probe
> > of the same function. This is common usecase and at the moment
> > it requires to create two kprobe multi links.
> >
> > Adding new attr.link_create.kprobe_multi.flags value that instructs
> > kernel to attach link program to both entry and exit probe.
> >
> > It's possible to control execution of the bpf program on return
> > probe simply by returning zero or non zero from the entry bpf
> > program execution to execute or not respectively the bpf program
> > on return probe.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       |  3 ++-
> >  kernel/trace/bpf_trace.c       | 24 ++++++++++++++++++------
> >  tools/include/uapi/linux/bpf.h |  3 ++-
> >  3 files changed, 22 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index d2e6c5fcec01..a430855c5bcd 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1247,7 +1247,8 @@ enum bpf_perf_event_type {
> >   * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
> >   */
> >  enum {
> > -       BPF_F_KPROBE_MULTI_RETURN = (1U << 0)
> > +       BPF_F_KPROBE_MULTI_RETURN  = (1U << 0),
> > +       BPF_F_KPROBE_MULTI_WRAPPER = (1U << 1),
> >  };
> >
> >  /* link_create.uprobe_multi.flags used in LINK_CREATE command for
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 241ddf5e3895..726a8c71f0da 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2587,6 +2587,7 @@ struct bpf_kprobe_multi_link {
> >         u32 mods_cnt;
> >         struct module **mods;
> >         u32 flags;
> > +       bool is_wrapper;
> 
> flags should be sufficient for this, why storing redundant bool field?

true

> 
> >  };
> >
> >  struct bpf_kprobe_multi_run_ctx {
> > @@ -2826,10 +2827,11 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
> >                           void *data)
> >  {
> >         struct bpf_kprobe_multi_link *link;
> > +       int err;
> >
> >         link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> > -       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> > -       return 0;
> > +       err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> > +       return link->is_wrapper ? err : 0;
> >  }
> >
> >  static void
> > @@ -2967,6 +2969,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >         void __user *uaddrs;
> >         u64 *cookies = NULL;
> >         void __user *usyms;
> > +       bool is_wrapper;
> >         int err;
> >
> >         /* no support for 32bit archs yet */
> > @@ -2977,9 +2980,12 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >                 return -EINVAL;
> >
> >         flags = attr->link_create.kprobe_multi.flags;
> > -       if (flags & ~BPF_F_KPROBE_MULTI_RETURN)
> > +       if (flags & ~(BPF_F_KPROBE_MULTI_RETURN|
> > +                     BPF_F_KPROBE_MULTI_WRAPPER))
> 
> nit: spaces around | are missing, also keep on a single line?

ok

> 
> >                 return -EINVAL;
> >
> > +       is_wrapper = flags & BPF_F_KPROBE_MULTI_WRAPPER;
> > +
> >         uaddrs = u64_to_user_ptr(attr->link_create.kprobe_multi.addrs);
> >         usyms = u64_to_user_ptr(attr->link_create.kprobe_multi.syms);
> >         if (!!uaddrs == !!usyms)
> > @@ -3054,15 +3060,21 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >         if (err)
> >                 goto error;
> >
> > -       if (flags & BPF_F_KPROBE_MULTI_RETURN)
> > -               link->fp.exit_handler = kprobe_multi_link_exit_handler;
> > -       else
> > +       if (is_wrapper) {
> >                 link->fp.entry_handler = kprobe_multi_link_handler;
> > +               link->fp.exit_handler = kprobe_multi_link_exit_handler;
> > +       } else {
> > +               if (flags & BPF_F_KPROBE_MULTI_RETURN)
> > +                       link->fp.exit_handler = kprobe_multi_link_exit_handler;
> > +               else
> > +                       link->fp.entry_handler = kprobe_multi_link_handler;
> > +       }
> >
> 
> how about:
> 
> if (!(flags & BPF_F_KPROBE_MULTI_RETURN))
>     link->fp.entry_handler = kprobe_multi_link_handler;
> if (flags & (BPF_F_KPROBE_MULTI_RETURN | BPF_F_KPROBE_MULTI_WRAPPER))
>     link->fp.exit_handler = kprobe_multi_link_exit_handler;

I have another changes on top of that, which add more handlers,
so I guess I wanted to keep it more explicit, but your suggestion
is simpler, will change

thanks,
jirka

> 
> 
> >         link->addrs = addrs;
> >         link->cookies = cookies;
> >         link->cnt = cnt;
> >         link->flags = flags;
> > +       link->is_wrapper = is_wrapper;
> >
> >         if (cookies) {
> >                 /*
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index d2e6c5fcec01..a430855c5bcd 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -1247,7 +1247,8 @@ enum bpf_perf_event_type {
> >   * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
> >   */
> >  enum {
> > -       BPF_F_KPROBE_MULTI_RETURN = (1U << 0)
> > +       BPF_F_KPROBE_MULTI_RETURN  = (1U << 0),
> > +       BPF_F_KPROBE_MULTI_WRAPPER = (1U << 1),
> >  };
> >
> >  /* link_create.uprobe_multi.flags used in LINK_CREATE command for
> > --
> > 2.43.2
> >

