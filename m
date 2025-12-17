Return-Path: <bpf+bounces-76805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FBDCC5D71
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 03:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6D363025148
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 02:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165E827B336;
	Wed, 17 Dec 2025 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsJuJ4lu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621E256C61
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765940237; cv=none; b=sEAHXofpod3gKvYwrVvBNqwDXYn2BVxeKItK1aiASDybQW5GQPMjT6nQQLr33102t+w/2yF9VNJZ+jy44jPzut4/H4nTHk8TfWGI/mEvu3JAmdkxMaV/VS2fd6otE8XEniNsSoUqyJ8FVEfMs0pp9fb3ZON4s+G9r1IUHYx46Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765940237; c=relaxed/simple;
	bh=vy9dhEwoFZypIXnPwGbt9wOWEVcb3pMPs6hN72RrTdY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PYF5hl+hK4yTwoaMIUpTKYN4ws1vyFaiwETScCmXgkQ4rhwVNywEYo7aopaeoUCbyYW7QhXgfyVGLO8GldpGM+wTlaxCqmyw89zr9Z26Tl/b7/nxZ+8QfPhl7h7YvTP7v4nF4GNmjpMRIP8l+rnIucnfaNh2cReR1R49fUpWaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsJuJ4lu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7fbbb84f034so1183245b3a.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 18:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765940234; x=1766545034; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bx11gz0v9FIYU5AR3gFhOHeA+LHnwdt68gyiS/iFJGg=;
        b=ZsJuJ4lu89gNv+WzfGiVEGxakVs67T0XfDCc5TGD3cS4KZg37WM0+Ku7aOwFyRL1uq
         QCPE73xGjHyxzsH+bb9u1o+IM1VRfmQ0FH7uMMsUx7URtQN7gCCgjhnEQwtye+dXKotF
         B1P2r9Lt6yeC3QM/eq+TCGF2FwKvCWtCYST0R4NHUMrM9HpIw62dbn8c1GwKlO9Xjzub
         sn9bC6mnywiFdbHajtjTxMuzaIMIyYk6VCq7uUIDIXJVJ2o5X5nwOYfV1gE88lu5LQ5F
         rmo2lrlEndvXorG3KPWqgtuMNoOhM+Ja06dC7Abxc1B5dektPMb5Sad88KqiomyXGW3C
         eK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765940234; x=1766545034;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx11gz0v9FIYU5AR3gFhOHeA+LHnwdt68gyiS/iFJGg=;
        b=KGD63Q4P9ldSj7t5SQ5yZciKAhpHpDVvuK7qcuLZmnzhIlgnZE9EJ1XLhj2HQcaxwH
         Vk1CgXIlcEpsLTNys+6T4eyGQ/GN6zimPYVvHfudHgSxNcSYls/7rFoNLb7Pw3sZekX3
         lOEnfp1a8jN90N9YcO/fapLn4LI92vycnsqTGDceWW8myNMdivIcaHy8/S/2yPuD3UoG
         eZOWJDBqtCAu2eDKygMzfg2C+pgNKgqdu3CHHTD8PutNOc5vnqaMyxGKVW3oiyx/U2Fc
         pWm6o45NDZoKCcTi85pvTtpphz44ma2BOoCQQbm6Ydq59cD96g6f4g3VY85V29eycctN
         Co2g==
X-Forwarded-Encrypted: i=1; AJvYcCXhWXPrmAx4Fqjws7LstKxRGc7yBnSdIoND1KYqAE9/END3abo7JGzyw9N2n5Hl/7QJqEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEdXZHQIuuLPQEqVtFBozz9CyHEMmqEN72SzUqjo0/vZ1u9UNV
	9cO11P2jR8mlpqnM9X2nxk5ijviP2NQx3Zd+mxWOqUmbLh7foSVPtv4e
X-Gm-Gg: AY/fxX6rqESp4DIx296fPDBdPyDJVD6GHKIxgo4Re5izukeaOsSGUjumu+3ygordq1Z
	2kAnfGCSK6W5EvdxGKtdXwpLaaVgq4nlyWF9LdjpHC2hCFjUueyZSE9YRXwSRb8YD/Pb77uDBlP
	JuT6dZ+ptZX1XJOTecDMCMZ3mxszKyBQg39vf0PIomLyKrWe5WavyHyUAy/Aj0PcTeXP1uCvUWS
	XTx0jfkL25acCGB41qRDiopCzgXfE6Hyq+8nMpK4o0SLs5kf1J+S+i7mRtkHOt036iuXbDJzhNR
	W1GFmjm1eJkuv8UwKzShW818wcvKNKQkednZA5pbUxp2+SJ/a0vavSnUNRKL9ZzNE2HdroMMVAb
	FQGK6gzMsAOEV2P3MO+9xtWlDanbs1waEgzXou2BLYHDuLRFNnmLPdF1nVTq69dM4J3gg7UW/sP
	zjgyYdgfH9
X-Google-Smtp-Source: AGHT+IEqlNltH5T58axg3EwB71MMWHr++W7/RBY1s/JD0BH6S9b4OQnoW9YT3DoNvqVZlzx0MVOT0A==
X-Received: by 2002:a05:6a00:4c85:b0:7e8:4471:8e0 with SMTP id d2e1a72fcca58-7f66a46ae16mr12376276b3a.65.1765940234467;
        Tue, 16 Dec 2025 18:57:14 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcb5c6d9acsm999786b3a.0.2025.12.16.18.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 18:57:13 -0800 (PST)
Message-ID: <aa21b648da9be14019fb78f23325052ec77b2730.camel@gmail.com>
Subject: Re: [PATCH bpf-next v9 04/10] libbpf: Optimize type lookup with
 binary search for sorted BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
  pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire
 <alan.maguire@oracle.com>
Date: Tue, 16 Dec 2025 18:57:10 -0800
In-Reply-To: <CAErzpmtLMd6pS9OfeS1=_VTyUqPNfNa4J7d1m_ydC=u4_k8Cbw@mail.gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
	 <20251208062353.1702672-5-dolinux.peng@gmail.com>
	 <cb0afb795b4dc8feae51985af71b7f8b1548826f.camel@gmail.com>
	 <CAErzpmtLMd6pS9OfeS1=_VTyUqPNfNa4J7d1m_ydC=u4_k8Cbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 10:32 +0800, Donglin Peng wrote:

[...]

> > > +             if (unlikely(kind =3D=3D -1))
> > > +                     return idx;
> > > +
> > > +             t =3D btf_type_by_id(btf, idx);
> > > +             if (likely(BTF_INFO_KIND(t->info) =3D=3D kind))
> > > +                     return idx;
> > > +
> > > +             for (idx++; idx <=3D end_id; idx++) {
> > > +                     t =3D btf__type_by_id(btf, idx);
> > > +                     tname =3D btf__str_by_offset(btf, t->name_off);
> > > +                     if (strcmp(tname, type_name) !=3D 0)
> > > +                             return libbpf_err(-ENOENT);
> > > +                     if (btf_kind(t) =3D=3D kind)
> >                             ^^^^^^^^^^^^^^^^^^^
> >                 Is kind !=3D -1 check missing here?
>=20
> The check for kind !=3D -1 is unnecessary here because it has already bee=
n
> performed earlier in the logic, after btf_find_by_name_bsearch successful=
ly
> returned a valid idx. In v8, the implementation of btf_find_by_name_bsear=
ch
> was refined for better performance, and when idx > 0, it guarantees that =
the
> name has been matched.
>=20
> Thank you for the review.
> Donglin

Ack, missed that, thank you for explaining.

