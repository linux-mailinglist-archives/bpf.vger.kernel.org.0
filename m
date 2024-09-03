Return-Path: <bpf+bounces-38815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 002A696A678
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334E11C240EB
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2931917E8;
	Tue,  3 Sep 2024 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnMPxhYx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2801917CD
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388068; cv=none; b=AQthPCAObw9jccDkrCnEl/5qZhgSh2m0xrR9RBx2Haty3GlyZuKpsCvjoRXWZZHT8iQq8faM6YXdGqghVS4S3JShRkJ35dZNQ79JgVZqHn6a1+5VxPRw1/wrukvtRghrm83n0BiIz902vD+IBE3f8tPD7/BjmDRV7JaMSl14PZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388068; c=relaxed/simple;
	bh=bYoFUSBYagYM9vX6vLnvOKFtHmjQk8YSVP8bS/GZm3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBeJbcYEm3MgGfZNZhcZT67dOXK4UrhmoXl2jvBY6ZHCQ4NPTgas5mFNwMMqpMsfBOG99m8Lv5eWbJhI2x00l7xfNH9Xkxdg88HuHtlj2VvgpdD41CulZZZlSl0vpC07cgScrVUnk8vyv3oQTNTWDrmEam+qRc8gw0P7T4E7R7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnMPxhYx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725388066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d24OUKgm5JQW5fQKGEQedXZHagzGyggF2Py5ZgqPqAo=;
	b=XnMPxhYxo1gsqrUkIBV++Aojxl7liRmg9Gx4nEV4BsGoDsQzWytiklO4Z0Bc/MD8TiWYD2
	SWZE10itSTLKxLzkwx5n373PKNfrlqE59oNq3CWIehkEgP6fjwLznZElThB7xQ6JLEte5K
	AWs61ugJZoUQQWCR7Tf19mpBciYQjJg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-LGAj98RNPu67JNz6csa9dA-1; Tue,
 03 Sep 2024 14:27:43 -0400
X-MC-Unique: LGAj98RNPu67JNz6csa9dA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 017141955BEF;
	Tue,  3 Sep 2024 18:27:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BB47C30001A4;
	Tue,  3 Sep 2024 18:27:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  3 Sep 2024 20:27:31 +0200 (CEST)
Date: Tue, 3 Sep 2024 20:27:24 +0200
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
Message-ID: <20240903182724.GI17936@redhat.com>
References: <ZtD_x9zxLjyhS37Z@krava>
 <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
 <ZtHM_C1NmDSKL0pi@krava>
 <20240830143151.GC20163@redhat.com>
 <CAEf4BzbOjB9Str9-ea6pa46sRDdHJF5mb0rj1dyJquvBT-9vnw@mail.gmail.com>
 <20240830202050.GA7440@redhat.com>
 <CAEf4BzZCrchQCOPv9ToUy8coS4q6LjoLUB_c6E6cvPPquR035Q@mail.gmail.com>
 <20240831161914.GA9683@redhat.com>
 <CAEf4BzYE7+YgM7HMb-JceoC33f=irjHkj=5x46WaXdCcgTk4xg@mail.gmail.com>
 <CAEf4Bza6SRP0ZTuOa=W8W3uM86DJKkGoTQ9itHxcdGWt1Su=-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza6SRP0ZTuOa=W8W3uM86DJKkGoTQ9itHxcdGWt1Su=-Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/03, Andrii Nakryiko wrote:
>
> On Tue, Sep 3, 2024 at 10:27 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Aug 31, 2024 at 9:19 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > But. Since you are going to send another version, may I ask you to add a
> > > note into the changelog to explain that this patch assumes (and enforces)
> > > the rule about handler/filter consistency?
> >
> > Yep, will do. I will also leave a comment next to the filter callback
> > definition in uprobe_consumer about this.
> >
>
> Ok, I'm adding this:
>
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 29c935b0d504..33236d689d60 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -29,6 +29,14 @@ struct page;
>  #define MAX_URETPROBE_DEPTH            64
> 
>  struct uprobe_consumer {
> +       /*
> +        * handler() can return UPROBE_HANDLER_REMOVE to signal the need to
> +        * unregister uprobe for current process. If UPROBE_HANDLER_REMOVE is
> +        * returned, filter() callback has to be implemented as well and it
> +        * should return false to "confirm" the decision to uninstall uprobe
> +        * for the current process. If filter() is omitted or returns true,
> +        * UPROBE_HANDLER_REMOVE is effectively ignored.
> +        */

Thanks, LGTM.

Oleg.


