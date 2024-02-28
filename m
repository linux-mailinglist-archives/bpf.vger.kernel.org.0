Return-Path: <bpf+bounces-22967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F96B86BC62
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531101C234BF
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804A072931;
	Wed, 28 Feb 2024 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTgpWe/l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F613D306
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164543; cv=none; b=QtJ7Zbqvo6oxk/QquKgXTvIIR1aL94J5rtShMcVMMwZGeafXzzFsHLEi9IdJ0a0bZ88pyI4iz6MOFeC0WdMuuWgKAv2XDgecsWVXAcwH7A4fpkSOQfINOxgDY63rQB6TYA53B3dT1L5e6pBMB/wcbVf1cKUaaMCvNLYeyi1oecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164543; c=relaxed/simple;
	bh=vQ6i5jkAZdIXYKRS053VNQRCFwvVh5/pFQ6JBQ6nTXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iCNfu+cQHljmimP+obcbA+Evth/aHZkuu9Ng6xRhRVu9U41NUBBtf/rTKTVphk2Qr3EAVO7JWuX5XX/iXlwwgpWxb0BtdGKvCFYWHULeKXnwCdRFj0L/8/8/CPJVJr9N4goV3wUxuLJDIwMNwSxUnlRwg2p9YASuViR/TzUDQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTgpWe/l; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5131c21314fso337621e87.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709164540; x=1709769340; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mz7b1wqkVuYpI8Qp9ZM3X1nbMVIpQUwNyot5K89IhDo=;
        b=fTgpWe/lfhB1DmAf4D7KVe4qqcSKy1BkqP48fIdHP8kjvmKVl9VVB9EYt5eodJ2MCH
         MBR8oBcoyEkaR+ATio0nXpHNwJFnrRlczhv4bwq4C4Ki9wTIvVZXHTshPbEFgNlIVevI
         i9ciscpQVKg7iXVzlsd9Y/PePl5XTikPcXTS32tOvDxQm2tSU4bEt5bBCtxvyGSx+hNa
         lfUnIdY6opCi0BygnUV55ntVrqhSka5muJsPX4vUOOseGqBNBfGNwZNThcBtEC3h30II
         EAjW/Z6dwFk7IiwN87VTaqHLVyP7Cv9jpNz+UnU2MEjPzaau+7VMj2HJH7XmWcyC0i5O
         /oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709164540; x=1709769340;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz7b1wqkVuYpI8Qp9ZM3X1nbMVIpQUwNyot5K89IhDo=;
        b=IIYm84Hn+hsa9jGjr8dD5CMsPFau9KLP+J3/JJc7bZrMxCWd1cBCzyRoBv2oALoOBl
         Us8dXOishNEEHIN6Y+v7uENnOInCTEO9lyU5qnTM8OL9EPJT/jLmLOEmX2Rk1oRc4tBa
         rHF7ZorgInHXRChdCP6FvuZhFcaDBk1YOjy6uK5qgo+1zWNK1txFVN9clnf2cEWR/L4A
         2hCdXDNvlXXCcV2vuWt+xrCEPp5HutlY2b2bKZcgdZBB/bp/iQjIA2zDsqg1ReyZFHqi
         wIYvvxNqzb0Smr/acg8b0FmUZSJ1YgHB9Cvgxq96bwSg6T6feqN0LXICmPvhrOrQIatb
         sVDQ==
X-Gm-Message-State: AOJu0YzQ95jEMyrlFIak5GmEeIMK90/nh8dSf4VzgIuIvoXQynJa0z4y
	nG4AO//iag9q1MhH7IaHTJ8xgUyMzTGmwptFczcd2GYC3cUAYGDt
X-Google-Smtp-Source: AGHT+IGHbHswfWU/KYsp/lmZcW1xqaEtOL3W75VNnfvDZQi1EsSJK0q8iwWf27WLpxklyXBX9eQqtg==
X-Received: by 2002:ac2:43d0:0:b0:513:256f:b702 with SMTP id u16-20020ac243d0000000b00513256fb702mr101439lfl.28.1709164539466;
        Wed, 28 Feb 2024 15:55:39 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q21-20020ac24a75000000b0051321139817sm36599lfp.47.2024.02.28.15.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 15:55:39 -0800 (PST)
Message-ID: <d5fda01ecfac47e096e741a68ac8a1d2d726fc16.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] selftests/bpf: test autocreate behavior
 for struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com
Date: Thu, 29 Feb 2024 01:55:37 +0200
In-Reply-To: <CAEf4BzbXzsDUx-dvUQQEMcCVUeUjnBnbF6V4fmc36C0YzVF73A@mail.gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-7-eddyz87@gmail.com>
	 <CAEf4BzbXzsDUx-dvUQQEMcCVUeUjnBnbF6V4fmc36C0YzVF73A@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 15:43 -0800, Andrii Nakryiko wrote:
[...]

> > +static void can_load_partial_object(void)
> > +{
> > +       DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
>=20
> nit: prefer LIBBPF_OPTS() over DECLARE_LIBBPF_OPTS()

Ok

[...]

> > +void serial_test_struct_ops_autocreate(void)
>=20
> same as in the previous patch, why serial?

Because of the print callback hijacking.
Also, what would happen when two tests would set struct_ops for same
attachment point?

[...]

> > +SEC(".struct_ops.link")
>=20
> can you please also have a test where we use SEC("?.struct_ops.link")
> which set autoload to false by default?

As far as I understand, that would be a new behavior, currently '?'
works only for programs. I'll add a separate patch to support this.

[...]

