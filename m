Return-Path: <bpf+bounces-62180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49060AF620D
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 20:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1933C1C472C0
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 18:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687612D77F3;
	Wed,  2 Jul 2025 18:57:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DEA2BE652;
	Wed,  2 Jul 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482645; cv=none; b=Y4ok3n2zzHIIyQW3P3XDtuPGDrUUTEhyaA+vGcwkBIrIwP6UfRRYDgXG6U4d8JMZbVNeWZ7pkKSI/wj7urmNKlpjsqy/XyDGBtqKgrbnp1izP5lv2HyjwjvSmRdLhyJckuc4YhawqYWtt45TX3gaJ/di6rJIqzGFQhfr0chDQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482645; c=relaxed/simple;
	bh=lfmZKeb2RRDCWysaxWfgfh0H9ySYIV5bvHrrEE+QlIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nuxfj0Xwsk3YemJ5uLAMEuKv9DMEDPkZBatadhK4V+zyx7PW+Chr8I5+jsuQ3WWX2FCuyx0ZecB/kr5vQ36ERxLijjJna3fepHaCRLB65bc2MSHHKkivSS+LGmHYJKE2wx2FlFIbc/bI6+Jgip9g0cyjjdGJr0O4L1qNy3QwQd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 7EC0E1A03D3;
	Wed,  2 Jul 2025 18:57:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 3945820028;
	Wed,  2 Jul 2025 18:57:15 +0000 (UTC)
Date: Wed, 2 Jul 2025 14:57:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>
Subject: Re: [PATCH v12 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250702145713.57062487@batman.local.home>
In-Reply-To: <CAHk-=wiU6aox6-QqrUY1AaBq87EsFuFa6q2w40PJkhKMEX213w@mail.gmail.com>
References: <20250701005321.942306427@goodmis.org>
	<20250701005451.571473750@goodmis.org>
	<20250702163609.GR1613200@noisy.programming.kicks-ass.net>
	<20250702124216.4668826a@batman.local.home>
	<CAHk-=wiXjrvif6ZdunRV3OT0YTrY=5Oiw1xU_F1L93iGLGUdhQ@mail.gmail.com>
	<20250702132605.6c79c1ec@batman.local.home>
	<20250702134850.254cec76@batman.local.home>
	<CAHk-=wiU6aox6-QqrUY1AaBq87EsFuFa6q2w40PJkhKMEX213w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tqycyxrww589xoz45k6js778uimaj3fu
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 3945820028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+/5DHB7kU211/NodR5xO9YcdRNxQMWYSI=
X-HE-Tag: 1751482635-577231
X-HE-Meta: U2FsdGVkX18zNvFAdZATJxTQQ/TbOv73e+1chWo4pPdA8XZfmthF1JMQxwMQfRenqHsdWzOjipyRZy/Rc2He9l0U897hIFmikK66fysA6pVE5lQxIidCckr0P+AfxIRtoX/oRjhTdDLlwRJ+98o3KVm1viF8cGGelrH5+x3QPJ2cPhZwymmuzwcyyeQzL8LTxlPOWGMnRGzTXxS1i07dG98wBIJGZyUT7ikrDRyKM/azimoNr+LuhCN66eFqhNyVBPFRFvhNkcJh/6FHH1uFe8ZPfSKk22O4Uoxb+vs2Nkh3ZUxCVJNUq+vlHpv8NmPwXe1hrmWvlDsvJIHOmCJeZqNHaQ2Hq6F3ghpPF3+xZwK3l02NoMTrj3JJFyG7n3swzNSrqhSK3FOZ7C/cmjqKTZlkj0m7fVkhPqIzO1JSBKkNVINU3L3Um/xDxC5U0t5B

On Wed, 2 Jul 2025 11:21:34 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 2 Jul 2025 at 10:49, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > To still be able to use a 32 bit cmpxchg (for racing with an NMI), we
> > could break this number up into two 32 bit words. One with the CPU that
> > it was created on, and one with the per_cpu counter:  
> 
> Do you actually even need a cpu number at all?
> 
> If this is per-thread, maybe just a per-thread counter would be good?
> And you already *have* that per-thread thing, in
> 'current->unwind_info'.

I just hate to increase the task struct even more. I'm trying to keep
only the data I can't put elsewhere in the task struct.

> 
> And the work is using task_work, so the worker callback is also per-thread.
> 
> Also, is racing with NMI even a thing for the sequence number? I would
> expect that the only thing that NMI would race with is the 'pending'
> field, not the sequence number.

The sequence number is updated on the first time it's called after a
task enters the kernel. Then it should return the same number every
time after that. That's because this unique number is the identifier
for the user space stack trace which doesn't change while the task is
in the kernel, hence the id getting updated every time the task enters
the kernel and not after that.

> 
> IOW, I think the logic could be
> 
>  - check 'pending' non-atomically, just because it's cheap

Note, later patches move the "pending" bit into a mask that is used to
figure out what callbacks to call.

> 
>  - do a try_cmpxchg() on pending to actually deal with nmi races
> 
> Actually, there are no SMP issues, just instruction atomicity - so a
> 'local_try_cmpxchg() would be sufficient, but that's a 'long' not a
> 'u32' ;^(

Yeah, later patches do try to use more local_try_cmpxchg() at different
parts. Even for the timestamp.

> 
>  - now you are exclusive for that thread, you're done, no more need
> for any atomic counter or percpu things

The trick and race with NMIs is, this needs to return that cookie for
both callers, where the cookie is the same number.


> 
> And then the next step is to just say "pending is the low bit of the
> id word" and having a separate 31-bit counter that gets incremented by
> "get_cookie()".
> 
> So then you end up with something like
> 
>   // New name for 'get_timestamp()'
>   get_current_cookie() { return current->unwind_info.cookie; }
>   // New name for 'get_cookie()':
>   // 31-bit counter by just leaving bit #0 alone
>   get_new_cookie() { current->unwind_info.cookie += 2; }
> 
> and then unwind_deferred_request() would do something like
> 
>   unwind_deferred_request()
>   {
>         int old, new;
> 
>         if (current->unwind_info.id)
>                 return 1;
> 
>         guard(irqsave)();
>         // For NMI, if we race with 'get_new_cookie()'
>         // we don't care if we get the old or the new one
>         old = 0; new = get_current_cookie() | 1;
>         if (!try_cmpxchg(&current->unwind_info.id, &old, new))
>                 return 1;
>         .. now schedule the thing with that cookie set.
> 
> Hmm?
> 
> But I didn't actually look at the users, so maybe I'm missing some
> reason why you want to have a separate per-cpu value.

Now we could just have the counter be the 32 bit cookie (old timestamp)
in the task struct, and have bit 0 be if it is valued or not.

static u32 get_cookie(struct unwind_task_info *info)
{
	u32 cnt = READ_ONCE(info->id);
	u32 new_cnt;

	if (cnt & 1)
		return cnt;

	new_cnt = cnt + 3;
	if (try_cmpxchg(&info->id, &cnt, new_cnt))
		return new_cnt;

	return cnt; // return info->id; would work too
}

Then when going back to user space:

	info->id &= ~1;

Now the counter is stored in the task struct and no other info is needed.

> 
> Or maybe I missed something else entirely, and the above is complete
> garbage and the ramblings of a insane mind.
> 
> It happens.
> 
> Off to get more coffee.

Enjoy, I just grabbed my last cup of the day.

-- Steve

