Return-Path: <bpf+bounces-46296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E21D9E77B4
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8AC1887C6B
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DED21F4E33;
	Fri,  6 Dec 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzDukZsC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A822068F;
	Fri,  6 Dec 2024 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733507453; cv=none; b=EECBOPC+g4JC0SEZjD2FdRxxvP9lNFOPuGhCSp5BuOPxsFXR51fjDR2VXJ23nAPsF1jbelE9H61hw9uBfivJ+hgArMGmw+xXlKZWACRnROBA1L07+x3e4ToRnI6IItNuZJqZTQrimwzv6pq8W2cE+Ey4t5spYwPXgIPYhJE2t/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733507453; c=relaxed/simple;
	bh=sxQpi/Re+o+nVehAG5Ly1Pzk9TSKI91Uafdr+ryfMM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqxGBV3xkTp57iH2K8t+Q7h6vMDEWpuLOW3l9Ubnl1f2PbFbiJGdbgt39dNPcMFjWqaC8ceV2lgyWDRJ+1NAyAtbhowoU0fxyM9pBvMz9NbhWnw0iHj9HmxJEDGSsg+2/2LkfS+22l/eUjzZ/lK7T+af2Plk6ipLOGfVQWCRdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzDukZsC; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso2783336a12.1;
        Fri, 06 Dec 2024 09:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733507452; x=1734112252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1pwg93Dh2Ekw2uQWZ/BkEp+u1+s0Tq7PSxXVKH5GFo=;
        b=jzDukZsCfc6fzSid4mtzUusRPb51nUQU0nrDa5n1OcSxi7jjwhAPXOm7M16nGvterR
         dc2xsm4tRnxti0FICkPe+hca9/WjlcsdfTA+EZOXtQob+/LAIEOagX3h7F7NMWakG/Js
         saYwumYD0GjTCXxu8jx9d1zNmEIj7ogQa022VZ4DsTzr1yIBuLEI0quszDqg4vAfUa5O
         YmMCocLf1KtyW5f3SJp6KBbbLmA9g9SDc2RT2AOBUXAOi7CkXZmB/Kw5VyeTFFAnCjo/
         P7R3rYrKyU6qCJcqUpjGJiW39cIZaDb8c/WXUJ8TX+IdpKvX7qkrfssRogL3eJGwPCs1
         UD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733507452; x=1734112252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1pwg93Dh2Ekw2uQWZ/BkEp+u1+s0Tq7PSxXVKH5GFo=;
        b=g/34DPGgh/gnZ8/1KEWmBkta+3IEDoOnreZayunVcZIC45DPFgJPr6mpstjebsHz/X
         o3B7XRKvPGaKyTCkjR3lUVKKZXiBh0fQG2UzDLul5c2iW7dnNzZ+wZvTIvPeelZR7m3f
         Kt6wj88psNWuNaVL/KP2bFcJj+McXYSgVudavL5umD/jQFnhRKSWdeMyLmbaG+7wXYKy
         WM+ZJaYt69XL6hhLcsbvbrmKlRA2KuWsEnLC6yUZOcTE5QhBFNpnxypzcL4QRaGHSzj7
         ARAIVFq0HZAYiZTfidR0kJPOfYH0N4xjKZ8wKdIRkCUuLZtvCm7sJGNVq2Ratbc7+3Cd
         YKaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb+8Q9oe259A/kM8dpG2aYRsPnD4Xa8y9E6Z7rhULN6tlFKy5Caagztqhcr9sRq31rzb/0CqlMBVv1POp1xiOZMz3g@vger.kernel.org, AJvYcCVoieXXCEfMiVv5A8Fd+5WPzI3jepJhxEwWtuV99+eNnwwf9qxQmtA/koLpbkRILcn2SjwF3KT+pS7FT+hp@vger.kernel.org, AJvYcCXMnfv1VSCKPojCYXBmh/nO3JpOKwnJKPErKgLhYUQpDG2KB1s/Yk6Lx0nzCQuDeVKSxMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgrYc9hqqs4/ze73kWkzHEMMpYXo9IIvAg+E8MSc7xLOfe6KWG
	1dhqLsamvAzgUM6udLlzGgfOwMA/tb4hpWPPtb3rOkUln6k1fmXSJ/uM3C1wChX3R4E+0wuRb4R
	ER9WyPv37VlrgBLOHbc37mDRkcmM=
