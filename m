Return-Path: <bpf+bounces-34794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADFA930E29
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 08:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3661C21026
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 06:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B4518307B;
	Mon, 15 Jul 2024 06:37:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75244C62;
	Mon, 15 Jul 2024 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721025432; cv=none; b=jlfhl8DdVhHFlFNsmDgNCCIckki/tC9QrikeLwrM7q28QxpN6ac+15pPL7TdmJETmylQLBEjcI5MEr4puVGZqoBsOdWH28nOYTqwjdXb67Fje6UQcUMQTUoidiuD+cAUki16LslKXMuyBoNDNJxqdh0sTyV1SRQJnI/Um+XZEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721025432; c=relaxed/simple;
	bh=POZE4bREBlZoPXxt7YmW4lVrRdTHkPM6h2GrqX6vGB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hA2a2mPbiA8x1LhgN+st3KUJqH0gYw/tZFsItLt2b7gmqn7Ge65sq2cspWYMjrqestsb9TeH3pJey7fGd0CuAXztZQ1A8iQQYDSfUucU6avLkDsyox9+XvrKzhSRiP71z4QR0zLGRUQd0sS+BhjccmGdnR9q3WmirctvPVh6Lu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WMstl0Wtcz9sSK;
	Mon, 15 Jul 2024 08:37:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oazn0T8e1H3x; Mon, 15 Jul 2024 08:37:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WMstk6rR7z9sSH;
	Mon, 15 Jul 2024 08:37:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DABB08B76C;
	Mon, 15 Jul 2024 08:37:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id pOSQDiM8HNmP; Mon, 15 Jul 2024 08:37:02 +0200 (CEST)
Received: from [192.168.233.202] (unknown [192.168.233.202])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5EA3A8B763;
	Mon, 15 Jul 2024 08:37:02 +0200 (CEST)
Message-ID: <4cad3dc8-f7b8-4771-ad04-f3524bc03340@csgroup.eu>
Date: Mon, 15 Jul 2024 08:37:01 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: Update powerpc BPF JIT maintainers
To: Naveen N Rao <naveen@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Hari Bathini <hbathini@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <fb6ef126771c70538067709af69d960da3560ce7.1720944897.git.naveen@kernel.org>
 <24fea21d9d4458973aadd6a02bb1bf558b8bd0b2.1720944897.git.naveen@kernel.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <24fea21d9d4458973aadd6a02bb1bf558b8bd0b2.1720944897.git.naveen@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/07/2024 à 10:34, Naveen N Rao a écrit :
> Hari Bathini has been updating and maintaining the powerpc BPF JIT since
> a while now. Christophe Leroy has been doing the same for 32-bit
> powerpc. Add them as maintainers for the powerpc BPF JIT.
> 
> I am no longer actively looking into the powerpc BPF JIT. Change my role
> to that of a reviewer so that I can help with the odd query.
> 
> Signed-off-by: Naveen N Rao <naveen@kernel.org>

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   MAINTAINERS | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 05f14b67cd74..c7a931ee7a2e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3878,8 +3878,10 @@ S:	Odd Fixes
>   F:	drivers/net/ethernet/netronome/nfp/bpf/
>   
>   BPF JIT for POWERPC (32-BIT AND 64-BIT)
> -M:	Naveen N Rao <naveen@kernel.org>
>   M:	Michael Ellerman <mpe@ellerman.id.au>
> +M:	Hari Bathini <hbathini@linux.ibm.com>
> +M:	Christophe Leroy <christophe.leroy@csgroup.eu>
> +R:	Naveen N Rao <naveen@kernel.org>
>   L:	bpf@vger.kernel.org
>   S:	Supported
>   F:	arch/powerpc/net/

