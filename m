Return-Path: <bpf+bounces-32880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7CA9145B6
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 11:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF741C21F83
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 09:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB0712F592;
	Mon, 24 Jun 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FL2wVzk7"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB2B1805E;
	Mon, 24 Jun 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219891; cv=none; b=IRBi0B8wqLn7DPVAIpPq+wWYmqtz90Fj7wqul8fmI8fet6vGz2CrCk/QJr37gQB0dfxjhO14R9J+8KMuVO9M0avbmYkH9oSMs1tbgtZ10Ob7aMM2tjLqpCJM9PZvni88wmLcQOT4QPQR34BSVTENS6Wz0uA1SItoHigtlBdPO8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219891; c=relaxed/simple;
	bh=qOKKj+vSE8iJq04V7aJLfJ5mVlcSE0IZo8cuGu/UOhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNUKPqflPnUzZtIVriGyUOQC3KSLyO17tQ9Mzd/hT+JCVp9aVvzX7S/RA8esT0LyCo0MUujMKLfGFM7NFbe1SbAlqe2Oc7XoH/dafJW0+spNJnwv6TkQFXkjbZMWL8XAOqnkwQN7VmbSiHuIEgjT0TTFKBWFG7ANW+jVsk2/99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FL2wVzk7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fQ7Hmfo8XApN4qZ2tlcgDa06oblQBkHNpn0Zc1XJrAo=; b=FL2wVzk7cBjs2QJJqzNJIKYg8s
	YtTn1qXZ08VRJFUC7r4C9Ow+9/oUEtxcBBFMII/9CDDCckklTVbIq2kH0z/rsv0vAcXMQrNXIP/+l
	E0Jz+e77GoKEdul5mg0KhkgSVhRw8HSZLRWIUKme4mk8FeTZ3FMxhsS+HUbWwAUcF/AWI+6q//JtD
	dC7kdXDoXKmOUBVSQJqs9KAeUvkarSYKOAK5bbLEHNSsFDzH072cqwVJ47dvf3JdO58PQnZShADhq
	v0Hi7dicR6WZV6bSd7B5mCrYtBouPXrHE/veJpDISm1TJL6D7HNEHPeC3ZQHLDvpcCXPLQndpJvc6
	jQJyAtjg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLfcl-00000008DCY-1wJV;
	Mon, 24 Jun 2024 09:04:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 13398300754; Mon, 24 Jun 2024 11:04:31 +0200 (CEST)
Date: Mon, 24 Jun 2024 11:04:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.11] sched, sched_ext: Replace
 scx_next_task_picked() with sched_class->switch_class()
Message-ID: <20240624090431.GG31592@noisy.programming.kicks-ass.net>
References: <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
 <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
 <ZnRptXC-ONl-PAyX@slm.duckdns.org>
 <ZnSp5mVp3uhYganb@slm.duckdns.org>
 <CAHk-=wjFPLqo7AXu8maAGEGnOy6reUg-F4zzFhVB0Kyu22h7pw@mail.gmail.com>
 <ZnXYsHw1gOZ4jlp2@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnXYsHw1gOZ4jlp2@slm.duckdns.org>

On Fri, Jun 21, 2024 at 09:46:56AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jun 20, 2024 at 03:42:48PM -0700, Linus Torvalds wrote:
> ...
> > Btw, indirect calls are now expensive enough that when you have only a
> > handful of choices, instead of a variable
> > 
> >         class->some_callback(some_arguments);
> > 
> > you might literally be better off with a macro that does
> > 
> >        #define call_sched_fn(class, name, arg...) switch (class) { \
> >         case &fair_name_class: fair_name_class.name(arg); break; \
> >         ... unroll them all here..
> > 
> > which then just generates a (very small) tree of if-statements.
> > 
> > Again, this is entirely too ugly to do unless people *really* care.
> > But for situations where you have a small handful of cases known at
> > compile-time, it's not out of the question, and it probably does
> > generate better code.
> 
> I'll update the patch description to point to the previous message just in
> case and apply it to sched_ext/for-6.11.

Can you please back merge and keep it a sane series? I'm going to have
to review it (even though I still very strongly disagree with the whole
thing) and there really is nothing worse than a series that introduces
things only to remove/change them again later.

