Return-Path: <bpf+bounces-67466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A3AB442AB
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A404586E50
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A76287277;
	Thu,  4 Sep 2025 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOYJgNzz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A2233128;
	Thu,  4 Sep 2025 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003223; cv=none; b=nsAxfnZykfPlNVmBxnR3sQ2+7fBXOd36ZMitLlFcqA/PbWNLJwYHfg0OROMjU5Pxj+hRDridXDFowpHf3A9dJ9BW6QIXZN0iv1UU1H9n0nxF6TS2MwlGeMEos45YBPLBcEEXgzLW18yaNx77w1XH9oCZPffZhc2IR35PQOMicm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003223; c=relaxed/simple;
	bh=Bya9Y6QWAztwGmY9OYG3eZmk5jgZ6V/z6Ca+KAlwX0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUSntXReNrYBd+YnDeXFn1lN7Q+H+7AB2zE1r6ZwTIoTUtuPDTtGsECvbmGq4OrQVozQ4ydXNZR3xqaJ98jDh9yn8ECaZqVBDJMTOaFDDwN3CtgHlTLfbWFxbmxZSsWCuDU+sSFQ0u40c6MgWFAlI0CJzTZAhNBXRwVPW83bGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOYJgNzz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b02c719a117so228569366b.1;
        Thu, 04 Sep 2025 09:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757003219; x=1757608019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x52XGF6iKHX3+nNGSEK/taBXgCRgBT1zKgfjO9/y908=;
        b=eOYJgNzzn9P1KdYbU2bseZGy6bgDwHYlrJdCNlAXDRwFAOczZJ/TIYEGXAqALfIEiQ
         f43JfAdmgw1M1+U6pZ+R5HWnKHUbvUUdXyqM3mG1pKn3zAf1O5tjUxfrK05LloQ+Iz/f
         7hQil+cK2iE/1qdxrfAi9hxMqv8J4K6xQYWbjdZ2dI+1WbQNsGwLD0TPWzWllgOmjnZg
         yHmNQHX5WYEtr7NdT2sSwzqQ8r3I9Uwjkp6m2FYt0bq1WfgYhokZyOvpMgNL2CaRI2AN
         NSWierApHP8qqMz69BWXVePa+btFg6z8Pxxzx5aYnyfSA2x1sv2zTj3/Ch8bJj1nSkzv
         Fpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003219; x=1757608019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x52XGF6iKHX3+nNGSEK/taBXgCRgBT1zKgfjO9/y908=;
        b=btWBovK6RYumQDYU/51fGrq8+tNCF2W/cPRcXM6zY/iQWkyXGQNkYrbUlX2qVD6umG
         7k0xPW3rFZ/l6U0CVObcRoXWSBFRCrfxjdT5CE0U0pGM/upZe3wJpuwi7NC4WEthpQHv
         BFEJnYBJBpPber6GsVmLYXAiTNXzvsVha3OJfsZirIFEVJRg4tX/GDT+zLXyc/MEaA2D
         BnCPJsw3gNOC9RE4smg6NpoQxXfC5eyr/SzBYqO1lAWV25XZ83pRP9k4J9ccFKEZltlb
         QIb+llTc1FLXnUJ3CKxZC7eATsUOhceyd07DBS9AbPnCTEYN9E2JZNS8OIWkBQPpVDb5
         Dg/A==
X-Forwarded-Encrypted: i=1; AJvYcCVCeQpziAGzv0ZPY2/XmcNM5GpCD0eaPlmJ85TUgj2U26EJbv7u5Pst/Hm66QlVYUYldI0=@vger.kernel.org, AJvYcCWPrBUO0BbusOS4gYsjz1jONFMvhKnevy/VAWsWDqMcyTh7EpoKjkhhwLI8pGwWbeHthPuNF9cFGYV1x9cD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxalh13XXFLjXbqQO3UQAVU6Sr0rQWENRZaTn1tplX18/fY5Vjy
	d+2Zudjh7TrlciYVrWJVGYRrjLwDsQZTCyUbEuF4Bb+tS4KQv7K0Ojj0bf7YvhryDg1RtPu5W8t
	biGcyAq0Ur906KAVujKz1y5wxZQLae2U=
