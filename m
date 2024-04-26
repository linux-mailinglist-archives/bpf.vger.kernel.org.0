Return-Path: <bpf+bounces-27975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DACAB8B4058
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 21:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4352CB24642
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989A72263E;
	Fri, 26 Apr 2024 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l870A80H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB223758
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714160859; cv=none; b=LxYG1x7W99sIjkjO6OPG76/owfZTODwPx5CvLevAEgWOXXCNUb63ayabLDZ0KIQuQeItl7tPXxdMUlpjeZWZGWd5uNDKnRgrKsaUh4ZAv6XwGx0aZlQ1jNOVo3TI1rUrySWdwOhtVRX9Gh5VG+IJKH71xRps04nIlnm8Yp01SbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714160859; c=relaxed/simple;
	bh=WULB3rXefBMZZbYX2AVjlRfPAvcI27FOLHfTP4djEz0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxRXhK3pq0bcn/H+CuF+OkPvRwYLyAosfqetWrqbAFHMsn8YHbXvoBo967+qmRwf7H4fPewIWKI/alyYuoI2YtCgOXqjz/bZkNosC00USTBRTk1iN1Q5zzUf6lRfVXMB3uUNz9727Q01d5ds38+spxIkd2Rbz2qeQRS+FCIaRaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l870A80H; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e2c725e234so29107875ad.1
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 12:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714160857; x=1714765657; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5meOlh6CXHxdnQGA/DTqdv672zk0oJ7XiNRKIDd9fBw=;
        b=l870A80HUvWKMuaBrX1gxtUfpZWBa+le1bwLIAA0AR5OYUiptkSWoVUKD4+6OArwFo
         DlOnPu+MdGnMwdAOS5VDWvj6mWcMA2eMmLwwQYHs8N7lQR+EkWX836BHzldrLowJEQ8K
         qsE3V7vyG050kDV0FdXnRiYvzi6j3wpl1snO3tZjW5rXcwhgUmykJhT5jaa6TdlpGBWb
         c296YXUZdznEUIpiiaDpktyzThTd9u1gJREUDKvParUjhii9psh8c7g61xUsB8X4YPKL
         dYfJFv2zbZGrkhlgAhcFxEbGbz6pPShoKtH9fLeE0PnLb1vzxzPKcJgM/+1WXgQw6tpA
         jd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714160857; x=1714765657;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5meOlh6CXHxdnQGA/DTqdv672zk0oJ7XiNRKIDd9fBw=;
        b=sKVX5IrJtGkuIIisj+snSi++DDb8qEaDRaPneyx0eEj+Kj+7F7SoM2pkyi5C0hbBQd
         DyYVXfrHGgXKz8ZPsCP4aRKCiUNkjK6FMVkT7fG4/whqmiFZomazdhJNHggb1tRn1EAO
         we5cYTJ+oPA3UweNKvMBQmT9qlBE6h1M2whQXoaogu4h/2DOrKHZDZOdWgS3vyGqO35U
         1u832LWikGI9uceI9ReURAHtaC3SNMHn7QBiDMJQmUdE1M5phFEAlmmOhxDm1MNmV8kP
         mYtYZIyn0fTzdtzYVzgAm2qIbSUoJqRxng5NFnNOvNZQXGnSkj0yqNZnMbujNQjzHc8U
         UWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLIQ4Iw6vMa1iUTAYKRYcsb3mP0+KPVwU16ptqlZFMh5TwOyTaBuv3p0WwNDEW0rafw8O7VFhS8wIoMOwbwx/St4D9
X-Gm-Message-State: AOJu0Yx30gSwAs0ijkRCdPiubDjh3gzohi8Z9Ixslxb0ZRm+6rXRcUkN
	f0+Z2Mr+ANs9xhwS2wJIQQr7rvsI5X0m58FLBQ41runsGcVpCRmm
X-Google-Smtp-Source: AGHT+IEZkv3vQG7rfbAJV7HAcV2adUlLOGIwY7LbyOmXub8ZG7xJ6KzJ99eu5t1l7lgK46cf10jp3g==
X-Received: by 2002:a17:903:1c3:b0:1e5:1041:7ed4 with SMTP id e3-20020a17090301c300b001e510417ed4mr965160plh.14.1714160857089;
        Fri, 26 Apr 2024 12:47:37 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:89b8:4c93:e351:1831? ([2604:3d08:9880:5900:89b8:4c93:e351:1831])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b001e5c6c399d7sm16130355plb.180.2024.04.26.12.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 12:47:36 -0700 (PDT)
Message-ID: <c046da5cec91dec15958c894d9a9cb7d7091659c.camel@gmail.com>
Subject: Re: [PATCH dwarves v8 3/3] pahole: Inject kfunc decl tags into BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, acme@kernel.org, jolsa@kernel.org, 
	quentin@isovalent.com, alan.maguire@oracle.com
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Date: Fri, 26 Apr 2024 12:47:35 -0700
In-Reply-To: <1f82795e9ae651a3d303d498e2ce71540170b781.1714091281.git.dxu@dxuuu.xyz>
References: <cover.1714091281.git.dxu@dxuuu.xyz>
	 <1f82795e9ae651a3d303d498e2ce71540170b781.1714091281.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-25 at 18:28 -0600, Daniel Xu wrote:
> This commit teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
>=20
> Example of encoding:
>=20
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfun=
c'" | wc -l
>         121
>=20
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
>         [56337] FUNC 'bpf_ct_change_timeout' type_id=3D56336 linkage=3Dst=
atic
>         [127861] DECL_TAG 'bpf_kfunc' type_id=3D56337 component_idx=3D-1
>=20
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
>=20
> This feature is enabled with --btf_features=3Ddecl_tag,decl_tag_kfuncs.

I tried to double-check results produced by this patch and found that
decl_tag for one kfunc is missing, namely, the following function:

[66020] FUNC 'update_socket_protocol' type_id=3D66018 linkage=3Dstatic

And it is present in symbols table (15 is a number of the .BTF_ids section)=
:

60433: ffffffff8293a7fc     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__u=
pdate_socket_protocol__78624

Interestingly, this is the last symbol printed for the section.
I'll try to debug this issue.

