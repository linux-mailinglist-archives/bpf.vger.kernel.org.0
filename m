Return-Path: <bpf+bounces-40819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F75C98EC51
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 11:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267AC1F22E85
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0721474CF;
	Thu,  3 Oct 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKcA+jeH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A913D882
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727947983; cv=none; b=FSmfemijuJKz+21szTSRjwzoUroIA5G1oKkNF5W9cqfljQCHzZ/IwEE8jKIBpuH6kf5aYgRolQ81+LEcIxrJt0A2jjMpCpzIkeU2a7cApZnnjoTj+2WaZsIK53Lvi2q9xpPBoWWcY82Fonz/CMjkxBcpJLZImCh8oxjeekNUosw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727947983; c=relaxed/simple;
	bh=asyUiUs4l6Obu18wzSHbX0wuQi7BUxCV2FNCJSDnFd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyhEtm0klG6xOVKFZCVouk3YVUF7kHPFQG6Pj31uFjc8YjqYQcGHRoGxqnoi2XnKL02UkKGM1w1LoedUex6cbISNCPhnsI0IBD1WUWTznBpE07aLwAsx1F75f1x4WoPGGdDWNTbbUbJEMAPhCpSolXqPYBLkoehYjmRo/8CfoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKcA+jeH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727947980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K+zMxwgIWHYPuis7ae29GnRO7x5ZWg1o/g/hL8Dw+so=;
	b=BKcA+jeHxdDwhewxNhUBCJ/1EzBa6mtv8h806OhbXQIOEc2mjxA/BxGrT5iJEGftU1fk0O
	GyuFjUKbdc7xcIauJy1MVTI4o4sUQVqew+TtOTtQup/WLXq7Bhrq3/GCI6R0ggvJkqt4nK
	MrDAZBcWLBO8j5+C5QuzSj7D5ytAeqI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-AvGNL3lSNh-7JtYkcul2nw-1; Thu,
 03 Oct 2024 05:32:55 -0400
X-MC-Unique: AvGNL3lSNh-7JtYkcul2nw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B49581955D56;
	Thu,  3 Oct 2024 09:32:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.1])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 801F519560A2;
	Thu,  3 Oct 2024 09:32:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  3 Oct 2024 11:32:37 +0200 (CEST)
Date: Thu, 3 Oct 2024 11:32:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, willy@infradead.org, surenb@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com,
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org,
	vbabka@suse.cz, mingo@kernel.org
Subject: Re: [PATCH v2 tip/perf/core 5/5] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
Message-ID: <20241003093228.GA20733@redhat.com>
References: <20241001225207.2215639-1-andrii@kernel.org>
 <20241001225207.2215639-6-andrii@kernel.org>
 <20241002072522.GB27552@redhat.com>
 <CAEf4Bzbpw-MDJFC8iNboEK02LVHcpeyzTKsQxrxt44fKm3MDRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbpw-MDJFC8iNboEK02LVHcpeyzTKsQxrxt44fKm3MDRQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/02, Andrii Nakryiko wrote:
>
> On Wed, Oct 2, 2024 at 12:25 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > +     vm_file = READ_ONCE(vma->vm_file);
> > > +     if (!vm_file)
> > > +             return NULL;
> > > +
> > > +     offset = (loff_t)(vma->vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vma->vm_start);
> >
> > LGTM. But perhaps vma->vm_pgoff and vma->vm_start need READ_ONCE() as well,
> > if nothing else to shut up KCSAN if this code races with, say, __split_vma() ?
>
> We keep going back and forth between reading directly, using
> READ_ONCE(), and annotating with data_race(). I don't think it matters
> in terms of correctness or performance, so I'm happy to add whatever
> incantations that will make everyone satisfied. Let's see what others
> think, and I'll incorporate that into the next revision.

OK, agreed...

And I guess I was wrong anyway, READ_ONCE() alone won't shutup KCSAN in
this case.

Oleg.