X-Gm-Gg: ASbGncv9LbcCK8en+tbEsAVqFiFU5yWm6+qBC53k+JG20gw65mdOIQ4+Bkm6ShRhKxu
	sNO9n1Ll7ulk03WVOqc50VcqSzEYXv//GnCaDzDe7Opw6quCobWp783AYpVayocSuGMk3XXwf3/
	T2D5U5sjsrPg3SHxjwFvhDjr7TyP4MGOkmfzhX4iR5/f6g5ZOkwaRS4wL2xK/y7NCmZCWoFTblO
	EdytYbb1lg5iD1H5VVUjYc=
X-Google-Smtp-Source: AGHT+IFHSx6hZlZJjgmXEk+skdNc6NPbwOFgHFtM3QRF1Gu2C6CnQMdkH8gTqKiWNIYivCF3n/UdO95dBbR/N21HyZ8=
X-Received: by 2002:a17:907:7f0e:b0:b04:74d1:a57c with SMTP id
 a640c23a62f3a-b0474d1ae30mr464217866b.58.1757003218864; Thu, 04 Sep 2025
 09:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-2-roman.gushchin@linux.dev>
 <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev> <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
 <87wm6rwd4d.fsf@linux.dev> <ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
 <CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
 <87iki0n4lm.fsf@linux.dev> <aLeLzWygjrTsgBo8@slm.duckdns.org>
 <87qzwnxgfr.fsf@linux.dev> <aLk0FuezkcInlM_r@slm.duckdns.org> <87h5xi1e6p.fsf@linux.dev>
In-Reply-To: <87h5xi1e6p.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Sep 2025 09:26:45 -0700
X-Gm-Features: Ac12FXwS8NBvLhK0GXWhEwLEcG0BPLfgFRE5uUtzqIDYNw67JkiC3-IZJcrgDd4
Message-ID: <CAADnVQLBrOgeH5T2iXa7nNpHTtQvpzuzfOgEgPQv8T_AKEg6mQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 7:32=E2=80=AFAM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
>
> Tejun Heo <tj@kernel.org> writes:
>
> > Hello,
> >
> > On Wed, Sep 03, 2025 at 04:30:16PM -0700, Roman Gushchin wrote:
> > ...
> >> > - I'm passing in cgroup_id as an optional field in struct_ops and th=
en in
> >> >   enable path, look up the matching cgroup, verify it can attach the=
re and
> >> >   insert and update data structures accordingly:
> >> >
> >> >   https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/t=
ree/kernel/sched/ext.c?h=3Dscx-hier-prototype#n5280
> >>
> >> Yeah, we discussed this option with Martin up in this thread. It doesn=
't
> >> look as the best possible solution, but maybe the best we have at the =
moment.
> >>
> >> Ideally, I want something like this:
> >>
> >> void test_oom(void)
> >> {
> >>      struct test_oom *skel;
> >>      int err, cgroup_fd;
> >>
> >>         cgroup_fd =3D open(...);
> >>         if (cgroup_fd < 0)
> >>              goto cleanup;
> >>
> >>      skel =3D test_oom__open_and_load();
> >>         if (!skel)
> >>              goto cleanup;
> >>
> >>      err =3D test_oom__attach_cgroup(skel, cgroup_fd);
> >>      if (CHECK_FAIL(err))
> >>              goto cleanup;
> >
> > Yeah, that'd look better but are there practical differences? The only =
one I
> > can think of is fs based permission check but that can be done separate=
ly
> > too.
>
> The practical difference is that a single struct ops can be attached
> to multiple cgroups.

+1
Attaching the same scheduler to multiple cgroups also sounds useful.
I feel sched-ext should use cgroup_fd too and do scx_sub_enable() at
attach time instead of load time.
Then scx_sub_disable() can happen at link detach.
Looks more flexible from user pov.

