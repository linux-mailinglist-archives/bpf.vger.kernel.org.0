Return-Path: <bpf+bounces-36402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F5E948047
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 19:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA735283F14
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B88315ECEA;
	Mon,  5 Aug 2024 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jodIVSc5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6202B2C684;
	Mon,  5 Aug 2024 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878961; cv=none; b=q+R/MGNotzdTU/jYDHufF8kQV3MgSU5OWtZjHtqdQ1zP1Y/e7BKzClasLPRC8lXAJpZsgsYMKRyG773ZaU5KJzasXYBrPNoPqqWw9YG83uW0PMulHuURwC3lVQHFybAyECapRDXS6+N3P54VEUyBg90RWA4NJ3LJWQORYIi6fno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878961; c=relaxed/simple;
	bh=2/s/hJWqPoKTJBCPiqfHbjHv+o4VX2TJ2kwz23v/VGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tt0a2wdmBYGME5SSaxSSFcVCMpxlCGHqUl4W0HfJ2YYax4Ix38iKIjXOldlpGxkWzC+VusJ3PVrvEE5EqQYsHU9Sd7tgYsHkCWcAsoWdhOVQSO7g7lIA7sTHCDBenIMqWxgceidDK8WLrVe7aBoZXPKOgJgCh1LR9A6NW7tw0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jodIVSc5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so5156344a12.3;
        Mon, 05 Aug 2024 10:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722878960; x=1723483760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HFEevnrc72PQ6Jhj0m4i/B6uiLdJ3YShD8APoLscWU=;
        b=jodIVSc5U48LOrEXHeKjge3CSNrHV16/f8Q8dsmWbio6FkwLSzT/gw/Pv1fvWND2wJ
         UTrVyfPqSuihI1e3we5bDRt3c9J3QhVYajz4C4Lkd+cAK10y3zBhBQ8kSC47DPcbzjQ7
         Av6eH5qy8+rmpOY6GvWTO9iH4P9dnRzyjNFySUjxYyzr7aNm0DniZ72FJGwNJNkJ8ITe
         iV3K8KjQUzsvrfKTJKPQktoYZL+u1ZcJ1JJdq5W+wbN2ySodCPu4rUzwoW/aq9uFEhYa
         0F1Bsz8P+yss+FafOUmvcJLoNGMJ/Uw3fkl/ij2eVuOMppR72dLgUaz3U7FTLpyMlL9w
         4zxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722878960; x=1723483760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HFEevnrc72PQ6Jhj0m4i/B6uiLdJ3YShD8APoLscWU=;
        b=kRa2/0FixI/f8Ko5NYQLliIYS7u1Jp1VV+aGstZMjQcw0C7T6mdPJaqSgdUpo0/p72
         4aGMA7CtV+ktf4Z7SHH2bTjr8Xm16EogOWMtMYnUW28Uk++BYUWeMUihIEgTmAS9tLEZ
         P/ZZZluRwHIID3VeO3FOhUUlEfxbC7ed5BszEOS+Zr1jkqfRy/pbdW4UjHH7EyN5eJhn
         I0F9RAM3R8L5XKvmdxU/dtkcilXLUVEsrX0n+ybuojdysj6ZjxlRjl7WvhVEJEConTPc
         rn7OIbHqDtqJ7WCTonlFitklRPTelu5P1OBxIyeKUgUb8JhUnYGA66Uam5rtjTMazqmk
         Qruw==
X-Forwarded-Encrypted: i=1; AJvYcCXONk2QaCiq0dMHIGpWnDBVMYvVv/Iyq7YkC4qTM/H8nWAKBH47qHv6sUI0M/+W4tp+Abo0IGMRF0ZbUUuuvb0HjwBA1/9gKstbqIxexvo/z3JbZmF/uBGSpltVhsvvbcJzxBsZQFVDPa2ZM5zCwyOSxvRNb670OAOTP6U5hIWPdN8PtiJW
X-Gm-Message-State: AOJu0YzqZI7LAqaJfSNJCe1loGNmqykHgeIJgeOw8mBJRKr7obkvxkKh
	oA0xRxysofeZ1NXDBjcCt/4WW+oQCUu85SOgzhwGUPKW9eRcWo4u7nh1pYLF3RBLDJPIFMRGY7y
	tb1QCfYjwXrxhgBQpIY7bJRFtinDC8w==
X-Google-Smtp-Source: AGHT+IGPt0LdYeJUltHWC3xC3JOU5FRo3Qhx8UDMnsai9X4ebykuBgYkP8LjG7B2eFoKj2OxlFGohlAvgPXyi2A/+mE=
X-Received: by 2002:a17:90b:354f:b0:2ca:f33b:9f26 with SMTP id
 98e67ed59e1d1-2cff95405b4mr10563202a91.28.1722878959607; Mon, 05 Aug 2024
 10:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-3-andrii@kernel.org>
 <20240805134418.GA11049@redhat.com>
In-Reply-To: <20240805134418.GA11049@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Aug 2024 10:29:07 -0700
Message-ID: <CAEf4BzYvkAYL4pPcA7ayiR_VT=g4Y1SMZy4MNX3QEV3H=PjYvw@mail.gmail.com>
Subject: Re: [PATCH 2/8] uprobes: revamp uprobe refcounting and lifetime management
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 6:44=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 07/31, Andrii Nakryiko wrote:
> >
> > @@ -732,11 +776,13 @@ static struct uprobe *alloc_uprobe(struct inode *=
inode, loff_t offset,
> >       uprobe->ref_ctr_offset =3D ref_ctr_offset;
> >       init_rwsem(&uprobe->register_rwsem);
> >       init_rwsem(&uprobe->consumer_rwsem);
> > +     RB_CLEAR_NODE(&uprobe->rb_node);
>
> I guess RB_CLEAR_NODE() is not necessary?

I definitely needed that with my batch API changes, but it might be
that I don't need it anymore. But I'm a bit hesitant to remove it,
because if we ever get put_uprobe() on an uprobe that hasn't been
inserted into RB-tree yet, this will cause a hard to understand crash.
RB_CLEAR_NODE() in __insert_uprobe() is critical to have, this one is
kind of optional (but still feels right to initialize the field
properly).

Let me know if you feel strongly about this, though.

>
> > @@ -1286,15 +1296,19 @@ static void build_probe_list(struct inode *inod=
e,
> >                       u =3D rb_entry(t, struct uprobe, rb_node);
> >                       if (u->inode !=3D inode || u->offset < min)
> >                               break;
> > +                     u =3D try_get_uprobe(u);
> > +                     if (!u) /* uprobe already went away, safe to igno=
re */
> > +                             continue;
> >                       list_add(&u->pending_list, head);
>
> cosmetic nit, feel to ignore, but to me
>
>                         if (try_get_uprobe(u))
>                                 list_add(&u->pending_list, head);
>
> looks more readable.

It's not my code base to enforce my preferences, but I'll at least
explain why I disagree. To me, something like `if (some condition)
<break/continue>;` is a very clear indication that this item (or even
the rest of items in case of break) won't be processed anymore.

While

if (some inverted condition)
   <do some something useful>
<might be some more code>

... is a pattern that requires double-checking that we really are not
going to use that item later on.

So I'll invert this just to not be PITA, but I disagree :)

>
> Other than the lack of kfree() in put_uprobe() and WARN() in _unregister(=
)
> the patch looks good to me.

yep, fixed that locally already. Thanks for the review!

>
> Oleg.
>

