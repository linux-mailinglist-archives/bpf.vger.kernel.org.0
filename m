Return-Path: <bpf+bounces-13953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4017DF540
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 15:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41CA8B21269
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 14:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7BD6FB4;
	Thu,  2 Nov 2023 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9vEGozf"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB218E1A
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 14:43:52 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE146B7
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 07:43:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-991c786369cso159890866b.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698936229; x=1699541029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yRWY6To//PSv5PztAwMqL72RXy3EgvMFiLC9u6Q/U14=;
        b=F9vEGozfGKRbF86oZbeq/4hALQrPph6WsjeppMQiErVdB7FEBssmjisSpGl/olQs3K
         fjlpDHStVsCVq5/pmLBEAimjN6hfqtgZ6WLeE0MGCBPaQsCS0qaZvNcpM5mcqEOaExIY
         oTepoLAui3UogDdHFsH7/SdLD3IHaA9hQLfcZg8JlSIY3TXMxuto2e3J9pLIxpz0bPQJ
         KkFsZT+T+1ORy7WVeowoe1IkUDEfODQip//17Icg+xbZQfx35N+Ct6ajbMl8mEgx/QeM
         rdOILdXNVcIXGNEloL23lJ7H6X5u2/AFiyFZMz79kfdTDM+nU12hEJOFbIc9VU9yXp+8
         X/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698936229; x=1699541029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRWY6To//PSv5PztAwMqL72RXy3EgvMFiLC9u6Q/U14=;
        b=FmNvrE9kSkvfsu1le+n97TA9FsOeIGSDbtc8IDmBVcoWutX8lz/ADWiwmCdSjevJof
         8BBQyQONLXfBEn2wkLHiMXvGiPWJvWIaM5OgxfJKutyHMbGoWiIyzm9MLDylZBeVXKEG
         yt/cvEMfy3uyBqt5paM4aSa7xwnhwjyykYy+N67plZBHEuK9dhMjdWlnloL663D+BKGY
         NF5rwlmNXjKvsE78SkQk/+SjcETHcPHS+lR6dcVqWJwudBcVSFPWxb+XCfPRbL5NiYIp
         38qvDwvIDV9yedCi8H19uAPkx/BhsIZ40FIb3opCZfOX0/9zwNoSKRRb9hzzMHutUDcs
         VTaQ==
X-Gm-Message-State: AOJu0YyxPuG69aXlCQCgkUxIdfExkONny6jIXdf9IfpmTl4x6Ku79MAa
	flnhiAzFysz4x1Q0yq5Fh6c=
X-Google-Smtp-Source: AGHT+IEup6tmEfBo69EQ4kMAmko3KYZc5Fdt4shvegdLy/+1kQ1KVhIAvv/eR2yUgJpoyv3vKN6puQ==
X-Received: by 2002:a17:907:d502:b0:9db:e46c:569 with SMTP id wb2-20020a170907d50200b009dbe46c0569mr1218961ejc.45.1698936229006;
        Thu, 02 Nov 2023 07:43:49 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id l12-20020a1709062a8c00b0099315454e76sm1210181eje.211.2023.11.02.07.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 07:43:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 Nov 2023 15:43:45 +0100
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
Subject: Re: [PATCH bpf-next 3/6] bpf: Add link_info support for uprobe multi
 link
Message-ID: <ZUO1oTWcMKKbTLWI@krava>
References: <20231025202420.390702-1-jolsa@kernel.org>
 <20231025202420.390702-4-jolsa@kernel.org>
 <CAEf4Bzbi8EgT-CC9jS69sV2whk1Dnr-WV5mRyCs=W3JxOMvtWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbi8EgT-CC9jS69sV2whk1Dnr-WV5mRyCs=W3JxOMvtWg@mail.gmail.com>

On Wed, Nov 01, 2023 at 03:21:36PM -0700, Andrii Nakryiko wrote:

SNIP

> > +               struct {
> > +                       __aligned_u64 path;
> > +                       __aligned_u64 offsets;
> > +                       __aligned_u64 ref_ctr_offsets;
> > +                       __aligned_u64 cookies;
> > +                       __u32 path_max; /* in/out: uprobe_multi path size */
> 
> people already called out that path_size makes for a better name, I agree
> 
> > +                       __u32 count;    /* in/out: uprobe_multi offsets/ref_ctr_offsets/cookies count */
> 
> otherwise we'd have to call this count_max :)

path_size is good ;-)


> 
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
> 
> on attach we do
> 
> task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
> 
> So on attachment we take pid in user's namespace, is that right? It's
> kind of asymmetrical that we return the global PID back? Should we try
> to convert PID to user's namespace instead?

you're right, I think we should use this:

  task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current))

> 
> > +
> > +       if (upath) {
> > +               if (upath_max > PATH_MAX)
> > +                       return -E2BIG;
> 
> no need to fail here, as pointed out elsewhere
> 
> > +               buf = kmalloc(upath_max, GFP_KERNEL);
> 
> here we can allocate min(PATH_MAX, upath_max)

yes, will do that

> 
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
> 
> it would be good to still return actual counts for out parameters, no?

hm, we do that few lines above with:

        info->uprobe_multi.count = umulti_link->cnt;

if that's what you mean

thanks,
jirka

