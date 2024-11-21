Return-Path: <bpf+bounces-45358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7069D4BE5
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285DF1F215EF
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28E01D3634;
	Thu, 21 Nov 2024 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd4eyciM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390ED1D2F43;
	Thu, 21 Nov 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188605; cv=none; b=JGDauanRRSF1IsROGwy990E15dBkzuzShJxuVrq6qQJZEP/AkvKNaFOQ1lAL+hiptajsDb+wnck/QhIyA7ssHJjHSrPdzBMHI+7Ncb+Slorz9WTb+3q7syhpb/PveI7m7rAQr/ZE3/fNSabkpa8mJgEh7eQ/ggCk2853EJisa68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188605; c=relaxed/simple;
	bh=/BU9PGY932wn21LtjDKae9aH7zv26C720CtlUCkyHBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HltZozY5gZz6p0fldzgDWc0IkUrohjGH3dO88Q3Pdj3zsX3IbfhAPXo80QKXciXZgJRGOkoTzMMudvD2JxxQ8OxNV0A98bnoULR/wQdH3l+pYKJNoBk6MrgWUen29HZhFqqtPo3OCDU1nzZQymeGCHzRIRxIGOd4hauW7A+NKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd4eyciM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5165C4CECC;
	Thu, 21 Nov 2024 11:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732188604;
	bh=/BU9PGY932wn21LtjDKae9aH7zv26C720CtlUCkyHBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zd4eyciMfSEaozRhA8GrXfvxk/aawYnsgpbdId8ex/F2P5cMSVLEpBJLigXkya97V
	 djqpFuXYoVJerVXHKtA+a865Ns5S8uAZthRmIRWlBkcArma7p7PCJUXXMdfwiNb8q/
	 NvOX3JtOeN4ssfiyvcRW8T0NQC4qRG50bjHIO750IJhA7nyr0Yp1frG95VjXxXg+Em
	 R+LuDdfWhEx4xb7K3ht5h8sebQJs47l28dLF5qc6qfXyDuwOmES3doxI+lr21EzOqI
	 G4iXjnKg6nN4uwHikFbGEG7H0fD4xTpCKkPI6OlZomHEEDAJAqaFiFjynv9MVyrdvq
	 aVyNf7zGd+2kw==
Message-ID: <6a960374-0cd2-4de9-8fc6-c8fe21097b6b@kernel.org>
Date: Thu, 21 Nov 2024 11:29:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: Override makefile ARCH variable if defined, but
 empty
To: Namhyung Kim <namhyung@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, David Abdurachmanov <davidlt@rivosinc.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
References: <20241106193208.290067-1-bjorn@kernel.org>
 <87r076nikd.fsf@all.your.base.are.belong.to.us> <Zz7Ng9CzrF_ciAz-@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <Zz7Ng9CzrF_ciAz-@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-11-20 22:04 UTC-0800 ~ Namhyung Kim <namhyung@kernel.org>
> On Wed, Nov 20, 2024 at 02:25:22PM +0100, Björn Töpel wrote:
>> Björn Töpel <bjorn@kernel.org> writes:
>>
>>> From: Björn Töpel <bjorn@rivosinc.com>
>>>
>>> There are a number of tools (bpftool, selftests), that require a
>>> "bootstrap" build. Here, a bootstrap build is a build host variant of
>>> a target. E.g., assume that you're performing a bpftool cross-build on
>>> x86 to riscv, a bootstrap build would then be an x86 variant of
>>> bpftool. The typical way to perform the host build variant, is to pass
>>> "ARCH=" in a sub-make. However, if a variable has been set with a
>>> command argument, then ordinary assignments in the makefile are
>>> ignored.
>>>
>>> This side-effect results in that ARCH, and variables depending on ARCH
>>> are not set.
>>>
>>> Workaround by overriding ARCH to the host arch, if ARCH is empty.
>>>
>>> Fixes: 8859b0da5aac ("tools/bpftool: Fix cross-build")
>>> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>


Acked-by: Quentin Monnet <qmo@kernel.org>


>> Arnaldo/Palmer/Quentin:
>>
>> A bit unsure what tree this patch should go. It's very important for the
>> RISC-V builds, so maybe via Palmer's RISC-V tree?
> 
> I think it'd be best to route this through the bpf tree as it seems the
> main target is bpftool.  But given the size and the scope of the change,
> it should be fine with perf-tools or RISC-V tree.


The bpf tree would make sense to me as well (but I don't merge patches
myself; let me Cc BPF maintainers).

Quentin

