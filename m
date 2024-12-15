Return-Path: <bpf+bounces-46998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA18D9F2459
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 15:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7BA418867F0
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 14:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D35C191F7C;
	Sun, 15 Dec 2024 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahDAvOwx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4E189905
	for <bpf@vger.kernel.org>; Sun, 15 Dec 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734272095; cv=none; b=drZk7HeaMbJvc+2lZCN4MnTs0PKWU+80QRHCO48vtbtFUVLy57RFPzVfgjBAjd+JUwuBvoo+RoJHlMm36eL0oLELUF3gGBSR2l66ATbimlT14vvQX5n8Z3ssHwZXrRkB10/Y+2/Tg/A8lP4xlg9NgfrHrHebG4jBQ5iKJlBvo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734272095; c=relaxed/simple;
	bh=a53vNz4PUMmhwfydX5urPkZUSvWv4tcg1WmTFyd1Bk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5tW2fuRJnaGUGljGubUqYtGyPvBMG8J85W12ROn5KQUNl0pYNz+X3ZT1S5/VwjjOfBmAHVlOm1S1R5DF/qEwvEsK/GWM3l464KePEix1m8NowVpIA4FFy1napKm2E2FavsAUhzpeP5m00UnLprCY2w8lQB9a9x0ww8D+3cBgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahDAvOwx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734272091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W3bWsES4HYFomsBdw8ix9WcXokymLmLN9+uEpumIVv4=;
	b=ahDAvOwxTWmBDOmDRYC/xsWFOjTRU5ng6ETmU4EVynvNfrRVyTHUnumU5HVq35F2unJkEW
	9g+SfljyEOICaXR/IL/a59hSSvAH3NQRN5UKHMIj9Hsp/16uu9E5acEwzP+BS47PFZu+o3
	v+4+83NuOVkOomktDDrme6BEV8GE5Ow=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-Ls14WX__PYqYc-D7LfhNYw-1; Sun,
 15 Dec 2024 09:14:45 -0500
X-MC-Unique: Ls14WX__PYqYc-D7LfhNYw-1
X-Mimecast-MFC-AGG-ID: Ls14WX__PYqYc-D7LfhNYw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 933201956089;
	Sun, 15 Dec 2024 14:14:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 295B630044C1;
	Sun, 15 Dec 2024 14:14:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 15 Dec 2024 15:14:19 +0100 (CET)
Date: Sun, 15 Dec 2024 15:14:13 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Jiri Olsa' <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <20241215141412.GA13580@redhat.com>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-9-jolsa@kernel.org>
 <1521ff93bc0649b0aade9cfc444929ca@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521ff93bc0649b0aade9cfc444929ca@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 12/15, David Laight wrote:
>
> From: Jiri Olsa
> > The optimized uprobe path
> >
> >   - checks the original instruction is 5-byte nop (plus other checks)
> >   - adds (or uses existing) user space trampoline and overwrites original
> >     instruction (5-byte nop) with call to user space trampoline
> >   - the user space trampoline executes uprobe syscall that calls related uprobe
> >     consumers
> >   - trampoline returns back to next instruction
> ...
>
> How on earth can you safely overwrite a randomly aligned 5 byte instruction
> that might be being prefetched and executed by another thread of the
> same process.

uprobe_write_opcode() doesn't overwrite the instruction in place.

It creates the new page with the same content, overwrites the probed insn in
that page, then calls __replace_page().

Oleg.


