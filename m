Return-Path: <bpf+bounces-45562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF539D7A6B
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 04:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C463162D49
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 03:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AF04F8A0;
	Mon, 25 Nov 2024 03:44:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F2810F9;
	Mon, 25 Nov 2024 03:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732506288; cv=none; b=QJJNGHQ6rJHMk7bBJEXafPaJMui9GwS7FvwWh/pNWJvlNPQp7y6hwmmYgfvX6XjS2cFq/8rrJMd8ObuXNsD+hpnzhaXfIEAfp3HTtflQOW08YLRY3MNImHc1dzgGALY7bmSWgfjpLjP21aGYDHHSeQSWQJBZFuJWwgu4/LYyDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732506288; c=relaxed/simple;
	bh=ZRnoajD1QdXZX6krqeoKi10PkO2r+xrRVPlVkYB7UZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxTtAnrCdN+O36RryvTM64Y0UHlk5An2BJ1W9Mg9y5pQs5F0oLrIuVXL6RYvwul/BNiThq7B4wfd1f/stMjNcTOl+0vuAJtP/DqQ/cw/KG5Un2czE+DWkZ90bm9g1cnUhS5HIkroJz+bKVgKzPzHAS0tBU5C8MhVznYqMjW7GUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A050C4CECE;
	Mon, 25 Nov 2024 03:44:43 +0000 (UTC)
Date: Sun, 24 Nov 2024 22:44:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ruan Bonan
 <bonan.ruan@u.nus.edu>, "mingo@redhat.com" <mingo@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "longman@redhat.com"
 <longman@redhat.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>, "mattbobrowski@google.com"
 <mattbobrowski@google.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
 <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org"
 <song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me"
 <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "mhiramat@kernel.org"
 <mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
 <mathieu.desnoyers@efficios.com>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Fu Yeqi <e1374359@u.nus.edu>
Subject: Re: [BUG] possible deadlock in __schedule (with reproducer
 available)
Message-ID: <20241124224441.5614c15a@rorschach.local.home>
In-Reply-To: <20241124223045.4e47e8b7@rorschach.local.home>
References: <24481522-69BF-4CE7-A05D-1E7398400D80@u.nus.edu>
	<20241123202744.GB20633@noisy.programming.kicks-ass.net>
	<20241123180000.5e219f2e@gandalf.local.home>
	<CAADnVQLBhV_sSuH+BKu66ZsxTcsvw7RSLnjRGLwQX3TFSjs-Gg@mail.gmail.com>
	<20241124223045.4e47e8b7@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Nov 2024 22:30:45 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > Ack. BPF should not be causing deadlocks by doing code called from
> > > tracepoints.    
> > 
> > I sense so much BPF love here that it diminishes the ability to read
> > stack traces :)  
> 
> You know I love BPF ;-)  I do recommend it when I feel it's the right
> tool for the job.

BTW, I want to apologize if my email sounded like an attack on BPF.
That wasn't my intention. It was more about Peter's response being
so short, where the submitter may not understand his response. It's not
up to Peter to explain himself. As I said, this isn't his problem.

I figured I would fill in the gap. As I fear with more people using BPF,
when some bug happens when they attach a BPF program somewhere, they
then blame the code that they attached to. If this was titled "Possible
deadlock when attaching BPF program to scheduler" and was sent to the
BPF folks, I would not have any issue with it. But it was sent to the
scheduler maintainers.

We need to teach people that if a bug happens because they attach a BPF
program somewhere, they first notify the BPF folks. Then if it really
ends up being a bug where the BPF program was attached, it should be
the BPF folks that inform that subsystem maintainers. Not the original
submitter.

Cheers,

-- Steve

