Return-Path: <bpf+bounces-75297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317B5C7CAE8
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 09:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E793A79EE
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 08:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49127FD74;
	Sat, 22 Nov 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ23pzJv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605CB1F09AC
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763801413; cv=none; b=bkDegnnJpZjAjb1RkMLwpOCsWsjlJ+Ts7KXldeBGf90AsAtu0bd0/wncQUNUazsJJPyLzMRIY3Ovx82s3MU0htEEmiAZ+w8YTMzmQ/7iOBqsJ7EJ/ixVHfBcvGiJdBUutU32FzfZfY3pXbjtQFYtk03fVgheADAOPmDYOzw+jzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763801413; c=relaxed/simple;
	bh=JYpUk2d5LVEVvLeynM6oao2GwY6qr8tahYHhHE+OC0s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IgIX89HU8SX2wRhNBcFEgiOYJbxXH/C9mBsDFMmjDqMkc5DJlJlGOIIca/d6hTGtqizTAoKmYElCdjkyM7/VZV4xg3GTzeZRUqDe3BKqzsQfKjtCw+T7GWizKQJFlv7n/s8goO62OEIgZcL6nqHyBRiMXURihzHW4fcGFrws9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ23pzJv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso4225517b3a.1
        for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 00:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763801412; x=1764406212; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JYpUk2d5LVEVvLeynM6oao2GwY6qr8tahYHhHE+OC0s=;
        b=dZ23pzJvVqq8IJJzg9AWrcWVD8ve7KvE1A6CkBkpyhTyuBrBnLD5lXu0CXUPQv/UYk
         piynnFusOC//f+k9p9jz3TQs1P+Fl4wqedBTEnhdsqUj5i6nd5MSIXzda970dWTZjeol
         /y3D3wh+Vt5/4hEKvaAhJtSsBrl8yhSGB6KLVoFTWpK1H6E6NUU9oQBsKQIM0aGsQrPI
         T7/2xAPmsZlQilS8SfxvncGG8Ap3CeQaw6z/wSbyUcFXdNZCQLUZjmJueFCGN9x03MVv
         PCHb24PpQmsha6PmAB0SblM4M/Z67aJb14XU5ZbEKMV0tgkrT/IM04GC7+ul1kj5Fju6
         ra8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763801412; x=1764406212;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYpUk2d5LVEVvLeynM6oao2GwY6qr8tahYHhHE+OC0s=;
        b=KqGheh8Pyn2FbYSj8jm0SmTKlImj8u60fRTbtrCXswTBfG6Hmbtm270QnY+A0DbN3M
         LLilU9jHQSOBjetQwOUfcl3Tptdc00u82HA3Ddc1rVTKjmYbEEB858H/Cu08KXsOqdO+
         k7TyK6dOhSKvdfiDRDjyVqIdHzEwkeUIg1EWgiTf/ngtrxinhUp2PfJyfvnyFGSTtmG4
         8gyzTauz5unz8cBbiu4JL235ZRAwF+JQIf2/rqQKx7dGvTOgYAOsyJP/shXSoOuKZwMI
         yDetn3sEO6GBBQOP5dsrjrZv5Mn4bpoRZKAp1wkYFt8fDBvbPR5fzxFNQ//KyC1jsJT/
         tfYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWFAFq/DW+4gZuBB+qBDeA7pGx1NId5iitzERwnoDWU4m89e8BNNO09DWjYAxQv86vb8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+qsetk/RVwul0TiepN8PnV0TRZNc+VWBzg2g609w5yzosBxn7
	MkTZQ4vfM3ykfZwMjbmHSOjwabejlxzoEWyOC8NxOpGM/ZIgPCREcTNf
