Return-Path: <bpf+bounces-45568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E84A9D82B9
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 10:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D5B16197B
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 09:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93582191473;
	Mon, 25 Nov 2024 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V9xA4n1+"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E418C031;
	Mon, 25 Nov 2024 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527880; cv=none; b=eDZI3hLf1Vy4SxtiQhAitqRyP+WmqbRAC66Fy1oXVb4wamGmCceqNYHIS2OcOD95k1Z4OiuqlyVqs7m/uHeF7J8I4nEocoWUFVYZrAMWBXCVSGv2chdF3oAWA5ay5ehQBSYIK03buXLoWGieOBPpjqMsOhyHxBDyOqZqJVGIIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527880; c=relaxed/simple;
	bh=lV2sPbbMYAQnsg3PBiGJBeLa/xFChAYA78ttDDmX/OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN5oxwNkzxM6GbvNB6UEBPyyNW/8vBfLw0KN95prmHhNGJh4dEgFg9XswIxqJ+4zI70Tz7FbyVXmlp2lq+9B6VZ6HlqZxDdzBhhlXohds5cuedb/fDE4t8TRZpD4N5DAeaU1ZSOLIXFYgK4JcDBxo568/vtQx1PR2juQsimuLIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V9xA4n1+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lV2sPbbMYAQnsg3PBiGJBeLa/xFChAYA78ttDDmX/OA=; b=V9xA4n1+Mz5THSJwXjhrIWhSLa
	azE0WTQ5uBBkjNpeA4pP4AIYXh07XzCdDT9HZ48fS8wRorWmghdZmbaluZHD9QyONvtESO7B4qrdi
	KglrzBl0BOxgbZsR8xsjoH+OIvq0tUnf3My/USKMFO6/Ff42FeNhzdGnDLDlxZTAaYn5yn0XX9C3t
	aCbsRS5lo37BQotPB1pdYiXfDdJtiSc5FfqUATsY+jMhjiwATf6gkhMZd2sVnmHPRqd7o/b/0BjFl
	4HypQqL+5D3p/D22yOm6KJMAltmjtCG3g6pkyhsSZCnfNsNniC/lC2owUo6GBzHoBZmm2sC7fUNfR
	5gcYkJIQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFVdq-000000014Vc-4B53;
	Mon, 25 Nov 2024 09:44:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9254630026A; Mon, 25 Nov 2024 10:44:26 +0100 (CET)
Date: Mon, 25 Nov 2024 10:44:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ruan Bonan <bonan.ruan@u.nus.edu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"will@kernel.org" <will@kernel.org>,
	"longman@redhat.com" <longman@redhat.com>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>,
	"mattbobrowski@google.com" <mattbobrowski@google.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>,
	"song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Fu Yeqi <e1374359@u.nus.edu>
Subject: Re: [BUG] possible deadlock in __schedule (with reproducer available)
Message-ID: <20241125094426.GO39245@noisy.programming.kicks-ass.net>
References: <24481522-69BF-4CE7-A05D-1E7398400D80@u.nus.edu>
 <20241123202744.GB20633@noisy.programming.kicks-ass.net>
 <20241123180000.5e219f2e@gandalf.local.home>
 <CAADnVQLBhV_sSuH+BKu66ZsxTcsvw7RSLnjRGLwQX3TFSjs-Gg@mail.gmail.com>
 <20241124223045.4e47e8b7@rorschach.local.home>
 <20241124224441.5614c15a@rorschach.local.home>
 <5489FB30-8B09-4F74-9C2B-FF25F4654A3F@u.nus.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5489FB30-8B09-4F74-9C2B-FF25F4654A3F@u.nus.edu>

On Mon, Nov 25, 2024 at 05:24:05AM +0000, Ruan Bonan wrote:

> From the discussion, it appears that the root cause might involve
> specific printk or BPF operations in the given context. To clarify and
> possibly avoid similar issues in the future, are there guidelines or
> best practices for writing BPF programs/hooks that interact with
> tracepoints, especially those related to scheduler events, to prevent
> such deadlocks?

The general guideline and recommendation for all tracepoints is to be
wait-free. Typically all tracer code should be.

Now, BPF (users) (ab)uses tracepoints to do all sorts and takes certain
liberties with them, but it is very much at the discretion of the BPF
user.

Slightly relaxed guideline would perhaps be to consider the context of
the tracepoint, notably one of: NMI, IRQ, SoftIRQ or Task context -- and
to not exceed the bounds of the given context.

More specifically, when the tracepoint is inside critical sections of
any sort (as is the case here) then it very much is on the BPF user to
not cause inversions.

At this point there really is no substitute for knowing what you're
doing. Knowledge is key.

In short; tracepoints should be wait-free, if you know what you're doing
you can perhaps get away with a little more.

