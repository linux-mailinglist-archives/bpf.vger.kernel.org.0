Return-Path: <bpf+bounces-72978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63423C1E934
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 07:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BAD42042A
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 06:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B69A314B90;
	Thu, 30 Oct 2025 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlHPwUQ0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E432F7464
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806049; cv=none; b=FQulG+wTZV9qn79cxWytNGkGfFQ7Z5g3YtOOC5Kl9EJj4+5ijqzKSd7M5CGFuT62iX8tdu810rNhzBTeu62fDjzOV4ArUBVx3XQyFJhqS7GxoJy4mUz22H20TqMOfo+d1TCPrYuH5IEedoXE6QHsMOkKklHyvTDTLNsnEVQsImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806049; c=relaxed/simple;
	bh=zflyYk3NYy4RcPJITCP+PJ6c8wHVT/sLZfTTgaXKfCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pT/y+dIuNHVzI+ZHJKCfADIn4TrotmyTUiFNJrZwBSnaWCfJpDpR07iTOuTQlIkp+r0kjS6GqR3k4Qs4DkswO/5j5uDtJju/UHzcEyJBQW5FOuEtaZJmP7/CPe/kAK/zDgEn37h1hISLZOHHDf9qESJIRKlyPDBnGXazYvdgj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlHPwUQ0; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-785f96ae837so7763257b3.3
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 23:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761806046; x=1762410846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zflyYk3NYy4RcPJITCP+PJ6c8wHVT/sLZfTTgaXKfCk=;
        b=UlHPwUQ0YSemv40ZGHCY7NIcxtx7Vdgvi54HCNlWgnToL98ONPEPEua6KiSleMKvZs
         CGnpyBNJFvkkMHenB1MYC3FLSNu4BVaOiNYS2FzlzUO6WDaLIyTlISp7339s0hodnitz
         6NtQdZzitvGieoICQidNlR+dlXRT3hTHxEwl8J4iQvV9gna2odKV7Ht6yhIorppqiufi
         N7AIYwAf2kZZsQyZroDk/uMqWMB6gcMFTIgVbfEM5/zUdFgdrvSVSvqRfEpQxK1BeqZP
         HTT+txarUxveXuMlN1i28dJ/0tXeO2ADi8ncOckcaXvpdiHuJvRV3RVl8rNTawxwYOH5
         3tZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761806046; x=1762410846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zflyYk3NYy4RcPJITCP+PJ6c8wHVT/sLZfTTgaXKfCk=;
        b=Gx+N6DFx936YuwWpN+dsrQetO9kggOh4C9KSn+u5TWlfWWdN1l6WpbH3zgDdDTXeha
         PqKvqQYvUOfzzVmzRSSMU3EfAljgUE4ulVV2HcntllZZ93yVTDsV6NAcbwsac7eA+nFO
         FbWJsNcg/7l2iiRAPHy2ZR9ujWfPsfzHBOT+Urhr5eHl5OZoBBRowyHUA/9KsGr56BRf
         FaqKzVrLycwnu5V/MhW/Mz4DQVCb+1fcu7tJvNkouC9uJ+SogpqPX1Y+5vQZ4qfc2zZz
         lqohKpsn+QYFaCmtTU+IzUzO1Qu75/lbGMgjcNWTSgVqJJcmD0TuPjvdfbc83tExg4Hg
         fLHg==
X-Forwarded-Encrypted: i=1; AJvYcCWqCtiBp66jV2PFoy6aw56O4ykcYlnjTJGBvbjcjEye8PhJgPLdjNyYet1F5NyQzqTC/C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbYmn/W3yenrnfJxJFt3CgXo6t2rY1XfsOv4X/qH5lnU0k4dYX
	Lc7u4oB+zkhU5WaizkgiR6OY0ZtmxEvaur3dt7jGtGVThSzelTVGtoard6+JrMVxIweyoTFJWtE
	kUtVCnK0lB7582vRMU4ehZL/0+yLelWQ=
