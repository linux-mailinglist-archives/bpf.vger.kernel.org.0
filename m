Return-Path: <bpf+bounces-38752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39FF969419
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 08:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E4BB22F09
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 06:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAAE1D54C6;
	Tue,  3 Sep 2024 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="abSKDFpD"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF41CF29C
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346095; cv=none; b=g+RFlxZDDxgAFKw+XNbHGxQyvd4qu9ohiOwCaMo4P6pjQiFhz7DmpQaECDGhgtOVfoGSSxztcJySOZjBshPGam0jul69kdAMpiaYsfa8c+hGA3fZoDl5t+28ytClXimworhKED2mHzGGK4gX9KQJOcHggLDkHnsPCy9bYpGGyEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346095; c=relaxed/simple;
	bh=83DBEAYwv/cWhybTTQoVLFwLIo4NBPh72zhoBthSdkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ST/les3AtVNJ/y1tgFW/i0G9+nTjr66jz90q01sMKeqe7bNLS2/KsAg8IcTwMCD3+j5fQSrnA1wHTAA1OIm3pP8AbeJ5V+Pn7ERtBbzYy47cdeBx7iHxs/u7bgHiwqahfl6CopTofiO9qIgnxtT9eW9VCzSPm5XkQTe+G1rajFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=abSKDFpD; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725346091;
	bh=M3epQsUKJhzbx4cflHZxn6z4gD7cw0fgFe7nIBjpPlU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=abSKDFpD91bF6JK7v3JWap7RqTbP1xIyPnqTojelNm86rzr7LfsH+onAz9HFy4aFF
	 3aYhWkxUmHPDaYksi4L/FJqnCUEfKZYcTJf/Cz47dpigzLOUoiBvxLekE2iELXn60B
	 BYRZJZ2EUMR3MRmN73WJZFPEUrjzfLtSHJa55tS4ik3eWOou7Gs2prbeZhPHNGQZWU
	 ZGxf9swVExNqkogGyTZX9eeUVNtU2FXzSZmnAdQ6yRiOUOqEZUV1T5sbVp5arfYTbY
	 GfJpc4U81Q5Ls6BrsrSgWbOG0ih889sG0OziCv1MyPfwp8Sp7ITALf42QwDEugVYch
	 tvm4slcVDP6Rw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WybmW2CH4z4wc4;
	Tue,  3 Sep 2024 16:48:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Abhishek Dubey <adubey@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mhiramat@kernel.org 
Cc: naveen@kernel.org, hbathini@linux.ibm.com, npiggin@gmail.com,
 bpf@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: Re: [PATCH v4 RESEND] powerpc: Replace kretprobe code with rethook
 on powerpc
In-Reply-To: <20240830113131.7597-1-adubey@linux.ibm.com>
References: <20240830113131.7597-1-adubey@linux.ibm.com>
Date: Tue, 03 Sep 2024 16:48:10 +1000
Message-ID: <871q216xn9.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abhishek Dubey <adubey@linux.ibm.com> writes:
> This is an adaptation of commit f3a112c0c40d ("x86,rethook,kprobes:
> Replace kretprobe with rethook on x86") to powerpc.
>
> Rethook follows the existing kretprobe implementation, but separates
> it from kprobes so that it can be used by fprobe (ftrace-based
> function entry/exit probes). As such, this patch also enables fprobe
> to work on powerpc. The only other change compared to the existing
> kretprobe implementation is doing the return address fixup in
> arch_rethook_fixup_return().
>
> Reference to other archs:
> commit b57c2f124098 ("riscv: add riscv rethook implementation")
> commit 7b0a096436c2 ("LoongArch: Replace kretprobe with rethook")
>
> Note:
> =====
>
> In future, rethook will be only for kretprobe, and kretprobe
> will be replaced by fprobe.
>
> https://lore.kernel.org/all/172000134410.63468.13742222887213469474.stgit@devnote2/
>
> We will	adapt the above	implementation for powerpc once its upstream.
> Until then, we can have	this implementation of rethook to serve
> current	kretprobe usecases.
>
> Reviewed-by: Naveen Rao <naveen@kernel.org>
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---

Was Masami's objection to v3 resolved?

cheers

