Return-Path: <bpf+bounces-47302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9853E9F7511
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 08:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893367A15EA
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 07:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1427F21639B;
	Thu, 19 Dec 2024 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RIP0zjHM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F6524F
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734591789; cv=none; b=mQyJpc/tjY0UkRGQIay6GauLm8RDC1zz7eSpWPDk5OC5DapJ3snOLXoZOnOj2rv9iTMfmszI5cLLt1nC3gpx1VMfiJeXNzqnwAee0QcQrfxmlsvmQT7Qt43L7wpE7h9XjTQlhbj7+KyZIVWstO2OnDLYTf1tBLMH83NvGdAQFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734591789; c=relaxed/simple;
	bh=4WuKTZzdL/XfHwy0B7V/oLmJfLfDN211pU+1sRw1GDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdcMdJy21sc4vHTo/mEVhDB6Fts3cqmwu9PPj/TsQDyAkN5DYUI9zaGkE9c8NrvY7LEDvJjf4ZIJKg6xeekVhDDDoDXQdrpMZxInvYNTGajwJ49WsDPe+k/nQ0vmMhYcCVGOA6xG6JkeeFec1F2+XgK/aRqJt/OBhEwyEnIh/Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RIP0zjHM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0f6fa6f8bso633228a12.0
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 23:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734591785; x=1735196585; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6EnveSRe195KkACzp6IErx9PltTepVYopxXSfbLVNa0=;
        b=RIP0zjHM/JZiwMFBcxx9gZCRNJOTtQTW8BluONFaMNvPEXYUG311cfoiQqS19O2vo0
         eAEc92h+v8I1GBgSgPhfBc9j4nUmaHmW1UGrnHyQG2Vhbd1W4sGwwafY3bEYz4MpyV3q
         2vAC+sEi6i7kC2YRZ/qOVYMtTHD95rypWHEO6r7hhGbf3yKuUyimKwFGrJbnRx+5FcOK
         dr572YqTQ2Uwf2T+hkis1rASKnUwNMNDwz7zdtwr6Js7AKR3m6MBTIFDzwW9bNqM2aRd
         lJBOy/xB8zi+H6GjNQAk8ybbqdTzi8Df1fse6wXfDXqgYe8YaoY6kCHwFGFwCWMMWR4o
         JQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734591785; x=1735196585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EnveSRe195KkACzp6IErx9PltTepVYopxXSfbLVNa0=;
        b=aC04Kn0pn9VASVzrwD5nrOopStky/vXFL4mNwmCL9tGZhipGzftoSIZHKhUysQZ/b/
         a14xjJR+ezKFoVzFnabqpy5CvhNELkPHx2YAyNksQnjdGGMeTsZy+4eE76vJMcr8dZoK
         ICt5//AcXqopOJ9QOh57TjU7s2viTilRqFSSRpBwUbOSCypLAGrAziG92AOER+8b0UxX
         dbD0s8G754wAkFySXfAhn8CqqBRxry0y2fju0S3OBKMo4UhXCgJKrx6kcUJE3VYY7Yw2
         HB7Mf3AJENZtLGbPcjVioIanO+mcWE+75RVrzho+C/kaZ2X16vfkCGnb6X+zS7S8RWT1
         g65Q==
X-Gm-Message-State: AOJu0Yx7l9k+eTNeQUOfcyQ1IZvPeipG9DQgLAXny94dnPJD4jLlaxsg
	qlMsKXsoZ8Q02mz3EsAv66kLLfwxein3yKhyjETUILCRuluk/fTlVK+xBMTy9oI=
X-Gm-Gg: ASbGnctw0OSJXdPmHxhYdlQZaFDegZP1E7IUyqfu8wMnLAePii5aMrQO+EncvNwt01O
	H08YhUC+09VFZKJpSDp2KD+GuOHqtShDW7ntYFdE3Tk/dm0mfzegHR3+pgMDQ+NTe4ieyKe3evG
	F7VngzvjmCP/cYxf/ZboUZg5R86asI2jQAifsjwVRagJSj0Y7NTBNIdElYiZKfHbNNCrf8sd6sP
	N/vQV1fNxRwIH1x6mD8eHFaMQwEv0cHSOCTEc5B+YoEfG/buNCCYtMsDHM/DN3m
X-Google-Smtp-Source: AGHT+IG3L6jZqjCglPktALyzgcJcm0sojQ6OLHrpen1D6VLMWKG9RI/QbMoW+YgvMNeMOrZko9hEVw==
X-Received: by 2002:a05:6402:4025:b0:5d0:aa2d:6eee with SMTP id 4fb4d7f45d1cf-5d80261d527mr2001196a12.26.1734591785486;
        Wed, 18 Dec 2024 23:03:05 -0800 (PST)
Received: from localhost (109-81-88-1.rct.o2.cz. [109.81.88.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f1dcsm351083a12.30.2024.12.18.23.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 23:03:05 -0800 (PST)
Date: Thu, 19 Dec 2024 08:03:03 +0100
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v3 2/6] mm, bpf: Introduce free_pages_nolock()
Message-ID: <Z2PFJw0U1nixt789@tiehlicka>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-3-alexei.starovoitov@gmail.com>
 <Z2Ky06Bwy9tO5E1r@tiehlicka>
 <CAADnVQJ+u6eWQZ_jhA_8EkGve7RQ1hbi2zfiTYX42Rtk1njfaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ+u6eWQZ_jhA_8EkGve7RQ1hbi2zfiTYX42Rtk1njfaA@mail.gmail.com>

On Wed 18-12-24 17:45:20, Alexei Starovoitov wrote:
> On Wed, Dec 18, 2024 at 3:32 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 17-12-24 19:07:15, alexei.starovoitov@gmail.com wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Introduce free_pages_nolock() that can free pages without taking locks.
> > > It relies on trylock and can be called from any context.
> > > Since spin_trylock() cannot be used in RT from hard IRQ or NMI
> > > it uses lockless link list to stash the pages which will be freed
> > > by subsequent free_pages() from good context.
> >
> > Yes, this makes sense. Have you tried a simpler implementation that
> > would just queue on the lockless link list unconditionally? That would
> > certainly reduce the complexity. Essentially something similar that we
> > do in vfree_atomic (well, except the queue_work which is likely too
> > heavy for the usecase and potentialy not reentrant).
> 
> We cannot use llist approach unconditionally.
> One of the ways bpf maps are used is non-stop alloc/free.
> We cannot delay the free part. When memory is free it's better to
> be available for kernel and bpf uses right away.
> llist is the last resort.

This is an important detail that should be mentioned in the changelog.

-- 
Michal Hocko
SUSE Labs

