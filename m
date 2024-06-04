Return-Path: <bpf+bounces-31387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580918FBDA2
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 22:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5EF1F2486D
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F19914C592;
	Tue,  4 Jun 2024 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7DLNT2o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCE514658E
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534595; cv=none; b=D8Y77p/n+pWgLwp2O78qD+YpyRcxAAL6M45+X5hdNcQPIXuPlH3aMdjtl+rfadOQLjIgEgXUpVozWt7z2BenbdXohceiLAn7AVaSjycB8EGfgH/HaEaxZePqZAcCLt8uJ/Le6Dycr6LWbeajcsBTw7lkKNeGIDxd3nInr7UVX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534595; c=relaxed/simple;
	bh=uGxXP4pIrKsI6IuRaqbnlx/Eh8rlLObCHGPARuWlJJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lXduULW1mtOesCKGPEh0NapanckXWtE2sGgG+QEGNYkA8ybsXBj3QZAccK1SI0tyZ+2S0IGR1DBajWOfy6y211+EUvjftrOPu6kwh3L6K+jQABlEt2lWWePTleBqdnYNP8XsqXCgal9eY371NuAhlZWZrrSWuxlwqPmBtzsAT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7DLNT2o; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f65a3abd01so27662545ad.3
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2024 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717534594; x=1718139394; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L9qS6ygE7bA1nsCmj3ZKwgsAb7CnTpkzelMJSxBwiBE=;
        b=b7DLNT2oK3BCUuntSLCRZnTHCU4zkLUjmh37UwTgsg/Xb8vXbVTJiObbDcegRUYf8s
         7q+y/Ie6ZCWRjVEsQRTEEIQeBMPNu6fZ115CTQoYERSsO3rylo58UUpQdKUVEsZ7lhNf
         F9pyxU8giRRReckV4C2V85M8irV61e6D6yZlMNaapRUQ3JsOxDiCE/QBuhJEWyCiPpHR
         uhQEOJtQ/m1aNGgWpXpR74SE4vNyAWsFriYpVH3cI3y7wZban66L+Og18rb2LgpWcEOo
         odOyQcVNA4cJjbB9gNisnNv7x9yg8ApVtB/6iDV3R0jyeYv9+P/EYvGaOuuaaUqSC518
         GmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717534594; x=1718139394;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9qS6ygE7bA1nsCmj3ZKwgsAb7CnTpkzelMJSxBwiBE=;
        b=hiqucUngL7XTtx+LrZ2BxFM6tJJv++YYhYbxXHogrWLMDDVPqtX5MjD6J6faHq39gN
         z8G4htH24R9ig3kv3VhtplKR7i4N/Fb8drl/1n0RkGj8VJme3DB9Ci8xQVaLR4PgePws
         i97m73x7uEBlCGRWsTlRhLtp4o793bY1SK3X0WdWx1GRbWjt8wuGjTeK31ZxM901hBkb
         fSMHvrtUxsNkB/JhQHwRZQN+ChHx3PSR10lxoWJFCREvtpv4kq7utLlRaPaXCM0t3HIW
         D0BdyB5rWu514b7ghFaBw6RKp7XYYoMLH14T9DDprcYi76aJWhICElyspkKdseCDw4Zh
         SW6A==
X-Forwarded-Encrypted: i=1; AJvYcCXWTZ9GvUKMr34zIAMgMcNdZ28+byczg6XzjZH89XQau0/NxpY8AxzWz1D5QZ8rEHXb2mnJE5qk52dM7nLdMSc1caOy
X-Gm-Message-State: AOJu0YzG35Qh2oJjuoFh42Oxdzz8svB3IdwVudon+GrlGSStFvyzrQPi
	65AgH2Vqf2B+REuoFuLepqfdrJjLeq0ZvhwBfsnT9ibVlrjemXqxJpxGXQ==
X-Google-Smtp-Source: AGHT+IEE9l/y/OztM3mpP9mn9pkBQt22ftjyW8gC6hwG6NCpZ5iosgRVH69CH6qLXWSz1lmO5cnLYw==
X-Received: by 2002:a17:903:2306:b0:1f4:985a:ba83 with SMTP id d9443c01a7336-1f6a5a699a4mr7727265ad.48.1717534593593;
        Tue, 04 Jun 2024 13:56:33 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ff9f3sm90217285ad.247.2024.06.04.13.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 13:56:33 -0700 (PDT)
Message-ID: <59b81a9f64e46583ad0f093551103752c1d6feb9.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/5] libbpf: BTF field iterator
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: alan.maguire@oracle.com, jolsa@kernel.org
Date: Tue, 04 Jun 2024 13:56:28 -0700
In-Reply-To: <20240603231720.1893487-1-andrii@kernel.org>
References: <20240603231720.1893487-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-03 at 16:17 -0700, Andrii Nakryiko wrote:
> Add BTF field (type and string fields, right now) iterator support instea=
d of
> using existing callback-based approaches, which make it harder to underst=
and
> and support BTF-processing code.
>=20
> rfcv1->v1:
>   - check errors when initializing iterators (Jiri);
>   - split RFC patch into separate patches.
>=20
> Andrii Nakryiko (5):
>   libbpf: add BTF field iterator
>   libbpf: make use of BTF field iterator in BPF linker code
>   libbpf: make use of BTF field iterator in BTF handling code
>   bpftool: use BTF field iterator in btfgen
>   libbpf: remove callback-based type/string BTF field visitor helpers

All looks good, thank you.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

