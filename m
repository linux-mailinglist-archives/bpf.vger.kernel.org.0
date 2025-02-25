Return-Path: <bpf+bounces-52570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E83FA44E81
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C003A367D
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 21:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CB81ACED7;
	Tue, 25 Feb 2025 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6qAbUpu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4719ABAB
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517980; cv=none; b=uh8uwalakvVOeT6sfez8yFuUEHN4fWZ8eAT745YyiC3YYupKYfjBs++6UbmgxcJ2RJbfYoa6IQYraXB30r70e0ythUa35Zs94O2lpnuf/M0zGBrt3R0Xo1YxIE4V1FGK4nKm6+Lb1PhwwGKli/ArCEl2iQwuqDVow2ea1trinRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517980; c=relaxed/simple;
	bh=gRiupZBiDSyOeAD0KZglhLZiQSD/hvbRfIWAq9d3e+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKYjXcuyaADj+3krvew1LKVAoaZ9quAS0cI2luqXqSmiObe21WugevQJTyhIJRkMyN0cfaqcUdhjcmxxX8DkBfVT4IeGfQAQKXrvxzZBa+GJNzXAc1v79/3oEfX9322XqG1HHLKjtlje/ab1m8FBZyC4h31dedG0P1hCkD62g7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6qAbUpu; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e5dad00b2e6so5010998276.3
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 13:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740517978; x=1741122778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny7nIevbiBnk8Hv8RMmBBp5SF7+o8BMCX554uR+nD3U=;
        b=O6qAbUpuGvqudhDX9GfdCYGMpFkZAE1dgtjp+uVAUgKwNMFANNb+S2sDANePt6X4bC
         dRXUzNcxUDU0X7iuTaBwdbh0A77it69JvZF7VcYo6+cxYeEyMgbS8MSLVjIrv3oEA9jd
         JehgydWDCXOH8a0rk3osCeunxlYse2xS1fBWpMO8cN8YrQ9kq/+Z+Hf7GNK1f04Dwkb5
         k0KPTM0spkueZHClp6o3lymglrXdvpZ2OhNE8Uqk9Zs2ghkoPGwJ3kK/7FxsX6AO0LLm
         aefhQV35wMlECxLJyVRk/l0gPgez33yZPTrNoRSqQPd+3NTj115/i5Wfr5gYvI2+8emg
         T6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740517978; x=1741122778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny7nIevbiBnk8Hv8RMmBBp5SF7+o8BMCX554uR+nD3U=;
        b=ZP9rQWKdzbd2kPKpiaeMTESNg3pRoB5DUlTwWziobxZ4xDChfg8KSAS6ZRVd5gRRe1
         Qn0yft6On2CO9NTW9hmtc4jKzDkrMym+C/jW5JjTBNQ/BSztY+MenR7WmfgB/H7CLu9o
         E+cjH8cQSyxTYEiBieH4eNJZxaq1R6Awc2Gcu2NO3zhyZQvlZOe2xl+l/ix01+Djd6MG
         HPr/lsEzpLzbp2mRJvOkScAS48zU77A/6rh0hhYU22pZbzuQFq7P+y6m5pxBLdKBNwKs
         4INFfTU5/lMTknF9R2ZFyl2++XwFYqZtSGxXmEKvLnpr9BruQSm9j2onLlL2XzXMN9CM
         NdSg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Gej/li51pF9CYg8KKTfRhDIDAFFsc6JFfJ6LJgtS0169QNRkoDYeAzDomQ0rknSNoaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFHSLPmYdxLCeTvvWsMxuzhGBOQA5aJJCHFy5DAGnSLM348geZ
	uOYsUC57L9EPi+p7WiNy8jjI1+RVDo8VEVFUMOIewefOQbZT+qsdMtiG8HXSRDJ950mXBfyZCO/
	Yl/Kw4Aid8CB0vTuO0Sokew5VtMc=
X-Gm-Gg: ASbGnctlxs+A6oukJDlaGO/mIqn8+mDgTH+XkQUK2Y+pfxSTG4l5CJa9YvMmkIPJWdT
	hGWqTr9+ChdBMoXJhYIo+zwEuV4Rm1CPNl7ICCD5bwK0xMi408cXGZq3kEYwahdFZz5mQKtdUet
	FXToygk2jcFsmcsD6sQNhlXac=
X-Google-Smtp-Source: AGHT+IEKR8XUZ86e/i40uFWP9EyHrlQYXpZ9AOOsMEjRfBsi/Ka2mzXxY+kTnNikRmd1c0U0RuJ1yYwHkUwPzwVBRuo=
X-Received: by 2002:a05:6902:27c7:b0:e5d:d047:78fc with SMTP id
 3f1490d57ef6-e5e2467c9b6mr14293686276.33.1740517977682; Tue, 25 Feb 2025
 13:12:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221164721.1794729-1-ameryhung@gmail.com> <20250221164721.1794729-2-ameryhung@gmail.com>
 <a53a4ae7-304c-4409-a273-09b85ac65b68@linux.dev>
In-Reply-To: <a53a4ae7-304c-4409-a273-09b85ac65b68@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 25 Feb 2025 13:12:46 -0800
X-Gm-Features: AQ5f1Jr2rZBHLXe4DfnFj4uRtWIjsWsqfFOA7iDaMGCJWvZozhEoRn_vanMDxwU
Message-ID: <CAMB2axO2SvodEe29TrFUqj3z6P-pOgxrSCdCZDpFtXGRO4hXZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Test gen_pro/epilogue that
 generate kfuncs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, eddyz87@gmail.com, kernel-team@meta.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 12:53=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 2/21/25 8:47 AM, Amery Hung wrote:
> > +static int st_ops_gen_epilogue_with_kfunc(struct bpf_insn *insn_buf, c=
onst struct bpf_prog *prog,
> > +                                       s16 ctx_stack_off)
> > +{
> > +     struct bpf_insn *insn =3D insn_buf;
> > +
> > +     /* r1 =3D 0;
> > +      * r0 =3D bpf_cgroup_from_id(r1);
> > +      * if r0 !=3D 0 goto pc+6;
> > +      * r1 =3D stack[ctx_stack_off]; // r1 will be "u64 *ctx"
> > +      * r1 =3D r1[0]; // r1 will be "struct st_ops *args"
> > +      * r6 =3D r1->a;
> > +      * r6 +=3D 10000;
> > +      * r1->a =3D r6;
> > +      * goto pc+2
> > +      * r1 =3D r0;
> > +      * bpf_cgroup_release(r1);
> > +      * r0 =3D r6;
>
> I think r6 is not initialized on the "r0 !=3D 0" case.
>

I will insert r6 =3D 0 after the first epilogue instruction.

Thanks,
Amery

> Others lgtm.
>

