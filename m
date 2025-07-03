Return-Path: <bpf+bounces-62300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1D0AF7C86
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 17:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31CE16F95F
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE49221D94;
	Thu,  3 Jul 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GACBzkMs"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF02EFC0B
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556963; cv=none; b=m+M3Z6SrAWhCOdmX3+rMgU0uegrMHZrQ594cHhMJ6bE0rP4VYxkQw/j1tgT6vXD5WGihV7XiUxypPgq5mvBWa6kVZl7BhIOstzrQEDIYxElZoOVTOk3pOTuVFtP9I+MEPnuPgHjvuB/RXztAkqx3k4dHopnbvP9mR1D6zKfQEnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556963; c=relaxed/simple;
	bh=+oQfP1Bds2NStfrSIzwtMkBJ7FoMmRtjt5wrpXL9d3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1sahp/TV628358GODYNeeFVoEmI9BQlsV25tpzt+pTTMhiTevXmo4cqimhi/oNdIkRlyfOhgJ8J9Hnn3Fh78RFMn4I40BQuQNpqJw9/YecVXQ92OB+Xpef4jwTqM5CGFzTvfzrSDnBZLMhMqgBwKu2e4jOfnvs2qvNHEhE7PAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GACBzkMs; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4925bd4-8169-47c2-9cff-5a4023f07a32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751556958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eRVsX60PZyYuNbYRScH64M22xCUcDp+0crN+OJ6Ra4=;
	b=GACBzkMsaqWE1QUIRDa0I+YZATjc4bnBA0JsEmS4WRXa+o9tyjSx3wxSx+hQp+wZWsc3tc
	iE0f59L/CLG/8xpbC3B4Leen32Ruip8FrWE+mRvgxnYdwLeYBIPLTy0t61qMuB8+mWYnsQ
	wW9x6gUh88pwU2/DSjV3n5gQZtWnoho=
Date: Thu, 3 Jul 2025 08:35:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Clean code with bpf_copy_to_user
Content-Language: en-GB
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250703124336.672416-1-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250703124336.672416-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/3/25 5:43 AM, Tao Chen wrote:
> No logic change, just use bpf_copy_to_user to clean code.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>   kernel/bpf/syscall.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e6eea594f1c..ca152d36312 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5208,21 +5208,10 @@ static int bpf_task_fd_query_copy(const union bpf_attr *attr,
>   
>   			if (put_user(zero, ubuf))
>   				return -EFAULT;
> -		} else if (input_len >= len + 1) {
> -			/* ubuf can hold the string with NULL terminator */
> -			if (copy_to_user(ubuf, buf, len + 1))
> -				return -EFAULT;
>   		} else {
> -			/* ubuf cannot hold the string with NULL terminator,
> -			 * do a partial copy with NULL terminator.
> -			 */
> -			char zero = '\0';
> -
> -			err = -ENOSPC;
> -			if (copy_to_user(ubuf, buf, input_len - 1))
> -				return -EFAULT;
> -			if (put_user(zero, ubuf + input_len - 1))
> -				return -EFAULT;
> +			err = bpf_copy_to_user(ubuf, buf, input_len, len);
> +			if (err)
> +				return err;
>   		}
>   	}

Actually, there is a return value change with this patch.
bpf_copy_to_user() return returns -ENOSPC while the original
implementation may return -EFAULT due to following code.

         if (put_user(prog_id, &uattr->task_fd_query.prog_id) ||
             put_user(fd_type, &uattr->task_fd_query.fd_type) ||
             put_user(probe_offset, &uattr->task_fd_query.probe_offset) ||
             put_user(probe_addr, &uattr->task_fd_query.probe_addr))
                 return -EFAULT;

         return err;


