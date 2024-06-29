Return-Path: <bpf+bounces-33430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA2991CD4F
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 15:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A825C2836AE
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EFA81AB6;
	Sat, 29 Jun 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNoEC7El"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B7080BEE
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719668448; cv=none; b=UPHeOwYgE3P56ZoqV9kaa88p8x08EM5fcHx5luNCRt4iLhKbhnEaIv9KItUbD/kLwAiLHoWTw0QwViI70fpWoxtLCRyFJJ6If6uT8GpvU/iR2Vv3YAoJgarMJq9QlX5B7FS8gfZ3sgFzZNmWIzha/fiVdaMCYHaZI294qPlau7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719668448; c=relaxed/simple;
	bh=TsD41L2f2VKq34Ph7lBOtRyiHdK+mQQb4xF8FjIP0iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAFhC6DNoTSalikP19Bm4VcunnlnAJKh82lhMGQykB5GBWDjEVxZRfE3fG7C1BltI3j3a2Ebz9IYJRJsjq7cwNUbvqDdPjWCemkzrKpEH7JYfD1FtaGBYa9Z8aaXRVqfxg/HHxsfUJmOQSeTlZrg5uOgvKptUKAvEexKxWrf1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNoEC7El; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719668445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsD41L2f2VKq34Ph7lBOtRyiHdK+mQQb4xF8FjIP0iU=;
	b=gNoEC7Eliv5Sfn1oFykhoQzKqNjrfM6Gi/p40qMi2EA3al98EiSxrsYBfTnDLcUNLvNYsk
	lLPjwTAApH7y1UMmnFr1fG/QC7EatSnpJZ3+xL/wZD3tWbC8B/4kXj/I+UgxWfUqut4zXW
	TPZGarXKTUQRpe1ivXUdOndegQbJlvw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-sgm5t3g6P3mMyhjci7Oh7Q-1; Sat,
 29 Jun 2024 09:40:34 -0400
X-MC-Unique: sgm5t3g6P3mMyhjci7Oh7Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43AD11956087;
	Sat, 29 Jun 2024 13:40:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.39.192.76])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 452B219560A3;
	Sat, 29 Jun 2024 13:40:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 29 Jun 2024 15:38:55 +0200 (CEST)
Date: Sat, 29 Jun 2024 15:38:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: andrii.nakryiko@gmail.com, andrii@kernel.org, bpf@vger.kernel.org,
	chenhuacai@kernel.org, jolsa@kernel.org, kernel@xen0n.name,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, mhiramat@kernel.org, nathan@kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH] LoongArch: uprobes: make
 UPROBE_SWBP_INSN/UPROBE_XOLBP_INSN constant
Message-ID: <20240629133747.GA4504@redhat.com>
References: <20240627173806.GC21813@redhat.com>
 <37f79351-a051-3fa9-7bfb-960fb2762e27@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f79351-a051-3fa9-7bfb-960fb2762e27@loongson.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 06/29, Tiezhu Yang wrote:
>
> On Thu, 27 Jun 2024 19:38:06 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> ...
>
> > > > +arch_initcall(check_emit_break);
> > > > +
> > >
> > > I wouldn't even bother with this, but whatever.
> >
> > Agreed, this looks a bit ugly. I did this only because I can not test
> > this (hopefully trivial) patch and the maintainers didn't reply.
>
> The LoongArch maintainer Huacai told me offline to reply this thread today.
>
> > If LoongArch boots at least once with this change, this run-time check
> > can be removed.
>
> I will test it next Monday.

Thanks!

> > And just in case... I didn't dare to make a more "generic" change, but
> > perhaps KPROBE_BP_INSN and KPROBE_SSTEPBP_INSN should be redefined the
> > same way for micro-optimization. In this case __emit_break() should be
> > probably moved into arch/loongarch/include/asm/inst.h.
>
> Yeah. I think so too.

OK... should I send v2? Or another change which does this on top of this
patch? Or will you do it yourself?

>
> Thanks,
> Tiezhu
>


