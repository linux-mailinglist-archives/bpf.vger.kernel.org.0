Return-Path: <bpf+bounces-38813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B5296A66C
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FC01C23E1B
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D99191F68;
	Tue,  3 Sep 2024 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdryD0+n"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B95B1917EF
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387952; cv=none; b=NPv/jN2dU1XmvEy06l0w+UMSCiHFE7Jk+8u5x/t0KlwpFGujCirG5+9OWzJfgBWvVdFqWR4eiqLMCHYJbIy1vNKCzCjDlZnP+22L01SYBe7/D2kgJly2WyWKc5V6QkRhif4+9RT1h/M65C9ywmkT6n1qkq0fAHZaMs9SFgA1QTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387952; c=relaxed/simple;
	bh=hJS6EaFB6prKGPaSLYwj+YKNJglp4aYVfW5lYICPAgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9TM5z+e1zbHOd41A9G2AOs7jt7EWSni6KawPjyfX6C8G9nhwyWrUuAyQ1Oxc5x8rVjREvIQtB7ZDsw3CdORiu40wcoV7dxag7hLPMXNgrF/CrTRLe7ws++2fL92YFJy02YreenzvtgY8911iTWHYDNhfMlRWQd4pYUNTrVwEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RdryD0+n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725387948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJS6EaFB6prKGPaSLYwj+YKNJglp4aYVfW5lYICPAgk=;
	b=RdryD0+n5hu8t1ig0fp6Q1xQOvoD0mOlpQyVTrvp9w5ThA5Ei4sKH1iFvEEzSXdpMP9w6z
	PBdBfALCcf0dB7iiTFodBB42UY63ehMvYhqQYfDGWyX9VXsgaUYEFQm5VX2Oo16f6/gABr
	oe0HVkVUobFUEgjnokWdNISizC6hBlo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-OZYe8k1LP0ezeXn8VZ0taw-1; Tue,
 03 Sep 2024 14:25:41 -0400
X-MC-Unique: OZYe8k1LP0ezeXn8VZ0taw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CAB919560B4;
	Tue,  3 Sep 2024 18:25:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.38])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 801FE19560AE;
	Tue,  3 Sep 2024 18:25:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  3 Sep 2024 20:25:29 +0200 (CEST)
Date: Tue, 3 Sep 2024 20:25:23 +0200
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
Message-ID: <20240903182523.GH17936@redhat.com>
References: <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava>
 <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
 <ZtHM_C1NmDSKL0pi@krava>
 <20240830143151.GC20163@redhat.com>
 <CAEf4BzbOjB9Str9-ea6pa46sRDdHJF5mb0rj1dyJquvBT-9vnw@mail.gmail.com>
 <20240830202050.GA7440@redhat.com>
 <CAEf4BzZCrchQCOPv9ToUy8coS4q6LjoLUB_c6E6cvPPquR035Q@mail.gmail.com>
 <20240831161914.GA9683@redhat.com>
 <CAEf4BzYE7+YgM7HMb-JceoC33f=irjHkj=5x46WaXdCcgTk4xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYE7+YgM7HMb-JceoC33f=irjHkj=5x46WaXdCcgTk4xg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/03, Andrii Nakryiko wrote:
>
> On Sat, Aug 31, 2024 at 9:19 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > I was thinking about another seq counter incremented in register(), so
> > that handler_chain() can detect the race with uprobe_register() and skip
> > unapply_uprobe() in this case. This is what Peter did in one of his series.
> > Still changes the current behaviour, but not too much.
>
> We could do that, but then worst case, when we do detect registration
> race, what do we do?

Do nothing and skip unapply_uprobe().

> But as you said, this all can/should be addressed as a follow up
> discussion.

Yes, yes,

> You mentioned some clean ups you wanted to do, let's
> discuss all that as part of that?

Yes, sure.

And please note that in reply to myself I also mentioned that I am stupid
and these cleanups can't help to change/improve this behaviour ;)

> > The only in-kernel user of UPROBE_HANDLER_REMOVE is perf, and it is fine.
> >
>
> Well, BPF program can accidentally trigger this as well, but that's a
> bug, we should fix it ASAP in the bpf tree.

not sure, but...

> > And in general, this change makes the API less "flexible".
>
> it maybe makes a weird and too-flexible case a bit more work to
> implement. Because if consumer want to be that flexible, they can
> still define filter that will be coordinated between filter() and
> handler() implementation.

perhaps, but lets discuss this later, on top of your series.

> > But once again, I agree that it would be better to apply your series first,
> > then add the fixes in (unlikely) case it breaks something.
>
> Yep, agreed, thanks! Will send a new version ASAP, so we have a common
> base to work on top of.

Thanks. Hopefully Peter will queue your V5 soon.

Oleg.


