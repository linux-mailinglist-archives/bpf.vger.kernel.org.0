Return-Path: <bpf+bounces-20745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE2A8428B4
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8481C2496A
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C1C86159;
	Tue, 30 Jan 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzIUzbHv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF297F7CF;
	Tue, 30 Jan 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630706; cv=none; b=D2mxzgRj2+8wQX41G+VN8vykmLzSDHWftAgOskzX8dUzTlTkrN2JsD/cwKxY1CLIInIacqen3jRv1fHe7gNrgp5VRU4pmOKZnyVqp4vovb2zkl09ZXhlvP827+u1Jg88iKqfTyEdDw2PKwqC38ikqI/fbaDz3qh3VH4K6g+OyxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630706; c=relaxed/simple;
	bh=DBArYt3O7YbnHeaa2xMlrJjlbXf9RshDy8kF0mLdvX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cMh3JZogFf28cFDkorDMaF9Vfp6oWgSPaOnnbuLA4ECO1PbIXcc/ACD/b/EZYUWS49k1PpH2r6dSHoeQlSzBiuMWjGdvCg5C5A1dWRapSAXgSQtE+TsIUmUHmLqmbpmjZ2EHsEAW6/Q+eC88lY2etNtyySxLGPjDH9Q8R3toOac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzIUzbHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AF6C433C7;
	Tue, 30 Jan 2024 16:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706630706;
	bh=DBArYt3O7YbnHeaa2xMlrJjlbXf9RshDy8kF0mLdvX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uzIUzbHv8e/qwu2wxd1x9xb8oI4wE+j4nDKnk6Jj5SWajcUxbNLbOWtXqu3nh2hsN
	 eFUMmhzZusitpdCNlv4BIsX9HBEIqH81vQpCBFPF/AQBANu4prr/C756V6hBQuEEqm
	 627yJMM/tlADyOzWGO0yvkuJ27YCPptPe7Mem1a1qt0dVLOLM3opqedQ8D/ExmRVcA
	 M/1W13yQ1smp7O3s3TSz6Mc3YsXioSryZ3OgDCHfqVAIvjFmgXJkpsvg4/zn6J/5v8
	 N1Slvg9FPFlsYjo7MB3MCBcI1TGRx4c9HbKZB8JN5paP+IC0QpjM/GJATK74EgtN1B
	 /bQPrDtA6QuQQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 2/4] riscv, bpf: Using kvcalloc to allocate
 cache buffer
In-Reply-To: <20240130040958.230673-3-pulehui@huaweicloud.com>
References: <20240130040958.230673-1-pulehui@huaweicloud.com>
 <20240130040958.230673-3-pulehui@huaweicloud.com>
Date: Tue, 30 Jan 2024 17:05:03 +0100
Message-ID: <87cytiq028.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> It is unnecessary to allocate continuous physical memory for cache
> buffer, and when ebpf program is too large, it may cause memory
> allocation failure.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

