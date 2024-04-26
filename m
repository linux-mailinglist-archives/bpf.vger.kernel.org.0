Return-Path: <bpf+bounces-27919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4C28B3555
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 12:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8835B2820E2
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 10:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88C13BC18;
	Fri, 26 Apr 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVssEkSN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E15A109;
	Fri, 26 Apr 2024 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714127482; cv=none; b=GnHEhEDQ/Up0Qu3OU+9dgqFRRtcw7X7bQoFKsBciFMcQrwq/ZdKy/Ivzwj/FKukpT3WJg8f2/pQY9dOStMJt6kCfcR0tJLGz9S2WmoHUh24c1fXBS7/S55jPnvOCTZFd5yQLXE1+G/Sv1+PXzqOpHkgLWx1oHf0KCJBiLUOm2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714127482; c=relaxed/simple;
	bh=M9Mk/1LclGdhJWimwogrI2nrrKOT8uLmGIKZSCfYvHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=odKfZT/9plY1qjaTWuGKjYfXGoKPjkMGqGFrtsD1OSDBfZP2BS5yY67zJwxJHhWG9ObBEBFIc8k8gZLLTV/Yf+IQ+P0ERUFbr1FlLgY6+W8m+8q91sQOV0UxQ2B1cwC1R7BPSeU6GWkAHM+D25jc+Q2gjHC9AChg0q4SE/45uKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVssEkSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C935DC113CD;
	Fri, 26 Apr 2024 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714127481;
	bh=M9Mk/1LclGdhJWimwogrI2nrrKOT8uLmGIKZSCfYvHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tVssEkSN4mreZLlloFd3oP+7+VkHU/QrDtXMKyNrGD3oLEEbH5Yyd01l6r23qCcAl
	 0aR+A6vh60gnuc9y0Is43qFML3eigsJL92H5eLrl4tlTtEKWAIwq/3eF8hXeHOkalC
	 Kd2SG+J5Lc+VFqd0qJHGBP0TN9Ewb4y9GXSAY1FWvAJzwUteJe7+n13KeNsubfIGyu
	 MIjvMT2g+6VWvayx4EZ1RE+fYF04LG62wtMQv2g+njP7XWH2IXmkPOwiM0l+8FqJPN
	 mfhddeFoMtzhL/t8Pr2xAfZCtSrmd23fRd3splmKAZxu5qCKqXXAtC1rZ/uyYKPfLC
	 ypv2zWsYIqTvw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>, Arnaldo Carvalho de Melo
 <acme@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: linux-kernel@vger.kernel.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
 Anders Roxell <anders.roxell@linaro.org>, llvm@lists.linux.dev, Jiri Olsa
 <olsajiri@gmail.com>
Subject: Re: [PATCH v2] tools/build: Add clang cross-compilation flags to
 feature detection
In-Reply-To: <ZUOWcXDpCOzxbFW0@krava>
References: <20231102103252.247147-1-bjorn@kernel.org> <ZUOWcXDpCOzxbFW0@krava>
Date: Fri, 26 Apr 2024 12:31:17 +0200
Message-ID: <87o79wxvnu.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jiri Olsa <olsajiri@gmail.com> writes:

> On Thu, Nov 02, 2023 at 11:32:52AM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> When a tool cross-build has LLVM=3D1 set, the clang cross-compilation
>> flags are not passed to the feature detection build system. This
>> results in the host's features are detected instead of the targets.
>>=20
>> E.g, triggering a cross-build of bpftool:
>>=20
>>   cd tools/bpf/bpftool
>>   make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- LLVM=3D1
>>=20
>> would report the host's, and not the target's features.
>>=20
>> Correct the issue by passing the CLANG_CROSS_FLAGS variable to the
>> feature detection makefile.
>>=20
>> Fixes: cebdb7374577 ("tools: Help cross-building with clang")
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Waking up the dead!

Arnaldo, Jean-Philippe: I'm still stung by what this patch fixes. LMK
what you need from me/this patch to pick it up.


Cheers,
Bj=C3=B6rn

