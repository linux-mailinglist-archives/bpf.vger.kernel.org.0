Return-Path: <bpf+bounces-44516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 564FE9C3F45
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 14:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E83B2181A
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DCC19ADBF;
	Mon, 11 Nov 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lupOlfOA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125DA9461;
	Mon, 11 Nov 2024 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330512; cv=none; b=P8z1RJd6TpCfNFKw10VqtTSvgFY9y+x3hFEmmgDWjh6YIsHKrF3T9x2elqhlLd3PWVRzTwI5tm8JmcidNKCI9DKbtDZoptfgfV7Sszi1YKJ0j9/y6ZPwtGs35kjI/a5LJY5O+lmc0pxEx49x3ska8Nuo/AGjl90ue3sbHExm1L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330512; c=relaxed/simple;
	bh=ndQ47GoQQXd6xUUwXGsSCLhDP2/RsFKYe4Ch6kiXxQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAgqwTFVOBproYjceX+ssAT6fkg0aTEAWkiQQgHKFgmmsadFwAMkCKoT/3i8VG0oG9JInKFsCfwaKoycCrnKCrsJzdixJwAX0vb0guRLuqBzRIe9SEI5fZBmE96r5TMiHmkpfobElakbq91b+MxYzjcX+OcQwJ5kwK/HC8rxbU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lupOlfOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F242BC4CECF;
	Mon, 11 Nov 2024 13:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731330511;
	bh=ndQ47GoQQXd6xUUwXGsSCLhDP2/RsFKYe4Ch6kiXxQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lupOlfOARoCIk5u1Q9cL9Y5doiDj/Q/AwTxN1kaJ168zo9doFrY8yw0sb5LNeIsm0
	 BQ8BWIuFETJV6Jl0eMFOpsoEmTlR7BHJ8RJaS0befhbpujuzWsHyIhPhB1hOxL7D5T
	 /226KYUReSQqFKSIeet3MVtIWqCYDoOISsIU5qiULwc9oj8DxQetRXh05HHaIx6MM5
	 S2EPGf57CUbXA74JaYAxr8Zk6wMho4vwLT9QA/cIywuEgAipmAMl0cTMiDaVGmoc4L
	 0VyjUnaqTzu7CYS6sloCaRsHmuxlirYe8noXNa2q4rrDScByvpK6YccVNSxeJwjfPM
	 /8JaW4jbUs4ow==
Message-ID: <7e382bfd-cb1b-4d67-9e2d-a007af86e90d@kernel.org>
Date: Mon, 11 Nov 2024 13:08:25 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix incorrect format specifier for var
To: Luo Yifan <luoyifan@cmss.chinamobile.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241111024814.272940-1-luoyifan@cmss.chinamobile.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241111024814.272940-1-luoyifan@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-11-11 10:48 UTC+0800 ~ Luo Yifan <luoyifan@cmss.chinamobile.com>
> In cases where the SIGNED condition is met, the variable var is still
> used as an unsigned long long. Therefore, the %llu format specifier
> should be used to avoid incorrect data print. This patch fixes it.
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
> ---
>  tools/bpf/bpftool/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 7d2af1ff3..ff58ff85e 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -283,7 +283,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>  				jsonw_end_object(w);
>  			} else {
>  				if (btf_kflag(t))
> -					printf("\n\t'%s' val=%lldLL", name,
> +					printf("\n\t'%s' val=%lluLL", name,
>  					       (unsigned long long)val);
>  				else
>  					printf("\n\t'%s' val=%lluULL", name,


Hi, I don't think your change is correct, it seems to me that we do want
to make the distinction between the signed and unsigned version here (as
for all the other enum cases in the function). What are you trying to
address, did you find a bug in the output or a warning during compilation?

Quentin

