Return-Path: <bpf+bounces-68684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B14FB8156B
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 20:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393981C23931
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 18:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E22E2FFDD5;
	Wed, 17 Sep 2025 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/oQxpPg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278F2FE582
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758133636; cv=none; b=bex2HoddfUzdmk/JTynbwX0XeoBkz2ZNH4E042zvroJ0wbOMrj5yckGPpcJYSon7MiN2scJSA5wNc7c9jMMrBCox39clRby9RA06uc6BgzaV/Win/cJHfLT3NCnhR3HkYChH8DjRIC3fVIO+/g1FNobzGUfb3/uOyLrb8vJXMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758133636; c=relaxed/simple;
	bh=giOIiZmv6I8DqOhlCekUkvEcCR09Gm73BQos2pe6CNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRtSGdSuVr9Wc9+lpdQlJpnIn7bYTLZuR7bxAZuJHGfjM+2If3UJ23RtHYJ5yELPkCha5/68Kmf4aHeGBSjitOlqzJBPcp/rmHiQw2UDQ4YMkl09QJJHae/0fZnpeqGhoeVSdN0W446niNHPIbCxuVHef3P8LcWFlClspHURJOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/oQxpPg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3eb08d8d9e7so115317f8f.0
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 11:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758133631; x=1758738431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giOIiZmv6I8DqOhlCekUkvEcCR09Gm73BQos2pe6CNk=;
        b=E/oQxpPgbN+RivgGRHA26H06/xO/6xjGCjKsuTwE26pX2Gil98zJOJ0eZNyakWzGZv
         MNXZatEey3bpWlrXnJgHsmr6zXBEL/pHdCZivc3Akcyz5TIAtkgkSjMBlMJ6VufwlBqu
         IqyP6jZsnhUZ5V+ILt5mdYzC6p7xrSGLhsYXfRA+Kmuh/tem/vm+xv36h1fEocy9hyTI
         pV5o9YJRa8q36khuswddE6S0Rdmg2LJyhmc3s3geUpnD2WbK+IMphxYJvFSK9xcaDRJ5
         y4AoxArIEh3D20FUdzFwtfnuWdQOq1NjCe3IN+2N5TFliYQDUZ3M/wLdYp+2IntXO5LM
         PXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758133631; x=1758738431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giOIiZmv6I8DqOhlCekUkvEcCR09Gm73BQos2pe6CNk=;
        b=Od/ZdJ5y+J1qGkWQd2kwyU/S8wZfPZr0WuJDb3G21Dgb9PNvhWcGz6DApRFtLCGQXn
         eyYJPssFQ5Zl7NmGzcW4pxI+IDGYfFElRfCQhrWx3pLzJJ4u/b993nW759nRLWMYoErj
         i56myX77Ytq2embazxUqPbskyY5nagTdFlRhoNksXa7mAzhARjyRW7zNkfPgCm5OyLIh
         rEY0/zIS82cHqZQi3FTx+WfTUoeuUHpEJkgRWW/WXYE8+kfMj/scoYdUItZ8YnEC9e+z
         6LO1bSP9YCEM6EvyddSsPbN1ZEZY9E7i58FKLhfGfJmJn8b1DK5YlxSRGOcQHeR+TQ9P
         5tMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ1LjlceBatVf0eqco9StdkDV61M/sQWgHd/Nx1Q5CtGpJohkZFV6oRklAJJiSnjSsKYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv4aIdDG4EbN5PSlhPUtOPyE8HHQePeymeWbXHnKDKlgEhSiBD
	78kn5WIOaVaGuIVDoMkwJcTJjMLqmeKdVsTYU0l4seqBXj3gsNSaTRQYcLZEL/kmvpgzT7mdYCA
	selktWoDywEshqO8xOXIpdYWccX6rbgM=
X-Gm-Gg: ASbGncs1KObN1Ic7ZkWyQZiBdwVcQYoZDckGMUl0GoTxxR8XwAQPe45WIv7zB/d3Esg
	wlyuRwx9Iw4fKriEVAV5VBOyGQVbu1iI0Za5V/59T51l/m3Yx2AH2PukjO6EFdf35FRz7S31hFf
	ysvmBDTa5ecqFlEb4LgOeTLneBuJLNZAv7F3fIGC6BQoRd57KAwXt5f3P3yJExj/veynZV9+/ni
	trvpjqyexUFmcHPSzohvilqqdgPZ3LMdGXyifS9OKMD1NY=
