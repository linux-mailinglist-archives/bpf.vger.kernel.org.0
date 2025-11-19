Return-Path: <bpf+bounces-75100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D63BC70641
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 18:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8142B35A8D8
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CC835E549;
	Wed, 19 Nov 2025 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rAtBzfyP"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944C2F7ABB;
	Wed, 19 Nov 2025 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571521; cv=none; b=D2no7pCo3y04n3tAxIJvP1ifEwzR1VFk18p49uIwPovST3ER8Lm2XeDWfAbNFmgSZAqUxSE43NSTu1/17aX2whUxJL3X59QZzQ3j98RTTZL1BZTaNdNq+SKcIi9/6HHXZ4HMuSiVR3vj0Qf/5Bo/gEJI9o+h6pXPgOMnKroAlnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571521; c=relaxed/simple;
	bh=eiGS+x24M0vUaaZR2W+48F4LZdd9/vvmdy3L2LaHIiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJ/YMwt5rz7dFMOY4pow7Rc+WaKqbm7T5BgtoW3An/rsf2vNdtP6B/rPR4Ez4bUwZOkAHJOKCp0rDw2eVHp644NlQ/gm+UYKKsjZHO3g2OOg7fOphtqCi6D4qRrlxHteaPD1H6Dg3J605NL6xNX7meP2r3ihGZqrGCQMOipg3lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rAtBzfyP; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8edc1bae-8a28-4d8b-bf52-249bea05537f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763571513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lv4CTLyeccPuS8dft5xHIpzhHPS08XwFHFC7fRT/dUg=;
	b=rAtBzfyPNXLqYrN2R4z3dREOJW4kAipYVDNEk68txV7ymN86eAy72JoSzDoEq/hclgAHOv
	iP5yvC5fPbuSn9EUDcQIh+MIjgj/WAiNWwlY7x5QdO4rJtXWL+m3KGRmkDu05d9o16kOkb
	v+m24yEQt1IlnbsUjNcu+F89ypi2zxU=
Date: Wed, 19 Nov 2025 08:57:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf-next v1 1/5] selftests/bpf: use sockaddr_storage instead of
 addr_port in cls_redirect test
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251115225550.1086693-1-hoyeon.lee@suse.com>
 <20251115225550.1086693-2-hoyeon.lee@suse.com>
 <9ed9de08-9a5b-4fc9-9213-ca918dafea0b@linux.dev>
 <CAK7-dKbxgFqw8cjfw3oWvZCQat=UKUq7u4zU+nx4xw-g5m4n_Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAK7-dKbxgFqw8cjfw3oWvZCQat=UKUq7u4zU+nx4xw-g5m4n_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/18/25 7:09 PM, Hoyeon Lee wrote:
> For the “family” field, agreed. ss_family is sufficient, and the tuple
> wrapper can be removed. If you're okay with that direction, I can drop
> the family field and resend patches 1 and 2 with that cleanup applied.

Please re-spin patch 1 and 2 with the 'struct tuple' cleanup. The 
patch's title should have "PATCH bpf-next v???". Take a look at other 
patches posted in the mailing list.

