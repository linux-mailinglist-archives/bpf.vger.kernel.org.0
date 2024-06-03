Return-Path: <bpf+bounces-31177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9228D7A20
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 04:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACB41F21237
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 02:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D468C1E;
	Mon,  3 Jun 2024 02:45:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8574C94;
	Mon,  3 Jun 2024 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717382758; cv=none; b=DJPLI/RpPr1b34/Hz2fzZ6GARSeEQSdUkPSU8CB/olV6cDBS5kRx5ZyCpYx0YYxxglJg3Y7ZqXD5yX58hsq7S/Jn+VWy6F3faIfWMAzyr9qnrqLLRXgyuK5tVPdTqjmp7X6DEn9orxer6/zozHoSfof9Zc3f0iOX20a0WhnD8qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717382758; c=relaxed/simple;
	bh=0poVrFSY2Uk6oDd3H41VjCnbX7bVm6ZgIXHVtooKAGc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r7Qsfu5/3KpSCRyrqrRbZCDqUnQfmCBQ50Fj5/ywZMlSRkLSJT3ahPxXbaueMH8RroNFws2q4at+YrslUKObgUMy4FQAWkwK+w8j0hD+7g1VOcM/gcSQ4hxVIeBXK50EpqGyet41OqfKymQmWWPQstlRsNxx9yotkwCy17nfH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VsylN3kNRz4x10;
	Mon,  3 Jun 2024 12:45:52 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, paulmck@kernel.org, Puranjay Mohan <puranjay@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>
In-Reply-To: <20240513100248.110535-1-puranjay@kernel.org>
References: <20240513100248.110535-1-puranjay@kernel.org>
Subject: Re: [PATCH bpf v3] powerpc/bpf: enforce full ordering for ATOMIC operations with BPF_FETCH
Message-Id: <171738271132.1517513.12789013884540856700.b4-ty@ellerman.id.au>
Date: Mon, 03 Jun 2024 12:45:11 +1000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 10:02:48 +0000, Puranjay Mohan wrote:
> The Linux Kernel Memory Model [1][2] requires RMW operations that have a
> return value to be fully ordered.
> 
> BPF atomic operations with BPF_FETCH (including BPF_XCHG and
> BPF_CMPXCHG) return a value back so they need to be JITed to fully
> ordered operations. POWERPC currently emits relaxed operations for
> these.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/bpf: enforce full ordering for ATOMIC operations with BPF_FETCH
      https://git.kernel.org/powerpc/c/b1e7cee96127468c2483cf10c2899c9b5cf79bf8

cheers

