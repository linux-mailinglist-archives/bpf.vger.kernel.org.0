Return-Path: <bpf+bounces-29076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3F48BFF0B
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 15:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD47928C57D
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD7A84E1B;
	Wed,  8 May 2024 13:41:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A5F7CF18;
	Wed,  8 May 2024 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175717; cv=none; b=G5sD5I/jkfmUA9l3m67vKoWUw4vBHQPthbySzbwpEfbSitloajMG71+ADV2Y+XUN5ITUj/PElwK7Wv7+YR0hvtzOgoYESYDG+8KcX7i1QrXvtLLrV7EeIUm+c80xS2G0nDw878Sxb3ZoYpzwoZs5wLojuXCLPLUUl2521udttxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175717; c=relaxed/simple;
	bh=l58XFGkABLDTN6QAKvg2jQCCAeS3M9CarSf2paN6xx8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I1WVndIjJVZoPyhYokxavweGVZHlV4iuwRbhXM6/SYA7DE3AyjZYeZMSoiAqz9+LZnGRF4uAXEZPTVf5y4IaIUmqcU1dmLBzVbLUF/WxdUKllgSwMFfsz/S1unt7VWlvJfUPRdG+Ho2qprOERDM6IeQiPIMJpq4O1JnQtmY+xbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGXK4YBmz4x3k;
	Wed,  8 May 2024 23:41:53 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <91de862dda99d170697eb79ffb478678af7e0b27.1709652689.git.christophe.leroy@csgroup.eu>
References: <91de862dda99d170697eb79ffb478678af7e0b27.1709652689.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/bpf/32: Fix failing test_bpf tests
Message-Id: <171517558551.165093.13897722350418535881.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:39:45 +1000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 05 Mar 2024 16:36:23 +0100, Christophe Leroy wrote:
> Recent additions in BPF like cpu v4 instructions, test_bpf module
> exhibits the following failures:
> 
> 	test_bpf: #82 ALU_MOVSX | BPF_B jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> 	test_bpf: #83 ALU_MOVSX | BPF_H jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> 	test_bpf: #84 ALU64_MOVSX | BPF_B jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> 	test_bpf: #85 ALU64_MOVSX | BPF_H jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> 	test_bpf: #86 ALU64_MOVSX | BPF_W jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/bpf/32: Fix failing test_bpf tests
      https://git.kernel.org/powerpc/c/8ecf3c1dab1c675721d3d0255556abe2306fa340

cheers

