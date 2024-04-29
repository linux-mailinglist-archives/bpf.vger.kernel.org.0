Return-Path: <bpf+bounces-28112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA4D8B5E2D
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1307B23BB2
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D2482D8E;
	Mon, 29 Apr 2024 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="la50SNEx"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25AD82883
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406029; cv=none; b=FCIjQ4BvTGtILMqRkB/ZR6pTtnTSmieWPSzotgqIFb5m7d92U3yuaHsotf8+R6hTSIqXnNQ4t1k/XR16fXX7Dkw4owqYWRfTZf0EoR2u8AkSKdSmT/OGbhwKN6pb6ofanJUay9INDDxfy4uooBJwWvTmtuFhi/i96zcfOa4O0X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406029; c=relaxed/simple;
	bh=NsRBY74Bfg5heYt2w1gPVTY1zYEHG1o7HaSNvAT0veY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkYxi8mG+jgFJkIdF9Yw5eq/dBfWfxiFUWrrJ9N2u0JSX6h1JzNJlIYNEh6RaXscfAxQylPG1IDV+e7hqcH7U6Lxa4D4AVdgiTcDYiSZANeCRbVhx81LougAvsPXvxChDf7o7MGls33/eL/vXfooGKK4D3/A7hudAU2zaTVQid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=la50SNEx; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7eddbfd3-2acd-4a25-8fc4-29689b39c3f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714406025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsRBY74Bfg5heYt2w1gPVTY1zYEHG1o7HaSNvAT0veY=;
	b=la50SNExVrvfi1d39DoSe/ovc3ZWfeh2yzBpLe97/jNasfxZL06OiPIObS5/vmQmymQC/U
	i03mLwyJjyiB46SxI6uSag+80FGyv1z9bzQaW+WRYcFgy+K++1AkLb2Xi8j4jduU92YIlW
	iCLzZN28IhHivqB6wTIIi1mUAsOmiA0=
Date: Mon, 29 Apr 2024 08:53:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Free strdup memory in
 test_sockmap
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1714374022.git.tanggeliang@kylinos.cn>
 <b76f2f4c550aebe4ab8ea73d23c4cbe4f06ea996.1714374022.git.tanggeliang@kylinos.cn>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b76f2f4c550aebe4ab8ea73d23c4cbe4f06ea996.1714374022.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/29/24 12:07 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> The strdup() function returns a pointer to a new string which is a
> duplicate of the string "ptr". Memory for the new string is obtained
> with malloc(), and need to be freed with free().
>
> This patch adds these missing "free(ptr)" in check_whitelist() and
> check_blacklist() to avoid memory leaks in test_sockmap.c.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Yonghong Song <yonghong.song@linux.dev>

