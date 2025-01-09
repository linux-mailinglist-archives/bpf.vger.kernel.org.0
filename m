Return-Path: <bpf+bounces-48456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0C4A08208
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4F8166AAF
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A4F202F71;
	Thu,  9 Jan 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUvyPCjF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB332010E6;
	Thu,  9 Jan 2025 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736457254; cv=none; b=MTHR7PUp2/NYsYJoxYUx11jpz6FtxXYG8MB7V3iuiWacvXvFeuj72OfMAql1k+aXnfzPPHLCJ4iYPn+jn+Tmh3Dlfm6wQTn8k1xgYKV29FmetX8Ek0+JWmwwPdJVkszzBt7gtbBRneEAcFASmYBUPBg9khMXvxAo9USwLH12YdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736457254; c=relaxed/simple;
	bh=oRe6W0YtOifBOq/5U5CvVX4H3M2hacfIjbXPMwcFjtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcEl8Kw+X57JvC9XaRPn1QxkJBiTTrHhZwsYBontp99QETSxVgyNazZdJaAnHXHPcMx68OOR+xB/aq6wo9hfml1ok+Bwn689/Mx6Iw2FKcIV4ipNfGH8t9u2IFG68BKb9WSJ/AyO7Me+FQaajW3e1ySlv3EXZj4Mnt3qe6QWfPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUvyPCjF; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ab2bb0822a4so287523266b.3;
        Thu, 09 Jan 2025 13:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736457251; x=1737062051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oRe6W0YtOifBOq/5U5CvVX4H3M2hacfIjbXPMwcFjtc=;
        b=YUvyPCjF4nxShAE8F3X4MpIhG+e2YaBOTT0bmbdlCjr352bivqIB3XDr2HfwP1K2Cf
         tKsFP4bLzVW40NW1gf6SCnvXStnON0gWmvkNdRDUR2cCuI1VU1/7MxZIH5lDnZY6UrZ+
         l9lZnk3fM2++raWo5SExE7iixUE7SK8RyZr9p7kHvkjqS6RX1CgiqQ7Kl3FYAKxl81ps
         rAQk/pw0wIIH3mD9xXSsujtXRpgVZUn4BaMyPd5FiQS0TtCoCRKhBP4mTZTuYeVVK0GA
         8CBKXnaMm399WDW8hZEX2MMe4r5gTeBVKwuJxu3gaGyjx/TUjzJkdC/CqME2EBOsOJBd
         ccIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736457251; x=1737062051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRe6W0YtOifBOq/5U5CvVX4H3M2hacfIjbXPMwcFjtc=;
        b=wQ6cGlzz5Dq2wevbSvY+s01Lvk7DUvktOHS2fxayaXkpTv8SCSe+M1HhI3JhY4af4t
         DhjizWHTgbZKywJTTbrOWYjdMZvr0EfqROJ9fDX+nLyDsu8/uUMldHkKvNbegxptSzg1
         LlD1j/XKaaU9jPfUc0gmp/uVmjiWgABJyjk7hzoNloPQcQNOv0c5meUHmzcZlcrC/vhC
         SouW4GkoJXpA7fgsYuOlCRA+cKlQVKCY06Bwp+9vghCYpVkNA2OEk53n5DTGYWX6yOVa
         1zDpKX2Oy6Etut6HUczFwCtnGNIzZF8vdbzucCFZEHngkhstdP3y2Fuosn39PnrZpBRy
         GoAw==
X-Forwarded-Encrypted: i=1; AJvYcCVL4Gf0RA0NnGgxcB8AjytrbYzNqiqZEKsLCTB5eHqIZmW1JghYRKAneyma3QmRe8o9soM=@vger.kernel.org, AJvYcCVlK8ndRzaU0A3kIll45O1bwNQFwYkTzuR7jqNY9EZ2pbRSAdhgsCGx/zFJ/FurzYw+Eg0YB5Jtfiy1YKHk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8J8PWc+8seDCstguiYxlwyckgTg1gsZANOIl80ABVH9feSqHK
	o6h7gwOiS2ng2zJlkC7GggtJLTHXEIcoFFg+qMDBVlDtmqNFAb7DXqPdesbyjOnKnGKHCStsb3z
	9VGS+R1EcZ37gvLWnFf/Hncn1yNc=
