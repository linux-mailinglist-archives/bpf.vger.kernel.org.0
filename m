Return-Path: <bpf+bounces-55113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FB7A78472
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 00:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2520F1890183
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 22:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72393214A90;
	Tue,  1 Apr 2025 22:12:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2015820AF6D;
	Tue,  1 Apr 2025 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545536; cv=none; b=daKdAfSESfkI1ORBGnO1SaXmXzHNlEnmyfA+aWx1f/k0nmSWWibtWNyLdTe5feLdq/CvW+8JO57LnWDsJ2EsA06eb+IKLinMdOleNggiKJPuASv0VQocoy74k37LBjZlQaccuuBs6uIMYFEo+8agTv4o87SKYiXNn0LoOCt5Paw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545536; c=relaxed/simple;
	bh=ueHFFVU8Pe2CZjt2gOmYKxtkwcIGkQ3hW9/7TQz/OQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fodVucwBCLMK1FB/QTSs/K/sKXNLxXppwti7Bd8dmYROec6/g/o+SEYihxc+/RvjUOvhw20fGp0ao33GXkQ2rqEdZthBmIwOm7i59Jh4tlioX/vs0QMQaj1UfN2uJct3I2s0NNfKnaY0PX3Fy9sqbqwWzZRJ8rki29si3EovsGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69F2C4CEE4;
	Tue,  1 Apr 2025 22:12:13 +0000 (UTC)
Date: Tue, 1 Apr 2025 18:13:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, mhocko@kernel.org,
 oleg@redhat.com, brauner@kernel.org, glider@google.com,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org
Subject: Re: [PATCH] exit: add trace_task_exit() tracepoint before
 current->mm is reset
Message-ID: <20250401181315.524161b5@gandalf.local.home>
In-Reply-To: <CAEf4BzYB1dvFF=7x-H3UDo4=qWjdhOO1Wqo9iFyz235u+xp9+g@mail.gmail.com>
References: <20250401184021.2591443-1-andrii@kernel.org>
	<20250401173249.42d43a28@gandalf.local.home>
	<CAEf4BzYB1dvFF=7x-H3UDo4=qWjdhOO1Wqo9iFyz235u+xp9+g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 15:04:11 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> How bad would it be to just move trace_sched_process_exit() then? (and
> add group_dead there, as you mentioned)?

I personally don't have an issue with that. In fact, the one place I used
the sched_process_exit tracepoint, I had to change to use
sched_process_free because it does too much after that.

OK, let's just move the sched_process_exit tracepoint. It's in an arbitrary
location anyway.

-- Steve

