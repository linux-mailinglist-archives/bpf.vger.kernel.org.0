Return-Path: <bpf+bounces-36404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A59948059
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 19:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73B71C21E7B
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F045615EFA3;
	Mon,  5 Aug 2024 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxS7tu1E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7B15E5C8;
	Mon,  5 Aug 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879129; cv=none; b=vA8CfODbJIaUZ2A4DE3gEOfiVVQ8yyUC/oHRRJrEpEemrKbyrIdyp+YmzaVWzGAdXEV38Ooko6YLN/n2gi0QowNomBbkouNejvC2MICDbstsRCNRm6ZLlB4xSIdYEdQS/bQTxQx2pP66+azWtkWfa8aEPQ1rbB/6BAnnHZjQxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879129; c=relaxed/simple;
	bh=lEym87Q9poVRRlFAesvUkzCxrM79JB4m/ty5VnTqNTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2rp/BO6AXaEzy/P427ihUfe1pkvGzRVtfmBLvrHQstEeQOX2cB2omWO7/Ado/gTNe6XBj4MFPazKjeh3gau8YT7SWk0f+aOJaKwkhgm8YjX8mv62C7a9zGwhmkU/qV0d+fuAJszPECqTevQBgXdvoJOSDL4odKLdM8jn8qoGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxS7tu1E; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7b80afeb099so1819681a12.2;
        Mon, 05 Aug 2024 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722879127; x=1723483927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjV3w/ak6du3PQEWcjLr548Sl+DcZwT+yymWRVWxH3Y=;
        b=VxS7tu1E/WFeJuJoHlPSxiEAp3NkL7pspo733oVIMXcYskI/xhykdNHVHYgVLQM/Rg
         +ECFAdB8ZApMet4WZ1lHHq1s+Ao3hE26S4eT+Ov35C0MXaAT1pqIk4/QPoqHrFa7F4+W
         Kun17QFzkTtkU2JKR47iss7XXXVO5kaxzgqRiK85YFsmYTfdYjuZl0hktAUYnWHzp8TU
         CCVCmhPYjDS2T/F2P8tNFkvjwR0c/lGrIz12rGEgVw1xiyV49ZwKa50HkKuuyh1WjQoc
         CovFg65wKV8GfUdVY8KORkgbjBa0Ot6D6KIZ0z8sHLBk8xQiNmHgX6lz7cK5Bm51+U73
         XB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879127; x=1723483927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjV3w/ak6du3PQEWcjLr548Sl+DcZwT+yymWRVWxH3Y=;
        b=buc1VhXCODCiZpaHx97S9UArhHaLbfMqy26SNPM2QPb5eaT9hrTVfsTMPxe9ZcgkwW
         9yF2GPVZbytETuLh6mlKf1HVXcZADInmZZyg4o7v0HQqLcCAa9yEAkOj0WVGPuypJ8d1
         iOG+8EEIySF73trWQKfZ4Jtpmx74jQpb61ps+cZaknrswSZEESViDXKlsluYzjyOmggM
         NzfBXFudzrCL4xuM+QPhWVJDuZi2YjZBmpLZkQvua+00xe6K5cEYEs9grGdXM392LnG6
         HCKb/w52PNAw1x8M5pSVh9yhqSLaszozZcz9QvzrOXhNZTLA0sX3bg4Ookhvg7FDfSEc
         cWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe4PtOES7JPqb46guijmCTUZFa+1viqNZRmnM2Z/1e8tzx1irCwuvNfbJn71Z4ZKXikb6DCqjlSPMbKK9cRDFJKyoRcx4n4iei+FNbroOV57ko0R3KOZK0l94lHz7QTQg93sOF+UVvIFmMR4KXyGDpLTuKjFxbufdKM2onMrVoHn4uVQpH
X-Gm-Message-State: AOJu0YwV+Sq8nBbOeANPi22Dl+uJBrCzzpamZYNzplGAdoyTSK+x0Ass
	KOZOlm5ngQJVPuAs4zNdMhELwRYnOUlqCsHTjiLqaEHVWISLs/X+uANl3raHpruVmUnRjJCKPaX
	wp44bowLtfXtf83tbTxnA+iWTTQ/BDw==
X-Google-Smtp-Source: AGHT+IFAYt+p5q+sPRsnInfI4H/CBHTr8um/ama6aqMpSIgLA7D3O1zOrMwhZie9CRJH/odkPUN4pmqhzIXNKjzTDq4=
X-Received: by 2002:a17:90b:4a0f:b0:2c9:359c:b0c with SMTP id
 98e67ed59e1d1-2cff9517df6mr10707687a91.28.1722879127269; Mon, 05 Aug 2024
 10:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-6-andrii@kernel.org>
 <20240805155931.GC11049@redhat.com>
In-Reply-To: <20240805155931.GC11049@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Aug 2024 10:31:55 -0700
Message-ID: <CAEf4BzZ=W3JLfpYcxEevMGS4whXQ2-nn5ezA+p3zV_WhiGG4iQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] uprobes: travers uprobe's consumer list locklessly
 under SRCU protection
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 8:59=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 07/31, Andrii Nakryiko wrote:
> >
> > @@ -1120,17 +1098,19 @@ void uprobe_unregister(struct uprobe *uprobe, s=
truct uprobe_consumer *uc)
> >       int err;
> >
> >       down_write(&uprobe->register_rwsem);
> > -     if (WARN_ON(!consumer_del(uprobe, uc))) {
> > -             err =3D -ENOENT;
>
> OK, I agree, this should never happen.
>
> But if you remove this check, then
>
> >  int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bo=
ol add)
> >  {
> >       struct uprobe_consumer *con;
> > -     int ret =3D -ENOENT;
> > +     int ret =3D -ENOENT, srcu_idx;
> >
> >       down_write(&uprobe->register_rwsem);
> > -     for (con =3D uprobe->consumers; con && con !=3D uc ; con =3D con-=
>next)
> > -             ;
> > -     if (con)
> > -             ret =3D register_for_each_vma(uprobe, add ? uc : NULL);
> > +
> > +     srcu_idx =3D srcu_read_lock(&uprobes_srcu);
> > +     list_for_each_entry_srcu(con, &uprobe->consumers, cons_node,
> > +                              srcu_read_lock_held(&uprobes_srcu)) {
> > +             if (con =3D=3D uc) {
> > +                     ret =3D register_for_each_vma(uprobe, add ? uc : =
NULL);
> > +                     break;
> > +             }
> > +     }
>
> we can probably remove the similar check above?
>
> I mean, why do we need the list_for_each_entry_srcu() above? Is it possib=
le
> that uprobe_apply(uprobe, uc) is called when "uc" is not on the ->consume=
rs
> list?

Tbh, I just don't completely understand how (and why) uprobe_apply()
is used from kernel/trace/trace_uprobe.c, so I wanted to preserve the
logic exactly. I still don't see when this consumer is added before
uprobe_apply()... Exposing uprobe_apply() seems like a huge API
violation to me and I'd rather get rid of its users. But one step at a
time.


>
> At first glance I see no problems in this patch... but you know, my eyes =
are
> already blurring, I'll continue tomorrow and read this patch again.
>
> Oleg.
>

