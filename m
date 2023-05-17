Return-Path: <bpf+bounces-801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D5F706F40
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD4E1C20F6F
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 17:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50D731135;
	Wed, 17 May 2023 17:22:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB085442F
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:22:53 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F86965B9;
	Wed, 17 May 2023 10:22:52 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3982120F2693;
	Wed, 17 May 2023 10:22:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3982120F2693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1684344171;
	bh=B0oIcaJ7eKE8RVMGKo2gtY9gzbix+usqvgrS1+i9Jas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6fifcHIW6sisuL0qqYxgYpP6X1RTbYeicwpLCvLbO3XEB5Lrxs5WPRfNSPUt6J0g
	 HICQ49ZBIKMT+Fk1oUF84zrIpFsCFMHMAqEnV2k3UeNBGcs49PcI28Xs9UUXYwpDu7
	 HXd+3UAhDg9ryFEFalPHO+V1L1VkaUq2mMooAF2E=
Date: Wed, 17 May 2023 10:22:43 -0700
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
Message-ID: <20230517172243.GA152@W11-BEAU-MD.localdomain>
References: <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home>
 <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home>
 <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 08:03:09PM -0700, Linus Torvalds wrote:
> On Tue, May 16, 2023 at 7:29 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > So this code path is very much in user context (called directly by a
> > write system call). The issue that Alexei had was that it's also in an
> > rcu_read_lock() section.
> >
> > I wonder if this all goes away if we switch to SRCU?
> 
> Yes, SRCU context would work.
> 
> That said, how critical is this code? Because honestly, the *sanest*
> thing to do is to just hold the lock that actually protects the list,
> not try to walk the list in any RCU mode.
> 
> And as far as I can tell, that's the 'event_mutex', which is already held.
> 
> RCU walking of a list is only meaningful when the walk doesn't need
> the lock that guarantees the list integrity.
> 
> But *modification* of a RCU-protected list still requires locking, and
> from a very cursory look, it really looks like 'event_mutex' is
> already the lock that protects the list.
> 
> So the whole use of RCU during the list walking there in
> user_event_enabler_update() _seems_ pointless. You hold event_mutex -
> user_event_enabler_write() that is called in the loop already has a
> lockdep assert to that effect.
> 
> So what is it that could even race and change the list that is the
> cause of that rcu-ness?
> 

Processes that fork() with previous user_events need to be duplicated.

The fork() paths do not acquire the event_mutex. In the middle of a fork
an event could become enabled/disabled, which would call this part of
the code, at that time the list is actively being appended to when we
try to update the bits.

> Other code in that file happily just does
> 
>         mutex_lock(&event_mutex);
> 
>         list_for_each_entry_safe(enabler, next, &mm->enablers, link)
> 
> with no RCU anywhere. Why does user_event_enabler_update() not do that?
> 

This is due to the fork() case above without taking the event_mutex. I
really tried to not cause fork() to stall if a process uses user_events.
This required using RCU, maybe there is a simpler approach:

One approach I can think of is that during fork() we don't add the newly
created mm to the global list until we copy all the enablers. The COW
pages should reflect the bits if a timing window occurs there, since I
believe it's impossible for the newly forked() mm to cause a COW during
that time. Then I can drop this RCU on the enablers.

> Oh, and even those other loops are a bit strange. Why do they use the
> "_safe" variant, even when they just traverse the list without
> changing it? Look at user_event_enabler_exists(), for example.
> 

The other places in the code that do this either will remove the event
depending on the situation during the for_each, or they only hold the
register lock and don't hold the event_mutex. So the disabler could get
removed out from under it.

IE: user_events_ioctl_reg() -> current_user_event_enabler_exists()

This is a place where we could just simply change to grab the
event_mutex, it's pretty isolated and we take the lock anyway further
down the path.

> I must really be missing something. That code is confusing. Or I am
> very confused.
> 
>             Linus

Thanks,
-Beau

