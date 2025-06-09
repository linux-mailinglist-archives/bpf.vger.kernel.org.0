Return-Path: <bpf+bounces-60105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73510AD2982
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 00:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BFA3AD7BB
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 22:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B23F223DC4;
	Mon,  9 Jun 2025 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q35I9pkR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EAB1DB346
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509137; cv=none; b=eURx94NPcyhUlW233Os9uZnMc0I0UMKCq+nNL3Pnwrie64dZ43yDg2YIlhWicPly3AYa+V/nOa7PnEuyf6uBHSzErXRNCYbQwK4PlFQibZ9nQZBOBRf8olkiSpgFaZqfPXtHuvPLHyIsW7FvYdJzyp0IHktgaW11kPj/DlX3qrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509137; c=relaxed/simple;
	bh=vH/MooZ5PQFWNCXmmmKCzI+9a2tQwCb0fecgCwDKAKE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kTX57FdU1HXNuEKzRc8aUZxXHZcSBa3JkK6Nw45IjmREC2pF3BEyxl5rI9wQEKfSVN4mJfMTo4DP2ahGkweMtK/bmrAjKhAnu+CnV9ulkbmsSKaEpTnR+MTNqDJEArKE+daI/rqDXyGFFGZC0Nfu60ZPkpL7r7rh05GcIqpLqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q35I9pkR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235e1d710d8so58661685ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749509136; x=1750113936; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vH/MooZ5PQFWNCXmmmKCzI+9a2tQwCb0fecgCwDKAKE=;
        b=Q35I9pkRBVSIzG6zIuZ1VXLDkYppv0JB3dvol4SGHKABYq1AvNTB8Um+HZyx2nFCLH
         Wdi9JqBz+82kVeuoJQKDJIglno5GFNzbnS3LIjxdaUM2YzUPrQWygoshec0PODgDVsaQ
         zrQbiRWQORrbVpkpPpmboetlU1PCu67wRgFSrU2kdOuwxWU1/yXZ87L+qZW06N/vM/ga
         M0gMk6wL0gCXZbdKTG5oQQ1UQh9feeFQB3o843fV9WHqMAEI/RsDbuNDQJnASJLnU6vE
         I5F3MJLtkXEyidIzzdUhrTc6juACVLLywAF5qStJsVhhBOszAGqQ+qLcFPfX6enBLevV
         mB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749509136; x=1750113936;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vH/MooZ5PQFWNCXmmmKCzI+9a2tQwCb0fecgCwDKAKE=;
        b=Z3n16gVCFP1R7CFa1mu6wg9pVKhVPrX9OfZNIIEf8apWW6jSE5k0gktr6m3hlvGjSD
         C4R/1heY9vN87c98KR8YhYBBXvaUAzEN+CykU1y2mrTjC7fr9q8waFTchde1yC+1FeB6
         aWysoghz4ga1IspWFw2XX3yY3mOPZvJ7WO3V2WNM2WhS3z3Z1lLVsLlzNswFhrVQXD1y
         JOm/pZvK5eMMnGpEFY83j1KiDWTzGOcapH4CRP3ZR6PZGU0GA+JYFsU+aJm0GzMVEDQZ
         5C7xZMjjmUOe/Ba1yd5cot5YIpvwwNmrw7ojCpeaTFxck9MFIIMoJMiALr0+3feP9grt
         5psg==
X-Forwarded-Encrypted: i=1; AJvYcCWJMpb4Dqi/ipSWYl14w3kTvXSQq/TvG2mgycDNCzIeu/QUmhuxw54hLXDPouhsvgkZ/UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzukOz4cgx23/RzCLOZSUb5Vl6AEynxrlX4+Llx8bd4hFrAEhkP
	Z1xx6OiSx9+uNFv+dFbOyHmj5cy9whVMIB277b1KNdpJGCMZzDnw8KyX
