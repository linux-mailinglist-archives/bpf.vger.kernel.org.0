Return-Path: <bpf+bounces-47294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 453F69F723C
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 02:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B170016EDFD
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 01:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5434206B;
	Thu, 19 Dec 2024 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag87r9Ev"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D937405A
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572735; cv=none; b=SBXWGmiAob2IA6B6/GC0k5VzAQ24Apg5uCpJULudH0eC2gmTAbIWT6DKsX/tvXdWig6Sa5ORElAd6avBFSBW0UJNzYvfONcHfSwvQrEGZTXMolleG27jBlIWbHLiO1QSExT8ZvNJBOs83SchJ9+JirK+w8abW0pRrAV4KgnhrvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572735; c=relaxed/simple;
	bh=neUu+o39xO0vU1QbBIE7Qaur/BaN8OS6IKH0p8Q+L4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7hNlr7AnN8szJ593tiDlaIXK9R4a8wzjJTDg24Y8qkPCLvEL6uIUlCH39M/NNPxWIvmsAji1k9geGzVA/gBvZ2NLmHcMIeAYQkFCEZ6qzGRqDCj4/OyjIGB4qMzTQAU0JMxuN0WVH3vqpWU9H7hShgHLZbgJ4/zEZanTRiYBxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag87r9Ev; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so149094f8f.2
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 17:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734572732; x=1735177532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neUu+o39xO0vU1QbBIE7Qaur/BaN8OS6IKH0p8Q+L4Y=;
        b=ag87r9Ev847MO7M8g5ZvNlau+1mUt1tTxDL7nFeWclSaylvjuxvMELxdnY0FK2v257
         1ZN93jKcBroO24NSNobc3+1dytDlhLOo/W8016pcF0FN2OKhAKTNe4l5sZaJ47gccWAD
         6pFOT5/AKhpDjwgw1/K5Z9G3p+Kk1RnlJ33xmXhhssWOYShXGReEwXbybRmKgmcTpXXL
         jnpZ1T8g94FnzyHe8lxOmHKji2F+LEOSLlcd1MHsEU1d1eD3jJvwkqXpMQJiTLTCwB3S
         mjsIK89gLHkjh62/+K7+e+Xv0VReiNkhQmZY/WbXY/wlOWOQWaRCkEj8yxQHPcAck8tl
         Z5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572732; x=1735177532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neUu+o39xO0vU1QbBIE7Qaur/BaN8OS6IKH0p8Q+L4Y=;
        b=goVsnz5AWFG7y4iKdeEwWzj2nb4/Ml95CDg/SpavKDeMgOJ3CyghtL7LWB/KYV8d1M
         fLzTXVY4apkiHx29qDzQU7s9MRYnjKf1TY2DHaoRD7AWPx9AFh90UpOlxzNiOkqrJavJ
         8sFm/KjjiZKg0LYegUGKnqH4RF+Cddy4rSWKZuqvmk/Ku3z8MdooaNSuKRnPTh2uVzX/
         p4PA9SEGvzqYx179n9d4yl/M/GX+PNZ1Idv/5grdYx5UPPe05DxcS0I9fl8JFONny1rR
         LhbVjmILlnwsw8Ro2rVS+NTlqkOGp7JR5tpKYtqVSRmHRJiXH9+gtjzv4QoAX3L2J8ws
         QfRA==
X-Gm-Message-State: AOJu0YwSbwtHCJPkzUU7LE8YdopXLhleVIDsLSLKXRz2yM8G+SFr6IV/
	r6iJn0rTrGVsRZUzxNpVjGH4VJYSL0RIk73d3DisH/Sfo5vpfqHaPZxx5uFlpst3OQc+aEYfwLX
	Wvo4ML/OM8fMgYHSa8KdEdE1ej7Y=
X-Gm-Gg: ASbGnctpNHDLI8Y4JD1v3rZNHHRKeH0kv0XBKc2ARs2YTrWjqOCTO7LKqC5eqC3toSf
	LF3W1VMmOFNlQHTEogCrGHTLH7+DVskDUQ70wDQ==
X-Google-Smtp-Source: AGHT+IEzHGEofYwzF42LaIwbJw43xOdwwIgH9nRJaYYwx8ezbmz/4KjO5UnvIcH0jxjLC+GavCjTfRYALCipVGXKsGo=
X-Received: by 2002:a5d:64e9:0:b0:385:e879:45cc with SMTP id
 ffacd0b85a97d-388e4d42ba8mr3785916f8f.19.1734572731610; Wed, 18 Dec 2024
 17:45:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-3-alexei.starovoitov@gmail.com> <Z2Ky06Bwy9tO5E1r@tiehlicka>
In-Reply-To: <Z2Ky06Bwy9tO5E1r@tiehlicka>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Dec 2024 17:45:20 -0800
Message-ID: <CAADnVQJ+u6eWQZ_jhA_8EkGve7RQ1hbi2zfiTYX42Rtk1njfaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] mm, bpf: Introduce free_pages_nolock()
To: Michal Hocko <mhocko@suse.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 3:32=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 17-12-24 19:07:15, alexei.starovoitov@gmail.com wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce free_pages_nolock() that can free pages without taking locks.
> > It relies on trylock and can be called from any context.
> > Since spin_trylock() cannot be used in RT from hard IRQ or NMI
> > it uses lockless link list to stash the pages which will be freed
> > by subsequent free_pages() from good context.
>
> Yes, this makes sense. Have you tried a simpler implementation that
> would just queue on the lockless link list unconditionally? That would
> certainly reduce the complexity. Essentially something similar that we
> do in vfree_atomic (well, except the queue_work which is likely too
> heavy for the usecase and potentialy not reentrant).

We cannot use llist approach unconditionally.
One of the ways bpf maps are used is non-stop alloc/free.
We cannot delay the free part. When memory is free it's better to
be available for kernel and bpf uses right away.
llist is the last resort.

