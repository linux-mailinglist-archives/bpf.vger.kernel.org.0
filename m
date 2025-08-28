Return-Path: <bpf+bounces-66803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07489B39476
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52717A838A
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F772C08A8;
	Thu, 28 Aug 2025 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXbkjrfL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B1923D7D3;
	Thu, 28 Aug 2025 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364346; cv=none; b=qoHPpSY1dAMK2dQl+WruoWRlowNu6dcAEbsKWbMBRugCcan7j1pm0YtpMl4d3sEbnt7J5YTmfJCPyIxKqO1DwVPO66BikAohRif0UleOIGxVwx/J4xX7zDAHDsFkgtsfivoOHBKY/P+audtUTSF0/l1J1lAlD0vShBB+OopWLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364346; c=relaxed/simple;
	bh=h+5QlIME0GXytQ7qpF5OiiV8EqngJ8LXAaGd30LRJtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xe6wv9KOT1OGioIfOkJQ+Li8/ecZZ/yO4xvpBW6aYBRRFBp6jG1Ui2ZAGim9N2FOlQza1bATTn41q953R3Ro5+bkkHc6ndJ/NiSvj6NVLMfu1NppJraJ3vstwcaESVbUHh0QjfZ2x8Mg7Te6r4c2NpQ/K+XfTcAi/Qkatz5+EzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXbkjrfL; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b10993301fso8763551cf.0;
        Wed, 27 Aug 2025 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756364344; x=1756969144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imRtYecfg+etFNKaWp3et/EHqOd3Dvqo3ESB36BTlR4=;
        b=eXbkjrfLDaAjErnLFj6r8aPy2f61coZK40M0Tq1ob71tMJEne6vz3KQVSeO+aHWZRU
         QruOK31xYNLiehP/mNiH0Cor8QuQB9mDIkCedJioFVkhLL7XjIA46HB4CL3BM5m+Zxqb
         0Naafhky0+7DtuwxNcjMtmlGHnbPuPfvZ8rx/RUrhKkHIq9dwWumoa1s/YoRtpLRDZgC
         7YxIYaNh3T6nFAX62jCWLk0W7UwW8uiiWefP3RILTdzgFUEjdxUF5TFmYHaZoY7/2704
         ztzIzw1Wwq0/l5PmM9WyZFCx/cilQeZQpWwuufl0OvQk49ZfFSuOV142V8hRyKu41nQx
         Fxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756364344; x=1756969144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imRtYecfg+etFNKaWp3et/EHqOd3Dvqo3ESB36BTlR4=;
        b=Ae3WEJDnOJ1UrVnw5sCHAJd6wyTknE1ZExZdtUy1lJH7JRvJOLFvC13vvVx3bbrytt
         Qwo9cdCHRG9FQP4VW4aQzpWvEVFzyPQ0XmH2Bi+DLVprz9AKdYlo7Ke/UKIZQ9bMZ9Nd
         ABKmVqmXOKIilz4HiUP/prw6BPe+HSy/gcE5o2W1SrX/4vmghCiEv3GsY5pdnkUPv+CA
         A9bkm4++3WteAtc/eZ9SjAjRA9Oh2KsJJwfjNIje4SwmaNCfUKHH5KDcC6fxKJn+GQXH
         ieax7o/zTX1SX8n3/lHolyPH1prBDOhE+3U5krYA5SGooKG/NlmcXvr7Itqv77OAhhHH
         Jaew==
X-Forwarded-Encrypted: i=1; AJvYcCVaOthyI9VDPNckAaxDrEUwoHC5J1Bdd0ds3m9NiA+rp4vfMcJt9vcdrQQ6JBPOIOQ6aX3d+WJIbTgF@vger.kernel.org, AJvYcCW2Wo7HSMKGUfYrG+hPv4FHPCT1bDLCfBeeHkUAKx6zPy6T3/yuY08K1gvaKJy71IFHQaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgcnT1RonTMxgImKRt2T9st3vQo6zyzQp25SmMQ/zgPSRgzJFb
	TtIRp2ahGv2wlKDEfZBO9hc5ht/V2YWViS7Gr6rL8IMfRs9S+soSPTD0o9dyxqPczMg1qVxodJ+
	NBtD5BKjSz2xK1aWL+NMOTl4ZlObDx70=
