Return-Path: <bpf+bounces-79308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB85D339BD
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 17:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD1C5303E688
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91339A808;
	Fri, 16 Jan 2026 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4EajVfO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481082571BE
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582703; cv=pass; b=NDjDKAnXMRe3RXE4T9icwC3Rf67XwVplMLQAm6BUVWno7FMx9790Oh3ZIovdE9TnwruCstYFEET9DeI3ohHdJTDGrpLtGxLP4GKRnbrEQAiJcj+3lJ5AYu60ic5hsVBtNv7PvhivJ+DI+kaSmJN43sEUizqeKLoQFyZRh6+QKHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582703; c=relaxed/simple;
	bh=u2xorRoykCJYfBHwt/70olFyGaH+Wieq9MkT2DW/j1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgUjTecpjnmLK83z9es0YLMXcYPj7QLgFUsmSSYEd8D6VHORoIYvfmhlUrgXQdOVr94SJftUEFD1LtpeZHFMCB29ZUvwi3T+6Saasl1tgkhwLyektpXyt1/bLw6ixnJt0jnekRyquTA3+aHVrebiljpR5tsl3NDTtBEgcyQbqfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p4EajVfO; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-501511aa012so497081cf.0
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 08:58:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768582699; cv=none;
        d=google.com; s=arc-20240605;
        b=hGaPt9ExiryIvMc47bYBzjRpnzkfiUDbn4dhYQBwrJclhZoiYav5O2gdMCJ1yv6vMr
         GWuQXxdpJ1ednZ0YDdrcLk9pR3XiBHvpxx9bRv1dzKswmLFsWmpBb57QpHS5jJ/TI2Cj
         AgUfBsZU/GHK911f9q87bLHWutgCdgj7UqKQbjws0b6BYPLfd9Pp/jMC3/0KiSxR9ngW
         p664DOc/FmOaiYGpm9tPyE62Rq06h74vHVqS4q/OKXf+CHdV4JR5Dqzn2C7D71zT4/hJ
         z5x7qlI0/520WnTyQa+XxQFiySwgJoNQtlSHd/NTmkfXB5KEavOVp7/H87I1re/GAziS
         VDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UaTAsxPYTCPWjwQ4mQCkSgV5i6jSjH4fHwMIaU55o8I=;
        fh=eu2Or3fEIf8abxjwsDYI7/td52Eehf9ppo8j8nHY0rI=;
        b=X/Mx+iyHkxEk4jxDzOkmjK1VHsJN+3w/O2nqMGw0w+n+KqDrkUsr290VRJbPCj1EmW
         Iimh29VUpN3Gz35JDSbVbaLmy9L1rivbzydBr2cbqfNcw2YZ7cw8yYxRFFD1xBWFasDU
         W6PSgoCZPHEJM839eHkp/BnP+8VK4Owxluy5BieAhfENbZ4QCaYDLtIMGP6NBMIu4ZBE
         biqrLXe/MJyi/ivEBrntFYLyJPfYVY8MPknClHyfUfp2CXcoqDIbZe1QV9aJIs2PFUyU
         rDDTcf6XwvLk9E30fevbz9q9Z+1wecigjlDA4p5KTGt2nRb0V+c5LSHPAkNoFbnpkda+
         1ojQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768582699; x=1769187499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaTAsxPYTCPWjwQ4mQCkSgV5i6jSjH4fHwMIaU55o8I=;
        b=p4EajVfO1J615wblGHRQaYJXwV2qFKzgbJAw3PXcY9JmHIpG9cXd47c1CDfkvjhWPS
         Jd2hF5AjW5zDbGE2TBBP4sxgh5Q8e69uRGuAA3snisSoDplifP6Kayjgke0eLAy2eewG
         9NmzVDUZv0KIwn6XLRsfqUmtzjfMxPJv8txHFJ4UkI+V9gHccAi3n/kPCTuX6Ex8+M6Z
         Zk9GYKllyxRYhIrSyoK/qJlVFOcaoilCoTenPydMmtbXslujaMIaBAKyhLeMGM8dLwA1
         S1E2H3vIp5dkiSMSi7UTr69VA60JwKmZ4y1Em45Sm5ntCbt9b70RTFAfZFtyPejv8FbF
         JloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768582699; x=1769187499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UaTAsxPYTCPWjwQ4mQCkSgV5i6jSjH4fHwMIaU55o8I=;
        b=rVsUCTITovgoToJ8fLZ6kszCPZYGYr6J/8WPwaFPXcjmEWBT6zqB+gyZvELz7JgRq8
         4K+U7dpc21lTq2Tc54BqdYC8NamzwPnCEFKzUXpuVHABTPQWo3oJ7n5HcI5wjWn0PYRe
         GGNahFX5hqtlOnIYTgHPrrXT6bkTy3ZUGYOyNzx7jm7pcqDLKG7ijmx2MvUVqIBcEU67
         l5KQFYfKe6dcr7/5ye2rw5I3eat7zCqmKj8zPlBjGWM4yDlA6E4UC5KKTvZG69W0k2DZ
         WyJRJctIG/iJVEAHaMtb2TvLn9Cxxob0DATsG2tdM5mLjE2CNWI4EF9ypMS8XFYsfJRN
         1weg==
