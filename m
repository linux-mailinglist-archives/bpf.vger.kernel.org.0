Return-Path: <bpf+bounces-44859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586FB9C916E
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 19:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13286B2B316
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 18:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A765818CBF8;
	Thu, 14 Nov 2024 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COUNifgc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A1CAD5B;
	Thu, 14 Nov 2024 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607307; cv=none; b=JJfaLWRcqq03YaZwf1Bs3YuPT9OPxL44WoP9vmGgvy7cealY8vg4PMMRUuuPbQeSaIMtdjSR/KLHk5CIey3M2H9KcLmoaRfDcw0p5IBIAicUtkZwOPCeRDVXiTvqgoNdlUpSTF/U5U5EWbDQ0RqFvtG/887kEuPRpnKHBgWzNTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607307; c=relaxed/simple;
	bh=R9UjnfoPmNE/s5atzJABTFQN3OZJFBf8gjzmCQsw6BE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EN/WLhDcZ3EcDG8zaT0kwlFfb5fm1PLlmei2EbvlPoijubjmYSDaiGxBma0mrEVN7aiXnuN5iRpBB8X3/1aX99gHqGLib9zJ5pvujsXG+29nkWX/rfxCuvJ46HfxidWdPOpun2itpqvZrMwbSKSyhP69pxclLf4HVb5Ofy1Jug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COUNifgc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cbca51687so10369565ad.1;
        Thu, 14 Nov 2024 10:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731607305; x=1732212105; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U2wkoZsIsiUL18nqhfk1WWn+G4es+wJPjlNNRSX0s6k=;
        b=COUNifgcELG+fXl1Qz/AIDdliIWgcA0GGVyf2wubHwHk7ypBpRsqez6IfBEcH5kLYn
         lDwzTiAHwtiGl+W+MTID22JdhDgfdTnpQ7LpT51RVI//rgFcxvk8d24KrDg9aMUvJGda
         kGwiha7lsHk/B2nfe+ERqHjZ85HglMptRC5Zy2Drp/08inerpiGZlUsBI4dvZO+1EXE8
         mvXRCUFJgyU15gwQv55xFyrDdjaYOTE1KKItTUh+hFy9tT5Hn4fPTrSaOO9PD+zcJl0d
         bePEhKrJgMKVNKXYQevu++G9oNrjlk35LDxr8F+G0fsCYtiOGRgFEVnAVjRRW4Tvn1bz
         SxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731607305; x=1732212105;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U2wkoZsIsiUL18nqhfk1WWn+G4es+wJPjlNNRSX0s6k=;
        b=Z2tV5B5r3T8KzGLDpmRvgXZyjYWsSCcgkVTJJNyKqbnKAAnoTjjDVTF2o+WDJl9PeU
         MaApMUbqaYc/fW8uL5d6RsG+wn+mN9Bmva/4Tet2bLVPzYW+8GFZQ84RN4KiNakAp9Gc
         140S1ZF4YSbK42Ewv93yEwBPEepkPIfu2BYceuR5WzMv59UqPqvfopL9c+aV1Zy1SwQu
         cVmFeuLovHXNz+W5YLPBW4apC1UEGMRWTzsUTPPWzaYasqOB3EtV3p2sb5kaZYz5Ln8i
         lFzsD67EZ5Ssu4BJklc8dUMTORXsy24phqTcb4DaYseqA1AwE+p+HzLyVhRAzYAbdkVV
         N3LA==
X-Forwarded-Encrypted: i=1; AJvYcCVfDw/f/lS2gPG+6q0Vz3WBcTBkGM3HBJBQjmvAZEv+yTaO+AI4OG6REYKFj6uhLnaGOWo=@vger.kernel.org, AJvYcCWyrsN+CRcdmhD2FXWos8Ays82+vThmo0dKelLRKdSpKnJR5O2xzBVVUqhs3nIiDw0Qs9s2MoOvAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUf34UEMLZUvbi2pXhreEqGZAhyCGsSrH4gakZWi7fsOif1t/
	aLP09YpkAwibNnmo5EzewNaQC33WwM+SHzv2kxy6LELgX+0qEZlz
X-Google-Smtp-Source: AGHT+IGiexLW5OcozoU1/H0k/g9u9QmAXPYVStVjhgQwF7hhUX/znDjDPMvS0ZBDsyCA2HAe0icMfA==
X-Received: by 2002:a17:902:d4cc:b0:20b:b238:9d02 with SMTP id d9443c01a7336-211c50069f5mr40566345ad.33.1731607304997;
        Thu, 14 Nov 2024 10:01:44 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c67f73sm13524845ad.111.2024.11.14.10.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 10:01:44 -0800 (PST)
Message-ID: <c7c68138b8920e7acfdbffd986cc858008d2eb38.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 2/2] dwarf_loader: use libdw__lock for
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org, 
 andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 kernel-team@fb.com,  song@kernel.org, olsajiri@gmail.com
Date: Thu, 14 Nov 2024 10:01:39 -0800
In-Reply-To: <20241114155822.898466-3-alan.maguire@oracle.com>
References: <20241114155822.898466-1-alan.maguire@oracle.com>
	 <20241114155822.898466-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-14 at 15:58 +0000, Alan Maguire wrote:
> Eduard noticed [1] intermittent segmentation faults triggered by caching
> done internally in dwarf_getlocation(s).  A binary tree of location
> information is cached in the CU, and if multiple threads access it
> concurrently we can get segmentation faults.  It is possible to
> compile elfutils with experimental thread-safe support, but safer for
> now to add locking to pahole.
>=20
> No additional overhead in pahole encoding was observed
> as a result of these changes.
>=20
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>=20
> [1] https://lore.kernel.org/dwarves/080794545d8eb3df3d6eba90ac621111ab717=
1f5.camel@gmail.com/
> ---

Looking at the libdw code, both dwarf_getlocations() and
dwarf_getlocation() might end up calling __libdw_intern_expression(),
where race condition occurs. So I think that this lock positioning
should be safe. In theory, the locking could be pushed down,
to only occur around __dwarf_getlocations / dwarf_getlocation,
but that would complicate the code a bit.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


