Return-Path: <bpf+bounces-77278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B440CD4804
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 01:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1881C30081BC
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 00:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B5122068F;
	Mon, 22 Dec 2025 00:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZsPES7T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F820B7E1
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766365002; cv=none; b=VTG9QgWnD8SNeBBk2iisNxBrWpIoaaDCHZCpb3Dsyh97xuZHYhSqqPK+m+OWdNR3fxftDzFYdWY8jr9b1eEGFG/mSUkrIvaT1MLmf36R9oxp8oP8PRrN+p+eBqAXGF2bFoq954Vym9ZuZ5sapWDQbaL09ktww65T+1dWrBsEjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766365002; c=relaxed/simple;
	bh=gN2PbKtCE6uPRqY4YQ2tR4mXYHPNrCzLHgZj1fqkuEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rka1J1UhZqMxWrSGcaBD1fCVU5HO65++gfMir4B+7kOxJZCOC+vxlzvFeeQvUkBN7OEGTdbKASj6XFD/H+A5c/ioiUhSo3aFkbnOG62AkFim3AffPN5Qs6Dg4pCuCH2HGsPjKtyxwhaZB+RqInDfB9OFePqcqzYaABYfkkc3XUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZsPES7T; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so25113655e9.1
        for <bpf@vger.kernel.org>; Sun, 21 Dec 2025 16:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766364999; x=1766969799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaZi5iENsOGI5yIZ774zh7QquumsnUvmJkwe3Ni9BpQ=;
        b=LZsPES7TIgi381wve1d23o7fLew65XKSBqayTCDmCT89ZSfhYGaH74TUGhvxiBc831
         9+1zC/tLyoWkVWc250PSqhH9MCR6AhniGvezkQKydDO2VpJoaGvpD9/KIgUrY057PY0w
         LVHYH/CzLE82cnLFbyRPCVbofh/96LU1W64kLKgZLAQEWpZgLvz4nABVrNw9/i4ACdQi
         iKXZg+fU0NbIHnGb7y0AJHt8tplO/2eqTZJuUa5WgWAj1MXvJ5CWkyuWSSTdBbenBK8b
         40WE8SuBj+LpxkL+t1ik/HCJfyIappznmYaLBZoDxT3r1qWdGj4x2R6O874Y/k8i8hT2
         Taqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766364999; x=1766969799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VaZi5iENsOGI5yIZ774zh7QquumsnUvmJkwe3Ni9BpQ=;
        b=ofhOvCbjbM2r8yjvlgoUZlgnKNg2JYi2WQhGuRPQf558NQrMayfhDr/476tvOZzt4R
         gTyItbZXDo9DaXYPoxVd63v1GoY2140AYyhiaG6jRWrPYeYYv+EmRyQ0bi6N5mGyQ1Il
         hpYPVqPWXl76zNSkY1QMsxJGjyQF7zk5z81uTRFyEmI+OqOVa0yK++bFili68aRRxZ0N
         agr0AXHsF9Sv+LWRCIpL1DtK1siMZ30NqR1xUD+3qt1Ye9smGV9ggoocEAXI5OEGu79A
         G9TK9dikUcMxhF09iihIY7GF5fkahYeLzT/61pxtoaaXSxs27tb2vsrKkARenP2lZcYw
         9OpQ==
X-Gm-Message-State: AOJu0YzXabsnb/dTyrQDpcSt0RjaAomsbfKCeSqA80gi28tc0pMBm+dE
	ePpMumjqbU9VB1XKrz94Ckb1ZY3HJ3KN4IURpFgQY8Z6VAyGT1UOXqrBQgCyqlJLJNrHZ3yOx07
	QG90TVwYEYge/tY33FkibLsbkVR9gGiE=
X-Gm-Gg: AY/fxX7bnCqbDmIqnZFG9nOLSPkA/LBOIGRh53rt/h45y9JknaQwAIk7GcgUy71ODwY
	tFHBXRsO0It+tmyxn1WbULdsTXsODZqZAyIaiLConxRf9oVXDkMQqhSJg8jD+v5fvuspYf7KBhi
	h2N3pX5n+ut37vjOv4X95z3e2ITPszO/UEDvpoZmFWkITKN9h8k67E+L4SwS8AoTtz2tVXdvH0M
	DYQDN+ZhrGodH/V688ADuAYakJi4azXHdYgP5TwFp3aNrhmCzPjmuWLx1kvU4qe6fAF+r/5
X-Google-Smtp-Source: AGHT+IHJeATgeERN6ImLgwGv5Af/NboYW/PhMtatYbo2wvzgwIjo1H9GirVN1eeXjZOqP+AM61xpme+3MfqVgcUdmz8=
X-Received: by 2002:a05:600c:1912:b0:477:89d5:fdac with SMTP id
 5b1f17b1804b1-47d1959f714mr110426525e9.31.1766364999048; Sun, 21 Dec 2025
 16:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208163420.7643-1-ubizjak@gmail.com>
In-Reply-To: <20251208163420.7643-1-ubizjak@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Dec 2025 16:56:28 -0800
X-Gm-Features: AQt7F2o-e4C1nqIZBaTEa9d7hNhbgtNzd41pMCjoBGAWqkrRNVNVkUpYStSyDoo
Message-ID: <CAADnVQLDY+6bGQqpiWCX5uaRBQYCEtnw_LYqpZdeLUE5s22Byw@mail.gmail.com>
Subject: Re: [PATCH] x86/bpf: Avoid emitting LOCK prefix for XCHG atomic ops
To: Uros Bizjak <ubizjak@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 6:34=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> The x86 XCHG instruction is implicitly locked when one of the
> operands is a memory location, making an explicit LOCK prefix
> unnecessary.
>
> Stop emitting the LOCK prefix for BPF_XCHG in the JIT atomic
> read-modify-write helpers. This avoids redundant instruction
> prefixes while preserving correct atomic semantics.
>
> No functional change for other atomic operations.
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied to bpf-next.

