Return-Path: <bpf+bounces-68399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D6B580C5
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 17:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E2B3B02FB
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01D81F03EF;
	Mon, 15 Sep 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mucR6vmA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6733375C0
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949963; cv=none; b=N11oZHb5alm3Ggyxaz7Vi20/mpHMdxKwSb3SUBFZJaCDbjxdWM3/L9KmzgQwQGQEGJRZlD1satBM7Fg7y8fF2PHmpPw8O6ngS7Ndp7gYOi/XZL2EMtn7DkQ+KHK2DlvgoqvCxgcAnsHotZsz4JfZC9MkciiQAF498MtPyCrynAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949963; c=relaxed/simple;
	bh=EyXri27Pt/akefOQDUhzfEAoRim6JXs5fhh6q8B4I8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7a5yILIsgYYRMhgvCMsVUz1q9EH+GjOQruO3vXXvDPvKvgZ4yWdO4jKms6Mih/4Deb2150pNI7XuixTOf6Z7hCocA7OAtPhrNN7VgcRQCrUtMpBvqv3ocakBDL0eR2WCwdNTyeof2nFIbHAUzRE5ZVf5Q+ANQTDa14Fnxo23KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mucR6vmA; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b4bcb9638aso976091cf.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757949960; x=1758554760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyXri27Pt/akefOQDUhzfEAoRim6JXs5fhh6q8B4I8Y=;
        b=mucR6vmA9vp0ZSpAmwO4LS6zAK7Wb7ZSe3I/P28PbXPaGKPLSOdg3PWSAuPissX/bP
         JSxHmUbg+idN1BM+1dD15AU5Qr1R3H2ehMxSL9ivIgYWUj+LBD5GpqWxtZWR4S/q4SVC
         02YsCwWVyN0v32ZFskC70esBc1UH3rb+8tOzzFSb6uuAVxBB79dj4Jzz14TaMELbT+aC
         fy5eTQA49cG4mPZPPrEUP6oiFOKEUDBy0OvGuiwWrJ1GmZJCIP8lZ8cbEY5GDRRk5vsX
         jdTXlGrIXhWvLvTgwOCwzcPUIQvythEBAAqt03fkqZFiSUA+K9Tv8ZAyrUYs7q83xbAd
         LBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757949960; x=1758554760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyXri27Pt/akefOQDUhzfEAoRim6JXs5fhh6q8B4I8Y=;
        b=N3rjd9E660K0vlpSjRIaAQgO1p9VmQ8T8/xlP87nXN6HXAIgHBELhhNSBvMwK9ySi8
         yNwKimiC5tA8URvLm5ybPqPtzEOd7BHxG/bE4zxl4xlr6KpcDk5AJyGOZqo9RqMxuJcn
         N3oZBXFFhTHBoikw8a2fNLY6r9cq7EJ8uNnrgtPdlkNJgthaJDJddn49ulLmGqKwuiFz
         Z/Y1HGWmQxIs+yGVpCp3tysNG1TnMrXOfbXftqWLit4RMyUGAFGuB03+P2R3rVJxHUfm
         9/jUEk4PI4Uhe2EyBWYWbIy7Ppp0KoCVPVTtCCChgwXk971EMEjq47mlWt986a0NRNR2
         xX+w==
X-Forwarded-Encrypted: i=1; AJvYcCXvij1UlLT/AjoMrzmw7p0Fx4aM3zocqBtMnzHp92miN2PdeTGTGyyHK1osxJwfTydxQ3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW2ngXqPIFp8Zam6h8k4dBqEWN14BUpJGi/KrZH4OsEtKWXEqc
	QDLy/IaVjAevkc7j5WoV8QmfJhBspjkPzjg8cjtHSu6eYxnpNtXIIzSQEqVkEV9L+dyTh8Gqd4L
	aew9aHq2oKDmAQXgtmVkQNP5wceoV6pnthLShyBms
X-Gm-Gg: ASbGnctoBFJ9lw6V1njKaicpVeFoD7xTDHku5QGILnchQexVX0bSHqDEiY/u1LgfwWJ
	bzfHIH3/XahUY8jYSMrgQKUoucjdofVHWd7Yj8eGNPiRZ0a+Ooi9uhkM13zIcD/bhostvOnlbfK
	GZ5q5PJFcm57r3Hu5YXsVo3fzMOOurwtH3Wd8NgiOykcDgYTcO2xolohxR2wcoLPZy08BL5NJgW
	R0r7RXezXtm5wtmllwZq1I=
X-Google-Smtp-Source: AGHT+IHShM3r6feBapT4gTDKOG5vd5vABusk6ZNc0QTT1nxg+Z0uMrihoDo/4U4rKPGDrTNbMSlHFgTxa0Fo2vgQkOU=
X-Received: by 2002:ac8:7e91:0:b0:4b7:a274:d54b with SMTP id
 d75a77b69052e-4b7a53bfae4mr5366191cf.12.1757949959762; Mon, 15 Sep 2025
 08:25:59 -0700 (PDT)
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
 <75bc0c27-3d08-484d-9d22-59bc70f7ee1d@suse.cz>
In-Reply-To: <75bc0c27-3d08-484d-9d22-59bc70f7ee1d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 15 Sep 2025 08:25:47 -0700
X-Gm-Features: AS18NWDzXwa6PsADklKbxWJVhOSyinFRXX6id3GB73JJ-8IdNGmacbKtj7E3p8E
Message-ID: <CAJuCfpHJyGrH91yErLBMPbFBu9dS3Nr_ij2FJdQ5cUnYxAu9Tw@mail.gmail.com>
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

On Mon, Sep 15, 2025 at 8:11=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/15/25 17:06, Suren Baghdasaryan wrote:
> > On Mon, Sep 15, 2025 at 12:51=E2=80=AFAM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> >>
> >>
> >> Shakeel or Suren, will you sent the fix, including Fixes: ? I can put =
in
> >> ahead of this series with cc stable in slab/for-next and it shouldn't =
affect
> >> the series.
> >
> > I will post it today. I was planning to include it as a resping of the
> > fixup patchset [1] but if you prefer it separately I can do that too.
> > Please let me know your preference.
>
> I think it will be better for patches touching slab (only) to be separate=
,
> to avoid conflict potential. [1] seems mm tree material
>
> > Another fixup patch I'll be adding is the removal of the `if
> > (new_slab)` condition for doing mark_failed_objexts_alloc() inside
> > alloc_slab_obj_exts() [2].
>
> Ack, then it's 2 patches for slab :)

Ack. Will post after our meeting today.

>
> Thanks,
> Vlastimil
>
> > [1] https://lore.kernel.org/all/20250909233409.1013367-1-surenb@google.=
com/
> > [2] https://elixir.bootlin.com/linux/v6.16.5/source/mm/slub.c#L1996
>

