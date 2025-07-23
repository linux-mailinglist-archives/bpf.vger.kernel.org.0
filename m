Return-Path: <bpf+bounces-64225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AB0B0FD21
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 00:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1B33AF52C
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 22:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F013527056F;
	Wed, 23 Jul 2025 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSOFFsVt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE14233714;
	Wed, 23 Jul 2025 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753311062; cv=none; b=RhzS+6FCF1eTvQ9Xkl2FoTHPcaIKSu/b8/psrFVj7tAzW++dU0csXgUBrD/VsiP0YBeSRAfFqL8JmlWAeN5ZroJD3M9pTynZH0Ezk/+z/8oa3Dzk+pua6za+KaE1YeQr+rIVAGhjJeRqAYNDDA0P4UlmdEfKghgT+r275SJSpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753311062; c=relaxed/simple;
	bh=RlAPo3yG9r5xJn+uMDDav2IEh77+oZ277nIW3U916Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvKzjJgK0TFePIFCaapYdWcH1rLGlDFfJWxr9C6Cz4UEoBQHL8Y4qslQZdo0K3s8wXYHJNpVXRZPp8Zaebk5DQan7PpXmvVA94xBwGA+brKeKK9Tn1cnvJSrdwI+owXwMculi2kiYd2OUWn1K4t5MhqT5mM1cJp9/VqlGH2Luus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSOFFsVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D89C4CEE7;
	Wed, 23 Jul 2025 22:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753311062;
	bh=RlAPo3yG9r5xJn+uMDDav2IEh77+oZ277nIW3U916Rc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DSOFFsVtTDj5wzsYtmMJMet/xf3nzeAgo1MqEZZQL5HeM3JeXp8rV9NpB9IAiQ9TR
	 pwxvkt4Glkj5wYP9pHAlaXJiVQmDRqjeph1RX7dL8j/JHs6iuCyug1ftmN+KDQfTJu
	 5/o5IB9pX32YJaeQJBWfMlrilX8TnhfRtvf/8pmWTvGh8tx6akWo5p9/mF3yt89xam
	 VaoeJ80v3cwY9cgKsky9PXsbyR7RmcGmWbdQ0eGLCmOsabURJTLLEuMcv0L+CSEBZB
	 KsTOIwmzG0liPPKLs3IPkyjPPARunb2WHgMzmDBEzl/38QqAMyUFfZNdbMwE7pQUFq
	 NBrClfygk/12w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9DDE8CE127E; Wed, 23 Jul 2025 15:51:01 -0700 (PDT)
Date: Wed, 23 Jul 2025 15:51:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 4/6] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <18ef593a-9572-4189-8cd7-2222c8d5e43c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
 <20250723202800.2094614-4-paulmck@kernel.org>
 <020d22f0-a95b-4204-a611-eb3953c33f32@efficios.com>
 <a09344a7-22dc-48d1-a202-67532507163b@paulmck-laptop>
 <20250723182930.2d0d59f1@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723182930.2d0d59f1@gandalf.local.home>

On Wed, Jul 23, 2025 at 06:29:30PM -0400, Steven Rostedt wrote:
> On Wed, 23 Jul 2025 15:17:52 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > I believe that Steve provided me with the essentials for perf and ftrace,
> > but please check:  f808f53d4e4f ("squash! tracing: Guard __DECLARE_TRACE()
> > use of __DO_TRACE_CALL() with SRCU-fast").
> 
> Note, there's nothing in the ftrace side that requires preemption disabled,
> but it assumes that it is, and adjusts the preempt_count that is recorded
> in the trace event to accommodate it.

Ah, thank you for the clarification.  I agree with your approach as being
a more localized change, with less chance of some forgotten invariant
biting us.  ;-)

							Thanx, Paul

