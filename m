Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6067344F24
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 19:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhCVSxe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 14:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232156AbhCVSxU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Mar 2021 14:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616439199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1EFF4wk6eea8kbJqsrOlXZnpCqubbggc+mAfB6S4ie8=;
        b=F09mB3zRB5w1Vw8WOSk4mrp8UkQy1qNEEw0x3Jf1Z90gZW/kOr5cTOw5PuYXXxvGsSNxmq
        paTs2LGjSMCepkmRMINR8QByiJbkL73RpLPL9xq0BfZpXQmaU+SE6yZj86RbqpirJUSNji
        CFVj74DG/10PDvX1yft+d4jAq98awcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-FFSoDa48OYSjW4zQG30yFg-1; Mon, 22 Mar 2021 14:53:15 -0400
X-MC-Unique: FFSoDa48OYSjW4zQG30yFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE55C180FCA4;
        Mon, 22 Mar 2021 18:53:13 +0000 (UTC)
Received: from krava (unknown [10.40.195.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id E01D95D9F0;
        Mon, 22 Mar 2021 18:53:11 +0000 (UTC)
Date:   Mon, 22 Mar 2021 19:53:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        paulmck@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf] bpf: Fix fexit trampoline.
Message-ID: <YFjnlqeqbkST7oPb@krava>
References: <20210316210007.38949-1-alexei.starovoitov@gmail.com>
 <YFfXcqnksPsSe0Bv@krava>
 <YFjEt42mrWejbzgJ@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFjEt42mrWejbzgJ@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 22, 2021 at 05:24:26PM +0100, Jiri Olsa wrote:
> On Mon, Mar 22, 2021 at 12:32:05AM +0100, Jiri Olsa wrote:
> > On Tue, Mar 16, 2021 at 02:00:07PM -0700, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > > 
> > > The fexit/fmod_ret programs can be attached to kernel functions that can sleep.
> > > The synchronize_rcu_tasks() will not wait for such tasks to complete.
> > > In such case the trampoline image will be freed and when the task
> > > wakes up the return IP will point to freed memory causing the crash.
> > > Solve this by adding percpu_ref_get/put for the duration of trampoline
> > > and separate trampoline vs its image life times.
> > > The "half page" optimization has to be removed, since
> > > first_half->second_half->first_half transition cannot be guaranteed to
> > > complete in deterministic time. Every trampoline update becomes a new image.
> > > The image with fmod_ret or fexit progs will be freed via percpu_ref_kill and
> > > call_rcu_tasks. Together they will wait for the original function and
> > > trampoline asm to complete. The trampoline is patched from nop to jmp to skip
> > > fexit progs. They are freed independently from the trampoline. The image with
> > > fentry progs only will be freed via call_rcu_tasks_trace+call_rcu_tasks which
> > > will wait for both sleepable and non-sleepable progs to complete.
> > > 
> > > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > > Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > Acked-by: Paul E. McKenney <paulmck@kernel.org>  # for RCU
> > > ---
> > > Without ftrace fix:
> > > https://patchwork.kernel.org/project/netdevbpf/patch/20210316195815.34714-1-alexei.starovoitov@gmail.com/
> > > this patch will trigger warn in ftrace.
> > > 
> > >  arch/x86/net/bpf_jit_comp.c |  26 ++++-
> > >  include/linux/bpf.h         |  24 +++-
> > >  kernel/bpf/bpf_struct_ops.c |   2 +-
> > >  kernel/bpf/core.c           |   4 +-
> > >  kernel/bpf/trampoline.c     | 218 +++++++++++++++++++++++++++---------
> > >  5 files changed, 213 insertions(+), 61 deletions(-)
> > > 
> > 
> > hi,
> > I'm on bpf/master and I'm triggering warnings below when running together:
> > 
> >   # while :; do ./test_progs -t fentry_test ; done
> >   # while :; do ./test_progs -t module_attach ; done
> 
> hum, is it possible that we don't take module ref and it can get
> unloaded even if there's trampoline attach to it..? I can't see
> that in the code.. ftrace_release_mod can't fail ;-)

when I get the module for each module trampoline,
I can no longer see those warnings (link for Steven):
  https://lore.kernel.org/bpf/YFfXcqnksPsSe0Bv@krava/

Steven,
I might be missing something, but it looks like module
can be unloaded even if the trampoline (direct function)
is registered in it.. is that right?

thanks,
jirka


---
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b7e29db127fa..ab0b2c8df283 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5059,6 +5059,28 @@ static struct ftrace_direct_func *ftrace_alloc_direct_func(unsigned long addr)
 	return direct;
 }
 
+static struct module *ftrace_direct_module_get(unsigned long ip)
+{
+	struct module *mod;
+	int err = 0;
+
+	preempt_disable();
+	mod = __module_text_address(ip);
+	if (mod && !try_module_get(mod))
+		err = -ENOENT;
+	preempt_enable();
+	return err ? ERR_PTR(err) : mod;
+}
+
+static void ftrace_direct_module_put(unsigned long ip)
+{
+	struct module *mod;
+
+	mod = __module_text_address(ip);
+	if (mod)
+		module_put(mod);
+}
+
 /**
  * register_ftrace_direct - Call a custom trampoline directly
  * @ip: The address of the nop at the beginning of a function
@@ -5081,6 +5103,7 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 	struct ftrace_direct_func *direct;
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *free_hash = NULL;
+	struct module *mod = NULL;
 	struct dyn_ftrace *rec;
 	int ret = -EBUSY;
 
@@ -5095,6 +5118,13 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 	if (!rec)
 		goto out_unlock;
 
+	mod = ftrace_direct_module_get(ip);
+	if (IS_ERR(mod)) {
+		ret = -ENOENT;
+		mod = NULL;
+		goto out_unlock;
+	}
+
 	/*
 	 * Check if the rec says it has a direct call but we didn't
 	 * find one earlier?
@@ -5172,6 +5202,8 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
  out_unlock:
 	mutex_unlock(&direct_mutex);
 
+	if (ret)
+		module_put(mod);
 	if (free_hash) {
 		synchronize_rcu_tasks();
 		free_ftrace_hash(free_hash);
@@ -5242,6 +5274,8 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 			ftrace_direct_func_count--;
 		}
 	}
+	ftrace_direct_module_put(ip);
+
  out_unlock:
 	mutex_unlock(&direct_mutex);
 

