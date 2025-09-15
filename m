Return-Path: <bpf+bounces-68424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E85BB585BC
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9AF2A3989
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4592877E9;
	Mon, 15 Sep 2025 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yJYFaFle"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6538F2747B
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967062; cv=none; b=oJ2tt+gykbXoO5d0IUJ5NunuYiJIQJoE+x9imxrn6cvvzzGLszKh0GJLadj2jkCY5oc4ktEAkpZt9C1hk3PUnt0Rhj3ZV3tBqnB61MIkiN8U/fP+r8WCjj4D6cCy8KMC8Z6a1j4u2/7v3eTuy2ucl3nK7TvmNClFh+bw+pPuB5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967062; c=relaxed/simple;
	bh=C7yADzXGocb/qE7uG5osiTyGOa5Q91Vr/vq8cRHwFCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lw31DZSEC/juWx0r6o6oSqrY6p4sm81tRUn+Sl/tpapSnDscEQq31WbzUhmhMuSKwStEdpC0mBG3Usb+Y8grlcQM50Y0OocbTANYNDAbXDR055mb+Fk9uUOhEpP4lwOLyPQnnV+ZnbDvtG9h5lTxYoak1+FSgaWGO9boMttPsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yJYFaFle; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b78657a35aso3531cf.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757967059; x=1758571859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7yADzXGocb/qE7uG5osiTyGOa5Q91Vr/vq8cRHwFCM=;
        b=yJYFaFledcRKvFuhi6PFJHKg5JNeoDCQYiNF3W0yVa3TDd2RU70myU6kmtxX9fZrE1
         KPAMX77igCyRNGlSa2s3PAuOT5kmHUVe8JRyVAUESsSV4SnKTQQfl66XUYy4vBbQdZcC
         /vB3ax6rdKbUtTYPXxyILQPuVIvAK3r/NmOP+CrD4DLJcNPL2I+SBV4ulO5TNpggMDLu
         mDznUrL6vuCiHX8yaSUPEvVia4jqHeDlXBcTR62tFsFAen88yJBypXGmDJuZlnRk5n9S
         nX8roixJJvC9NmVVAjmmOJUnJ7Wrciou2f/7xhuazLajMSzpruhAXlp9h1EYa2XbBqJh
         itpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967059; x=1758571859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7yADzXGocb/qE7uG5osiTyGOa5Q91Vr/vq8cRHwFCM=;
        b=gghe2aKO+aEZBjSHI3imsgaBBUJJ9O7hbA/AGavMty4FYYowXSWTpeqIPNWgNds/YH
         urUkGwQZvHkMh4EB7tMgRoGKoO1OzoD7N2lluvAPxCw61lDyqMebhcWk3K802GZMN0Ui
         vYRJubliyeHkB9sdBQXUofPJg2co3nbrIRdw3nwXRPikeVLLFtLCBj89LhLUJ+T86imB
         /v5q7glv/L5XYhj8jKo2SIwv6IR/JTDc0TguMOZk6BKkS6dZMBj3PVMGj+JeZPnpWCV8
         OuiFtnG+baCoI3dDg1scef2hkHALiHNocqIMNfG6+7LvVveXoQz4/vVOSX5E2ozBLW08
         xJTA==
X-Forwarded-Encrypted: i=1; AJvYcCUk/d5EWvChBMNE/cv8QaJXdJdooR4FoKilJSMUscRvLio8F1Ut89IS6HrxdTWEIRbI6PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGujhi/ftECB9Q5gFRko5xLAMvtQg8dR/wB3bSyKUgxC/45Kmz
	2k5fa87ivjAqO3uouZa0gKvKnH6ZPOUBpb6rgsoe082wV5cDXluEKx/2q/zzKP4SfQ3PtX3M7kT
	6D4oMIaXZ7upFazKTXx6mSRv1eDyL61LWtxH2Z/38
X-Gm-Gg: ASbGnctmQ8CDyJ19fpRKbXfsjI0oj86Wo+qo/N2ZP5VSZgb+2JzQ7tJGaaCPmEtKDo1
	Y4sRew/mBZanFrrtKCs9oByLYLHuCg28rK9YerBaahYgjwAUbjJK1HE4JYRYL+v6ljQ0zUwcn3Y
	f6HhvThXBuwpnUs3x5BnBan6SQuKCL/7xDzuVpi5MHgifhakM+51HsFz4ZGTeR1kMkjXHRM6ydW
	SCh6pVj0ZHY7PhuYdV/Clk=
