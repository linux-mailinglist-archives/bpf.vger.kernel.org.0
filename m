Return-Path: <bpf+bounces-63670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71725B095CA
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 22:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEF55A16A6
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 20:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CE62248A5;
	Thu, 17 Jul 2025 20:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/3Wlho0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA552AEF5;
	Thu, 17 Jul 2025 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784721; cv=none; b=Px5ftW6JQn6CYoPHc50JA/MSQ/tyiTL9JSEVA8rvfRATkI6NNlDIyrvAgzZf12aHblnK/ZdqiZQ69AJyOfd9P/62KptG8NTdy4Qp+zKUoEuYa2khM/Qnk8bSs3t3HrmAX7U0AWhYqz8B8irZ9PPoJ/kiwuaJ3jerq3VmAZMDLUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784721; c=relaxed/simple;
	bh=7GyQUocLfLcFj7HM0l9V/mer49iHPDl7xAtCMgjYXr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBHxxSMyqstoSIGqq5i/pCJ+ipPP/qxW7Vm9j06Sulx+OXOKKIUDVwPJyuTygZqEG99s1OM9upmjFvD3CNtt9kJjJvrL6B3vxr6T8j9ZsYDMRVKL/IlJoSdg8S6kUNYWI5wQSuzlRStMv4QH2iJx1ZUGJvDOgOMCrBnDB//I8ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/3Wlho0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24960C4CEE3;
	Thu, 17 Jul 2025 20:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752784721;
	bh=7GyQUocLfLcFj7HM0l9V/mer49iHPDl7xAtCMgjYXr0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=o/3Wlho0HXDXZcLtRAB4W3s27qiRPz5zYBaNZUoWBuUm/AdQb36SUpeaaxnlrx3uu
	 avNKunobPbFGjkvthUQrS8rmUIXi8nzUmjnCd4JKI3DIpd+hK1xXpWJ+o2t4Vd5U1z
	 mwasSZVb4iY6jK5s3mjOo2DEkkC6dU+yGsvFXntpPBCuKlRUBlzcsNuHwNcw1AaPwY
	 YqYN11bnuDdq5O5F01xIX+t56iwotV/WRjrOw1fYQVHnvSpLkX0lDYswff6IjS+RJT
	 xhj63CDG34/J+IJzSMbEA3eQCEnxgY22HRO7sBDGu62Q5l1FShxo4qMLiVUp8Xd+Td
	 8ia/jyNPJLBhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BC40ECE13CD; Thu, 17 Jul 2025 13:38:40 -0700 (PDT)
Date: Thu, 17 Jul 2025 13:38:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	bpf@vger.kernel.org
Subject: Re: [PATCH RFC 6/4] srcu: Add guards for SRCU-fast readers
Message-ID: <f77b3b38-d150-4ee9-be65-fac2b877a355@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <58866d6b-f4d9-4aaf-abce-10ddf526c3ad@paulmck-laptop>
 <20250717151934.282d8310@batman.local.home>
 <af022343-1719-4882-bf86-ec49e59f77c3@paulmck-laptop>
 <20250717155638.63c4f58d@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717155638.63c4f58d@batman.local.home>

On Thu, Jul 17, 2025 at 03:56:38PM -0400, Steven Rostedt wrote:
> On Thu, 17 Jul 2025 12:51:29 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Thank you!  I will apply this on my next rebase.
> > 
> > The normal process puts this into the v6.18 merge window, that it, the
> > merge window after the upcoming one.  If you need it sooner, please let
> > us know.
> 
> I'd suggest 6.17. I can understand the delay for updates to the RCU
> logic for how subtle it can be, where more testing is required. But
> adding a guard() helper is pretty trivial and useful to have. I
> wouldn't delay it.

OK thank you, and let's see what we can do in v6.17.

							Thanx, Paul

