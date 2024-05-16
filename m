Return-Path: <bpf+bounces-29853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3308C77E8
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 15:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBC01F2311F
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF80147C62;
	Thu, 16 May 2024 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKd46TN9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C898A145A1D
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715867147; cv=none; b=gmEw6dLNpF7p0TlqwOVm8J8Xtsut8YhsCQwDswLuyAbvh8yHeTViwffY6+1xrzmZAWadELQ9X1hTGotFWjGvuJya3/WLFCnail9gbmExj9X6R2yiBXOhf0GPAEBewniAHVd/P7mKWIjL0Acycp8qE+uLWj6TAFZD5A7XaWYGvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715867147; c=relaxed/simple;
	bh=cYo/nT8qQDC03xw+GHMsNdNJFVkts/EufyugSZPYN3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlX9fAGP1BFdgIaw22qtt7wqLyLymQjbay9QOuB/Edt0ZDqS2XvdWaDz+EFS6inq4XPCWLjWrvjEDzCiTAIXr7jZ6u27GnPr1j79a1vW0zWys2wvThM+4Lre/N3c05+x85XJtMRWn6scB1tyKbeztnvTgJ65Wts3GdU5cA2k6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKd46TN9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715867144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50YV4doU4hotrim85PHUofwG7EON94IM6vTruab4+zc=;
	b=hKd46TN9KULX6BTes0Zs5WGXETa++0t0Zvhhw65X5XW70vgShFij8iywxtTJz6JeRJG7dU
	PtBzM9e12LU5lLui5Epud6VhF9TuuIBDXaM2fkbHkDLjz4HnLwyE7Jj6sqp9BGAYFCxfRr
	lbBcmH48oQoJFB1yHvIQh/eLaZ3rlQA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-rSEynkDFMsGmI5GvUwokuA-1; Thu, 16 May 2024 09:45:41 -0400
X-MC-Unique: rSEynkDFMsGmI5GvUwokuA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2b2a8bd5ee0so6868268a91.2
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 06:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715867140; x=1716471940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50YV4doU4hotrim85PHUofwG7EON94IM6vTruab4+zc=;
        b=mX3aE/uaAvOEVz9LzYdbv8FUx++kJi3qkwKtxa6oA3YvoVUJbg9OwKo9IV3GyuPCnS
         j6M/6JPR9VtDN+kh3IxHJaEomM7tyHOqwTjk+JLgpxaAFm3L13x55Q4le82rmyDrkAPi
         5KZSrGRYoMDsJBp090NY6mpENEGja7Hj5OLpuL2/W+Mw+VoWJIY8og994tDSCJGVNZlK
         MyAzlWkxFa/5l54z+4QyjZd1SpVOHYIVWHqMBSZIEnacYbD+aTUhrFCA1toD3AuvjOYq
         9gplGr1GI1CQoEz37CQYobVqW2e66AG3b9SKe2VWqFyL0DUzFjP5VKaS/PrN/K8wiyYZ
         HGyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX98sJUXfOHolJ+dLLV1QpxY3FhSrMFrgC267im3+kAu3sXs7ZBX3a6oqotfkWgb8r+c3A2vmUVBf+drRrN0k+UEWsg
X-Gm-Message-State: AOJu0Yz9CRqGyWENOsNEyHI/KackC+y/trkXhP7D9y26mMboKt33Z1+c
	VoTVLq5pst3Y0J4dcPZrkzB9tfDxKUkbbGS9a26hFNk8LCGuC4Tu67Pgje4PogOgg6l55Dz03gA
	l6G7BOe9GYkKH6N+8UE67it7BeEQ2tYt7nAwrlHuLGQ8hQKsGfSwYL2g+X8o+zBc/HWVSYgicbV
	kS7jNU9vrHxH0ciQOlQnAH5q0h
X-Received: by 2002:a17:90a:a10d:b0:2a5:badb:30ea with SMTP id 98e67ed59e1d1-2b6ccd76d85mr15980296a91.36.1715867139862;
        Thu, 16 May 2024 06:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZPNaeWcVsWqCiEobZXcjnuR4f6EwP5sGhEIOxK97tKsPzuoSWjvq9Z02ox1q+mfONfFWCNhfgXTPZnTJjNn4=
X-Received: by 2002:a17:90a:a10d:b0:2a5:badb:30ea with SMTP id
 98e67ed59e1d1-2b6ccd76d85mr15980262a91.36.1715867139289; Thu, 16 May 2024
 06:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516133035.1050113-1-houtao@huaweicloud.com> <dbb75bc2-cb09-79e9-2227-16adf957ae05@huaweicloud.com>
In-Reply-To: <dbb75bc2-cb09-79e9-2227-16adf957ae05@huaweicloud.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Thu, 16 May 2024 15:45:26 +0200
Message-ID: <CAKa-r6u=FiCxzQ0FF-XMdNjEA=LZZ+m-yMZ1KXT9wqMiX2gkPg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: unregister root_lock_key in the error path of qdisc_alloc()
To: Hou Tao <houtao@huaweicloud.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello Hou Tao,

On Thu, May 16, 2024 at 3:33=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Oops. Forgot to add the target git tree for the patch. It is targeted
> for net- tree.
>
> >
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index 31dfd6c7405b0..d3f6006b563cc 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -982,6 +982,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_=
queue,
> >
> >       return sch;
> >  errout1:
> > +     lockdep_unregister_key(&sch->root_lock_key);
> >       kfree(sch);
> >  errout:
> >       return ERR_PTR(err);
>

AFAIS this line is part of the fix that was merged a couple of weeks
ago, (see the 2nd hunk of [1]). That patch also protects the error
path of qdisc_create(), that proved to make kselftest fail with
similar splats. Can you check if this commit resolves that syzbot?

thanks a lot!
--=20
davide

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/com=
mit/?id=3D86735b57c905


