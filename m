Return-Path: <bpf+bounces-57278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54343AA7A9A
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 22:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E4C466ED9
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 20:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4923D201278;
	Fri,  2 May 2025 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkVH9xzo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C8017A2FC;
	Fri,  2 May 2025 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216673; cv=none; b=gH8aK3MFY0QrzZOFO4VkdNfdHSocmENb0jGt5Jcxf7MwbhM+lhwK4Wr1azi3TkBtgYr92ho3Iv58EqaPxNZeahdnjJy6pwNi6c+QIFocECsOfnJtLVuYfVtADRq9n74BKnbD32vNESwn+j+zw582ENu7M8r56BaSvMlkBhGlV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216673; c=relaxed/simple;
	bh=4SPBgwEugGZZWaF0L06xTEWCqkIlvE8NdlDa+57rzT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q489uTpUCoeZIXqiY2swXdeliEIHWaVEFovbO75d69K7pK3KeGBiO1TKKQYN27Vwnjq84hLIjDiyCwVSdCRm2DB9QgLG/osETL77xtzVtjgEyzLLkZ08c21Sy9B7r0XZ8GUw4AxeElJphk5rN/58AOrSqVHbPT/AZmsLxrFprGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkVH9xzo; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7369ce5d323so2415745b3a.1;
        Fri, 02 May 2025 13:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746216671; x=1746821471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SPBgwEugGZZWaF0L06xTEWCqkIlvE8NdlDa+57rzT0=;
        b=fkVH9xzo2ibhy+I0TYR1oe/hRRjhrodBodS1Qp2chg8fIwv8DNWCJtZQwAB18s2oIz
         E5K0s6bnGj0HIgvyOb7HD1TxnUdz/AKt1vG1YfZqF+4OSHOWCbOgR+PL1Ua0VJef8fvy
         JCVh280GNEYRVat042AwknZOu8rvv36H4qbkSi+7K4/UHTZvGXDspFNuJrz9yRS76ZLu
         VQDPjBEF6lh1b/qgNtLAEvYDM0nyF5ttO9A59H7SNgVwv9m7BRYZ0/KLVxvTt7DRdrXJ
         +F3klgmc6g2XwkjHx2tv/W6VhKJBBJl61ysMB9Od95VRAGM/fTnrsDEcCLV2eoTZMpop
         d4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746216671; x=1746821471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SPBgwEugGZZWaF0L06xTEWCqkIlvE8NdlDa+57rzT0=;
        b=c/yQivhxXMynTxaLF6oZht+UvF1uZrBxmI6iO5zDF2clayaxRZKITNtqx4qx/petzD
         6sb0XWW3prNOaDkDWwX7bjw+TxIel2TSqH8jez2TknvBvlhSgOPWPFU0ELI4uSYAzU8l
         z3Sl4aT0C9mVHEXHyqxNmb9Je6fTCP46Myo/2Sa1HLIsTDh6ls0Rs6x6KPhvNHNFOHRC
         MHav97l+jPqL5QQOgSr8OZhcnpq5GpCYIDwjRCPMfS8/IflkFEPp36YzDq0jht03D9dm
         pHs/6e/EbyO+nvOsqtZnorWL0Y/1WhKLs1YlW9W2UzlS+9uF67TclOcJ2yPgTysJ4gjr
         +v5g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+NUvrjHZBocU5JKaCKeeoUloud/+x70SvCeSfJKKovxdl9TVNZicYAv8fMgGG8NYKcs=@vger.kernel.org, AJvYcCXFXcvMJgbtMtme3eHCgGkf8V1aqST+2bWbpNWH/eWdPc8arXiMk/HUrXN1PU3ED9p0OhgBfaN2@vger.kernel.org
X-Gm-Message-State: AOJu0YzV9j5vJVph30AkADPiuY/fz6yIQRt5ER2ZJVCmMiWnINy+fbm/
	QhP9Behc2ivHovnNH7ZSFCF9wqZChFhsmG6O81eli/vFdyVqPreaaLtAzzWuWsaA/xs6kB3NNnR
	xrQJujRFLx0M/WfLflRSKnfBBbvM=
