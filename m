Return-Path: <bpf+bounces-36582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C454A94ACC5
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D972C1C2037D
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762CB84A31;
	Wed,  7 Aug 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxyiRcep"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D6C8172A;
	Wed,  7 Aug 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044259; cv=none; b=Gf6NWLl1xZ7FVqXyUlBpIPh3jfpHXJRB3GzGvOfoMJUV9PBFSZm4Yg7QMBl02OIU1CWvcWCXkTCZxJFxGwLEspgtT6Mbiq+K7ZfgWvcgmrehnL+Pi80A9tJkQ1u4Mgo7Uk2Ht7ipZI024BXpQgdlV+mDeOrHaQ3793fryyJFbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044259; c=relaxed/simple;
	bh=SEjKNP9Fe5ihcvTOrovnqpB71SkawQ3ddYeJkcUyS/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLG1e0ciXwEBg2lPFLTZDg7RSm43EHNrjAyCF/1lugB9qdnRBOyQt+0Cpl2hqkBflJBKi9JN/P1sAPGD9fmsYA9EVh8qPdmUaB3rz+8AMMcH8h8/DuQwLOYxuqCHbVkJEwyGNhx7Ilxxi+aRdpuXqxk39g7GuQkUJDMpj/yGTOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxyiRcep; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso1404300a12.2;
        Wed, 07 Aug 2024 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723044257; x=1723649057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbDcCJvPNRNpC4aX1OzirY7PNPGSPI/8NwUARfS27JY=;
        b=lxyiRcepOfch8JyB6COnqGajU/fwqGMYI7krrkNrS/flT7UH+swzurqZ4QXfw5Sykx
         JsSd66xlqWGzY3pzm/6YYQoIfwMJidvPO9pmBQ5vQlidRQ8LGFCfSdBKvz9mUSDHketx
         b8CDDsS3GdAzsvAN1sv+ypn5WysAOkJTwYsuOahShG9KJm40Sn3/zoBZXA4Wh5z67Ioo
         Vm8mLXLAn6M2MHT+nXi2IQEgwZ0sKlCgg3DarZ5cArdhrDhtsv5DRAKtsw/a3eefPj/l
         WWE3EeSMYBJ1588D95xO4E7X93koFT8h4sZIuGvBF4d4OU/0LBAN2MuZLLdcwSiWA2ZS
         f1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723044257; x=1723649057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbDcCJvPNRNpC4aX1OzirY7PNPGSPI/8NwUARfS27JY=;
        b=btecsGiGW7ZMeC83SWUzNwhV/fmRqK0MYbUuj8CTKFf7JoZ3LAwNEgUk56eLB5okzl
         UZFoDsI60zlXjGSe8SoXh5IGZDXFtAoWXyPUY1TpSJuShaeVEOvVIcxI1djES2fSMGrp
         WvJDDWysa4mxfoTrO72/7hxz44wg5oruJQG1ghqQ18OHZvir3ikw7PChpwcZHTrWa6Rj
         /lsKi92tpTWTEabX5R1mQ29jcDvs5EwcMOMgnJdCmniI6/9kNKT+qcNrxE9iBVIx2w5k
         Wkmw+XjzKw0QzUsMJLeVDTSJNJoL5/mp1HI4DwlEgrtmSa0QBMO9IvZajY/XAq/QSyUW
         spvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWScgcDOZgNrdlXaqezqGWAd/yQnAPfAg/ltlOtXUv3xW+NsmLK2xcm0FWIERjNie3QgrMlfRHmQdtWEBcdbBbjnwCgZYwWlheFGab3KZa6s2rTItnEUPLkdyPuTGO5WL1sU2PJlCEpJpiVZ0q0d6PIV6i4ufE6fJ2Pge13hJcvIsMRh6bZ
X-Gm-Message-State: AOJu0YxX5wHQT/k2bij28V0C+kRlm6dxuVv2YA2sU7Bi6RHFO4Fmywia
	bG0ZhywHhILdLuj1gQfUZrf2rwfiucEo4P+8nb4DtPBvh2eVtXISmLuuBOerbvXAU5iJ4zquW7C
	AkhtHvuSgHVf7msMB0opVRHK3GIA=
X-Google-Smtp-Source: AGHT+IHd5L60soA69oQfvZaSbKGh/Af6O+NhckWDP+Cq/EbKRh8dwZPSOptlz5tGokig2e1+QZMY3Nr7YqZ14+6R27o=
X-Received: by 2002:a17:90b:8c2:b0:2ca:1c9e:e012 with SMTP id
 98e67ed59e1d1-2cff93d4117mr18278788a91.6.1723044256637; Wed, 07 Aug 2024
 08:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240807132922.GC27715@redhat.com>
In-Reply-To: <20240807132922.GC27715@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Aug 2024 08:24:04 -0700
Message-ID: <CAEf4BzZSyuFexZfwZs1bA9S=O0FHejw_tE6PXm5h8ftMsuSROw@mail.gmail.com>
Subject: Re: [PATCH 0/8] uprobes: RCU-protected hot path optimizations
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 6:30=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 07/31, Andrii Nakryiko wrote:
> >
> > Andrii Nakryiko (6):
> >   uprobes: revamp uprobe refcounting and lifetime management
> >   uprobes: protected uprobe lifetime with SRCU
> >   uprobes: get rid of enum uprobe_filter_ctx in uprobe filter callbacks
> >   uprobes: travers uprobe's consumer list locklessly under SRCU
> >     protection
> >   uprobes: perform lockless SRCU-protected uprobes_tree lookup
> >   uprobes: switch to RCU Tasks Trace flavor for better performance
> >
> > Peter Zijlstra (2):
> >   rbtree: provide rb_find_rcu() / rb_find_add_rcu()
> >   perf/uprobe: split uprobe_unregister()
>
> I see nothing wrong in 1-7. LGTM.
>

So, I don't know how it slipped the first time, because I tested
overnight with uprobe-stress, perhaps I adjusted some parameters (more
threads or different ratio of threads, not sure by now), but it turns
out that lockless RB-tree traversal actually crashes after a few
minutes of running uprobe-stress. I'll post details separately later
today, but I suspect that rb_find_rcu() and rb_find_add_rcu() is not
enough to make it safe.

Hopefully someone can help me figure this out.

> But since you are going to send the new version, I'd like to apply V2
> and then try to re-check the resulting code.

Yes, I was waiting for more of Peter's comments, but I guess I'll just
send a v2 today. I'll probably include the SRCU+timeout logic for
return_instances, and maybe lockless VMA parts as well. Those won't be
yet for landing, but it's probably useful to see everything
end-to-end.

Given the hiccup with lockless uprobes_tree lookup, we should land
that change, but the first 4 patches hopefully are in good enough
shape to apply and reduce the amount of patches that need to be
juggled around.

>
> As for 8/8 - I leave it to you and Peter. I'd prefer SRCU though ;)

Honestly curious, why the preference?

>
> Oleg.
>

BTW, while you are here :) What can you say about
current->sighand->siglock use in handle_singlestep()? Is there any way
to avoid that (or at least not have to take it every single time a
single-stepped uprobe is triggered?). This turned out to be a huge
issue for single-stepped uprobe when scaling to multiple CPUs even
with all the other things (all the SRCU and lockless VMA lookup) taken
care of.

