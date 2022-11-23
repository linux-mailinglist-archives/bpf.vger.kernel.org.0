Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8754B634E3D
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 04:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiKWDRs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 22:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiKWDRl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 22:17:41 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859A32D4;
        Tue, 22 Nov 2022 19:17:36 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NH5rp4Wv5zHw4g;
        Wed, 23 Nov 2022 11:16:58 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 11:17:35 +0800
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 11:17:34 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <mhiramat@kernel.org>, <yujie.liu@intel.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rostedt@goodmis.org>, <zhengyejian1@huawei.com>
Subject: Re: [PATCH v2] tracing: Optimize event type allocation with IDA
Date:   Wed, 23 Nov 2022 11:18:06 +0800
Message-ID: <20221123031806.735511-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111234137.90d9ec624497a7e1f5cb5003@kernel.org>
References: <20221111234137.90d9ec624497a7e1f5cb5003@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 11 Nov 2022 23:41:37 +0900,
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> On Thu, 10 Nov 2022 10:03:19 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
>
> > After commit 060fa5c83e67 ("tracing/events: reuse trace event ids after
> >  overflow"), trace events with dynamic type are linked up in list
> > 'ftrace_event_list' through field 'trace_event.list'. Then when max
> > event type number used up, it's possible to reuse type number of some
> > freed one by traversing 'ftrace_event_list'.
> >
> > As instead, using IDA to manage available type numbers can make codes
> > simpler and then the field 'trace_event.list' can be dropped.
> >
> > Since 'struct trace_event' is used in static tracepoints, drop
> > 'trace_event.list' can make vmlinux smaller. Local test with about 2000
> > tracepoints, vmlinux reduced about 64KB:
> >   before：-rwxrwxr-x 1 root root 76669448 Nov  8 17:14 vmlinux
> >   after： -rwxrwxr-x 1 root root 76604176 Nov  8 17:15 vmlinux
> >
>
> This looks good to me.
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks for your kind ack, Masami!

But Yujie Liu <yujie.liu@intel.com> reported a problem that highly
reproducible after applying this patch:
Link: https://lore.kernel.org/lkml/54f23c9c-97ae-e326-5873-bfa5d2c81f52@intel.com/

So please DO NOT apply this patch before I find what happened about it.

--
Best regards,
Zheng Yejian

>
> Thanks
>
> > Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> > ---
> >  include/linux/trace_events.h |  1 -
> >  kernel/trace/trace_output.c  | 66 +++++++++---------------------------
> >  2 files changed, 16 insertions(+), 51 deletions(-)
> >
> > Changes since v1:
> >   - Explicitly include linux/idr.h as suggested by Masami Hiramatsu
> >     Link: https://lore.kernel.org/lkml/20221109222650.ce6c22e231345f6852f6956f@kernel.org/#t
> >
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index 20749bd9db71..bb2053246d6a 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -136,7 +136,6 @@ struct trace_event_functions {
> >
> >  struct trace_event {
> >	struct hlist_node		node;
> > -	struct list_head		list;
> >	int				type;
> >	struct trace_event_functions	*funcs;
> >  };
> > diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> > index 67f47ea27921..f0ba97121345 100644
> > --- a/kernel/trace/trace_output.c
> > +++ b/kernel/trace/trace_output.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/kprobes.h>
> >  #include <linux/sched/clock.h>
> >  #include <linux/sched/mm.h>
> > +#include <linux/idr.h>
> >
> >  #include "trace_output.h"
> >
> > @@ -21,8 +22,6 @@ DECLARE_RWSEM(trace_event_sem);
> >
> >  static struct hlist_head event_hash[EVENT_HASHSIZE] __read_mostly;
> >
> > -static int next_event_type = __TRACE_LAST_TYPE;
> > -
> >  enum print_line_t trace_print_bputs_msg_only(struct trace_iterator *iter)
> >  {
> >	struct trace_seq *s = &iter->seq;
> > @@ -688,38 +687,23 @@ struct trace_event *ftrace_find_event(int type)
> >	return NULL;
> >  }
> >
> > -static LIST_HEAD(ftrace_event_list);
> > +static DEFINE_IDA(trace_event_ida);
> >
> > -static int trace_search_list(struct list_head **list)
> > +static void free_trace_event_type(int type)
> >  {
> > -	struct trace_event *e = NULL, *iter;
> > -	int next = __TRACE_LAST_TYPE;
> > -
> > -	if (list_empty(&ftrace_event_list)) {
> > -		*list = &ftrace_event_list;
> > -		return next;
> > -	}
> > +	if (type >= __TRACE_LAST_TYPE)
> > +		ida_free(&trace_event_ida, type);
> > +}
> >
> > -	/*
> > -	 * We used up all possible max events,
> > -	 * lets see if somebody freed one.
> > -	 */
> > -	list_for_each_entry(iter, &ftrace_event_list, list) {
> > -		if (iter->type != next) {
> > -			e = iter;
> > -			break;
> > -		}
> > -		next++;
> > -	}
> > +static int alloc_trace_event_type(void)
> > +{
> > +	int next;
> >
> > -	/* Did we used up all 65 thousand events??? */
> > -	if (next > TRACE_EVENT_TYPE_MAX)
> > +	/* Skip static defined type numbers */
> > +	next = ida_alloc_range(&trace_event_ida, __TRACE_LAST_TYPE,
> > +			       TRACE_EVENT_TYPE_MAX, GFP_KERNEL);
> > +	if (next < 0)
> >		return 0;
> > -
> > -	if (e)
> > -		*list = &e->list;
> > -	else
> > -		*list = &ftrace_event_list;
> >	return next;
> >  }
> >
> > @@ -761,28 +745,10 @@ int register_trace_event(struct trace_event *event)
> >	if (WARN_ON(!event->funcs))
> >		goto out;
> >
> > -	INIT_LIST_HEAD(&event->list);
> > -
> >	if (!event->type) {
> > -		struct list_head *list = NULL;
> > -
> > -		if (next_event_type > TRACE_EVENT_TYPE_MAX) {
> > -
> > -			event->type = trace_search_list(&list);
> > -			if (!event->type)
> > -				goto out;
> > -
> > -		} else {
> > -
> > -			event->type = next_event_type++;
> > -			list = &ftrace_event_list;
> > -		}
> > -
> > -		if (WARN_ON(ftrace_find_event(event->type)))
> > +		event->type = alloc_trace_event_type();
> > +		if (!event->type)
> >			goto out;
> > -
> > -		list_add_tail(&event->list, list);
> > -
> >	} else if (WARN(event->type > __TRACE_LAST_TYPE,
> >			"Need to add type to trace.h")) {
> >		goto out;
> > @@ -819,7 +785,7 @@ EXPORT_SYMBOL_GPL(register_trace_event);
> >  int __unregister_trace_event(struct trace_event *event)
> >  {
> >	hlist_del(&event->node);
> > -	list_del(&event->list);
> > +	free_trace_event_type(event->type);
> >	return 0;
> >  }
> >
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