X-Gm-Gg: ASbGncu966M6PrPm463srMDhos2qGY47WsdzMZP/Dki/3BtS/0ZAQsEKJsIOWLFufiv
	w5+mc3o109Uv5o78vRd4EVd6paC7SbNmfAH5FsIEOGXB0VCPV03VP95c43t2MWLv9csz1B3pJBo
	a6MWZVjnl8pmyg5DkqwFszYTXj6pvuAdhnFM+Y+Q==
X-Google-Smtp-Source: AGHT+IGl9fsmDmga7NZHNEHTdkDXACxVD1Gk+QupwKB+N+saSNwZY4YpvPlPxS8ACYV1O5yarHN95fBbBd5ZlGN4L0U=
X-Received: by 2002:a17:90b:5147:b0:2ee:ee5e:42fb with SMTP id
 98e67ed59e1d1-30a4e59610cmr5896776a91.13.1746216671460; Fri, 02 May 2025
 13:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214039.2919818-1-ameryhung@gmail.com> <CAEf4BzYUNckc9pXcE7BawxWFVfY--p12c3ax8ySP1P+BEww91w@mail.gmail.com>
 <CAMB2axMbAjYVB3+bMuwOszqAn153_9S_vG6iN26-J-n67NGwPQ@mail.gmail.com>
 <CAEf4BzZ=HORw6JnQz=pguoaUSc=swFiaG9mzQLxqLZgTamc1qA@mail.gmail.com> <aBUQpPFemrUYxyO6@slm.duckdns.org>
In-Reply-To: <aBUQpPFemrUYxyO6@slm.duckdns.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 May 2025 13:10:58 -0700
X-Gm-Features: ATxdqUHxEhX3Lp-HaihDyvIanUeH8CbeeYq8WIvZyGk4AgYCGrxZQX4Qk4jfIRc
Message-ID: <CAEf4BzYMvYN5aPrdE6i=CTv8dfb1zoDQqngxN6Aj33XN_ryUZg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/2] Task local data API
To: Tejun Heo <tj@kernel.org>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 11:36=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, May 02, 2025 at 09:14:47AM -0700, Andrii Nakryiko wrote:
> > > The advantage of no memory wasted for threads that are not using TLD
> > > doesn't seem to be that definite to me. If users add per-process
> > > hints, then this scheme can potentially use a lot more memory (i.e.,
> > > PAGE_SIZE * number of threads). Maybe we need another uptr for
> > > per-process data? Or do you think this is out of the scope of TLD and
> > > we should recommend other solutions?
> >
> > I'd keep it simple. One page per thread isn't a big deal at all, in my
> > mind. If the application has a few threads, then a bunch of kilobytes
> > is not a big deal. If the application has thousands of threads, then a
> > few megabytes for this is the least of that application's concern,
> > it's already heavy-weight as hell. I think we are overpivoting on
> > saving a few bytes here.
>
> It could well be that 4k is a price worth paying but there will be cases
> where this matters. With 100k threads - not common but not unheard of
> either, that's ~400MB. If the data needed to be shared is small and most =
of
> that is wasted, that's not an insignificant amount. uptr supports sub-pag=
e
> sizing, right? If keeping sizing dynamic is too complex, can't a process
> just set the max size to what it deems appropriate?
>

One page was just a maximum supportable size due to uptr stuff. But it
can absolutely be (much) smaller than that, of course. The main
simplification from having a single fixed-sized data area allocation
is that an application can permanently cache an absolute pointer
returned from tld_resolve_key(). If we allow resizing the data area,
all previously returned pointers could be invalidated. So that's the
only thing. But yeah, if we know that we won't need more than, say 64
bytes, nothing prevents us from allocating just those 64 bytes (per
participating thread) instead of an entire page.

> Thanks.
>
> --
> tejun

