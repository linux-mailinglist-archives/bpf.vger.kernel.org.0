Return-Path: <bpf+bounces-79106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7B4D27556
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1DF5305087D
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BBA3D3CE8;
	Thu, 15 Jan 2026 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q98W8KbV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4843BF2F3
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768500024; cv=none; b=DMR69BOCKOXQ1yeJU8GM66znohC6VKkJBNQ56wa99lyvgVyxYAdL25hw6hKPbwa4Vfpe2kLo6VopY/eKckAXiXoxfuV+Z317zO+UgDa5AOsZfCpHLoVRp9OkC0qUBO5RkXWkxkdEJD7+9BPdFhvZC4dM68OZfV43QXZi+JtUOgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768500024; c=relaxed/simple;
	bh=vLddMxM0W6026RbjbLsRAyK48T0JMu6b1ru+OYq9x+Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laeCONNDb27gyssz6caTaq03hNShmlDy21ifGsr5GT+uXPG+Zzrew+sUDTtV03MBHXUPZZQgkYzjBzjkRBbp3+/G3c8WMsvGMQB1pGS1h401AE5jS90Ke9FqQ3JHYaG4AxoEOziXOorgEU6gWl/RFdp2HM0C0q1KtVaD7LSR9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q98W8KbV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so711126f8f.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768500021; x=1769104821; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8THmu0qXU1sZub569pYlCPkbhQYfiv8r3J7zMWrHXdE=;
        b=Q98W8KbVD0HNwCgzTK/NzQjs7GwQ8LlzVXscW6qR5zM3u/JEKK49xq2wVfvSrBM5hz
         wrjQ3Keo1Dkesj1NSgyflDA93bKlJr1/XlBUiPIYOlMBXdnIRDiHqWICuAE0eTOuflM7
         wakFJkdpJGUu9AtDdJfWUEKSYcSNyOPJd8zPPySwPWfsYRXtEMmm+JxX6By/DYizyERV
         QGlnQyAI7p8p8yn/NPrfLhnH+5GtykFM+nEGpqjt30Hxo9Xbwh/0IP0u0Q37CiCgg0Gn
         sbn95rjNZcm2YbXypPimgYoZa6PLazYTKFIbtnBKPf4RM4QbcCNJWAQWAhkdb73r28Ua
         HGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768500021; x=1769104821;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8THmu0qXU1sZub569pYlCPkbhQYfiv8r3J7zMWrHXdE=;
        b=dBdycNDm1uz68QzPnDtVp6TfIgSIulR8USgJp2mHTccHk+wBxGOSgmHx9ihBUrPLVl
         eKgH58jtpMUGwv+TnDQdD4uoUmhv16cdC+Gg8WP7I3Ikc1Edx3k2SKCyol+4LoKmkJwS
         F4H4B3TTqAdZYU92+4hiJfNgW+4xG0sBPclSMiNlQR0qG60rL01FkZaJlapGdg5E/ZzS
         CdsjLT2OKOltNRqlET/hUrWB+QB1jyH1OYYJTvHbIpwuDx3ngUrG4hRNjUp3pMYl7dA7
         p8WYaF+2NsE4YA4gVa3HdnmnL5co+T5p56JvevmPaQZ0AIKAoHjeARwa49JGWwr+bLwy
         olbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKq1rSpMakMyWzDNWIBpavkM9+g8WoZ96h7bLJS3DryljQzERocwOI3M3o+ZFJxPZy2QY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8um05Juv3i//WyJRhR35SfYkfT3EtyBZKSg/MBFjQ7bruO5ex
	UtCI6GXkyFa3PFqJqwQBdXs3R7/JjUrYfOFXIsWDUwmmLcuJw4Q1oEg1
X-Gm-Gg: AY/fxX78O+QoBcrm7q95z95Jyysu4pDqXcXy6HuU2OajU+HwR9TmxAyl42dAdd7404l
	XvWckukMCSfBBiK4csZHLJqqhDUP0uuNVIZFxwdgcK8iC+iMd/A2Q+b/oP2Ib3QInmMKvWzEfnT
	z4zNas9z7bIuws6PKvuGeKFiguRvpaCRCcogLuJNl+aoHmIu+6zN14O1VdGq+/v7AQMSAHnPS46
	uqcBuuc9l97nofk7mGthw+6im7FPURo6/HXZMAx/FeKv+iOl1/MI9moPOLUC+yyTZU1XdYt+gTd
	t5EuwulzOqRWNv4xO2PZqHTDvB7iVApG5exknn3Vc9LN9j0MwMocdVVdna4ZD4JKH1cBo2AOxiP
	wxy+aD+CK0MrqkweRa81KAjHQTFW8+hvw5/qRbQYdNdVwl3QSu+SrhRSe/zSSFUR4SXRW7Ev4ii
	A=
X-Received: by 2002:a05:6000:26d1:b0:431:2cb:d335 with SMTP id ffacd0b85a97d-4356a053852mr135704f8f.34.1768500020783;
        Thu, 15 Jan 2026 10:00:20 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e664sm280337f8f.30.2026.01.15.10.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:00:20 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 15 Jan 2026 19:00:17 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Leon Hwang <leon.hwang@linux.dev>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 0/4] bpf: tailcall: Eliminate max_entries and
 bpf_func access at runtime
Message-ID: <aWkrMckumhQErMmV@krava>
References: <20260102150032.53106-1-leon.hwang@linux.dev>
 <CAADnVQJugf_t37MJbmvhrgPXmC700kJ25Q2NVGkDBc7dZdMTEQ@mail.gmail.com>
 <aWd9z8GVYO12YsaH@krava>
 <CAADnVQLxo1uPbutGNKrv=f=bSVkzxOfSof0ea8n7VvqsaU+S3w@mail.gmail.com>
 <aWgD3zH7vsiBdIcr@krava>
 <CAADnVQLHVogD1mjMCsHcJOayuZW4OwadEN0g9wu=6d97uRSWqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLHVogD1mjMCsHcJOayuZW4OwadEN0g9wu=6d97uRSWqQ@mail.gmail.com>

On Wed, Jan 14, 2026 at 01:56:11PM -0800, Alexei Starovoitov wrote:
> On Wed, Jan 14, 2026 at 1:00 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > >
> > > > fyi I briefly discussed that with Andrii indicating that it might not
> > > > be worth the effort at this stage.
> > >
> > > depending on complexity of course.
> >
> > for my tests I just had to allow BPF_MAP_TYPE_PROG_ARRAY map
> > for sleepable programs
> >
> > jirka
> >
> >
> > ---
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index faa1ecc1fe9d..1f6fc74c7ea1 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20969,6 +20969,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
> >                 case BPF_MAP_TYPE_STACK:
> >                 case BPF_MAP_TYPE_ARENA:
> >                 case BPF_MAP_TYPE_INSN_ARRAY:
> > +               case BPF_MAP_TYPE_PROG_ARRAY:
> >                         break;
> >                 default:
> >                         verbose(env,
> 
> Think it through, add selftests, ship it.
> On the surface the easy part is to make
> __bpf_prog_map_compatible() reject sleepable/non-sleepable combo.
> Maybe there are other things.

ok, thanks

jirka

