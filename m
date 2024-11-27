Return-Path: <bpf+bounces-45684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 656509DA192
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 05:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2AE2822FD
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 04:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3FE13AA3F;
	Wed, 27 Nov 2024 04:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGTlE9pG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD15013AD0;
	Wed, 27 Nov 2024 04:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732682958; cv=none; b=Ds1uMDTV+HUJ8+ltevcES/R6sP3seY+XU0J8OwzH7YqztBZ/4w7uEHjU5ntE+AhxOzE9agLbP9ulmSX6BTX9SSEqGqUGAriXllSjX1Z78clVlvTLpDudn6FtIn4VrJAn2gQ+R1cXJqTZ6vwpv+WjfNs9EogzMepwzsTaXXNBmb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732682958; c=relaxed/simple;
	bh=vk0oTidZrPt7vXawpRT99So1Tc8eAnJ+FxoOjfNT730=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYFRoSU3bUy8Qny+yJ5Aqu2JGNeDbjqQ9c0gRIgIdjyQQ0fpLbSY6cqGvvgBvbfXQDN9BaC/7pYCNiMVXXc5YP0rYp8tqvzIQWrymqtAksTCYkFaDfJDFzzXheflq/bOZxIgxEtOiUmogbfnT6sjb3tvRi1bwyAaZVV5Urb7LKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGTlE9pG; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ea5a22d80cso4913345a91.0;
        Tue, 26 Nov 2024 20:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732682956; x=1733287756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YI6a5V6MFlh1RS08PL7P83mOTzI2RZFmbjyaRVBpOA=;
        b=AGTlE9pGb5z4C02HL1jDTZ7YthqJe5rGq8/DALDVxZYIRjTzUmiHqe8a1Oouthlq47
         i0Oa1BMT/WwX0fkeodZK8bIsGvF4TRGdG+wnSbaAVan30qy5gOtiNIhxHAJmO1hfRCct
         oO/yT9PqxL9vdxzsSS7u2WKgJziWtWeOQEr6DnbO/OaMG3JpEcHpFK+w1YK1xu5EzJ9o
         GnGNDS+VBzj9ikASjzylzWj8TmFPhC338h/jzhkVbYLAb/DYHzVPr1RdCf5BwtyAVdKP
         JNh6Tb85yMQ3ShgzQgM2rxudReMq84nTOawHz6tTlCZb1fix2DzDkSsYSCwff+6e+Iou
         6dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732682956; x=1733287756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YI6a5V6MFlh1RS08PL7P83mOTzI2RZFmbjyaRVBpOA=;
        b=B0z4Xk39Fd5jxpYMuxX5eFyAbwwFomZu9gX+GOxCOS36P2IrWyljcDul6iZ8mxXD9Z
         RwXZINiBTL/mgGW4Xrpcp/zXHrAM9a0TPXSRqITRwgremzaybHE36Ewik4ksCmSZAeWv
         N42q7Bo3X1NNzQDwJUpRcvLhJ8XjXK5XfqjmxwLmy1bSa8vCav5At7zbSiwT2MYpUO40
         EtNGpEuhZsAsDMJe2HJORi7TbcofylfPZBhNsZWE67tNiJQ9M++rsyGIOzMnUGCx81ML
         XnATnl6T8ac3+Vn8kh3KmE9COd2xZ2sY/aFRJrxiVwO4H0KsFvb5/cEG3tjMiWzNtrGA
         s18A==
X-Forwarded-Encrypted: i=1; AJvYcCW6IoiGxseQC72mvLxd2q+9J+DqJkR5ccVXTl6ZLCf0lQdmpa8PV+FgYpOo3Z+eZ3bEBSnCJ6nuyEXktLy7@vger.kernel.org, AJvYcCWr34GsDWTmmxCfYqsv83JQflJ5xD3O7Fpw7jDiYmSYURIseLH5/27TpDOeyeS0peF4LZYqDVhaCJtjr3buWmHmGhQ5@vger.kernel.org, AJvYcCWzD3xfr/ZA4GQwqcX2rb885FcJl7uPPiQ1mXBP5/In9ROXkwUW2r1oXAmwDj5oqVn7cJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcsK7cGTXAVFBFJ6tuE7w7zoY2rvofPRUO8ANXDomj2utAEhG+
	lts1JAlXB78ftD153RT27JIXBkqCsBh22a/SGjJQ54Bg1fy0ksSJGJW26Mzpxa6IC/F3TZQ6sQV
	zDOylzD1U9ONVKUzznA2oqaKxCFc=
