Return-Path: <bpf+bounces-664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC8470551F
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 19:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2A52814E7
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 17:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EAC107AB;
	Tue, 16 May 2023 17:38:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659458814
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 17:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF41C433D2;
	Tue, 16 May 2023 17:38:53 +0000 (UTC)
Date: Tue, 16 May 2023 13:38:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, linux-toolchains@vger.kernel.org,
 daandemeyer@meta.com, andrii@kernel.org, kris.van.hees@oracle.com,
 elena.zannoni@oracle.com, nick.alcock@oracle.com
Subject: Re: [POC 5/5] x86_64: invoke SFrame based stack tracer for user
 space
Message-ID: <20230516133850.4685e72c@gandalf.local.home>
In-Reply-To: <CAEf4BzY498TqDDBYFWoUHi9RG3fdhfDmJPo0Nm-793N7A_eTLQ@mail.gmail.com>
References: <20230501200410.3973453-1-indu.bhagat@oracle.com>
	<20230501200410.3973453-6-indu.bhagat@oracle.com>
	<20230502105353.GO1597476@hirez.programming.kicks-ass.net>
	<20230502112720.0c0d011b@gandalf.local.home>
	<CAEf4BzY498TqDDBYFWoUHi9RG3fdhfDmJPo0Nm-793N7A_eTLQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 May 2023 10:25:52 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> As discussed in the halls of LSF/MM2023, such lazily mapped .sframe in
> approach won't work with BPF's bpf_get_stack() approach, which expects
> stack trace to be grabbed and returned synchronously from NMI context.
> But we can probably retrofit it into bpf_get_stackid()+STACK_TRACE BPF
> map API.

Note that we will likely not be able to use sframe in NMI context, and if
that's a requirement, then BPF will need to continue using the method it is
currently using.

The best way to access sframe reliable is in normal context. NMI is
special, and really should never had been used to access user space
addresses. That was just a simple solution but not a good one. There's a
lot of hacks just to allow a page fault in NMI context.
See https://lwn.net/Articles/484932/

> 
> Indu, please cc bpf@vger.kernel.org for future revisions so we can
> track and plan accordingly. Thank you!

I'll likely be taking over the kernel side of sframes. I'll be happy to
Cc that work to the bpf mailing list.

-- Steve

