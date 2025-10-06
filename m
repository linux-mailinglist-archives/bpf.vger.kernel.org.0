Return-Path: <bpf+bounces-70455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB00FBBFC32
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 01:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E3D24E85AD
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 23:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB121F1505;
	Mon,  6 Oct 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS1f4wmJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8118C1A254E
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759792901; cv=none; b=RP4MK7H2Whs9Yk9bG/1PFsEiAevTELvPgLFt7e6X4orhGRrezGXXqcw6dtCLIN1Uv5fbSoHjMWWseAo8r41wdpCa0Uk/tpi+QaRRz+ALj+PZmAQlS5FlqAdHb6vKTAzKUPstY8Ys8uay0FSNjbhQF7BERB+n+GHJai31QBqcm64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759792901; c=relaxed/simple;
	bh=BlF8MRmuAY5ZGP/hSG05FFgxKgRsiLUZrKxnhJp/7YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5/O++EMZrnnF9KbT264PsHK6J2zWFSmSaTFFs2Rl7IV12WKYwC/HOvAHA0opD0nETznAEPgP7ECL2ZZKaqPzWEQ+d5vLPSP4JvaFNC+DPURaHQbQ4CPNLcTUxyKWZjTLVV85+CzqNvlQfBBP6i40UWQ3YRkeVsJV4kDul9p3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS1f4wmJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26c209802c0so53895785ad.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 16:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759792899; x=1760397699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlF8MRmuAY5ZGP/hSG05FFgxKgRsiLUZrKxnhJp/7YA=;
        b=IS1f4wmJL9fFXAGzRb6belq7QkyOYZ9d+m1R10KdtSrofhS7r6/4V5rEtQO4QZ6RX0
         iuPcEIxcRNWhnapKfJXwotXg/uATlRUCOhJq6bk7C4Rj5aEFYnIWDkEdzhbB0/KqtaTd
         8wZNGko7fvUkdB94fR3vijdcU63xxzJQUTdNgPXaWlGIro8mBOzIrm4jU72gZAB3fb9Q
         IU4kDSVzxG9eWZ311BZ9ZcJk0SAGg7uMgt+XZ4yNTLBuI2pRlF+mqfao0wP53yu/nUa5
         P1Ykf/wiDP+o8mHkpbz5OT6yi64ennv0WE0cYKZdieO8LTF+Gf80ULWllB1iL/4lH72z
         o7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759792899; x=1760397699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlF8MRmuAY5ZGP/hSG05FFgxKgRsiLUZrKxnhJp/7YA=;
        b=SpmEGGZC0kwrJuKhdi9mLj45Lw8madNIaiEGHiOpNX8OqFb3V1MCoCTgVE2lYU9FTL
         lT6D52X4s0lmb9HkBmAeLVv/G+O6eFLWy+ZJzeiI7vacU+Fw6hxw2l4ZC40AUNAMMnpj
         6OIk1qF87/JSyWigp6m0ZIrMUK6e6XdWnPTU0coULv7MghBMrVgdLUW/Q1gFst083J8c
         S863niUeiE5wuGxi4CbaG+t3Ltec2ZL5PIAh7UBHNocyPukMSq1AjfLv6b74hsC0YviP
         kyeeXIBcQ5lK9z2ZyrErNpLSPWaoeDEkm2CkAdBqTyc6rZ9fPtNO/zTRId30OX6qVonq
         CX4A==
X-Forwarded-Encrypted: i=1; AJvYcCX3o9d3+XYradVMYsIggR/vt/V7b7ENY5cM+E1p+2Jp2BFiDqrr7BZxTH3I0oh007fWcvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaN5xCSx+3GoGCIKZUSBWv8FjD7Ijv1j3SgG2w5NClgXFXLWBL
	tMDAPwsLmTZS5MCnQsW0anjuainBzcXzamhtviTYwGfDMvJApSbO2Bx1xXorDZNG2d7t6tqoDRD
	+1CzQ9u0x82yvYMHPz9IellFrMcEiGoA=
