Return-Path: <bpf+bounces-40018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B91A97ACC0
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7781C22083
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1C015358F;
	Tue, 17 Sep 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0peoFGU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830EBE4F;
	Tue, 17 Sep 2024 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726561200; cv=none; b=oV5yBTFetUOqKzYm4VcU5Z7wXmJjcpoA0JVd7UCZBYMXjAj7C4ojwQj4dY5/g3qhiyeUqbQPF56tMiJgctf+tKLgBkEKHNXuCl95R/t4IVzWhueYpJ8hdPXT6IT5OCfLFZBgyC0p3UcGr5VGKIUO4c8OhYSOW9kUFpnIuorUym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726561200; c=relaxed/simple;
	bh=WEvMu8Kwbzd+aVnz8UN6VDyrXN83El98kYTbr6vkoMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqQYIKkoy5q98nV5UQML21zJThkLWmMIqitP9wBHA6vPD9x9LDWvr3TotahszZIIhX1kgNSw+ee+2KNjKx/L3lkvgg6TJsPgb+EvikQqKS4MG2Ue+4gVghjNU8PlnvZfILkvm5XJ+8D7pLPyxErerCCicXYhBzYqziNBlJEtJ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0peoFGU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2053f6b8201so50234685ad.2;
        Tue, 17 Sep 2024 01:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726561198; x=1727165998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62qrnE8pj3OOeoUczDjNWSRiDCBubxYi7zDU0C08Cg0=;
        b=e0peoFGUcq0GKr2K8HmvOo+QCl8SR7uqrQ84VyNh2qXjBqULjjH6UvxcIXBQ7/seUT
         A/eSkiG3hNvuHFdINsfKJ244T7mwG0dGUCkeiZql417ZwQR7jC+KGc/65WQ2I6lQqh0Z
         StigK+XBr6aIsf3Td8fGPizZboq+PkWlA+jCxRmXFharY+oDLC0Aba+ojZunGRfmI8XB
         gAJq9HG9NguJXQCcxNZOb3b4v+TbMkpPvpeBRmoGc/nnyhEzDWYGH7dHxgspFsxNWdjX
         tB6V7U80P2sVV167tsu47PBE5neUErm2oBAT6Svz3ZlgsjS+ZwYwD7WvvkTbYSY5Wj+o
         56xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726561198; x=1727165998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62qrnE8pj3OOeoUczDjNWSRiDCBubxYi7zDU0C08Cg0=;
        b=gfplR4EklHOh+wCvwsFTQIgvE5I1TdpcxKgJT6pEeMVgnuEbGYZcRJW8YpDxmfzz7k
         MexlU9c2PhN8M7LOyNnJVPro7Z93SPcsYvZ5j9LeqHSU/Q/unmsUIm7c4WHHzWatIJv1
         7Oug2fWFH0HbYQ2WhziQXGlQM0tPY5fjG+friUlH6UQu+d+05LsuojMuGFiOrm31rqnS
         naNLYYM0GzrW6hQNwI4uKHnQV9ASUm5OowiWlrExeDbJeQuX0DrFYEqN9+QcHuN9w0a2
         DVO0151GAlMnHhPCvzonpJNSB3Nd6pLMa1sgsRqONm+Y+cY33e6Q9lrFcVNEUKFJclYQ
         eu3A==
X-Forwarded-Encrypted: i=1; AJvYcCU/4ME60HA5rsqOfVfxtQessaFQzg+eV4Z9+COwO9l0uDIvwSnO0/bljZaiXyxusa9aPW0QnizzP6y72SS4UXa/Nv/+@vger.kernel.org, AJvYcCVQFnIcwRoUHzV5wKAr0cYunxfbmRX2zTq/tKSjKo1x6RtHJHnqP49DcCR2SY2wfVznEujZBmjCNsq+lx6n@vger.kernel.org, AJvYcCWn6ftRGngRInNzJvD/IYChMMkyorP9ESS1twImTAXvFpjwFRkq5189iceQRtfrg2jt9Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvf5vkb6r0Z7Bd5JBLvZkDkIe5qZned5Pbo00Mka05FcDcoR8n
	87kW7r4CfZG4lRNvbpPCjAw7ka2Ys2GV6+L3eBwsn9FoevOMmEWcsfGMnMV+jQtiIvHnkeM0Fyd
	gr0HB+4Ycv1Zd8Ywtt6OfbTABUCI=
X-Google-Smtp-Source: AGHT+IEVhLBhSwOagybbRN8ICxXcGMdAre6M3HGdAN72GMKM5GOvHwwmEwDp7gSujPDbqMOawEJTvsQ9t/TNupuNMxU=
X-Received: by 2002:a17:90a:ce01:b0:2cf:fe5d:ea12 with SMTP id
 98e67ed59e1d1-2db9ffb8564mr22352587a91.24.1726561198561; Tue, 17 Sep 2024
 01:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-3-andrii@kernel.org>
 <20240915150429.GC27726@redhat.com>
In-Reply-To: <20240915150429.GC27726@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Sep 2024 10:19:45 +0200
Message-ID: <CAEf4BzZjjA=PMOES-RyQ9Xyi_UEKGa7_qFunwi4w7uY3qDLiww@mail.gmail.com>
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless VMA-to-inode-to-uprobe
 resolution
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 5:04=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 09/05, Andrii Nakryiko wrote:
> >
> > +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_=
vaddr)
> > +{
> > +     const vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
> ...
> > +     if (!vm_file || (vma->vm_flags & flags) !=3D VM_MAYEXEC)
> > +             goto bail;
>
> Not that this can really simplify your patch, feel free to ignore, but I =
don't
> think you need to check vma->vm_flags.
>
> Yes, find_active_uprobe_rcu() does the same valid_vma(vma, false) check, =
but it
> too can/should be removed, afaics.

yep, agreed, I'll see to simplify both, you points make total sense


>
> valid_vma(vma, false) makes sense in, say, unapply_uprobe() to quickly fi=
lter
> out vma's which can't have this bp installed, but not in the handle_swbp(=
) paths.
>
> Oleg.
>

