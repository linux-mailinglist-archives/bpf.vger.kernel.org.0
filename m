Return-Path: <bpf+bounces-64567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB31B14493
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 01:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861397A1CD5
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 23:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55B5236A88;
	Mon, 28 Jul 2025 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rQicMV3o"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67951A76DE;
	Mon, 28 Jul 2025 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753744144; cv=none; b=JFJ5V8nWrcrFk5D31ASA3v+9dEQ9RTnDGpbmvubvmfuACZMQTx1YDtGzeLvWAsKtFqorEOZla6dCMtwwg+7aqoQiF3LPfuu6s4cXwbm/n2EMdSJTc1NjwUhFoqgziF9bjqgt71lY4WGUyZBohW5oawQmY0gNInMpQJ7d197EM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753744144; c=relaxed/simple;
	bh=XCU0AGGLxitu5cKJWqXljhOwgmuRcpJEhvP1NouLn9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/0YWH7Kor7s970uv05cPUAL43mKQg46jR85yQzB77nuHmfcoApDnwm0PAPBz/dzJ8+OyVaN+yvPFXBhE29xZhgRtm2PlF1kFc8nfVOLgfxHpAeJyGdroHxhY0EkuxMbY/SiUL/YfYFxHWqIcvYQEG+PFwUxrSDtme7PyReFfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rQicMV3o; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <21a94c95-cd2d-47cb-9efd-5ee76efc62d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753744140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCU0AGGLxitu5cKJWqXljhOwgmuRcpJEhvP1NouLn9Y=;
	b=rQicMV3oCBaUNgsL24SsglvaPaYxAHR2xO+OM2Ln3LmwZ6D8IMreia7Kyk5jTrpfxGyY22
	ewpVRl34/h0O/EXE9o5Zx/P1iuVVIfwpGY9Gy37P3/XH/pl3vjhxa+NGG5Cacr5+detux0
	FxnbD25bnw4Ff1kjIIowg/8Qh/z9Crs=
Date: Mon, 28 Jul 2025 16:08:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Use the correct destructor
 kfunc type
Content-Language: en-GB
To: Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250728202656.559071-6-samitolvanen@google.com>
 <20250728202656.559071-9-samitolvanen@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250728202656.559071-9-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/28/25 1:27 PM, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
> indirect function calls use a function pointer type that matches the
> target function. As bpf_testmod_ctx_release() signature differs from
> the btf_dtor_kfunc_t pointer type used for the destructor calls in
> bpf_obj_free_fields(), add a stub function with the correct type to
> fix the type mismatch.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


