Return-Path: <bpf+bounces-43226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22A49B15C7
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 09:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB890283E9B
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 07:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA297083C;
	Sat, 26 Oct 2024 07:13:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C2E183CD4;
	Sat, 26 Oct 2024 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729926803; cv=none; b=X5iNKi3rURW6zvA5nruZmAAorIAlg1Lb6PjmzhXVttRVtK/TvWvQM2sMhLky4amfumaU4iieqcl6tM6mLric5newZ3EF50Ax5AjEix5h2SlgfVvvnEJQvBwW7BO954eIN86hg5JXa489FXa+aBlp7sGK5MFXavR0/eJV9pGvs8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729926803; c=relaxed/simple;
	bh=Q/sgAUVS6R7lQ6DyA99V3mGnHGzVphfOu8As7Kx0ljU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWDzRqPY4JIHC7Mt/b78xCur/QYHSjG9T37Qf8F4ihGKopjYu9C41u4DlRhIV2lVge2Cfm1sYG32KPmZPkNfCOrmrqdDyhpIqwahmtPy+QZUvShsBCH6BXBqN0YApHjTKJPKPvNTUm6fJsaN2YYlh0ymZZVuaIxU9awPgQjczTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3028C4CEC6;
	Sat, 26 Oct 2024 07:13:18 +0000 (UTC)
Date: Sat, 26 Oct 2024 03:13:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jordan Rife <jrife@google.com>, acme@kernel.org,
 alexander.shishkin@linux.intel.com, andrii.nakryiko@gmail.com,
 ast@kernel.org, bpf@vger.kernel.org, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, mark.rutland@arm.com, mhiramat@kernel.org,
 mingo@redhat.com, mjeanson@efficios.com, namhyung@kernel.org,
 paulmck@kernel.org, peterz@infradead.org,
 syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, yhs@fb.com
Subject: Re: [RFC PATCH v1] tracing: Fix syscall tracepoint use-after-free
Message-ID: <20241026031314.0f53e7fa@rorschach.local.home>
In-Reply-To: <f31710d3-e4d8-43ad-9ccb-6d13201756a3@efficios.com>
References: <20241025182149.500274-1-mathieu.desnoyers@efficios.com>
	<20241025190854.3030636-1-jrife@google.com>
	<f31710d3-e4d8-43ad-9ccb-6d13201756a3@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 15:38:48 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > I'm curious if it might be better to add some field to struct
> > tracepoint like "sleepable" rather than adding a special case here
> > based on the name? Of course, if it's only ever going to be these
> > two cases then maybe adding a new field doesn't make sense.  
> 
> I know Steven is reluctant to bloat the tracepoint struct because there
> are lots of tracepoint instances (thousands). So for now I thought that
> just comparing the name would be a good start.

You are correct. I really trying to keep the footprint of
tracepoints/events down.

> 
> We can eventually go a different route as well: introduce a section just
> to put the syscall tracepoints, and compare the struct tracepoint
> pointers to the section begin/end range. But it's rather complex
> for what should remain a simple fix.

A separate section could work.

-- Steve

