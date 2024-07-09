Return-Path: <bpf+bounces-34303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD9492C558
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50183B21501
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 21:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E595182A45;
	Tue,  9 Jul 2024 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUYmhNo6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B11B86D4
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560809; cv=none; b=WQqeJpaBQQAml1Bod7YetMpSu+DvcT7dCpfzjud+aXMGb74S6+0SFNTaX6XYjkmzcs+t3WgWpsmP3KtCyi5GaztmVLSnbkEm8+GfZVKk4Dq2G3jhb2m1cj4xKYFVIihyIms7J08An/bjUicpvj+7gCbg3l+/7Eyl7ba2bZzga08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560809; c=relaxed/simple;
	bh=NhqgCMPXWxlvbk1mFCgpxvPZzmPnVSOZnFqFzWoQ/k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9p4X39SkqpOfw0YpuqmLQoNQoYUz29q9PsoIBYoc+AxYox7cAOQBD6A7a9IhUx1aihbz4MIfh5Mwr2kJuHzz5YzJq344wAVtclLkhimeNGz+V5MXpwOS8ehfuOMla8GJxRcABhHgbhmh1l8d6u9UMt8bTjD/rcHFnA7pHKLFec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUYmhNo6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720560807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhqgCMPXWxlvbk1mFCgpxvPZzmPnVSOZnFqFzWoQ/k4=;
	b=fUYmhNo6en1T4Yzk3/4rvlQUbAJ4/FXdJtYa+188R8pCkbY/2Ze8rjuI4N9ylmyRqpfAT9
	MCIJcdP+anJKpnDHwsGJYf63R5zUmHROktCQHgAL2QVfEHwpuap/jjQj8TDN8pSiU73O2v
	+9jjYfaonOAoXjIzIwtJo7rsRzXfEcI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-Vg5wCabsOAyyQk7Pn_0LcA-1; Tue,
 09 Jul 2024 17:33:21 -0400
X-MC-Unique: Vg5wCabsOAyyQk7Pn_0LcA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0812E195420F;
	Tue,  9 Jul 2024 21:33:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D5D7019560AE;
	Tue,  9 Jul 2024 21:33:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  9 Jul 2024 23:31:42 +0200 (CEST)
Date: Tue, 9 Jul 2024 23:31:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org,
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240709211642.GA6162@redhat.com>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-5-andrii@kernel.org>
 <20240705153705.GA18551@redhat.com>
 <20240707144653.GB11914@redhat.com>
 <CAEf4BzYZCVNFQcVBPue4uom+StiCQA6ObR7Z-sKzcEZyTiSyRA@mail.gmail.com>
 <20240709184754.GA3892@redhat.com>
 <CAEf4BzZFJ-fQRJELsCYRjdPg8ezQwOOEhHbF9Nb5=4e8WE9bzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZFJ-fQRJELsCYRjdPg8ezQwOOEhHbF9Nb5=4e8WE9bzQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/09, Andrii Nakryiko wrote:
>
> On Tue, Jul 9, 2024 at 11:49 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > Yep, that would be unfortunate (just like SIGILL sent when uretprobe
> > > detects "improper" stack pointer progression, for example),
> >
> > In this case we a) assume that user-space tries to fool the kernel and
>
> Well, it's a bad assumption. User space might just be using fibers and
> managing its own stack.

Do you mean something like the "go" language?

Yes, not supported. And from the kernel perspective it still looks as if
user-space tries to fool the kernel. I mean, if you insert a ret-probe,
the kernel assumes that it "owns" the stack, if nothing else the kernel
has to change the ret-address on stack.

I agree, this is not good. But again, what else the kernel can do in
this case?

> > Not really expected, and that is why the "TODO" comment in _unregister()
> > was never implemented. Although the real reason is that we are lazy ;)
>
> Worked fine for 10+ years, which says something ;)

Or may be it doesn't but we do not know because this code doesn't do
uprobe_warn() ;)

Oleg.


