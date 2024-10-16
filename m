Return-Path: <bpf+bounces-42151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB749A019A
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 08:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1A3288407
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 06:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1132E1AF0C0;
	Wed, 16 Oct 2024 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz8oliIk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E0A1925AB;
	Wed, 16 Oct 2024 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060895; cv=none; b=SibXk5+KOwbSyqM/kf2+M38sFShJmofj/99q7RDVsnbTyrD+LIEXiS+KPFHU/sFXraJ8rc+mpXAATbZ5iQGS4HnzuW+UesXKO/Hvt4MLAY9I5lg+Gi7PHwT3zqPFMVNW989psKbmbzJsBQtrkm77y0oOH9HCecCvoAbIL6yc3k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060895; c=relaxed/simple;
	bh=9buN6B0a1P/fouEa7lGOzxQEmtGq3mQx/ABtI/ocsE8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqpqeLZA+faU/N4WTNioSpAfDqsXaB9P+tbl1BcNC4rZW0XG2orYqpKtpO1eDfGpK/2CbcZkCb5AEcEWmk7DEkb841lQ+u6hA9OoQr9u6w6z2T8YnVYVl4Ug9sa/iTYE+YmYoR+S8P4sFWonE3wT42kelVw1TqN9sVNFyyp5sT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz8oliIk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d47b38336so3922735f8f.3;
        Tue, 15 Oct 2024 23:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729060892; x=1729665692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7i5+HvUzunWz4n5qk4xNRl8y+WY1cbMRKJb/pt3aQHc=;
        b=Dz8oliIkdt8XpWUZeGP6W2fRCJIBBHG/47kIR2qk66OybbU8EVPo0CZi4gTvaL8baG
         jV4yi86p2Qf4Z6nSQDGwlTtpJuGG4Y5ZF8u1KPFpaE2c8e2b41+IU0MWI9yspB6PPj1s
         0RBd0VziiWow1nVf1ibaxmwdrg7gOXbnxan6kXRxjnK6qnRhcdXlzrpkUn4TAwDO9M+c
         /hmt8znCCph4zIz4mHC05NUHvT06D/uJs74b/JGJ2A5cJoVL9nuOSqN7SPyI6bvJ2oab
         dgI5CYHTGXTg3xATAL6lvN289FAjnXBKgdJMIYMVNmOm9p9XGoVCLLcmMunRfjAz/946
         f1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729060892; x=1729665692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7i5+HvUzunWz4n5qk4xNRl8y+WY1cbMRKJb/pt3aQHc=;
        b=DHpXAFMUYGPfHu/5u3mM0FMTrnC3wN8f9eo/wQ8aVUDvEQAj4Hah/aR+YYJShoNaeN
         OUPvoaBWAvyYAfNiRLow0a7O8hkMhvMv9LxMWSejyNS9TaKErlWnsx8iM0Gkx8yiHfeM
         CmsZP7uyc+J2dOV1IgGaZe037AgPeFcRfv7DK6RXlqxxRr6LkUJUhpvJpWnFLmRXLOns
         LLzPRZ2Nv+m0+9g1myQO08N++fcsatQdVySzyc9JAUKVTHD+FFGP4QqHxT4vQtUT42Cv
         4jSwFa1V3MWaZ9r52iT8IEyF763zHbVI5ZHGGtKUYNWepRY5Wd3mV5y5f/3ziuGsRgzD
         yxCg==
X-Forwarded-Encrypted: i=1; AJvYcCUmQdBkZYQljdCOEMjrxn+EC0QLKHr5V+CzoQvJ3Ftx5ldEr45uohiHW2PAPw/wvyrNXM4=@vger.kernel.org, AJvYcCWDC/zg3xe2EpZwugtVHQ4hzZcM57b5P69AY8mJRcg456iy384eS0zPY8FmLxolE1a+BMMHzhV9YR7VhgH5@vger.kernel.org, AJvYcCWdEVRD8Q0x0j1QqnR4VL6LhuKgW09p0t5TRZZmuCQav0ACCcqs/z5A8S1vEdSC5XGeUR/AjsRRk7WJSGPILmMP/TjR@vger.kernel.org
X-Gm-Message-State: AOJu0YyQXCFdfRrXn647QWlk+kVL22p5kYn/nwXueJuOnm1fiFbJH06S
	HkCLNWJgkZ91AM6eclaAZHMAFCmelL3XKX3oQvrlTB/JvSSKIYoT
X-Google-Smtp-Source: AGHT+IHScn5eSmr6CSg99RKXGS5vqmTkYKp9jkZ1GtMKlD+JPiocBjIv4k8z1L7JwltrBMgrXt9OeA==
X-Received: by 2002:adf:fd0a:0:b0:37d:4f1b:359 with SMTP id ffacd0b85a97d-37d86d59ae3mr1892701f8f.53.1729060891702;
        Tue, 15 Oct 2024 23:41:31 -0700 (PDT)