X-Gm-Gg: ASbGncvE5oifL1htQXS/Uzxk8FCiscx29Dx1hbW+TlSf0OWoQAyGfljAByjYk/3+qrd
	vLj7Tkevlam5rUnqj0/JTQop0rpOHhfEr52a7nABfolBi/+PCcyfubX7Xm8xCI9rsb69HmYsolT
	1OAkx5yFdyADKQtoNuVUpFlMt5BPe4YtF5cJCh2W/u9jrssGJCALHUUSnK4PAueL1V+2t9UF+NA
	JXU7uvEHKVKR7v+xNgAPuclqp2sQ4lKCwuquQRt7GvA8iLLfZ7jd3kaAppYS3+FXz83f+cp
X-Google-Smtp-Source: AGHT+IHAkzPCtNQ20ppd+4ZhB3lJD10RCDw7ZQWKRcjkJ/MU+ifVpTXFAcgPBxAL5BiXPDLqVFNv4y1b/arwSry/zk8=
X-Received: by 2002:a05:690c:b95:b0:781:159:33ae with SMTP id
 00721157ae682-78628e82453mr55969657b3.4.1761806045641; Wed, 29 Oct 2025
 23:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev> <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
 <871pmle5ng.fsf@linux.dev> <CAADnVQJ+4a97bp26BOpD5A9LOzfJ+XxyNt4bdG8n7jaO6+nV3Q@mail.gmail.com>
 <aQKa5L345s-vBJR1@slm.duckdns.org> <CAADnVQJp9FkPDA7oo-+yZ0SKFbE6w7FzARosLgzLmH74Vv+dow@mail.gmail.com>
 <aQKrZ2bQan8PnAQA@slm.duckdns.org> <CAADnVQJPcqq+w0qDjMV+fx-gYfp6kjuc7m8VD-7saCZ7-bvaBw@mail.gmail.com>
In-Reply-To: <CAADnVQJPcqq+w0qDjMV+fx-gYfp6kjuc7m8VD-7saCZ7-bvaBw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 30 Oct 2025 14:33:29 +0800
X-Gm-Features: AWmQ_bmDSiMH7BHRJ2t-PSFn5y1B5iA1PUPKgXH8mX3AM57qm-0dXLGAddjgEhY
Message-ID: <CALOAHbBW0jM=WZG7BM3Lh=xHBV7M585j85xMzpWAtWdrkRa+nQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:16=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 29, 2025 at 5:03=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> >
> > Oh, if there are other mechanisms to enforce boundaries, it's not a pro=
blem,
> > but I can almost guarantee as the framework grows, there will be needs =
for
> > kfuncs to identify and verify the callers and handlers communicating wi=
th
> > each other along the hierarchy requiring recursive calls.
>
> tbh I think it's a combination of sched_ext_ops and bpf infra problem.
> All of the scx ops are missing "this" pointer which would have
> been there if it was a C++ class.
> And "this" should be pointing to an instance of class.
> If sched-ext progs are attached to different cgroups, then
> every attachment would have been a different instance and
> different "this".
> Then all kfuncs would effectively be declared as helper
> methods within a class. In this case within "struct sched_ext_ops"
> as functions that ops callback can call but they will
> also have implicit "this" that points back to a particular instance.
>
> Special aux__prog and prog_assoc are not exactly pretty
> workarounds for lack of "this".
>

I also share the concern that supporting the attachment of a single
struct-ops to multiple cgroups appears over-engineered for the current
needs. Given that we do not anticipate a large number of cgroup
attachments in real-world use, implementing such a generalized
mechanism now seems premature. We can always introduce this
functionality later in a backward-compatible manner if concrete use
cases emerge.

That said, if we still decide to move forward with this approach, I
would suggest merging this patch as a standalone change. Doing so
would allow my BPF-THP series to build upon the same mechanism.

--=20
Regards
Yafang

