Return-Path: <bpf+bounces-22222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6DE8593F3
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 03:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9711C20C3A
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 02:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEC11103;
	Sun, 18 Feb 2024 02:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkrz7uci"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F6FA29
	for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708221990; cv=none; b=SCJqkT3VYB7p/V8fStA1q1wcdz8ulqm7dkA5YUIaC6rd0se+wtDp6bj+2Nrd8xhRzjNTGxy8Orw1XuDm5trBEMYLM2zzYWXxhbE1DZGAldeBUKBGQQLwxg0v8kN51lIJ52tMf9QRRUkC0nLHhGmUPF2A0E8XtquKQEK4LzkLp9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708221990; c=relaxed/simple;
	bh=lZkOITWb9nU/weIsGj4C9MlqOJDG54M2Z4Klzqq2rro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuqRwfqnBjUZK0OvfB0V4ZqCt7NModbMhXWTi1quLFTjuW5/whgjF9HkpdlrYAYKKDSOXASBvGD4MZLFP8rcATCoRYErRSCGHjw9Oj0eOw8I9YO57iCXDCSDe+EdSVZGORwjY6n4MMB0540oiDmuUzbnXB8a142Zm7jZg2vtF+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kkrz7uci; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d3f0ed7b5so80310f8f.0
        for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 18:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708221987; x=1708826787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LspqbKL7rNz4iyMpDNG6Id9vnYOGttAUTDKHLylKfyM=;
        b=Kkrz7uciz4JOdDQVLfGEk0aGg/qhAhhRBLlcWHelaLBuasLFXRXpFFfYfh8RKkwrBR
         FNRSdoxuBz7qzsZNaqWYMX0UKP/ON+ce2K9C8DJi5ejqZ7OrEbjVSqoFlRTrP2e+vdPl
         ZNnOP2h6f+Sz67MzuLMrHl19WLTuDGAN7SG1lmkx2Y9snaqAPeEJl6m2oN9nTeURg0NA
         dvzuRt3MKg71VsQqDQDp8IfYD4oq81n0nHysEGq0249UzLV2BYfLZkwqxLMb46iazwTx
         m6LCqlSX8wrAKFFia0s8lFCKurIflRJvqITtSHjaPdSM9zPYNBeufb34ALfRaVP90vQN
         uPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708221987; x=1708826787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LspqbKL7rNz4iyMpDNG6Id9vnYOGttAUTDKHLylKfyM=;
        b=WzMgrhnbniNvHK4efzFNnk2t7duu4V3bfFFknv+BBWyuMZsMI4MpcJJjDIQ7Odeai+
         W3Dhl4c9vKfTLmDkdZ3C9BRd4PFCc+V/jzhrr42Nm4SE2sg9WN8XdNBwJZZC9V+Lflv0
         Pv8rdKTXlxlFh0aQiZhmrj3ipoHfIEDV0UaaHWc/exdPavi1YbtX+3sWQ1i+Hd46vbZX
         E4YfT3XAGpCE0++PxOjUTh1uSIY4YIY+oOYXxLow7m3nEpgOU/Eo1CP1juJ/Zexe5HlO
         S4YJiiaXnD1slJbtuwHcK0IML7ipXJHPIBfCA+1B6urfzTthbuY+tcuit7W2k35rvudC
         hjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZFtXMBr1ywn8sZG5Rs8WaPK+MiIfZqWVkMzjWi0+Rlm+rvq5wvBZefdde3NOe8QwQKqv9BPsxYevhzlpJgicXWHZS
X-Gm-Message-State: AOJu0YxWL0tNvnuNFLm21UOdu3R+JWjl3c9lSd53OiSXG0OlKyazgOwg
	FQ0BHePZo3Nbb5Ee/vG9ylldBP1nQrtTL/FDvFySyMk75zhVNoWD1bAGDUSHF3lUo2PAtMcUBK6
	y+MCLchTRWQ35TzHCKuAiF2bH6xo=
