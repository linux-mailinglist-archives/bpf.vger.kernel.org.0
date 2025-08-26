Return-Path: <bpf+bounces-66547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D45EDB36601
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 15:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93738E65EF
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BBC3469EE;
	Tue, 26 Aug 2025 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxLRhKWC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A870343219;
	Tue, 26 Aug 2025 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215865; cv=none; b=IgRle4u93GVr8sYKMfQlVopwTPaWQXXut93RHtQdkEgmqDND7Uvv0jkDO7DwwgEm4hpBzu2WZMKa8qCFgQCPPxjaem43RIKJ8domeS332fRBE+BXbky776r1z1oFgCNmQsvTbfRczr49zD7XQSgYd1zgNOvR8bpBv2xit1Zr7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215865; c=relaxed/simple;
	bh=h6gfrpYEH2XBYqvnyiT6BNKRSQZBOw2Kxi6wqxzH7SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEegD+eGsZjfIAwnhVHnE6S2Z+bazrkTY5q4w7kiiyi1OnvhI0H/xIHa0Bewmxtfi3Qh5p1ScUMfk6VW8Bi32vDTqfOfwCPRcu6gRXEltoTJIKvS9iFYyz137xGayYbl+1UgHzYyrlivv3bvELAOrcgBCNno1CuDTTAqMyFaQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxLRhKWC; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-72019872530so21487957b3.1;
        Tue, 26 Aug 2025 06:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756215863; x=1756820663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9Wu+r9qe8msXqcy0bdhKSC4qdKofp2IsD3pyoPiBGI=;
        b=RxLRhKWCfP72wH38XuXWZL8sANDl42UMixoQ8uzey5sbugLKWDychD+CKh/s6g3yGu
         /ITbJQ5iibWpBytCd6bceLtIaUiR79vxy27cZIR5IlJjn2PlpE4xJTQ5zoDLRdavPlUY
         BEqexNpJ1Doisb40yyeAOmfgc19HfsbUnsGrA50hgfew7wy6ZJInJH9smR/FtcxLUD7n
         xn2DZZ1Y9xYUzFz9szw/pYAjjucgxfxTPCOt3dR7LoNUIh5t97YHSmIrhWRwUBPA7jIE
         vz5Dv6kSJMdeFqtp4UifWTX961x2X0mn8+Z4BuEKnhB4qFG7oW331EpG5DgGi/L9fb50
         LSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756215863; x=1756820663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9Wu+r9qe8msXqcy0bdhKSC4qdKofp2IsD3pyoPiBGI=;
        b=LiLX69cVyDxYnC3L+i71bZNWpPmmKCIJUUt4uB5zncxA0dkwv6hKrMZBsgWJ37whFp
         bz2kWwU/1hT5jOlENkBPD2iqhw9sBZnqKyli7jHN7d1thjP+paJAGWs+dK1e9RwYu9jw
         GUSujaygjd+Xfq2uKEpUIJEPnuUceDoSgMxhutlUIiWrhlcG09KnVuTrLhG9BAR/8rmD
         7ogVHjveunkc2ATxRMmbaq4UEqW3RJanGKpIfHu0JSZDL5fphaLBhpeTYHM+AYmXnKLt
         d5450lzk3OqLT5PSUchpsYNfuZkaU5Z/Bi68h8jFqsSeTqju9cqtf67AoyQ4ry1oJ93O
         xmcw==
X-Forwarded-Encrypted: i=1; AJvYcCXgobxnaT8HoBAZ0FQfANixI4F434UdLke1S2YgSGDQkM/sRsmNk+e8TpRRDzQUIG+P9NRnGJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXSDXxAITXX8VQVf6IAX6ZzOKK9qW3d/qrfipkW+fkOvEPDkm
	ozzgMO8axoVmsDnk+Dj8v1m8b3aF6wyHvzZ4RBVGK05HvyFDDLLnIEfhTmDYNF/TNjqBQDJs8tp
	5+HVWeZ7fD7eNa6fF0/GJL3wjTZJTEGo=
X-Gm-Gg: ASbGncvDsj2hnKcNbOJ574vOpOVeNEGRVi+U4NeX1pZXiY+sBAWLE7uEzA5jN9DXA4m
	a9JcYAA3u/BoLSg+RkZtevGKCahhSnNGsCECXze55BHHxBYGxeGYyTyyF2mxM4SSQlfPc/EpSoT
	VMAUceGf0WaplAgGh6WzptW6Ld+fCl28nX8t+4hj97hUfgS2W+EYnCd4rO4xRX5gqqvOl+o+qLL
	0NHLxpLVTgNIo4P+w==
X-Google-Smtp-Source: AGHT+IFKP70JWp1/cr4TdNlPBWxCnWQMNyk7OxeuCiP2T5O/NjJy7Wk8Yux3WDbnvc/kyh4lFy8n9qpu4Xtn4gPKZsQ=
X-Received: by 2002:a05:690c:64c8:b0:720:139d:4dcf with SMTP id
 00721157ae682-720139d5b66mr97299627b3.12.1756215863019; Tue, 26 Aug 2025
 06:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825193918.3445531-1-ameryhung@gmail.com> <20250825193918.3445531-4-ameryhung@gmail.com>
 <20250825153923.0d98c69d@kernel.org> <CAMB2axP2c+tfYPvw7PiPRk11ZkTpvMdMnLRMgjgG697unhGEcA@mail.gmail.com>
 <20250826062019.2140dd84@kernel.org>
In-Reply-To: <20250826062019.2140dd84@kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 26 Aug 2025 06:44:12 -0700
X-Gm-Features: Ac12FXzHU8CEjaA58v6GMjiC8MirT5rJfphKvaQZCFg4OLrpH-rgKkR4FUpjtqU
Message-ID: <CAMB2axP59H5h5pLw4x-uu-CyJkds=BvzD6pa51PtAD2QRNhSfQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 3/7] bpf: Support pulling non-linear xdp data
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	mohsin.bashr@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 6:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 25 Aug 2025 22:12:21 -0700 Amery Hung wrote:
> > > > +     data_end =3D xdp->data + len;
> > > > +     delta =3D data_end - xdp->data_end;
> > > > +
> > > > +     if (delta <=3D 0)
> > > > +             return 0;
> > > > +
> > > > +     if (unlikely(data_end > data_hard_end))
> > > > +             return -EINVAL;
> > >
> > > Is this safe against pointers wrapping on 32b systems?
> > >
> >
> > You are right. This may be a problem.
> >
> > > Maybe it's better to do:
> > >
> > >          if (unlikely(data_hard_end - xdp->data_end < delta))
> > >
> > > ?
> >
> > But delta may be negative if the pointer wraps around and then the
> > function will still continue. How about adding data_end < xdp->data
> > check and reorganizing the checks like this?
>
> You already checked that delta is positive in the previous if (),
> so I think it's safe. Admittedly having 3 separate conditions is
> more readable but it's not strictly necessary. Up to you.

Got it. I will change to the new set of checks. The original kfunc
would return 0 when pointer wrapping happens and delta <=3D 0.