Received: from krava ([213.0.100.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc419ffsm3448080f8f.111.2024.10.15.23.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 23:41:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 16 Oct 2024 08:41:28 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv6 perf/core 01/16] uprobe: Add data pointer to consumer
 handlers
Message-ID: <Zw9gGHzQNY9BLJCZ@krava>
References: <20241010200957.2750179-1-jolsa@kernel.org>
 <20241010200957.2750179-2-jolsa@kernel.org>
 <20241016072426.c6f7b9572b946dd31c0c1fb8@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016072426.c6f7b9572b946dd31c0c1fb8@kernel.org>

On Wed, Oct 16, 2024 at 07:24:26AM +0900, Masami Hiramatsu wrote:
> On Thu, 10 Oct 2024 22:09:42 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Adding data pointer to both entry and exit consumer handlers and all
> > its users. The functionality itself is coming in following change.
> > 
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Alexei, please merge this series via bpf tree, since most of the patches
> in this series are for bpf.


hi,
so the uprobe changes are based on Peter's perf/core and bpf changes
on bpf-next/master.. I merged them locally as a base for this patchset

Andrii has an idea how we could proceed with merging:

	> I think uprobe parts should stay in tip/perf/core (if that's where all
	> uprobe code goes in), as we have a bunch of ongoing work that all will
	> conflict a bit with each other, if it lands across multiple trees.
	>
	> So that means that patches #1 and #2 ideally land in tip/perf/core.
	> But you have a lot of BPF-specific things that would be inconvenient
	> to route through tip, so I'd say those should go through bpf-next.
	>
	> What we can do, if Ingo and Peter are OK with that, is to create a
	> stable (non-rebaseable) branch off of your first two patches (applied
	> in tip/perf/core), which we'll merge into bpf-next/master and land the
	> rest of your patch set there. We've done that with recent struct fd
	> changes, and there were few other similar cases in the past, and that
	> all worked well.
	>
	> Peter, Ingo, are you guys OK with that approach?

jirka

> 
> Thank you,
> 
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/uprobes.h                              |  4 ++--
> >  kernel/events/uprobes.c                              |  4 ++--
> >  kernel/trace/bpf_trace.c                             |  6 ++++--
> >  kernel/trace/trace_uprobe.c                          | 12 ++++++++----
> >  .../testing/selftests/bpf/bpf_testmod/bpf_testmod.c  |  2 +-
> >  5 files changed, 17 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index 2b294bf1881f..bb265a632b91 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -37,10 +37,10 @@ struct uprobe_consumer {
> >  	 * for the current process. If filter() is omitted or returns true,
> >  	 * UPROBE_HANDLER_REMOVE is effectively ignored.
> >  	 */
> > -	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
> > +	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data);
> >  	int (*ret_handler)(struct uprobe_consumer *self,
> >  				unsigned long func,
> > -				struct pt_regs *regs);
> > +				struct pt_regs *regs, __u64 *data);
> >  	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
> >  
> >  	struct list_head cons_node;
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 2a0059464383..6b44c386a5df 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2090,7 +2090,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> >  		int rc = 0;
> >  
> >  		if (uc->handler) {
> > -			rc = uc->handler(uc, regs);
> > +			rc = uc->handler(uc, regs, NULL);
> >  			WARN(rc & ~UPROBE_HANDLER_MASK,
> >  				"bad rc=0x%x from %ps()\n", rc, uc->handler);
> >  		}
> > @@ -2128,7 +2128,7 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
> >  	rcu_read_lock_trace();
> >  	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
> >  		if (uc->ret_handler)
> > -			uc->ret_handler(uc, ri->func, regs);
> > +			uc->ret_handler(uc, ri->func, regs, NULL);
> >  	}
> >  	rcu_read_unlock_trace();
> >  }
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index a582cd25ca87..fdab7ecd8dfa 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3244,7 +3244,8 @@ uprobe_multi_link_filter(struct uprobe_consumer *con, struct mm_struct *mm)
> >  }
> >  
> >  static int
> > -uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
> > +uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
> > +			  __u64 *data)
> >  {
> >  	struct bpf_uprobe *uprobe;
> >  
> > @@ -3253,7 +3254,8 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
> >  }
> >  
> >  static int
> > -uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs)
> > +uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs,
> > +			      __u64 *data)
> >  {
> >  	struct bpf_uprobe *uprobe;
> >  
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index c40531d2cbad..5895eabe3581 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -89,9 +89,11 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
> >  static int register_uprobe_event(struct trace_uprobe *tu);
> >  static int unregister_uprobe_event(struct trace_uprobe *tu);
> >  
> > -static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
> > +static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
> > +			     __u64 *data);
> >  static int uretprobe_dispatcher(struct uprobe_consumer *con,
> > -				unsigned long func, struct pt_regs *regs);
> > +				unsigned long func, struct pt_regs *regs,
> > +				__u64 *data);
> >  
> >  #ifdef CONFIG_STACK_GROWSUP
> >  static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
> > @@ -1517,7 +1519,8 @@ trace_uprobe_register(struct trace_event_call *event, enum trace_reg type,
> >  	}
> >  }
> >  
> > -static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
> > +static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
> > +			     __u64 *data)
> >  {
> >  	struct trace_uprobe *tu;
> >  	struct uprobe_dispatch_data udd;
> > @@ -1548,7 +1551,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
> >  }
> >  
> >  static int uretprobe_dispatcher(struct uprobe_consumer *con,
> > -				unsigned long func, struct pt_regs *regs)
> > +				unsigned long func, struct pt_regs *regs,
> > +				__u64 *data)
> >  {
> >  	struct trace_uprobe *tu;
> >  	struct uprobe_dispatch_data udd;
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > index 8835761d9a12..12005e3dc3e4 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -461,7 +461,7 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
> >  
> >  static int
> >  uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
> > -		   struct pt_regs *regs)
> > +		   struct pt_regs *regs, __u64 *data)
> >  
> >  {
> >  	regs->ax  = 0x12345678deadbeef;
> > -- 
> > 2.46.2
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

