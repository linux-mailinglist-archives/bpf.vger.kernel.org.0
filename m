Return-Path: <bpf+bounces-70317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6022BB7B42
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 19:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983AE1B209D0
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A213E2DA744;
	Fri,  3 Oct 2025 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEIn+btG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE56C23AB8B
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512162; cv=none; b=nwuxWhjzpz55CDNF2xJuQzSbZCAyffnGVl5ox2Jo6LgvAt5EwWuoNltCulvYbUDjrxkrr958hJPvEZSZzYv5OP4WdE7io9ZthWbGNMZ3HQew3MjzqJLbjyi5PBA1mV6/JLbuUSO/fH5wq7CxUzaBcjukU2JDW5AWhr1ekI6KAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512162; c=relaxed/simple;
	bh=ZuQz3CJTDu+J+5413xj7FHoXTTs2tGONgXCfRQObPgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hQ6pqflKlaknmBNX+j6wc3sSdGc2a7zI4xXsGChHiggoiGdjXtebfRWUEyjrqzu1TWUG3YDKAK1pGv5OLJzU9txU5pmG5LJytCKwBi7MAqXEd/LT3+qbYrnTtiwcKZW/FV/cujD1TTzjH79mxuYrHW1UAxwX4Ox38KGbT/Wcits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEIn+btG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso2201899b3a.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 10:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759512160; x=1760116960; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BYGZUXANdnLNXjf9WR2U3LkhmaZwsJwEa/PCxMnSO0w=;
        b=lEIn+btGXUB0nqhX/gKUNiqY/6vUxjDRn2F9Oev7A8QANaxqzcbdZL70J30ZoS3SHe
         Fuwk9f8GLnVHT5G9azI/CRAIMlSyJaAnscROv6mLog165sFLYRCcHiS1WnuhQLDUYUAA
         q+/UCvuDXmVi7Gxf1CvEpqk/6gd/u0QajbEKE2Hb6jqz7lOXkNIkvEZ7TdnKcTYEwS3u
         IrZOB2QZriluHdunpOK+HaTRG7xZ6iVNCHUkpn+euHimxAPs/7IW19WU5JBfFNBNGBIz
         J+Sf7tWfhi+W+tqG+3iO2I9a/29i4YSYv2PdzcuFsNrjpyT8NPgZsQajxxt0L53aiLgW
         bcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512160; x=1760116960;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BYGZUXANdnLNXjf9WR2U3LkhmaZwsJwEa/PCxMnSO0w=;
        b=CqlkMlI2QrqgI70RYD1R7dcfBbYASmqPYHXpzAfcDVCp9lhpuX022YPT79dfODX+IB
         +dyEr2s9QakSDV4qqvLArT6G5aXAnenIZac62idk+dglwRLIytI8pwomrJxQ2dD5wqqx
         RbZxK/+tG7Gft9T5DY2M3UmzShpbLC2rdNgxKCmVRRRlb6SvPKEneZ3d6lreHs/goRHC
         wHX9YHpgmDmRG/ai7rkra92yTL0gFVK9XFsOPdyoBOSzA+tOy3P5R7eH0xdrJNzYL3Uh
         7l9FAQjk0g/XtUVNHtdASkOPovQyj57rOiqZYekZAkojk+PpR9PJHmtv3uCKI/TwM42D
         umGQ==
X-Gm-Message-State: AOJu0YwMv7X9wmm7gHG5+uMLNWRTwEq9JPTHo7N/Uti3HaSsdmYFMpsI
	F0b+z+AqLwN0rLNbUfNltayOj4OzfuQU+Y9P75PpMkLihvoYbwVL4XMB
X-Gm-Gg: ASbGncsfx/e/mA34f5gDvKPTyfpKNq/Sm4LUSGrRxh0qKGKwS1dlaP/qU8hJN0Q/m1c
	mEBatxefo0LWJK/pmyFIO64KY1wm0tFzyfEsxfMYFZ84by5TUXLrCV9FUiG02egeqVBB11XvV08
	u3i7eu4S9cWhY9JELeXiTnWrhbOSylvCFLTVb0ZMx8ht772V8k3UMxmvi0uDR+CUnw53Bn80b96
	o3P8l8ANMepX7l9K3oCA8c98Hpqy3J7kFqGioX2C5kVq0PnEYcXCTsnndN3mKLHHQo4p8mFOc2k
	9w+TOssPKCz5Ic8lximqmypNub1SJMT4dx5iucpsfTenC4mxnyxMxAHiJlDp+iMNxEVKEQZKwQ3
	Rv9tiVlRtZ4ES9XFUiX4i+zXw8Jz6EA8HmCuFsub7FP0doEdlPjktagnhAnTwjTBhPmsJaEDu
X-Google-Smtp-Source: AGHT+IF6aUkdJfCT4YwHJRlJq/rKk5W9mhyXE+VlezC5JazFPjBhr7ZI0P3lalwhTTetUmfXZ81/3w==
X-Received: by 2002:a05:6a00:4650:b0:781:1d38:d571 with SMTP id d2e1a72fcca58-78c98dc19femr6321142b3a.17.1759512160045;
        Fri, 03 Oct 2025 10:22:40 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206e814sm5399918b3a.68.2025.10.03.10.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:22:39 -0700 (PDT)
Message-ID: <a2aa09d003e61e9b6ba00c5a766c692d1a0a4b7c.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 04/15] bpf, x86: add new map type:
 instructions array
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Fri, 03 Oct 2025 10:22:37 -0700
In-Reply-To: <aN+TtaajMJ9uPgN3@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-5-a.s.protopopov@gmail.com>
	 <7f2e28c4cee292fb6eb5785830d5e572b7bd59c2.camel@gmail.com>
	 <aN99rP7iS2O0kJMN@mail.gmail.com>
	 <83421daaf2db3319b12ab95bc5406b4d5fc7c076.camel@gmail.com>
	 <aN+TtaajMJ9uPgN3@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 09:13 +0000, Anton Protopopov wrote:
> On 25/10/03 01:48AM, Eduard Zingerman wrote:
> > On Fri, 2025-10-03 at 07:39 +0000, Anton Protopopov wrote:
> > > On 25/10/02 05:50PM, Eduard Zingerman wrote:
> > > > On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> > > >=20
> > > > Overall I think this patch is fine.
> > > > We discussed this some time ago, but I can't find the previous disc=
ussion:
> > > > would it be possible to make this map element a tuple of three elem=
ents
> > > > (orig_off, xlated_off, jitted_off)?
> > > > Visible to user as well.
> > >=20
> > > See https://lore.kernel.org/bpf/8ff2059d38afbd49eccb4bb3fd5ba741fefc5=
b57.camel@gmail.com/
> > >=20
> > > In short, this will make the map element to be of different size
> > > from userspace and kernel (BPF) perspective.
> >=20
> > But why does map element size has to be different between kernel and us=
er?
> > For internal use there is an `ips` array and that has to be 64-bit.
> > For external use, it appears that any structure can be used.
> > I probably don't understand something.
>=20
> I think that map->value_size is expected to be  between
> user space and kernel code (verifier). For this map we
> use PTR_TO_MAP_VALUE, etc.

Looking at the code, it appears you already changed the only place in
verifier that cares about map->value_size, by introducing the
map_mem_size() function.

All other map->value_size uses are about value lookup/update when
communicating with user-space, and thus need no modification.

> But before diving deeper into this topic, what is missing, really?
> The orig->xlated mapping is easy to keep from userspace, if needed,
> why is this not sufficient?

It is just more convenient to have all three values at hand,
The values are maintained by the kernel anyway.

[...]

