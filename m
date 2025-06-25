Return-Path: <bpf+bounces-61467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA21FAE7399
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 02:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40F43ABEDD
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1FE1FDA;
	Wed, 25 Jun 2025 00:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DybOHrKz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BEFA31
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750809894; cv=none; b=CTcEu8qR0cAC3zZxLS00uOI/9aPSvRaYI5Y4PzBxEJ05hWeumnOYXTJmL0stJvmtq0SeL+JrfnN5rf+UGJPQ8tmfPI/IRgy2CiLkrvD+keIYgj41xUNGrGOp9SWFGCjR82WXbj5zhgmDJA9xujmVxlT8t2i0UasK/frKlOvpbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750809894; c=relaxed/simple;
	bh=K3sY+LHHBxBPADkRUebqy42hZORDw5nnmqAvESI14oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1Pc7zPVCI0Lw2USKk/m05zuPS9hrPC4dM+toHRrH9fVlGaDXaURGySi/t8xuzz35cHuFQE+ufo/q/M7RNHYInLb5vJVwnfqsr3Dt/Mxl6/yA1+44VTDiovK03MXT0aHQw/sLxSjz7YTZpZBC4osp/pgdP8VVP/5/toBxJZv3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DybOHrKz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a528243636so647312f8f.3
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750809891; x=1751414691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3sY+LHHBxBPADkRUebqy42hZORDw5nnmqAvESI14oE=;
        b=DybOHrKz96ZEee7iD4mLXpeWL7QJIwENGU3VSXPC2T1G12+abvEjsVJTuwdBKL/bf5
         W6V/+BFg0xfQH95wPKnmeWI9M7Pi7xZUWWnC0L94ewt3ki+bblEH02s34U0U6w3UMerr
         qEwWlURy3E1CdEtV+9uZAqkt5NVFxqb+pYHEnQ581Khdtp14UbIoHwDaEQ+X+9eeipR/
         weRb9A7EuZc5TqdcxJtZpp0fT8AA6NQU/gapZGhpJYKe9fov1vkEDD+ngyT2AttIqvMb
         Nwo0iU5f7itAstGhOxULi6mtuKQC1WdnT+Da3GPpLHdKKm2Zy8kaEoxpGTx1Vf/m4p/E
         hkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750809891; x=1751414691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3sY+LHHBxBPADkRUebqy42hZORDw5nnmqAvESI14oE=;
        b=lOIP5X1ttGrc9IKMa4zcBOyYSv2aGQ0bqpJGf7mSBlfDp3T6PhEl0iaV5JMtY2uDSN
         H/6POsauXEgdBiDEnBgHiVzXYszNdzH42rcHcDJ3qbXEjXoaoE1f+BAJ1bCC1YUnGRDR
         Yj4yL8IOC5Ev5pS3nUktZVFz+thnbGZ95Z9wSL7kLRQl93xcX+CnI4XM6jyaJoa+W/4l
         PukXA2yRt8akqFnFHTD8aD2AdFHjygUUBwMO4kaAzhN0rh/4CqBg1reXvFVDfokMLIUA
         aUM5XCnhNldV/tyq5yJlrLzPMShvVCXmeRGg0+0WzgLShNe50bl5ggeoS1f7vCH+dUjc
         2RNQ==
X-Gm-Message-State: AOJu0YxR/Oiuv22v7BJA9553758C9ctO5httWjA1mdyxOMki6RxeLZHb
	NcST+DT5SdrhOScmXX8IGzuOzA3wuyUh2qIzAndJV83UbVHfn1eMSLM1UKYODFYYBs4TZaS4+ru
	2RRI8GBXEF7o9KaYZv90S5QZQfZOy+hOYnQ==
X-Gm-Gg: ASbGnct0Q93cKnRcCKtny/ohAGJM+crkHZ1cvlJb5CTWdxI8DP/4AF8m/obLH97kpZt
	N45NyfxU70ERmp8kjnCvDw3wY/YajbnlspO+L5Qh89R/tqE8fCcXzvaXGTjIR2rXYX/QfyUFBXv
	bv4nUW9+QvzJ39erI+wlhLoehqbt2dtJu9zzztOiADXtMrz2dO/xJYyFU4VDvB/sgVK1oBuGu+
X-Google-Smtp-Source: AGHT+IFMK2J65EacN9ZAaF55lseEYCysYDvhqvBehJfdrhJwkXLDlIde/4U4uWKWpIU5WOKUaqFcdJBW8BIRX2vCQwg=
X-Received: by 2002:a5d:584a:0:b0:3a3:67bb:8f46 with SMTP id
 ffacd0b85a97d-3a6ed674eb1mr398435f8f.57.1750809890772; Tue, 24 Jun 2025
 17:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624191009.902874-1-eddyz87@gmail.com> <20250624191009.902874-4-eddyz87@gmail.com>
 <CAADnVQK8e7SqSRDab8xw1onFHe6YoBnTqoXJ+Pjg-_bDk5=sXA@mail.gmail.com> <110807608b360cd18beb0e9cd621ce1b3c25a7f8.camel@gmail.com>
In-Reply-To: <110807608b360cd18beb0e9cd621ce1b3c25a7f8.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Jun 2025 17:04:39 -0700
X-Gm-Features: Ac12FXykGef8bklaPVO9ygWeNyQO9JflPLPHLVK0d1kgVrBsK5NGe5hv7bgKRq0
Message-ID: <CAADnVQLUtFcH7FX9XP2n=LGatAJb2opv3KyZzf_YBpxpC+dkSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] selftests/bpf: allow tests from
 verifier.c not to drop CAP_SYS_ADMIN
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 4:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-06-24 at 14:55 -0700, Alexei Starovoitov wrote:
> > On Tue, Jun 24, 2025 at 12:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > Originally prog_tests/verifier.c was developed to run tests ported
> > > from test_verifier binary. test_verifier runs tests with CAP_SYS_ADMI=
N
> > > dropped, hence this behaviour was copied in prog_tests/verifier.c.
> > > BPF_OBJ_GET_NEXT_ID BPF syscall command fails w/o CAP_SYS_ADMIN and
> > > this prevents libbpf from loading module BTFs.
> >
> > You need this only because of 'bpf_kfunc_trusted_num_test' access
> > in patch 4?
> > Can you use kernel kfunc instead?
>
> This turned out non-trivial, not many kernel kfuncs take pointers to
> primitive types, and those that do are either STRUCT_OPS or need
> device bound program or have special checks requiring stack pointers.
>
> I declared a separate prog_tests/mem_rdonly_untrusted.c runner.

Just skip it for now.
Adding unpriv btf access can be a follow up.

