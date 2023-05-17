Return-Path: <bpf+bounces-817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86880707180
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 21:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2251C20F42
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5131F10;
	Wed, 17 May 2023 19:08:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B7111AD
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 19:08:00 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27D581FF7;
	Wed, 17 May 2023 12:07:59 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B6D020F26B9;
	Wed, 17 May 2023 12:07:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B6D020F26B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1684350478;
	bh=WaJOQ9NdVPK9G+noT++BF6bTs8xagsFisu0TbP9AX+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P2N7DiAKSItQlAiFfJ6er1Fdeu4g8LFOpR8t6qy3tKt6i/MJFzpz9hK43iwK1dmep
	 HJl1XgRo0gzKCkRmE5CWXKebVIzpxrPl13LQo1A9jjC/JSdnploZXdsf2jyTY1vZFA
	 COUujXfzx+dAz3IVIHL+m91v0Azjs/ZYBbZVkA+o=
Date: Wed, 17 May 2023 12:07:50 -0700
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
Message-ID: <20230517190750.GA366@W11-BEAU-MD.localdomain>
References: <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home>
 <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain>
 <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 11:15:14AM -0700, Linus Torvalds wrote:
> On Wed, May 17, 2023 at 10:22 AM Beau Belgrave
> <beaub@linux.microsoft.com> wrote:
> >
> > On Tue, May 16, 2023 at 08:03:09PM -0700, Linus Torvalds wrote:
> > > So what is it that could even race and change the list that is the
> > > cause of that rcu-ness?
> >
> > Processes that fork() with previous user_events need to be duplicated.
> 
> BS.
> 
> Really. Stop making stuff up.
> 
> The above statement is clearly not true - just LOOK AT THE CODE.
> 

user_event_mm_dup() puts a new mm into the global list before the
enablers list is fully populated. As it stands now, since it's in the
global list, it can get enumerated in a small timing window via the
tracing subsystem register callbacks when someone enables the event via
ftrace/perf.

> Here's the loop in question:
> 
>                 list_for_each_entry_rcu(enabler, &mm->enablers, link) {
>                         if (enabler->event == user) {
>                                 attempt = 0;
>                                 user_event_enabler_write(mm, enabler,
> true, &attempt);
>                         }
>                 }
> 
> and AT THE VERY TOP OF user_event_enabler_write() we have this:
> 
>         lockdep_assert_held(&event_mutex);
> 
> so either nobody has ever tested this code with lockdep enabled, or we
> hold that lock.
> 
> And if nobody has ever tested the code, then it's broken anyway. That
> code N#EEDS the mutex lock. It needs to stop thinking it's RCU-safe,
> when it clearly isn't.
> 
> So I ask again: why is that code using RCU list traversal, when it
> already holds the lock that makes the RCU'ness COMPLETELY POINTLESS.
> 
> And again, that pointless RCU locking around this all seems to be the
> *only* reason for all these issues with pin_user_pages_remote().
> 
> So I claim that this code is garbage.  Somebody didn't think about locking.
> 
> Now, it's true that during fork, we have *another* RCU loop, but that
> one is harmless: that's not the one that does all this page pinning.
> 
> Now, that one *does* do
> 
>         list_add_rcu(&enabler->link, &mm->enablers);
> 
> without actually holding any locks, but in this case 'mm' is a newly
> allocated private thing of a task that hasn't even been exposed to the
> world yet, so nobody should be able to even see it. So that code lacks
> the proper locking for the new list, but it does so because there is
> nothing that can race with the new list (and the old list is
> read-only, so RCU traversal of the old list works).
> 

Well, that's the problem I was trying to point out. The fork path calls
user_event_mm_dup() -> user_event_mm_create(), which DO expose this to
the trace world. I definitely need to fix that, then I can drop these RCU
paths in the enablers. It has been exposed out to the tracing tracepoint
paths, but it has yet to be exposed out to the newly forked process that
could cause data writes, add new events, disable them, etc.

> So that "list_add_rcu()" there could probably be just a "list_add()",
> with a comment saying "this is new, nobody can see it".
> 

Yes, after I fix the ordering of the mm add to the tracing global list.
That is clearly something I should have done originally and caused
confusion and extra RCU usage that is unneeded.

> And if something *can* race it it and can see the new list, then it
> had damn well needs that mutex lock anyway, because that "something"
> could be actually modifying it. But that's separate from the page
> pinning situation.
> 
> So again, I claim that the RCU'ness of the pin_user_pages part is
> broken and should simply not exist.
> 
> > > Other code in that file happily just does
> > >
> > >         mutex_lock(&event_mutex);
> > >
> > >         list_for_each_entry_safe(enabler, next, &mm->enablers, link)
> > >
> > > with no RCU anywhere. Why does user_event_enabler_update() not do that?
> >
> > This is due to the fork() case above without taking the event_mutex.
> 
> See above. Your thinking is confused, and the code is broken.
> 
> If somebody can see the new list while it is created during fork(),
> then you need the event_mutex to protect the creation of it.
> 
> And if nobody can see it, then you don't need any RCU protection against it.
> 
> Those are the two choices. You can't have it both ways.
> 
> > > Oh, and even those other loops are a bit strange. Why do they use the
> > > "_safe" variant, even when they just traverse the list without
> > > changing it? Look at user_event_enabler_exists(), for example.
> >
> > The other places in the code that do this either will remove the event
> > depending on the situation during the for_each, or they only hold the
> > register lock and don't hold the event_mutex.
> 
> So?
> 
> That "safe" variant doesn't imply any locking. It does *not* protect
> against events being removed. It *purely* protects against the loop
> itself removing entries.
> 
> So this code:
> 
>         list_for_each_entry_safe(enabler, next, &mm->enablers, link) {
>                 if (enabler->addr == uaddr &&
>                     (enabler->values & ENABLE_VAL_BIT_MASK) == bit)
>                         return true;
>         }
> 
> is simply nonsensical. There is no reason for the "safe". It does not
> make anything safer.
> 
> The above loop is only safe under the mutex (it would need to be the
> "rcu" variant to be safe to traverse without locking), and since it
> isn't modifying the list, there's no reason for the safe.
> 
> End result: the "safe" part is simply wrong.
> 

Got it, I was confused.

> If the intention is "rcu" because of lack of locking, then the code needs to
>  (a) get the rcu read lock
>  (b) use the _rcu variant of the list traversal
> 
> And if the intention is that it's done under the proper 'event_mutex'
> lock, then the "safe" part should simply be dropped.
> 
>                Linus

Thanks,
-Beau

