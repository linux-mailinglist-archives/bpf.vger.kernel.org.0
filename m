Return-Path: <bpf+bounces-73736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A50BC38256
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 23:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD51F34F3F9
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 22:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39242EFDA2;
	Wed,  5 Nov 2025 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1ks+Q7t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB2B287505
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380543; cv=none; b=MNmMM63NRKhBd/glZXKzrIrdtSWUdxOfFLAm+rqGE87Lf8HM1xO5eaed5WGTxumyxV3f/bigyK3xq6k5GUU1sTOdzSHppACWNGXqaM623QTS5c/2gZgwU8zeMJ4+1aNf7XCOFQar5Hb7vuxd3hes9+KH/UIpJq01C0vI0C/ZbpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380543; c=relaxed/simple;
	bh=KgXp3nCnzWJkka6TIDbKkxCGzc5iLi6go3oc5VGCLSc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kTsrhT+Px3rts+q9J52cB8MtAbIheIfH5Fc1kd/p5UJYY5L9d/b9wMBlGlKKrX/D4MrOH5ti2NGvn8zlZmJcyPAOpb/oL7ySRBT3QQqnxoQHWckjltbGlZIsF4bj2p+xFaeDCi8oj8148sw1c9BKALfWasgUhDgCF5VCNB+8SF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1ks+Q7t; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so340445b3a.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 14:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762380541; x=1762985341; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8+4iq6Nh86L1GZyal89LrHUzhbwe/7RnJqO8ZvkHHtE=;
        b=m1ks+Q7tcLohYFK1Dzo+hWdx5CmHrHwbBoqjjhsgJRTaWmtdiTCZChkUrbaWpneBtv
         eJXmAJLuVOYwh0+4LO34KowNDrReoK37Tg3l6ea/KJPKVwbcMkYBej4ol9zL3iSWF28S
         i2IAm5NkcX3grf/41Jx6a4EheZLnMvrnHBMopbgq8a67tH7smqqCNOMLQ1Hp5bO+gCC5
         Bfhfn8+a5JVgit3WBiezQACOfIsVDX94j1LHrPoXSz8R6+V1KGONOH8JQnMW+/5looJN
         FwUIgU/3I/ULSOuCtHWAfg8yarPGFTIGO+MdP43GiOpdrCoqwFn2Mn361il5x7VOW9Ci
         GzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762380541; x=1762985341;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+4iq6Nh86L1GZyal89LrHUzhbwe/7RnJqO8ZvkHHtE=;
        b=O5HngdFtcnSJk5X1z5XPtFUOx5nySox96aL7C3JF6lK0+3AMgsKylQa7Yqxv5NAvJA
         GJWqF/AE5YraumyGQarVmQK9t9Xn8nTkX6nhuX22Aa0MhSWMRjUI1LjLeYoYKmzY489O
         6IaLh/thGmJUGpqjE6bJSJSkR71eky0KA2FaMCeftAICR1hLUCy/wfglIEF78ferZtRo
         mOL+4A3uNMerfx6BX5ziAQi26igqQRFcSMTdgNMgm1ww23wM/YfHrtF2tegNqzTxO2tY
         1UIzSTpINvTuXFvgCrhKOH9L+3MFb5fGLBaIgejxDWLY+E0l8bwxTm17Kjn53hIbVg1N
         oKtw==
X-Gm-Message-State: AOJu0YwSBRrq2c7wHOxjKpJj54k9dlIz2WPSiLOFkECAVEFmJy7mk21l
	zRgYM0N2ApgOgMlCBVWCGFPygZGyT4ZGaSfcqmPLfCEoSyrSoHn1T1js
X-Gm-Gg: ASbGncvSDbHBOzKOYdVzQo61zq1CZWKyHvxcynRsS5f8I55FyUeKZRCw1bi2BI/VN2N
	1NsXBTjtY+SsJlY5B7UKfFYDljzbrEftdd17+Rs3ZZRs2fQsp7HEZlCde6DiZ8Byf/Qt9V0rYkm
	4bjR2q/FU4oKT/i+xWFdvTJLiOykfa17sveFVdbBniVX1BYVIeMjhpXqv7WWdSFGNEfgZqjP2ZD
	fFYV+AaHbJDQuAFvTQgCmMiCXzjLV7bMnGENAc4dxXh8pT8QEkSba19F5hu5vOXuM7Bpsmow9GE
	y09eZHB8AxxIjw4tguSAGT6O4J5eBMj5+JPpsk4mvHpoFCSzSoTc83e5nxoqWMA1nztBGaAc/y+
	/QoROckd3eKkayMA8HV/LunE52K0g6o+eJxef5rAt1uK1KRl9uLFqbbR8ADYwp9aft4jk/niJ2Q
	gNSTn5Ouk7z/Zj0mOCUNXoZkE4fhOkr1Xik6U=
X-Google-Smtp-Source: AGHT+IENaFQ323oqHXktoW9GYmrBP/FWVmxzB76vnO2zIMZUBVCvou6g2s32dv+DxPvmfdHEzD56lg==
X-Received: by 2002:a05:6a21:3e07:b0:2cf:afc1:cc3c with SMTP id adf61e73a8af0-350de314257mr966411637.16.1762380541043;
        Wed, 05 Nov 2025 14:09:01 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d11e2336sm84997a91.1.2025.11.05.14.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:09:00 -0800 (PST)
Message-ID: <c251bcb61fb1ed225d2ad1b0d865f4b4bb7ffb5c.camel@gmail.com>
Subject: Re: [PATCH dwarves v3 0/3] btf_encoder: refactor emission of BTF
 funcs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	alan.maguire@oracle.com, acme@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 kernel-team@meta.com
Date: Wed, 05 Nov 2025 14:08:59 -0800
In-Reply-To: <20251105185926.296539-1-ihor.solodrai@linux.dev>
References: <20251105185926.296539-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 10:59 -0800, Ihor Solodrai wrote:
> This series refactors a few functions that handle how BTF functions
> are emitted.
>=20
> While addressing comments from Eduard, I noticed that we don't
> actually need to carry the encoder in btf_encoder_func_state, because
> only one encoder exists at all times. So in v3 I added a patch
> removing encoder from the state struct, which resolves the ambiguity
> of where state->encoder should be used.
>=20
> v2: https://lore.kernel.org/dwarves/20251104233532.196287-1-ihor.solodrai=
@linux.dev/
> v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.solodra=
i@linux.dev/
>=20
> Ihor Solodrai (3):
>   btf_encoder: Remove encoder pointer from btf_encoder_func_state
>   btf_encoder: Refactor btf_encoder__add_func_proto
>   btf_encoder: Factor out BPF kfunc emission
>=20
>  btf_encoder.c | 204 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 117 insertions(+), 87 deletions(-)

No difference in generated BTF with my test kernel config.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

