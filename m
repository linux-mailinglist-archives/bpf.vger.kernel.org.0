Return-Path: <bpf+bounces-26231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F0789CF4B
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 02:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FFC2839EE
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 00:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B649389;
	Tue,  9 Apr 2024 00:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbmwXifR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8B370;
	Tue,  9 Apr 2024 00:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622153; cv=none; b=sSusTpidpmJdSrXnt5p4WgrbQmcR+NXpNVgySBiwvGjCLqXzX6StqRSs0zbxwQfl+C3YkLVUTvNA5SCS8uQpy3QP+1Cc/ANjKO/Af7xKYQqV7rMYx2pTFmmxVnankvVif70HxnclwJ5dfIciVSBh7oyqD0uwxgv1h6aR+h2tWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622153; c=relaxed/simple;
	bh=w8VrpY/UdCloj41DDlLEbyaW7v3AWiwBQTEspM1D5Iw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=C9ClJDnT4M0QZ8x3Rw6d+7G9XcOa5rV1IFZdk5TQtr1dbBIzpfsea6VMUYaICVwo5aQoL7ze0h6zn5WYP5lUX9/4wtVyhn1WLIpAduK5Q7C8loCyN3J9OTW0kNs+1ms3rm6/MDxBt0gP3APuwa8bEpUpCeDUwrbohn4/NLRt92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbmwXifR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943CFC433F1;
	Tue,  9 Apr 2024 00:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712622153;
	bh=w8VrpY/UdCloj41DDlLEbyaW7v3AWiwBQTEspM1D5Iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qbmwXifRJqbG1K3YMl1hHsGUPEWg6NbMIGPLYnP37L6SgQJ2KisxbW7znoQ6+BhDC
	 mFa4zbvK8SaIeJKR74p924LfG7pU7kxHUM+mDb+IToF/W6AKiSabKTfP2l38/fYI64
	 lYX6wsvuWhQI3Stxs2yp+hzHKoGiC5zxfpIkBSGA3C+V7P30/Qy7rq/iFoFcGaJUcm
	 ujgNlIU7uoyXcKWjEvJh3nED6DrZ9hWcdiiBoJmgYIDoTsH4vRX3s7n3LQEOMphZfB
	 R8Pr/5Jygt/v615nSEoQ76mipDCxfLuYcn+lTl2fN90dMqT02m98i9DZEGssYqoSOa
	 NN78WRsgi4GlA==
Date: Tue, 9 Apr 2024 09:22:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: martin.lau@linux.dev, kernel-team@meta.com, andrii@kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, sinquersw@gmail.com, kuifeng@meta.com, John Fastabend
 <john.fastabend@gmail.com>
Subject: Re: [PATCH v2] rethook: Remove warning messages printed for finding
 return address of a frame.
Message-Id: <20240409092228.c8dbe901a0143f580346756b@kernel.org>
In-Reply-To: <20240408175140.60223-1-thinker.li@gmail.com>
References: <20240408175140.60223-1-thinker.li@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 10:51:40 -0700
Kui-Feng Lee <thinker.li@gmail.com> wrote:

> The function rethook_find_ret_addr() prints a warning message and returns 0
> when the target task is running and is not the "current" task in order to
> prevent the incorrect return address, although it still may return an
> incorrect address.
> 
> However, the warning message turns into noise when BPF profiling programs
> call bpf_get_task_stack() on running tasks in a firm with a large number of
> hosts.
> 
> The callers should be aware and willing to take the risk of receiving an
> incorrect return address from a task that is currently running other than
> the "current" one. A warning is not needed here as the callers are intent
> on it.
> 

OK, looks good to me. Let me pick it to probes/for-next. Thanks!

> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> 
> ---
> Changes from v1:
> 
>  - Rephrased the commit log.
> 
>    - Removed the confusing last part of the first paragraph.
> 
>    - Removed "frequently" from the 2nd paragraph, replaced by "a firm with
>      a large number of hosts".
> 
> v1: https://lore.kernel.org/all/20240401191621.758056-1-thinker.li@gmail.com/
> ---
>  kernel/trace/rethook.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index fa03094e9e69..4297a132a7ae 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -248,7 +248,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
>  	if (WARN_ON_ONCE(!cur))
>  		return 0;
>  
> -	if (WARN_ON_ONCE(tsk != current && task_is_running(tsk)))
> +	if (tsk != current && task_is_running(tsk))
>  		return 0;
>  
>  	do {
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

