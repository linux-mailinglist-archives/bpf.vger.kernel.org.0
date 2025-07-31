Return-Path: <bpf+bounces-64762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E148B16A4C
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 04:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4820C4E7C73
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 02:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5FD13AA2A;
	Thu, 31 Jul 2025 02:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu1NpMYQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7CF3D69
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753927672; cv=none; b=eMlADBMwPdnrCzQCeTA6fUOGgWHgiPmqM59j4phYRkVGP4Ak9iy1zqxvwdid6mgkYBAgw1sTZNdHzBUM/3ekfoQs42FylMiI+WSo9rX3TN4djzOyXa1p89mJVErkUFxDmrrecKxYWUOySb4+TySq5XK/iSAHKusGjhDU2Mvo5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753927672; c=relaxed/simple;
	bh=GNrPNeA3sPng1pEzthXqof5sqaTQASf+zQPWSy+n+b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNK+poDBQcp2GAMrkX7wRcfj8/jre6lx89REDimXEhNiioIzapLeedBu3Cmuk04LrP2jVaycL1uqliYdZY/i6u1eab0/nBiwEOJl2+cXilT8jjuyEVDSwn9wT000G1xwElD93vgQiz0tdPt8Hr1k5iBuSu9+mpVdqXlndHbOiTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu1NpMYQ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-707453b0306so4980206d6.2
        for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 19:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753927670; x=1754532470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNrPNeA3sPng1pEzthXqof5sqaTQASf+zQPWSy+n+b8=;
        b=Fu1NpMYQeWfPb+aCA6aC1eHtX1cJu46B3UcRSwgyabqRRdoqgDMXPwOkDWwNx8ovZ/
         a0ckLZikAzetDLClJjKD2GWpRHLPiu9SM+5fHqSSV0lKPdsusrKZx35OWYU93B0EfzUa
         5PggtF4T25dfOn2I77ztcDkmAyZFmf2b8WxCOEjpINpqkzVucEdwmgIrQ2ygJbyLmKEg
         xJSAOzyBoco+YnSsafa5NjD8MWJB0H5II8GAg5MUzTeix57FKyfm0r7yjYuYUd742OBm
         nj6NC7KNyG++OcDAAFfjMOBYwip+qZem4FObrK6eKkt4kMxkytzN0K2Qj7/LjBwUmP5O
         zrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753927670; x=1754532470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNrPNeA3sPng1pEzthXqof5sqaTQASf+zQPWSy+n+b8=;
        b=p5tY+fS1OuoutbbZcnYntdB7w65XRY5uo9GXIPtdGy/uV4387Xsth5ya2IHHntcD9k
         9HZFWV18hJPqXTCZzSSjdwmyTnulj5cfjTlRuJ8NDZ426pjSTbqC5SWNdbAqtam2P6Pr
         kNDb/WGSGbXti4IgiIXOkCXagx9OLpXFVM+lU25hHAY+nV8vZWRjoUku9T8CLd9ZetcU
         EOPhQOJ5WKpZciZq69onRVvhUD9o1kxD8C+mOtjMuntm022caO61Xq18eHzjl+/i+hvk
         FAmEDRSHYEPsOC7GIv3DDJb2K21uErNFSjJ3meL1/T3l0qCeEHm0ECkkvAVBA3HRq8bt
         Dqvg==
X-Forwarded-Encrypted: i=1; AJvYcCUr2WJb9ayaNSyoegOFWKYolpLKZ0QZND2PERP3AAQLVCSYFDEvbzZF/qhCyCyEVRRPAAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3PxLAHPHyMOx5BrnSMuOsJxaGw/+NlkZ08GrtkcCsDxjFKMSj
	H7om8KkZso7cYmvw6YWEFKvPwumgdoSeJr/qROeivRml4W425Dq6aMfZqIVocoAieJkAngvuVGG
	RF50VJij5887UQVdckiQ0gSpqHilVnCM=
X-Gm-Gg: ASbGnctKonOmAPG97kg8/Dvp6rh+p15jzfrqMa2iczPPXTSO07dReCdOE7IgbAH+Idz
	qWqc/qZTo8o3yzhJpRnOHlnBwTCXEBwgmhbNVP0BTpJivtkBBtNow+4+y+q9wFyt1C1fsnLCO78
	QHtxN4TFLsfR4cyK7PD7r/FMR0v6EvP/Pr9U0pMi5tX9tIh7w/1DSwjpagZ7fNnWt18IbeLFLxm
	EkiIy9F8fgdhroGnlI=
X-Google-Smtp-Source: AGHT+IFl4zilJ+iq7LWpCHNLJ08uCPsTB0QyYd7euDvV41rgJzWYvXwal5T8QCY+T4E0b1bI9FEYFuWQnW9GmYI4VlM=
X-Received: by 2002:a05:6214:dae:b0:707:4023:6b8f with SMTP id
 6a1803df08f44-707670af0edmr91719236d6.28.1753927670016; Wed, 30 Jul 2025
 19:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729091807.84310-1-laoar.shao@gmail.com> <08D7155B-84F0-4575-B192-96901CFE690A@nvidia.com>
 <CALOAHbDRBs8bdXB_LJjx-7gALOCLvmMxFD+c7MbHAiQ3htXawA@mail.gmail.com> <65e9ee9a-3b64-4efc-ade0-83990de7af91@redhat.com>
In-Reply-To: <65e9ee9a-3b64-4efc-ade0-83990de7af91@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 31 Jul 2025 10:07:13 +0800
X-Gm-Features: Ac12FXzKKcoL0KYZ3HOR5kQdoagfYyPfz1C1dwQkzN4KdSj9vlKo7adHNYovK5I
Message-ID: <CALOAHbCuFixOuTP=dUiHF2ki8PiBgU_W_JtL7qZUL7C3o1SH3g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/4] mm, bpf: BPF based THP order selection
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 5:58=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
>
> >
> > Yes, mm is sufficient for our use cases.
> > We've already deployed a variant of this patchset in our production
> > environment, and it has been performing well under our workloads.
> >
> >> Are you planning to extend the
> >> BFP interface to VMA in the future? Just curious.
> >
> > Our use cases don=E2=80=99t currently require the VMA.
> > We can add it later if a clear need arises.
>
> We should start immediately with a VMA-based approach as discussed
> previously.

Got it, I=E2=80=99ll update that.

--=20
Regards
Yafang

