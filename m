Return-Path: <bpf+bounces-45363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DC49D4C29
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C787B2537C
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04F11D3634;
	Thu, 21 Nov 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOgFOKzJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393D3C47B;
	Thu, 21 Nov 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189329; cv=none; b=N1pWmhEpGMEDFp+HjFVehfFS+vTPQvxvVWkA5aQnQJMQmKP5gvV/WQ6OwKiL0lnsS0NZTrEGltT7s2QjSAmHYjl5VWTgSZ4GG/UW9tEfO/W/J0INJl8i/DylqGgWuTh3YDZ09YERymjPt2hY6SCKfBlROgA6xQix35a2BhigDlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189329; c=relaxed/simple;
	bh=ppdP5C6+NmUaAZ8ionJv/HF1F4enkFjg2vCtdGt7v7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVUnuCtlPU7ylS2rFiO0OOoORj2JiCVtvMm/NfRFAM/hBrd3CAYiZtBOMXKoHLRK2Ixjf0FIXEaXviY/KLLNsH3t2bsw6tz3DWvKfLFjeMnHntf1CX2dEBwL27cUgZ1hGg0vRbAjldEFKUL3+/MuQR1OU3XUf6f81YIsPffgD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOgFOKzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641F7C4CECC;
	Thu, 21 Nov 2024 11:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732189329;
	bh=ppdP5C6+NmUaAZ8ionJv/HF1F4enkFjg2vCtdGt7v7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UOgFOKzJ4YH4vyEcqO1kxme7OZ/uMlTNWIMYRR+hH2ApX81p5Zaw0oH/VdC7szNkn
	 okKizIkrBoZGWr5bI3R38iUiZbfe+l1wfq/SN6rKXtT2FjAzU/7FN5G2KP1Axg5gJ6
	 h1PB4KfbU3p2AbVjk+PuRu3PwhV8ILUfBd2tLNnQNborEC9d9MuP8XNTV+DbxSbf+u
	 bgymeHrdLeqSyHM20y/spJOhsZZKXSkVslIOqtYYVP22xY72w4v0vc6xjRNPe8Kwuo
	 imUh9d38inmU8+zvttVAHs+dE58NLSOGsH3qnPOGeszKmT6K4bkwROFlSwVFYkfLhE
	 7H8ksbp3P++uw==
Message-ID: <80690ecf-2d21-460c-b031-8133ca571e7c@kernel.org>
Date: Thu, 21 Nov 2024 11:42:06 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix wrong format output
To: liujing <liujing@cmss.chinamobile.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, liujing <liujing_yewu@cmss.chinamobile.com>
References: <20241121084731.3570-1-liujing@cmss.chinamobile.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241121084731.3570-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-11-21 16:47 UTC+0800 ~ liujing <liujing@cmss.chinamobile.com>
> From: liujing <liujing_yewu@cmss.chinamobile.com>
> 
> %d in format string requires 'int' but the argument type
> of pf is 'unsigned int'.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 5cd503b763d7..5bc442d93456 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -699,7 +699,7 @@ void netfilter_dump_plain(const struct bpf_link_info *info)
>  	if (pfname)
>  		printf("\n\t%s", pfname);
>  	else
> -		printf("\n\tpf: %d", pf);
> +		printf("\n\tpf: %u", pf);
>  
>  	if (hookname)
>  		printf(" %s", hookname);


Thanks, but while at it can you also fix the format specifier for the
other two prints of "lines" in the function (via "p_err()"), please?

Quentin

