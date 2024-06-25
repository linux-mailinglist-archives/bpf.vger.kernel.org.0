Return-Path: <bpf+bounces-33063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE21916B07
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 16:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA742859F9
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F52316D33B;
	Tue, 25 Jun 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPZ7O3Oi"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4837516D31C
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327100; cv=none; b=KkwLuXxyXIQyEpmnyQZBxBQmMyC9tG3/eQIIy3qFSyLXbnTNNXvQkxzR36EJnTzKeDysrkej6yrGSOq6Zc5Pfv6nVtakfMn5jBvQhQPrfdQyumlpLIj+lIcBC0HQMgWtOcZo+nyheBSi8G7YUMrpuI3UH7ReCqpwml314W8KFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327100; c=relaxed/simple;
	bh=v76kX6Yqf/ttqX1bSAcPMLXkbrs/9IQ1fOvtZsUtYbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECAOfMNknFDbklUfg2TqlRA4pu9CgaxWZ2Vmrr58yvBZ51fq/FLjHQakjKb5wapTJbBKr3JgeUgnmvRavDTAj9nkAiPs/0gi1BFIIf3SSbsLQcnsw+Yj7WYufv5x/gY54PUOyxZZp/pAK/zhnKV2BhdalDei9trkMsnnJ4tQIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPZ7O3Oi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719327098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v76kX6Yqf/ttqX1bSAcPMLXkbrs/9IQ1fOvtZsUtYbM=;
	b=DPZ7O3Oi8v2pxJvPnxpKWqMLxwIpUy9wfsd1fG1pUcAUlDuZMeCIGZJB9VwMGPIk9VpTnf
	kOP6V4D10fhyUYwWPInEEKz04GEeeQVnkJGITVXCi6mHb3FKTYVC0TVk3mLFQa01CTnfzR
	NhFCQ3CkRrgvopAggpqqNEnnvoAduXA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-CgwGlM-ENm2Cp5z6Cl9IPQ-1; Tue,
 25 Jun 2024 10:51:32 -0400
X-MC-Unique: CgwGlM-ENm2Cp5z6Cl9IPQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 978DE19560A0;
	Tue, 25 Jun 2024 14:51:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.198])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A39761955E91;
	Tue, 25 Jun 2024 14:51:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Jun 2024 16:49:57 +0200 (CEST)
Date: Tue, 25 Jun 2024 16:49:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, peterz@infradead.org, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH 02/12] uprobes: grab write mmap lock in unapply_uprobe()
Message-ID: <20240625144952.GA21558@redhat.com>
References: <20240625002144.3485799-1-andrii@kernel.org>
 <20240625002144.3485799-3-andrii@kernel.org>
 <20240625102925.665f2fa3b39dc7602b1321d8@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625102925.665f2fa3b39dc7602b1321d8@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 06/25, Masami Hiramatsu wrote:
>
> On Mon, 24 Jun 2024 17:21:34 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > Given unapply_uprobe() can call remove_breakpoint() which eventually
> > calls uprobe_write_opcode(), which can modify a set of memory pages and
> > expects mm->mmap_lock held for write, it needs to have writer lock.
>
> Oops, it is an actual bug, right?

Why?

So far I don't understand this change. Quite possibly I missed something,
but in this case the changelog should explain the problem more clearly.

Oleg.