X-Forwarded-Encrypted: i=1; AJvYcCXgydnwv9HDWTzPSxJmWmf0RgSN1gxjuQaEaCUupsNM7idi4Lcx5Is4gAy4vq+lSq3iJ6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHcHmWiVFgZvV9DD+3IBVIdiKNFC8Ws4rF63qD++jy6jEIvcDq
	wW6oCOAi3BD9kF8h9qPmEcsJaAQd46pf+Fr/Fxvg/UC5P0mAeJURgHm2s8XpA0+gqoR9rfgay0q
	T1JlhFISgDFlmWcaeotJUnKsq4nuuIXhlI8YPWgm9
X-Gm-Gg: AY/fxX4+3ModfSjUfiS9oO/mmHD5Qq4jfA/XU86/SEQmSgIv6m5o79nJcRwsq1/eX7h
	Xbe8CZV2th0T1BJitlbXc2sHdASSmA18P5lAh5U+Ynh3kKq3Zhi8B/Nj8u+9EpWjJKdYT8cwBRC
	Pe7jZGMcZaYnmcUruVBFwTsoOf2z65O74/dz07ne6gVXcw4jyUBW2t/Jnu52t+kDA5vafhntCVw
	N1Au+PaX/1c9tIL3C76Nd0NVmjnwAKgCniMrZbRRt2ibLWP3xD7jQhp16O+MfW4UO3Fiw==
X-Received: by 2002:a05:622a:4c6:b0:4f1:9c3f:2845 with SMTP id
 d75a77b69052e-502a36feeefmr9677951cf.9.1768582698713; Fri, 16 Jan 2026
 08:58:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-3-98225cfb50cf@suse.cz> <CAJuCfpHowLbqn7ex1COBTZBchhWFy=C3sgD0Uo=J-nKX+NYBvA@mail.gmail.com>
 <4e73da60-b58d-40bd-86ed-a0243967017b@suse.cz>
In-Reply-To: <4e73da60-b58d-40bd-86ed-a0243967017b@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Jan 2026 08:58:07 -0800
X-Gm-Features: AZwV_QiGfwWS_a1m6Zzi_yFSpjGioLT9sSjsdK1eWkPIvYtSYBlLySU-l0-N1MQ
Message-ID: <CAJuCfpGikJpueGo1hW8ONimHOALnpftT22F7xYuL5CpnphJu+A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 03/20] mm/slab: make caches with sheaves mergeable
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 11:24=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 1/16/26 01:22, Suren Baghdasaryan wrote:
> > On Mon, Jan 12, 2026 at 3:17=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> Before enabling sheaves for all caches (with automatically determined
> >> capacity), their enablement should no longer prevent merging of caches=
.
> >> Limit this merge prevention only to caches that were created with a
> >> specific sheaf capacity, by adding the SLAB_NO_MERGE flag to them.
> >>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/slab_common.c | 13 +++++++------
> >>  1 file changed, 7 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> index 52591d9c04f3..54c17dc6d5ec 100644
> >> --- a/mm/slab_common.c
> >> +++ b/mm/slab_common.c
> >> @@ -163,9 +163,6 @@ int slab_unmergeable(struct kmem_cache *s)
> >>                 return 1;
> >>  #endif
> >>
> >> -       if (s->cpu_sheaves)
> >> -               return 1;
> >> -
> >>         /*
> >>          * We may have set a slab to be unmergeable during bootstrap.
> >>          */
> >> @@ -190,9 +187,6 @@ static struct kmem_cache *find_mergeable(unsigned =
int size, slab_flags_t flags,
> >>         if (IS_ENABLED(CONFIG_HARDENED_USERCOPY) && args->usersize)
> >>                 return NULL;
> >>
> >> -       if (args->sheaf_capacity)
> >> -               return NULL;
> >> -
> >>         flags =3D kmem_cache_flags(flags, name);
> >>
> >>         if (flags & SLAB_NEVER_MERGE)
> >> @@ -337,6 +331,13 @@ struct kmem_cache *__kmem_cache_create_args(const=
 char *name,
> >>         flags &=3D ~SLAB_DEBUG_FLAGS;
> >>  #endif
> >>
> >> +       /*
> >> +        * Caches with specific capacity are special enough. It's simp=
ler to
> >> +        * make them unmergeable.
> >> +        */
> >> +       if (args->sheaf_capacity)
> >> +               flags |=3D SLAB_NO_MERGE;
> >
> > So, this is very subtle and maybe not that important but the comment
> > for kmem_cache_args.sheaf_capacity claims "When slub_debug is enabled
> > for the cache, the sheaf_capacity argument is ignored.". With this
> > change this argument is not completely ignored anymore... It sets
> > SLAB_NO_MERGE even if slub_debug is enabled, doesn't it?
>
> True, but the various debug flags set by slub_debug also prevent merging =
so
> it doesn't change the outcome.

Yeah, I thought that would not matter much but wanted to make sure.

After finishing the review I'll have to remember to verify if that
comment on slub_debug/sheaf interplay stays true even after
args->sheaf_capacity becomes the min sheaf capacity.

>
> >> +
> >>         mutex_lock(&slab_mutex);
> >>
> >>         err =3D kmem_cache_sanity_check(name, object_size);
> >>
> >> --
> >> 2.52.0
> >>
>

