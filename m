Return-Path: <bpf+bounces-63274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 098F6B04C84
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 01:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E043AA67D
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 23:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BE32777F1;
	Mon, 14 Jul 2025 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aQlHAg9r"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7545253B71
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 23:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752536732; cv=none; b=JcXHPaqEcFdiBQ5ttnFM2g3QgGI2MamnPwNPVcl3Yve5703VTw31Rz5+0dHTqYTm1C3nBS8Ydh32tvnIhANO5dFaH8sFv11n/GZWzjbc/QmliZG8rSuDJCkvW2xrypN8Z63KgOkuqvvPGm80npm7lTQJZxbpic73zGHtvLmlN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752536732; c=relaxed/simple;
	bh=eDaeNRY9d4DwiLpiw4HbMVjhOvgL0gPYNvcfXP5EuFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSDbEmNE/SmQAPbysLOwWgOnvvK+gNRQ+6Tof81mBZODD3TKkWB/TlH8YY3Ru5TX5TDDJoqPICRwm7+xH+hTVJQnr2qwnIQnisI3wEzLJkbZE3BN9xe5rH4DkeYohjcczFv4rImsUf3hYYCLxf+kUQ/7LTEO9ICPhYCsThK6bGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aQlHAg9r; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0027bec0-e10f-4c7d-9a56-1c9be7737f6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752536717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyc9wOVmB/LsVjlEChnyf4WH3KMKL1NswKuvQMdphAo=;
	b=aQlHAg9riapgF4KgIvqBT8t525wuLfg74cw/uwurQt71PCDpk7WxGLjK4b+qmAwQK7px5Z
	gaceNa5UK4jpS3B0iT9eZgY8YuDMyOsqhHt17QR9a2c3KLvecYyMvIfWZ1XVMpOchl9UMz
	1fZz6nBUm29EaPXcAXD9F/tR6+c9jvI=
Date: Tue, 15 Jul 2025 07:45:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 06/18] bpf: tracing: add support to record and
 check the accessed args
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org, jolsa@kernel.org,
 bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-7-dongml2@chinatelecom.cn>
 <CAEf4BzYpfYJyFKj0Uvtj+h2mBe1AXDwa2pfFCF7E377JufSU3g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Menglong Dong <menglong.dong@linux.dev>
In-Reply-To: <CAEf4BzYpfYJyFKj0Uvtj+h2mBe1AXDwa2pfFCF7E377JufSU3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2025/7/15 06:07, Andrii Nakryiko wrote:
> On Thu, Jul 3, 2025 at 5:20 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>> In this commit, we add the 'accessed_args' field to struct bpf_prog_aux,
>> which is used to record the accessed index of the function args in
>> btf_ctx_access().
> Do we need to bother giving access to arguments through direct ctx[i]
> access for these multi-fentry/fexit programs? We have
> bpf_get_func_arg_cnt() and bpf_get_func_arg() which can be used to get
> any given argument at runtime.


Hi Andrii. This commit is not for that purpose. We remember all the accessed
args to bpf_prog_aux->accessed_args. And when we attach the tracing-multi
prog to the kernel functions, we will check if the accessed arguments are
consistent between all the target functions.

The bpf_prog_aux->accessed_args will be used in
https://lore.kernel.org/bpf/20250703121521.1874196-12-dongml2@chinatelecom.cn/

in bpf_tracing_check_multi() to do such checking.

With such checking, the target functions don't need to have
the same prototype, which makes tracing-multi more flexible.

Thanks!
Menglong Dong


>
>> Meanwhile, we add the function btf_check_func_part_match() to compare the
>> accessed function args of two function prototype. This function will be
>> used in the following commit.
>>
>> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>> ---
>>   include/linux/bpf.h   |   4 ++
>>   include/linux/btf.h   |   3 +-
>>   kernel/bpf/btf.c      | 108 +++++++++++++++++++++++++++++++++++++++++-
>>   net/sched/bpf_qdisc.c |   2 +-
>>   4 files changed, 113 insertions(+), 4 deletions(-)
>>
> [...]
>

