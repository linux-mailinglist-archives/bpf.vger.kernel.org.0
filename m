Return-Path: <bpf+bounces-36588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C8794AEAE
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F9B1C21763
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55C313C9CF;
	Wed,  7 Aug 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBgy/xBo"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9B713B59E
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050689; cv=none; b=E8Tu+t1HSZBkD/nQcFwEJWPDBSMhblbGCGOq+LUHpRtczBvsYnBZSLCmyoxphpK3FqcJy04q7THmhQ98EH0gkRUGKXDj4Ht13azK1cFJpdpR2dCnNsB0UnQOn6AUblAtan2hTb7QfV2h0JeHcOlgR7JCwR9j+7Qv412Z0U4jn7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050689; c=relaxed/simple;
	bh=KvEjb23X87A6JzXK9BKvxQ/d0z1ZHIL3IyVVU+EyAMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCVOBPQqyLIPzSHF7PKXirt8WqRwfHjcGJ7DhUeuj7fpNgH/5FlEv1tR6Y+LOsUF+2xl8rRv9ojOwfA42x5wfiWJLR4im6gyZIglg4nseHFXvO5oFKyYT7/F2wPY4U2XnVGC9dCH2RM4N4jXuoLx0EJxK/vmv2R9Z4jIzPN020c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBgy/xBo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723050686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KvEjb23X87A6JzXK9BKvxQ/d0z1ZHIL3IyVVU+EyAMA=;
	b=RBgy/xBo8KCVXDAymK5hg2i1IjgdN/69pJoBz/H4GJf07HzP/yTvXexLxZ0sfEK6MkoIth
	F5S9zEFDbupKGcBwG9oYxT6HbHAaAKWbkqSImKRXKcME/0rXZ9+ug3IMC8kA10I4MxEc0P
	PCdELgJ5sdJuwRcOMsIvBOPLRr4ZsiE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-ZUSnP5WfM2GTQj0wfKTwXw-1; Wed,
 07 Aug 2024 13:11:21 -0400
X-MC-Unique: ZUSnP5WfM2GTQj0wfKTwXw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 168071944B25;
	Wed,  7 Aug 2024 17:11:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.97])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 47D2B19560A3;
	Wed,  7 Aug 2024 17:11:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  7 Aug 2024 19:11:18 +0200 (CEST)
Date: Wed, 7 Aug 2024 19:11:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 0/8] uprobes: RCU-protected hot path optimizations
Message-ID: <20240807171113.GD27715@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240807132922.GC27715@redhat.com>
 <CAEf4BzZSyuFexZfwZs1bA9S=O0FHejw_tE6PXm5h8ftMsuSROw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZSyuFexZfwZs1bA9S=O0FHejw_tE6PXm5h8ftMsuSROw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/07, Andrii Nakryiko wrote:
>
> Yes, I was waiting for more of Peter's comments, but I guess I'll just
> send a v2 today.

OK,

> I'll probably include the SRCU+timeout logic for
> return_instances, and maybe lockless VMA parts as well.

Well, feel free to do what you think right, but perhaps it would be
better to push this series first? at least 1-4.

As for lockless VMA. To me this needs more discussions. I didn't read
your conversation with Peter and Suren carefully, but I too have some
concerns. Most probably I am wrong, and until I saw this thread I didn't
even know that vm_area_free() uses call_rcu() if CONFIG_PER_VMA_LOCK,
but still.

> > As for 8/8 - I leave it to you and Peter. I'd prefer SRCU though ;)
>
> Honestly curious, why the preference?

Well, you can safely ignore me, but since you have asked ;)

I understand what SRCU does, and years ago I even understood (I hope)
the implementation. More or less the same for rcu_tasks. But as for
the _trace flavour, I simply fail to understand its semantics.

> BTW, while you are here :) What can you say about
> current->sighand->siglock use in handle_singlestep()?

It should die, and this looks simple. I disagree with the patches
from Liao, see the
https://lore.kernel.org/all/20240801082407.1618451-1-liaochang1@huawei.com/
thread, but I agree with the intent.

IMO, we need a simple "bool restore_sigpending" in uprobe_task, it will make the
necessary changes really simple.

(To clarify. In fact I think that a new TIF_ or even PF_ flag makes more sense,
 afaics it can have more users. But I don't think that uprobes can provide enough
 justification for that right now)

Oleg.


