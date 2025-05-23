Return-Path: <bpf+bounces-58867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF52CAC2BAD
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 00:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44DF1C06C66
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 22:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C688B211713;
	Fri, 23 May 2025 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HyT2Gfe+"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F620DD51
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748038071; cv=none; b=mRfm30LBrQJXJP71GfzdlLiAi/IS0Iur/p7dkXnWpxH/Xo7QQuc27uQiLCu/knFbLo2CE44MIm9o4EHAWpp+Vi98OHtMPw8PcSy+bTNp6RGTvLLdYoz/PdGVenZV77ETzLNEin8zg264AU2ExDGgz9N5ApMKQSuDwsWcmkLEHR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748038071; c=relaxed/simple;
	bh=KlzmfCa2SrxzmEGXj+PDBGSrLBS3JO3WQH1Yb1+4QC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ra34LZEsSmjrtVXxB2PoypIgaXQtbgNot9mBseGwNzMz5/FC4z/msIBUsmLbxsexzWRDfmEswrY/eUxmqF7FAk2g2/yyIv/HrCWIXtfxLQWy+eEsw6xMl2Lpxik2v5hNVUmyyLL+mYi1sj9YEI7bjiwHT/mZRm/LRQPV5thqG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HyT2Gfe+; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <495201b0-36b9-4a97-8eb3-aedd57e039a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748038057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AWGlpPVijp+HKh8HaBzqxw9GPYtIBf5i/198Hxq2dg=;
	b=HyT2Gfe+BLjA5h4B8z7VJvRvOP+Qbpc1qlbTRzW/9P0lF1HmZtbBSOC3TxHGLz+kT9VKVh
	Dm9T4yY9mmgWu7f21N9OdOPrhc54nGMbtbEl2+Lg/n/zZt9T5PNLVrnqAay436VFeOeG5u
	6dCMXNQk8c6icOZq5EE6xTdGV+Qc5as=
Date: Fri, 23 May 2025 15:07:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 03/10] bpf: tcp: Get rid of st_bucket_done
To: Kuniyuki Iwashima <kuniyu@amazon.com>, jordan@jrife.io
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org, daniel@iogearbox.net,
 netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
References: <wxqtnfk2nkwfd3lybyyitawusswohp7hkaoszfxpfdsiuluilr@g3zlc3ojxjkv>
 <20250522204443.78455-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250522204443.78455-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/22/25 1:42 PM, Kuniyuki Iwashima wrote:
> From: Jordan Rife <jordan@jrife.io>
> Date: Thu, 22 May 2025 11:16:13 -0700
>>>>>   static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
>>>>>   {
>>>>> -	while (iter->cur_sk < iter->end_sk)
>>>>> -		sock_gen_put(iter->batch[iter->cur_sk++]);
>>>>> +	unsigned int cur_sk = iter->cur_sk;
>>>>> +
>>>>> +	while (cur_sk < iter->end_sk)
>>>>> +		sock_gen_put(iter->batch[cur_sk++]);
>>>>
>>>> Why is this chunk included in this patch ?
>>>
>>> This should be in patch 5 to keep cur_sk for find_cookie
>>
>> Without this, iter->cur_sk is mutated when iteration stops, and we lose
>> our place. When iteration resumes and we call bpf_iter_tcp_batch the
>> iter->cur_sk == iter->end_sk condition will always be true, so we will
>> skip to the next bucket without seeking to the offset.
>>
>> Before, we relied on st_bucket_done to tell us if we had remaining items
>> in the current bucket to process but now need to preserve iter->cur_sk
>> through iterations to make the behavior equivalent to what we had before.
> 
> Thanks for explanation, I was confused by calling tcp_seek_last_pos()
> multiple times, and I think we need to preserve/restore st->offset too
> in patch 2 and need this change.
> 
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index ac00015d5e7a..0816f20bfdff 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2791,6 +2791,7 @@ static void *tcp_seek_last_pos(struct seq_file *seq)
>   			break;
>   		st->bucket = 0;
>   		st->state = TCP_SEQ_STATE_ESTABLISHED;
> +		offset = 0;

This seems like an existing bug not necessarily related to this set.

The patch 5 has also removed the tcp_seek_last_pos() dependency, so I think it 
can be a standalone fix on its own.


>   		fallthrough;
>   	case TCP_SEQ_STATE_ESTABLISHED:
>   		if (st->bucket > hinfo->ehash_mask)> 
> 
> Let's say we are resuming at an offset (10) in the last lhash bucket
> but a few sockets (3) disappeared, then we go to the ehash part with
> a non-zero offset (3), which will overwrite st->offset (3).
> 
> If the ehash does not fit into the batch size, we need to allocate
> a new batch and retry, but the offset (3) is different from the
> first try (10).


