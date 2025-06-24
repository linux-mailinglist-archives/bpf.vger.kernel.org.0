Return-Path: <bpf+bounces-61461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1174AE7340
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 01:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A005C1BC2D61
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 23:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555B926E705;
	Tue, 24 Jun 2025 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy9IPqGj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E32B26E6E1
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807868; cv=none; b=ukIaSoCpg4ROzpkOPDZ/COkYR3rKrhKImNIhw96lZ2NaTob/ZpxN0LnJRbAo6nWUman0cRQVui/6bGGIfR1ll2OOZwtzOog/JI9WhHjDUH2C//mjzVP6pqakIQdAyP9vE01b0YZVfVyepi3HijpCgaNc4S7SRrr844vOSDp3+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807868; c=relaxed/simple;
	bh=0BSwHxo+80HSVRACjo2q9a74ZrxjNQ0WKlawLaxYl00=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oHmrN2qFsXqr3RxqwapFkgpgWokrqACan7mhvqLpR9fHscZasGlEYpyQytVOwqNd7t1U4L12ncP6wm2srgA/H9BZPb2Z/vTYChIKWatpGS647yB8m+Jw/4/k4PdueR6UWjPg9TfcU6TbC82hJgJRSTyLDtc/BRFrHkz3SJfTJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy9IPqGj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so1003716a91.3
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750807867; x=1751412667; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0BSwHxo+80HSVRACjo2q9a74ZrxjNQ0WKlawLaxYl00=;
        b=fy9IPqGjJc9pJPGhnb8hWvhxxrfPks7iDgfLWJCPPfTHEacxoNjC2LER+IP5iHxdAT
         P7KFtQjgDkgIzIgeC/Tfb15c/5hjLiUWGN9xfWUM950xFN0anlK31xueEAtGW3seiZ6j
         Q+gWEopy1KS00FNFXVhy4nRGwtSz9CNg8embDWS56N1dr2opLrVfJrPrmEsquV9AAbYO
         ZD5iMJiNyuFnIk6Wm0hkSFBasbN//4C9+yQPTRfPu6k2hQiEO5GO+3UvtOtL8k21M6H6
         HFZZZHq9vhpiSSo8fbfteppRnYetHy8Mru34BwpwqLMewfqpwSRxOmshZkxLsKlLzijy
         KwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750807867; x=1751412667;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BSwHxo+80HSVRACjo2q9a74ZrxjNQ0WKlawLaxYl00=;
        b=BnUk0Vl1j3hIUC+CnAcFv9reNdggYHIE5BEgwzBP1KKASHD2Gvqesk4kCdRigcHegO
         tYzSDJHsE9ifFa8FbHLE+HuNvktG68lIfAFpTk6SoaIQnsC/Zj6AS8Kzy3ERVCRbWYUx
         7F9fwulSXucHFOu4szyZN18tzIMa0B+bhJuZLJyP1e2cmHu+/+nr5tT1BBS3TBUrnRqZ
         jIBOSjZ/cWD0dVOpEplgaRKfZw6OimLbAciIb9NBtCTHSgNnVhvT19+O79Jb5gehglB0
         TgtC3Q8+bIpF/s4v0N6jMH/pygYWbWfl1ZapBH3LJFnGWcPM9w5QFkWQpwJmEYsFaSiu
         HjLQ==
X-Gm-Message-State: AOJu0YzqELVa58jrsne+khax+xlgumDKQoLWuk9uFMDCJ5dlIPRqt1Ou
	FNRZE1l2riBsG8u25X5HnulCi0Li7bzDLzrxR/zGhqFWQuxWNm2IAara
X-Gm-Gg: ASbGncsWk9Le9/MdOTMtiAFQKSDVqGC9g4iz9qt6ff68DEgMl19K0FvFGn0R5fYPh+O
	UYUuJ3z4ro4y5k4DHnFBvUKYRJqEEhg6SuOWUCX3l2mx2rxcQC0D9etDKNNX/hdaxlRgj/u0BuF
	1HHXq0hYod8WXvdU5Kr/7i78hC6XvMMwDQF0y5NIwKvKW2kMLSddCpBERu9N+Zx9vb/ODrU9+Su
	dCziys6/YVDcY16P4UqyI0WUGScfV4lQPsZ2kxsZVhUhh+uCWd/BPfwF8YIV1EVgK+LxBUgkJwS
	MlwCexMIaohve82L19ahzbrJZan835Sv9UnMrK7zy5iLYQR4SZAQjaL+j/KsKT3JAz5qMoAaimk
	4KAlpW7SvfQ==
X-Google-Smtp-Source: AGHT+IEyeOCr4ZiD3XFWU/pHb3Ujx32F1upg1gBvYWz+TQwpgvUQuk8/tL2pCyhHY86nvwXq9hRM4A==
X-Received: by 2002:a17:90b:288f:b0:311:eb85:96df with SMTP id 98e67ed59e1d1-315f2676b34mr1041578a91.17.1750807865882;
        Tue, 24 Jun 2025 16:31:05 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5387675sm198357a91.9.2025.06.24.16.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 16:31:05 -0700 (PDT)
Message-ID: <110807608b360cd18beb0e9cd621ce1b3c25a7f8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] selftests/bpf: allow tests from
 verifier.c not to drop CAP_SYS_ADMIN
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Tue, 24 Jun 2025 16:31:03 -0700
In-Reply-To: <CAADnVQK8e7SqSRDab8xw1onFHe6YoBnTqoXJ+Pjg-_bDk5=sXA@mail.gmail.com>
References: <20250624191009.902874-1-eddyz87@gmail.com>
	 <20250624191009.902874-4-eddyz87@gmail.com>
	 <CAADnVQK8e7SqSRDab8xw1onFHe6YoBnTqoXJ+Pjg-_bDk5=sXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-24 at 14:55 -0700, Alexei Starovoitov wrote:
> On Tue, Jun 24, 2025 at 12:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > Originally prog_tests/verifier.c was developed to run tests ported
> > from test_verifier binary. test_verifier runs tests with CAP_SYS_ADMIN
> > dropped, hence this behaviour was copied in prog_tests/verifier.c.
> > BPF_OBJ_GET_NEXT_ID BPF syscall command fails w/o CAP_SYS_ADMIN and
> > this prevents libbpf from loading module BTFs.
>=20
> You need this only because of 'bpf_kfunc_trusted_num_test' access
> in patch 4?
> Can you use kernel kfunc instead?

This turned out non-trivial, not many kernel kfuncs take pointers to
primitive types, and those that do are either STRUCT_OPS or need
device bound program or have special checks requiring stack pointers.

I declared a separate prog_tests/mem_rdonly_untrusted.c runner.

[...]

