Return-Path: <bpf+bounces-26446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634B689FB16
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 17:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CD9287B73
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5FE16DEC0;
	Wed, 10 Apr 2024 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gyujga+H"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B813A414
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761799; cv=none; b=kXI0SBooWRix4XSWsu33Dy4iG5vcq7nCpuaQ2HBgxsxCmLeu6i/MMrLeaxeklgkeuNUqWJ71iayZ0LpLrqzyIPdaGIzgOpLjnSAfuY4F1UDrBzIyPk0l/7oDZhr4EVrX1P+8rdlBLhmGHEIpa3zRnhxvQtBKlkuwMleDgqOEr64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761799; c=relaxed/simple;
	bh=JBToPHsKyA1IBRYoalpk1N7HunyLQxVk5LEZ5W4MlOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGFrQRPz9/nFINHaW+QqlCjnt0V0T5FGjv40FG/kbT9wQQAJsua2+B6SQQvrXJRgtaWKb+WlU18q3z1+yQ40NstrgcEcJ0QS4iZXyVDGFuZyp/MaHTknSQAWezSAG0bYy8K/KVgs1vZA6ep1yQCnOHD7Ah595+lH/G+deBsyfSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gyujga+H; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4bfc3494-a3e9-4b4c-9d93-fa1049a10235@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712761795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cy4xebQzWg8ALuOLJMZcZOAIDsJ9HQugVvvvnFO1U9g=;
	b=gyujga+HaZvsTQ7G3DmgTeft/hcI9fL/iS3AKqRtU5+stijNTdql8qDujHFNsjLn8ti84u
	LaATm+Wy2MzAHhA6g3V5ezs1I5QHVmJxvhUjpyeVBtlJdHU/Q2ueaMlrY+dJMoldGCfTYB
	ojlT6FDWBvgWlw+0ANXTkxkOOiKzkc8=
Date: Wed, 10 Apr 2024 08:09:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: strnchr not suitable for getting NUL-terminator
Content-Language: en-GB
To: Edward Adam Davis <eadavis@qq.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com
References: <tencent_EC72CD3879FA6F102FC56E4495F0E822EC0A@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_EC72CD3879FA6F102FC56E4495F0E822EC0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/9/24 5:33 PM, Edward Adam Davis wrote:
> The strnchr() is not suitable for obtaining the end of a string with a length
> exceeding 1 and ending with a NUL character.

Could you give more detailed explanation with specific examples? I think
strnchr() does the right thing here. Note that if fmt is not NULL,
strnchrnul() never returns NULL pointer so in the change below,
'if (!fmt_end)' will be always false.

>
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   kernel/bpf/helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 449b9a5d3fe3..07490eba24fe 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -826,7 +826,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
>   	u64 cur_arg;
>   	char fmt_ptype, cur_ip[16], ip_spec[] = "%pXX";
>   
> -	fmt_end = strnchr(fmt, fmt_size, 0);
> +	fmt_end = strnchrnul(fmt, fmt_size, 0);
>   	if (!fmt_end)
>   		return -EINVAL;
>   	fmt_size = fmt_end - fmt;

