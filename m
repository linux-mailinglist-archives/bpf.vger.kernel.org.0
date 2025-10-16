Return-Path: <bpf+bounces-71100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F1BE21DC
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 10:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC53580FB4
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 08:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05688303A0B;
	Thu, 16 Oct 2025 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etUeZPzb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3107303A02
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602727; cv=none; b=m+0qaEPE6NKO7QbvLdweLUw2p3tZFRvIuXh54Ubf64A3amXeWyyUj4li80prReC0i16G0tYTiBJNZANfl69fVKjB7ojtL49MUExVSu5bt9F8Bu3i1L/PvDp/z0dYmtAYQi/Ztl11p/IvWnrcDAHdSGxlGLk4bC3zQcUezY6I++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602727; c=relaxed/simple;
	bh=YHky9NJmU5RI/PX1MdgC/LSD2GIkMokTbTvw2kfRtCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYmkbYZnrlUow5Bm6vefUKiTZPchkOJSdRCY4E1YZGpkoRnf164FcVyEWbqeA7dVRproJMX8d4l/CGMU29KW+wbOSgfE82Ikioy+SUCFzrwpA7YKXCKwHEQcb8H1uZ3zI6XvOc/UgjtxWHKJ32OFqXFAxP1XwZx4q2J62W55K/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etUeZPzb; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63bcfcb800aso515947d50.0
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 01:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760602725; x=1761207525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgHYOgNqUKqEBxe2gRboRiYdQxE4NjF5ePcPPbuQMg4=;
        b=etUeZPzbCirYmFFDYVpbD0LLU5/8ZVfii3caD+IIcgeyXWgjk4jjZTJFk5WRs0R0Wv
         NTyTh6ZtlYw7CQGZ7SEAB2gwOHfu7QLOdBaWT7ueaH5xWq20IBtbgxRks4Y68Rski5iu
         n83ZTDc6PAhE7bMYuKVHJTEbn4qw60Ka2Dobmn5m5J7uEk5vWVnvWtvzzYm9TBNhyu6Y
         eGC+DlfPQUqVS8+8ou9P9J6ZqwNKUa2y9rBk5X4YNyw/bhetm4sgiaBxN163dM8TcUjg
         4835FLPHRdDTnNLBjA8OIx4oG5CMUoqLVi1mSijUyfaXTiA80IFaC/U3RCasCJ2SamMH
         FxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760602725; x=1761207525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgHYOgNqUKqEBxe2gRboRiYdQxE4NjF5ePcPPbuQMg4=;
        b=Vwy+C9+DAZN9zF9evm0zEh7jDT/25iBgj5aVJxBX+yvbXclJZj7TQkaHiYfvTLfZ4q
         nwVnNf4noxpULBiXozLVBzixupz5th0ISUK/owb0uzLgSdN+f8JkL+Xq7fEhy1DTaRed
         +T1JBWymjY9y3VIjmQ0R2iifzJcytHdoTD53b9UisqGrVZzwvUQj1U6ONN5z/r6OCa0Y
         hvui0fbm/UKANxmNmu/E8RK0FM41KbOpboBJP0/Ti+/rIl2A58z9V6dCjWACpvYhwirX
         2hFeMZJrKpnyX4PLRiYlBOQ5txrjVb7ZtOMPVw/F05d3q3rZOKqJ4O4DfWI6sqRj/nJh
         y6dw==
X-Forwarded-Encrypted: i=1; AJvYcCUp1SKlni9GQYjE7peDW3iU69gYI+cVvSF3uW2galoBjosVmTZvy50uSEJi/4UvC/K841k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBA15mQCHx+N0X1mYVcazyCPdpq1k/Ge+QxFjMxE0Fs57ScCP6
	WVxt90DQTeequIlsF//q5Jpk0QF3lp/+8eqNGeJAG91mGfZpUWCWRJeWlUshGbyNklDKwVZaxKx
	gP97nEoJuC/dB1aldzVvhAPs4CACDr4M=
