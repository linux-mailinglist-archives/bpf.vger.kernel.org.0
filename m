Return-Path: <bpf+bounces-21744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352428519FA
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 17:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B881C21EAF
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF09D3D56E;
	Mon, 12 Feb 2024 16:48:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996CB3D97F
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756525; cv=none; b=m6maO2+bphfYwrdZYQd9kSWqQOtdn5DW6OaROtEK0ITu/pP6KQNylPCP0wvN+u7zSdoDRnjTo0l+jScgj533A+gKyyk8WmqUjzrlVC5kJOwKO844/7MmX/8ooiDNtleq8j4NINgPEXwTrAyMNuGJiJPKOOGhtDPd4/9mE8gWmkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756525; c=relaxed/simple;
	bh=kD3D8MPg9R61iaECyAflPBpJPy/cbM7Ou6a2FY14nGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5qK03nyvZ/Qr8p+XKACHikZV6Nb0ILm3r5ib5Qsl+ygTxmx58iTVnUb8s9pf0wva/qGzQdUDWvWyTt/G19h16LZvgLdtpO7BSfY59oEFXuWJeU0eNRVjTM1GqPd90sf3TjxupOFo9pSRn5wMjrR8qFsOf2HYFJYFHeqnzGWQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-46d7a67d751so3032137.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 08:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707756522; x=1708361322;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNwvYyZhOt8RlyAXSRCMIOJBWJwymU5uQqZx/oeimBs=;
        b=aNd2AWXGnUT8B2HUxiFgdm3uW2EHgRE/3LnGOsE54yGePqOHpYJbcEwQ+IzswcZUhp
         Xdc7BK0X0HR+IWbxwSmo2gZLtXX6f2yxazW8IM1eMyc4iMQdBTpPp2bhEWaCwIOgURp7
         VQ5UEFQs3UsjzI+8aw+jcAVy0UVo0bxe6OOOlJVEaJrBR7k4JPU47VQSiXUhblEhVL/z
         L/AvE0BiPJuOk1tsN/N0V2IfYa6lkCNUHtonrKg/hi79qX2UCgN5+UfS/JZt8wBP7z6W
         CqE3aH5jJItFcU0LY/5Y5JhyB1yB2TEK7ueH31uq0Dwd744HaXHs7dGCmSaxTnJgDheP
         LgWA==
X-Gm-Message-State: AOJu0YymAtqMBc64PzZM+tBQucsh0zZW8s2yw3LvntShDiqxyYql7MMF
	2YIncXw336d1qZI03yXBJawQY3yMJH40AjriKWWEtV1zgpnZUAXq
X-Google-Smtp-Source: AGHT+IGlWH3ZjRbE+7u7YgELxfQ4mSi4w+MZBq2Ng2KdUcwsJ4j8yz0T8KgnmAyHgo0g/YT6aaSoAg==
X-Received: by 2002:a1f:6201:0:b0:4b6:cc19:42dc with SMTP id w1-20020a1f6201000000b004b6cc1942dcmr3539288vkb.11.1707756522255;
        Mon, 12 Feb 2024 08:48:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPj+AQ/bo7LwFN6ha5A4xDVj54ziwnKhUv7xPnMVvopVBI0K2F1ls9iheIUNWw/RheM81C1sXxjPhIvGOtfDme1eggL+xMNLZDv/E0gL1GD4mmgjgTYfg3dITfcS/jbn7RZGZ59E5o2CguhCZCBAeFK+zk1hFmZtN+92THrCVi3Tx0odyYb4914s5+NCGWY6sE5G1zogV2tl89BzvCF+rJHXuk3z5yMNzyGhrjDnAzUP5VJVkXB4vwqRrDefpw3cXKiOph8/J1HOwmP63/w7YOLWGmuJnLLDDjLjRACavhMYxiVnY4Rh582Y9H0R47z1wS/PRQVipIWI+mfZI5ik+UlIfPUNfwUixCYp7lGusqhd1CgRo1qZ4Y5A8091kz43ZCI6TUYHoW99tLxrw=
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id lq7-20020a0562145b8700b0068caf5c5fe5sm320382qvb.77.2024.02.12.08.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:48:41 -0800 (PST)
Date: Mon, 12 Feb 2024 10:48:39 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 17/20] selftests/bpf: Add unit tests for
 bpf_arena_alloc/free_pages
