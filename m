Return-Path: <bpf+bounces-57295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC3CAA7B6F
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 23:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D503AA6E9
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 21:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED1720B7FB;
	Fri,  2 May 2025 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F5BeHLyK"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30729408
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746222070; cv=none; b=udr+AkKesaeyl70su9WKrAPyzvJsOlGDaDWdfLa+xvdQFwhxGXMngeQAWn/76bqEtHzfGoEsWaqLI0Xrs1SJM6gXOLTNGfuoOTM3K8I230sUhdV2v9/xxz/uEYIKjgEQyBKGlVuEgi7JC3Un9aFSdk28DAjyXkgeibfAR0OpMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746222070; c=relaxed/simple;
	bh=z8ZRMLZtLHsJaTmMyIaxVIeYlIp5HL/M7mAQfbIvtGE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=NTJ8ZrIqyuIudmD07NxB+X4QjfNQFZyW40xT6F9UTFrvnHY39k1/NtRTK4mZES6aau4h91R6m4ng5BKghEmBSB+SYVgRhr1ei6RycWEiG/EymHoAYPtgZrzmldU7zqnCLGYnYdOZTqtwBx2Bl6nkxKtN1LEMyfmsgNcTEDg/reM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F5BeHLyK; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a039ded-b67d-4a0c-a851-e3aafff57321@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746222053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iitgyLfWSO5Stim9LQ1kMUkOc0KG4iKI2UtGkMOuXLE=;
	b=F5BeHLyKbi+x6pQRA0oLRaVxncLBIldvXz2FFI+yUiA5LUasAkjKkKrL09eLbaTyiL1ONV
	RH3ZvBOqRIV7sxMpJIa4apL/kd9bgLr5Du0kDrt7HfJ15Dk29v3Ubqsob78eUPePvTxIYd
	dHkVLf2KM/EDZnoL5k9C9R/+PipPM+A=
Date: Fri, 2 May 2025 14:40:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: selftests/sched_ext: testing on BPF CI
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Alexei Starovoitov <ast@kernel.org>
References: <3fb44500b87b0f1d8360bc7a1f3ae972d3c5282f@linux.dev>
Content-Language: en-US
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3fb44500b87b0f1d8360bc7a1f3ae972d3c5282f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025-01-28 4:21 p.m., Ihor Solodrai wrote:
> Hi Tejun, Andrea.
> 
> I tested a couple of variants of bpf-next + sched_ext source tree,
> just sharing the results.
> 
> I found a working state: BPF CI pipeline ran successfully twice
> (that's 8 build + run of selftests/sched_ext/runner in total).
> 
> Working state requires most patches between sched_ext/master and
> sched_ext/for-6.14-fixes [1], and also the patch
>    "tools/sched_ext: Receive updates from SCX repo" [2]
> 
> On plain bpf-next the dsp_local_on test fails [3].
> Without the patch [2] there is a build error [4]: missing
> SCX_ENUM_INIT definition.
> 
> We probably don't want to enable selftests/sched_ext on BPF CI with
> that many "temporary" patches. I suggest to wait until all of this is
> merged upstream.
> 

Hi everyone. I tried enabling sched_ext selftests on CI today, and there
are no issues on bpf-next tip (f263336a41da).

https://github.com/kernel-patches/vmtest/actions/runs/14802453691

If there are no objections, I'm going to push this to BPF CI on Monday.

As a reminder, this means that selftests/sched_ext test runner will be 
built and executed for pending BPF patches, and BPF CI pipeline will 
fail in case of problems there.

> You can check the full list of patches here:
> https://github.com/kernel-patches/vmtest/pull/332/files
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/log/?h=for-6.14-fixes
> [2] https://lore.kernel.org/all/Z1ucTqJP8IeIXZql@slm.duckdns.org/
> [3] https://github.com/kernel-patches/vmtest/actions/runs/13019837022
> [4] https://github.com/kernel-patches/vmtest/actions/runs/13020458479


