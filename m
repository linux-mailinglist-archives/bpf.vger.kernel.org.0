Return-Path: <bpf+bounces-77615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDEDCEC624
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 045A6300B91F
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D47A28CF52;
	Wed, 31 Dec 2025 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3VOGLpc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F80D2222C5
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202352; cv=none; b=fiwF7a06toQgdjbzJPK1tX6JU0qj0p3Ur3zVK4OdVdkNG1lzkerU3Ob5yJe80priCWoSRGTle9n+w8hkrtQvrmU8RobDu/7CFeYytbJ1IbRwlDmuiPgn3dcVmyx02kR72+JJ8om3ETeze92oYtyhXSH5R40lvrUYXXf+Gy8Rzn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202352; c=relaxed/simple;
	bh=CWoDrfHmOdhFciCxsmJwQCN9HJQusNNBucTfzYig05Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOQqLz9q4AaFPcr74btdpRO0yGxfb2qXCwign3gv0MjjgXBqHABCfFOSBk5VS7VePh4xQMJhLPUbrJ5EVfAHQ/oMBTHzc0P9b/w9rAvkgb7xNdZjfigTIVdYDZDQ0/9mlOjFhm6jWZDXLtUxJ8OjoPhDxPXXUyjYi4ioR4e4CSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3VOGLpc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so5136649f8f.3
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767202349; x=1767807149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5VuiLn3dVAn40uBcT/YeDlX15d0jLQo0ZWVzvFA7PA=;
        b=G3VOGLpcUC52OLRAdDZO/XOeDADOgC0BarXtTyGA4Iwa+2i+4vJGp+4wGdXosJQTHJ
         3a9qTExw7AKK2oto24fM9hIjbEj9hZASOkZh6lUYqCNGZaexFW5WoI/bNEQUXbp7Y6+i
         R5JRgjrGELpP7A3v7ibZeI/JJInpwMsCy5PjvMFjX6Wh5+q5juPNi16h7F6EYSEIc4Bi
         t7/Y4lVnOQnOH+oEq7XgZ0Nrsanm9d3T6JIj93RVbh2u4RyssHY/OM8xCaewHz1mbr3L
         F4BMXbLuFaGzcu3mqNpWowd/kf0DOu6CGlIzO3TmZsxS60Cw4/NyXYERwJoj1kQOk43U
         BFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202349; x=1767807149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U5VuiLn3dVAn40uBcT/YeDlX15d0jLQo0ZWVzvFA7PA=;
        b=XWgERLiWtUpPjeMMXIobRgnIb7s0JGUPuWvE9PznzDe9jRP7KijypiZIISh4o7l7en
         UnD13zZ9rdEMpWkFQbs2Jp8JO08ZQX6g0h7rE/nq50AYlJ5TOB46bdE2867PCoDdxuUg
         4P8k0el5Hdj8ihf/NWF6R1OiGB9LAIQVLduoR33uMsLgCMtyyPl2cQrg7y/tjNKcMQio
         04zeOA71SeK70uNQN2AMDImCDMV0V0FVWCB42RIAmhmLNSOnXDgROAHQ6yKinO7Q6H0b
         3yaP0bIg+cuVrhHMvM30CZpCfJoiA6q8fc8d1t4RW+XvE6yutDU8Sv+myjazwINcosxy
         DMHw==
X-Forwarded-Encrypted: i=1; AJvYcCUzjvrFM5pQ2iD/PE2Wm5lUfZCSOIgkpvTGoBkkkd8VHAtPkYfL7GbH35tEExOxAbzwPWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYyovVsIfM0Xr/BZjgMahuD2HEG2W+rUjHP7wJgxg96RTvow/U
	nDCA11PN16TaKpdd9X+2F26Mlpp6Yup1Eca5GDnjSH/M1ch81Va6V75t0p8QO1NLYe0ZUG3CsS+
	dd6AwbeF9uKwLQHdo1dsF+Cu/W1IuSJA=
X-Gm-Gg: AY/fxX4QHcPzwJDTDYGHZEoYxDKGlOlxZrUyajOxG8coBiAPlkL//EqI5+R27zHmhuD
	tRGLEids2yMi0M/gjxsbSv7zObO55z+uMczFSnwtTvmndy2368kwWzzx8MGjcVaFuK2UhsvN1Fg
	B4aaAlYXyYtEk9ccEUlT0D/4EmC+RmInnRvFOBMTMqjT8PMaR2hsGA2gVcN4P1YGIAk/eKUfP3Z
	RkJyfgMglUd6ZnKfAGDHuYHvKF2Ot4IrPXTqTLFg7a0e5WA+d55g1SICLcqn90uumeNUtP41lU/
	5O+EnJgBpvDSHIiLPRHdWlRkfzgj
X-Google-Smtp-Source: AGHT+IF7HyxxRbtC84cXSMOHnJT4OH6Sl+m5edZ7DMni0hLzLRwsRYANm/mz1DDpTK4ecNOoY4W/98DOOm3T/bFVH4o=
X-Received: by 2002:a05:6000:3104:b0:431:9d7:5c2e with SMTP id
 ffacd0b85a97d-4324e501694mr44836005f8f.35.1767202348661; Wed, 31 Dec 2025
 09:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
 <20251223044156.208250-4-roman.gushchin@linux.dev> <aVQ1zvBE9csQYffT@google.com>
 <7ia4ms2zwuqb.fsf@castle.c.googlers.com> <aVTTxjwgNgWMF-9Q@google.com>
