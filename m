Return-Path: <bpf+bounces-67299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1DB423E1
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426395684D7
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7ED20E334;
	Wed,  3 Sep 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X1nfFhB2"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8051FBEA6
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910370; cv=none; b=Yt4l3bb35jE9gX5dtGnuQ31rNp1gJtae+T3zLhBvk4i2YRrQGFz8LFDQ6uFzklIJ9kwnCRN+lZzI9VXT0VQ0auq7ITuog28qKIWDa5kUxnQW376NqcoyfOZLwE9tzxF1u47WHxEvwQR0G3+FedQnvTUTRNnhpOrfr/0VUguOcpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910370; c=relaxed/simple;
	bh=9XWNIGXscISA1Rn7Z/34yd+8NrlJjy1LZ0HLoHHNCdw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Y/RBQXD9YVUwOi0EEgWP0836StpHcsJCIjP/3LVEa9nR2aaDLk2a2/2PH/5LUgD0cI3D0f7CjFNNfH1qa/Mfr99OTmMK7+PfJIAMDkL8MBYfqAIsuQ9h4CEIKw/oY6dMF4oDwSE4kxiZfETQGL0KD2wOMFn+LKFDg/gZMEZHxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X1nfFhB2; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756910363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrvVXvBTviFrJXpWvnca+/A9NhlXLNaTSseb3vwN1+s=;
	b=X1nfFhB2MLorrgXbokkzumpMGQfZcjBrcNFFhB89uXLtPem/56vJDy95uOeqH3sHOsDaIh
	bocST9TGi0mFC7t0m2VkxReFvM5Y0eJ1jCX7BrjZHvn5Y4jn7AlwAt6W4n/sz9GLblT38F
	ugkWx63a+DiT9UVSGlVzAOHT9Maf6qM=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Sep 2025 22:39:16 +0800
Message-Id: <DCJ8QRHELLM0.2A30YCC5EUXUQ@linux.dev>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <jolsa@kernel.org>, <yonghong.song@linux.dev>,
 <song@kernel.org>, <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v4 1/7] bpf: Introduce internal
 bpf_map_check_op_flags helper function
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
References: <20250827164509.7401-1-leon.hwang@linux.dev>
 <20250827164509.7401-2-leon.hwang@linux.dev>
 <CAEf4BzbuhaWSE6-1fnxYhUX_6iaBvrr6Q1Mq05MhuxE7U4_63A@mail.gmail.com>
In-Reply-To: <CAEf4BzbuhaWSE6-1fnxYhUX_6iaBvrr6Q1Mq05MhuxE7U4_63A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu Aug 28, 2025 at 7:17 AM +08, Andrii Nakryiko wrote:
> On Wed, Aug 27, 2025 at 9:45=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
>>
>> It is to unify map flags checking for lookup_elem, update_elem,
>> lookup_batch and update_batch APIs.
>>
>> Therefore, it will be convenient to check BPF_F_CPU and BPF_F_ALL_CPUS
>> flags in it for these APIs in next patch.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf.h  | 28 ++++++++++++++++++++++++++++
>>  kernel/bpf/syscall.c | 34 +++++++++++-----------------------
>>  2 files changed, 39 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 8f6e87f0f3a89..512717d442c09 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3709,4 +3709,32 @@ int bpf_prog_get_file_line(struct bpf_prog *prog,=
 unsigned long ip, const char *
>>                            const char **linep, int *nump);
>>  struct bpf_prog *bpf_prog_find_from_stack(void);
>>
>> +static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags=
, u64 extra_flags_mask)
>> +{
>> +       if (extra_flags_mask && (flags & extra_flags_mask))
>
> doh, Leon... when extra_flags_mask =3D=3D 0, `flags & extra_flags_mask` i=
s
> always false, so just:
>
> if (flags & extra_flags_mask)
>     return -EINVAL;
>
> But it feels more natural to reverse the meaning of this and treat it
> as extra *allowed flags*. So zero would mean no extra flags should be
> there (most strict case) and ~0 would mean "we don't care or will
> check later". And so in the code you'd have
>
> if (flags & ~extra_flags) /* check for any unsupported flags */
>     return -EINVAL;
>
> But I need someone else to do a reality check on me here at this point.
>

It seems clearer to handle this as additional *allowed flags*. That would
make it more understandable.

Thanks,
Leon

