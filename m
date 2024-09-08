Return-Path: <bpf+bounces-39206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CAA970964
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 21:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63681281B2D
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 19:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A33178CEA;
	Sun,  8 Sep 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzY+I+E6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F441114;
	Sun,  8 Sep 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823207; cv=none; b=setIgbZZ9L5UBY0ieLe/357baDaHaNG7RlgRKyQAaIFqZWdiyFJKNQtbneETqag035wIeIne3fr54sjcAOkRpthgUMAd1wl0gT7TohZBbFkyMdSRnfxoe44ToWs0XLIDeDFWK2JUiq10o+yC8Jv/wDAdNO0/x4+QaIpCTdERXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823207; c=relaxed/simple;
	bh=fPzRhjNMvX2wVQZqO7nLiFSOLSviBH/ZaPY/0H3vcjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h99CX6d66NJccG019sSeF/y3T6i9H7e/gXjv+LhUVmd2gts9kuN8x3h2Qqe/US1bmGCgO7u0n+h2+vhW/4rAzu4Jx8s2V7Yk/LE9kVJkawyos32I66oD31O5x2pDKAPgLSODptSP0YSb8/JXkskHeyYMJ9tXSOtgrBXBIv7U8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzY+I+E6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE16C4CECA;
	Sun,  8 Sep 2024 19:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725823206;
	bh=fPzRhjNMvX2wVQZqO7nLiFSOLSviBH/ZaPY/0H3vcjw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VzY+I+E6IvXzqIcugLikR2Kl8TDc9RGC95OA/VWBKZEjqTMNfnr/5xCQNJGTY58/N
	 0tJdwOhj7URs1g/yO2Pgm8hUH9YdSC3cjc37ZqdEuZFP1WY59eYCd5IUBcfaChKpKg
	 3Hps6usetCMrUL6t3ZO/+7k8RbGkPqeJMGsq1N+SuiYTxSiXVmB3ZaIyBeHuxpWTaA
	 bpPug1eu0o5sgpt9YGb70bJXkaJEFe1WBkiO9hu3htJ+oS2ZzFG5gIiZfAHs3ddhJN
	 vKpyV1D9mDnGQ4MylXY+3PAz66BIog5itMQJzXmAKIygUoCYsvhuJn0s9WLZJDJEaF
	 Y6jkHYxUm2T/Q==
Message-ID: <c63c6c0d-80f0-4e44-8e02-b12ff365f4eb@kernel.org>
Date: Sun, 8 Sep 2024 20:20:01 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] bpftool: Fix a typo
To: Andrew Kreimer <algonell@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20240907231028.53027-1-algonell@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240907231028.53027-1-algonell@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/09/2024 00:10, Andrew Kreimer wrote:
> Fix a typo in documentation.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-gen.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> index c768e6d4ae09..6c3f98c64cee 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> @@ -172,7 +172,7 @@ bpftool gen min_core_btf *INPUT* *OUTPUT* *OBJECT* [*OBJECT*...]
>      CO-RE based application, turning the application portable to different
>      kernel versions.
>  
> -    Check examples bellow for more information how to use it.
> +    Check examples below for more information how to use it.
Thanks! Since we're at it, would you mind fixing the rest of the
sentence, too?
“Check _the_ examples below for more information _on_ how to use it”

Quentin

