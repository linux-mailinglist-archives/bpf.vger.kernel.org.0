Return-Path: <bpf+bounces-45263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05849D3C7C
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 14:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418751F22684
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 13:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F751A7262;
	Wed, 20 Nov 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lcppw3e/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589019F43A;
	Wed, 20 Nov 2024 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109126; cv=none; b=H0b3PZg8Sr+vqwRHrM6iTQmetv02U9GwWT3jfjQZBCOkWQZQLJiGBBZwcONnTgB0A49prMWcc5+fOnQ+DDvEhK2fC2VIGymBRDYkI38kI6Cb8LTO/auH0lXpc2vsQtRZiDZ2AXcP7toe7V+m/QvLs4dNojpcrLIn5qhHlCZ4+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109126; c=relaxed/simple;
	bh=PSieHCoFZ55YqSWubEMSMVrhpXBeC7NlmdRgZteAHjA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VAA4tQtzRDMvoFrnpYKy0Xt4SRfI4VaQyiVFvDkj3OaZHw7naHncS+9bU2bjSZoljTh7oZD5h4KZgsQ5Cr1kF6oOIpDItNT0MXiEMxdycbhwCgquCGZPNbkBOF7kwbJegCdsnT+ta2WBHD5vOdzNtbOb6vm7uBBSFZk9aHW3xws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lcppw3e/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D3EC4CECD;
	Wed, 20 Nov 2024 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732109125;
	bh=PSieHCoFZ55YqSWubEMSMVrhpXBeC7NlmdRgZteAHjA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Lcppw3e/uzSvAp+9e5qUUil3I+8wKhXjxzfzhKZIdKrgn+FQEegBUlvynONjCU1lU
	 TVu3qpC9oIRp224tiyV4pBtlJOHDPhC1ojStRump7eZDsRzFNEW0K9Ia1XlTTc1SAc
	 qjxNSK8YEd+0lL8xAxJEu7p/mbNs+EML2TgSnqs3LhplpS5VvfekZg5Cjn7RO3+4bi
	 dDGF9TvIcGapwcCo4w9oFFKgi+jocd6c1qPKD8SJorHj5VNg+gKmFaSDp60V86QkbB
	 JIsMjudbhLV8inXyAXV60G5uze30q+NQMvNFfYFGsjm2ZjIPBjwp2l4/pJIBR4dHoy
	 o2Zw3D4udBkDw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Quentin Monnet
 <qmo@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, David
 Abdurachmanov <davidlt@rivosinc.com>
Subject: Re: [PATCH] tools: Override makefile ARCH variable if defined, but
 empty
In-Reply-To: <20241106193208.290067-1-bjorn@kernel.org>
References: <20241106193208.290067-1-bjorn@kernel.org>
Date: Wed, 20 Nov 2024 14:25:22 +0100
Message-ID: <87r076nikd.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> There are a number of tools (bpftool, selftests), that require a
> "bootstrap" build. Here, a bootstrap build is a build host variant of
> a target. E.g., assume that you're performing a bpftool cross-build on
> x86 to riscv, a bootstrap build would then be an x86 variant of
> bpftool. The typical way to perform the host build variant, is to pass
> "ARCH=3D" in a sub-make. However, if a variable has been set with a
> command argument, then ordinary assignments in the makefile are
> ignored.
>
> This side-effect results in that ARCH, and variables depending on ARCH
> are not set.
>
> Workaround by overriding ARCH to the host arch, if ARCH is empty.
>
> Fixes: 8859b0da5aac ("tools/bpftool: Fix cross-build")
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Arnaldo/Palmer/Quentin:

A bit unsure what tree this patch should go. It's very important for the
RISC-V builds, so maybe via Palmer's RISC-V tree?

Opinions? Just want to make sure it doesn't fall between any chairs!
:-)


Bj=C3=B6rn

