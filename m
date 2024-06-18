Return-Path: <bpf+bounces-32475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 413A090DFBA
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 01:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D5C1F240FA
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD46153BF8;
	Tue, 18 Jun 2024 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c45zDCcO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2B13A418
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 23:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718752582; cv=none; b=fO5RvTZAsa9ueCFknlxQ3np2i5LwHasYO6Q5i2Xu1Oie5mialplnkfHLsfdsvS/olzD7NDvGiPNZB8H60n+0OqKtomQyKsw5DTVikp8MpMDj+VLOeXkyO8A8tEv/iW/lAvEsHk1UXwWcap9lEnRCsUKI78ZTFYHE7aDPWh0vdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718752582; c=relaxed/simple;
	bh=P09vKwvdRvxyninql8zWczEiW0opFMffbn65JYghNic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jrbPhGMbPPmuCs/NBThgIZkofBhQDCBbK9IvghNc5lLkUKzMyhnHpcslXtGV+Fr/qUenud4LWIFO5YJG4wa6h+5Ab+A4Jl8v+IT4dNEFm0oXNqFgPu88ilXwwX/FLKUGA0fjx/i3Ri3briKntus6TcDsqqz25W6AHhj3aevaLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c45zDCcO; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-705d9f4cd7bso3682015b3a.1
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 16:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718752580; x=1719357380; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P09vKwvdRvxyninql8zWczEiW0opFMffbn65JYghNic=;
        b=c45zDCcOPoWCCqIBNsY/yqU3ufrHDf9b9wiHqpnn0RtD5u8nV04d+3hbGuUUyS1+id
         UuFsNVW5xlyRl5bCAEaMVMDHjKhmEhh9XqncBSIpdepOVR2z88VwuT0BuZRl3vkEaqXn
         BFn+vbCJzVI/hU8YW/jPPpUFeYS4HEWzZXcaSwga/8QbEy2RH1pkqIGCjXwmMbHIW10u
         R06vDyGyzQY3Gecu+mABvlbPGQFpBmFaN8NiLcffEMtoZUukFd2sV1Kp3yBDESLqq4fu
         QVvBVHKu8glsM54PKcw3KOxCyjq30OGfuR0S+CeF38f9WsWNPQ8E7Q1TU0QsqlWlbyAS
         yUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718752580; x=1719357380;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P09vKwvdRvxyninql8zWczEiW0opFMffbn65JYghNic=;
        b=ClQwQffPI6Uw09ZE1wo6El+7S3+t6+ojGeGUwZj4UfIhsnJgP8nGW7s2uxgOn0nAXq
         lVv19ctiOZgDGvTpDEd8hTZorirrNshfZR3e/NRZuhwak680lw1ChIMF1XJWSiIFW5lK
         zacNTFCunaMsfDaXrN0z3qH1e5O6iqUPTYMbahVUD9l8mDKbyL+O2RRAtd1Snakmt0Sl
         fhberV4STKny7UtXVlHoswB1XH6GGoYgBqUN8h5os8fzB3+/96aWIMmr9mD8kJEhPJ6p
         N9rMsE0UPtbAaJfjCVmA4mloZ+Ls4AHbR6M/14E0BZkvUlWzDo+vp9WesELpJaVzSxb4
         wEvg==
X-Forwarded-Encrypted: i=1; AJvYcCW8QN502JpG7wxBhreedSczKAUK9uyGsLZHpYbLrChtFcBZvfrYa7IDM6gVUpI164/qLa64098YBgLXuH1G3/v6LQx8
X-Gm-Message-State: AOJu0YzAWeZUJPpwXdUqsVs1R0E2DtqA9L7FZvTMW7vxDc3E9Zwl0PJS
	DAW6OARsm0oyJjlYxITtwaXo6UJZUHuX2GYlSJrsDW17WdOkpIaJ
X-Google-Smtp-Source: AGHT+IE9RuPGSOB1Lfd5w9u7xyqGKTNHZf+j+QxgypUxjE5RsG1OjHOpXN6GDLDrm1hhT4whPDNzfQ==
X-Received: by 2002:a05:6a21:3288:b0:1b4:efbb:d1d3 with SMTP id adf61e73a8af0-1bcbb6dfba5mr935826637.51.1718752580094;
        Tue, 18 Jun 2024 16:16:20 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96752fsm9448987b3a.50.2024.06.18.16.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 16:16:19 -0700 (PDT)
Message-ID: <05449fe120951ff8c02f96e20887348db1f505da.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/5] libbpf,bpf: share BTF relocate-related
 code with kernel
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire
	 <alan.maguire@oracle.com>
Cc: andrii@kernel.org, acme@redhat.com, ast@kernel.org,
 daniel@iogearbox.net,  jolsa@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev,  john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com,  mcgrof@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, 
 thinker.li@gmail.com, bentiss@kernel.org, tanggeliang@kylinos.cn, 
 bpf@vger.kernel.org
Date: Tue, 18 Jun 2024 16:16:14 -0700
In-Reply-To: <CAEf4BzZbn9-=7w8A99hkVFT1wKZ6LicBYSu-Z54Tb-eG7r1ffQ@mail.gmail.com>
References: <20240618162449.809994-1-alan.maguire@oracle.com>
	 <20240618162449.809994-4-alan.maguire@oracle.com>
	 <CAEf4BzZbn9-=7w8A99hkVFT1wKZ6LicBYSu-Z54Tb-eG7r1ffQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 15:53 -0700, Andrii Nakryiko wrote:

[...]


> > +# Some source files are common to libbpf.
> > +vpath %.c $(srctree)/kernel/bpf:$(srctree)/tools/lib/bpf
>=20
> this is something new, what does vpath do? (sorry if this was
> discussed before and I missed it)

I was unfamiliar with this thing as well:
https://www.gnu.org/software/make/manual/html_node/Selective-Search.html
basically it allows to add a directory to dependency search path.
An alternative would be to make a soft link, e.g. like with
./tools/testing/selftests/bpf/disasm.c

[...]

