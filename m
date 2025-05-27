Return-Path: <bpf+bounces-59013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB17AC5A00
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 20:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7254A2B15
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 18:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFB527C173;
	Tue, 27 May 2025 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kB7Lm1ZJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997BB189B80
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748369992; cv=none; b=k/FI8VaN09f79JwsZtBTeLNnYaDNR26AnGVibHGPzrlSuL9V6dO6xHo8GIx9dW4+npl7A07rVdA8MxIgepliXbmwjuKh0iRkdDgElgkCbm8RMZ6aQ5cTg7W1q14MUYRF3EQ38wvzE4Il0PKzftswNIUuso9y0gL79FN2K02Wkqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748369992; c=relaxed/simple;
	bh=4157WNDPmaLRh9FoaDL4mzKslAOw6dhMPTfXyXQt0zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeV/e0sc3h95j5hfh3CdDZrY5hukoNsQaDcT29M2oIx/e+1/9J4qUlFAtvhuPhrEGMecQEVUKWTMJAgJFettpQ14eiVA2GXWW7Y7y6C02y1d3eHL4mVlzpoFCeXa5T5N+Pzylol3aQ5aDVuThMPaz5x1A+lNqUlUAfJPFDdUvfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kB7Lm1ZJ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <21f4f0e6-58a5-48b4-8ccd-37f79f9b8241@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748369987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpbr6+yvoAeCVple+mGNixeYL4agEPADgVUkkelLgHw=;
	b=kB7Lm1ZJ5ka0o4aTenPVaiIRyQiiwNmyJSto0QN4oRE40VThzyLxbkyLMSFpQgR36rzVDh
	rUpl+J/oWKm8ymjBlVBDfQAOpBQXoIUmvozHtM6DvuCe/vxUd4BU7wkaf3QcGtWnBfb9aV
	HqHLSHKLZFumFHHBwHSRjq1S/BANm0o=
Date: Tue, 27 May 2025 11:19:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 03/10] bpf: tcp: Get rid of st_bucket_done
To: Jordan Rife <jordan@jrife.io>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alexei.starovoitov@gmail.com,
 bpf@vger.kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 willemdebruijn.kernel@gmail.com
References: <wxqtnfk2nkwfd3lybyyitawusswohp7hkaoszfxpfdsiuluilr@g3zlc3ojxjkv>
 <20250522204443.78455-1-kuniyu@amazon.com>
 <495201b0-36b9-4a97-8eb3-aedd57e039a9@linux.dev>
 <bfey2fu3e74d52wjnoimu5ra7wqox2idnc2syzlrvsyjzezdli@lhywkrucesbf>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <bfey2fu3e74d52wjnoimu5ra7wqox2idnc2syzlrvsyjzezdli@lhywkrucesbf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/24/25 2:09 PM, Jordan Rife wrote:
> On Fri, May 23, 2025 at 03:07:32PM -0700, Martin KaFai Lau wrote:
>> On 5/22/25 1:42 PM, Kuniyuki Iwashima wrote:
>>> From: Jordan Rife <jordan@jrife.io>
>>> Date: Thu, 22 May 2025 11:16:13 -0700
>>>>>>>    static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
>>>>>>>    {
>>>>>>> -	while (iter->cur_sk < iter->end_sk)
>>>>>>> -		sock_gen_put(iter->batch[iter->cur_sk++]);
>>>>>>> +	unsigned int cur_sk = iter->cur_sk;
>>>>>>> +
>>>>>>> +	while (cur_sk < iter->end_sk)
>>>>>>> +		sock_gen_put(iter->batch[cur_sk++]);
>>>>>>
>>>>>> Why is this chunk included in this patch ?
>>>>>
>>>>> This should be in patch 5 to keep cur_sk for find_cookie
>>>>
>>>> Without this, iter->cur_sk is mutated when iteration stops, and we lose
>>>> our place. When iteration resumes and we call bpf_iter_tcp_batch the
>>>> iter->cur_sk == iter->end_sk condition will always be true, so we will
>>>> skip to the next bucket without seeking to the offset.
>>>>
>>>> Before, we relied on st_bucket_done to tell us if we had remaining items
>>>> in the current bucket to process but now need to preserve iter->cur_sk
>>>> through iterations to make the behavior equivalent to what we had before.
>>>
>>> Thanks for explanation, I was confused by calling tcp_seek_last_pos()
>>> multiple times, and I think we need to preserve/restore st->offset too
>>> in patch 2 and need this change.
>>>
>>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>>> index ac00015d5e7a..0816f20bfdff 100644
>>> --- a/net/ipv4/tcp_ipv4.c
>>> +++ b/net/ipv4/tcp_ipv4.c
>>> @@ -2791,6 +2791,7 @@ static void *tcp_seek_last_pos(struct seq_file *seq)
>>>    			break;
>>>    		st->bucket = 0;
>>>    		st->state = TCP_SEQ_STATE_ESTABLISHED;
>>> +		offset = 0;
>>
>> This seems like an existing bug not necessarily related to this set.
> 
> Agree that this is more of an existing bug.
> 
>> The patch 5 has also removed the tcp_seek_last_pos() dependency, so I think
>> it can be a standalone fix on its own.
> 
> With the tcp_seq_* ops there are also other corner cases that can lead
> to skips, since they rely on st->offset to seek to the last position.
> 
> In the scenario described above, sockets disappearing from the last lhash
> bucket leads to skipped sockets in the first ehash bucket, but you could
> also have a scenario where, for example, the current lhash bucket has 6
> sockets, iter->offset is currently 3, 3 sockets disappear from the start
> of the current lhash bucket then tcp_seek_last_pos skips the remaining 3
> sockets and goes to the next bucket.
> 
> I'm not sure it's worth fixing just this one case without also
> overhauling the tcp_seq_* logic to prevent these other cases. Otherwise,
> it seems more like a Band-aid fix. Perhaps a later series could explore
> a more comprehensive solution there.

It is arguable that the missing "offset = 0;" here is a programmer’s error 
rather than the limitation of the offset approach itself. Adding it could be a 
quick fix for this corner case.

That said, it is a very rare case, given there is a "while (... && bucket == 
st->bucket)" condition, and the bug has probably existed since 2010 in commit 
a8b690f98baf. If there is a plan for a long-term fix in /proc/net/tcp[6], I 
think it is reasonable to wait also. I do not have a strong opinion either way. 
I am just unsure if any users care about the skip improvement in /proc/net/tcp[6].