X-Google-Smtp-Source: AGHT+IF2lGt0lJf+WbTVS/XPc6/xOZw7ZUacoVQDVPx7K8ic1lgKflcPDrQY5Of7C9uiS+cOXF1PY24v4Kc5nIMBU5A=
X-Received: by 2002:adf:e6c3:0:b0:33b:8257:c66f with SMTP id
 y3-20020adfe6c3000000b0033b8257c66fmr6230404wrm.5.1708221986973; Sat, 17 Feb
 2024 18:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-5-alexei.starovoitov@gmail.com> <Zcx7lXfPxCEtNjDC@infradead.org>
 <CAADnVQKT9X1iSLXojVs1sWy4B-qEGccuk6S6u1d9GBmW9pBAeA@mail.gmail.com>
 <Zc22DluhMNk5_Zfn@infradead.org> <CAADnVQJ8azcUznU6KHhwEM99NUOx8oai8EOyay4dxLM6ho8mjw@mail.gmail.com>
 <Zc8rZCQtsETe-cxU@infradead.org> <CAADnVQJ_rn+PEETAApwK6iW5LYxGh=-rijpfTB6Y6r8K6sG4zA@mail.gmail.com>
 <Zc-Y09fYxwbXOWj1@pc636>
In-Reply-To: <Zc-Y09fYxwbXOWj1@pc636>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 17 Feb 2024 18:06:14 -0800
Message-ID: <CAADnVQLDCXp0UNY2P4ZvjCRwChARw91TpMfn3H+nuEPJLSirfA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/20] mm: Expose vmap_pages_range() to the
 rest of the kernel.
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 9:18=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> On Fri, Feb 16, 2024 at 08:54:08AM -0800, Alexei Starovoitov wrote:
> > On Fri, Feb 16, 2024 at 1:31=E2=80=AFAM Christoph Hellwig <hch@infradea=
d.org> wrote:
> > >
> > > On Thu, Feb 15, 2024 at 12:50:55PM -0800, Alexei Starovoitov wrote:
> > > > So, since apply_to_page_range() is available to the kernel
> > > > (xen, gpu, kasan, etc) then I see no reason why
> > > > vmap_pages_range() shouldn't be available as well, since:
> > >
> > > In case it wasn't clear before:  apply_to_page_range is a bad API to
> > > be exported.  We've been working on removing it but it stalled.
> > > Exposing something that allows a module to change arbitrary page tabl=
e
> > > bits is not a good idea.
> >
> > I never said that that module should do that.
> >
> > > Please take a step back and think of how to expose a vmalloc like
> > > allocation that grows only when used as a proper abstraction.  I coul=
d
> > > actually think of various other uses for it.
> >
> > "vmalloc like allocation that grows" is not what I'm after.
> > I need 4G+guard region at the start.
> > Please read my earlier email and reply to my questions and api proposal=
s.
> > Replying to half of the sentence, and out of context, is not a
> > productive discussion.
> >
> 1. The concern here is that this interface, which you would like to add,
> exposes the "addr", "end" to upper layer, so fake values can easily be
> passed to vmap internals.
>
> 2. Other users can start using this API/function which is hidden now
> and is not supposed to be used outside of vmap code. Because it is a
> static helper.

I suspect you're replying to the original patch that just
makes vmap_pages_range() external.
It was discarded already.
The request for feedback is for vm_area_map_pages proposal upthread:

+int vm_area_map_pages(struct vm_struct *area, unsigned long addr,
unsigned int count,
+                     struct page **pages)

There is no "end" and "addr" is range checked.

> 3. It opens new dependencies which we would like to avoid. As a second
> step someone wants to dump "such region(4G+guard region)" over vmallocifo
> to see what is mapped what requires a certain tracking.

What do you mean by "dump over /proc/vmallocinfo" ?
Privileged user space can see the start/end of every region.
And if some regions have all pages mapped and others don't, so?
vmallocinfo is racy. By the time user space sees the range
it can be unmapped already.

