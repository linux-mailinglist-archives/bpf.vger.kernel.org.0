Return-Path: <bpf+bounces-71035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60D7BE038D
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 20:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908CF3B37D9
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6C2C11D4;
	Wed, 15 Oct 2025 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4lMorw1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686913254A6
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553634; cv=none; b=FLQEwX8uYRX0IjUeSAQYP+NlS1wa/B+YvnAHi4fDlYvi0nbu9SX5Pd2z4ZdAvUAxZRPClWCMhSeC9CcsxrtLw2pr1eG7bjKptQ8oZ7fJWv8whlYRSV7fCbs6ZDCQb5K/zgdu3nST9uPTjMCZCiV9KjrWs5QXSBLg6I/cNdatasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553634; c=relaxed/simple;
	bh=HyXy9JyVqtyq39vQXqfBYlJIImY88Fnsw/Xg5RMIIqE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TAWWl5TD+bhe4BF2B5BvsBitf4HBcv7N9ZGNbvhu6hgkQEJq8Qnr+Gc0YNWJrOKHx3N2x2L174byrBmR5Ac3y74BJUAbfQEIz7/k2gQ3vTF9a0hxzJ4wnqLSvxnV42Scr2DdNpl1HjzmmH8E4wd4fBtRP3sgKivjVPw78wmhqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4lMorw1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1447644b3a.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760553632; x=1761158432; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hchKK86+KgVfirLf74vk3FqzNCUxs81/b/j60tbNRSU=;
        b=g4lMorw1vI64Ne228V9Rp+dga65UgIUZ0E7AZb7aSkgc2ZdKXwBGj8cumU0/Z3m7Y+
         VYLtPg5BExNUt3m949lIQP8Nfz22fpECvEPcRn6jYWIVARDHLBlOr9c6Z8oLChRRNEqb
         /VKQenERl1egKPdcOqLidtOdfTLzzTzPHH+3ferfoxJN5qxL2B3FhrAHIvGv6JsmWbYl
         ISb05z0qquybevUspeH8YAeyh4CdvAaT/2GzKKgNqdnGJ7CDORUspHKMgBUtH5wAgZ80
         K5npHm6HME3lCo2L1xkFisODiGEr18y03JjW1Lux80J2Fb7wIn2uJstTdfZFDgllEJNc
         mEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553632; x=1761158432;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hchKK86+KgVfirLf74vk3FqzNCUxs81/b/j60tbNRSU=;
        b=L3g6RkZjCFoBvSXB0BN8HXW3Emdj77qHLOvhKDPX/eqxIxl5LceUfj/BU4GQfXXHZU
         2nxMTthdATl9XDvV//AejvhGkWscs9DR1ubIeDdrFvVbA8HStfaFLp8AeChNboI2aJhf
         7BhmsU2xiXiIdK/SDnYUeT/fNee4567IuIiU/qc23YahCuILAj1sYog6x9QLH4Kur2kW
         7TX+2iFxECyI0PGHBxGAvNBMY7YK6g331p1Zeg29JbJg496J7cezhJc2lAhrvrkA11Z+
         eK72KX5sFXMNY1WaTByRIv6Ifz4ZqKXZtwCwsm10gSM9VCft9sn5jq6HXyvhfAH2YFvr
         1TqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF/6GjdMReB9xBX3/5yK5Ut55qxPY22ZumSYu5EdSm99oeqbo69+isjZjMAtd55kvEDoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynIn+Dx9gWerSdano5lU+gDtIfVNBgvpBDrZJ/qi/YQmoSJwA5
	40KoC8AJgW8feKYwE+YrUgm2Yeyvn7EgFRlT42N08r34uf5NtDkDm78k
X-Gm-Gg: ASbGncu4l9JZysKxmcxVjCwoGKK9LXAUNWWNb2PA5BcnF3nCzo6Wa+P3Vpyt337V4+m
	RFP8Yt5ICp2jvK3A/xXlxjfBuBJGglTMPg+glzv3NjebXGvtWoJxQfwIPxa8v5wsLmVN7tkkduB
	S0+u7DioVGl3Q/MlEUX8VXothDA/yaTu/C717Zvr5T1mtRxXpsA0OxPTZihgb8SU7jiiQ8/AY/f
	DcYKg4AHA9cEzGct8ijAGqmDQ6c2LltUy1on0/dwBbg6iNQMVBhe6Aa4LBzGYrqMUBolLs8Cc1M
	MI60jwFZhCSrgY7xE9J6qPuRRc5z/rcoQgqQYbza7fBegp5SmWXR/687znTfwk+G3Pw/AiMXJVS
	UllKVrETVv8LVAYEZxQCE/6FXBAJGKXjdCTopbxI=
X-Google-Smtp-Source: AGHT+IHSqc+hkjTVpSEHmw0zHlWgwD2yxQPTUM5JuVcSvW0k2XqZQTEnEirn1I9k9wrsXFzHRwnKSA==
X-Received: by 2002:a05:6a00:2286:b0:77f:df:5c3b with SMTP id d2e1a72fcca58-7a210fdcb76mr1371875b3a.16.1760553631419;
        Wed, 15 Oct 2025 11:40:31 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e135asm19610557b3a.56.2025.10.15.11.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:40:31 -0700 (PDT)
Message-ID: <066d090c7f0b9e2f3ba815b366396a96146ae5cc.camel@gmail.com>
Subject: Re: [RFC PATCH v2 00/11] bpf: Introduce file dynptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 15 Oct 2025 11:40:28 -0700
In-Reply-To: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> This series adds a new dynptr kind, file dynptr, which enables BPF
> programs to perform safe reads from files in a structured way.
> Initial motivations include:
>  * Parsing the executable=E2=80=99s ELF to locate thread-local variable s=
ymbols
>  * Capturing stack traces when frame pointers are disabled
>=20
> By leveraging the existing dynptr abstraction, we reuse the verifier=E2=
=80=99s
> lifetime/size checks and keep the API consistent with existing dynptr
> read helpers.
>=20
> Technical details:
> 1. Reuses the existing freader library to read files a folio at a time.
> 2. bpf_dynptr_slice() and bpf_dynptr_read() always copy data from folios
> into a program-provided buffer; zero-copy access is intentionally not
> supported to keep it simple.
> 3. Reads may sleep if the requested folios are not in the page cache.
> 4. Few verifier changes required:
>   * Support dynptr destruction in kfuncs
>   * Add kfunc address substitution based on whether the program runs in
>   a sleepable or non-sleepable context.
>=20
> Testing:
> The final patch adds a selftest that parses the executable=E2=80=99s ELF =
to
> locate thread-local symbol information, demonstrating the file dynptr
> workflow end-to-end.

Nit: could you please include summary of changes between patch-set
     versions in the cover letter?

