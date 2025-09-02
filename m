Return-Path: <bpf+bounces-67203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB00DB40A76
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 18:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B650016146B
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EFF32A82A;
	Tue,  2 Sep 2025 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7S2tSrW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD92D593A;
	Tue,  2 Sep 2025 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830175; cv=none; b=CC4tgLzy5pDY8o6YVm31foiKF47mQBnGtPqqE3GTdvPV5OTWIPV2jBwOxQJSwtjcCX8Ne/SutX2jMDrx9jYUzYeRxY3X252XW26s1yB572xXPv8UqDmylAdaSD0D7EdS3fLvF8HuBGNXpA4sYHtQL5/IHxFO/JOYA/yGpaMrnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830175; c=relaxed/simple;
	bh=s8redoHiFiaDFRdOB4o+GTB9FYVh+flB3tU5pZMyFbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbnHQqnfuU4VyeCF0OskGDwPgLXadp6PAfIzJxMu576XvtYrpsOBCPbsPQIsSYtXlOfZlbIOudYrUoJeJoojnptWFzgAFscNBS7DBb4FpVy4/F0KeGnBddVoEpFq+Xu+hNXDoy4UzvwybSrCcD4Mh3v6ICbOqzhYmgq16o+iok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7S2tSrW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0431c12df3so338154366b.1;
        Tue, 02 Sep 2025 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756830172; x=1757434972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgCxwwbqdu3nXpSeFUO9IfY1NtNLTx4RTCfuguxloxE=;
        b=H7S2tSrWi77PE8eZtat6o5Hng7EETC/yxtGXZwsUGg801oCjBDf5libyRMZpCNR0Ai
         /x+VaFVr4oRwmFcMfQP/NOffzQGrJRBgv2NhU32t2AIJbE1fhOC7iVXk1iY8Pdn+FHCx
         MhMUnaNsRhZVJtl+cHlqFmKPSipLp4INLJ0C3WdqzFhWu2NUhBE5012pG8jr1iLRotQ1
         Wkl1iYpgJbhmjkJsuLVA8RymFaFS63y0tzbcbQiybAZIatzBsUjWa3FKjDy/MIKaruEv
         FNXgaiTmj7ASE0GYHawcnMQNyMKquJNdHYWyBaeP5WnZTsG6NMDKgDvqGbFich0Aw/FW
         QWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830172; x=1757434972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgCxwwbqdu3nXpSeFUO9IfY1NtNLTx4RTCfuguxloxE=;
        b=F9OzDiBQdaODu6BgRq1gSHfW0Z3wUY36jWVghXaC5su/5q9hBN15r94t9rUMfcV/TU
         kP3Bc/NKO5FD/cH2EbFXVY9w7dTe15cNyudSH4J4SnIxhkuc0S4xgN0UIMS5h7uqV1Bc
         9yaibjG0ulK0Hkb+ZKkeHeNJmdSiDbi9lyuqnp9sRi8Sa6nle3x3klQEmetYemRvAqoh
         NgfPp1tKjyqnuVzuUc99i5/JOW3EMEem4nc2ju0iUE9UHImJHzVzs7kI2rWb0P8Gyql/
         04WJIIGwpAEHjsgFWRwV4xsYySoev/RHyDcRlc2UpUxIOv5rcwzuh2vwA6DgokRcMms4
         rHbw==
X-Forwarded-Encrypted: i=1; AJvYcCUELjMv2IXCP4qJMIGWYrAfutwwYMOXOxHpTXmw93046lvN7fMUqysbigJSGBR5s7Xs54s=@vger.kernel.org, AJvYcCWfiNIYJ/7rNvvyogg6ICOsgrxgP8Gp3yqIpg2cAyN5MW+EIMtCAeIXEy6llxNwak+/e8AqkvZP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/fDUvGpfgk9Tn+Mdt2lMvnGaJ1yhEd7JxsWngGHWpfLZ7U7Lv
	+2+rTXwKcnfNVSKysQ94gNxF4mSS4sZRZwvVTUItvRW0yivJRJkAKf2KQKs1oZzs7mwVdRF8vL0
	JtoyLDGWAtjxLQEdMgNuqnPmLhMmoa1sH+w==
