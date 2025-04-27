Return-Path: <bpf+bounces-56806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29975A9E426
	for <lists+bpf@lfdr.de>; Sun, 27 Apr 2025 20:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA5C7AC44D
	for <lists+bpf@lfdr.de>; Sun, 27 Apr 2025 18:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176AA1F3BAC;
	Sun, 27 Apr 2025 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDl1MW8l"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07522148830
	for <bpf@vger.kernel.org>; Sun, 27 Apr 2025 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745777127; cv=none; b=Ldx1T2uxL2vA8aQHcm6+PzFWUPbK9565JcnSQDJdo7ScFUcbUYQ/8Vp3bTIWkbBg3mcYKX6NXDtGDQ8dAanWleGUPRQHZVcSVo6p5Nt6skFhkdRiEW6V+upwOAcRtgTcKerMhjrkPd4uBtz0keZ13mm3aUWn5G8Szu8uRLdlU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745777127; c=relaxed/simple;
	bh=iS+BWdQFqu9rHi+AL8I8nmdxj4clbLLijGqv07hWvPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R091HSyTpxQX/RQLIg1t03l9wa+vgHvl/mWVx+cm0naITXdaSAHOTm6kRUfbrJ6po35E34nlQGwhmCmIZtBsWsOlMU1dEOdWeNwnxDpArRrZ6TvuDBNXg38qL3cTOf8tZsAjpvsyrbXZhYV8+2uk0ROz385KYZLlXtkh6oZKzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDl1MW8l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745777124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hlulregCELNawc2eHc0Mpga5Qw4ebb5u08XRR8Bt5cg=;
	b=UDl1MW8lM+7jtia1THmYDOlycSXzDCB1QMB5kceKI0Ux64nb5T4nmeCS4VUd3GMk7GTXrk
	+o9x1FwzmFrGVlLoNGLE7R6z4QSdET7O7ZRQsm2znlDvJAuL7N+RTlCKUtTrWGoxqzav3B
	CNr+iujel/0r8PsPStjyphCT3snqIgI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-EdZCb-u_P4acJwNPKDrNwA-1; Sun,
 27 Apr 2025 14:05:20 -0400
X-MC-Unique: EdZCb-u_P4acJwNPKDrNwA-1
X-Mimecast-MFC-AGG-ID: EdZCb-u_P4acJwNPKDrNwA_1745777118
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCE6B1956086;
	Sun, 27 Apr 2025 18:05:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C842D19560A3;
	Sun, 27 Apr 2025 18:05:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 27 Apr 2025 20:04:39 +0200 (CEST)
Date: Sun, 27 Apr 2025 20:04:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
Message-ID: <20250427180432.GC27775@redhat.com>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-9-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421214423.393661-9-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 04/21, Jiri Olsa wrote:
>
> +struct uprobe_trampoline {
> +	struct hlist_node	node;
> +	unsigned long		vaddr;
> +	atomic64_t		ref;
> +};

I don't really understand the point of uprobe_trampoline->ref...

set_orig_insn/swbp_unoptimize paths don't call uprobe_trampoline_put().
It is only called in unlikely case when swbp_optimize() fails, so perhaps
we can kill this member and uprobe_trampoline_put() ? At least in the initial
version.

> +static void uprobe_trampoline_put(struct uprobe_trampoline *tramp)
> +{
> +	if (tramp && atomic64_dec_and_test(&tramp->ref))
> +		destroy_uprobe_trampoline(tramp);
> +}

Why does it check tramp != NULL ?

Oleg.


