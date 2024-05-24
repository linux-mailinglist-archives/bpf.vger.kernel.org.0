Return-Path: <bpf+bounces-30532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38898CEB91
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057691C20BE3
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 20:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788A51311BD;
	Fri, 24 May 2024 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mERfR1mx"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40DA130E21
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716584086; cv=none; b=m0DCU8vwcLk5HwO85fRYcvYhqCCr1HcCN0IFEVsLp8qu3+dhsSU/J0Xrc9/SVpEReLawz7vnrRvFcShavMXKAadMEORGCuhkmr3d3Awd1U/4PU60GXsmAPaESqRqJSk0AWQJ5VEnkUFrXFn2T2bhrxpRrwr2k8WmRe+wmoM3nL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716584086; c=relaxed/simple;
	bh=yVLnqnImDkLFBBkIeEe/zgwmiPIxTIKbwkixkJw+qwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hgli4+DcnqFYjNVCocksYhLo4SMq6YLsxnheShuAqw5sAvTl6P1CRpP/P2N3yHVMTyUbL7fNNiaMm1/EJlbsu7MMNFnUHfA5Sh6DY4HNi+dn6n6BSIPWBphQ7WPfrncGpVStfYzj0Gbk2+ulgGEUpa6QsOtIz3Szv7sJte5QIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mERfR1mx; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716584083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDBEhv0HyRq4SxPfnYiersMvCncgSbh57JB8QLDUSf4=;
	b=mERfR1mxob98mIV5u9s05Sqgi34cydLJe3b6Rp9wJI7b90tooaBtcUUeAKZ73gaSl+JpG2
	onqBSqtOmv79lojTxR4OlD7PRhhfnEUIqd/z7s8d7wxb8UqVfSnQPILACiazJXhreAahj+
	/LXFFO9Z+jTyyfvefZAKMgoY4LqgiIk=
X-Envelope-To: ameryhung@gmail.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: yangpeihao@sjtu.edu.cn
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@kernel.org
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: toke@redhat.com
X-Envelope-To: jhs@mojatatu.com
X-Envelope-To: jiri@resnulli.us
X-Envelope-To: sdf@google.com
X-Envelope-To: xiyou.wangcong@gmail.com
X-Envelope-To: yepeilin.cs@gmail.com
Message-ID: <dfbea3d6-f24b-4fc3-8a78-13745fc4042e@linux.dev>
Date: Fri, 24 May 2024 13:54:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v8 18/20] selftests: Add a bpf fq qdisc to selftest
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 yangpeihao@sjtu.edu.cn, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kui-Feng Lee <sinquersw@gmail.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 Stanislav Fomichev <sdf@google.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Peilin Ye <yepeilin.cs@gmail.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-19-amery.hung@bytedance.com>
 <6ad06909-7ef4-4f8c-be97-fe5c73bc14a3@linux.dev>
 <CAADnVQLLqy=MTK_u2FMrxUEZRojYPUZrc-ZG=Gcj-=SaH9Q=XA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQLLqy=MTK_u2FMrxUEZRojYPUZrc-ZG=Gcj-=SaH9Q=XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/24/24 12:33 PM, Alexei Starovoitov wrote:
> On Thu, May 23, 2024 at 11:25 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>>> +
>>> +unsigned long time_next_delayed_flow = ~0ULL;
>>> +unsigned long unthrottle_latency_ns = 0ULL;
>>> +unsigned long ktime_cache = 0;
>>> +unsigned long dequeue_now;
>>> +unsigned int fq_qlen = 0;
>>
>> I suspect some of these globals may be more natural if it is stored private to
>> an individual Qdisc instance. i.e. qdisc_priv(). e.g. in the sch_mq setup.
>>
>> A high level idea is to allow the SEC(".struct_ops.link") to specify its own
>> Qdisc_ops.priv_size.
>>
>> The bpf prog could use it as a simple u8 array memory area to write anything but
>> the verifier can't learn a lot from it. It will be more useful if it can work
>> like map_value(s) to the verifier such that the verifier can also see the
>> bpf_rb_root/bpf_list_head/bpf_spin_lock...etc.
> 
> Qdisc_ops.priv_size is too qdsic specific.

Instead of priv_size, may be something like a bpf_local_storage for Qdisc is 
closer to how other kernel objects (sk/task/cgrp) are doing it now. Like 
bpf_sk_storage that goes away with the sk. It needs a storage that goes away 
with the Qdisc.

I was thinking using priv_size to work something like a bpf_local_storage 
without the pointer array redirection by pre-defining all map_values it wants to 
store in the Qdisc, so the total size of the pre-defined map_values will be the 
priv_size. However, I haven't thought through how it should look like from 
bpf_prog.c to the kernel. It is an optimization of the bpf_local_storage.

> imo using globals here is fine. bpf prog can use hash map or arena
> to store per-netdev or per-qdisc data.
> The less custom things the better.



