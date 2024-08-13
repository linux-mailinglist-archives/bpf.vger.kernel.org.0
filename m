Return-Path: <bpf+bounces-37051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5139995094C
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 17:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C773CB259E3
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8380A1A08A6;
	Tue, 13 Aug 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+pOgavc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DDE1A071B
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563681; cv=none; b=hkk9DvbebAzX+O/x6SBXb0U5PuUdZvSLoGNou4K9xtpxj+eKq6sfr5/P8zEN8ZACYzSKVyPoeJM9G3LNjRkb4SNshg2BqVKstw3jDahDk5iJ7fmjdjCfU/LSujOOrVVf1NLuPcLsomvNIocymZSr2Gpdn3g04tdNsFtTd05L0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563681; c=relaxed/simple;
	bh=Npyy2Bd+ANW37v8ollyt7u2h4ZMhRX+VULG33NNi4Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZ0/CvdqFBc7F9Wizn6DTJWu9blqiFXC/fXo1tR0IhFfP+9qAgoBqMJKdEkTHltI+YWuRNTxjigdmFhSVf3GGnV6cPOOB/h9Ec4SqHy3W77r0IDmBDFi1EKxoAyFkNfiur4zpU2GN6YXOvbVgP0PleUuxGAYRS1kPv1bneSMo6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+pOgavc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723563678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0JBUuzCdLskAMLnZ7TZEmC1cmMuQ9jRqzKUNexZqpes=;
	b=e+pOgavcnD+aKXpZeaKAreWT0B5KJkEYo6JbKeo1+dfQyiVrELmMR6vPzRmc2subFR4Q33
	nbTOGUOfKSI/ZCatRrQoz4m3x5n8MCgyNMHqfvOjWmBTiX2rU7vBokU7E7xzY5Ozfpe1i+
	6wes8qaBUPxrlPCFEbLi4UCyGFNLQGA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-Oarm0UZlP_2nRYRsnwOTjw-1; Tue,
 13 Aug 2024 11:41:13 -0400
X-MC-Unique: Oarm0UZlP_2nRYRsnwOTjw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A50EA18EA948;
	Tue, 13 Aug 2024 15:41:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7BB8F300019C;
	Tue, 13 Aug 2024 15:41:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 13 Aug 2024 17:41:08 +0200 (CEST)
Date: Tue, 13 Aug 2024 17:41:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, peterz@infradead.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH v2] uprobes: make trace_uprobe->nhit counter a per-CPU one
Message-ID: <20240813154055.GA7423@redhat.com>
References: <20240809192357.4061484-1-andrii@kernel.org>
 <20240813223014.1a5093ede1a5046aaedea34a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813223014.1a5093ede1a5046aaedea34a@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/13, Masami Hiramatsu wrote:
>
> > @@ -62,7 +63,7 @@ struct trace_uprobe {
> >  	struct uprobe			*uprobe;
>
> BTW, what is this change? I couldn't cleanly apply this to the v6.11-rc3.
> Which tree would you working on? (I missed something?)

tip/perf/core

See https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/diff/kernel/trace/trace_uprobe.c?h=perf/core&id=3c83a9ad0295eb63bdeb81d821b8c3b9417fbcac

Oleg.


