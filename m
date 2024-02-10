Return-Path: <bpf+bounces-21687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB0385028C
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 05:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052291C211C1
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 04:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69253C30;
	Sat, 10 Feb 2024 04:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjLGX08h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB441110A
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 04:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707539926; cv=none; b=CmvA96VWI/jAAIeAij5dlYukD6VfEsRREysT1Pjzv0m6Tm1MPxL+47Y6VU0MU0WDv/pZQz+PgZBK3D6zLGS5v01295AECCHOdzYrpeMOibDKf0PyeOk/m91KGmTHjrT/bzy+oqD5ddWb9OB0TN3zUBwx7brQqa1YnoNAWiBUr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707539926; c=relaxed/simple;
	bh=pEF1Xzzp8paMKC43Vd1QrWXw3lGgsDBilaIzGYEOl98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIeGfGHlRz2p0GMEFNDYN9oE1uVMbayLOIqZoYoFrCBeu/ZKUafBIPSCnZGk3Be0S8Hxc0971U63F+lgjc1MbrRX/P6rxlJ8N2v0VMKFnzu7wFm7QVEF2Z537Sif1LfEjYCPss+TfFh+QDvpNVTWnVUz51M5f20IticTcqUI+fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjLGX08h; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3392b12dd21so855228f8f.0
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 20:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707539923; x=1708144723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6Zlup8iomPkzs8TJs5tn797XN1N7V8PDpjald6vSBk=;
        b=QjLGX08hPYPVkRDzMxdB6tc8oljaFdFl+FFTjde8tymsskH9jZT6HQ0VczqobRAqnv
         IlBNijTQh8Vyqe74XKjyavOs+XEVUtSFqzllBJhz9mLBr26fw4xaGV9aB8HS+6K8s2G1
         jhjFU5j0WXeqtCC/w3zcNydjYzZYykU3AFsGvv18FNnlkAjuRGhTSVhFv4sl34FsgeDO
         GVHVZTjg1G9k3F/TGdiEhbAk92fntPUrA6uSo+xxkGGkN/cMalj3xlQmbYvSZaUtbOTQ
         CyvSRH1mdCD5JzQTA4wqVGnqRGx/W8twptz6OgN6wzkHwXd2Pt1l5jEwY6tudEwO2PK2
         OB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707539923; x=1708144723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6Zlup8iomPkzs8TJs5tn797XN1N7V8PDpjald6vSBk=;
        b=ez7pu9gTEDc43AMM8ABTbT8Lwrzfzt98eFDRaE8m27udQFB2Y14NDj770PXYkDuQ77
         sLOiZBc4fEvdLTXHAnzicQ/B2oKpeOUiz1tXEaaBhF8s+0FtsTCC3fPR3J3dwRWpphhE
         3xKWi6S3qDs0gKaUOfik33yIvxL0tV1sVr1cbSFp7ZDVWU/Zp0orec60PbESxBC+/Avz
         kyB2X/MtOicJUCBwQJ5esLVk1evf5IOGVG/EXyUo+c6cR3LjVS9m/RuzcWZH5pL/jkf4
         mOt71CX1ypSP94Gb9DiROCwLrI2fiB+Mw+xvLAbWcYkpPOwEENAMraF/X1hKpC1hPXIs
         dbdA==
X-Gm-Message-State: AOJu0Yxi7q2TINpiRK9refghKRs3FiXzAzfxUm2K9UviX1g+hrUQgc5T
	hJwe4i1MdZhEbind73OAZuvIJkwL6ALb2Eda2nquelJTPjLq0A/ddOMivb5vg7jWZdddDVAVQ0M
	D8Di4PS5EndsLu3loGHNO9GEVFr0=
X-Google-Smtp-Source: AGHT+IEckgyJXtExzgMpqKsN7RM+kh6aI/P91uoCSe0NeawVq/NvTH4M2i5t+5WcZvbV/QSKhoZCcaVxPEmVxeHIYqo=
X-Received: by 2002:adf:ce92:0:b0:33b:5b10:acc2 with SMTP id
 r18-20020adfce92000000b0033b5b10acc2mr510961wrn.28.1707539922801; Fri, 09 Feb
 2024 20:38:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-6-alexei.starovoitov@gmail.com> <20240209203634.GA3615691@maniforge.lan>
In-Reply-To: <20240209203634.GA3615691@maniforge.lan>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Feb 2024 20:38:31 -0800
Message-ID: <CAADnVQJ8ngVfDiVs9oUNnFHzh=RYkHd6tmPH3imQAidk9tX3hw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/20] bpf: Introduce bpf_arena.
To: David Vernet <void@manifault.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 12:36=E2=80=AFPM David Vernet <void@manifault.com> w=
rote:
> > +     if (attr->map_extra & ~PAGE_MASK)
> > +             /* If non-zero the map_extra is an expected user VMA star=
t address */
> > +             return ERR_PTR(-EINVAL);
>
> So I haven't done a thorough review of this patch, beyond trying to
> understand the semantics of bpf arenas. On that note, could you please
> document the semantics of map_extra with arena maps where map_extra is
> defined in [0]?
>
> [0]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tre=
e/include/uapi/linux/bpf.h#n1439

Good point. Done.