X-Gm-Gg: ASbGncu7gjWonGCYkkwhV7axw/uxzR2fqRZoFYA+omQot3Q96uVk8usG77o7oG9drNA
	Dk02pwmj8nLLQpg3JH0R255QjpBrbZKURjXlY+ij2
X-Google-Smtp-Source: AGHT+IEUPbOa4WdvFmUpaXweBL0Ko6uBYL5VTOEFrrQG7SZV6qywnZewzkY81tZ+QL/jp/rDTN47FxoBVeQDRADtj9E=
X-Received: by 2002:a17:907:7e87:b0:aa6:5e35:d730 with SMTP id
 a640c23a62f3a-ab2ab559bcemr579404766b.24.1736457251023; Thu, 09 Jan 2025
 13:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <CAHk-=wh9bm+xSuJOoAdV_Wr0_jthnE0J5k7hsVgKO6v-3D6=Dg@mail.gmail.com>
 <20250108091827.GF23315@noisy.programming.kicks-ass.net> <CAP01T75XoSv91C6oT8WSFrSsqNxnGHn0ZE=RbPSYgwX79pRQVA@mail.gmail.com>
 <974db75a-4ffd-4379-8085-484c45702fe5@redhat.com>
In-Reply-To: <974db75a-4ffd-4379-8085-484c45702fe5@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 10 Jan 2025 02:43:34 +0530
X-Gm-Features: AbW1kvZGT9MwXw0Fczwwi9l0CkcoPfVFhv0oq8xdfEf3qVkM2jZMlNgPTbQ_xr0
Message-ID: <CAP01T76guECG9gn2cDENww4_W9rRvAZ_6YkF9T2mAy7jUS+V4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/22] Resilient Queued Spin Lock
To: Waiman Long <llong@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 19:29, Waiman Long <llong@redhat.com> wrote:
>
> On 1/8/25 3:12 PM, Kumar Kartikeya Dwivedi wrote:
> > On Wed, 8 Jan 2025 at 14:48, Peter Zijlstra <peterz@infradead.org> wrote:
> >> On Tue, Jan 07, 2025 at 03:54:36PM -0800, Linus Torvalds wrote:
> >>> On Tue, 7 Jan 2025 at 06:00, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >>>> This patch set introduces Resilient Queued Spin Lock (or rqspinlock with
> >>>> res_spin_lock() and res_spin_unlock() APIs).
> >>> So when I see people doing new locking mechanisms, I invariably go "Oh no!".
> >>>
> >>> But this series seems reasonable to me. I see that PeterZ had a couple
> >>> of minor comments (well, the arm64 one is more fundamental), which
> >>> hopefully means that it seems reasonable to him too. Peter?
> >> I've not had time to fully read the whole thing yet, I only did a quick
> >> once over. I'll try and get around to doing a proper reading eventually,
> >> but I'm chasing a regression atm, and then I need to go review a ton of
> >> code Andrew merged over the xmas/newyears holiday :/
> >>
> >> One potential issue is that qspinlock isn't suitable for all
> >> architectures -- and I've yet to figure out widely BPF is planning on
> >> using this.
> > For architectures where qspinlock is not available, I think we can
> > have a fallback to a test and set lock with timeout and deadlock
> > checks, like patch 12.
> > We plan on using this in BPF core and BPF maps, so the usage will be
> > pervasive, and we have atleast one architecture in CI (s390) which
> > doesn't have ARCH_USER_QUEUED_SPINLOCK selected, so we should have
> > coverage for both cases. For now the fallback is missing, but I will
> > add one in v2.
>
> Event though ARCH_USE_QUEUED_SPINLOCK isn't set for s390, it is actually
> using its own variant of qspinlock which encodes in the lock word
> additional information needed by the architecture. Similary for PPC.

Thanks, I see that now. It seems it is pretty similar to the paravirt
scenario, where the algorithm would require changes to accommodate
rqspinlock bits.
For this series, I am planning to stick to a default TAS fallback, but
we can tackle these cases together in a follow up.
This series is already quite big and it would be better to focus on
the base rqspinlock bits to keep things reviewable.
Given we're only using this in BPF right now (in specific places where
we're mindful we may fall back to TAS on some arches), we won't be
regressing any other users.

>
> Cheers,
> Longman
>

