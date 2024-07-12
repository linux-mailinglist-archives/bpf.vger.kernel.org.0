Return-Path: <bpf+bounces-34644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9379392FAB5
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 14:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30068B22650
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 12:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6E116F849;
	Fri, 12 Jul 2024 12:53:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF4DEAC7;
	Fri, 12 Jul 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788835; cv=none; b=VqGuNPYcpIpnIukcIAJtkOBnVGs0U5UHeA0d3V3e5LzZu46WnC4F58um+Ynsho1mwoY96eX7vFRYuFKimhbKD4DuKpb5qu2MAdnDHimbBZBcwROpD7RR1eSPai/k4lWhrAFkr+pJgTW9DanJgb1Vyh1Qbakr9+3mDtQyd3XDC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788835; c=relaxed/simple;
	bh=mSxXOcwPtD87bTwX2HqZczA/PwtF1TIZCMUrydQFC3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cq3S9imuTe8GiSdFBsj0VFDyNZYC47vbRL+VT4XhK1YHYDOIqFVVZqZqRtdEm1RKaNZCPTFzUQR4vGVEBQkndS84TRKwvzo3EoxR8ZYqZ5OLzYiQhXU2bNLPvjMtQT7NZRG7PWM2Ngv1q/pGMU38Imu3S7C+h2HJId//hsdN5AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WLBNv0dScz4wc1;
	Fri, 12 Jul 2024 22:53:51 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Artem Savkov <asavkov@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240517075650.248801-1-asavkov@redhat.com>
References: <20240517075650.248801-1-asavkov@redhat.com>
Subject: Re: [PATCH 0/5] powerpc64/bpf: jit support for cpuv4 instructions
Message-Id: <172078879459.310795.3299316174968073660.b4-ty@ellerman.id.au>
Date: Fri, 12 Jul 2024 22:53:14 +1000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 17 May 2024 09:56:45 +0200, Artem Savkov wrote:
> Add support for recently added cpuv4 instructions fixing test_bpf module
> failures. This is mostly based on 8ecf3c1dab1c6 (powerpc/bpf/32: Fix
> failing test_bpf tests, 2024-03-05)
> 
> Artem Savkov (5):
>   powerpc64/bpf: jit support for 32bit offset jmp instruction
>   powerpc64/bpf: jit support for unconditional byte swap
>   powerpc64/bpf: jit support for sign extended load
>   powerpc64/bpf: jit support for sign extended mov
>   powerpc64/bpf: jit support for signed division and modulo
> 
> [...]

Applied to powerpc/next.

[1/5] powerpc64/bpf: jit support for 32bit offset jmp instruction
      https://git.kernel.org/powerpc/c/3c086ce222cefcf16d412faa10d456161d076796
[2/5] powerpc64/bpf: jit support for unconditional byte swap
      https://git.kernel.org/powerpc/c/a71c0b09a14db72d59c48a8cda7a73032f4d418b
[3/5] powerpc64/bpf: jit support for sign extended load
      https://git.kernel.org/powerpc/c/717756c9c8ddad9f28389185bfb161d4d88e01a4
[4/5] powerpc64/bpf: jit support for sign extended mov
      https://git.kernel.org/powerpc/c/597b1710982d10b8629697e4a548b30d0d93eeed
[5/5] powerpc64/bpf: jit support for signed division and modulo
      https://git.kernel.org/powerpc/c/fde318326daa48a4bb3ca8ee229bac4d14b5bc2a

cheers

