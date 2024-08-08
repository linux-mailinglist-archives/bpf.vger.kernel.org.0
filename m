Return-Path: <bpf+bounces-36682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E88D94BEA7
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 15:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A51282A30
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173B218E056;
	Thu,  8 Aug 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjdkhrMH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2956418E047
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124424; cv=none; b=JolgwFfnQ0DvnE5C+gbPfK3PUWai3BizTNeVPJggig/F9rWlecyybvGCFL6rRiB18tqqqyaUlPgNskPPiy4N9PjH3ztllbT2EjfFmVxBBXLMC7kzafodCaANbVS34ECnyso4O5G4IwLkX1/C0+yL9YTQ9dAw5kTgF3bLhzd8Vo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124424; c=relaxed/simple;
	bh=E7qPM6Za/OUweacjnMkcLSYOGg27RehJJPlMm6etOas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR+MRWPyuAFlkX90Tl2XzEuL0KhDgEpTxATWd47ehLOvwZklu81LUvdhCQa0nHsy0JNS9A+jA1zydGHq9diKYNKWpJDvFck9y3Ikhd+rb6ZXETZExwuI4bMNA932J9rITMm62TihEr8RzvvsBdCaVzPrgELKojazuTbFQIOyS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjdkhrMH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723124422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BzXJpaP0eGm9JAF0HD6UstKeBReW0UlULvpo8rzaNMQ=;
	b=EjdkhrMHj0JBdEq9B61aSk9FO9r3RPbz4SIIsGl7watv3LPZJp3TcgnvCK299EnVt9ZyrV
	JClGp4lqwtRDZIwWPP9zX3MhCkPkYA8jvRPyJe2qzet1JhtFTsmWizhOMOFAA9iPM7jYHR
	O76w+G09gDDVJywzGyhWrk/hN58TzFI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-qdhrjKtiPpmbMdJcVjijYQ-1; Thu,
 08 Aug 2024 09:40:15 -0400
X-MC-Unique: qdhrjKtiPpmbMdJcVjijYQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAE361955BCF;
	Thu,  8 Aug 2024 13:40:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 27C9919560A3;
	Thu,  8 Aug 2024 13:40:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Aug 2024 15:40:12 +0200 (CEST)
Date: Thu, 8 Aug 2024 15:40:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 7/8] uprobes: perform lockless SRCU-protected
 uprobes_tree lookup
Message-ID: <20240808134007.GE8020@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-8-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731214256.3588718-8-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/31, Andrii Nakryiko wrote:
>
>  static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
> +static seqcount_rwlock_t uprobes_seqcount = SEQCNT_RWLOCK_ZERO(uprobes_seqcount, &uprobes_treelock);

Just noticed... Why seqcount_rwlock_t?

find_uprobe_rcu() doesn't use read_seqbegin_or_lock(),
seqcount_t should work just fine.

Oleg.


