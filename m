Return-Path: <bpf+bounces-75608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5F4C8B8A7
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 20:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88D534E6D98
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 19:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE0733F8BB;
	Wed, 26 Nov 2025 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xvW14r6M"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D33311948
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764184401; cv=none; b=KcAFZv3gUMf4kWWvESMC7vmAfuO6X+lo+/XBXCK7Z1WXbMtsswKqmRvvMuGhd5SIXe30Mux0cDcl5LyR8DxErF+bmOyfN7SREw5eqMpemStZl1dBt/XJ+4g0T8a/Lvw70ic9Aff6eSkFbqe2PY4cUopYu7VRX30xZDAChqxRN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764184401; c=relaxed/simple;
	bh=N0Zb+RrDajauwjsyN6i28AMVPOJUhfk5DbUUzMwggys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzj9du2BXOsCQD0pwH+t8M/6A1QzWflPAcDu7Sg6313JsLjVt6fmnauvb3BrURoQ3dE04jxcl4NxNufg/jzdGU9C0gOd5jIDE89n1zLxqs5x5l44qqq3mtO4MOs0TXcxXPVpVcstOa8fCLTS5B8jQTAblvK8ue4xNTce/2Ye7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xvW14r6M; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6b61c22b-d38c-47c1-8b8f-a37e44866644@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764184396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oj7a/chW6SNwlrR4P2Y5EG7P7Q7f9ZjCmFxdGZ83m2c=;
	b=xvW14r6MwplzZCEMbwn7A8A5jtx0DN9DcCMJSK0NDmNKOyL8XG8Tv7TwV2bWk44sVCEGbi
	GAL8rrEGFMQ+esPBU+v0Uc5zM2A4hnwP9Txc+Z1bqMfiEYj/673tCW1sKhwu+S4ce2lRAz
	IfIA22ebNUlPHWZEylq3zBBIQuW2pFc=
Date: Wed, 26 Nov 2025 11:13:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 4/4] resolve_btfids: change in-place update
 with raw binary output
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 bpf@vger.kernel.org, dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
References: <20251126012656.3546071-1-ihor.solodrai@linux.dev>
 <20251126012656.3546071-5-ihor.solodrai@linux.dev>
 <CAErzpmt7ER171hAjQ2SwbmC9R3dVsKHj02B8VM5gKMViP1iFqA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAErzpmt7ER171hAjQ2SwbmC9R3dVsKHj02B8VM5gKMViP1iFqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/26/25 5:03 AM, Donglin Peng wrote:
> On Wed, Nov 26, 2025 at 9:29 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> [...]
>>
>> For the kernel modules creating special .bpf.o file is not necessary,
>> and so embedding of sections data produced by resolve_btfids is
>> straightforward with the objcopy.
> 
> The Makefile for the bpf selftests also needs be updated too:
> https://elixir.bootlin.com/linux/v6.18-rc7/source/tools/testing/selftests/bpf/Makefile#L708
> 
> This results in the self-test for resolve_btfids failing:
>  $./vmtest.sh -- ./test_progs -t resolve_btfids -v
> ...
> test_resolve_btfids:PASS:id_check 0 nsec
> test_resolve_btfids:FAIL:id_check wrong ID for S (0 != 3)

Good catch, thanks.

I remember I noticed this at some point, and then forgot...

Interestingly this test passes on CI [1]: 

2025-11-26T03:09:52.0908317Z #366     reg_bounds_rand_ranges_u64_u64:OK
2025-11-26T03:09:52.0925114Z #367     resolve_btfids:OK
2025-11-26T03:09:52.3904190Z #368/1   res_spin_lock_failure/res_spin_lock_arg:OK

I'll take a closer look.

[1] https://github.com/kernel-patches/bpf/actions/runs/19690981192/job/56406840021

> 
> 
>> [...]
>>


