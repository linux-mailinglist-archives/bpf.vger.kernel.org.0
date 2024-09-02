Return-Path: <bpf+bounces-38698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFC09682CD
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 11:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C771C22717
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB10187335;
	Mon,  2 Sep 2024 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wgsqm2ip"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10A7186287;
	Mon,  2 Sep 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268302; cv=none; b=ci0/jexl4za4/xP8G+fy1fuJdYGc/qPQr/ZbVjzDOrCBVNe3WtJNpwYQIs1h8EaaBE+V0iWUGnp2G1G2kBtYMYsfC9UxL7YrrodjwdEOF1NNEW7dQUSi+zUO21A9BvZNSaGBQ9asuCEiwA2EEp98f8fEvq0e/r/pVD/7ZED1mCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268302; c=relaxed/simple;
	bh=Ze5XgkMUSpr8SCNL10HvJp4M0g7KOfF9oueeg28V9ko=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLoZK81ncnVIeLJHS9Qo+0bxeqsGYnlzwj7PgN3WYG/MPjE4HmV8fO0wr4x0tBKAkjXDXF7FA0bTYuhXTFad5/l+Ryk0bFqces7GAapqi8PeRz3heMzuW5VSSO3UAYVXZkQdaTqrN1juhPRRB8kvqEqR3f7Q28r3BI04tQy8wnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wgsqm2ip; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bb9d719d4so27697035e9.3;
        Mon, 02 Sep 2024 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725268299; x=1725873099; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w866Zb3XiSYwaoQyh8s0RANWJJh1KBMZkoTV9yM5crk=;
        b=Wgsqm2ipi0dXyauhD03jKPzSoSBVO6dYbI+Ad0JMSbrQkK7pkpDx75DKATwNn1QZCP
         XmA2M+OSgWA+lJIMfcvorrqShgwjF3cnUKg+S15UoAYIEyabdX9cdX1axmABTKIZdx/1
         GjecZaNiEuxUHqYV7rHuqoIKkvbfZXZYk3p6yfcUfwM324BcbamCSCcemd16EPl9+Fl3
         bWzcZPsAKHtWnJN9c2vIUelbO9DKHD9y10TO94y16g1W6TE9otBggVgTiwl3XRlUrk0+
         PyXuwcdMqpetcCfduvi/ogF4otAN3zUvpiAS7tgf891o7GCelGxsT4bIfvwnQJkxPdrD
         UKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725268299; x=1725873099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w866Zb3XiSYwaoQyh8s0RANWJJh1KBMZkoTV9yM5crk=;
        b=cMCplp+tf3pFEI3IUcaLXapR//P2sjm6/aTiAdZri9+czYrfd1MqF/2GkU9swieEGK
         JdEbklNKC5Ya4ED/CVlT8rwXqsYgvGEl+eG33hw1WQUDXaTXQTPXQkV/MrlWgC3WdYvt
         9uUVIRTKsDHzepmfcl8Gj7sBI4l/oRgg+ik3gp2b/8/j7qf+bsBQIQ+zG2cNrSEAvIFm
         TO1K23OjKGlgLro4GK6mtAT9o4abjYX2ov1SBWBjl/iju7Ugwhw18qrjkAVrM7G3zjx/
         Yk7iMnazkc8/vyQphUsUrVhhxGvfYy975ij+ln7JA1Z5WsRSKoJyQ/CXNlNJTutg3Jpp
         btfg==
X-Forwarded-Encrypted: i=1; AJvYcCVCCkS5jLHE7es+p+jbWD8bQnUo/EV9/WM6FLyfV9Szt/KCnitMXl2APHOSqta8Jjc7klk=@vger.kernel.org, AJvYcCXVuhaV/J9EayzbLqf/Njp9WeQJInd4dlyN9BGDMA4GOu+uUVIXw2RWk6yWBP4gDmCtWXdhaK0mcJnRo+IVNH3PKdfe@vger.kernel.org
X-Gm-Message-State: AOJu0YySiLq607eMXmK8bQG2277A3V/EfXb26ElZnkD6dg1NssA+WRGQ
	8v9+Xt1T8/+AY1tpDLh3Q46o0h66dMhXPddQbKVTBi86HSeFZI2uMgD+OHnV9+c=
X-Google-Smtp-Source: AGHT+IEjipaqKXixmWQPn7Ax5wPPsCL88WkGlwpctr8endQwXziWeM6jD8pcq/xkQ28hb+7/WHn/mg==
X-Received: by 2002:a05:600c:3b8e:b0:42b:a9d7:93 with SMTP id 5b1f17b1804b1-42bb032c82cmr107500965e9.28.1725268298698;
        Mon, 02 Sep 2024 02:11:38 -0700 (PDT)
