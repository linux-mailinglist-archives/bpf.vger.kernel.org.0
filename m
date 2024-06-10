Return-Path: <bpf+bounces-31697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 210F4901A34
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 07:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD941F218F9
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 05:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27974DDBB;
	Mon, 10 Jun 2024 05:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nfJlAZtu"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2940AD53
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 05:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717997535; cv=none; b=fUV79ATO9dZk1ozH5S4wet8IFQGiQVoA/DsTzf4KmKYBk1ZzQ1Q7eM1UggjrUONS43VpqM+1YeVdGuYBg0yYqvH5pCehYPuGcNGLxk0Dfy4hL5T6t9zIpWugFaGZVgAWIRY9rMw4zzTTaLS+i4xV2bYfkShd2YWq1vR3q5llIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717997535; c=relaxed/simple;
	bh=8ojqdR6kozr5T/R8yd2tDtEx/begCjSEYJh2CWknw18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGLfa2RkvLT2gyPVpt97T70+S5njGJmTAZ0cd356w0PEb6c+XjVxNx5FQGrxOG1BvsIpgYc5RyfHAc0upEdecVjU3/dNsEuzzYS8OGM+g1MfKuwT30+iCu6cVU1qR+H6zlozljgTse1wIDHHureLtXfYVwoXt2jyfdLJfeYijOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nfJlAZtu; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dev@der-flo.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717997531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuHwydXR93Dwe8tYu2VTD3i/1sdTHguHwXbOvjF1V0Y=;
	b=nfJlAZtuSdOXEBeOA8z51OlYThLGLPSEVuOWIg22HXGGytC6UZ9xJlnHbfbuApLIEpjmBm
	kkY/+C5iazWeDTy8ZVGaxfaOtzLnJapiLZf5K2UXFn9ybJbbFBnqKaqIzZUxgQiV/pkcqR
	u/9GHl+g5ZTc0S8VAG4jcpkhAlPLvXI=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: song@kernel.org
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
Message-ID: <83728982-d976-4b5b-b8cb-531ca61dba5a@linux.dev>
Date: Sun, 9 Jun 2024 22:32:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Return EINVAL instead of NULL for
 map_lookup_elem of queue
Content-Language: en-GB
To: Florian Lehner <dev@der-flo.net>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
References: <20240608092912.11615-1-dev@der-flo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240608092912.11615-1-dev@der-flo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/8/24 2:29 AM, Florian Lehner wrote:
> Programs should use map_peek_elem over map_lookup_elem for queues. NULL is
> also not a valid queue return nor a proper error, that could be handled.
>
> Signed-off-by: Florian Lehner <dev@der-flo.net>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/queue_stack_maps.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
> index d869f51ea93a..85bead55024d 100644
> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -234,7 +234,8 @@ static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
>   /* Called from syscall or from eBPF program */
>   static void *queue_stack_map_lookup_elem(struct bpf_map *map, void *key)
>   {
> -	return NULL;
> +	/* The eBPF program should use map_peek_elem instead */
> +	return ERR_PTR(-EINVAL);
>   }
>   
>   /* Called from syscall or from eBPF program */

