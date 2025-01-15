Return-Path: <bpf+bounces-48990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27907A12E4F
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0B518869FC
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 22:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4451DC9A8;
	Wed, 15 Jan 2025 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8WKaFDQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87B8F77
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980450; cv=none; b=niU50xF0/nJ43E+hhJ7FyHRyfMn6hLhhGFq3hWOyaXYSMl0A+LUOSfQo5XDTmkL8UuWmmV4+YeMeLQgXfJq8+SwGM9s5Q8Deo6035ptH039Lwg+l9u93glxoIkKqlAPfE3KZ9JTmiikPaS18Ccq6bt3ZhZBJ5bj+yvby7UfZzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980450; c=relaxed/simple;
	bh=HdCkGrgXt+TtjkIRMxtdtLmSDedwnDbVoPu3KY19zjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G33LUqXHdJEjlyY9fPkrvnCdTUEoQWQoT9M1zhm1H59l3PdVJuQ3zAPXBuxm1AR63Ortfr6kA+YSffAOfc+/eE+KW/60RL8Y6ORwgJhJl40Y2H7gYcTPjJB2fRmg+GQ9lFmS4skyfTxxVG0UpZByGj3KJZQVOHtHEFSsejrIiTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8WKaFDQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3862d6d5765so148259f8f.3
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 14:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736980446; x=1737585246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdCkGrgXt+TtjkIRMxtdtLmSDedwnDbVoPu3KY19zjM=;
        b=d8WKaFDQpCsBtQ77tyUgUGp5PEFhmxsqusMHS+7F0a+aU2EPFRo9BpQkxPkitiRy0v
         vIIGfJ7N0WIhYDDNrFvu3W91dA3svtm3dY9IggEH7g9PaEf1iRUrWco/oQEH+Yyn5s97
         784uJdsz9mc/5+LMUIDStWrMsJbo75BGV1SuTk7hzjMt94aqToWYjDA5k+2a6COH3lC+
         acRwyJZp6qI+vKjGrWtFSfquMNoViaEYelyrJ3j17hIAdVT1HIuHgqvEhu3QELPF/xhE
         0WnqF++v4DF64vBtoeeSkH8bA185MQacYgiWtQy4xTeMVtGxCyeJRRlbi1tc7HqWZEh5
         xhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736980446; x=1737585246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdCkGrgXt+TtjkIRMxtdtLmSDedwnDbVoPu3KY19zjM=;
        b=f7NRpZm8ZWfmiNHTCnkr8/BNdosTDdmLZoLk9D4sM3rTy5GaTW9UauzrJxzM6uhUMv
         JxMReb3T6px4wy0+cTXSr/1WgmNQjCTkvEV5PDvP8AxTzz6Y1t0gcUAdco+SleqBwg+6
         cCjsnw1CVUKK1WglsGL8YuEoqgFtZGHS8gYsuh9JasXxB8KBpeki+TH9xxIv++cBQPmV
         fN/mCPllwNVHL+6NO4bUTwSKTV1vdCgA4iZBvRfFybHo/qKg107p6cT1o8yS8ptxfHGn
         hoPqUhtplk7EGof87YoDLl/3/nH0mznI54oRs7eiQ7biZxvoInFVOMdImkjQWb3tU588
         6rxw==
X-Gm-Message-State: AOJu0Yx5o0nwnT+KimGHjdoN/xHFWtUAw88RuoIsMbsZQChtoLB6pzFY
	l0KsPUVVmu9MiDzI2PPof6XJ8lI6MGQZdQby8mm/rcgJQtDEWmTNiqzddL3wL+0g/hSEa0AL2L7
	EupD+mxyOvDlqf88RVCq0EVychIg=
X-Gm-Gg: ASbGncsZBZmF+dHSPR8MY8D/yUqgFHqCWe2LiszQ/SJPn2VWQ6HJBwhfNZjKtBR0QKr
	ho5JVAxwkFEGWIgWQSmil9pwbPAZyVjIvSZ53OnQAaEAN5JWbrJar2g==
X-Google-Smtp-Source: AGHT+IEHxD5tDF30UTHPuEmFS0lLv/rpE46aiB0cbj0uY+4Ltf+aPw2fPOnrnDGbXjxrvuxgL883HyguoZTXcMQ671Q=
X-Received: by 2002:a05:6000:1a88:b0:38b:ece5:5fe4 with SMTP id
 ffacd0b85a97d-38bece56cb7mr194224f8f.1.1736980446207; Wed, 15 Jan 2025
 14:34:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
 <20250114021922.92609-2-alexei.starovoitov@gmail.com> <Z4Y9BVygLcRTjhMh@tiehlicka>
 <CAADnVQKYb+kHwaAzL5c9S8V+Wcnju+ScMbajmMj2wi6E_=Pq-g@mail.gmail.com> <Z4dzVO-GBBc6Tr5E@tiehlicka>
In-Reply-To: <Z4dzVO-GBBc6Tr5E@tiehlicka>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 Jan 2025 14:33:53 -0800
X-Gm-Features: AbW1kva-ZkzMxsQ3qqhYQ1yxPEzA3vJvyYUvoRdZ9pBIgeH_JNx3IW1FBxhOW8s
Message-ID: <CAADnVQJbA8Fw9mg5SztPOiGUw9QdrR4=1O0EtGV272w1zk4z-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
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

On Wed, Jan 15, 2025 at 12:35=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Tue 14-01-25 17:23:20, Alexei Starovoitov wrote:
> > On Tue, Jan 14, 2025 at 2:31=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> [...]
> > > LGTM, I am not entirely clear on kmsan_alloc_page part though.
> >
> > Which part is still confusing?
>
> It is not confusing as much as I have no idea how the kmsan code is
> supposed to work. Why do we even need to memset if __GFP_ZERO is used.

kmsan's main objective is to find uninitialized memory access.
So when the page is initialized kmsan needs to notice.
It's similar to kasan_unpoison logic.

