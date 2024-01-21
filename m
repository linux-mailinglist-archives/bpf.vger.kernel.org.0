Return-Path: <bpf+bounces-19978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978948358C0
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 00:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9DBAB218F8
	for <lists+bpf@lfdr.de>; Sun, 21 Jan 2024 23:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEC73984D;
	Sun, 21 Jan 2024 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="P6I44lQy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C945E38FB5
	for <bpf@vger.kernel.org>; Sun, 21 Jan 2024 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705879947; cv=none; b=VOqvCK95EDuAFzPy0tZWPETDKNX2GnchTVSxbtDX0lULvhBZ1az4hhlz7EvRMQauPx51EXQ5HsZ1gyPO21ysuN/r5u0HfhdH07TA+qw0b8lcT2wlQt+ZkxN6X904svFV4YiQN+tDnjV6fruJsNl7HnA54etsFZrXmQAGceA4I7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705879947; c=relaxed/simple;
	bh=86Hs8N3qB1R5Vv/GCnSufMx5bQQD8njwkfHqMythQog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jlwb8A1ktlp5rMewc34Bfl+KrBa1v/+jQTh7hwnjWdA+YPrOIGMHzW12BSJkdLsfXdtsGdjtyrjZ/bW3FgIx/6qZyYpoP7hRhrPoYMYSf6J+7fAbXEKP1v/CbDo+O9eKK/JyyQG1NR+/XemACu5j+6DgwALxhd2Bjwr1zV43wGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=P6I44lQy; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-429ca07044eso24065741cf.3
        for <bpf@vger.kernel.org>; Sun, 21 Jan 2024 15:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1705879944; x=1706484744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjAyR5yAuxqP2MXzhvI5gNl4zdn4tEXP6bBd21ORa3E=;
        b=P6I44lQy8CqkFvrKSz8gY3CP2vDxsDG3VCs3+hYKFzoDeIh9VMBiLIRuy6PLHt1l3D
         xoskyj4jP9nP36ysLMy8ez4ctvtH2IPGkIw2zw7VTKkG7YJsIoFASdhcbJA9kqa48k/M
         z5AGKFMToYiDP4KyRPe7aI0V67qTp/+gCc2++dyepv/rPc0amaO1FiQXVLJTy93hDZ8W
         a0yudf3PHlC7PHqy9GmRtmCPOReE+ePRd5nyGABvOX+gg2M4zOTLb81UGZIaBAcy7HkG
         maTTbPoKIvYfTh5q4wHrB2IzpzO7faHroT76GSRwt5gsOGm6wzBItcGxqEQWSXbVV/j1
         V5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705879944; x=1706484744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjAyR5yAuxqP2MXzhvI5gNl4zdn4tEXP6bBd21ORa3E=;
        b=YUi4lgeEKCbx5z0diqyQbv++ThMjH06l1mWKLOtt4ygZRWs4LvqxoS6Q7e1Re++pKk
         MpYq4P+yi45dM4lOc1P0sQECIvn6DT0FqhfbngbJW1ncjCJDtV0P8pY1otVte6F9FZFc
         FU/6Itio6SDNy4OCiBY4sgyPEg4iuJnA9d5tzsuiVYMUh/YvH9nzSIQYYmBx6qF0r78H
         XRG35DqW7JvvG0l67CjmHIpDTYATn+4E1efmQXzpXHZnj/h3qwkpdHrnxz95wwSwHXkq
         Kz0X5gGDPl7LjtA5viWYK0Xrd02DaD1AHGNJ8QVohLU64b2TYdyLW4sdyPNrxD1V5mCs
         w3qA==
X-Gm-Message-State: AOJu0YwUkkzTDOdzcj2OhTUov2R6afemOqxljhAqIbaV6+xCndzNDXkC
	tNrr578UPFaUXo3UoJfsDxVe55vfwlq+VP1zysA8VnVKauNxXqNtFTV6PxznYl8GTpXeTMG5dCY
	HeEwfqG4BNwhW/5gC3aUWl7VD4mFXOod7nvLRGQ==
X-Google-Smtp-Source: AGHT+IHivVz4AXDlztP5Ti2xRZhD4G1//TCleyRPSv0+jm2GNZ2s0PiypPLZvpl/q0OkhQIdBOHj30bfFDYrRraUsOY=
X-Received: by 2002:a05:622a:b:b0:42a:3274:c523 with SMTP id
 x11-20020a05622a000b00b0042a3274c523mr4459943qtw.137.1705879944558; Sun, 21
 Jan 2024 15:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org> <b04b65df-b25f-4457-8952-018dd4479651@google.com>
 <Za2lS-jG1s-HCqbx@casper.infradead.org>
