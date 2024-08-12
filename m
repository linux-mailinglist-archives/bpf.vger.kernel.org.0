Return-Path: <bpf+bounces-36941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8140694F7C5
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 22:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973DA1C21B8F
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073D91917EC;
	Mon, 12 Aug 2024 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moAwArip"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265C561FFC;
	Mon, 12 Aug 2024 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723492814; cv=none; b=cz1wH0a8zAeOTwpKx1xDfAE8m+wXJrArDFqqAkkY0bU5cxUE2t8VX8q0WmLZas3IcnoUDFmp0a7B5KpLuMlENsrQSqtEUrFZlZiHnNMIJJZ2pRJrDEacuGW7ZJfKzqE1MjraOCFlaF5WxIHd3LXSYiSxbuLsmKmkwd9BTsWxBv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723492814; c=relaxed/simple;
	bh=KstVNJ3L2qzscAMgj5Jf9zkpCjcBT4Mr9zo3QRiI65g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uznqG1SAkhkvfGgqGncB0XLN3Ju++AzFJZicmpcojHLP64Fr+AmubyWK/CQI0yHUqv8NBocFsnYpu+PrQi4LXF7DAcJar7BETXMD9Tp2/jLmYOl3z9V12bp5E/lxxI/2x66AvZb0eYcCwsSmc0NhV7/PkRy5B63PFEvF+GOvZak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moAwArip; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb4c584029so3677552a91.3;
        Mon, 12 Aug 2024 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723492812; x=1724097612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9w/uBXZ5D6MzP4JJL1EO+fWDE4hnfbBDw04URWpP+U=;
        b=moAwAripv35LUnMKbwwc1lLYBB71QOCotIDhXbLzNEkt+rYfOQ9tPBUFsx8vdQ9MNx
         hfoRSJI+xTg4ujksp6HmZsV799Qr0qL0J/aklRPPQ12tqZ5yfSTbSQZ/qwdVB2zRx6Y9
         gdSHcwF56/QMzmDW4T3YHPEgVn4iJU9mFVH9w3gLr4V39TbqsEnNiYsBXiGHlKzlguHI
         wmhvmpLke1xJjCWa0hz9Xy0HOaJKs4iLK8KIYeED4n4xKWpqhVTdzTtTZel2C/pgGopJ
         HskVRWrXEy3OO5zuR2mQzlw2wPUACE6/I7cD3yUvLE35N432f0vvcIc1BduqmUZgtIBK
         CoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723492812; x=1724097612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9w/uBXZ5D6MzP4JJL1EO+fWDE4hnfbBDw04URWpP+U=;
        b=houn5Kaxww4+RKbRjpvL5CHzIXPA8jxfJgOHKRRLIPjX3XyXnDCZwXsKpoejnI/ovU
         8CcvXXpegQ6KhlVE/AOc+p0yxj96uUI7MBkSpqkXEJDbtcdjszANf9jTEQHDfukI4Y5j
         p+p71VbFH6ReAvhvWRN9aIQN+xWlnEa8CQ+uVn7+lZUec26ZTbJ8mPV1kGG54XeMnSjP
         myG8y18CgkKcTH57G7wliRSC7cxdhEEFzFbmelECOzWmLeDhI5Allpb6PrdIOVJbmA+6
         Gzg0oyKxzuRu3rH4pc3gwMRhw8eitQ7o8SvyTEg57JJ0CXg9frfNsd7PUMJPw63UDYXT
         Ze0w==
X-Forwarded-Encrypted: i=1; AJvYcCXj58BYvYbCRQ3FdhiwjDpXFS67myWFINKgD0QpomME/AUoOkYez2rX60W488uYHoT2+g+zrqTFj/fU1/NiepM9+/waTJpP2BzlsPneQQksg8advf9gzF7NfAizuKJfoYKrCmOskF2orytObw4HayyPA6/eY7+vNhlb6DZ/QrXLrYV9MrN7eHK5WctjMuqXv60sT5oMXRkJXoCdKwavTOB8VTINRnU3xw==
X-Gm-Message-State: AOJu0YzogxFm6dz4sKasIZJ3U73DnbCYYXGOy9RiysFj5JXKPfexr0ok
	FLvE5aYsBKlXqkyz9831j2IoU0MDd7exUHHJFjVrwOQ8R6X1uaNaA6tBbgZ4lNljj63cOfSIKDQ
	+hejxy1HaAwd3twXClVFk7zr7ojw=