X-Gm-Gg: ASbGncuodaPCS0B63/jrFuR8RKk4fMVBDxNmi8IBj4fFbhmLwOhrgq0MwYR+50m2jZn
	hHADRjeod6Er8ggUmfUr9jpBVdZEi5SY6hhtXbbLxmQMQWXUkLufb6F6nKyIPMiYrXOHPOUNlA+
	jq2C1S9JApZlUzDkG8EYa0m48bGtncf3runY734mrO/sA4gYTSlIjs5bkDFp73tcximKjA4/cVm
	BS58h/izNwyXnZbXPpfndYrbaKIakGUFiTpbEEGnaElqXzrUaUK+JCO89BHMzTm0b7cc8gA
X-Google-Smtp-Source: AGHT+IHVqXd5quXoFkL7TseeikvmflCG1zrHiGi4zY5UsuuarF4PtLzgSuWNSHW7MIFsJygYWpoqCYW0WFpL9IgIR0g=
X-Received: by 2002:a05:690e:4007:b0:63e:dbf:ab89 with SMTP id
 956f58d0204a3-63e0dbfaf6dmr985502d50.21.1760602724828; Thu, 16 Oct 2025
 01:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015141716.887-1-laoar.shao@gmail.com> <20251015141716.887-7-laoar.shao@gmail.com>
 <CAEf4BzZYk+LyR0WTQ+TinEqC0Av8MuO-tKxqhEFbOw=Gu+D_gQ@mail.gmail.com>
 <CALOAHbBFcn9fDr_OuT=_JU6ojMz-Rac0CPMYpPfUpF87EWy0kg@mail.gmail.com> <ebf60722-34e1-4607-b6a7-595fc2091998@lucifer.local>
In-Reply-To: <ebf60722-34e1-4607-b6a7-595fc2091998@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 16 Oct 2025 16:18:08 +0800
X-Gm-Features: AS18NWD2AXGKlmvFo5UH1F2cQyeA_L5yHcpBAgeZL4_sZgqmARGxyWqYqUTXbrc
Message-ID: <CALOAHbDnJyou=MUwPBCEwWeeK+9w2MiOXjpkkcCALExfnsj=_A@mail.gmail.com>
Subject: Re: [RFC PATCH v10 mm-new 6/9] bpf: mark mm->owner as __safe_rcu_or_null
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, akpm@linux-foundation.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev, 
	rdunlap@infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 3:21=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Oct 16, 2025 at 02:42:43PM +0800, Yafang Shao wrote:
> > On Thu, Oct 16, 2025 at 12:36=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Oct 15, 2025 at 7:18=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > When CONFIG_MEMCG is enabled, we can access mm->owner under RCU. Th=
e
> > > > owner can be NULL. With this change, BPF helpers can safely access
> > > > mm->owner to retrieve the associated task from the mm. We can then =
make
> > > > policy decision based on the task attribute.
> > > >
> > > > The typical use case is as follows,
> > > >
> > > >   bpf_rcu_read_lock(); // rcu lock must be held for rcu trusted fie=
ld
> > > >   @owner =3D @mm->owner; // mm_struct::owner is rcu trusted or null
> > > >   if (!@owner)
> > > >       goto out;
> > > >
> > > >   /* Do something based on the task attribute */
> > > >
> > > > out:
> > > >   bpf_rcu_read_unlock();
> > > >
> > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >  kernel/bpf/verifier.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > >
> > > I thought you were going to send this and next patches outside of you=
r
> > > thp patch set to land them sooner, as they don't have dependency on
> > > the rest of the patches and are useful on their own?
> >
> > Thanks for your reminder.
> > They have been sent separately:
> >
> >   https://lore.kernel.org/bpf/20251016063929.13830-1-laoar.shao@gmail.c=
om/
>
> Could we respin this as a v2 without them then please so we can sensibly =
keep
> the two separate?

Sure, I will send a v2.

>
> Thanks!
>
> >
> > --
> > Regards
> > Yafang
>
> I do intend to have a look through the various conversations on this, jus=
t
> catching up after 2 weeks vacation :) in the kernel this is an eternity, =
even
> during the merge window it seems :P

Huh, we've been refactoring a bit too fast and furious since your last
review ;-)

--=20
Regards
Yafang

