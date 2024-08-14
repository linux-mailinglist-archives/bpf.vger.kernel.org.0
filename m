Return-Path: <bpf+bounces-37135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9952951179
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 03:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286691C211CB
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 01:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4701D18046;
	Wed, 14 Aug 2024 01:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZycA0Fyw"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3E8C04
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 01:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723598166; cv=none; b=beVBO2yEg4IN4tAG6vI0nurs5R8Kw/DYm6MgHUtl9+EG4h6/5W8pydIB/EHUvlOp+SrI7aDTuzix8QDH00qqcL0zRoAN9HK/W/BgPWK8lh43QobZjigdZwxGvp1aHcUvttNcf4yeUEgcdIdJG5iJPdqeXzH9GJ9qG61g0KKfQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723598166; c=relaxed/simple;
	bh=MkXFiA2R7N0GkeSfvtm/4uVsgAkkboJRbIr+H0/Jdio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgGZnuQcIGbhdZwiPsvCSaBzJZQXKapt2EFGVtYDZADoU/6T27O51IEwcp3UX3a+Hs0RblQrpN2QqVyZ/c6cHUmvZ3L213j4rgiwz5Y0gVembazP9RkI9dy+2/I2yeu/HbddJ7icvZycDyV/AS2VFkt8YNlR+Eb1gRZQcZo6tTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZycA0Fyw; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <77a5dbd2-7792-486c-b161-76e2262b67a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723598162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1wCb4eQ0dBgNvVDp9u7eIeToZA3GAWW3d5tUNq1/Tw=;
	b=ZycA0FywXVC2J97ie40NHCfZaCQU05nw9fvwnzZSz69nJFGlpyQZL2foxm1SBFeEoknlWs
	z+097RZ/d+EgH+uGLFxOaOks1vhzVxyIEJhBuoXsoszJhxrD86n5iNF0/aJxYxTLyG+vNe
	xt9MIOhfEgiXFaDcf+nZdh/9Lh0nf7M=
Date: Tue, 13 Aug 2024 18:15:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Avoid subtraction after htons()
 in ipip tests
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240808075906.1849564-1-ast@fiberby.net>
 <87sevfpdti.fsf@toke.dk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <87sevfpdti.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/8/24 2:24 AM, Toke Høiland-Jørgensen wrote:
> Asbjørn Sloth Tønnesen <ast@fiberby.net> writes:
> 
>> On little-endian systems, doing subtraction after htons()
>> leads to interesting results:
>>
>> Given:
>>    MAGIC_BYTES = 123 = 0x007B aka. in big endian: 0x7B00 = 31488
>>    sizeof(struct iphdr) = 20
>>
>> Before this patch:
>> __bpf_constant_htons(MAGIC_BYTES) - sizeof(struct iphdr) = 0x7AEC
>> 0x7AEC = htons(0xEC7A) = htons(60538)
>>
>> So these were outer IP packets with a total length of 123 bytes,
>> containing an inner IP packet with a total length of 60538 bytes.
> 
> It's just using bag of holding technology!
> 
>> After this patch:
>> __bpf_constant_htons(MAGIC_BYTES - sizeof(struct iphdr)) = htons(103)
>>
>> Now these packets are outer IP packets with a total length of 123 bytes,
>> containing an inner IP packet with a total length of 103 bytes.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> 
> Reviewed-by: Toke Høiland-Jørgensen <toke@kernel.org>

Applied to bpf-next/net. Thanks.