X-Gm-Gg: ASbGncvRhXCTAhEk9Xk/TrFS+ZBWodAX9fIkLBIAylAXiI/h/D0S7GHMRDiNGm7Llc5
	KW1fFxGv+1D2+huVqH+rNbee0kgHRdnB243HD2unPDc6ZWeJL7pWLAIq/t8XjMl7Tgmshe4a8B5
	D7QI9+d/al7GS2ZHMGrWnjhmhDxLjrc/4v3gbhXerqU4CmfycjHyFp57yJv+/QzJQirrt7DIaA8
	FBGNfr6bCUHVm4BzUNyywQVVvq25noamMZeyUURCKVgt04=
X-Google-Smtp-Source: AGHT+IFbiIZLWXUzbg0MpPNz8jI3+5uhR1e00vTKI1xy/5u7Pb90M6pGakUvtknMmHcQXhggccYvP9be6Tx3vlFcycs=
X-Received: by 2002:a17:903:b83:b0:26e:62c9:1cc4 with SMTP id
 d9443c01a7336-28e9a54ef95mr136288395ad.4.1759792898721; Mon, 06 Oct 2025
 16:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev> <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev> <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
 <87wm6rwd4d.fsf@linux.dev> <ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
 <CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
 <87iki0n4lm.fsf@linux.dev> <a76ad1e9-07d5-4ba1-83e4-22fe36a32df0@linux.dev> <877bxb77eh.fsf@linux.dev>
In-Reply-To: <877bxb77eh.fsf@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Oct 2025 16:21:24 -0700
X-Gm-Features: AS18NWDafFk0nrI4dX1WXSkb90Zju3Gm0uidZQfWzJfIM8rRKysrrjNo3H_c-hs
Message-ID: <CAEf4BzafXv-PstSAP6krers=S74ri1+zTB4Y2oT6f+33yznqsA@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 7:01=E2=80=AFPM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
>
> Martin KaFai Lau <martin.lau@linux.dev> writes:
>
> > On 9/2/25 10:31 AM, Roman Gushchin wrote:
> >> Btw, what's the right way to attach struct ops to a cgroup, if there i=
s
> >> one? Add a cgroup_id field to the struct and use it in the .reg()
> >
> > Adding a cgroup id/fd field to the struct bpf_oom_ops will be hard to
> > attach the same bpf_oom_ops to multiple cgroups.
> >
> >> callback? Or there is something better?
> >
> > There is a link_create.target_fd in the "union bpf_attr". The
> > cgroup_bpf_link_attach() is using it as cgroup fd. May be it can be
> > used here also. This will limit it to link attach only. Meaning the
> > SEC(".struct_ops.link") is supported but not the older
> > SEC(".struct_ops"). I think this should be fine.
>
> I thought a bit more about it (sorry for the delay):
> if we want to be able to attach a single struct ops to multiple cgroups
> (and potentially other objects, e.g. sockets), we can't really
> use the existing struct ops's bpf_link.
>
> So I guess we need to add a new .attach() function beside .reg()
> which will take the existing link and struct bpf_attr as arguments and
> return a new bpf_link. And in libbpf we need a corresponding new
> bpf_link__attach_cgroup().
>
> Does it sound right?
>

Not really, but I also might be missing some details (I haven't read
the entire thread).

But conceptually, what you describe is not how things work w.r.t. BPF
links and attachment.

You don't attach a link to some hook (e.g., cgroup). You attach either
BPF program or (as in this case) BPF struct_ops map to a hook (i.e.,
cgroup), and get back the BPF link. That BPF link describes that one
attachment of prog/struct_ops to that hook. Each attachment gets its
own BPF link FD.

So, there cannot be bpf_link__attach_cgroup(), but there can be (at
least conceptually) bpf_map__attach_cgroup(), where map is struct_ops
map.

Having said that, we do have bpf_map__attach_struct_ops() already
(it's using BPF_LINK_CREATE command under the hood), and so perhaps
the right way is to have bpf_map__attach_struct_ops_opts() API, which
will accept optional extra attachment parameters which will be passed
into bpf_attr.link_create.struct_ops section of UAPI. That thing can
have target FD, where FD is cgroup/task/whatever we need to specify
attachment target. Just like we do that for BPF program's
BPF_LINK_CREATE, really.

