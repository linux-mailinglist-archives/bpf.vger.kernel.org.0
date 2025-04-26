Return-Path: <bpf+bounces-56783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E9BA9DAC0
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 14:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 454517AC51C
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539D44A02;
	Sat, 26 Apr 2025 12:37:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0529523BE;
	Sat, 26 Apr 2025 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745671069; cv=none; b=tHLxouprJlRTfqyL1AC6Kl0KB9i6iGtD4rRSJrWbQ7mEAIX3gIcFCDMe0twSX85ewtJiHNWFtInI64t5kZiGaRIB1E9zwC7Quj7jXzjan2+AOqmJVZXPbx/VZDw6AkMGOcaFlnB8B6muo8RvcZ2tgQnnuY3kWPjnWGgoRLPExRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745671069; c=relaxed/simple;
	bh=FhnB/f2eS+TpixKJZ1oPFU936Rb5zabms5B2x9SIPro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxCqlLDWBzkWGaghjNPn+OeCvlbBTmBHczo9owcM56dGJkQSR3ii9bmY9f6s6xjhXgkqk22wf6vPEpjIprdgqZ5keUGPaNibMFqaotKbty4qwe0mUW01H0jZ0AvmL7QCBIEcGXrz2uSDu6WpqKBwtwZsTPFT8FNinflZ0qQzw4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ABDC4CEE2;
	Sat, 26 Apr 2025 12:37:46 +0000 (UTC)
Date: Sat, 26 Apr 2025 08:37:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, Kees Cook <kees@kernel.org>, bpf@vger.kernel.org, Tejun Heo
 <tj@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>, cocci@inria.fr
Subject: Re: [RFC][PATCH 1/2] kthread: Add is_user_thread() and
 is_kernel_thread() helper functions
Message-ID: <20250426083745.77590827@batman.local.home>
In-Reply-To: <26F4E8D1-4DDF-48EC-AE21-478EDF4C65C3@alien8.de>
References: <20250425204120.639530125@goodmis.org>
	<20250425204313.616425861@goodmis.org>
	<26F4E8D1-4DDF-48EC-AE21-478EDF4C65C3@alien8.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Apr 2025 14:08:46 +0300
Borislav Petkov <bp@alien8.de> wrote:

> >+static __always_inline bool is_kernel_thread(struct task_struct *task)
> >+{
> >+	return task->flags & PF_KTHREAD;  
> 
> return !is_user_thread(task);
> 
> or the other way around. 

Yeah, I thought about doing that but decided against it.

As Kees mentioned to use !!, I think using the !is_user_thread() is a
better approach.

-- Steve