X-Gm-Gg: ASbGnctzXCvTyq4QIIQza9dQCJDxDzFUglOkIimS/9mx+6vvSFhoirkD+Q23BxfQN3g
	Q/Wd2cAK5wvet/PyVUwGX5NP2ukTHfwT1jF8r8UGW4Zl8WUr8ZHPvfciPrx1D1BjsSPd2/zVVSm
	QjI+TQ7tdpV1jwo5D2/rFDz/I1qWJtSWvG70E0/OZJKC/L3T9ZfJw1igILYBc7hk1EUTPDaH8hP
	sN7j31TsqC2DsTXKNz+UdyrInEZsUyj4/xowiC4LjQjChXPUWVjnqEevrIGnJ5FHDLbYuQb1wcZ
	pwa6pTrfPhtM50JcmL4QUktzpezMK7vXlNc1zm9YoXRB9kMkN1uYUtgg4dgKgyJV7ZJU
X-Google-Smtp-Source: AGHT+IFEqIysfQVsjLbmr+7kOaPqgRddMKUivfxFdMl6a63QEa1fMh1lq6cYvR8jkJHpxCLOVWKQ3w==
X-Received: by 2002:a17:903:3ad0:b0:234:ed31:fc99 with SMTP id d9443c01a7336-2363829d116mr4284085ad.21.1749509135800;
        Mon, 09 Jun 2025 15:45:35 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:6ea2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032ff365sm59543055ad.130.2025.06.09.15.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:45:35 -0700 (PDT)
Message-ID: <4a7fc3484d51e7ed2c2a10bcf4ed4db6425d8b8f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] veristat: memory accounting for bpf
 programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	kernel-team@fb.com, yonghong.song@linux.dev
Date: Mon, 09 Jun 2025 15:45:33 -0700
In-Reply-To: <CAEf4BzYHvPBcG+eUFh4+Rbhzfw=_937BgCv7ZGKcbABhrjYCZA@mail.gmail.com>
References: <20250605230609.1444980-1-eddyz87@gmail.com>
	 <20250605230609.1444980-3-eddyz87@gmail.com>
	 <3dd16f19-63a4-4090-abd0-9b84fb07346b@gmail.com>
	 <efe0cc259f70b11ffd3e398441efd0de5aa98c3e.camel@gmail.com>
	 <CAEf4BzY2CzZy8DMe==F7OmvEO2gkGG___SaZgu8dGDJd4LG4_Q@mail.gmail.com>
	 <ae7b709f618ecd75214e62f2a300fe2949d9b567.camel@gmail.com>
	 <CAEf4BzYHvPBcG+eUFh4+Rbhzfw=_937BgCv7ZGKcbABhrjYCZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-09 at 13:57 -0700, Andrii Nakryiko wrote:
> On Sat, Jun 7, 2025 at 1:13=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m>
> wrote:

[...]

> > Given above I'm inclined to stick with "many cg" approach, as it
> > has
> > less jitter and is reasonably performant. I need to wrap-up
> > parallel
> > veristat version anyway (and many cg should be easier to manage for
> > parallel run).
>=20
> As I mentioned in offline discussion, this 256KB jitter seems minor
> and is not on the order of "interesting memory usage", IMO. So I'd go
> with a single cgroup approach with reset and keep runtime quite
> significantly faster. Mykyta is working on a series to further speed
> up veristat's mass verification by relying on bpf_object__prepare()
> and bpf_prog_load() for each program, instead of re-opening and
> re-parsing the same object file all over again. So it would be good
> to
> not add extra 18 seconds of runtime just for creation of cgroups.
>=20
> FWIW, we can count mem_peak in megabytes and the jitter will be gone
> (and we'll probably still get all the useful signal we wanted with
> this measurement), if that's the concern.

Ok, makes sense, I'll rename the field to mem_peak_mb and go with a
single cgroup. Metric would be zero for small programs but that should
be fine.

[...]

