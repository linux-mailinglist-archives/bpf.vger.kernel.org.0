Return-Path: <bpf+bounces-9236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3617920AE
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 09:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3F1280F58
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 07:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2809ECE;
	Tue,  5 Sep 2023 07:19:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F05EBC
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 07:19:47 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E7DCC2
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 00:19:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a5dff9d2d9so316086166b.3
        for <bpf@vger.kernel.org>; Tue, 05 Sep 2023 00:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693898384; x=1694503184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zl6G1++ZEWCjAINx287DAb0VzNQTwBTqyRqOjycduRE=;
        b=h7WSJpRLF1+JMS+pj/H0ln2k2Xxo7c4fg+Shjv61b893JaHDlf7Sx4g4Mg9dVJMwpg
         LzIkqEkJALkD5xFyHxbq8pvtldBl/wNmCIDp3uB6kSKnhr6PWHYFe8qiUt0qTh0ynjrS
         OJB8SExtJFV7ZSGcW/rQJcOe7hyo7p2UYzzxHuCAzznYqauEGa7EHo7m5/wqQ1CeJns+
         mJUEUeH3Jbv+YMIYrgjgdnOm14oeeLGzRjVtEtDgO69kwT7NKzE47rRezqB66yuNGQlB
         WEfmZrLGei4LLUcOcLm4nqoxjSeJof5CXDWtc8oWCieKiqTYv9Rp3N9EA4Cut+dniDQE
         Rr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693898384; x=1694503184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zl6G1++ZEWCjAINx287DAb0VzNQTwBTqyRqOjycduRE=;
        b=SJp+4gIwyDYx2r/XtXByi5j8hpDNyYiQ/x9S5YIAZ29NfoK+3ShnCL0/ismLjel9Ej
         m/qLybL7mTPWcrRA0QGXcVOEXII4rFdyr+e5diSze/NuqQWSfMMqBah+F8ADTWT4AfjP
         a2dQudDgWrS6P4JcBrIH5S19EZr52CDzp1tfH6Fcn5v4vsUNsMMqIuecy4w3X8cyNRze
         2EdvowiimBc8hg6RT8P4tUhyjwRB06bpcwwnBZLSEr38HDnaYI7pc5UcuUXt1aEsYHwU
         zEIJY7n3vvIOZgSh8GtODdnHSCuxeWo/pzUCMJE7GynjEa2DCcDQP30+DRiAQjiAI1cJ
         Bf2w==
X-Gm-Message-State: AOJu0Yzrj/r/JQYo1dK7kDKXPo5aPfIemfSHqHcC1T31E0kC2I0MJBhk
	8AlqJ6l+0s3EH22XX3ec/QY=
X-Google-Smtp-Source: AGHT+IGeWopOGx1a45MCdmRXP0IyKJATwWB7o0cmPcfBmLDvIfHQO3lyzmqvK9BK9dycQyDxoLbZJQ==
X-Received: by 2002:a17:906:2d2:b0:99b:c86b:1d25 with SMTP id 18-20020a17090602d200b0099bc86b1d25mr9347015ejk.26.1693898383990;
        Tue, 05 Sep 2023 00:19:43 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id lt20-20020a170906fa9400b009a193a5acffsm7107679ejb.121.2023.09.05.00.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 00:19:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Sep 2023 09:19:41 +0200
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 05/12] bpf: Add missed value to kprobe perf link
 info
Message-ID: <ZPbWjW8/do1YCstj@krava>
References: <20230828075537.194192-1-jolsa@kernel.org>
 <20230828075537.194192-6-jolsa@kernel.org>
 <4540a09e-43a4-c258-710c-af895138ba6b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4540a09e-43a4-c258-710c-af895138ba6b@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 10:23:27AM +0800, Hou Tao wrote:
> Hi,
> 
> On 8/28/2023 3:55 PM, Jiri Olsa wrote:
> > Add missed value to kprobe attached through perf link info to
> > hold the stats of missed kprobe handler execution.
> >
> > The kprobe's missed counter gets incremented when kprobe handler
> > is not executed due to another kprobe running on the same cpu.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/trace_events.h   |  6 ++++--
> >  include/uapi/linux/bpf.h       |  1 +
> >  kernel/bpf/syscall.c           | 14 ++++++++------
> >  kernel/trace/bpf_trace.c       |  5 +++--
> >  kernel/trace/trace_kprobe.c    |  5 ++++-
> >  tools/include/uapi/linux/bpf.h |  1 +
> >  6 files changed, 21 insertions(+), 11 deletions(-)
> >
> 
> SNIP
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 17c21c0b2dd1..998c88874507 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -1546,7 +1546,8 @@ NOKPROBE_SYMBOL(kretprobe_perf_func);
> >  
> >  int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
> >  			const char **symbol, u64 *probe_offset,
> > -			u64 *probe_addr, bool perf_type_tracepoint)
> > +			u64 *probe_addr, unsigned long *missed,
> > +			bool perf_type_tracepoint)
> >  {
> >  	const char *pevent = trace_event_name(event->tp_event);
> >  	const char *group = event->tp_event->class->system;
> > @@ -1565,6 +1566,8 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
> >  	*probe_addr = kallsyms_show_value(current_cred()) ?
> >  		      (unsigned long)tk->rp.kp.addr : 0;
> >  	*symbol = tk->symbol;
> > +	if (missed)
> > +		*missed = tk->rp.kp.nmissed;
> 
> According to the implement of probes_profile_seq_show(), the missed
> counter for kretprobe should be tk->rp.kp.nmissed + tk->rp.nmissed. I
> think it would be a good idea to factor out a common helper to get the
> missed counter for kprobe or kretprobe.

ok, makes sense.. will check, I was also thinking to move
bpf_get_kprobe_info args into struct

jirka

> >  	return 0;
> >  }
> >  #endif	/* CONFIG_PERF_EVENTS */
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index b754edfb0cd7..5a39c7a13499 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -6539,6 +6539,7 @@ struct bpf_link_info {
> >  					__u32 name_len;
> >  					__u32 offset; /* offset from func_name */
> >  					__u64 addr;
> > +					__u64 missed;
> >  				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
> >  				struct {
> >  					__aligned_u64 tp_name;   /* in/out */
> 