Message-ID: <20240212164839.GB2192269@maniforge.lan>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-18-alexei.starovoitov@gmail.com>
 <20240209231433.GE975217@maniforge.lan>
 <CAADnVQJsdbUuvkp67_z5xprA+UP=O9rTcwm3xRkpqSArrGqNaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7LSYlawjg2+mwi2g"
Content-Disposition: inline
In-Reply-To: <CAADnVQJsdbUuvkp67_z5xprA+UP=O9rTcwm3xRkpqSArrGqNaA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--7LSYlawjg2+mwi2g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 08:35:01PM -0800, Alexei Starovoitov wrote:
> On Fri, Feb 9, 2024 at 3:14=E2=80=AFPM David Vernet <void@manifault.com> =
wrote:
> >
> > > +
> > > +#ifndef arena_container_of
> >
> > Why is this ifndef required if we have a pragma once above?
>=20
> Just a habit to check for a macro before defining it.
>=20
> > Obviously it's way better for us to actually have arenas in the interim
> > so this is fine for now, but UAF bugs could potentially be pretty
> > painful until we get proper exception unwinding support.
>=20
> Detection that arena access faulted doesn't have to come after
> exception unwinding. Exceptions vs cancellable progs are also different.
> A record of the line in bpf prog that caused the first fault is probably
> good enough for prog debugging.
>=20
> > Otherwise, in terms of usability, this looks really good. The only thing
> > to bear in mind is that I don't think we can fully get away from kptrs
> > that will have some duplicated logic compared to what we can enable in
> > an arena. For example, we will have to retain at least some of the
> > struct cpumask * kptrs for e.g. copying a struct task_struct's struct
> > cpumask *cpus_ptr field.
>=20
> I think that's a bit orthogonal.
> task->cpus_ptr is a trusted_ptr_to_btf_id access that can be mixed
> within a program with arena access.

I see, so the idea is that we'd just use regular accesses to query the
bits in that cpumask rather than kfuncs? Similar to how we e.g. read a
task field such as p->comm with a regular load? Ok, that should work.

> > For now, we could iterate over the cpumask and manually set the bits, so
> > maybe even just supporting bpf_cpumask_test_cpu() would be enough
> > (though donig a bitmap_copy() would be better of course)? This is
> > probably fine for most use cases as we'd likely only be doing struct
> > cpumask * -> arena copies on slowpaths. But is there any kind of more
> > generalized integration we want to have between arenas and kptrs?  Not
> > sure, can't think of any off the top of my head.
>=20
> Hopefully we'll be able to invent a way to store kptr-s inside the arena,
> but from a cpumask perspective bpf_cpumask_test_cpu() can be made
> polymorphic to work with arena ptrs and kptrs.
> Same with bpf_cpumask_and(). Mixed arguments can be allowed.
> Args can be either kptr or ptr_to_arena.

This would be ideal. And to make sure I understand, many of these
wouldn't even be kfuncs, right? We'd just be doing loads on two
safe/trusted objects that were both pointers to a bitmap of size
NR_CPUS?

> I still believe that we can deprecate 'struct bpf_cpumask'.
> The cpumask_t will stay, of course, but we won't need to
> bpf_obj_new(bpf_cpumask) and carefully track refcnt.
> The arena can do the same much faster.

Yes, I agree. Any use of struct bpf_cpumask * can just be stored in an
arena, and any kfuncs where we were previously passing a struct
bpf_cpumask * could instead just take an arena cpumask, or be done
entirely using BPF instructions per your point above.

> > > +             return 7;
> > > +     page3 =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, =
0);
> > > +     if (!page3)
> > > +             return 8;
> > > +     *page3 =3D 3;
> > > +     if (page2 !=3D page3)
> > > +             return 9;
> > > +     if (*page1 !=3D 1)
> > > +             return 10;
> >
> > Should we also test doing a store after an arena has been freed?
>=20
> You mean the whole bpf arena map was freed ?
> I don't see how the verifier would allow that.
> If you meant a few pages were freed from the arena then such a test is
> already in the patches.

I meant a negative test that verifies we fail to load a prog that does a
write to a freed arena pointer.

--7LSYlawjg2+mwi2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcpL5wAKCRBZ5LhpZcTz
ZGqGAP9FXyIT26podcWUi4w5oM6m1yzPG0qtlJFkJI/bnGpN2AEAsHASWmqgcXzj
7q2z+BKmvv3HQe3cvdSfl7XeLbIivgY=
=O8oq
-----END PGP SIGNATURE-----

--7LSYlawjg2+mwi2g--

