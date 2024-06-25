Return-Path: <bpf+bounces-33047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D57E91658E
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 12:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0CA1C2175E
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2317214A4E1;
	Tue, 25 Jun 2024 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWhMpPvS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8861487C8
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312753; cv=none; b=F81bUcQu7VncSfChS0noHyc68KB69xHxPrJGb7ztUKbTt1ZWsvZlW4Pna+7L1UR/vSfeH3qCrCEH0qvxdaAztpD6t8pkaqT+R08UYqGt7bKxnhPuVZK8m270Y2mJEFQvtdWG7jbKt/uiHTMdUs4xHxWgE/8NQlv/I8IyEt4+xq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312753; c=relaxed/simple;
	bh=xsBdtpI54FoOSUb77qs1DTcuu9/gqAqEpvliU+PuvIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfcGd3g72l5+sGo6bDvbh29yfb1qexvj2OHjM/020Go6A1o7+MXLvOM/xbzpcPgXaIhHgwuPimFdh4aAkrIDE2qwrafEPP8CFdKBCnLJwQN+unIrsdM/P3YMOp2tvOAkOdcINTAuKXxF0y8Sx5LlS1gavTGwo8aav6zJn7jIxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWhMpPvS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719312751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pHsvthZbZtlCFiyH7nqCiYFCPc67csnKDgNG4Ut8o8M=;
	b=iWhMpPvS5nr5Uq7ZLfDQby1ZweW16FzEBsLWwQ+D+d6mTM2MdhzknH+7xVVGVsCIQHa8C9
	G1kl6DpJexdtYjxVLXI27qMO8yuj30SMmfoUC/VukEziQBr2nnRRedLr2hmi3R3Vr0t04b
	VrGL4K/j8p8avo8D6lpICJx2XXwpFV0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-NmnGFxuUO1eK3-YmLHB5bw-1; Tue,
 25 Jun 2024 06:52:23 -0400
X-MC-Unique: NmnGFxuUO1eK3-YmLHB5bw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB24019560B6;
	Tue, 25 Jun 2024 10:52:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 04FA9300061D;
	Tue, 25 Jun 2024 10:52:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Jun 2024 12:50:48 +0200 (CEST)
Date: Tue, 25 Jun 2024 12:50:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH 02/12] uprobes: grab write mmap lock in unapply_uprobe()
Message-ID: <20240625105043.GA14979@redhat.com>
References: <20240625002144.3485799-1-andrii@kernel.org>
 <20240625002144.3485799-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625002144.3485799-3-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

I don't think I can review, I forgot everything, but I'll try to read this
series when I have time to (try to) understand what it does...

On 06/24, Andrii Nakryiko wrote:
>
> Given unapply_uprobe() can call remove_breakpoint() which eventually
> calls uprobe_write_opcode(), which can modify a set of memory pages and
> expects mm->mmap_lock held for write, it needs to have writer lock.
>
> Fix this by switching to mmap_write_lock()/mmap_write_unlock().
>
> Fixes: da1816b1caec ("uprobes: Teach handler_chain() to filter out the probed task")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 197fbe4663b5..e896eeecb091 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1235,7 +1235,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
>  	struct vm_area_struct *vma;
>  	int err = 0;
>
> -	mmap_read_lock(mm);
> +	mmap_write_lock(mm);

Can you explain what exactly is wrong?

FOLL_FORCE/etc is fine under mmap_read_lock(), __replace_page() seems too...

I recall that initially uprobes.c always took mmap_sem for reading, then
register_for_each_vma() was changed by 77fc4af1b59d12 but there was other
reasons for this change...

Again, I don't understand this code today, quite possibly I missed something,
I am just trying to understand.

Well, it seems there is another reason for this change... Currently 2
unapply_uprobe()'s can race with each other if they try to update the same
page. But in this case we can rely on -EAGAIN from __replace_page() ?

Oleg.


