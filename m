Return-Path: <bpf+bounces-37050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B702950936
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 17:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33C3B23442
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC80F1A0714;
	Tue, 13 Aug 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIJb49lB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8CF1A01DB
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563378; cv=none; b=uLqaNIMajXb1JYl/Z8Xi10Eu1awurUoHHc37gvBEdGwhEOVyyrD33hLy6p10ZSs/Ee71UX8ji8YxvKBbRbDM5z97YvrlP/nJT6GrbA8B39Y25vu7HcsGXZaEqLwAWR+zj+SWGQTAsH8ZvmMw/xHVBl+HzpQkzDAVqzFpARKdgbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563378; c=relaxed/simple;
	bh=8XN8l1jauSNkrNY6DVaHPyqTBlKmM+vQ22mOTXq6Qk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjaPJn6yfQeV6YohPGO8I3aoCKnLiK7CGH0JfsUmnR+RmyVb+e6H+gd5IzFZ4ZXEGbutdiqZbx1pW9srEKw9N7NyzauWF0sf45rclRVAjv9xSORaUT5kEnrwPhYo/O5Ejg6izQ5jxiPUFddvr/3CM5opbcY7VIgE3InpiRi58wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIJb49lB; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-66c7aeac627so52882517b3.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723563376; x=1724168176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XN8l1jauSNkrNY6DVaHPyqTBlKmM+vQ22mOTXq6Qk8=;
        b=uIJb49lBjwhjsM7YyoerXyRVX3gB43sgf3V+wCC+G7+gorz8W9mrsqUD0+Kt/HjK8n
         W1cqPRfYIcA7xgG4ddc6Obe1JPPkkoLCaMaRd8FzzWpzhTxXP+I+/CRrNhq2ws7buw4c
         A5sTpi9i1RNaz+Zxvowl4+hw/B8AJCa7jcq2UuZvAnt2+ZYwhWF5o7bUUhEMm6NWUqi8
         fWNcfItBIY3cPL4QJQTN7UrzwH8jQcMd6REatXPcBkB6tCNIA7yfY+PpEq2ikFt6TVHL
         IkOa7324BVSSrN6o+GqNoW/j07XO7/fMB0T5B4sPSnK7zWHBYfNhdvET/pi1mNyPj5eE
         GAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723563376; x=1724168176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XN8l1jauSNkrNY6DVaHPyqTBlKmM+vQ22mOTXq6Qk8=;
        b=F18/LHZDtHp5PWmJkyJJ8umNNRZFosE9TBpI0qfiAGt1JlS0DDqraTJMKsXe72kI5w
         WKC4JPrYirNGfEkKlx/2kwUXGqCd3M/CKBi9k0MYQlcztNic6TfNfT+xtWm3egTJldfN
         qjLQIH+8/4Np6b2wqPILlHAbgRRgbywfLPeQGSyv1QJ0YFntMTO5IhZLFjz8wBOAyK//
         XE39KZAx1K4kbPB6waYoTQzSQqQpRYgEK8pIw1x98unaCv39ydxY3u0kgFlsoOV1k78l
         hdlzuW8hywPsaqbEze10uTaCtjxqU88/e58NQVOnc3TXGqLXV+pjMux1WJXeLzltx1Ol
         aKaw==
X-Forwarded-Encrypted: i=1; AJvYcCXHs5QxNa2uBWg1rFytuOuNjcTcB5HDtjgcX/39PcoU+L/lGaU2omgBMiEFToxC+VbX/G7go0grRWSjYiZrANEmCJgb
X-Gm-Message-State: AOJu0YwWH6uMnv6+L97Q8X+qPXcr+0RgUa/xwMcDI4Jrfby78GAnSiLw
	JV1WYN3gdXi8T7aLqjBzknYPuJH3FA+5IQNOpX1WN0iVRBAUwFZ0I/z46+K7q2ahrXP6gvrA0JU
	/3ENRR6bWPfn95fHjvH+MRlDp697cYJyNcAjg9HVYCuAz17GhXXPt
X-Google-Smtp-Source: AGHT+IGewMdQHdmN2hlq9rjJ5cHzdQ207H+U5ZLcJ+Wx1W91wONKxrCoPZpU6MRnXFPoSPwcwCTkkq02/x8cYLzztA0=
X-Received: by 2002:a05:690c:ed5:b0:632:c442:2316 with SMTP id
 00721157ae682-6a97142715dmr47043317b3.3.1723563375488; Tue, 13 Aug 2024
 08:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240813042917.506057-14-andrii@kernel.org>
 <7byqni7pmnufzjj73eqee2hvpk47tzgwot32gez3lb2u5lucs2@5m7dvjrvtmv2>
In-Reply-To: <7byqni7pmnufzjj73eqee2hvpk47tzgwot32gez3lb2u5lucs2@5m7dvjrvtmv2>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Aug 2024 08:36:03 -0700
Message-ID: <CAJuCfpG8hCNjqmttb91yq5kPaSGaYLL1ozkHKqUjD7X3n_60+w@mail.gmail.com>
Subject: Re: [PATCH RFC v3 13/13] uprobes: add speculative lockless VMA to
 inode resolution
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 11:18=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> On Mon, Aug 12, 2024 at 09:29:17PM -0700, Andrii Nakryiko wrote:
> > Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely access
> > vma->vm_file->f_inode lockless only under rcu_read_lock() protection,
> > attempting uprobe look up speculatively.
> >
> > We rely on newly added mmap_lock_speculation_{start,end}() helpers to
> > validate that mm_struct stays intact for entire duration of this
> > speculation. If not, we fall back to mmap_lock-protected lookup.
> >
> > This allows to avoid contention on mmap_lock in absolutely majority of
> > cases, nicely improving uprobe/uretprobe scalability.
> >
>
> Here I have to admit to being mostly ignorant about the mm, so bear with
> me. :>
>
> I note the result of find_active_uprobe_speculative is immediately stale
> in face of modifications.
>
> The thing I'm after is that the mmap_lock_speculation business adds
> overhead on archs where a release fence is not a de facto nop and I
> don't believe the commit message justifies it. Definitely a bummer to
> add merely it for uprobes. If there are bigger plans concerning it
> that's a different story of course.
>
> With this in mind I have to ask if instead you could perhaps get away
> with the already present per-vma sequence counter?

per-vma sequence counter does not implement acquire/release logic, it
relies on vma->vm_lock for synchronization. So if we want to use it,
we would have to add additional memory barriers here. This is likely
possible but as I mentioned before we would need to ensure the
pagefault path does not regress. OTOH mm->mm_lock_seq already halfway
there (it implements acquire/release logic), we just had to ensure
mmap_write_lock() increments mm->mm_lock_seq.

So, from the release fence overhead POV I think whether we use
mm->mm_lock_seq or vma->vm_lock, we would still need a proper fence
here.

