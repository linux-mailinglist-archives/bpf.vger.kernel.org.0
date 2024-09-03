Return-Path: <bpf+bounces-38775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5376969FA3
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4619C1F2494E
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 14:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246C8364A0;
	Tue,  3 Sep 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tkax2lHD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272362AE99
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372007; cv=none; b=hr0xT4WdODcX16Q3ma/4kysFen7J04NmSCF+L9Fong3O9iKCAkwwlM+Yghqip1E7iUMAjkAFvDd6aqleA+5eyx8jWtk+m9ClFgKvZeOCBaFNsjzx2irVIsB1ZciqffG2bVzgRbadHQPPsYg9Ja95e8xNMuIq+SRHOXVKdioJX0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372007; c=relaxed/simple;
	bh=GsjevHJXsnqvGMZ8L30qbBHqavxUfCBayoBtcR6NkSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXYztAiLdAkdtdNiZgvJ88qubxMaSIySgCGkBQFqLgVVQkbnZDuqnQVe9ur6ukVKbj3lF3/o/1D/I8wgQe4/QC5rzdQPN5pUIwoqnwhU3wUwkSQWMp5M6jyb08QFLHtJ8aPEOaPmKRlTWN/x2Lw54Vee5YrwYP6II7XBXlyvrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tkax2lHD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725372005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vOyoZGP/p+DT+U1ETspm+Bx5HvccqPRxCBRFOBQrO4c=;
	b=Tkax2lHDX8R01R3/6JYbmLkfFDBXW2nZHnRrhv1gVedHkKH7o1/9GGxSbloNrXNd5BtVES
	9srCYzGUm/Yes/gR2RRj1SLnONIT8+8zMSECYUiQF/w32SHIGe5UlCqitGoARkrl1EU9ZD
	vtJzIpFyhexMuAH1iZb/ev7805JMwcY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-VS-W_Pz6P-6r_Y7YKaslCw-1; Tue,
 03 Sep 2024 10:00:01 -0400
X-MC-Unique: VS-W_Pz6P-6r_Y7YKaslCw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 727E018EA8B6;
	Tue,  3 Sep 2024 13:59:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BE0DD1956052;
	Tue,  3 Sep 2024 13:59:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  3 Sep 2024 15:59:49 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:59:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 0/8] uprobes: RCU-protected hot path optimizations
Message-ID: <20240903135943.GE17936@redhat.com>
References: <20240829183741.3331213-1-andrii@kernel.org>
 <20240830102400.GA20163@redhat.com>
 <20240903132103.GV4723@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903132103.GV4723@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/03, Peter Zijlstra wrote:
>
> On Fri, Aug 30, 2024 at 12:24:01PM +0200, Oleg Nesterov wrote:
> > On 08/29, Andrii Nakryiko wrote:
> > >
> > > v3->v4:
> > >   - added back consumer_rwsem into consumer_del(), which was accidentally
> > >     omitted earlier (Jiri);
> >
> > still,
> >
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> >
>
> Let me go queue this in perf/core then. Thanks!

FYI, Andrii was going to send another revision due to missing include
inux/rcupdate_trace.h in kernel/events/uprobes.c.

See the build failure reported kernel test robot:
https://lore.kernel.org/all/202408310130.t9EBKteQ-lkp@intel.com/

Oleg.


