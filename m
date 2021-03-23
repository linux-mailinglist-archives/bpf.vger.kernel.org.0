Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2EC346A95
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 22:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhCWVAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 17:00:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233466AbhCWU74 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Mar 2021 16:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616533196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nEJEAGnBDrkMwTac8x1suOx88OEJOU7HbYOYLwosHvY=;
        b=LuYrEdP26loRRr5HeFSuB+Hd2f0DM8t+CggHgGpkQOebVzTMVr06W25h6PH89qjYcd5pJA
        3j/8TrWTtru5CykfE+Oeiq+ywpkR+NewRQZDSOfnTe6cCRorVkZg2nQ6vnsifjS5oBlDhZ
        pweRVonhtvJD5yR4Ko7ZsrWoZ4yjpfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-00Yh_wfXMpa44y5FFklzFA-1; Tue, 23 Mar 2021 16:59:51 -0400
X-MC-Unique: 00Yh_wfXMpa44y5FFklzFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 027AD100746C;
        Tue, 23 Mar 2021 20:59:50 +0000 (UTC)
Received: from krava (unknown [10.40.192.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id A39DD5C1CF;
        Tue, 23 Mar 2021 20:59:47 +0000 (UTC)
Date:   Tue, 23 Mar 2021 21:59:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        paulmck@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf] bpf: Fix fexit trampoline.
Message-ID: <YFpWwpeQBUjCMhqJ@krava>
References: <20210316210007.38949-1-alexei.starovoitov@gmail.com>
 <YFfXcqnksPsSe0Bv@krava>
 <YFjEt42mrWejbzgJ@krava>
 <YFjnlqeqbkST7oPb@krava>
 <20210323085900.3bdc0002@gandalf.local.home>
 <6d8ad633-b464-0a72-a310-2dda27dfeb99@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d8ad633-b464-0a72-a310-2dda27dfeb99@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 23, 2021 at 07:50:55AM -0700, Alexei Starovoitov wrote:
> On 3/23/21 5:59 AM, Steven Rostedt wrote:
> > On Mon, 22 Mar 2021 19:53:10 +0100
> > Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > > On Mon, Mar 22, 2021 at 05:24:26PM +0100, Jiri Olsa wrote:
> > > > On Mon, Mar 22, 2021 at 12:32:05AM +0100, Jiri Olsa wrote:
> > > > > On Tue, Mar 16, 2021 at 02:00:07PM -0700, Alexei Starovoitov wrote:
> > > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > > > 
> > > > > > The fexit/fmod_ret programs can be attached to kernel functions that can sleep.
> > > > > > The synchronize_rcu_tasks() will not wait for such tasks to complete.
> > > > > > In such case the trampoline image will be freed and when the task
> > > > > > wakes up the return IP will point to freed memory causing the crash.
> > > > > > Solve this by adding percpu_ref_get/put for the duration of trampoline
> > > > > > and separate trampoline vs its image life times.
> > > > > > The "half page" optimization has to be removed, since
> > > > > > first_half->second_half->first_half transition cannot be guaranteed to
> > > > > > complete in deterministic time. Every trampoline update becomes a new image.
> > > > > > The image with fmod_ret or fexit progs will be freed via percpu_ref_kill and
> > > > > > call_rcu_tasks. Together they will wait for the original function and
> > > > > > trampoline asm to complete. The trampoline is patched from nop to jmp to skip
> > > > > > fexit progs. They are freed independently from the trampoline. The image with
> > > > > > fentry progs only will be freed via call_rcu_tasks_trace+call_rcu_tasks which
> > > > > > will wait for both sleepable and non-sleepable progs to complete.
> > > > > > 
> > > > > > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > > Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
> > > > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > > > Acked-by: Paul E. McKenney <paulmck@kernel.org>  # for RCU
> > > > > > ---
> > > > > > Without ftrace fix:
> > > > > > https://patchwork.kernel.org/project/netdevbpf/patch/20210316195815.34714-1-alexei.starovoitov@gmail.com/
> > > > > > this patch will trigger warn in ftrace.
> > > > > > 
> > > > > >   arch/x86/net/bpf_jit_comp.c |  26 ++++-
> > > > > >   include/linux/bpf.h         |  24 +++-
> > > > > >   kernel/bpf/bpf_struct_ops.c |   2 +-
> > > > > >   kernel/bpf/core.c           |   4 +-
> > > > > >   kernel/bpf/trampoline.c     | 218 +++++++++++++++++++++++++++---------
> > > > > >   5 files changed, 213 insertions(+), 61 deletions(-)
> > > > > 
> > > > > hi,
> > > > > I'm on bpf/master and I'm triggering warnings below when running together:
> > > > > 
> > > > >    # while :; do ./test_progs -t fentry_test ; done
> > > > >    # while :; do ./test_progs -t module_attach ; done
> > > > 
> > > > hum, is it possible that we don't take module ref and it can get
> > > > unloaded even if there's trampoline attach to it..? I can't see
> > > > that in the code.. ftrace_release_mod can't fail ;-)
> > > 
> > > when I get the module for each module trampoline,
> > > I can no longer see those warnings (link for Steven):
> > >    https://lore.kernel.org/bpf/YFfXcqnksPsSe0Bv@krava/
> > > 
> > > Steven,
> > > I might be missing something, but it looks like module
> > > can be unloaded even if the trampoline (direct function)
> > > is registered in it.. is that right?
> > > 
> > 
> > Not with your patch below ;-)
> > 
> > But yes, ftrace does not currently manage module text for direct calls,
> > it's assumed that whoever attaches to the module text would do that. But
> > I'm not adverse to the patch below.
> 
> Jiri,
> 
> could you please refactor your patch to do the same in bpf trampoline?

right, we need to take care about bpf_arch_text_poke
interface as well.. I'll resend

> The selftest/bpf would be great as well. It can come as a follow up.
> Let's fix the issue for bpf tree first.

ok, will send test later

jirka

