Return-Path: <bpf+bounces-60111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8C3AD2A7F
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D02827A3388
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1F922B5B6;
	Mon,  9 Jun 2025 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwW1qu/e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931B22B588;
	Mon,  9 Jun 2025 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749511610; cv=none; b=rHh5ktba3WWvmZ+dCz05U2n5oxkx8e4GTyQp80yy9XAiUbJWuiVgHhjF1hM/Dw+rZ7PROlw7beB8YPf4gcS7zH2fsG0gLFcecRi0ahbakALv5I8c8i0lyPovWywquYVTRm0yzxRMxXQlrJibtHFt2x+/r9378+48D9XCRRuALTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749511610; c=relaxed/simple;
	bh=Aumbtb4AZN063xAleZtZe+qd8XmERe+H3IwO4eAnrHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GW6mfe2kTkV5YLu+Lw67xxCprsb3nrDpMqyAxVBiiIKXR7f3i+QsIFj7tPaxbzD+ttEvp9MNzDxDO/n6/8Ql7OKQeyen9LIsW8v7jU7Ksw36QF57hmrJYhdyjUOd31xB7wDSuLXcwu5gqHu+rpdx3XBSIowec1U13zU+mkCRs44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwW1qu/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022CFC4CEEB;
	Mon,  9 Jun 2025 23:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749511609;
	bh=Aumbtb4AZN063xAleZtZe+qd8XmERe+H3IwO4eAnrHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwW1qu/eq5uzk5bTxz5QL1bi0HpVdDQAKsRuQwOqTG8PWLp3ZZucveTlegecacn55
	 VQqpi3aGOkB9+vuhpiUIKlHFNqx7tiYDZKV0TV1U7K7fS0XhIycJzHAKbuQ25n0q2f
	 7luNhqqapqR7queTL/cqauXhS0d8OroHLxDLnxiXHkmgv/qEgPPwSnvFLm0qHECIJg
	 MW78edWJ327N7FLCnv9tZMrFbWhPIhYkF0+hS9NrWN9fmvmBbQew+GUn5GH0ikc2kN
	 jRHktvSGIvuY3SC3/SpOs+qrV73ROZDKBE6rNupb2vsPTX2emgRh9DQe5n9XRWPmtY
	 wkoKslX9zqUpQ==
Date: Tue, 10 Jun 2025 01:26:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>, rcu@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] rcu: Fix lockup when RCU reader used while IRQ
 exiting
Message-ID: <aEdttj_vcdIEsKxG@pavilion.home>
References: <20250609180125.2988129-1-joelagnelf@nvidia.com>
 <20250609180125.2988129-2-joelagnelf@nvidia.com>
 <aEc6sroqylvlfx_M@tardis.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEc6sroqylvlfx_M@tardis.local>

Le Mon, Jun 09, 2025 at 12:49:06PM -0700, Boqun Feng a écrit :
> Hi Joel,
> 
> On Mon, Jun 09, 2025 at 02:01:24PM -0400, Joel Fernandes wrote:
> > During rcu_read_unlock_special(), if this happens during irq_exit(), we
> > can lockup if an IPI is issued. This is because the IPI itself triggers
> > the irq_exit() path causing a recursive lock up.
> > 
> > This is precisely what Xiongfeng found when invoking a BPF program on
> > the trace_tick_stop() tracepoint As shown in the trace below. Fix by
> > using context-tracking to tell us if we're still in an IRQ.
> > context-tracking keeps track of the IRQ until after the tracepoint, so
> > it cures the issues.
> > 
> 
> This does fix the issue, but do we know when the CPU will eventually
> report a QS after this fix? I believe we still want to report a QS as
> early as possible in this case?

If !ct_in_irq(), we issue a self-IPI, then preempt_schedule_irq() will
call into schedule() and report a QS (if preempt/bh is not disabled, otherwise
this is delayed to preempt_enable() or local_bh_enable() issuing preempt_schedule())

If ct_in_irq(), we are already in an IRQ, then it's the same as above
eventually.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

