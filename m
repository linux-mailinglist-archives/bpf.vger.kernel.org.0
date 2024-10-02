Return-Path: <bpf+bounces-40747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B6F98CDB8
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 09:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D33281826
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 07:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBF8193436;
	Wed,  2 Oct 2024 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PShmL/P8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B06825771
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853956; cv=none; b=UyhGlCA+tieNYagR7hTgBv/KO3n0yRgUevFUiic4KQhm+JAIPyvQT6OiCVFu+3AxajAfQbYXPqNM1/Hscccbfy49gusCaUHLNzHo8TTMFgrsLdvUQ3LsojrNo3EbwA4GQvx1ndN2HNgRdz4grj9lLEEgeTuNow938a2NYBWZ0Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853956; c=relaxed/simple;
	bh=whs1PLrIWf98FbtcWpSMvQ2hiSqPL9UXrhXLV0qbJUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2kL9nztLUYhKgxSO+cGsw4QcbBuu1xvBApnh43O9NWELpWRLktDZ4Uz6tNylxxFjet7TuTgK+9tTyOHHwLqIJVjH93SKPDlrglp/RGuPHDCZRGnvaKzFiwIQk5EBiumtlz22AEWBcwixirFeJoMj7FKVhO+3sLGrU3VjTblibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PShmL/P8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727853953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+6Ju5sOQPJKUz0yTIEr2+PumFGXW89G0ZVPqVTbN80=;
	b=PShmL/P8qsai8cJGctG2J/W9wu6bwdpSvsISPupmyv9/XKUIAt5pj8Q71mWTH5pvjbzssp
	oz1IiQn6mm61tYmjz0jUadNoQDlQjFY01f8hfZ86pAdWmOXaBH3vXdXgceyAq4fhWcY0NL
	DpQXn4SGuxIv5cV3iRDEJ9T3sMS20vg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-NKM0WuwcORu4JEE4-zijow-1; Wed,
 02 Oct 2024 03:25:48 -0400
X-MC-Unique: NKM0WuwcORu4JEE4-zijow-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C59F9195608B;
	Wed,  2 Oct 2024 07:25:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.196])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 68A7A19560A2;
	Wed,  2 Oct 2024 07:25:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Oct 2024 09:25:30 +0200 (CEST)
Date: Wed, 2 Oct 2024 09:25:23 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org,
	jannh@google.com, mhocko@kernel.org, vbabka@suse.cz,
	mingo@kernel.org
Subject: Re: [PATCH v2 tip/perf/core 5/5] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
Message-ID: <20241002072522.GB27552@redhat.com>
References: <20241001225207.2215639-1-andrii@kernel.org>
 <20241001225207.2215639-6-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001225207.2215639-6-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/01, Andrii Nakryiko wrote:
>
> +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct uprobe *uprobe = NULL;
> +	struct vm_area_struct *vma;
> +	struct file *vm_file;
> +	loff_t offset;
> +	long seq;
> +
> +	guard(rcu)();
> +
> +	if (!mmap_lock_speculation_start(mm, &seq))
> +		return NULL;
> +
> +	vma = vma_lookup(mm, bp_vaddr);
> +	if (!vma)
> +		return NULL;
> +
> +	/* vm_file memory can be reused for another instance of struct file,
> +	 * but can't be freed from under us, so it's safe to read fields from
> +	 * it, even if the values are some garbage values; ultimately
> +	 * find_uprobe_rcu() + mmap_lock_speculation_end() check will ensure
> +	 * that whatever we speculatively found is correct
> +	 */
> +	vm_file = READ_ONCE(vma->vm_file);
> +	if (!vm_file)
> +		return NULL;
> +
> +	offset = (loff_t)(vma->vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vma->vm_start);

LGTM. But perhaps vma->vm_pgoff and vma->vm_start need READ_ONCE() as well,
if nothing else to shut up KCSAN if this code races with, say, __split_vma() ?

> +	uprobe = find_uprobe_rcu(vm_file->f_inode, offset);

OK, I guess vm_file->f_inode is fine without READ_ONCE...

Oleg.


