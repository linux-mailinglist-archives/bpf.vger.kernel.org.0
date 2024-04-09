Return-Path: <bpf+bounces-26303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB17789DF2A
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 17:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771FE1F298AD
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B29213AD3E;
	Tue,  9 Apr 2024 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e/T3dzyS"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C7713541F
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676524; cv=none; b=lt8Kx7C4DHoEUIpiOsuf8CA1JcpvHcvcBu4synxm+deGeJevOLhCUc33ZNfrcsmU2s49Fbla9XnhL92S+hq4b2O2O3ISI7hv1sX1I7mO6Jz9PxqdhHdfOSz0DXPG6hEW2z3oR2QluBIHBth1hnwMfV4v+W3ieHNoaKYkjeS6lOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676524; c=relaxed/simple;
	bh=4SRS/ZgNsyr32oBjnC1SjKUbhXdAWUOZVmXMVCyq4mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ih+NoeV0N9KKDrHNXvigBE2zKOvqaybOh5ayLyeYcz8oaSmncrB0EcxG05NAsWQ88AW5IFvSF/MCkuXxQ+GCu1xzgyk5kavdqMFZ9IoIOQH2MCc0c1Suqd4sliLiHk1+IUyiKzC/FAGOAUDrHSoY+YdlFpkCc/QBM3Ww0Kx5jec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e/T3dzyS; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <54361423-20a4-43fb-997b-ec0ef064c218@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712676519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eda4ZhsdSIWVVKpSNeFZoFyYc1zuAVn0p3Ihmlmc6OI=;
	b=e/T3dzySaWtkixYI6FLK/qF6NSH+MhBYGOr7BqHLJF5qUdo/0VTWDzOBuzuRHwin6oUNpI
	osGR/V8n/GkXnhi8gp6N/nmzeRI0KKg7mWTmMHRne3s35fItfrxABYlYRsmqSJOi9RpzPc
	BsM7YR/LNPxdyAQmyBweJslQgWaK384=
Date: Tue, 9 Apr 2024 08:28:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Sitnicki
 <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240408152425.4160829-1-yonghong.song@linux.dev>
 <20240408152431.4161022-1-yonghong.song@linux.dev>
 <b5df14d028562c863e65c27af82250c14395f513.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b5df14d028562c863e65c27af82250c14395f513.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/9/24 2:52 AM, Eduard Zingerman wrote:
> On Mon, 2024-04-08 at 08:24 -0700, Yonghong Song wrote:
>
> [...]
>
>
>> +/* Handle the following two cases:
>> + * case 1: link != NULL, prog != NULL, old != NULL
>> + * case 2: link != NULL, prog != NULL, old == NULL
>> + */
>> +static int sock_map_link_update_prog(struct bpf_link *link,
>> +				     struct bpf_prog *prog,
>> +				     struct bpf_prog *old)
>> +{
>> +	const struct sockmap_link *sockmap_link = container_of(link, struct sockmap_link, link);
>> +	struct bpf_prog **pprog, *old_link_prog;
>> +	struct bpf_link **plink;
>> +	int ret = 0;
>> +
>> +	mutex_lock(&sockmap_mutex);
>> +
>> +	/* If old prog is not NULL, ensure old prog is the same as link->prog. */
>> +	if (old && link->prog != old) {
>> +		ret = -EPERM;
>> +		goto out;
>> +	}
>> +	/* Ensure link->prog has the same type/attach_type as the new prog. */
>> +	if (link->prog->type != prog->type ||
>> +	    link->prog->expected_attach_type != prog->expected_attach_type) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	ret = sock_map_prog_link_lookup(sockmap_link->map, &pprog, &plink,
>> +					sockmap_link->attach_type);
>> +	if (ret)
>> +		goto out;
>> +
>> +	/* return error if the stored bpf_link does not match the incoming bpf_link. */
>> +	if (link != *plink)
>> +		return -EBUSY;
> Hi Yonghong,
>
> Sorry, this was a mistake on my side,
> this needs a 'goto out' in order to unlock the mutex.

It is my fault as well since I missed it too. Will send a revision later today
just in case there are more comments.

>
> Thanks,
> Eduard
>
>> +
>> +	if (old) {
>> +		ret = psock_replace_prog(pprog, prog, old);
>> +		if (ret)
>> +			goto out;
>> +	} else {
>> +		psock_set_prog(pprog, prog);
>> +	}
>> +
>> +	bpf_prog_inc(prog);
>> +	old_link_prog = xchg(&link->prog, prog);
>> +	bpf_prog_put(old_link_prog);
>> +
>> +out:
>> +	mutex_unlock(&sockmap_mutex);
>> +	return ret;
>> +}