Received: from krava ([87.202.122.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c7f172be3sm47182615e9.36.2024.09.02.02.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:11:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 2 Sep 2024 12:11:34 +0300
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Tianyi Liu <i.pear@outlook.com>, Jordan Rome <linux@jordanrome.com>,
	ajor@meta.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, flaniel@linux.microsoft.com,
	albancrequy@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <ZtWBRgM3TyhdiwKw@krava>
References: <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240830101209.GA24733@redhat.com>
 <ZtHKTtn7sqaLeVxV@krava>
 <CAEf4BzZPGxuV38Kz3R387tANP3tLF7j9GLRd6tOYtaEWT9uqCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZPGxuV38Kz3R387tANP3tLF7j9GLRd6tOYtaEWT9uqCw@mail.gmail.com>

On Fri, Aug 30, 2024 at 08:51:12AM -0700, Andrii Nakryiko wrote:
> On Fri, Aug 30, 2024 at 6:34 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, Aug 30, 2024 at 12:12:09PM +0200, Oleg Nesterov wrote:
> > > The whole discussion was very confusing (yes, I too contributed to the
> > > confusion ;), let me try to summarise.
> > >
> > > > U(ret)probes are designed to be filterable using the PID, which is the
> > > > second parameter in the perf_event_open syscall. Currently, uprobe works
> > > > well with the filtering, but uretprobe is not affected by it.
> > >
> > > And this is correct. But the CONFIG_BPF_EVENTS code in __uprobe_perf_func()
> > > misunderstands the purpose of uprobe_perf_filter().
> > >
> > > Lets forget about BPF for the moment. It is not that uprobe_perf_filter()
> > > does the filtering by the PID, it doesn't. We can simply kill this function
> > > and perf will work correctly. The perf layer in __uprobe_perf_func() does
> > > the filtering when perf_event->hw.target != NULL.
> > >
> > > So why does uprobe_perf_filter() call uprobe_perf_filter()? Not to avoid
> > > the __uprobe_perf_func() call (as the BPF code assumes), but to trigger
> > > unapply_uprobe() in handler_chain().
> > >
> > > Suppose you do, say,
> > >
> > >       $ perf probe -x /path/to/libc some_hot_function
> > > or
> > >       $ perf probe -x /path/to/libc some_hot_function%return
> > > then
> > >       $perf record -e ... -p 1
> > >
> > > to trace the usage of some_hot_function() in the init process. Everything
> > > will work just fine if we kill uprobe_perf_filter()->uprobe_perf_filter().
> > >
> > > But. If INIT forks a child C, dup_mm() will copy int3 installed by perf.
> > > So the child C will hit this breakpoint and cal handle_swbp/etc for no
> > > reason every time it calls some_hot_function(), not good.
> > >
> > > That is why uprobe_perf_func() calls uprobe_perf_filter() which returns
> > > UPROBE_HANDLER_REMOVE when C hits the breakpoint. handler_chain() will
> > > call unapply_uprobe() which will remove this breakpoint from C->mm.
> >
> > thanks for the info, I wasn't aware this was the intention
> >
> > uprobe_multi does not have perf event mechanism/check, so it's using
> > the filter function to do the process filtering.. which is not working
> > properly as you pointed out earlier
> 
> So this part I don't completely get. I get that using task->mm
> comparison is wrong due to CLONE_VM, but why same_thread_group() check
> is wrong? I.e., why task->signal comparison is wrong?

the way I understand it is that we take the group leader task and
store it in bpf_uprobe_multi_link::task

but it can exit while the rest of the threads is still running so
the uprobe_multi_link_filter won't match them (leader->mm is NULL)

Oleg suggested change below (in addition to same_thread_group change)
to take that in account

jirka


---
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 98e395f1baae..9e6b390aa6da 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3235,9 +3235,23 @@ uprobe_multi_link_filter(struct uprobe_consumer *con, enum uprobe_filter_ctx ctx
 			 struct mm_struct *mm)
 {
 	struct bpf_uprobe *uprobe;
+	struct task_struct *task, *t;
+	bool ret = false;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	return uprobe->link->task->mm == mm;
+	task = uprobe->link->task;
+
+	rcu_read_lock();
+	for_each_thread(task, t) {
+		struct mm_struct *mm = READ_ONCE(t->mm);
+		if (mm) {
+			ret = t->mm == mm;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
 }
 
 static int