X-Google-Smtp-Source: AGHT+IGIjDIE66b7poTQjbUsClk+JTa8i87RedpfgKqXFvYZF5/Mwpf7vxUqOeoC4SPPIS3ebGzBC4ZDuD2hxOymUMo=
X-Received: by 2002:a05:6000:24c1:b0:3eb:2832:96c with SMTP id
 ffacd0b85a97d-3ede1c74f09mr448260f8f.31.1758133630484; Wed, 17 Sep 2025
 11:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916022140.60269-1-alexei.starovoitov@gmail.com>
 <47aca3ca-a65b-4c0b-aaff-3a7bb6e484fe@suse.cz> <aMlZ8Au2MBikJgta@hyeyoo>
 <e7d1c20c-7164-4319-ac7e-9df0072a12ad@suse.cz> <CAADnVQLNm+0ZwX2MN_JK3ookGxpOGxEdwaaroQk+rGB401E8Jg@mail.gmail.com>
 <0beac436-1905-4542-aebe-92074aaea54f@suse.cz> <CAADnVQJbj3OqS9x6MOmnmHa=69ACVEKa=QX-KVAncyocjCn1AQ@mail.gmail.com>
 <c370486e-cb8f-4201-b70e-2bdddab9e642@suse.cz> <CAADnVQL6xGz8=NTDs=3wPfaEqxUjfQE98h5Q2ex-iyRs4yemiw@mail.gmail.com>
 <aMpdAVKZBLltOElH@hyeyoo> <aMpeADsz1Znaz8AU@hyeyoo>
In-Reply-To: <aMpeADsz1Znaz8AU@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Sep 2025 11:26:57 -0700
X-Gm-Features: AS18NWAFnsgy5aitphu3UPL49R51UGNv6gxHVzc-JxbR8L-AQ1LExbbnhT_DQj0
Message-ID: <CAADnVQ+sKKV+-Ee61Bxma+=MN4unGLRypAnfqHuLOtHM6T=HEA@mail.gmail.com>
Subject: Re: [PATCH slab] slab: Disallow kprobes in ___slab_alloc()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 12:06=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> w=
rote:
>
> On Wed, Sep 17, 2025 at 04:02:25PM +0900, Harry Yoo wrote:
> > On Tue, Sep 16, 2025 at 01:26:53PM -0700, Alexei Starovoitov wrote:
> > > On Tue, Sep 16, 2025 at 12:06=E2=80=AFPM Vlastimil Babka <vbabka@suse=
.cz> wrote:
> > > > > It's ok to call __update_cpu_freelist_fast(). It won't break anyt=
hing.
> > > > > Because only nmi can make this cpu to be in the middle of freelis=
t update.
> > > >
> > > > You're right, freeing uses the "slowpath" (local_lock protected ins=
tead of
> > > > cmpxchg16b) c->freelist manipulation only on RT. So we can't preemp=
t it with
> > > > a kprobe on !RT because it doesn't exist there at all.
> >
> > Right.
> >
> > > > The only one is in ___slab_alloc() and that's covered.
> >
> > Right.
> >
> > and this is a question not relevant to reentrant kmalloc:
> >
> > On PREEMPT_RT, disabling fastpath in the alloc path makes sense because
> > both paths updates c->freelist, but in the free path, by disabling the
> > lockless fastpath, what are we protecting against?
> >
> > the free fastpath updates c->freelist but not slab->freelist, and
> > the free slowpath updates slab->freelist but not c->freelist?
> >
> > I failed to imagine how things can go wrong if we enable the lockless
> > fastpath in the free path.
>
> Oops, sorry. it slipped my mind. Things can go wrong if the free fastpath
> is executed while the alloc slowpath is executing and gets preempted.

Agree. All that is very tricky. Probably worth adding a comment.
Long term though I think RT folks needs to reconsider the lack of
fastpath. My gut feel is that overall kernel performance is poor on RT
due to this. sheaves might help though.

