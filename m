Return-Path: <bpf+bounces-820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D156D70723E
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 21:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B001C20DF4
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B0A34CEE;
	Wed, 17 May 2023 19:36:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C0111AD
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 19:36:15 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABC99109;
	Wed, 17 May 2023 12:36:13 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id EA0EE20F26AB;
	Wed, 17 May 2023 12:36:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA0EE20F26AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1684352173;
	bh=kOczaw1TlAZYv+vsEch6YqBha9eh9KoqTxDoaMXzpow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8WrzbOo/RSmXAZ7HQMSpMgjIuPWUIYbH1jZWa4bcrvm7nP6GxHL5qyXaW1CidIUH
	 7jr6Nv19tpmoP6j3q/D6ZsDUCoM9CyI+fTIIMeKKz1BgMNdMT4Wd78WBrxTwr3DWID
	 k1HRFJ9da2FNue7CRgxI/EJ+8isbaJ1/y6XPeWRU=
Date: Wed, 17 May 2023 12:36:02 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>, dthaler@microsoft.com,
	brauner@kernel.org, hch@infradead.org
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230517193549.GA401@W11-BEAU-MD.localdomain>
References: <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home>
 <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain>
 <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain>
 <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 12:26:44PM -0700, Linus Torvalds wrote:
> On Wed, May 17, 2023 at 12:08 PM Beau Belgrave
> <beaub@linux.microsoft.com> wrote:
> >
> > user_event_mm_dup() puts a new mm into the global list before the
> > enablers list is fully populated.
> 
> Then that simply needs to be fixed.
> 

Agreed.

> user_event_mm_dup() should not madd the mm into the global list until
> it is *done*.
> 
> Because if it makes that list visible to others in a half-way state,
> then it needs to use the proper locking and use event_mutex.
> 
> You can't say "this is so critical that we can't take a lock" and then
> use that as an excuse to simply do buggy code.
> 

Didn't mean that, I just have more work to do then just the RCU walks.
I will fix these up.

> Either take the lock in user_event_mm_dup(), or make sure that the
> data structures are all completely local so that no lock is necessary.
> 
> Here's a COMPLETELY UNTESTED patch that just separates out the notion
> of "allocate" and "attach".
> 
> NOTE NOTE NOTE! I am *not* claiming this patch works. It builds for
> me. It looks right. It seems like it's the right thing to do. But it
> might have some issues.
> 
> With this, the newly dup'ed list is attached to the process once after
> it is done, so nobody can see the list being built up.
> 
> Also note that this does NOT fix the incorrect RCU walks.
> 
>            Linus

Thanks for the patch and feedback!

-Beau

>  kernel/trace/trace_events_user.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index b1ecd7677642..b2aecbfbbd24 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -538,10 +538,9 @@ static struct user_event_mm *user_event_mm_get_all(struct user_event *user)
>  	return found;
>  }
>  
> -static struct user_event_mm *user_event_mm_create(struct task_struct *t)
> +static struct user_event_mm *user_event_mm_alloc(struct task_struct *t)
>  {
>  	struct user_event_mm *user_mm;
> -	unsigned long flags;
>  
>  	user_mm = kzalloc(sizeof(*user_mm), GFP_KERNEL_ACCOUNT);
>  
> @@ -553,12 +552,6 @@ static struct user_event_mm *user_event_mm_create(struct task_struct *t)
>  	refcount_set(&user_mm->refcnt, 1);
>  	refcount_set(&user_mm->tasks, 1);
>  
> -	spin_lock_irqsave(&user_event_mms_lock, flags);
> -	list_add_rcu(&user_mm->link, &user_event_mms);
> -	spin_unlock_irqrestore(&user_event_mms_lock, flags);
> -
> -	t->user_event_mm = user_mm;
> -
>  	/*
>  	 * The lifetime of the memory descriptor can slightly outlast
>  	 * the task lifetime if a ref to the user_event_mm is taken
> @@ -572,6 +565,17 @@ static struct user_event_mm *user_event_mm_create(struct task_struct *t)
>  	return user_mm;
>  }
>  
> +static void user_event_mm_attach(struct user_event_mm *user_mm, struct task_struct *t)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&user_event_mms_lock, flags);
> +	list_add_rcu(&user_mm->link, &user_event_mms);
> +	spin_unlock_irqrestore(&user_event_mms_lock, flags);
> +
> +	t->user_event_mm = user_mm;
> +}
> +
>  static struct user_event_mm *current_user_event_mm(void)
>  {
>  	struct user_event_mm *user_mm = current->user_event_mm;
> @@ -579,10 +583,12 @@ static struct user_event_mm *current_user_event_mm(void)
>  	if (user_mm)
>  		goto inc;
>  
> -	user_mm = user_event_mm_create(current);
> +	user_mm = user_event_mm_alloc(current);
>  
>  	if (!user_mm)
>  		goto error;
> +
> +	user_event_mm_attach(user_mm, current);
>  inc:
>  	refcount_inc(&user_mm->refcnt);
>  error:
> @@ -670,7 +676,7 @@ void user_event_mm_remove(struct task_struct *t)
>  
>  void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
>  {
> -	struct user_event_mm *mm = user_event_mm_create(t);
> +	struct user_event_mm *mm = user_event_mm_alloc(t);
>  	struct user_event_enabler *enabler;
>  
>  	if (!mm)
> @@ -684,10 +690,11 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
>  
>  	rcu_read_unlock();
>  
> +	user_event_mm_attach(mm, t);
>  	return;
>  error:
>  	rcu_read_unlock();
> -	user_event_mm_remove(t);
> +	user_event_mm_destroy(mm);
>  }
>  
>  static bool current_user_event_enabler_exists(unsigned long uaddr,


