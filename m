Return-Path: <bpf+bounces-23050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB09686CC3B
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 15:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784081F23653
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 14:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DCC13776C;
	Thu, 29 Feb 2024 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="hUjNLrhA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D62137774
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218753; cv=none; b=a1aCKTDMy1rBxkMT/ndysHOyoAJhIezbmq7HDnh0LpEwE1OSim8pWDd0oXDYz3TZfEebKhOKlmK2+HVB//TPGWHs23KkDnseCDVQaIhwzN/LSr1+4HXUjYuOpMvAYBw1ag384qeTZUmMgWK1AhK8MzBfCOoOkJghQeqtjPo6/QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218753; c=relaxed/simple;
	bh=t45ZwhnZa1PSnMFLwJNxO6Nrnhs1cuWq9t11gdbzq7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cv63FOFwbLik01A2YOJWHwsGwzSrlzwPECI9hYLVAoZWyJAronpuBfpZFrEWWnUrAW2qhzVVIlp74ZXdMEUExqXxHVFg/8cWBZ5RwmzwTlAyawR1k1J2hwqscaRnjzXVnXFrPdEI5S3pKcBYDXLztUgMzl4v7iYnQ19Z3NTWrkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=hUjNLrhA; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51320536bddso931397e87.3
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 06:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1709218749; x=1709823549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ho9X7jcLqagbeeH0onl+0K7F3oqFjrKaBZiI6+CTBhk=;
        b=hUjNLrhAe8+hUVhLN4oPIOUM+kbNinw/1EGz3Sk8f6Y2Dn72MHPxT1XyfmaDbMk0xR
         ntKKOxjuDMJ5ivscvUma6Mm6XSfv0n2PzBj+5jyJ3aoyOCufquPJ0EtPqS8SDYJlQNfP
         eo3pRqlRUPM2RdzNlmISf5iAKmJvIBpk6oQSPNN0x8/r6ATEshUsAcW06v72EVyLtOnJ
         WCg2MWlIOUqTrMQD4YzTG8wCtu4u10zqHjbTwRLHzaCOoe85IvUSwB1M+6DyJcwiK4CN
         Ud/cDsN9oOtCYh71V31xLoFmhHGlm7gatHqO9ij9cVEMgxVICfJzl53wpxvJNU9yqC/j
         kEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709218749; x=1709823549;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ho9X7jcLqagbeeH0onl+0K7F3oqFjrKaBZiI6+CTBhk=;
        b=DvnqGD/WyhXLidRmphAm1Snl+/LNWWVqiG41pgiFbRt4MDQ8755XjD0HbkuKhVEVDU
         WJZ/HRYk/rur2vTL1UPcZee4y6lL37oSskOsHaV4nZTCZ1i4pkn5QD1TrGNVNGR9lg+7
         ZKx33syCd3B4tS0R6wJjSKV+nzLhqFU/VqK3OVatDx4bPEpLlLE4tkGS60/6JKH0SiRe
         L6Tv3fv87sLHC/tRzArNaalEWQYIyXJ3vdP9oqOJw6fUvOPj1KBmTQtnDCO3wHFf2HBs
         nTLE42gbWps97Ibxxo22P4apy/gZrHxRTfA8WoeE/WMiF5z60fMDC9C5PZ7p+dhJGnOt
         y8mw==
X-Forwarded-Encrypted: i=1; AJvYcCXxoT1pakPKCib4sb6czjZJmE7rmKYfivr+M8m42TmOR5Ijg5jAXMa6JW36imDb2zUb4oFVPQokTCCiVdbRJaVzlA0c
X-Gm-Message-State: AOJu0YzNE032dn5HCibBBSxe6O5OTff9qyygMAPMwgKPfZLhjv1kC1Hw
	8j3dJE9MV3EQUtM+2m4U+hWB9WsZD/XP5eO8W5nplqtz8tIFLkLYeQBZBPmxYCuQsXZ+Fve4RY8
	CY18=
X-Google-Smtp-Source: AGHT+IHH+E8fXWE62Tud3X1qGIU7qsF8BIm4opulsrTzyFXg6ve/gmnTcpzJbRsLLJRuzWJpzIrNSw==
X-Received: by 2002:ac2:55a6:0:b0:513:28b9:76da with SMTP id y6-20020ac255a6000000b0051328b976damr1125229lfg.46.1709218749182;
        Thu, 29 Feb 2024 06:59:09 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:b9bc:a5f9:b673:94cc? ([2a02:8011:e80c:0:b9bc:a5f9:b673:94cc])
        by smtp.gmail.com with ESMTPSA id q13-20020a5d61cd000000b0033e11ff6284sm1411971wrv.12.2024.02.29.06.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 06:59:08 -0800 (PST)
