Return-Path: <bpf+bounces-33764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1C8925EE6
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 13:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DBE283D39
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDF313C66A;
	Wed,  3 Jul 2024 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlAcqrYB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A195137910
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006819; cv=none; b=NBBxKcGRger7Zr8/teDiVBKdYkhp6+btsazJr+k6xudrP+e24vACYYj+AEauyaFwlO4mLBa3EIMmt4qpv4RdFm3qxwfj9+yZXs18JVGjDzeITunqk/TjJEGMgceAf+n8cSoXaUyRvVU+4Q55vxyM+uvMxopWui2njV/t6Nm8ewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006819; c=relaxed/simple;
	bh=Q/gLFE2jiZm2A5UjLyCwu76dGuP501HZRmWqLeZf/iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHOjqCGeFmUmsX6JSXn6l/Qtx3lSEvKMA0gMhSgnuyg+6OkiZicaE8Ot9TI0FOyuG1IltdVYqqRfMgL9hMi/ZvFVXg//SwrTfWW8ZeJAPfIq/cZ/BBCY8lTrFVcJ7ghrXYtyMVa0gTP5VyyZTomG6bOmwKtU4oy8nY/WhC6L8i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlAcqrYB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720006817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REw1xMcZju11woGKbqg6skhczkzaJjJnxVodA2+Ty3k=;
	b=XlAcqrYBi5VzLYPBzTnd6ic4wQgHAbpuR2NU14LFRwefbkQt+DQAroewdV9dr776ZhmpeX
	H4CAxl1gc6BJaacz0wznCWmgE/OF7WzbpdTqVynvcoy1QVAR63SOeTlLe1XiJic2NJ7H7d
	vaG5DnKzBEez5/MsHnSBSAmNKH+5T6Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-EHJL6A1qPCGubzUU4B5LsQ-1; Wed,
 03 Jul 2024 07:40:11 -0400
X-MC-Unique: EHJL6A1qPCGubzUU4B5LsQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B109F19560B1;
	Wed,  3 Jul 2024 11:40:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.202])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E9F081955F21;
	Wed,  3 Jul 2024 11:40:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Jul 2024 13:38:34 +0200 (CEST)
Date: Wed, 3 Jul 2024 13:38:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH v2 01/12] uprobes: update outdated comment
Message-ID: <20240703113829.GA28444@redhat.com>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701223935.3783951-2-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Sorry for the late reply. I'll try to read this version/discussion
when I have time... yes, I have already promised this before, sorry :/

On 07/01, Andrii Nakryiko wrote:
>
> There is no task_struct passed into get_user_pages_remote() anymore,
> drop the parts of comment mentioning NULL tsk, it's just confusing at
> this point.

Agreed.

> @@ -2030,10 +2030,8 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
>  		goto out;
>
>  	/*
> -	 * The NULL 'tsk' here ensures that any faults that occur here
> -	 * will not be accounted to the task.  'mm' *is* current->mm,
> -	 * but we treat this as a 'remote' access since it is
> -	 * essentially a kernel access to the memory.
> +	 * 'mm' *is* current->mm, but we treat this as a 'remote' access since
> +	 * it is essentially a kernel access to the memory.
>  	 */
>  	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page, NULL);

OK, this makes it less confusing, so

Acked-by: Oleg Nesterov <oleg@redhat.com>


---------------------------------------------------------------------
but it still looks confusing to me. This code used to pass tsk = NULL
only to avoid tsk->maj/min_flt++ in faultin_page().

But today mm_account_fault() increments these counters without checking
FAULT_FLAG_REMOTE, mm == current->mm, so it seems it would be better to
just use get_user_pages() and remove this comment?

Oleg.


