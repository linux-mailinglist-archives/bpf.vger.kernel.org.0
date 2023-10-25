Return-Path: <bpf+bounces-13282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A950D7D77A2
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 00:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391E3B211C1
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 22:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EAF3717A;
	Wed, 25 Oct 2023 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XP1sipJh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008E168DF
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 22:09:53 +0000 (UTC)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [IPv6:2001:41d0:203:375::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8758E181
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 15:09:52 -0700 (PDT)
Message-ID: <51abec01-c4ce-434f-694a-f932e0e203ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698271790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xS/mNPxC92MYDT4iyEXeYRRgcvO//O6K2O3T1bsKM8U=;
	b=XP1sipJhRUqpcxP82pICdZDA8p6/zQTW8ENIUqRnjOO/q3fh4ypTykEjy2/DuLdSZ97WMw
	F/wjfgDZu6Gn/efED8iJM1RoJt6NwWGCb24IKqBcr1jYmapTFczWG/eKeHu5Pk8cRS+khn
	plSmjoTSGys/UZt131dG2XjsX3yfNhI=
Date: Wed, 25 Oct 2023 15:09:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/7] netkit, bpf: Add bpf programmable net
 device
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, ast@kernel.org,
 andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 toke@kernel.org, kuba@kernel.org, andrew@lunn.ch,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <20231024214904.29825-2-daniel@iogearbox.net>
 <ad801a2c-217e-44b4-8dae-0ae7b1b8484f@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ad801a2c-217e-44b4-8dae-0ae7b1b8484f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/25/23 2:24 PM, Kui-Feng Lee wrote:
> 
> 
> On 10/24/23 14:48, Daniel Borkmann wrote:
>> This work adds a new, minimal BPF-programmable device called "netkit"
>> (former PoC code-name "meta") we recently presented at LSF/MM/BPF. The
>> core idea is that BPF programs are executed within the drivers xmit routine
>> and therefore e.g. in case of containers/Pods moving BPF processing closer
>> to the source.
>>
> 
> Sorry for intruding into this discussion! Although it is too late to
> mentioned this since this patchset have been v4 already.
> 
> I notice netkit has introduced a new attach type. I wonder if it
> possible to implement it as a new struct_ops type.

Could your elaborate more about what does this struct_ops type do and how is it 
different from the SCHED_CLS bpf prog that the netkit is running?