Message-ID: <d61e8537-e291-434c-b401-2b020b2b610d@isovalent.com>
Date: Thu, 29 Feb 2024 14:59:07 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Mount bpffs on provided dir instead of
 parent dir
Content-Language: en-GB
To: Sahil Siddiq <icegambit91@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20240229130543.17491-1-icegambit91@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240229130543.17491-1-icegambit91@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-02-29 13:05 UTC+0000 ~ Sahil Siddiq <icegambit91@gmail.com>
> When pinning programs/objects under PATH (eg: during "bpftool prog
> loadall") the bpffs is mounted on the parent dir of PATH in the
> following situations:
> - the given dir exists but it is not bpffs.
> - the given dir doesn't exist and the parent dir is not bpffs.
> 
> Mounting on the parent dir can also have the unintentional side-
> effect of hiding other files located under the parent dir.
> 
> If the given dir exists but is not bpffs, then the bpffs should
> be mounted on the given dir and not its parent dir.
> 
> Similarly, if the given dir doesn't exist and its parent dir is not
> bpffs, then the given dir should be created and the bpffs should be
> mounted on this new dir.
> 
> Link: https://lore.kernel.org/bpf/2da44d24-74ae-a564-1764-afccf395eeec@isovalent.com/T/#t
> 
> Closes: https://github.com/libbpf/bpftool/issues/100
> 

Fixes: 2a36c26fe3b8 ("bpftool: Support bpffs mountpoint as pin path for prog loadall")

> Signed-off-by: Sahil Siddiq <icegambit91@gmail.com>
> ---
>  tools/bpf/bpftool/common.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index cc6e6aae2447..6b2c3e82c19e 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -254,6 +254,17 @@ int mount_bpffs_for_pin(const char *name, bool is_dir)
>  	if (is_dir && is_bpffs(name))
>  		return err;
>  
> +	if (is_dir && access(name, F_OK) != -1) {
> +		err = mnt_fs(name, "bpf", err_str, ERR_MAX_LEN);
> +		if (err) {
> +			err_str[ERR_MAX_LEN - 1] = '\0';
> +			p_err("can't mount BPF file system to pin the object (%s): %s",

The error string should be updated, we're not trying to pin one object
file here but to mount the bpffs on a directory to pin several objects.

> +				name, err_str);

Formatting nit: "name" should be aligned with the argument from the line
above (the opening double quote). You can catch this by running
"./scripts/checkpatch.pl --strict" on your patch/commit.

> +		}
> +
> +		return err;
> +	}

This block above cannot be before the check on "block_mount", or we will
ignore the "--nomount" option if the user passes it.

Perhaps it would be clearer to split the logics of mount_bpffs_for_pin()
into two subfunctions, one for directories, one for file paths. This way
we would avoid to call malloc() and dirname() when "name" is already a
directory, and it would be easier to follow the different cases.

> +
>  	file = malloc(strlen(name) + 1);
>  	if (!file) {
>  		p_err("mem alloc failed");
> @@ -273,7 +284,17 @@ int mount_bpffs_for_pin(const char *name, bool is_dir)
>  		goto out_free;
>  	}
>  
> -	err = mnt_fs(dir, "bpf", err_str, ERR_MAX_LEN);
> +	if (is_dir) {
> +		err = mkdir(name, 0700);
> +		if (err) {
> +			err_str[ERR_MAX_LEN - 1] = '\0';
> +			p_err("failed to mkdir (%s): %s",
> +				name, err_str);

We use err_str to pass it to mnt_fs, but we cannot use it here (it is
not set by mkdir). We probably want "strerror(errno)" instead.

+ Formatting nit: "name" should be aligned with the opening quote (use
spaces for the last part of the indentation).

> +			goto out_free;
> +		}
> +	}
> +
> +	err = mnt_fs(is_dir ? name : dir, "bpf", err_str, ERR_MAX_LEN);
>  	if (err) {
>  		err_str[ERR_MAX_LEN - 1] = '\0';
>  		p_err("can't mount BPF file system to pin the object (%s): %s",

Thanks for this work!
Quentin

