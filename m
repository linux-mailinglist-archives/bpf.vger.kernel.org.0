Return-Path: <bpf+bounces-33085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D9B9170EB
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 21:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F451C21BB2
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF317C9F7;
	Tue, 25 Jun 2024 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7QFcpsB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E498217C7D8
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342576; cv=none; b=CRFto5oHQgRFDW2RLiVeTX8RCh/KA4Ro8qTxXjzrSbou7SdPLal7iA9iIEUdB8oKXJSmh8Erderz+NeXSIqbXFwIzFHwJWq3Y3MDiiMKEvqp0+ZUaoclmVY1C+OEwK6AcxMwrBOC2p9Gb46lgmhIWHbXD0bW7lrf0ErfpGccZ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342576; c=relaxed/simple;
	bh=z2BF7Ex61wpNnq5ogD2hlatbhnnMKfD3kRXDdGwaiuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwsxWXRaydYo3ZRN+qJAowF+nWZ1U9ILQxGFMdyryFcogDFxix3A4KWdsZZc2vaD07g38fkt7CMqSmBbDz+RuTEvGXs8mETsiTSawrvLIxAmqH7qPOyPpNOoB8+ZXfmRCinYnfsrtFsEdvB6X+6izPWlZIfuchrwSWcRrye//pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7QFcpsB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719342574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2BF7Ex61wpNnq5ogD2hlatbhnnMKfD3kRXDdGwaiuw=;
	b=f7QFcpsBDlGwEUIEgvgZ8v362hEl2KkP6v1y+TAilzWM52NpOOWR6nQ7HNdJ+XtlO1JIBa
	i24uK1hcVk4WMcUAiFlLxIOjU+er27S4v4CWb9m6+apfF5mhzv+HWOvQ2EejXZvMF/BSSS
	I8YiriEY8uDPMxy743ATyM0KjpDF/2k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-d3gYip-ROHe2P-5QokYUCw-1; Tue,
 25 Jun 2024 15:09:29 -0400
X-MC-Unique: d3gYip-ROHe2P-5QokYUCw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D22A1956087;
	Tue, 25 Jun 2024 19:09:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.198])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 88B5919560BF;
	Tue, 25 Jun 2024 19:09:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Jun 2024 21:07:54 +0200 (CEST)
Date: Tue, 25 Jun 2024 21:07:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	peterz@infradead.org, mingo@redhat.com, bpf@vger.kernel.org,
	jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH 02/12] uprobes: grab write mmap lock in unapply_uprobe()
Message-ID: <20240625190748.GC14254@redhat.com>
References: <20240625002144.3485799-1-andrii@kernel.org>
 <20240625002144.3485799-3-andrii@kernel.org>
 <20240625102925.665f2fa3b39dc7602b1321d8@kernel.org>
 <20240625144952.GA21558@redhat.com>
 <CAEf4BzZqGNVqAmk_wrGP+MmxQidEr4=FdYiYpodpRd1TAib81A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZqGNVqAmk_wrGP+MmxQidEr4=FdYiYpodpRd1TAib81A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/25, Andrii Nakryiko wrote:
>
> On Tue, Jun 25, 2024 at 7:51 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Why?
> >
> > So far I don't understand this change. Quite possibly I missed something,
> > but in this case the changelog should explain the problem more clearly.
> >
>
> I just went off of "Called with mm->mmap_lock held for write." comment
> in uprobe_write_opcode(), tbh.

Ah, indeed... and git blame makes me sad ;)

I _think_ that 29dedee0e693a updated this comment without any thinking,
but today I can't recall. In any case, today this nothing to do with
mem_cgroup_charge(). Not sure __replace_page() is correct (in this respect)
when it returns -EAGAIN but this is another story.

> If we don't actually need writer
> mmap_lock, we should probably update at least that comment.

Agreed.

> There is a
> lot going on in uprobe_write_opcode(), and I don't understand all the
> requirements there.

Heh. Neither me today ;)

Oleg.