X-Gm-Gg: ASbGnctSBEBha3Xk72UxzMu1ofIxB+CBG0m38H+CMxI9J5FkwOLCLSYIkNOb4+LrIgk
	hZFuvgPWwE45H6cBEC4vgWRYGPVAmRTMRoW3XvglXgfDTTy83BEK3KW8eUknCmzDRtRVSw3JMru
	ywdjRxJG4dvL27DwXI/GFtufkQeKsDtye/sxmKJaUB5HBxS53P/dlEPIbTqzbJeUOqSeIxHw0Eq
	7E4GRFlCQQgx3DTzszhQ9VcjEJyd9iUGraQnliVpgUWDRoP3Q==
X-Google-Smtp-Source: AGHT+IGMHvpvoVZa9mXmBBeocL1rpGhAuvRVNAEm2pjo8nSBLdwTn61/uotyQhl6uDY9bSKpy9uNA61YHeQ2elpq2ks=
X-Received: by 2002:ac8:5d48:0:b0:4af:322:346a with SMTP id
 d75a77b69052e-4b2aaa7df5cmr235111751cf.37.1756364344187; Wed, 27 Aug 2025
 23:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-3-laoar.shao@gmail.com>
 <fxjgxvoq3z4utlwb7asmt6wfjfl5t2nvfnghhmwplhqerv22yg@3i4gdavsyirq>
In-Reply-To: <fxjgxvoq3z4utlwb7asmt6wfjfl5t2nvfnghhmwplhqerv22yg@3i4gdavsyirq>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 28 Aug 2025 14:58:28 +0800
X-Gm-Features: Ac12FXxzOOTe1natEd0mMCAsPZpFJWP7A30MXtoADcSt0CwP8hYi3Z3hSqrAKo0
Message-ID: <CALOAHbDmtyH54sxyxhRBAd+f1m-Yw6WrBvdk+Qom2SMLYqCAYA@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 02/10] mm: thp: add a new kfunc bpf_mm_get_mem_cgroup()
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:46=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Aug 26, 2025 at 03:19:40PM +0800, Yafang Shao wrote:
> > We will utilize this new kfunc bpf_mm_get_mem_cgroup() to retrieve the
> > associated mem_cgroup from the given @mm. The obtained mem_cgroup must
> > be released by calling bpf_put_mem_cgroup() as a paired operation.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  mm/bpf_thp.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 50 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> > index fbff3b1bb988..b757e8f425fd 100644
> > --- a/mm/bpf_thp.c
> > +++ b/mm/bpf_thp.c
> > @@ -175,10 +175,59 @@ static struct bpf_struct_ops bpf_bpf_thp_ops =3D =
{
> >       .name =3D "bpf_thp_ops",
> >  };
> >
> > +__bpf_kfunc_start_defs();
> > +
> > +/**
> > + * bpf_mm_get_mem_cgroup - Get the memory cgroup associated with a mm_=
struct.
> > + * @mm: The mm_struct to query
> > + *
> > + * The obtained mem_cgroup must be released by calling bpf_put_mem_cgr=
oup().
> > + *
> > + * Return: The associated mem_cgroup on success, or NULL on failure. N=
ote that
> > + * this function depends on CONFIG_MEMCG being enabled - it will alway=
s return
> > + * NULL if CONFIG_MEMCG is not configured.
> > + */
> > +__bpf_kfunc struct mem_cgroup *bpf_mm_get_mem_cgroup(struct mm_struct =
*mm)
> > +{
> > +     return get_mem_cgroup_from_mm(mm);
> > +}
> > +
> > +/**
> > + * bpf_put_mem_cgroup - Release a memory cgroup obtained from bpf_mm_g=
et_mem_cgroup()
> > + * @memcg: The memory cgroup to release
> > + */
> > +__bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
> > +{
> > +#ifdef CONFIG_MEMCG
> > +     if (!memcg)
> > +             return;
> > +     css_put(&memcg->css);
> > +#endif
>
> Just use mem_cgroup_put() here.

i will change it and thanks for the clarification.

--=20
Regards
Yafang

