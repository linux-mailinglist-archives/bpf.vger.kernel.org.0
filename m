Return-Path: <bpf+bounces-48306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777D8A066EB
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 22:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29616188A609
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 21:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9F2205AC1;
	Wed,  8 Jan 2025 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMcJMB+f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ADA205ABA;
	Wed,  8 Jan 2025 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370404; cv=none; b=CdfdGfYxRL4Zz5SQM+4M6hY3gfkscPtJkMg17OW0o85niziLiI9GojgtL8r/GUL3VmAbvwv9UXgQ3alVTGU3/cO/CjNRvkz7lF2K+yROzM6wcS9seT9N6vHYTTqs08sSDBJ9U1YIQgKymqh9OrKuOxLDUrkTGLMs8v1GKhVDnBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370404; c=relaxed/simple;
	bh=ook2oqzd4qsVOMBJBxcsu/5IcJK72AcEQU57KbKZ6fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+EXw3urU1KXHd/NURgrwuJhXxd26GVoECsls0A52cESZ+d3waQjwCE9HJfSvH4JjxUCJcuDGp+pmEkwJeClX6n7Z6aoXJEd8mM4tU0HB5PSooC6L6LV/GVOtgolfX07Kda+58Pcp5QBHVsNJcsENXQcY14ZoOqQmrqmXETT4rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMcJMB+f; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso217121a12.2;
        Wed, 08 Jan 2025 13:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736370401; x=1736975201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1n3CrI1LI2n81otfRkPG2ubhSOErW2iw4sGhWzG6664=;
        b=PMcJMB+fw2NKiCWawNpHfxQcEMv75Diec7L0TNtJyYGYb6897HRcM0qOWzKvRIMYwJ
         y/VekM103dYWfvhb6vvcdMTDj/u33dzXeELaeflmfNfCcp5/40BLjQzSCaEEYCwy87sj
         QdzDTtE+S17UZ/397zBQGvnTRhaF3oC9u3jQIxxQBrW13Q7oPmhBdTWx+ZURTiuOrnGa
         NxXDS/22HGZ9lTAGr+6yepDK1FDaAnOHR3WVQmWU1Q/ii7hhobhSsXoeMk0X1laabfQI
         Kk3Vk12NJXy3Kc2hgXtdg4Sjdwr+umAraBuIaGg+xIWaHesAcYIX5Nad5aBLeeBrGF6/
         B5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736370401; x=1736975201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1n3CrI1LI2n81otfRkPG2ubhSOErW2iw4sGhWzG6664=;
        b=sGOCdQAwWx9p+5aVPk7FHqqiNTt/E2U8uJP2fK+DBsP+GBQnJNj+2ki8Wrn0Cqs0IL
         2whJdiKZtPVWykB7SldmGmOuiokynrCunKSnZShs6KkGsduqvaA9TbhExVia5vW6H/AU
         hsanzg0oH35BDc8GxWnEWA54vCzc4D+W3IVBBv/hjcpI/clJevXQUGLfAYFlErx/dRZ6
         WWEQrTYrDMU7em9r9aRgAJMxLlA9danYmWJj4pmhrmwBHzWJ/dRaxzHJd90awcppvQTy
         HgQhrubsWIr6NS+st9osPUwB93DokOkBlO7HQRQIQErE7CTu3Fmq+GhFH3i4iJf5SYB7
         PL6w==
X-Forwarded-Encrypted: i=1; AJvYcCU3jNmB5SCQXRirF422pJAvqqrAr1LDRG8xcjiwqdVz7SX8jaRn+wXN+HqbgmIp7+pmM/08IvD89RObC9xJ@vger.kernel.org, AJvYcCUgw6wPxFLlSx2NSuxEmbSqVrxSq7JNkRuQiKIxRQvj7Go8XgmmLQkDFgCU0Z05bXe6oKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAYUv2/cTrcW7F3XWGglWLyD8ku97LF0NG+LzOOCP4Y+ANeJmg
	ufo+48w46uwn9+2ZjOjFwQhDoQxQJkYv1yZF65Kx5BIp5hilom1/uOvGSKXahpy8R7tj327VRpP
	hAdzSrhuvj7fREFJ8T8tRxJXqAcY=
X-Gm-Gg: ASbGncuNOJJ1ZGiBEbdpJGhI78Je0PmMW7aubGLqSeK/voEhOL1Kdrbw1f7pbWjlzv6
	ckhyagMu1roaLYVIUnkfLW/IDm7zjY4JsILHMLvWjhZ55DaPn5CYo+o4l7YbDOypVJDAd
X-Google-Smtp-Source: AGHT+IFk29+HgpReRAbVbXpAUbtuMV+T1rKB9ZavNoeM8w81J4tUgdm8jwjE6KpxL7OrUOiMjDG7Kcvokqktp4Tj4uc=
X-Received: by 2002:a05:6402:51d3:b0:5d2:723c:a568 with SMTP id
 4fb4d7f45d1cf-5d972e08756mr3606829a12.10.1736370401326; Wed, 08 Jan 2025
 13:06:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <CAHk-=wh9bm+xSuJOoAdV_Wr0_jthnE0J5k7hsVgKO6v-3D6=Dg@mail.gmail.com>
 <20250108091827.GF23315@noisy.programming.kicks-ass.net> <CAP01T75XoSv91C6oT8WSFrSsqNxnGHn0ZE=RbPSYgwX79pRQVA@mail.gmail.com>
 <CAHk-=wiWxnjFkqG9VLm0N3Nj4U7Y3JNvyshmjdwdD_=7_zZriw@mail.gmail.com>
In-Reply-To: <CAHk-=wiWxnjFkqG9VLm0N3Nj4U7Y3JNvyshmjdwdD_=7_zZriw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 9 Jan 2025 02:36:04 +0530
X-Gm-Features: AbW1kvZyMqkjEm64kW3RBq0nwXO4lTlqg6X656LdLHQcu2Bfq1x6RDEi9ZH7uW0
Message-ID: <CAP01T77yksZ3WxGqnCAwhFUp22ycGqHS-mdtpctBcAsoSA5rgg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/22] Resilient Queued Spin Lock
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Waiman Long <llong@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 02:00, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 8 Jan 2025 at 12:13, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Yes, we also noticed during development that try_cmpxchg_tail (in
> > patch 9) couldn't rely on 16-bit cmpxchg being available everywhere
>
> I think that's purely a "we have had no use for it" issue.
>
> A 16-bit cmpxchg can always be written using a larger size, and we did
> that for 8-bit ones for RCU.
>
> See commit d4e287d7caff ("rcu-tasks: Remove open-coded one-byte
> cmpxchg() emulation") which switched RCU over to use a "native" 8-bit
> cmpxchg, because Paul had added the capability to all architectures,
> sometimes using a bigger size and "emulating" it: a88d970c8bb5 ("lib:
> Add one-byte emulation function").
>
> In fact, I think that series added a couple of 16-bit cases too, but I
> actually went "if we have no users, don't bother".

I see, that makes sense. I don't think we have a pressing need for it,
so it should be fine as is.

I initially used it because comparing other bits wasn't necessary when
we only needed to reset the tail back to 0, but we would fall back to
32-bit cmpxchg in case of NR_CPUS > 16k anyway, since the tail is >
16-bits in that config.

>
>               Linus

