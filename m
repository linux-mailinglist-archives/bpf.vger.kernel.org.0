Return-Path: <bpf+bounces-49684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4EDA1BB5F
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 18:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D15B3AEBAC
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 17:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C3E1CEADF;
	Fri, 24 Jan 2025 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrFqJ0oB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8684715CD79
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737739579; cv=none; b=BG0BApZfBOGK41nF1V/wfPCMX9aDr6md/H7YeS9xN37Gp5XNx0NV6RRFADLnKPc2O1nDA/aLTNOGQ1NnYDMQXGj0j0btN46ungnAVTjY0Yxba+C4o7jw1EQm3sfNEQp3I9CzGMrzI23OvzKgBzmpHIBVp1/4ckbTPrGpMb96mUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737739579; c=relaxed/simple;
	bh=d8wUl4niMMG4T1Ja3SaVYJVWS3/qmpuxD7+JucIVKRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC350jv7Bvjfh4o5h4yHFtoG4RwHFUuutCXDn7iIRzBLe5RFhMCdiHOAUjI++YxUMAzyZaxfDPPx0U8lb8RAD0oGXkttxm1widnIquh5qzQ7CiIbDzXqFM2VaGaEBsqMIGjOZUGZzh2QSOfmRcVX+MMUxFaJKA1ca3NZQNuCJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NrFqJ0oB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737739576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d8wUl4niMMG4T1Ja3SaVYJVWS3/qmpuxD7+JucIVKRk=;
	b=NrFqJ0oBPrPHaaf1wpDRPIEoduBAAlUdVA4/O+1mW3kvqkdICRKU4g+Zw5WQU9gmTqNcnS
	zLXGJF5t3WdT2eS75B5seMEN82FvtVWKBLaAJyesWWFBM+EhAN6+SZwlOcZIqJnToBoQlL
	TljAxr5g1J5fLNq8pRHHpuTSd5v+C6g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-o9TuW2LFNw2IfUt3Yqazcw-1; Fri,
 24 Jan 2025 12:26:13 -0500
X-MC-Unique: o9TuW2LFNw2IfUt3Yqazcw-1
X-Mimecast-MFC-AGG-ID: o9TuW2LFNw2IfUt3Yqazcw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFB181955DCC;
	Fri, 24 Jan 2025 17:26:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.72])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 82F1919560AD;
	Fri, 24 Jan 2025 17:26:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 24 Jan 2025 18:25:44 +0100 (CET)
Date: Fri, 24 Jan 2025 18:25:36 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Liao Chang <liaochang1@huawei.com>, mhiramat@kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, andrii.nakryiko@gmail.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v5 1/2] uprobes: Remove redundant spinlock in
 uprobe_deny_signal()
Message-ID: <20250124172435.GB13891@redhat.com>
References: <20250124093826.2123675-1-liaochang1@huawei.com>
 <20250124093826.2123675-2-liaochang1@huawei.com>
 <20250124102702.6ff0ccc5@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124102702.6ff0ccc5@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/24, Steven Rostedt wrote:
>
> On Fri, 24 Jan 2025 09:38:25 +0000
> Liao Chang <liaochang1@huawei.com> wrote:
>
> > Since clearing a bit in thread_info is an atomic operation, the spinlock
> > is redundant and can be removed, reducing lock contention is good for
> > performance.
>
> Although this patch is probably fine, the change log suggests a dangerous
> precedence. Just because clearing a flag is atomic, that alone does not
> guarantee that it doesn't need spin locks around it.

Yes. And iirc we already have the lockless users of clear(TIF_SIGPENDING)
(some if not most of them look buggy). But afaics in this (very special)
case it should be fine.

See also https://lore.kernel.org/all/20240812120738.GC11656@redhat.com/

> There may be another path that tests the flag within a spin lock,

Yes, retarget_shared_pending() or the complete_signal/wants_signal loop.
That is why it was decided to take siglock in uprobe_deny_signal(), just
to be "safe".

But I still think this patch is fine. The current task is going to execute
a single insn which can't enter the kernel and/or return to the userspace
before it calls handle_singlestep() and restores TIF_SIGPENDING. We do not
care if it races with another source of TIF_SIGPENDING.

The only problem is that task_sigpending() from another task can "wrongly"
return false in this window, but I don't see any problem.

Oleg.


