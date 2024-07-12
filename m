Return-Path: <bpf+bounces-34701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF689301A1
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 23:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4FF1F241CC
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5244C5C603;
	Fri, 12 Jul 2024 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ex765zrY"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356EA1BDD5
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720819841; cv=none; b=Q5zUlabHXKMpPYLN5BwNVpGRm29s6EMRj5ZzHefJLzrmFp/TLhftv2f1X9StR4gj9umchWwcg2ZxA1Dgp317Dno9BfkrLw3nnvPOwqEem/qXCs4eaop3QQGrsB8/boLeTHuMps9q6azn9Jp1WAB+P36W5AeqbVwwNsOydS8iXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720819841; c=relaxed/simple;
	bh=Bp3TUsg6/fyN5Jy6+ajJ7dpj1YJtA6eZMrJMcBJEVu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhEhSKvq+VAjcvk0lOhOE0ORApzgRIXPVvw4WnVdpsVxymEwuyFTW9JPJXa3IXdTShOCoG287tv0+dWb6mQzU5feAGzhoVOgxVgwcBO13uvmtSXtVRYeUFh0CMdKnkG47h01ueIZ+t+jHhQ6ZcUr6igSg9d60nSOZo22DP5jduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ex765zrY; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: eddyz87@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720819838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPwbth/ARywVWDNzxujr630VQVlSIBj4xd+2DuE4i74=;
	b=ex765zrYyUFY/vtVdQnUvr4zatGY/Z2/KKI4/QpcxDRvrToS0NeiksuwG102EyeO4AESbv
	HjAc/7r7VYW0z4+EwAaGCf57aJ50m8JK7APw55Tbnvr41ZJoBN2hjYZPJaw7nSqmSp/L+e
	BML5wJ+vo69EnyysoXqw1xLmgTP3jt8=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <28749f56-3058-434c-bba2-804f81f4781c@linux.dev>
Date: Fri, 12 Jul 2024 14:30:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Get better reg range with ldsx and
 32bit compare
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240712202815.3540564-1-yonghong.song@linux.dev>
 <fae1d2787b5340209429c83111cb6a1b92a66308.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <fae1d2787b5340209429c83111cb6a1b92a66308.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/12/24 1:50 PM, Eduard Zingerman wrote:
> [...]
>
> Also,
>
>> +	/* Here we would like to handle a special case after sign extending load,
>> +	 * when upper bits for a 64-bit range are all 1s or all 0s.
>> +	 *
>> +	 * Upper bits are all 1s when register is in a rage:
>                                                         ^^^^
>                                                   I missed 'n' here, sorry

Ack. I fixed a couple of places but missed this one. Will make
a change in next revision.

>
>> +	 *   [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
>> +	 * Upper bits are all 0s when register is in a range:
>> +	 *   [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
>> +	 * Together this forms are continuous range:
>> +	 *   [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]
> [...]
>