In-Reply-To: <aVTTxjwgNgWMF-9Q@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 09:32:17 -0800
X-Gm-Features: AQt7F2oadTXea_Sik1GVA2Fk1q8JBbDHb41lLkyeYrVxdpyCyv7zsIwArp1KPOg
Message-ID: <CAADnVQLNiMTG5=BCMHQZcPC-+=owFvRW+DDNdSKFdF8RPHGrqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/6] mm: introduce bpf_get_root_mem_cgroup()
 BPF kfunc
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 11:42=E2=80=AFPM Matt Bobrowski
<mattbobrowski@google.com> wrote:
>
> On Tue, Dec 30, 2025 at 09:00:28PM +0000, Roman Gushchin wrote:
> > Matt Bobrowski <mattbobrowski@google.com> writes:
> >
> > > On Mon, Dec 22, 2025 at 08:41:53PM -0800, Roman Gushchin wrote:
> > >> Introduce a BPF kfunc to get a trusted pointer to the root memory
> > >> cgroup. It's very handy to traverse the full memcg tree, e.g.
> > >> for handling a system-wide OOM.
> > >>
> > >> It's possible to obtain this pointer by traversing the memcg tree
> > >> up from any known memcg, but it's sub-optimal and makes BPF programs
> > >> more complex and less efficient.
> > >>
> > >> bpf_get_root_mem_cgroup() has a KF_ACQUIRE | KF_RET_NULL semantics,
> > >> however in reality it's not necessary to bump the corresponding
> > >> reference counter - root memory cgroup is immortal, reference counti=
ng
> > >> is skipped, see css_get(). Once set, root_mem_cgroup is always a val=
id
> > >> memcg pointer. It's safe to call bpf_put_mem_cgroup() for the pointe=
r
> > >> obtained with bpf_get_root_mem_cgroup(), it's effectively a no-op.
> > >>
> > >> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > >> ---
> > >>  mm/bpf_memcontrol.c | 20 ++++++++++++++++++++
> > >>  1 file changed, 20 insertions(+)
> > >>
> > >> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> > >> index 82eb95de77b7..187919eb2fe2 100644
> > >> --- a/mm/bpf_memcontrol.c
> > >> +++ b/mm/bpf_memcontrol.c
> > >> @@ -10,6 +10,25 @@
> > >>
> > >>  __bpf_kfunc_start_defs();
> > >>
> > >> +/**
> > >> + * bpf_get_root_mem_cgroup - Returns a pointer to the root memory c=
group
> > >> + *
> > >> + * The function has KF_ACQUIRE semantics, even though the root memo=
ry
> > >> + * cgroup is never destroyed after being created and doesn't requir=
e
> > >> + * reference counting. And it's perfectly safe to pass it to
> > >> + * bpf_put_mem_cgroup()
> > >> + *
> > >> + * Return: A pointer to the root memory cgroup.
> > >> + */
> > >> +__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
> > >> +{
> > >> +  if (mem_cgroup_disabled())
> > >> +          return NULL;
> > >> +
> > >> +  /* css_get() is not needed */
> > >> +  return root_mem_cgroup;
> > >> +}
> > >> +
> > >>  /**
> > >>   * bpf_get_mem_cgroup - Get a reference to a memory cgroup
> > >>   * @css: pointer to the css structure
> > >> @@ -64,6 +83,7 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgr=
oup *memcg)
> > >>  __bpf_kfunc_end_defs();
> > >>
> > >>  BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> > >> +BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NUL=
L)
> > >
> > > I feel as though relying on KF_ACQUIRE semantics here is somewhat
> > > odd. Users of this BPF kfunc will now be forced to call
> > > bpf_put_mem_cgroup() on the returned root_mem_cgroup, despite it bein=
g
> > > completely unnecessary.
> >
> > A agree that it's annoying, but I doubt this extra call makes any
> > difference in the real world.
>
> Sure, that certainly holds true.
>
> > Also, the corresponding kernel code designed to hide the special
> > handling of the root cgroup. css_get()/css_put() are simple no-ops for
> > the root cgroup, but are totally valid.
>
> Yes, I do see that.
>
> > So in most places the root cgroup is handled as any other, which
> > simplifies the code. I guess the same will be true for many bpf
> > programs.
>
> I see, however the same might not necessarily hold for all other
> global pointers which end up being handed out by a BPF kfunc (not
> necessarily bpf_get_root_mem_cgroup()). This is why I was wondering
> whether there's some sense to introducing another KF flag (or
> something similar) which allows returned values from BPF kfuncs to be
> implicitly treated as trusted.

No need for a new KF flag. Any struct returned by kfunc should be
trusted or trusted_or_null if KF_RET_NULL was specified.
I don't remember off the top of my head, but this behavior
is already implemented or we discussed making it this way.