X-Gm-Gg: ASbGncu4NZveWAhh3v80SDoai4uTQdzZShIzu+q4auIptSrBfkM7SnOlWsP3B2uUxC+
	pUlblHSrk4nxpO3Ffj50LcnEkmeAWwkblX9d4ZppxlsDTLGc=
X-Google-Smtp-Source: AGHT+IH51XKWB7OGMnkJU4faJchvCGW6xx3N56IfNXPdi0vRNuxb5FtmUhj2YkJexIgFInqeXpQIb/Qz9P4n3QSpmX4=
X-Received: by 2002:a17:90b:1850:b0:2ea:3ab5:cb9d with SMTP id
 98e67ed59e1d1-2ee08e9928amr2518763a91.8.1732682956057; Tue, 26 Nov 2024
 20:49:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122035922.3321100-1-andrii@kernel.org> <20241122035922.3321100-2-andrii@kernel.org>
 <CAG48ez06=E-rXYk59yJR2aKFD2yaqcQu+6wqVau9pQ8X36A+aQ@mail.gmail.com>
In-Reply-To: <CAG48ez06=E-rXYk59yJR2aKFD2yaqcQu+6wqVau9pQ8X36A+aQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Nov 2024 20:49:04 -0800
Message-ID: <CAEf4BzZf5C-tqbKqJxPaoPZi0tLky8Y8wCS8k-+MekNxvoHTog@mail.gmail.com>
Subject: Re: [PATCH v5 tip/perf/core 1/2] uprobes: simplify
 find_active_uprobe_rcu() VMA checks
To: Jann Horn <jannh@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, peterz@infradead.org, 
	mingo@kernel.org, torvalds@linux-foundation.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, surenb@google.com, mjguzik@gmail.com, brauner@kernel.org, 
	mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, david@redhat.com, 
	arnd@arndb.de, viro@zeniv.linux.org.uk, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 2:20=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Nov 22, 2024 at 4:59=E2=80=AFAM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> > At the point where find_active_uprobe_rcu() is used we know that VMA in
> > question has triggered software breakpoint, so we don't need to validat=
e
> > vma->vm_flags. Keep only vma->vm_file NULL check.
>
> How do we know that the VMA we find triggered a software breakpoint?
> Between the time a software breakpoint was hit and the time we took
> the mmap_read_lock(), the VMA could have been replaced with an
> entirely different one, right?

We need that VMA only to get inode + file offset, and whether it is
the original VMA with uprobe installed, or someone raced and replaced
it with some other VMA shouldn't matter. We either find uprobe at that
offset within that inode, or not. So this seems fine.

>
> I don't know this code well, and your change looks like it's probably
> fine (since the file is just used to look up its inode in some tree,
> and therefore for incompatible files, the lookup is guaranteed to fail
> and nothing will happen). But I think the commit message looks dodgy.
>
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > Suggested-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/events/uprobes.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index a76ddc5fc982..c4da8f741f3a 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2305,7 +2305,7 @@ static struct uprobe *find_active_uprobe_rcu(unsi=
gned long bp_vaddr, int *is_swb
> >         mmap_read_lock(mm);
> >         vma =3D vma_lookup(mm, bp_vaddr);
> >         if (vma) {
> > -               if (valid_vma(vma, false)) {
> > +               if (vma->vm_file) {
> >                         struct inode *inode =3D file_inode(vma->vm_file=
);
> >                         loff_t offset =3D vaddr_to_offset(vma, bp_vaddr=
);
> >
> > --
> > 2.43.5
> >

