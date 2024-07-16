Return-Path: <bpf+bounces-34907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B025932383
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 12:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA6C1F2222D
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB936197A6E;
	Tue, 16 Jul 2024 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXJBVt/o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DE225D4;
	Tue, 16 Jul 2024 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124148; cv=none; b=M2ePkztwuSagxlac2jKILNI9c/Tssjwny9qZtbQ1N/YxEpDXM2LjGgDSOqF/JpYZ93SPZn3I6ZSKMx9lBuRK1aAkCNaUmrivZf3bnrGnoe3bQW+v+EzgOWj1Tg2mU9Cv5BjUBTrQVSkAXk2ogTMMF/ZRtr/5XyHdiGu085wHDFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124148; c=relaxed/simple;
	bh=2vKo7LaogIOzX8PebynEk4Cv88o2mwsO2aiXrOezlbw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tp0O6datgInvKA7Pv3PAe7UzqQHNIcjIvOx1yiCi2zOZzWks/IpSglKer082QBIBc7ujqejVx+9ANfvItfOBErKXoGDpCIlFtmhlynlWKJibY3SNgq5/yTYX4f/8nww+Omq/0YjwbquDdT6PKhoYzpa7NKfAxA9fdGJbxncvdlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXJBVt/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDAFC4AF09;
	Tue, 16 Jul 2024 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721124147;
	bh=2vKo7LaogIOzX8PebynEk4Cv88o2mwsO2aiXrOezlbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EXJBVt/oidhu7w5LrETdB7V2ZQV8CZpY/qBydFAZ3/A7tdEJZNftMTsbBOnzBl61C
	 P0IXd2ebO6k1P2aj1O3qXiISvThLagopgUYsXrkiyZU9VAL7u0Mnz39XROHw7iSDgj
	 QLstIP1891Tjgtb8ZYscFSgB7+w0X4XWW/Rj1xOSYJ+Y0/0NQH6Wj0kgHv8Qp5GLeK
	 qPEWEqY/ssH3Mqph1/dNuxj3KTdpUgt3RjfPtLPP2mX2ku5FezPBlXLfWWn02XvI0H
	 uCh394WRGlEdz8q1o+leI3Lh5dEGRfwO70VIZTnoSK3ik6druqcgn/5usPp/WCApA8
	 CMKyJri1GG+pQ==
Date: Tue, 16 Jul 2024 19:02:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Naveen N Rao <naveen@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <bpf@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Hari Bathini <hbathini@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: Update email address of Naveen
Message-Id: <20240716190222.f3278a2ef0c6a35bd51cfd63@kernel.org>
In-Reply-To: <fb6ef126771c70538067709af69d960da3560ce7.1720944897.git.naveen@kernel.org>
References: <fb6ef126771c70538067709af69d960da3560ce7.1720944897.git.naveen@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Naveen,

On Sun, 14 Jul 2024 14:04:23 +0530
Naveen N Rao <naveen@kernel.org> wrote:

> I have switched to using my @kernel.org id for my contributions. Update
> MAINTAINERS and mailmap to reflect the same.
> 

Looks good to me. 

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Would powerpc maintainer pick this?

Thanks,


> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
>  .mailmap    | 2 ++
>  MAINTAINERS | 6 +++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 81ac1e17ac3c..289011ebca00 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -473,6 +473,8 @@ Nadia Yvette Chambers <nyc@holomorphy.com> William Lee Irwin III <wli@holomorphy
>  Naoya Horiguchi <nao.horiguchi@gmail.com> <n-horiguchi@ah.jp.nec.com>
>  Naoya Horiguchi <nao.horiguchi@gmail.com> <naoya.horiguchi@nec.com>
>  Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
> +Naveen N Rao <naveen@kernel.org> <naveen.n.rao@linux.ibm.com>
> +Naveen N Rao <naveen@kernel.org> <naveen.n.rao@linux.vnet.ibm.com>
>  Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <quic_neeraju@quicinc.com>
>  Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <neeraju@codeaurora.org>
>  Neil Armstrong <neil.armstrong@linaro.org> <narmstrong@baylibre.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa32e3c035c2..05f14b67cd74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3878,7 +3878,7 @@ S:	Odd Fixes
>  F:	drivers/net/ethernet/netronome/nfp/bpf/
>  
>  BPF JIT for POWERPC (32-BIT AND 64-BIT)
> -M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> +M:	Naveen N Rao <naveen@kernel.org>
>  M:	Michael Ellerman <mpe@ellerman.id.au>
>  L:	bpf@vger.kernel.org
>  S:	Supported
> @@ -12332,7 +12332,7 @@ F:	mm/kmsan/
>  F:	scripts/Makefile.kmsan
>  
>  KPROBES
> -M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> +M:	Naveen N Rao <naveen@kernel.org>
>  M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>  M:	"David S. Miller" <davem@davemloft.net>
>  M:	Masami Hiramatsu <mhiramat@kernel.org>
> @@ -12708,7 +12708,7 @@ LINUX FOR POWERPC (32-BIT AND 64-BIT)
>  M:	Michael Ellerman <mpe@ellerman.id.au>
>  R:	Nicholas Piggin <npiggin@gmail.com>
>  R:	Christophe Leroy <christophe.leroy@csgroup.eu>
> -R:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> +R:	Naveen N Rao <naveen@kernel.org>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
>  W:	https://github.com/linuxppc/wiki/wiki
> 
> base-commit: 582b0e554593e530b1386eacafee6c412c5673cc
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

