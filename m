Return-Path: <bpf+bounces-22831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F87A86A509
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 02:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3501C235FB
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 01:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEC81C3E;
	Wed, 28 Feb 2024 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCVyFltV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564FC184F
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083903; cv=none; b=BwRBvV80oiszRk8vO1da4J5VIZq4L99FTbFWpVDOBlthGzM8P/vrx3xFmwNrYQhIZTvZQf15mdGnfwbwIc0NrnRJuD+9aY3/thRb1iOtqJFi12av5YmS222wY0VwFj1/QXRIoMHrSQvJpACLGVED2ejOXsdsoCjcS8lu7/fOHZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083903; c=relaxed/simple;
	bh=8ItnNvRbX2SWsH1uTt+ise7flvo8KOnpCk15acJGb/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4+wh/mW56WcQ4vY00i9tG6WFNTaKXUTAMJx34WmKbVScEVMauJ+zYgnDzC3UjBoN19QVuGXWneM4anXBciY3beV0ymkPGxE+xwdA1pWHnD7cxPBoIXmIMTTlo+GeiEg7FQrgFA/s+N9sZ4mOjcdm+v7+mVIBj2BPkH3X6rjyuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCVyFltV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d6cc6d2fcso3062145f8f.2
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 17:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709083900; x=1709688700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQB+JZ1G68ICyO1N3p0oqOVpl3RnCmkeQUi97bJMYlw=;
        b=RCVyFltV6tHxcKhFdXildNkAC/4zV8ubrIiKXd42fH1CRsady03JhalLbKeHZS1z7S
         78J3nPTILdkLEuBzqjKkS3amSPcZ/qaEIO2o8/cCMyz55A8opp0AMAxTH3d+/kMsFZTh
         H3r4zvhvEm4p2DkBJitU4NI/2/dRmcXyDKFvuQGTU+z/nCgxEyjtE6hc4VpDcTFkDPJB
         bgq2NXgh+TvK6+3p1Tgtn5gvkOowJj/dVvL3MnpJCT4JarSAu28GV6L70S/dwy10YtYY
         GjXvSwEZg7lzjLUvsHbOy8FNr8mSnKQGeYXZvKXOSETDuwK+QAYeZgbOOHeFvjZ5OrXo
         XyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709083900; x=1709688700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQB+JZ1G68ICyO1N3p0oqOVpl3RnCmkeQUi97bJMYlw=;
        b=iKdpwbqsrpjiF2lOnHS6N/vvMAY+G/+69RzfQ1sqERhoZ0AhuRucZ8xdyVtG2ylVQE
         ay7i01FP3IXc0l3Sbs4HlzwTE/wA/pkrGDziLJIC+EwnuCq1uUxhcRGvIJS4dTlOfJVu
         rW0KgFOdqrihRb8b8uIuxmypRjUlB+VOhTXKXxlwoFUXVEjKraAptX1ehZqNXrEWk3zE
         GLNdrgxpoD5nH+r6zrxwhp1lM4tE6l+LX6Izz9/dRo3GmX+QrgYeXndlZg9pFqbp2a76
         WqCEWVGAbqSP082W/CI2oQuIgYq9Vh/I53piymmC43zk4bjxm0ugdWR0iDe7pR36VlRG
         ScKg==
X-Gm-Message-State: AOJu0YynCwdyPiztoZCczRw47H5Nxteo5OLjA9yBVqaQcyva1ei1ZDBH
	o5ZWxSniHKEfk9mZW7ZMy1FK7F0ngZjiYHPo+d0O68JJ0+oF/beO6G/IHiEOdY2lK/+tqHdqkuC
	TNGdkwBXviAg5u4jaG30Iwy09QgU=
X-Google-Smtp-Source: AGHT+IHW0RvW1Yw8eRC97o+L4oxzxSjZSar1xugDudti2CXKZy7764qOr6NgwPLSJiP97CBaYnawADxltOlqy8AvltM=
X-Received: by 2002:adf:db07:0:b0:33d:82ae:67f8 with SMTP id
 s7-20020adfdb07000000b0033d82ae67f8mr8131519wri.50.1709083899508; Tue, 27 Feb
 2024 17:31:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223235728.13981-1-alexei.starovoitov@gmail.com>
 <20240223235728.13981-4-alexei.starovoitov@gmail.com> <Zd4jGhvb-Utdo2jU@infradead.org>
In-Reply-To: <Zd4jGhvb-Utdo2jU@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Feb 2024 17:31:28 -0800
Message-ID: <CAADnVQ+f06b1hDrAyLM-OrzDfEEa=jtamJOKfEnEo4ewKPV0cA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/3] mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
To: Christoph Hellwig <hch@infradead.org>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, sstabellini@kernel.org, 
	Juergen Gross <jgross@suse.com>, linux-mm <linux-mm@kvack.org>, xen-devel@lists.xenproject.org, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:59=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> > privately-managed pages into a sparse vm area with the following steps:
> >
> >   area =3D get_vm_area(area_size, VM_SPARSE);  // at bpf prog verificat=
ion time
> >   vm_area_map_pages(area, kaddr, 1, page);   // on demand
> >                     // it will return an error if kaddr is out of range
> >   vm_area_unmap_pages(area, kaddr, 1);
> >   free_vm_area(area);                        // after bpf prog is unloa=
ded
>
> I'm still wondering if this should just use an opaque cookie instead
> of exposing the vm_area.  But otherwise this mostly looks fine to me.

What would it look like with a cookie?
A static inline wrapper around get_vm_area() that returns area->addr ?
And the start address of vmap range will be such a cookie?

Then vm_area_map_pages() will be doing find_vm_area() for kaddr
to check that vm_area->flag & VM_SPARSE ?
That's fine,
but what would be an equivalent of void free_vm_area(struct vm_struct *area=
) ?
Another static inline wrapper similar to remove_vm_area()
that also does kfree(area); ?

Fine by me, but api isn't user friendly with such obfuscation.

I guess I don't understand the motivation to hide 'struct vm_struct *'.

> > +     if (addr < (unsigned long)area->addr || (void *)end > area->addr =
+ area->size)
> > +             return -ERANGE;
>
> This check is duplicated so many times that it really begs for a helper.

ok. will do.

> > +int vm_area_unmap_pages(struct vm_struct *area, unsigned long addr, un=
signed int count)
> > +{
> > +     unsigned long size =3D ((unsigned long)count) * PAGE_SIZE;
> > +     unsigned long end =3D addr + size;
> > +
> > +     if (WARN_ON_ONCE(!(area->flags & VM_SPARSE)))
> > +             return -EINVAL;
> > +     if (addr < (unsigned long)area->addr || (void *)end > area->addr =
+ area->size)
> > +             return -ERANGE;
> > +
> > +     vunmap_range(addr, end);
> > +     return 0;
>
> Does it make much sense to have an error return here vs just debug
> checks?  It's not like the caller can do much if it violates these
> basic invariants.

Ok. Will switch to void return.

Will reduce commit line logs to 75 chars in all patches as suggested.

re: VM_GRANT_TABLE or VM_XEN_GRANT_TABLE suggestion for patch 2.

I'm not sure it fits, since only one of get_vm_area() in xen code
is a grant table related. The other one is for xenbus that
creates a shared memory ring between domains.
So I'm planning to keep it as VM_XEN in the next revision unless
folks come up with a better name.

Thanks for the reviews.

