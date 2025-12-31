Return-Path: <bpf+bounces-77638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3E6CEC80D
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 20:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A01C13005F07
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541A030BF4F;
	Wed, 31 Dec 2025 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBbde3Hi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8F62FFDCA
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767209964; cv=none; b=ChmvD2hExIL+ffhT5pLmYNZILP3MZdmJKMIt5zoqC34YHB0ks+xg8TeS0xgTQ1rwVDztf9CnHmwCh6IXHeKeNV6pKM9kAGo48ensQb/XzWmO8PyEeHNyMfOJuUxqRdz+X7mZzHNx2lB4VpieECpkIVq/pUZmj4eEOVaiQCJtL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767209964; c=relaxed/simple;
	bh=792S3C16XFXtKagbjNF6rmlSCyFMF6/oHUPGBbyVDGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfPRnhSNevE1QKBkMjQIEuo5jOp6oYVsFl5M7dO+NfNo3UV44ZzB8WMgbu1q9RhTsD4h/7w+7DT9qjaKa6d0hwq27Y8FCCqC+KAFpj3Zl3CAgdHM1nV+rNKltlIQ1qw+AYbGIWyAyBeC7TEV5nOXIfsOf1CdjnV9UKe2LN4poEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBbde3Hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFB1C4AF09
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767209964;
	bh=792S3C16XFXtKagbjNF6rmlSCyFMF6/oHUPGBbyVDGo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dBbde3Hiu3mpl1nmDEi/KmP58vPd2dB5+MIZ5iXdROvAFv8E7aDSfjRxAk4n0tf4x
	 AZZZyD82O8X5eqH4E2T8rf2lsHXm5Ik2cCIMyLQQaBaPtSDgecUeNxM1aIg9bWkxoo
	 G8VaCzhUBHn2CBy905yPltQEQmlRxnCTVmAZHODwkXMu09t6UApkWTZtWSkzPSK50g
	 Mk0rBUL8RiiGPN/6NdM4BvgSHOTqXw6VLBQF/wGIXAf8tOBsyV+PXTzyUt+LIdyRN3
	 IR0L+Pjae/nXxZUC0n+k1hhTBDBFsx45XZ3VdkxSepecsuHnFH+0Pmj/w3fWxAAVLO
	 ppcxlSg0k1yKQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b736d883ac4so1861616366b.2
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 11:39:24 -0800 (PST)
X-Gm-Message-State: AOJu0Yw8yy/M3s/GaQ5Y4PumpwApWiWQiEqT3UWj7znAvAu/qjZCUPy2
	bMtuqF79pEdxlfpGsIE0GNXDUiLUGiJSpqsLwHahhl5qcEF4LWq8BHWLpHAvLji7qwXDt3mL43m
	7stpXgUyXQJqnP9gUEVnViwUGB7qObtQ=
X-Google-Smtp-Source: AGHT+IEzH3AEuTMDVAtqgMKGqwkv75u94Rc8nLsptfq00bcBjC1bGVtfZz2IAzjzrjqCCWR6X05mGjBhTtmFC3DHaiI=
X-Received: by 2002:a17:907:940e:b0:b76:b921:d961 with SMTP id
 a640c23a62f3a-b8036f0a416mr3611860166b.2.1767209962797; Wed, 31 Dec 2025
 11:39:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231171118.1174007-1-puranjay@kernel.org> <20251231171118.1174007-7-puranjay@kernel.org>
 <138667689e511652194fd98ad0e20d71f7738234.camel@gmail.com>
In-Reply-To: <138667689e511652194fd98ad0e20d71f7738234.camel@gmail.com>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Wed, 31 Dec 2025 19:39:11 +0000
X-Gmail-Original-Message-ID: <CANk7y0hXxYsmgMY9km1ivtt-Bd3=tbjf4+vra5y_5M66srEh_A@mail.gmail.com>
X-Gm-Features: AQt7F2qG_aco2W0DtZXTIj1EIhCwYA9V9Ytzl9qP1VtqS_-hLGCdixX0Ug37iGs
Message-ID: <CANk7y0hXxYsmgMY9km1ivtt-Bd3=tbjf4+vra5y_5M66srEh_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 6/9] selftests: bpf: fix test_kfunc_dynptr_param
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 7:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-12-31 at 09:08 -0800, Puranjay Mohan wrote:
> > As verifier now assumes that all kfuncs only takes trusted pointer
> > arguments, passing 0 (NULL) to a kfunc that doesn't mark the argument a=
s
> > __nullable or __opt will be rejected with a failure message of: Possibl=
y
> > NULL pointer passed to trusted arg<n>
> >
> > Pass a non-null value to the kfunc to test the expected failure mode.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> Unrelated to this patch-set:
> what do you think about merging __nullable and __opt?


Yes, I think we should only have __nullable, because that is how
programmers are used to think about functions, just pass NULL if it is
unused. But I will see what the verifier expects differently from
these two and send a patch to merge them.

