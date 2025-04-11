Return-Path: <bpf+bounces-55798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F994A868C2
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 00:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181569A72EB
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 22:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8266729CB5C;
	Fri, 11 Apr 2025 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gLII+QOz"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B1A23F424
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744409472; cv=none; b=MjJfkZh3OYYXUtcrAuE4zrVjlsm3+o2FocIp5jGHEVoJZtN2QJKBxtTNjx3XdxzXexrHOmw+Wsl232jKu5orTgQI1hVVsevoz902xxHZ6WPv9+CFrBU3MVR1HDRQTKvgV3u5MuGGuJ/DVTdz3Mw7/FGoDWmKuaIv1Q9toY5KZi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744409472; c=relaxed/simple;
	bh=eevoZKld/790h56ww/TySBTQFAy3eHgaOO+S9uFNxOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJ4ppxa3Qe7wsdSMhSOdFi3dp4DjpPa60+8hYFvrEwVzl8ZZI6XMxLj6LyO3IAqUJfOAu29llmU1QeLmI5isoUedKjk49Kc2DmJKXNBlTo7GrvOHqfCI0ubSpWqFxO9w+fkV2ePSPME1ksQkiqbCQHmmjhTPI7YIUi/rxTmP+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gLII+QOz; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7ed28273-a716-4638-912d-f86f965e54bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744409467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qheMuk29FFYH8kDIeWSyVqIdek0lwqrC1Q0451zKyto=;
	b=gLII+QOzvaqnKljBpm25/fp++1pft2+KK5OJJ+9Q/xSKZmoyn/ancmlgKl7DUL1G3Qm5dP
	SXWDZ7P9NzhdOu1bUdWvW2R5aO7P7uXUUWno0YM6JlnYIp9z8g1aEX97MYjs+ZDXSX02Cd
	sLQ0wGcVLDSEHSzey4DDhBMqE9j79sQ=
Date: Fri, 11 Apr 2025 15:10:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: udp: Propagate ENOMEM up from
 bpf_iter_udp_batch
To: Jordan Rife <jordan@jrife.io>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250411173551.772577-1-jordan@jrife.io>
 <20250411173551.772577-3-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250411173551.772577-3-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/11/25 10:35 AM, Jordan Rife wrote:
> Stop iteration if the current bucket can't be contained in a single
> batch to avoid choosing between skipping or repeating sockets. In cases
> where none of the saved cookies can be found in the current bucket and

Since the cookie change is in the next patch, it will be useful to mention it is 
a prep work for the next patch.

> the batch isn't big enough to contain all the sockets in the bucket,
> there are really only two choices, neither of which is desirable:
> 
> 1. Start from the beginning, assuming we haven't seen any sockets in the
>     current bucket, in which case we might repeat a socket we've already
>     seen.
> 2. Go to the next bucket to avoid repeating a socket we may have already
>     seen, in which case we may accidentally skip a socket that we didn't
>     yet visit.
> 
> To avoid this tradeoff, enforce the invariant that the batch always
> contains a full snapshot of the bucket from last time by returning
> -ENOMEM if bpf_iter_udp_realloc_batch() can't grab enough memory to fit
> all sockets in the current bucket.
> 
> To test this code path, I forced bpf_iter_udp_realloc_batch() to return
> -ENOMEM when called from within bpf_iter_udp_batch() and observed that
> read() fails in userspace with errno set to ENOMEM. Otherwise, it's a
> bit hard to test this scenario.
> 
> Link: https://lore.kernel.org/bpf/CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com/
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   net/ipv4/udp.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 59c3281962b9..1e8ae08d24db 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3410,6 +3410,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   	unsigned int batch_sks = 0;
>   	bool resized = false;
>   	struct sock *sk;
> +	int err = 0;
>   
>   	resume_bucket = state->bucket;
>   	resume_offset = iter->offset;
> @@ -3475,7 +3476,11 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   		iter->st_bucket_done = true;
>   		goto done;
>   	}
> -	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
> +	if (!resized) {

The resized == true case will have a similar issue. Meaning the next 
bpf_iter_udp_batch() will end up skipping the remaining sk in that bucket, e.g. 
the partial-bucket batch has been consumed, so cur_sk == end_sk but 
st_bucket_done == false and bpf_iter_udp_resume() returns NULL. It is sort of a 
regression from the current "offset" implementation for this case. Any thought 
on how to make it better?

> +		err = bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2);
> +		if (err)
> +			return ERR_PTR(err);
> +
>   		resized = true;
>   		/* After allocating a larger batch, retry one more time to grab
>   		 * the whole bucket.


