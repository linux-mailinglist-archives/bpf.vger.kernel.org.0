Return-Path: <bpf+bounces-21686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5918485028B
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 05:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A973284330
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 04:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A58923CA;
	Sat, 10 Feb 2024 04:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bapohd0W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3316F8462
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 04:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707539716; cv=none; b=YnjtELpccVAaUbVs5Pg62gk1WTq9hw+vVvYytdLebD6r0EHHnv/jFvlLvibS5K83ioDLyMcTB7DNQNP6PYjCaOcGOOiF/QQNUFwNlgI7jvC2qZWXu39iTtEON4jSkRgdT5jAr86MCHJscILYZ4ADKy345PKLqDizilJfD9eRlGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707539716; c=relaxed/simple;
	bh=CD+TybYfqMK6NarsAhKItCooYAQKUbEMZAMyjpYMdlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMkB5Qgm8SeZojuEhxHweTsdJBsHK6yPdT59qQkrM7D2wqsrV0yFZbBD4/qzvoBix4WG+02T0QU4gYba1JBWk9fEc2azdGxujrJGC8w1G3x0pJ/aEPIMYxMsPjkDys+D0n80Vz3lRBM5A2BOoYXYCY82K0Gx9JEFjyh9Q1jPF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bapohd0W; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51165efb684so2793662e87.3
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 20:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707539713; x=1708144513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EelMK3MNqQ7kc2Ty0nKSU3ZVwcIo6iAgFWKPjvAcvk=;
        b=Bapohd0WLpMT5/6yeEZl7PaOrgrEkyT7R7C7rtl1syw9vh8tCvNNzqA6s5kYstAEc7
         NB4Y9zy0hRev5xYbvGCQLk6pyCEMwPQTmiK+r6ci32J4ekh1kR/QQ9uSfUTmdaSixyMx
         0HGZpr8JgCSs5rs9tPQJx8dm+BRas3gLRXIH65G8k9qyCXM3seMxRzqTTkNsHg1uzMDd
         ScWk8dZy5D3TgwNAp1LTi4HTT7d2l2hPDSWwQyLXBcr2+iAHkO9c6VBhI9HZ2w4XhydT
         lww16/5fp02c6d/uZoHyY4eGyMKw3IFQNRbdDejEHOTT0Zxl51OBB/AbZrnBGEmp0Xog
         GUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707539713; x=1708144513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EelMK3MNqQ7kc2Ty0nKSU3ZVwcIo6iAgFWKPjvAcvk=;
        b=cG5hBdw7nomTQuFDHV+IIsG0c9WVr1umLRG5B5RvgVt3TN3mehPHekp3ptCIsitAvY
         ILdk0rnNxs6ztYp7H/r3cXeb6YYXyszw/5Hltm4cus5la2d86nvmKBOV5I7+hsR9gNTs
         iiTk1K8hq5Cn0RLcgWnMwRGzV7/PDB7gp4LiO1SedTelOpNd6P58k+ZFFZPobWnxfcWM
         I/FMdYEHrY14xIXjKSnMV66Xxum7Pf48UBOKSO/f5+zUBeafrucnzCvyjZsIjMPPwxiP
         irMF7Hxv+RsGdjcfNfVqhm90IvLv9GofG3+Kcl/uX9tTEv6Py2+YHsTysvZsKiZwXBYx
         4Z8A==
X-Gm-Message-State: AOJu0Yz6JPm0FN8Atw/0aC/NlkUh0iBlAy0jp7cFxWQCpf07n9MTCDlk
	MZgOjOUtrFtN2fOi1JeOsPJmMbwmlVJ44YWfvoRknj6Rg/L5QenMG2T5GDrzmHuRxyoHvo3Vsli
	rTglAhvMkxIYnakU6xxCt2aqPLqI=
X-Google-Smtp-Source: AGHT+IF+y/dAhddg2G9++QGcoCfVBM8iGq8fEgZ8U1iiAhwmWIH5JO54RAihATpQnmZtdbCjG/ShsWTjGvD3Lpsgwew=
X-Received: by 2002:ac2:593a:0:b0:511:71fe:dc10 with SMTP id
 v26-20020ac2593a000000b0051171fedc10mr582654lfi.10.1707539712964; Fri, 09 Feb
 2024 20:35:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-18-alexei.starovoitov@gmail.com> <20240209231433.GE975217@maniforge.lan>
In-Reply-To: <20240209231433.GE975217@maniforge.lan>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Feb 2024 20:35:01 -0800
Message-ID: <CAADnVQJsdbUuvkp67_z5xprA+UP=O9rTcwm3xRkpqSArrGqNaA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 17/20] selftests/bpf: Add unit tests for bpf_arena_alloc/free_pages
To: David Vernet <void@manifault.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 3:14=E2=80=AFPM David Vernet <void@manifault.com> wr=
ote:
>
> > +
> > +#ifndef arena_container_of
>
> Why is this ifndef required if we have a pragma once above?

Just a habit to check for a macro before defining it.

> Obviously it's way better for us to actually have arenas in the interim
> so this is fine for now, but UAF bugs could potentially be pretty
> painful until we get proper exception unwinding support.

Detection that arena access faulted doesn't have to come after
exception unwinding. Exceptions vs cancellable progs are also different.
A record of the line in bpf prog that caused the first fault is probably
good enough for prog debugging.

> Otherwise, in terms of usability, this looks really good. The only thing
> to bear in mind is that I don't think we can fully get away from kptrs
> that will have some duplicated logic compared to what we can enable in
> an arena. For example, we will have to retain at least some of the
> struct cpumask * kptrs for e.g. copying a struct task_struct's struct
> cpumask *cpus_ptr field.

I think that's a bit orthogonal.
task->cpus_ptr is a trusted_ptr_to_btf_id access that can be mixed
within a program with arena access.

> For now, we could iterate over the cpumask and manually set the bits, so
> maybe even just supporting bpf_cpumask_test_cpu() would be enough
> (though donig a bitmap_copy() would be better of course)? This is
> probably fine for most use cases as we'd likely only be doing struct
> cpumask * -> arena copies on slowpaths. But is there any kind of more
> generalized integration we want to have between arenas and kptrs?  Not
> sure, can't think of any off the top of my head.

Hopefully we'll be able to invent a way to store kptr-s inside the arena,
but from a cpumask perspective bpf_cpumask_test_cpu() can be made
polymorphic to work with arena ptrs and kptrs.
Same with bpf_cpumask_and(). Mixed arguments can be allowed.
Args can be either kptr or ptr_to_arena.

I still believe that we can deprecate 'struct bpf_cpumask'.
The cpumask_t will stay, of course, but we won't need to
bpf_obj_new(bpf_cpumask) and carefully track refcnt.
The arena can do the same much faster.

>
> > +             return 7;
> > +     page3 =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0)=
;
> > +     if (!page3)
> > +             return 8;
> > +     *page3 =3D 3;
> > +     if (page2 !=3D page3)
> > +             return 9;
> > +     if (*page1 !=3D 1)
> > +             return 10;
>
> Should we also test doing a store after an arena has been freed?

You mean the whole bpf arena map was freed ?
I don't see how the verifier would allow that.
If you meant a few pages were freed from the arena then such a test is
already in the patches.

