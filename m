Return-Path: <bpf+bounces-40267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E3A984A91
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 20:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614C71C230B7
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 18:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FC91AD3FC;
	Tue, 24 Sep 2024 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6S3Lxaq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B989749641
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200875; cv=none; b=fJs45VFWVq2kqQHNf8OAbFu8AUjx54wrKhisOX0jWEhQhWgFy6EXWyDwXFInn30Oq6lCVoT4SXFE+2IzIl1sf7GyUD51fn4e3UdEcuQ/OdMXWky7fbGbfQdHoMrBkTIu5q+e8V+hmwDWmcbFmQMyt4R3mqhoirTdARO+VxTEiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200875; c=relaxed/simple;
	bh=A15kpu7Y1O25FNXdv/Y2yPmP7X/PnOCFalZNHC+1jXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJQFQs8hoFxhvO7IHLQFeidLoanYGGZY8z4sAMqYCQyQErZutngt5xUxTQas8wOeiMppx9mgGBfT4XMWmwk+BpuLmMGFAaaNcuXn0Z6sF/xNa7ptnbk7w0PfbkYVPI/hAdA3YkrleaYxb4fdRJH4c/PPzEq+4D2Gwy0pW5p5wls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u6S3Lxaq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c2460e885dso2392a12.0
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727200872; x=1727805672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjhiFYP9ZLzgH4eZvCkFY1gAOy9o8UQ0O08H+0Dp/FU=;
        b=u6S3Lxaq7PirxiNRfIobA4VEYipLwNJiv9uvjIe+0hMb9qOuzLDwR8yjYHMSa72mJx
         kSxC5LIKd9i+4cg2eyOfoik45g9v8DTGZQi9dsBV06BuG0CWRoyStJbX89n3kPBJABvf
         04EVIriLmSDI4qoL/D+UiUfTSnUJc5f6KmM9/nLK+QLCOQAvTguHIhlgANBHDWKBOM+N
         WWyxJenBLNmwVXI03ZG/zqBH04R+Y9UM1zqhTgL6t+jKf+wDdd3x27s6W3+UCWNgkBUf
         o9pVnQKJ1X2EOWQOPLqlBO2KHgqPlMTZZAam8djiwcWn0H3J2DTfpgGk5Qk1W0cdrDty
         f5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727200872; x=1727805672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjhiFYP9ZLzgH4eZvCkFY1gAOy9o8UQ0O08H+0Dp/FU=;
        b=XeFEvARyxufzAVgJo+qpON0VKZBO1WTYc3DLtuV+Q4tVpda8TLIrB61mjUr3yX66II
         SQc3WM2z06l0NpDAW7bbPA2nJER/q6QGo4efcyZ+BpLIwzhiRHz9qV+H4OlynTOJzRjf
         q1x4Him91RZ+rN5ZjNj0CeJME39kgtsAKsgDOE29UOq101zYSqFzGa0qKBjp61RTK1Sp
         pXxuaKX+2oS6oaG+VZVxhiPmm5aXfUxaXKs8bHMV54bIti7pR+ewuNr4rdte4heY4iXE
         Kz3O4OSwE1eKk0D8k9WXJ6RBBQykyx0OsDBsHrfZeIaG5ra/yCNQWpHmBGJd/GUXJ0U6
         ixKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj3WGf3TWQrIJ/S0qS7awrwq3HQxmxJe8oedqGoswloWTkylqDIK2zDaQJMoXoIzG8BPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUVsnEyGxD/w7Lvx+ckRI6huMH+rNawXxqf1vFlsGRKe3esm2a
	WOQDb6CsNkNRRzublg/vznOFm4tkf8dAEwWlRe9LNfIiGZ7j/7BtjhQ6u8XD/+DZT8fHUJqpXDO
	jmkr9CqobR5rpCD5g1VxNMjC5u9Zt4Mw7cA7mkSugv3d4cnitx0F8TRM=
X-Google-Smtp-Source: AGHT+IGauZmcTAmbWAYK0JUSi5/BirlMPx1JVwLFWuHaMRUoRmepOtiQ7z74xNp5Rgwdm/FNTBH4pFL40akueNX7x10=
X-Received: by 2002:a05:6402:26d3:b0:5c5:c5fb:d3f0 with SMTP id
 4fb4d7f45d1cf-5c7209c91fcmr22261a12.4.1727200870366; Tue, 24 Sep 2024
 11:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpFFqqUWYOob_WYG_aY=PurnKvZjxznnx7V0=ESbNzHr_w@mail.gmail.com>
 <20240912210222.186542-1-surenb@google.com> <CAG48ez131NJWvo_RrxL7Ss0p4jd_aKOu71z1vm9wfaH7Qjn+qw@mail.gmail.com>
 <ZvLzueEY9Sbyz1H4@casper.infradead.org>
In-Reply-To: <ZvLzueEY9Sbyz1H4@casper.infradead.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 24 Sep 2024 20:00:32 +0200
Message-ID: <CAG48ez0c=ExHdoxQWqDN9hFAhwUKab8vgk-nJ-JGqTUm4xVUsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 7:15=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Fri, Sep 13, 2024 at 12:52:39AM +0200, Jann Horn wrote:
> > FWIW, I would still feel happier if this was a 64-bit number, though I
> > guess at least with uprobes the attack surface is not that large even
> > if you can wrap that counter... 2^31 counter increments are not all
> > that much, especially if someone introduces a kernel path in the
> > future that lets you repeatedly take the mmap_lock for writing within
> > a single syscall without doing much work, or maybe on some machine
> > where syscalls are really fast. I really don't like hinging memory
> > safety on how fast or slow some piece of code can run, unless we can
> > make strong arguments about it based on how many memory writes a CPU
> > core is capable of doing per second or stuff like that.
>
> You could repeatedly call munmap(1, 0) which will take the
> mmap_write_lock, do no work and call mmap_write_unlock().  We could
> fix that by moving the start/len validation outside the
> mmap_write_lock(), but it won't increase the path length by much.
> How many syscalls can we do per second?
> https://blogs.oracle.com/linux/post/syscall-latency suggests 217ns per
> syscall, so we'll be close to 4.6m syscalls/second or 466 seconds (7
> minutes, 46 seconds).

Yeah, that seems like a pretty reasonable guess.

One method that may or may not be faster would be to use an io-uring
worker to dispatch a bunch of IORING_OP_MADVISE operations - that
would save on syscall entry overhead but in exchange you'd have to
worry about feeding a constant stream of work into the worker thread
in a cache-efficient way, maybe by having one CPU constantly switch
back and forth between a userspace thread and a uring worker or
something like that.

