Return-Path: <bpf+bounces-38595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3E6966A59
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12E81C21A89
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 20:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0B41BFDEB;
	Fri, 30 Aug 2024 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC+xa4pV"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AF71BF7FD
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049277; cv=none; b=dxuG+gN1TgfwhES6Z2Z7HhQiLyXX1VxgmxN93ynb5+uWJfpGI1wJHZ04481r6t0ftGSu/e9jfxTFPNCAPa4B9zXVpvqKFs0eLYOPsxfAz7Q4O8qo0b8znCKuqurmOWqVOG9JefywVUf7TMQSO7/xTvZPPrL/9A6YCcnAGaQ3Nzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049277; c=relaxed/simple;
	bh=tlG9Z3SWZS45Au6orXQjCifgDXL/6bzfSjTyzN+bf2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYS/aw+/iaCiLqjavl9YLNw/0krXzJFatncRwpItjPmwCTRTDoyhOF87Ygtz4uLMAcrXjC3PvJS6DRQjjs+x1zNbBWnjAXIJP6GXn7bfQPkpP1uwPGpZ8yyBdQimLa6oSQAcaXUERIOxXIfI/jtc1/2LhNU8pTGbG6JT+TDlFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DC+xa4pV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725049274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlG9Z3SWZS45Au6orXQjCifgDXL/6bzfSjTyzN+bf2c=;
	b=DC+xa4pVYRGaqwy8i8gvwuKgdqnAQDnF3HlOIt82y2VD2RYFOe9FY+pzMLYSZSx5lv3BbO
	Ii9ORby8V/2i5+8cnMOkn9kWiLA4dBSDzc22/VrzVFq0NXLI1Dn7MKNGU28hDu2NNcbF+4
	G67+iSwyxjjnIZAcmL10RHdGz67aYsI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-H6sJ7imwP5qkwnjaTwy5Iw-1; Fri,
 30 Aug 2024 16:21:08 -0400
X-MC-Unique: H6sJ7imwP5qkwnjaTwy5Iw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA2AB19560A6;
	Fri, 30 Aug 2024 20:21:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.148])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 02C8119560A3;
	Fri, 30 Aug 2024 20:20:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 30 Aug 2024 22:20:57 +0200 (CEST)
Date: Fri, 30 Aug 2024 22:20:50 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <20240830202050.GA7440@redhat.com>
References: <20240829183741.3331213-1-andrii@kernel.org>
 <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava>
 <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
 <ZtHM_C1NmDSKL0pi@krava>
 <20240830143151.GC20163@redhat.com>
 <CAEf4BzbOjB9Str9-ea6pa46sRDdHJF5mb0rj1dyJquvBT-9vnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbOjB9Str9-ea6pa46sRDdHJF5mb0rj1dyJquvBT-9vnw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/30, Andrii Nakryiko wrote:
>

Andrii, let me reply to your email "out of order". First of all:

> Can we please let me land these patches first? It's been a while. I
> don't think anything is really broken with the logic.

OK, agreed.

I'll probably write another email (too late for me today), but I agree
that "avoid register_rwsem in handler_chain" is obviously a good goal,
lets discuss the possible cleanups or even fixlets later, when this
series is already applied.



> On Fri, Aug 30, 2024 at 7:33 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > No, I think you found a problem. UPROBE_HANDLER_REMOVE can be lost if
> > uc->filter == NULL of if it returns true. See another reply I sent a
> > minute ago.
> >
>
> For better or worse, but I think there is (or has to be) and implicit
> contract that if uprobe (or uretprobe for that matter as well, but
> that's a separate issue) handler can return UPROBE_HANDLER_REMOVE,
> then it *has to* also provide filter.

IOW, uc->handler and uc->filter must be consistent. But the current API
doesn't require this contract, so this patch adds a difference which I
didn't notice when I reviewed this change.

(In fact I noticed the difference, but I thought that it should be fine).

> If it doesn't provide filter
> callback, it doesn't care about PID filtering and thus can't and
> shouldn't cause unregistration.

At first glance I disagree, but see above.

> > I think the fix is simple, plus we need to cleanup this logic anyway,
> > I'll try to send some code on Monday.

Damn I am stupid. Nothing new ;) The "simple" fix I had in mind can't work.
But we can do other things which we can discuss later.

Oleg.


