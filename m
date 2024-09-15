Return-Path: <bpf+bounces-39942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C06979761
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 17:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABC32820F1
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 15:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BA71C9DD9;
	Sun, 15 Sep 2024 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+24g+S+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109FF1C9877
	for <bpf@vger.kernel.org>; Sun, 15 Sep 2024 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726412700; cv=none; b=vCY1InOjuS9pIuxtkFOPsMqTQBt58eZ2tdZ7SMkvpq25HFqMlhZIeT0NoopyVJsywYouN3fWxGjkfI1Tgfhz2SOZEW0kdu0jq7RPIrnC4gzpXHBEH6YiYpORt+MSIp/6cgzxHWj/3DqHEapkTtb6Gjq8T9frg/R+8s165c5lr9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726412700; c=relaxed/simple;
	bh=muriC4vnR1Pgp6FrCmeUYns5egLK2oHEwfG6/WSz7Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrpIldXEsVM706eU91tzBbTp/7UyM7SYLwRRxRtlrGat4XZ7WZ5wbB/nzJfvTYnKjWIdAJmXE2r0jnN36j3YY+IjVs18wHyLTF3rqE5FA7+gNsaBmjWSyUpnUqr+1WUceBT4aquraCS1hKseU5dVB2mB61jXIj3rY69Uye31uj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+24g+S+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726412698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgPXoGAgWEmJuNaNaMNmxrMHZdG9YhV6gHMHUQ6h5z0=;
	b=E+24g+S+iTPZd+IZllyY4dogO2wKL/REkdezclmY+yfo66xC+JBacIb/sWJ2B3BOxrglt3
	brsCAlvyf0jC60ne/brzcxb1vC++HTIL0/p1G0mcyTpJOFp/1N7SoNvSLSa4VpapHQpYXS
	69gAU5OEeGRm1OCZ5qIowkbY32/khXo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-JbosABjIMUe7gj9-zuvLyw-1; Sun,
 15 Sep 2024 11:04:52 -0400
X-MC-Unique: JbosABjIMUe7gj9-zuvLyw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0DA119560B1;
	Sun, 15 Sep 2024 15:04:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 09EE51956086;
	Sun, 15 Sep 2024 15:04:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 15 Sep 2024 17:04:37 +0200 (CEST)
Date: Sun, 15 Sep 2024 17:04:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org,
	jannh@google.com
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
Message-ID: <20240915150429.GC27726@redhat.com>
References: <20240906051205.530219-1-andrii@kernel.org>
 <20240906051205.530219-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906051205.530219-3-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/05, Andrii Nakryiko wrote:
>
> +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
> +{
> +	const vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
...
> +	if (!vm_file || (vma->vm_flags & flags) != VM_MAYEXEC)
> +		goto bail;

Not that this can really simplify your patch, feel free to ignore, but I don't
think you need to check vma->vm_flags.

Yes, find_active_uprobe_rcu() does the same valid_vma(vma, false) check, but it
too can/should be removed, afaics.

valid_vma(vma, false) makes sense in, say, unapply_uprobe() to quickly filter
out vma's which can't have this bp installed, but not in the handle_swbp() paths.

Oleg.


