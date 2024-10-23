Return-Path: <bpf+bounces-42853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB6C9ABA7B
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 02:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8175B232D7
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 00:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB108175B1;
	Wed, 23 Oct 2024 00:20:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27817753;
	Wed, 23 Oct 2024 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642840; cv=none; b=QC57w0M+ymCwuo18UI9BiFSfod3jP5exRZ8saGy3ZzBENCJLASBguJCNW42pMjQkfLR4BGdG2a9iGFo1iCeOaNy9iG6TcCS8WyDClXmdbgK1ZBuH+JiZ1jIQGq57r2rTXxp8g8+z6mYCk9JDr0CJCb/RnRjnzkkn1UodIKT/LKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642840; c=relaxed/simple;
	bh=0kSOg9f5wbUj4S89ebjgTp0df7YqMPgK9WjQwW7IRKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xl8UisqSPGAPrQYkcPXrBAW2MFne2jh1icx5Jdw6fz7tOkg+ucbMMlzWWl7SGeToMK3eysHyyOli8hsFhNURXXPf9bjayawXyU3L0WE+yyC3uDJtimlWCYO2+b+c/1DtXpiHgKnhps6psWe+K0oV031gGdvhcp4cvYjzbpAaDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3488C4CEC3;
	Wed, 23 Oct 2024 00:20:37 +0000 (UTC)
Date: Tue, 22 Oct 2024 20:20:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jordan Rife
 <jrife@google.com>, linux-kernel@vger.kernel.org,
 syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, Michael Jeanson
 <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
Message-ID: <20241022202034.2f0b5d76@rorschach.local.home>
In-Reply-To: <1ab8fe0d-de92-49be-b10b-ebb5c7f5573a@efficios.com>
References: <20241022151804.284424-1-mathieu.desnoyers@efficios.com>
	<CADKFtnSGoSXm-r0cykucj4RyO5U7-HHBPx7LFkC6QDHtyPbMfQ@mail.gmail.com>
	<3362d414-4d6f-43a7-80af-1c72c5e66d70@efficios.com>
	<CAEf4BzYBR95uBY58Wk2R-h__m5-gV0FmbrxtDgfgxbA1=+u0BQ@mail.gmail.com>
	<1ab8fe0d-de92-49be-b10b-ebb5c7f5573a@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 16:04:49 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > 
> > That's just to say that I don't think that we need any BPF-specific
> > fix beyond what Mathieu is doing in this patch, so:
> > 
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>  
> 
> Thanks!

Does this mean I can pull this patch as is? I don't usually take RFCs.

-- Steve

