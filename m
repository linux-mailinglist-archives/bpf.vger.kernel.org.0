Return-Path: <bpf+bounces-64846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DD5B17902
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 00:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371666203C6
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 22:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55FB26CE13;
	Thu, 31 Jul 2025 22:14:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7761719DF62;
	Thu, 31 Jul 2025 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000098; cv=none; b=RcOn4GsXa+TvGvur85RoIog21j7R10XnWmXp6F1bnu/qTZ5F/T8aacG0z6VuD/ch1DwTuTDIK4WbZToozGTj5BCk0Bg2qc1IlyUj0LqB9VJ5keisytmLkNiC7fsXIlRsxug/xsYAlSCDRRbD2IXrtzU7j7d6zExrRb/PgAgd5RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000098; c=relaxed/simple;
	bh=T2iK/JRIu+MAVgGULZdaXCB0yQ+4ElAMiiMnn10eWxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzK7tf6LNjjdKcdmEJKIjzZqWibGKLrD/OsDpXVsDGww7Z+8qQR3FZrLSVdfUatRi7p5QJZLV0WUrSn1L5odjXT/yr+Or4eukPUabn9QgOVbOzTOE+CRY+Xg/k/9yGN9IeROUM8qoQ224/MboEMtsNq/4U/30l0ecCtsvjUgzW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 7A97B160732;
	Thu, 31 Jul 2025 22:14:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 4923D20030;
	Thu, 31 Jul 2025 22:14:44 +0000 (UTC)
Date: Thu, 31 Jul 2025 18:15:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>, Tom Zanussi
 <zanussi@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>,
 aahringo@redhat.com
Subject: Re: [PATCH] tracing/probes: Allow use of BTF names to dereference
 pointers
Message-ID: <20250731181503.2662c1c7@gandalf.local.home>
In-Reply-To: <aIvlrQEZQ6OTZxAY@krava>
References: <20250729113335.2e4f087d@batman.local.home>
	<aIvlrQEZQ6OTZxAY@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4923D20030
X-Stat-Signature: gk43yptynx94a9irn4b7sfzkab9mopr5
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18aRYcpEoFQX773FH3fd8FR5oGOdXff/aE=
X-HE-Tag: 1754000084-43510
X-HE-Meta: U2FsdGVkX1+VnurXHtEPrwd65fkKV2qDbXnGLvvxC9q8uwHd3+ckcA/wbwH8Ayigco7RS/fW7SCJ8KdwN4f7ffZ6jlpSSbLxbDpS4lJxSXHgGpxHP1L3buQg1ecSBI8+8uQgriXZVWCMITez94pdHuJiEYKwwYmXBxhXqXLPp9+7HYJiBo8if2mItRT4OLg7X2inxEclMHH4ropPVvMNzyimKDqw24zJNI25Z1kqEP2ifZYkmTwEzRiBECDPdsTOk9p0BLquFa4hHlD4XF3QLJ46ncpQIf7D7gD/zUj9MHNk7Tao3k/1mMXZVfkyaEJj4UF3Anrgc/7YoQg75Gb0VgfLOTr0Ly8P

On Thu, 31 Jul 2025 23:52:45 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> > +int btf_find_offset(char *arg, long *offset_p)
> > +{
> > +	const struct btf_type *t;
> > +	struct btf *btf;
> > +	long offset = 0;
> > +	char *ptr;
> > +	int ret;
> > +	s32 id;
> > +
> > +	ptr = strchr(arg, '.');
> > +	if (!ptr)
> > +		return -EINVAL;
> > +
> > +	*ptr = '\0';
> > +
> > +	id = bpf_find_btf_id(arg, BTF_KIND_STRUCT, &btf);  
> 
> hi,
> I think you need to call btf_put(btf) before return

I think you're correct ;-)

-- Steve