X-Gm-Gg: ASbGncuIxtRcD8hcOXJuqKtOHTMNQedBaW2pMR+aHfdZUCXedVsLuqmLYCdRhr3PoWR
	SEQP+ZDwfcMHmaSJZvzDnrKKL7+Q+yXMCNMOgU3tRNY03iWI=
X-Google-Smtp-Source: AGHT+IEQ2CJYqmyLFQiiRLnsPVzwFmjTsExzZT6jDDhMyx3aUJzvpb7k00ZncHKoximJN2TBdSUjJlqrwM/t51JbWV0=
X-Received: by 2002:a17:90b:1890:b0:2ea:61c4:a443 with SMTP id
 98e67ed59e1d1-2ef41bbac79mr12705184a91.4.1733507451799; Fri, 06 Dec 2024
 09:50:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206002417.3295533-1-andrii@kernel.org> <20241206002417.3295533-2-andrii@kernel.org>
 <Z1MFHg3fd_BMQtve@krava>
In-Reply-To: <Z1MFHg3fd_BMQtve@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Dec 2024 09:50:39 -0800
Message-ID: <CAEf4Bzad08Xy3RhcKq=vk_HaZwHXnCxRHp-hC60EY5B7iWkgDg@mail.gmail.com>
Subject: Re: [PATCH perf/core 1/4] uprobes: simplify session consumer tracking
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@kernel.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liaochang1@huawei.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 6:07=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Thu, Dec 05, 2024 at 04:24:14PM -0800, Andrii Nakryiko wrote:
>
> SNIP
>
> >  static struct return_instance *alloc_return_instance(void)
> >  {
> >       struct return_instance *ri;
> >
> > -     ri =3D kzalloc(ri_size(DEF_CNT), GFP_KERNEL);
> > +     ri =3D kzalloc(sizeof(*ri), GFP_KERNEL);
> >       if (!ri)
> >               return ZERO_SIZE_PTR;
> >
> > -     ri->consumers_cnt =3D DEF_CNT;
> >       return ri;
> >  }
> >
> >  static struct return_instance *dup_return_instance(struct return_insta=
nce *old)
> >  {
> > -     size_t size =3D ri_size(old->consumers_cnt);
> > +     struct return_instance *ri;
> > +
> > +     ri =3D kmemdup(old, sizeof(*ri), GFP_KERNEL);
>
> missing ri =3D=3D NULL check
>

Doh, of course, sorry, my stupid mistake. I'll send a follow up fix.

> jirka
>
> > +
> > +     if (unlikely(old->cons_cnt > 1)) {
> > +             ri->extra_consumers =3D kmemdup(old->extra_consumers,
> > +                                           sizeof(ri->extra_consumers[=
0]) * (old->cons_cnt - 1),
> > +                                           GFP_KERNEL);
> > +             if (!ri->extra_consumers) {
> > +                     kfree(ri);
> > +                     return NULL;
> > +             }
> > +     }
> >
> > -     return kmemdup(old, size, GFP_KERNEL);
> > +     return ri;
> >  }
> >
> >  static int dup_utask(struct task_struct *t, struct uprobe_task *o_utas=
k)
> > @@ -2369,25 +2372,28 @@ static struct uprobe *find_active_uprobe_rcu(un=
signed long bp_vaddr, int *is_swb
> >       return uprobe;
> >  }
> >
> > -static struct return_instance*
>
> SNIP