In-Reply-To: <Za2lS-jG1s-HCqbx@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 21 Jan 2024 18:31:48 -0500
Message-ID: <CA+CK2bCAPWhCd37X8syz9fHYSv_pQ0-k+khgXZc1uCPRBnFaWQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
To: Matthew Wilcox <willy@infradead.org>
Cc: David Rientjes <rientjes@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Sourav Panda <souravpanda@google.com>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

Thank you for proposing this topic. I would also like to be part of
this discussion at LSF/MM specifically because of the memory
efficiency opportunities coming of memdescs.

On Sun, Jan 21, 2024 at 6:14=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Jan 21, 2024 at 01:00:40PM -0800, David Rientjes wrote:
> > On Fri, 19 Jan 2024, Matthew Wilcox wrote:
> > > It's probably worth doing another roundup of where we are on our jour=
ney
> > > to separating folios, slabs, pages, etc.  Something suitable for peop=
le
> > > who aren't MM experts, and don't care about the details of how page
> > > allocation works.  I can talk for hours about whatever people want to
> > > hear about but some ideas from me:
> > >
> > >  - Overview of how the conversion is going
> > >  - Convenience functions for filesystem writers
> > >  - What's next?
> > >  - What's the difference between &folio->page and page_folio(folio, 0=
)?
> > >  - What are we going to do about bio_vecs?
> > >  - How does all of this work with kmap()?
> > >
> > > I'm sure people would like to suggest other questions they have that
> > > aren't adequately answered already and might be of interest to a wide=
r
> > > audience.
> > >
> >
> > Thanks for proposing this again, Matthew, I'd definitely like to be
> > involved in the discussion as I think a couple of my colleagues, cc'd,
> > would has well.  Memory efficiency is a top priority for 2024 and, thus=
,
> > getting on a pathway toward reducing the overhead of struct page is ver=
y
> > important for our hosts that are not using large amounts of 1GB hugetlb=
.
> >
> > I've seen your other thread regarding how the page allocator can be
> > enlightened for memdesc, so I'm hoping that can either be covered in th=
is
> > topic or a separate topic.
>
> I'd like to keep this topic relevant to as many people as possible.
> I can add a proposal for a topic on both the PCP and Buddy allocators
> (I have a series of Thoughts on how the PCP allocator works in a memdesc
> world that I haven't written down & sent out yet).

Interesting, given that pcp are mostly allocated by kmalloc and use
vmalloc for large allocations, how memdesc can be different for them
compared to regular kmalloc allocations given that they are sub-page?

> Or we can cover the page allocators in your biweekly meetings.  Maybe bot=
h
> since not everybody can attend either the phone call or the conference.
>
> > Especially important for us would be the division of work so that we ca=
n
> > parallelize development as much as possible for things like memdesc.  I=
f
> > there are any areas that just haven't been investigated yet but we *kno=
w*
> > we'll need to address to get to the new world of memdesc, I think we'd
> > love to discuss that.
>
> Thee's so much work to be done!  And it's mostly parallelisable and almos=
t
> trivial.  It's just largely on the filesystem-page cache interaction, so
> it's not terribly interesting.  See, for example, the ext2, ext4, gfs2,
> nilfs2, ufs and ubifs patchsets I've done over the past few releases.
> I have about half of an ntfs3 patchset ready to send.

> There's a bunch of work to be done in DRM to switch from pages to folios
> due to their use of shmem.  You can also grep for 'page->mapping' (becaus=
e
> fortunately we aren't too imaginative when it comes to naming variables)
> and find 270 places that need to be changed.  Some are comments, but
> those still need to be updated!
>
> Anything using lock_page(), get_page(), set_page_dirty(), using
> &folio->page, any of the functions in mm/folio-compat.c needs auditing.
> We can make the first three of those work, but they're good indicators
> that the code needs to be looked at.
>
> There is some interesting work to be done, and one of the things I'm
> thinking hard about right now is how we're doing folio conversions
> that make sense with today's code, and stop making sense when we get
> to memdescs.  That doesn't apply to anything interacting with the page
> cache (because those are folios now and in the future), but it does apply
> to one spot in ext4 where it allocates memory from slab and attaches a
> buffer_head to it ...

There are many more drivers that would need the conversion. For
example, IOMMU page tables can occupy gigabytes of space, have
different implementations for AMD, X86, and several ARMs. Conversion
to memdesc and unifying the IO page table management implementation
for these platforms would be beneficial.