X-Google-Smtp-Source: AGHT+IH2ABfXb4DwKPnac3WHtKB/buhhVf/EdUWNCc4f+qA019sh73f6G3fzY2MHaUsZNUbwzHEwRuwgYnb3fDthRSo=
X-Received: by 2002:ac8:5955:0:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-4b7b2d829a0mr192231cf.7.1757967058696; Mon, 15 Sep 2025
 13:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909010007.1660-6-alexei.starovoitov@gmail.com>
 <jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5>
 <CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE8pG0K1uXA@mail.gmail.com>
 <CAADnVQJu-mU-Px0FvHqZdTTP+x8ROTXaqHKSXdeS7Gc4LV9zsQ@mail.gmail.com>
 <shfysi62hb5g7lo44mw4htwxdsdljcp3usu2wvsjpd2a57vvid@tuhj63dixxpn>
 <CAADnVQ+eD7p4i0B9Q2T-OS_n=AqcrrvYZGY57QOOqKEof6SkDQ@mail.gmail.com>
 <lv2tkehyh4pihbczb7ghvbkkl4l75ksdx2xjtxf2r7lgzam76h@ekkrlady2et3>
 <CAADnVQLX_mi9WLygRxwp5PtBFG7L_sqm9sL93ejENWqVO3ar7g@mail.gmail.com>
 <e7nh3cxyhmlxds4b2ko36gnxbdfclcxu3eae5irvrd2m6qzqoj@gor7vopfe47z>
 <CAADnVQJuAo5K417ZZ77AA1LM5uZr5O2v1dRrEEue-v39zGVyVw@mail.gmail.com>
 <rfwbbfu4364xwgrjs7ygucm6ch5g7xvdsdhxi52mfeuew3stgi@tfzlxg3kek3x>
 <CAJuCfpHJEUypV2HWRHqE598kr-1Nz_DokMz_UgrUnq8YkFcb9w@mail.gmail.com>
 <CAADnVQJQo6+AwJ_LxARVu37J-5T-7tyn1kA5hMVDGDfEyjF6mQ@mail.gmail.com>
 <e166705a-e838-4c8f-a8cf-64913e120caa@suse.cz> <CAJuCfpGR2tHhUu=p4X2YKPNot4TJbhuFPRiT8BgOHvtcw=j-Ug@mail.gmail.com>
 <75bc0c27-3d08-484d-9d22-59bc70f7ee1d@suse.cz> <CAJuCfpHJyGrH91yErLBMPbFBu9dS3Nr_ij2FJdQ5cUnYxAu9Tw@mail.gmail.com>
In-Reply-To: <CAJuCfpHJyGrH91yErLBMPbFBu9dS3Nr_ij2FJdQ5cUnYxAu9Tw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 15 Sep 2025 13:10:47 -0700
X-Gm-Features: AS18NWCSLNjt4OO-yaU88tQeA8HQXsepTIm4TtQqdSzJ2SipSga5dU21EKuuu4A
Message-ID: <CAJuCfpE20N31AFdTboQX8GOrD_Pn_=oNB_UtGsFFKBotEb2-1A@mail.gmail.com>
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 8:25=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Sep 15, 2025 at 8:11=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 9/15/25 17:06, Suren Baghdasaryan wrote:
> > > On Mon, Sep 15, 2025 at 12:51=E2=80=AFAM Vlastimil Babka <vbabka@suse=
.cz> wrote:
> > >>
> > >>
> > >> Shakeel or Suren, will you sent the fix, including Fixes: ? I can pu=
t in
> > >> ahead of this series with cc stable in slab/for-next and it shouldn'=
t affect
> > >> the series.
> > >
> > > I will post it today. I was planning to include it as a resping of th=
e
> > > fixup patchset [1] but if you prefer it separately I can do that too.
> > > Please let me know your preference.
> >
> > I think it will be better for patches touching slab (only) to be separa=
te,
> > to avoid conflict potential. [1] seems mm tree material
> >
> > > Another fixup patch I'll be adding is the removal of the `if
> > > (new_slab)` condition for doing mark_failed_objexts_alloc() inside
> > > alloc_slab_obj_exts() [2].
> >
> > Ack, then it's 2 patches for slab :)
>
> Ack. Will post after our meeting today.

Posted at https://lore.kernel.org/all/20250915200918.3855580-1-surenb@googl=
e.com/

>
> >
> > Thanks,
> > Vlastimil
> >
> > > [1] https://lore.kernel.org/all/20250909233409.1013367-1-surenb@googl=
e.com/
> > > [2] https://elixir.bootlin.com/linux/v6.16.5/source/mm/slub.c#L1996
> >

