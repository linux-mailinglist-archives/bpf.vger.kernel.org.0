Return-Path: <bpf+bounces-60523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C611EAD7C58
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 22:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D9D3B4FE1
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 20:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE18D2D6616;
	Thu, 12 Jun 2025 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Faz8D18k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AA71D79A5;
	Thu, 12 Jun 2025 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760101; cv=none; b=S+iLvTAX8sfaEHpePQe6L5INjjw0zUgWffyqYYOMx45Mi0LMZLwpxd/Wt4PsmQB3pxjMZ6OIRRdCzqkSffEslX86NeBEqb0nq8L1Y9L3EVZri11p14q43Sy3JL/08Y5J8y36bhd4mXCSa4fs927TsJRtPROUKPF0c1+Hk1o0Vqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760101; c=relaxed/simple;
	bh=oRSm7ZpB2dIF6nVqpuQz3Jd3BNn0/vdz7YkxnBDKJzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzQngG56flCoXkFzIU76O1hs3tHq8P6Dt9OMgZ7wmKs3oIj6VFhQO7HGCdrUc+5KienfOG2Rn4QbX1BG5cjlsxyVBUOZtM7WjVz6FWV9Bp0cBlAytH18H5mHXpN4mh/MJwQWO7yJYmjOLBF1/eJ7tFAYjEivxgsaYz14pEP4m7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Faz8D18k; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso1539470a91.0;
        Thu, 12 Jun 2025 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749760099; x=1750364899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbNc7HY8VMs8jQgNlP6re9PN2yZih6ZIaqzQM653mQQ=;
        b=Faz8D18kb4AWoe6kcvsGP7Q7hk9U8M4yU+kc4uHht2eqV0TVuLSeU/abE7FCUI5jE8
         eO8zxwo+h3k0GpkrnjzatIOBAeLz0NSRfk3g9TGbsG8blvARGRuAwQ01lqaEG5vDblbK
         tXCdM90AtPwQgsmsRYl6O1ZODU0Qj6/5SWLBKJC2I1Ui/Uyh7fQkWT39ujBds+wrZstk
         MWPqlo17hPKHKNpNeE7YsRjqYRSX3xzhAiidgnh+2czW6Wf4NP15Jx2nDKXG5tZLpOr2
         eJYUAhktvfeVYNnqDJn1U2EQxsSMO+SRihWUCAqmpgiU0wifcwtoJeSKqfBWo2EZXzQE
         op+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749760099; x=1750364899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbNc7HY8VMs8jQgNlP6re9PN2yZih6ZIaqzQM653mQQ=;
        b=YYXQvUgtG8F+zDqY8RsdV36WqcSzZCZUTnGa6G111c0ixoV9GbzfczFg79uLA31Zin
         uUPQr+nXv8tvNGT2GDwIdMWq7NBLTPPmWNSDnRT2dCssXzBfdy01wr1VRbRobDA2eaPV
         Q/4CP1TxFub5pH+IHgRfrQP1YK8FUAa3sOuSMEfniVl8KAwE30AHdkUn07OxSnrkHdKL
         nHv89UnB1DvqNaeyhOD67MVSvYjNWrLJ5Ce2rNrKnHrInH+5CaOWDVzQ+/LPm0T6x6Zo
         oXNlRO2xhzRrcZIm9Iwy055vYWfLVV0u4kUeCJQ4xA4KulQcJRF9FhhBOo+V3SRrc2po
         MpMw==
X-Forwarded-Encrypted: i=1; AJvYcCVnLnm3r1e2/Ce91xIO+E7VyIjTRl3uYpc0xb0eGFfbD7Lz3QxorUt4d5wG+pckfCANf8pZyoW4dhCnsUJ/@vger.kernel.org, AJvYcCWAt8S4F4ktHWktW8qcWXIX3EBGO7zYxGKT99i2XQ2C8XRbxpK8hZpx9rLNcN2z+MQusvw=@vger.kernel.org, AJvYcCX81wLivfd13yTRfihBdUXaQRl3/QO54TvoP+0BWfo7V2OKi/d1yneXKsO7i9kQ0FzwrJX/MpRVXBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfiwWWR5NRdF2563h/SHUWBOZNca7RGjjtjmXu1dHVLK9dDVd4
	eylg58bn290O8iRHBGlke9rp6oLqMQWH1VWNevFaKDxOhIHTaYhdnkT6ITox0qqAdjP3ltX71Az
	5hsH9E2RRJ9Bd2nozJzv5OwQJsc4RyV0=
X-Gm-Gg: ASbGncv4QKzitpS/XgheL6ygzFH/PuBptT6CVEQLJ/DAbE8cg/L4L2/WBeIgjwj0qnN
	eoiS8XC5pdtalHU1d+jy8LhblYqCKdFzfY4w6O12W2BATGeVe0GfAvQ2I+8eMnpUnBeLELu/nLY
	5pkkuIq9tb+C85JUmiMPIiQuRDLvpxVnfG7wrRHysI2zPppIswUoj/TsJiHW0=
X-Google-Smtp-Source: AGHT+IFzp9wE6ohGX9H5TUuxNuCopVHXZP+q6ExEdlcRvnybkr7qomkVzrU4YPeYA/75XCqu0VoEcg00BbvSowdup2Q=
X-Received: by 2002:a17:90b:3d06:b0:311:c970:c9ce with SMTP id
 98e67ed59e1d1-313d9ea2effmr736404a91.28.1749760099154; Thu, 12 Jun 2025
 13:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606214840.3165754-1-andrii@kernel.org> <CANiq72kDA3MPpjMzX+LutOoLgKqm9uz8xAT_-iBzhR3pFC+L_Q@mail.gmail.com>
In-Reply-To: <CANiq72kDA3MPpjMzX+LutOoLgKqm9uz8xAT_-iBzhR3pFC+L_Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 13:28:06 -0700
X-Gm-Features: AX0GCFv2_R1w9AinnKKibx6LjkaQ05xASRlncBw9977J0iGCLXb0a7tS5H8foEE
Message-ID: <CAEf4BzZDkkjRxp4rL7mMvjEOiwb_jhQLP2Y2YgyUO=O-FksDiQ@mail.gmail.com>
Subject: Re: [PATCH v2] .gitignore: ignore compile_commands.json globally
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, masahiroy@kernel.org, 
	ojeda@kernel.org, nathan@kernel.org, bpf@vger.kernel.org, 
	kernel-team@meta.com, linux-pm@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 2:27=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Jun 6, 2025 at 11:48=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > compile_commands.json can be used with clangd to enable language server
> > protocol-based assistance. For kernel itself this can be built with
> > scripts/gen_compile_commands.py, but other projects (e.g., libbpf, or
> > BPF selftests) can benefit from their own compilation database file,
> > which can be generated successfully using external tools, like bear [0]=
.
> >
> > So, instead of adding compile_commands.json to .gitignore in respective
> > individual projects, let's just ignore it globally anywhere in Linux re=
po.
> >
> > While at it, remove exactly such a local .gitignore rule under
> > tools/power/cpupower.
> >
> >   [0] https://github.com/rizsotto/Bear
> >
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
>

Masahiro,

Would you be able to pick this up? Or where should we route this
through, in your opinion? Thanks!

> Thanks!
>
> Cheers,
> Miguel

