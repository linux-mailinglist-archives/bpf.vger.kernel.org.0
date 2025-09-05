Return-Path: <bpf+bounces-67632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87158B46593
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE288A03616
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C00B2F28E7;
	Fri,  5 Sep 2025 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDvU8pvx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6117C2F069A
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107980; cv=none; b=ib3BIR9/owEidDkbwHHwYw2GsKLLT8pFNl8VXMfAtToYN2OYex26y2yTJVdTECoc8/HHGmbwcIQFuDnuZ3mmUnZlS6d7s/+8P9qn0lwWypFp4grvuMlzc26XA19iigXGLdUHRXm+SLUZgAPjWcKZjj6EHwnewzKZxdln19inpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107980; c=relaxed/simple;
	bh=lEocCmkSDFqfdFlE6l5/J/o7LpyS2vV4xHuhDgLyY7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PLSzCDByh+r7BgTnta8yUjf5TE7k0+4udzv1fnSiIyOCTlddHQButMZxxkmMemG2gnTiHUfRgn3Cn8Gf18o+KGL6DTfzeewcgqDc+AReOugz4VFGsz7hBpowEMi+9aGGSXG/WxZPwRivnvRheB8XjvNh1QDXJNmTTlJ76XjNKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDvU8pvx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24b2de2e427so19513185ad.2
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757107979; x=1757712779; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P5P5J/g93ark7gSSgenyTAZXjbzGkCtRoibuCmfazTA=;
        b=JDvU8pvxlzxUx0mKs+fyj+yip/uZtGvI67mn2cq3Cn0qearNoYMe3Dn1/kAE4YcZWe
         7iSeAnQWPY2slg/OJH8ieQs18htraIxOMo3dcAh4FGAH7h1Fn5riVWYnbOfEzexj23GC
         2UaXHLkPOtCNE8MvXp1Vt5wxJdOreLyNjoUL0RxOXMBESmW4Q7j9OlFSfVl2qa/BoNdp
         dUEJvdDruriU27gd0/He3ITa441fk0n1vYld6Rwvtbjcfe4aMBZlz9bDca/ohnESr/jj
         vFOmduuCFHoNxMiQEqC15s0riPPf+GkVg4TthUUsZY2JzW3pVoPffm7VuPpPlGkNVryU
         AoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107979; x=1757712779;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5P5J/g93ark7gSSgenyTAZXjbzGkCtRoibuCmfazTA=;
        b=nYwQ9Cv486roDlKFL/Ek9UfGq5LIjtSE9uUW9CYkHzbhOd7nl0FUpEGApRyyJHD+5Q
         oqZtsFfLTZeuZ8uss33y6bJL4muYGjB5nF/NQQ+O7/0vUJ3Cm2ZIa/MgxlZelt68K+h2
         1U1l2AWZ+9QN5hdxKit3fqLDvtVFfZXnzmQtj4zfCd0NXs+GuM3Z9u/aWPUTJyqjngx9
         5HJx6JbwEov1Y4xjCWA7AIu1fG5/FpptkuKnY9n89xed8hh/9TxSarfqth3S8FZ6NYb9
         qocSdEFY9l8majVjuzequHJHljz3FBrcVPlirRPZ3ORFlT0EZXO88ifI4RsIzla+QX/8
         F0Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXS2SaXgmbclFDZtj7edPkuQv1IIE4TFsF6qvyswkQpNEtgqTacEVCGUqYEvwp1SaEHTyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdm1EduRKArLYFaGewWGYnuNUiQE5NfN0Gi4A9Ej4GUC7SfPqK
	0sf17YgDIwNYThHoWKjP0l2Gvo7HTT8eNHapmUAZug22JLTJVAmmNH9G
X-Gm-Gg: ASbGncslCmef95RxAB1imRizRhs3tAztwKBMVJkHrr7+jeaqtgj/xQFCzzOUF18uBjb
	LykA4o2QCi7majyCkdL/U1OGYExYQyeqpi7cwFH5adGGfz1kGNUOC0mbvhZX5mXVz6105WAcU1A
	BWrwgoMvia7IY5JWgqZ0WvfUJI2pTtuD3S97ELlpjEto45yHIUecByMOZIM6QvFMK4DXOEYeSon
	96wJ46l4XCrr7On/vxknCFW6mIVzzwB/opJdZQBT9dLIPTrYAYDCa17PuOo/h8SfVdGWVEzRSXi
	co1LYQ0R7CLVH1l8JPmWIpaFMpdhENMB8xh4l8OLIFd3tU700uAx4bCnsJX0uenNAq3Li4ki5xL
	ezve3AtPcn3qT6ESdHA==
X-Google-Smtp-Source: AGHT+IH57MoxZgHvHmPNYVOp/IykbpLcZ9vsqJvD9mxim/SDmLpNwOPp+6hxlxnJc47s3VpV6iMA4Q==
X-Received: by 2002:a17:903:ac8:b0:24d:1f99:713a with SMTP id d9443c01a7336-251715f32demr1960175ad.31.1757107978757;
        Fri, 05 Sep 2025 14:32:58 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32be42d650dsm1591962a91.28.2025.09.05.14.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:32:58 -0700 (PDT)
Message-ID: <4503a37c85d7ff9131b6ccd1fe2a696771747e4f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf: extract generic helper from
 process_timer_func()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 05 Sep 2025 14:32:54 -0700
In-Reply-To: <CAEf4BzbiKHQa_q=KrPaXsJRPCQue_PPoEazvsu5G6bg5yvXO0g@mail.gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-3-mykyta.yatsenko5@gmail.com>
	 <dd66ef2b3ba7d462b649ef87ebb2e166103bdb79.camel@gmail.com>
	 <CAEf4BzbiKHQa_q=KrPaXsJRPCQue_PPoEazvsu5G6bg5yvXO0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 14:31 -0700, Andrii Nakryiko wrote:

[...]

> > > -static int process_timer_func(struct bpf_verifier_env *env, int regn=
o,
> > > -                           struct bpf_call_arg_meta *meta)
> > > +static int process_async_func(struct bpf_verifier_env *env, int regn=
o, struct bpf_map **map_ptr,
> > > +                           int *map_uid, u32 rec_off, enum btf_field=
_type field_type,
> > > +                           const char *struct_name)
> >=20
> > Also, it appears that process_wq_func() needs to have the same checks
> > as in process_async_func(). Maybe add it as a separate commit?
>=20
> heh, we raced, I was asking the same question.
>=20
> But let's do any extra refactorings and fixes to pre-existing code as
> a follow up, ok?

Sure.

