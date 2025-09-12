Return-Path: <bpf+bounces-68267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96228B55853
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 23:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579A2AA705F
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 21:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC601259CBB;
	Fri, 12 Sep 2025 21:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAVMHmgG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD0222256B
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712281; cv=none; b=BqkitUNvu6u1wAT6/+oSnQX+tuecphPSMFoOEtGlScjygXtBVvN5yurc7Hlu0oJbOFHFBiyqyfGOU3jNco2FkqmqDsA3OC4GUbltCz0GZQbni8CQHdoDW7c9butwxPiK3AuBfvnpXDEuvBNeJ7Vj3cNSSuK+8yNbc7MbJyx9puY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712281; c=relaxed/simple;
	bh=WWm9YsYf2w0GyNuqpvEAceO2ybRB76x2x0lUOA0o3S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKJvuOzm2kZNFoWnhkLmwj7C61/F2JzSwesXJdCzttyOGlz3cOxD3S4d0Tv1y1iorst75AWgeWPcJau/F7FojbAx5SCZyuXLkYlt7/3IPPsLaoRvHvC5vDjkSwqxVlFZVAeeCfoqI07hRojoW6CkRSMbiPt3ktYaKtzr/WcIGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAVMHmgG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3d19699240dso1954304f8f.1
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757712278; x=1758317078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWm9YsYf2w0GyNuqpvEAceO2ybRB76x2x0lUOA0o3S0=;
        b=kAVMHmgGuNZetN8qFIYdHjL4bpazu8kDn2FVPG7iJZuzCYxBMg4HF9Inff/Bib1saX
         bnFc4WvyHXpXC72INRtsIbLAmR4O3pLyRr8HpPSkSXiXhsffcrYvJOY/OEZ38aYK0ZiG
         ExSI/19NJdbQv4DEQXszbJfjqvZjB7RGiGsi4Lq+/AgtInhvYxv8RNwJAkq8Y14ODo2O
         5jeIrOH+iUgdywJkv2L/XpuEGNSLm2DuKptGbYT1n8JSCG+74S5NmcDqN9svKYVJ3NTh
         beYvH9NNrPEYtMN+YXgNK7X3qc+kO62oPoz9ILhF34CAQkoL8WwYef5OmLOKSbk1FI8Q
         ahMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757712278; x=1758317078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWm9YsYf2w0GyNuqpvEAceO2ybRB76x2x0lUOA0o3S0=;
        b=OkMGh25Id1etF+T1E8fhFlkLOjc4jBGoKm/nLsDtq37cZKQVXI/g/BXIv1m9B97uIV
         bjIEV/4PEW3zjYqb/RwhlF3jMorZe2pUhOr+OAgXXiro06l4W+WIvNLlIvUinJJdSsls
         NhoiGFnc4NsxH/Y7Q+dysWcuqCuu8DVQiWjgUynwPGjgZld3L3xLA3ieg2Eg5K5vPD21
         BHfD4t7QWChd9I1VCGd61TY2XWDg5C8EEOoJ8zySFDu9/7vf5QSevXrv9tT/PH+NURcV
         s7Sh7auCx1BoKb8q/WcS5sl2lQVme68Ki3048FmFq4IGErVvjJvx+gKem+VbJhBsgWBW
         rAVA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9uobvWQoWdcIgXtvl4CLruK3jfW/hidK0oKz1ITBAedQX9bLMY0dp5I2Fp/JvH0hvJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq92KMWpUmtWK3asNGSCu2Bdzq2PNCn6SaCmhFKda3MYLGm0MK
	eErTNoKDmB/P4K9fBcYfvpCpmS1Pl2NNxVThzgET/QNCbvv1wVMsZ+1r+E4rLL/94I1TqEudma/
	2TlxPeANC+sWVsm51JJIHOxUhZHBfANY=
X-Gm-Gg: ASbGnctOyo5Jfgrd78v8o9BxH/x6YpM3el24ran3j1K0OitObDTfQPPxFwoS19mEY8V
	w7vKKI+uWb9iiNT8ZOqF+v+qvBhYOZ8kZxsI1V+SoNoyWM6UTun3yiquClBtpgwfuL7EYr4PcJm
	2VyZh7mmz6ek7r7rUciwkSAarnUdW89mo6S2Gkj2tQG3dhbkKlkhmH+/D3U9davHHx8flpX09FC
	H/pvz5ILf3+FvGL89I1YFR+Jzkr0edeeFUxo3YQoa+snYZDvhmYzRLI/g==
X-Google-Smtp-Source: AGHT+IGCZsREvR1VZ+XsR7ha+tSOnACMJcqyHTG9GdyppjH3mGDryHaDWAaGL7FjSTusjsI3mMut2nsh+qgHgEwvsTk=
X-Received: by 2002:a05:6000:2209:b0:3e7:428f:d33 with SMTP id
 ffacd0b85a97d-3e7659f371bmr4280887f8f.16.1757712277929; Fri, 12 Sep 2025
 14:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-6-alexei.starovoitov@gmail.com> <jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5>
 <CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE8pG0K1uXA@mail.gmail.com>
In-Reply-To: <CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE8pG0K1uXA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Sep 2025 14:24:26 -0700
X-Gm-Features: AS18NWBQoKfEqcXxDiBi2y0eZcdZwwfvRq5T3SFVD5TOSJQlB_ujy9rk-5-4j_w
Message-ID: <CAADnVQJu-mU-Px0FvHqZdTTP+x8ROTXaqHKSXdeS7Gc4LV9zsQ@mail.gmail.com>
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
To: Suren Baghdasaryan <surenb@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 2:03=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Sep 12, 2025 at 12:27=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> >
> > +Suren, Roman
> >
> > On Mon, Sep 08, 2025 at 06:00:06PM -0700, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Since the combination of valid upper bits in slab->obj_exts with
> > > OBJEXTS_ALLOC_FAIL bit can never happen,
> > > use OBJEXTS_ALLOC_FAIL =3D=3D (1ull << 0) as a magic sentinel
> > > instead of (1ull << 2) to free up bit 2.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >
> > Are we low on bits that we need to do this or is this good to have
> > optimization but not required?
>
> That's a good question. After this change MEMCG_DATA_OBJEXTS and
> OBJEXTS_ALLOC_FAIL will have the same value and they are used with the
> same field (page->memcg_data and slab->obj_exts are aliases). Even if
> page_memcg_data_flags can never be used for slab pages I think
> overlapping these bits is not a good idea and creates additional
> risks. Unless there is a good reason to do this I would advise against
> it.

Completely disagree. You both missed the long discussion
during v4. The other alternative was to increase alignment
and waste memory. Saving the bit is obviously cleaner.
The next patch is using the saved bit.

