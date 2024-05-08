Return-Path: <bpf+bounces-29077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377CF8BFF1A
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 15:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682A91C21C4C
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6139285269;
	Wed,  8 May 2024 13:42:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92584E04;
	Wed,  8 May 2024 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175721; cv=none; b=EnLCnnGU9ZM/8iXhLmSvnAMeZPev7XI6BLzLkISlb/pZ1eOFE/LLAjMUoZzJjGLQGmMktUdn+cEjaMj+mgxq7QnQWDClAYc18oTKyxiG84aiwJ0qhV6yXbcS44ijpEbbiHIbJfX44KxlEbXIibqs0K6hc+78yQkLQ/ZGaV+5Rtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175721; c=relaxed/simple;
	bh=AYzT8wAUdtGeTkTOdCcgz0/5nuiVd/wcZb8NwNWX1SI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qPbV3iAihrVuAtljHI2w3C4AJVsyiD66VohZZD1orZja+15G8zc/IOiEPquBi7eqvSAwhtFlfAcIwvjya4csulqX5pnvp080Lh9QDVOthAyjz8pcSxTIO/hsbUpR/ssRshlmi5b3CzumRGtrOLJf1P7VxPObbjPzIPD5mL17spQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGXP6RJ9z4xG1;
	Wed,  8 May 2024 23:41:57 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, Hari Bathini <hbathini@linux.ibm.com>
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Martin KaFai Lau <martin.lau@linux.dev>, stable@vger.kernel.org
In-Reply-To: <20240502173205.142794-1-hbathini@linux.ibm.com>
References: <20240502173205.142794-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] powerpc64/bpf: fix tail calls for PCREL addressing
Message-Id: <171517558549.165093.12896481227430118737.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:39:45 +1000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 02 May 2024 23:02:04 +0530, Hari Bathini wrote:
> With PCREL addressing, there is no kernel TOC. So, it is not setup in
> prologue when PCREL addressing is used. But the number of instructions
> to skip on a tail call was not adjusted accordingly. That resulted in
> not so obvious failures while using tailcalls. 'tailcalls' selftest
> crashed the system with the below call trace:
> 
>   bpf_test_run+0xe8/0x3cc (unreliable)
>   bpf_prog_test_run_skb+0x348/0x778
>   __sys_bpf+0xb04/0x2b00
>   sys_bpf+0x28/0x38
>   system_call_exception+0x168/0x340
>   system_call_vectored_common+0x15c/0x2ec
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc64/bpf: fix tail calls for PCREL addressing
      https://git.kernel.org/powerpc/c/2ecfe59cd7de1f202e9af2516a61fbbf93d0bd4d
[2/2] powerpc/bpf: enable kfunc call
      https://git.kernel.org/powerpc/c/61688a82e047a4166436bf2665716cc070572ffa

cheers