X-Google-Smtp-Source: AGHT+IFQv65X7h0W+swS6SZWsFIogJb9kuzpuwC+BM97J3qO7vfuuD5CfkZJOLfnuW0vYUsROGAtj1ZcEEQzP4muKUw=
X-Received: by 2002:a17:90b:33d2:b0:2c9:9fdf:f72e with SMTP id
 98e67ed59e1d1-2d3926340bemr1552158a91.26.1723492812304; Mon, 12 Aug 2024
 13:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000382d39061f59f2dd@google.com> <20240811121444.GA30068@redhat.com>
 <20240811123504.GB30068@redhat.com> <CAEf4Bza8Ptd4eLfhqci2OVgGQZYrFC-bn-250ErFPcsKzQoRXA@mail.gmail.com>
 <20240812100028.GA11656@redhat.com> <CAEf4BzZ6coCZHY_KMnSQQUyc_-xziKurOQ0j3xaCvHhnDaafuQ@mail.gmail.com>
 <20240812192405.GD11656@redhat.com>
In-Reply-To: <20240812192405.GD11656@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Aug 2024 13:00:00 -0700
Message-ID: <CAEf4BzbW9frgUDE+9mbrAyMj0eshPOoqgLs11ynb91spWkdAzw@mail.gmail.com>
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in __uprobe_unregister
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, jolsa@kernel.org, acme@kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	irogers@google.com, kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 12:25=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> On 08/12, Andrii Nakryiko wrote:
> >
> > adding bpf ML, given it's bpf's code base
>
> Thanks,
>
> > On Mon, Aug 12, 2024 at 3:00=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > > --- a/kernel/trace/bpf_trace.c
> > > > +++ b/kernel/trace/bpf_trace.c
> > > > @@ -3491,8 +3491,10 @@ int bpf_uprobe_multi_link_attach(const union
> > > > bpf_attr *attr, struct bpf_prog *pr
> > > >         }
> > > >
> > > >         err =3D bpf_link_prime(&link->link, &link_primer);
> > > > -       if (err)
> > > > +       if (err) {
> > > > +               bpf_uprobe_unregister(&path, uprobes, cnt);
> > >
> > > I disagree. This code already uses the "goto error_xxx" pattern, why
> >
> > Well, if you have strong preferences,
>
> Well, YES and NO ;) please see below.
>
> > so be it (it's too trivial code
> > to argue about).
>
> Agreed. On a closer look both the code and the problem look very trivial.
>
> But note that nobody noticed this trivial problem before. Including me wh=
o
> had to change this trivial code to adapt to the recent API changes.

Yep, error handling problems tend to go unnoticed frequently. The good
thing is that this is quite unlikely in practice for bpf_link_prime()
to fail, which is why it was a syzbot that found this.

>
> May be this means that we should keep the error handling in this function
> more consistent ;)
>
> > We do have quite a lot of "hybrid" error handling
>
> And YES, I don't like this kind of error handling.
>
> But, at the same time: NO, I never-never argue with the maintainers when =
it
> comes to "cosmetic" issues.
>
> My main point was (and you seem to agree) that this simpler patch above w=
on't
> simplify the routing. I too thought about the change above initially.
>

Agreed. Just stick to your code, it's fine. Thanks!

> -------------------------------------------------------------------------=
------
> > Yep, absolutely, given the bpf_uprobe_unregister() change, I don't see
> > any problem for it to go together with your refactorings.
> >
> > For the fix:
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> Thanks! I'll write the changelog and send this patch with your ack includ=
ed
> tomorrow.
>
> Oleg.
>

