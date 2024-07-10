Return-Path: <bpf+bounces-34404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ABA92D4FB
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 17:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E8E1F2293C
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 15:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF211946CD;
	Wed, 10 Jul 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CkqcZUIA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB65436AF8
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625408; cv=none; b=sOebYumbiR4bNWgL8zgGO9qiC5gqRG8bsghvTWCH3FRmOfTllu6OdUNgql8TB6r1+7NQa8B/N3KawfCrTsBeGl4ZaEeHKuqz86sEnVCoNI7mOUDvNRMoGFD1T5BxjfCWJlgJ+rklXtWmjJpUCVurohjzgJBsIkFEFbcZgwi4GwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625408; c=relaxed/simple;
	bh=8/gfPXWxxf7FOY8AgpmCewWXxXTZYt2IGleiv5CqE8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wz1UkTytK9+6AyObw2WcVEAI/86QiUj9J1vgYDUyb0ur/A/hC/rxBN9hBpv4vOzl4mGwKvEuiKAlm9O0vWTKdfvr79tZAuYxHeeA4784pkycgJJzFireABtEJ+wuRPiMMQeTcImshTyxUBxgfuG+Hi2N7TD3j2PITITUgXDAK04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CkqcZUIA; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7eedf4ae265so21325139f.3
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720625406; x=1721230206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gh4KlpRRZVtRU7Y7a9D5NYIzadIHQ/XSQ7aTvmHJrcU=;
        b=CkqcZUIAEsLP7D+L1o6ycdoU+bQ3sEcRS7O1q+3JvY8FIziIPHNrnUVtIBk+Pe2nRz
         U1E0xNBjfw+iDCOhbSCSoA6FenmLSILVRTZ8wHm9ZyhTI/upboGAwoqN8JTK+hmXUBD5
         8kv55PVsfz60McK9T6XfCzB4Rd4DlKkCKs7Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720625406; x=1721230206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gh4KlpRRZVtRU7Y7a9D5NYIzadIHQ/XSQ7aTvmHJrcU=;
        b=IhqvFx/VSSYQN7gePoB6gNep5WFuhCy5Y489GcCOmd0VlinHczhC9cc0mZLJZwKHog
         boNTStrVYLY3LB+2UaYhNKzb37UG9WFkBiUHeolBnamlnCTYxMXlOvgBVx/V+hobPJop
         HrDFFTMixFXhwndbPVt1JIxNF9RlzucraIbMGfdakBz4q7hVI1n0z5lCwcWw0o0aAPTD
         rcUDc+DfDNN1guJww9/K0YP3VTPW/8Bqc/ZozPqhM36enTOCpbA9BYCc5sDPwBmjAHu4
         1lEbwScoEvT86ugELiOrd/lihmzFBbtQGCu0KitAA1ko7MVNcz17aIrjMuAtYd54Pktx
         ZBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBeYU+rLjOGYkOeGUQCqDhhneojxdAb8ap2JmRPte2JeZPKv+3r7ExmOQrc7f9HB6CROu10xJByUZ+E3dAMX2NRAcz
X-Gm-Message-State: AOJu0YwM7jVcAhzftNScqFLlNqlWnpsRTvxhKik5amCsBhyiwa8Q4e/V
	20wdbrKn2m1o5tP3mbSdDr+fWKIwihQ6KoqUwfSDUTqnDMNXZaA/5AzdfitB5io=
X-Google-Smtp-Source: AGHT+IEaNw0ouQ+VXx2iRgxdND1WLK34gMh/WUa7EyQuElws8C+1LmKST3HSfMbu0U5iEmjqwA1QWQ==
X-Received: by 2002:a05:6602:3413:b0:7f8:bfcd:db53 with SMTP id ca18e2360f4ac-8000269672bmr658618839f.1.1720625405978;
        Wed, 10 Jul 2024 08:30:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c13848sm1184863173.133.2024.07.10.08.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 08:30:05 -0700 (PDT)
Message-ID: <273183c9-101c-422b-9fcd-a9921c127cb1@linuxfoundation.org>
Date: Wed, 10 Jul 2024 09:30:04 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf:fix a resource leak
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, jolsa@kernel.org,
 shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240710015913.2554-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710015913.2554-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 19:59, Zhu Jun wrote:
> The requested resources should be closed before return
> in main(), otherwise resource leak will occur
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

How did you find this problem? Please give more details
on the tool used including the output from the tool.
> ---
> Changes in v2:
>   - check for cg_fd >= 0 and have just one out label
> 
>   tools/testing/selftests/bpf/test_sockmap.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index a34e95040994..285a9a714666 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -2075,8 +2075,10 @@ int main(int argc, char **argv)
>   
>   	if (!cg_fd) {
>   		cg_fd = cgroup_setup_and_join(CG_PATH);
> -		if (cg_fd < 0)
> -			return cg_fd;
> +		if (cg_fd < 0) {
> +			err = cg_fd;
> +			goto out;
> +		}

I don't this this improves the code - it makes it more complex.
If you want to improve this - add the same error message that
gets printed out for

case 'c':

in argument parsing.

fprintf(stderr, "ERROR: (%i) open cg path failed: %s\n",
                  cg_fd, optarg);
>   		cg_created = 1;
>   	}
>   
> @@ -2092,7 +2094,7 @@ int main(int argc, char **argv)
>   	if (err) {
>   		fprintf(stderr, "populate program: (%s) %s\n",
>   			bpf_file, strerror(errno));
> -		return 1;
> +		goto out;

This looks good to me.

>   	}
>   	running = 1;
>   
> @@ -2109,7 +2111,8 @@ int main(int argc, char **argv)
>   		free(options.whitelist);
>   	if (options.blacklist)
>   		free(options.blacklist);
> -	close(cg_fd);
> +	if (cg_fd >= 0)

Why is this check necessary?
> +		close(cg_fd);


>   	if (cg_created)
>   		cleanup_cgroup_environment();
>   	return err;

thanks,
-- Shuah

