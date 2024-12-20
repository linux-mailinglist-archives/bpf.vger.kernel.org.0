Return-Path: <bpf+bounces-47381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A669F8915
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 01:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8D97A38B2
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 00:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F595680;
	Fri, 20 Dec 2024 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA79tcRk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F595179BD
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734655388; cv=none; b=dmgiNtxsoLsL91Eh9wtwieO1ZADrMx7YaNeg1h9Yc4/kqcdZLjR6WaKTku/kZ8vz2lyjp+rFAQ8jOVwefhI1NBHGtkIMWBEzShgS68LN3e8SA+pL330asNlknTz5xoOfo/HRcfn7d2oo86ZUtnG2fo9XTC0croJt6Ek+TmOGSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734655388; c=relaxed/simple;
	bh=Zn1YeoeweHmhAMEzrDGeblDaOeWu5OeRVvAAmJvLOvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OU5PA++aRduFudzggswFHQj+t3EhdxiHSiPUVWPJrs3ATRMJHJ3wgy0JBKXUXhnB6g8DUPC8gmITrzFwW6PQIIF4Xf9OeV/gAjHwoy3WXix4XlE13Fat06VxyAcPUNmAbteiLrTcHdIz6FwKDXtApQQKxBmcHZu8ywaHCD4PKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA79tcRk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso1153688f8f.1
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 16:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734655385; x=1735260185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn1YeoeweHmhAMEzrDGeblDaOeWu5OeRVvAAmJvLOvw=;
        b=jA79tcRkMsEOuM4GWwLxclP/l+kbj9tHmyk6xj8gXqACFvjhTO+bL3HbeXXvJUW/+c
         0ezGOfl+dVe440xThfs3s1urpwKxriXFgqbyq00vSvMJx8oQQ8gkOtUxYxKawctFBH07
         K2xS0sk6kESB0eMeyx7zE01qM9hg0jtcpwvRSSsUgIC9+Wt+89XkvLl6KlozvM/JiUop
         KFRltZj2Kqtv8I8j1TBgm0LtZRUkErzmngbfpfzLuP0bZq98y8jE1DR6FgWgw0Hf2frO
         9MKkYuGr7psHabTHuP9/QkI5cQJ9ZT2QJb6b9eYkRNaYC9KFKVqF+zObE7HrKzq2t3mI
         GIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734655385; x=1735260185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn1YeoeweHmhAMEzrDGeblDaOeWu5OeRVvAAmJvLOvw=;
        b=E5DOSjd4KsH350a5IY3L5EX//tBVfuxUTvE2pheFwsFEGRy2pbvaXujK8XqHZF5+es
         8quGAgDkLO2brY6kCK3aLWWaeRrqfFg7g5NjdtScjtU15pvNAhyZ8MI0F/mi7NzAO2pQ
         qwC8opb5HAIZ9ifvzFYByUabNHCmGVNYA9Nk3hNwgSsklaVotQ97dvSla6e8qnia5sZP
         rlSl8DslRt6Vfu5hYm7tmN8rIgEMBXfR4JWoMomto00pIaMY3eG5qGMCWRmhlcQjkNw7
         1ges/LZbUwpYm5kne/DSmGxBfDdsIChM/45431bFhaTYHrK94FZ1oIbJfe0+YHvmmBLN
         6Yog==
X-Gm-Message-State: AOJu0YxZ09xPL57+IocS0NrZ9fwgjKAhdiOMZ8huq5MmJGk28wvEPt69
	GqKpafypVvyPmZHfBwZ8gzJ6MBV+RUY0A5dhDnjthDowpLXL7uV9jXjLaVmrNELtVJMsErqnTXd
	ch1g+4PUCCnVRnC3HX4G2MxLXhh0=
X-Gm-Gg: ASbGncuMaEY+CeU4Y2l9XHRjE9KKQSvvKadRuPoZRMDu/3BQhCDpjza0QizlQvf7jxw
	KXxOMLEP/ofSO0/J3AD2HY1qt+EhUhBlPTV288Q==
X-Google-Smtp-Source: AGHT+IGgyu+1kqiVBMJsGLyp7vu32A0tmKG4NisGG3KBOcwY80UhYFq1gjtAGGhq6qrgXp7qVOguL0PEy7wuXq52S0M=
X-Received: by 2002:a05:6000:2ca:b0:386:3e87:2cd6 with SMTP id
 ffacd0b85a97d-38a223ffc3dmr724801f8f.38.1734655385139; Thu, 19 Dec 2024
 16:43:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-3-alexei.starovoitov@gmail.com> <Z2Ky06Bwy9tO5E1r@tiehlicka>
 <CAADnVQJ+u6eWQZ_jhA_8EkGve7RQ1hbi2zfiTYX42Rtk1njfaA@mail.gmail.com> <Z2PFJw0U1nixt789@tiehlicka>
In-Reply-To: <Z2PFJw0U1nixt789@tiehlicka>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Dec 2024 16:42:54 -0800
Message-ID: <CAADnVQLpLOBQBGBHN-ecAdacM_Yhw0Wbp+cdiCZrZecPDifvdg@mail.gmail.com>
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

On Wed, Dec 18, 2024 at 11:03=E2=80=AFPM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Wed 18-12-24 17:45:20, Alexei Starovoitov wrote:
> > On Wed, Dec 18, 2024 at 3:32=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Tue 17-12-24 19:07:15, alexei.starovoitov@gmail.com wrote:
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > Introduce free_pages_nolock() that can free pages without taking lo=
cks.
> > > > It relies on trylock and can be called from any context.
> > > > Since spin_trylock() cannot be used in RT from hard IRQ or NMI
> > > > it uses lockless link list to stash the pages which will be freed
> > > > by subsequent free_pages() from good context.
> > >
> > > Yes, this makes sense. Have you tried a simpler implementation that
> > > would just queue on the lockless link list unconditionally? That woul=
d
> > > certainly reduce the complexity. Essentially something similar that w=
e
> > > do in vfree_atomic (well, except the queue_work which is likely too
> > > heavy for the usecase and potentialy not reentrant).
> >
> > We cannot use llist approach unconditionally.
> > One of the ways bpf maps are used is non-stop alloc/free.
> > We cannot delay the free part. When memory is free it's better to
> > be available for kernel and bpf uses right away.
> > llist is the last resort.
>
> This is an important detail that should be mentioned in the changelog.

yeah. The commit log is a bit too short.
Will expand in the next version.

