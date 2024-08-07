Return-Path: <bpf+bounces-36576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D3094A89F
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 15:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82DD1F216C4
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377591E4857;
	Wed,  7 Aug 2024 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQH+DZ/9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FAA17AE12
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037416; cv=none; b=ATGIog5LP4TyFHUZeAQ60m/1NIqqU54/I/FSjJLedfTDNyR5Z7da4ycZwfxIumxGf2zlvtgV0/UoG9EJXSAAbzyH/MdJgCd89EtkhxMgjDomm/tHJx+Yod7lgSBSGjz1vaAkMnZRCKijwj6kSiJLS3xJ2HM15D6qi09TJ/3DAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037416; c=relaxed/simple;
	bh=2eRPKEFxxIXDo90EmVtlG5x4oYNEUjacrR24ctzOsA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIX1iAnCxyqeM08vhrXAOe7nI7wJWdvfxZjo/GiVbxBiJhGX5/G5rl9Q5kk8R26dC9UeF6UdtLZ6eCTZZeH/rQyj86A49rPJb3/z+DLmXAhX5vDmYuHxI62w69RkCdeRiXD7lFnP+ynSAiX65/leVYx/5YdHHGAKflUgaQH4WI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQH+DZ/9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723037414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Pw5MOqd3z8LGuMF23Tz78DSwPMjyeTrVQ5jFAuAguQ=;
	b=NQH+DZ/9imG8RhGiJwjyRovwBwuvrOgdjq8CGnGqqfGe+fYi3HPQqOQKUjVLB1cwCcUr0/
	NFdcjxUm+QMlEs/HQq0cj3q8nAcf9kSZBCIIeoXYjyME51NSnK1pNMGK/2tdj0FBE58tH/
	Guc7va2RL7F7Q4otIeypt9Al9YBvQ5c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-eAAaB6LjOfCnEp4UIRxBlQ-1; Wed,
 07 Aug 2024 09:30:10 -0400
X-MC-Unique: eAAaB6LjOfCnEp4UIRxBlQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C1721955F28;
	Wed,  7 Aug 2024 13:30:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.97])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D0FB01955BFC;
	Wed,  7 Aug 2024 13:30:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  7 Aug 2024 15:30:07 +0200 (CEST)
Date: Wed, 7 Aug 2024 15:29:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 0/8] uprobes: RCU-protected hot path optimizations
Message-ID: <20240807132922.GC27715@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731214256.3588718-1-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/31, Andrii Nakryiko wrote:
>
> Andrii Nakryiko (6):
>   uprobes: revamp uprobe refcounting and lifetime management
>   uprobes: protected uprobe lifetime with SRCU
>   uprobes: get rid of enum uprobe_filter_ctx in uprobe filter callbacks
>   uprobes: travers uprobe's consumer list locklessly under SRCU
>     protection
>   uprobes: perform lockless SRCU-protected uprobes_tree lookup
>   uprobes: switch to RCU Tasks Trace flavor for better performance
>
> Peter Zijlstra (2):
>   rbtree: provide rb_find_rcu() / rb_find_add_rcu()
>   perf/uprobe: split uprobe_unregister()

I see nothing wrong in 1-7. LGTM.

But since you are going to send the new version, I'd like to apply V2
and then try to re-check the resulting code.

As for 8/8 - I leave it to you and Peter. I'd prefer SRCU though ;)

Oleg.