X-Gm-Gg: ASbGncsZX1Rpl40kvfT6JGW2KKn/cM8GA+NROvvDp/zEEo7MWMhwOcE7Icy+OZumQJz
	SQBGXN0JuTJgJuvR2zuRSVWBYP7Ob7tMdWW1KEmrIg3e53kcQq3pqDv8FiZfgN3NB/z8QForcA3
	C985JbhPeAS7j6tEmQmBknV7RcXR1DOp3W2bsL8GN39D+xgfWLV1Y5ntXBI+7Lp1ReO8Zce09Kk
	UQ0RPoh7aTqASUW80NcRDNaPSngHHPc8jPqSx3ww7b36o5Yz/6FNE4vQMObfgys2vWto6s+RMtE
	zRs+8VBUSvE1TZ7dvB+zn4VqYF/u6s9TrLozHmIa6m2m2Cs+2v/lp56/obDyjuUBG3iAGoLxPcy
	nEqujXv8oYq682c01wgKJ1NCa2RpiY8jGkZZYoyxD99Bde4svocogncmiG4PUnkFMfdOyM7V0ky
	UOmFGeQQI=
X-Google-Smtp-Source: AGHT+IHOtvBb/gc+kJaGK3biLyQeaMFA39gCQxyG+kDUtS7sNw6EMd06A4LyWaC8dVZwQA4xyMu7SQ==
X-Received: by 2002:a05:6a20:5491:b0:35f:30ff:89f1 with SMTP id adf61e73a8af0-3614ee85318mr7246761637.56.1763801411603;
        Sat, 22 Nov 2025 00:50:11 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760ac633dsm7722798a12.27.2025.11.22.00.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 00:50:11 -0800 (PST)
Message-ID: <f515305c3b250f9dbed003b98d78f72c3d72cc2c.camel@gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting
 validation for binary search optimization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, 
	zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
  Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire
 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>
Date: Sat, 22 Nov 2025 00:50:08 -0800
In-Reply-To: <CAErzpmvP41CNQhRVKuDU23xnBKjj239R6_e5K8DSwcNDo7GG5Q@mail.gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
	 <20251119031531.1817099-6-dolinux.peng@gmail.com>
	 <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
	 <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com>
	 <bddc9f1d5c1f2f7f233707cf2af81a2013d46b7d.camel@gmail.com>
	 <CAErzpmvP41CNQhRVKuDU23xnBKjj239R6_e5K8DSwcNDo7GG5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-22 at 15:19 +0800, Donglin Peng wrote:

[...]

> > - find_bpffs_btf_enums() - this function does a linear scan over all
> > =C2=A0 types in module BTFs.
>=20
> I think putting names ahead is helpful here, because there is a check
> (info->cmd_t && info->map_t && info->prog_t && info->attach_t) to
> return early. but I think it can be converted to use btf_find_by_name_kin=
d.

Oh, sorry, I somehow missed the early exit here.
But as you say, it is a combination of 4 by-name lookups, essentially.
Thus can be converted to btf_find_by_name_kind() trivially.

> > - find_btf_percpu_datasec() - this function looks for a DATASEC with
> > =C2=A0 name ".data..percpu" and returns as soon as the match is found.
> >=20
> > Of the 4 functions above only find_btf_percpu_datasec() will return
> > early if BTF type with specified name is found. And it can be
> > converted to use btf_find_by_name_kind().
>=20
> Thanks. I=E2=80=99ve looked into find_btf_percpu_datasec and we can=E2=80=
=99t use
> btf_find_by_name_kind here because the search scope differs. For
> a module BTF, find_btf_percpu_datasec only searches within the
> module=E2=80=99s own BTF, whereas btf_find_by_name_kind prioritizes
> searching the base BTF first. Thus, placing named types ahead is
> more effective here. Besides, I found that the '.data..percpu' named
> type will be placed at [1] for vmlinux BTF because the prefix '.' is
> smaller than any letter, so the linear search only requires one loop to
> locate it. However, if we put named types at the end, it will need more
> than 60,000 loops..

But this can be easily fixed if a variant of btf_find_by_name_kind()
is provided that looks for a match only in a specific BTF. Or accepts
a start id parameter.

