Return-Path: <bpf+bounces-34392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B52F692D2DE
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 15:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519DFB27625
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 13:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D25190472;
	Wed, 10 Jul 2024 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9Qy/58s"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3018FDBE
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618379; cv=none; b=XgFPXVnHWHFPVBuryEtZFLldcsI4s6oV+aYQi7cirMtT3/inF1kpIJN8Jmh6Tw6PEeYdLOPr3cAn9YFHoZx/6sLc6CRQVhSMDWOiWBeJ/n1Vz2qgDFDk8zwNe2mfhOMQ0+oTcap+xLqoL7r1bS2frY7VaQzfCih7FVl4cYlswvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618379; c=relaxed/simple;
	bh=kn8LUbWIe+Gz3RA5JbBKLr6Du3KlZIc1sUeGjfDtUxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIgBd3pjZYvR1SPg2wkupVLaVRIWLgNOHTwQRKaswVz30QHs7Xxa/iFurSLR9gcT4FfweIoj17VqHoIx6ItcxiH5uOzMioxB+u9KNWYvi9JIfRCeOT32M3oVnNRPRUH3FoJ+rtUnYhHkdP53IbwwyccBhkV2BYYs2aLklJhSz4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9Qy/58s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720618376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=883k/meUQZ7VdLJT0YsroQR9x4ibt1eMIzZuBlKNXww=;
	b=D9Qy/58ssuYzQx7WUAKxMzUrzg6A7YoA5XSHv0EWZGF87Q2CUu7yl9NYbFRuFRHQxSWQ8g
	zD+aAN9fg6quMM0xBr9vASojPHMHMP0jI4V1ZV+/6j0MqxBwfDh67NM925+EeS3dlxk3c7
	8kggC24TFcduW3mpA1JF0axcCpvJuAo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-DmqMCUPaMmKvzHdTwEwXfQ-1; Wed,
 10 Jul 2024 09:32:55 -0400
X-MC-Unique: DmqMCUPaMmKvzHdTwEwXfQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B71F519560B2;
	Wed, 10 Jul 2024 13:32:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 029A91955F3B;
	Wed, 10 Jul 2024 13:32:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jul 2024 15:31:17 +0200 (CEST)
Date: Wed, 10 Jul 2024 15:31:12 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH v2 01/12] uprobes: update outdated comment
Message-ID: <20240710133112.GA9228@redhat.com>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-2-andrii@kernel.org>
 <20240703113829.GA28444@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703113829.GA28444@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/03, Oleg Nesterov wrote:
>
> >  	/*
> > -	 * The NULL 'tsk' here ensures that any faults that occur here
> > -	 * will not be accounted to the task.  'mm' *is* current->mm,
> > -	 * but we treat this as a 'remote' access since it is
> > -	 * essentially a kernel access to the memory.
> > +	 * 'mm' *is* current->mm, but we treat this as a 'remote' access since
> > +	 * it is essentially a kernel access to the memory.
> >  	 */
> >  	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page, NULL);
>
> OK, this makes it less confusing, so
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
>
> ---------------------------------------------------------------------
> but it still looks confusing to me. This code used to pass tsk = NULL
> only to avoid tsk->maj/min_flt++ in faultin_page().
>
> But today mm_account_fault() increments these counters without checking
> FAULT_FLAG_REMOTE, mm == current->mm, so it seems it would be better to
> just use get_user_pages() and remove this comment?

Well, yes, it still looks confusing, imo.

Andrii, I hope you won't mind if I redo/resend this and the next cleanup?

The next one only updates the comment above uprobe_write_opcode(), but
it would be nice to explain mmap_write_lock() in register_for_each_vma().

Oleg.


