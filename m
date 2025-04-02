Return-Path: <bpf+bounces-55179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4F6A795DD
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 21:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890DD171C12
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 19:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE351E7C03;
	Wed,  2 Apr 2025 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGItr/vr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E5537FF
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622233; cv=none; b=JRJOLMz41Jp9cbw4uQFKpNIsWTQtnCIRNj5+DcqUGpWSSoH45klwxmAh7HEBiQ1CZ1rNwUWtBgpyzpI/A2L77zQJy4XJCBM8s3uGjjXvjAB4XRyEJ14QzXAnGwvVbX0G2JJPLt6Tn5y5k5Xg0+27LRYYuJSTQbmLW5iiIFjxmhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622233; c=relaxed/simple;
	bh=pDty7qdy1rHOKuZlyaV2086KMlSFCizQT1WMJPTpj0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGSxvrbkhnpVhwLYCY/cZNIoq4eIlDZYhArOgz2oasqmcQLgPPFomIrkrEicuPCxOV4/sweYwYh5M/wp7rPjvTlB6wmBs+dFXjIloA70ohbxcgk+Qgg3tbga+FLmjxE4exX9nnoylYkrIQGrDdLYwdjmfQCJvZHAdocOMba9bsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGItr/vr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743622231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jMUxxfRt3wM6XkYnKMTxN7wq4AzIR0quaLREWPyUJRg=;
	b=OGItr/vrwR0zN09EvEiHXiGj4Lr4yTU0P0wKpPoC8uz+qyf9glO6YZRFEGWY/+IKXI1Zzh
	JlpBpTvIsz6N4k40P7VIkyC74z1nFtc21isZFVJkX37EbcaVOE8OOEALivekoDt6knpKTx
	HlmMx1umVMdIhFItCA6L9IoUXJcKmWM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-SLG-MGLjP8y-MyMLVm6a0Q-1; Wed,
 02 Apr 2025 15:30:24 -0400
X-MC-Unique: SLG-MGLjP8y-MyMLVm6a0Q-1
X-Mimecast-MFC-AGG-ID: SLG-MGLjP8y-MyMLVm6a0Q_1743622222
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDFA61800EC5;
	Wed,  2 Apr 2025 19:30:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EDFEA180B489;
	Wed,  2 Apr 2025 19:30:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Apr 2025 21:29:47 +0200 (CEST)
Date: Wed, 2 Apr 2025 21:29:41 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mhocko@kernel.org, rostedt@goodmis.org,
	brauner@kernel.org, glider@google.com, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Subject: Re: [PATCH v2] exit: move and extend sched_process_exit() tracepoint
Message-ID: <20250402192940.GB32368@redhat.com>
References: <20250402180925.90914-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402180925.90914-1-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/02, Andrii Nakryiko wrote:
>
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -937,12 +937,12 @@ void __noreturn do_exit(long code)
>  
>  	tsk->exit_code = code;
>  	taskstats_exit(tsk, group_dead);
> +	trace_sched_process_exit(tsk, group_dead);
>  
>  	exit_mm();
>  
>  	if (group_dead)
>  		acct_process();
> -	trace_sched_process_exit(tsk);

I see nothing wrong in this change.

(and I think that the current placement of trace_sched_process_exit() was
 more or less "random").

Acked-by: Oleg Nesterov <oleg@redhat.com>