X-Gm-Gg: ASbGncsoRsBEx8ArzHQBg6TtErbe5/x/c9Q934xagVplSPi1kslYg4ptm2MP/SRfJeb
	MezCOQEZk9r5ZXlaCUcyutYDNxaP4HrElU4ipWBTjin3qcYkgJQOSSaZ7udSkz1hg2P/8+rL3A9
	bxSq3/60b16HRelcjhPKRGv37h8PkS0dqIS39G0JRgGDiNuypJ4yy96HAczZx32x224OGAKuX9h
	f1Eh4ux/ogsSgp5Lm9OC98fBwqaV7Ixlg==
X-Google-Smtp-Source: AGHT+IFIEbJfkmbeGYg24Rnph3Gu/OhIGZCxHM3rNukuk2+854LxQI3VS22WNyy7if7fkN/xHNCvUqq9L1iRMOZuiow=
X-Received: by 2002:a17:907:3e87:b0:afe:af04:33e4 with SMTP id
 a640c23a62f3a-b01d8a26e7dmr1354392666b.11.1756830171971; Tue, 02 Sep 2025
 09:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829180950.2305157-1-maciej.fijalkowski@intel.com>
 <CAL+tcoA2MK72wWGXL-RR2Rf+01_tKpSZo7x6VFM+N4DthBK+=w@mail.gmail.com>
 <aLYD2iq+traoJZ7R@boxer> <CAL+tcoAKVRs9nnAHeOA=2kN3Hf_zSS5z64yUSEVmtiS82zz3-Q@mail.gmail.com>
 <aLbNNInuSjkC5qbI@boxer> <CAL+tcoAiY1_OvVAJwWj-YwWY3_9QOWQ_Dwsn5V4vy+wnOQJJog@mail.gmail.com>
In-Reply-To: <CAL+tcoAiY1_OvVAJwWj-YwWY3_9QOWQ_Dwsn5V4vy+wnOQJJog@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Sep 2025 09:22:40 -0700
X-Gm-Features: Ac12FXz9hTvA2zwICzWYf_7hO2ZJqXxi4PpcS1KUHGmKAH9CMWIlZmSdetCt7Js
Message-ID: <CAADnVQKOwfFsccUxC1MmtdETkbEw34MaV+YwV=f4vssP=+scVA@mail.gmail.com>
Subject: Re: [PATCH v7 bpf] xsk: fix immature cq descriptor production
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 6:39=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> > > > >
> > > > > > +               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)-=
>addrs_list, addr_node) {
> > > > >
> > > > > It seems no need to use xxx_safe() since the whole process (from
> > > > > allocating skb to freeing skb) makes sure each skb can be process=
ed
> > > > > atomically?
> > > >
> > > > We're deleting nodes from linked list so we need the @tmp for furth=
er list
> > > > traversal, I'm not following your statement about atomicity here?
> > >
> > > I mean this list is chained around each skb. It's not possible for on=
e
> > > skb to do the allocation operation and free operation at the same
> > > time, right? That means it's not possible for one list to do the
> > > delete operation and add operation at the same time. If so, the
> > > xxx_safe() seems unneeded.
> >
> > _safe() variants are meant to allow you to delete nodes while traversin=
g
> > the list.
> > You wouldn't be able to traverse the list when in body of the loop node=
s
> > are deleted as the ->next pointer is poisoned by list_del(). _safe()
> > variant utilizes additional 'tmp' parameter to allow you doing this
> > operation.
>
> Sure, this is exactly how _safe() works. My take is we don't need to
> use _safe() to keep safety because it's not possible for one reader
> traversing the entire addr list while another one is trying to delete
> node. If it can happen, then _safe() does make sense.

Jason,
sounds like you're still confused what "_safe" suffix does.
"_safe" doesn't help with concurrent access at all.

