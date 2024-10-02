Return-Path: <bpf+bounces-40735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076A998CD18
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 08:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391EE1C21A86
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 06:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBE684D2C;
	Wed,  2 Oct 2024 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SX7n50Fk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B481723
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850200; cv=none; b=aXrdzuCHe13GEfV/SNLs3szCQvJiBBJDYM77ce6hq848++E7RqWaiLU9LPX3ahY1Rst6aImlldXDA5QOqA9gKCyxzcE+u7BfUMjcMmbkFw7RQ0v7WAyuUBNqRLCDoTXvq9b0mhk3MKBWI5N6QgFhqYf6oPHs4htiyYBMNFjd/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850200; c=relaxed/simple;
	bh=UzKoBxpbk4aL4Yx0+CEm/GEDDDVa1g3ht2MnHb5Ts/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fChkjjCdFC7/4ym9FV3pUw0KNg430dwwDdD8bErdKbVcIPyWpfeSHau4McKikY0lK7RiXIZQc5xDx+IS6TjhWyed5NPhdoT/7oqpzSSFSmCc0EU8ETxz9v2uQjHmFtSDspUeb61nuFqFof+ELSK0qcuU1wu8O2qbqhBEi4kriiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SX7n50Fk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727850197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CoIq6U8qofHBQZGFVoSjI+GCS/TwH5xAxtMOanCM3vA=;
	b=SX7n50FkfCdbcMEU2xBjs503Drz8N8qxmDeNwPNm1vwk1JirMknfcgSiih3JtUFGDTcKRy
	CtCDSdrLO2lIXZLxXpizdilvPQA/MQeDksPQPMVS+b+gMZVKq6pVh44UCCVxbYuhUCFx2b
	N7skI6z1i3N6P6Nj3PIXUtqm3ZGQ/mI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-y3H0uhPmP4q3HNzJ2LXVCw-1; Wed,
 02 Oct 2024 02:23:14 -0400
X-MC-Unique: y3H0uhPmP4q3HNzJ2LXVCw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3B1419560A2;
	Wed,  2 Oct 2024 06:23:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.196])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 30ABB19560AD;
	Wed,  2 Oct 2024 06:23:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Oct 2024 08:22:56 +0200 (CEST)
Date: Wed, 2 Oct 2024 08:22:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org,
	jannh@google.com, mhocko@kernel.org, vbabka@suse.cz,
	mingo@kernel.org
Subject: Re: [PATCH v2 tip/perf/core 4/5] uprobes: simplify
 find_active_uprobe_rcu() VMA checks
Message-ID: <20241002062248.GA27552@redhat.com>
References: <20241001225207.2215639-1-andrii@kernel.org>
 <20241001225207.2215639-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001225207.2215639-5-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 10/01, Andrii Nakryiko wrote:
>
> At the point where find_active_uprobe_rcu() is used we know that VMA in
> question has triggered software breakpoint, so we don't need to validate
> vma->vm_flags. Keep only vma->vm_file NULL check.
> 
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Oleg Nesterov <oleg@redhat.com>


> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index a2e6a57f79f2..7bd9111b4e8b 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2091,7 +2091,7 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
>  	mmap_read_lock(mm);
>  	vma = vma_lookup(mm, bp_vaddr);
>  	if (vma) {
> -		if (valid_vma(vma, false)) {
> +		if (vma->vm_file) {
>  			struct inode *inode = file_inode(vma->vm_file);
>  			loff_t offset = vaddr_to_offset(vma, bp_vaddr);
>  
> -- 
> 2.43.5
> 


