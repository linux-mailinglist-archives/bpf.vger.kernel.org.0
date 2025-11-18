Return-Path: <bpf+bounces-74950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15587C69543
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CAF342BB5E
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858B034F486;
	Tue, 18 Nov 2025 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZSI97HY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3C31B815;
	Tue, 18 Nov 2025 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468183; cv=none; b=cQ6h6ZUYS5Me6zbm02AWwN+lcx7mqvgETv91m2VZtZdZ0cUlUWTdrnLxqYnMa1wBO//cjeT2fAWe7oDVHAqEXqnsV4hegLEzmIF/zzOte7GkrqipBdbOYef8H0+mR2u9b2OzX5w0KDZZ7NBLbbklszYPfSVzG2wwfMc5v2Q0FGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468183; c=relaxed/simple;
	bh=NDB8zwmWSTVU1id8kMQajfeIzzTo3lZzUCYfR5Bj2DU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D0DXIlNAyW2AExwbCet7b7CkoZqe2BtHvYr2U9Dp3wa68ibp+PB8w8McHX5xSiLq8Y98XCN3ud8VNa6iiKAEzCodUY50qGu8/g04uOXtDBs2uW3BpHeGr15gce+GGXPkGJ6hZyMpfC3nXbosW9kqXx853o9HD/RHL2tBJsurzRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZSI97HY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFC3C2BC87;
	Tue, 18 Nov 2025 12:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763468181;
	bh=NDB8zwmWSTVU1id8kMQajfeIzzTo3lZzUCYfR5Bj2DU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tZSI97HYHNPl3L5KUfMb0dR2U/wzbcuAVrIyCM+H/wCGCfA2wLZHJ4RGsLch320Po
	 2yoQr43fJVMkBUZxQxd3tLZbOO4CZ14+mPIxzGrDRo7lPxFUNPGuPAsVxYcgxLN+jI
	 cBSBDcmOPiFmzpSl7nX0M9/3boiGVlava4RfB0/6t9jpP9sNd1GSPtwpJLLSQ1HasJ
	 9dVgZOUGZLTkItL9p9rtPj05L7O6tmqq5K6X7rBZ4NDXSjcqBTamOJykSybjx76/+q
	 lC8FabexGv7q2NLxXGDWr1AaISDLUp/JGBxuiN5AYU4weEv7vJ7mg0YImxN0gbu2zH
	 MQoRvbG+okbAg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Inline helper in powerpc JIT
In-Reply-To: <cover.1762422548.git.skb99@linux.ibm.com>
References: <cover.1762422548.git.skb99@linux.ibm.com>
Date: Tue, 18 Nov 2025 12:16:16 +0000
Message-ID: <mb61pbjkzmt7z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Saket Kumar Bhaskar <skb99@linux.ibm.com> writes:

> This series add support for internal only per-CPU instructions,
> inlines the bpf_get_smp_processor_id() and bpf_get_current_task()
> helper calls for powerpc BPF JIT.
>
> Changes since v1:
> * Addressed Christophe's comments.
> * Inlined bpf_get_current_task() as well.
>
> v1: https://lore.kernel.org/all/20250311160955.825647-1-skb99@linux.ibm.com/ 
>
> Saket Kumar Bhaskar (2):
>   powerpc64/bpf: Support internal-only MOV instruction to resolve
>     per-CPU addrs
>   powerpc64/bpf: Inline bpf_get_smp_processor_id() and
>     bpf_get_current_task()
>
>  arch/powerpc/net/bpf_jit_comp.c   | 16 ++++++++++++++++
>  arch/powerpc/net/bpf_jit_comp64.c | 19 +++++++++++++++++++
>  2 files changed, 35 insertions(+)

For both the patches:

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>

