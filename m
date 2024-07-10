Return-Path: <bpf+bounces-34460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 029C792D98D
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 21:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8BFB20BC9
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 19:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786D5197A68;
	Wed, 10 Jul 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hO2jQfaT"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B2E847B
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720641067; cv=none; b=LEO9qKtcZilfuOxaTyPb/p1t5Oo9ZzLNVsYn6RoWbooDd8IsDNFQtxVzYjdVQS+Uyfv2/6Hq+eo4GJFvpRSdfDwn0bm9qA+fzNObxKCfDnn6eZosDe9XU5CBhhBoqxD3dA6XrxxbbhF0azLFxjUcDadzf+QBvp3DT4fNm4jBBtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720641067; c=relaxed/simple;
	bh=k8/IRfHCMIglTM9FKE6eELzQuWgMFFPURP5KTYESLQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaJmoHBDsNY0dozBPG3CYzWr3H1G14u4gXRIywYLEeItMnhQW2Ug5tCxl6MtdEnKEUfwt7KM6bTxjDoIXUzZs5r3TOP5Tkskrgmofoy94TuFPNEIix0lIayQ6RDkX6iQcvVmOttB/OqhOT3jwL79AXg1CsIel/Vl66ZV8+ujCfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hO2jQfaT; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720641062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTNmdRjunnfj3vk0Cn2ImvCJZjGorcb2qD/C3cIdM1c=;
	b=hO2jQfaTArggx/L8iXW53F+Wl6nQyLUxYOqF/5D3zMY3vdfzliKB4sqasiUoXBUiCc0HVw
	+EM4iqNulsFmkTs7MSE8yQ7gfe1IX1lfg6KBmO7rrS1Y1mMuWmld8x1yzXzRZDcSR/PnYt
	bWN2UzxI1BRiS4BQQLtLJnlUIxCsCyc=
X-Envelope-To: andrii@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: mykolal@fb.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: shuah@kernel.org
X-Envelope-To: tanggeliang@kylinos.cn
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
Message-ID: <31f82582-2eca-475c-a06f-d10615254fb9@linux.dev>
Date: Wed, 10 Jul 2024 12:50:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/2] BPF selftests misc fixes
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1720615848.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <cover.1720615848.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/10/24 6:10 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v2:
>   - only check the first "link" (link_nl) in test_mixed_links().
>   - Drop patch 2 in v1.
> 
> Resend patch 1 out of "skip ENOTSUPP BPF selftests" set as Eduard
> suggested. Together with another fix for xdp_adjust_tail.

This is not very useful as a cover letter to summarize what has been fixed. I 
need to go back to the "skip ENOTSUPP BPF selftests". I beefed it up a little.

I also added the Fixes tag before applying. Please remember to add Fixes tag 
next time for bug fixing.

Thanks for the fixes.


