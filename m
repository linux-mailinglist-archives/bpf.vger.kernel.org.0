Return-Path: <bpf+bounces-570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81AE703DC7
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 21:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4C21C20C05
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 19:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933D819525;
	Mon, 15 May 2023 19:35:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E843D2E4
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 19:35:42 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 139D226AC;
	Mon, 15 May 2023 12:35:41 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 42A012044710;
	Mon, 15 May 2023 12:35:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42A012044710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1684179340;
	bh=PcFG+iIa/PA7p0IIgskPb1ruV+sX7mzcczF0a582zuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dZC0Y1cjSTLSoaHgLlbLJz9qTrQZ3hbcf9ZlQOPGYVMVbbgOQUi309o/v++fIOct8
	 LHS6+lCLPr2yc32sNNHeyQ5P/wGZYLepluAC+iqSDagyJ+z/heZVKg/h/vy+tMLiRH
	 PuNPVhL0D1XkdrY1gEUA1LyM//Mw+1f+cCn7ln4U=
Date: Mon, 15 May 2023 12:35:32 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	dthaler@microsoft.com, brauner@kernel.org, hch@infradead.org
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230515193532.GA153@W11-BEAU-MD.localdomain>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home>
 <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515143305.4f731fa9@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515143305.4f731fa9@gandalf.local.home>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 15, 2023 at 02:33:05PM -0400, Steven Rostedt wrote:
> On Mon, 15 May 2023 09:57:07 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > Thank you for these details. Answer below...
> 
> Thanks for this well thought out reply!
> 
> 

[...]

> > 
> > > 	if (unlikely(ret <= 0)) {
> > > 		if (!fixup_fault)
> > > 			return -EFAULT;
> > > 
> > > 		if (!user_event_enabler_queue_fault(mm, enabler, *attempt))
> > > 			pr_warn("user_events: Unable to queue fault handler\n");  
> > 
> > This part looks questionable.
> > 
> > The only users of fixup_user_fault() were futex and KVM.
> > Now user_events are calling it too from user_event_mm_fault_in() where
> > "bool unlocked;" is uninitialized and state of this flag is not checked
> > after fixup_user_fault() call.
> > Not an MM expert, but this is suspicious.
> 
> Hmm, yeah, this should be:
> 
> static int user_event_mm_fault_in()
> {
> 	bool unlocked = false;
> 
> 	[..]
> 
> out:
> 	if (!unlocked)
> 		mmap_read_unlock(mm->mm);
> }
> 
> Good catch!
> 

I don't believe that's correct. fixup_user_fault() re-acquires the
mmap lock, and when it does, it lets you know via unlocked getting set
to true. IE: Something COULD have changed in the mmap during this call,
but the lock is still held.

See comments here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/gup.c#n1287

Thanks,
-Beau

> 
> Thank you Alexei for asking these. The above are all valid concerns.
> 
> -- Steve
> 

