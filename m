Return-Path: <bpf+bounces-13132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 784217D5108
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 15:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340B228186C
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 13:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8608B29410;
	Tue, 24 Oct 2023 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IuStOsCa"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE49F28E21
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 13:08:53 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0211129
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 06:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QkAB4l0XNSkFYmLmZgrjOxekpkhMm4UqhYP/yafjPdU=; b=IuStOsCa9PSvi1jyLPWuthOpj9
	+t97cU5EwMnkJ/Cnjlug4Da4s2GwbpP/NeCNGe4co8d1Ss1dFS3zlZifGTx3IKQRGq5EKL1o8cWWe
	ox6xqjNMcpcyXupVkhbd5Rc5pJomaw7Cg9bbeNEbTWcar/sPr0FU6dTKpxKcwcoTlwXqA7UATCCmR
	UOn57UP+axbErgGD/W3g66XsPNpWh9HIGhnj0QsYb84Y0Dfw4zYk9/9SvJjZqnralSi5TmHLO/OsO
	pbDRTUw3Oj4GCUYuCNb2psRnRu3Z3TE+3edcZ4fuvWRJF1GHDMS0xxWHRpecHqGUZLnAt+Rnz48xp
	U8D3QMjQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvH9M-000NvS-Ma; Tue, 24 Oct 2023 15:08:49 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvH9M-000Os7-CL; Tue, 24 Oct 2023 15:08:48 +0200
Subject: Re: [PATCH v4 bpf-next 2/7] bpf: derive smin/smax from umin/max
 bounds
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20231022205743.72352-1-andrii@kernel.org>
 <20231022205743.72352-3-andrii@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5fed076b-597d-1721-2430-155d27188dfe@iogearbox.net>
Date: Tue, 24 Oct 2023 15:08:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231022205743.72352-3-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27071/Tue Oct 24 09:43:50 2023)

On 10/22/23 10:57 PM, Andrii Nakryiko wrote:
> Add smin/smax derivation from appropriate umin/umax values. Previously the
> logic was surprisingly asymmetric, trying to derive umin/umax from smin/smax
> (if possible), but not trying to do the same in the other direction. A simple
> addition to __reg64_deduce_bounds() fixes this.

Do you have a concrete example case where bounds get further refined? Might be
useful to add this to the commit description or as comment in the code for future
reference to make this one here more obvious.

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   kernel/bpf/verifier.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f8fca3fbe20f..885dd4a2ff3a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2164,6 +2164,13 @@ static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
>   
>   static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
>   {
> +	/* u64 range forms a valid s64 range (due to matching sign bit),
> +	 * so try to learn from that
> +	 */
> +	if ((s64)reg->umin_value <= (s64)reg->umax_value) {
> +		reg->smin_value = max_t(s64, reg->smin_value, reg->umin_value);
> +		reg->smax_value = min_t(s64, reg->smax_value, reg->umax_value);
> +	}
>   	/* Learn sign from signed bounds.
>   	 * If we cannot cross the sign boundary, then signed and unsigned bounds
>   	 * are the same, so combine.  This works even in the negative case, e.g.
> 


