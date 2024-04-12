Return-Path: <bpf+bounces-26671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9F78A37B3
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9031C21468
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F4E15252D;
	Fri, 12 Apr 2024 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN9vgkh2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1DA39FD5;
	Fri, 12 Apr 2024 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956251; cv=none; b=JWU81vdn1kH3A3ETv061HOXkh8qqepMl5aC8ED7BlNMzAey0Sk8U4/+T2EKRPdbGpG9v4OZX8P5bPumGyecw87E8FvWnZBK8P2nWik57M3P177qJxOyQMl/l46OkZInFo/EoKDkz9+KbOJONJJrGHBJfamxjqNlW/P31e6+A3WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956251; c=relaxed/simple;
	bh=Nt1H8i2doyq85gsPERe01hg0D8NO/pjyHmMWJ5/05Zk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EoqxAFr1uqO15e07Qk6HbUJY2Mmx9a6uKjRH1ns6yuryN2rdH8dZgpOAgW9MHxbMpDVcNMcyKGmHWWKnyyHBTdUoqQoBEWTfZIPpfhzuH/gQhLRRTeo2pTaEYyiC2jzNuF8yMnlBZWH90kNGjv830Jb+yWgf175pABXzFnBv4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RN9vgkh2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a523e1372b2so89513366b.1;
        Fri, 12 Apr 2024 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712956249; x=1713561049; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nt1H8i2doyq85gsPERe01hg0D8NO/pjyHmMWJ5/05Zk=;
        b=RN9vgkh2yT86y6VurSX5eSGVtiBFdQxSTBUpxm8yQPBvDu9WleX+/mBj2BGDlmdeUo
         ky2cr2Zs6H55QpimjBS5zvjz2tVqt24i7LhMwTPjOZ2VIFf037yht87GOWY0VXsgEDvA
         1PEik+70WOOUWgZgYOVKdHQnTmYv1HY3vTq4uQzqJCKZ+69k93EER0C7TKS6z5RWplvM
         n2NwcnTVnnLkp44aFznlzSuJNH+osglBpfvyOKdf9ysP5bvxK51Umo9f985giAkERKWs
         biAMhEN9Oxr6wnPesPwRcWj75M412L3XjU+lO+dtUKdwMKbisdNAtc23Mgkvg69sJ+Cs
         J8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956249; x=1713561049;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nt1H8i2doyq85gsPERe01hg0D8NO/pjyHmMWJ5/05Zk=;
        b=t92Yc5sEeN0qfl9ejb81+YEX+0Y8NseENgonksjmKXogZ3Caa9i0Z5mQDDcFMhf1UK
         R1rx2iME8x0hfsKgasPuSKQT0g4LtHKuyeOPU+GaS134cBLfJYoPmukQJnsoTcXJ+m0o
         9Ll8dEVA9tSEKuVxyIHaGa2goa8QvlvylP/IbdIbxE8bvxsZaqUBVRlenGWQpm3rI305
         3SQuf/BMU2ZS/Joxf85sdGZu5/nz7+WaMEh8qbeTvIagidT9XX1aqtJNatr388NKH5Wn
         pL48EI6KAyrLug8P3UWCP43AYL74PEe02mu6z+eRDf2FppMBZvk6hhmfE/19ZvJi5JpA
         o/qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVclmJEIBZPlp7opRfHUHjtBjQQTIEXAktp3QHM4hdbRuNQPDwHhpwnO9c+YjSae3oCHEYnSfQV5ORoxtb8T7CGW88s/T5XS1KCtnLi3uSFMPZZo1RicUCnvzFMtg==
X-Gm-Message-State: AOJu0YzeAFLdJq2kC9+zPPXrnbTOm2vwJTV2HZsG16nV6zOnK5zaV3F4
	8h/dSi7K2JP6eE1qFhVQtwLfCHfD1rXSZ9eBc5OL6BewC0yMBV5/
X-Google-Smtp-Source: AGHT+IFM1b5GtL3S9qdwh/VYUTOByzBQF8bak21CdSDet1jDQVhUnT0B8yr3P7tKKkrOSh+utA5aeQ==
X-Received: by 2002:a17:906:ee87:b0:a52:23b6:19c1 with SMTP id wt7-20020a170906ee8700b00a5223b619c1mr2885289ejb.76.1712956248544;
        Fri, 12 Apr 2024 14:10:48 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id ne33-20020a1709077ba100b00a51b26ba6c5sm2194280ejc.219.2024.04.12.14.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:10:48 -0700 (PDT)
Message-ID: <25f907fd820d3d1bb9dfa3860e2e562993034774.camel@gmail.com>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org, Jiri
 Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>, Kate Carcia
 <kcarcia@redhat.com>, bpf@vger.kernel.org, Kui-Feng Lee <kuifeng@fb.com>, 
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Date: Sat, 13 Apr 2024 00:10:46 +0300
In-Reply-To: <Zhmi8OEthfzafTIh@x1>
References: <20240402193945.17327-1-acme@kernel.org>
	 <747816d2edd61a075d200ffa5da680d2cc2d6854.camel@gmail.com>
	 <64bfcf02-030d-471a-871a-e7490d74ca28@oracle.com>
	 <db6480e9378f59c367b03f7455372caf7b593348.camel@gmail.com>
	 <ZhmbiFdtYN3tlG6u@x1>
	 <fcaf2c3d2134ae6ecbfbd17dbaa574373ff7ab03.camel@gmail.com>
	 <Zhmi8OEthfzafTIh@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-12 at 18:09 -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Apr 12, 2024 at 11:40:44PM +0300, Eduard Zingerman wrote:
> > On Fri, 2024-04-12 at 17:37 -0300, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Apr 09, 2024 at 05:34:46PM +0300, Eduard Zingerman wrote:
> > > > Still, there are a few discrepancies in generated BTFs: some functi=
on
> > > > prototypes are included twice at random (about 30 IDs added/deleted=
).
> > > > This might be connected to Alan's suggestion and requires
> > > > further investigation.
> > > >=20
> > > > All in all, Arnaldo's approach with CU ordering looks simpler.
> > >=20
> > > I'm going, for now, with the simple approach, can I take your comment=
s
> > > as a Reviewed-by: you?
> >=20
> > If you are going to post next version I'll go through the new series
> > and ack the patches (I understand the main idea but did not read the
> > series in detail).
>=20
> Ok, its now in the next branch, I'll repost here as well.

Great, thank you, I'll go through it over the weekend.



