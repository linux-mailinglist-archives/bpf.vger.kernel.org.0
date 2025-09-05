Return-Path: <bpf+bounces-67587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5B0B45FEA
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B1C5C4688
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 17:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91FD37427E;
	Fri,  5 Sep 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c2dQePiF"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2101B313280
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092841; cv=none; b=rcrLfJ1eSON96J0kL6xovmEWuaCl0boHGKulKHwMC7WeWXONV8B82AE765jlAptenS10emRgMVj4cnbNw5vue5Q6zND+qXymbwJ/xKRtMaVCpFILczXjYOAT3FWSsQM4lRC8o2lALaJSVTTRHfCPGWFLpNLTkYUz31xI3/VuRLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092841; c=relaxed/simple;
	bh=69VwV53pEtbwlpqFCXdqeHzoaEBq/NLT0xcX5Dl5RTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7OwpuE7ehXBoUojmggtBsNDlyP1RUIXZMaQY4p8M3Bn02JNsgk1smWo8lVvSLidqiM7VcdjTn6CyPq+wjngfQ7xc7rrvvX97GzO+nzvAfHcbp69+tvbU8n3qK/5KoJRXbJIcpBwNRz1gbGQTfOh47mckdeNYpfXE7fb72CExGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c2dQePiF; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9ac027eb-e1fa-43b7-9b36-f5a267e461f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757092826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwgUa8pyKPwPOQ4M2XhOit+u2/9lsIIMXunBg9kdPhA=;
	b=c2dQePiF6hmccOFnJ4dZKjS5xDnXsi2rVVVxFF65kEVxvnVunxMge4VTrCLeStOpfCfTVd
	7nLNVgTZHeQ9Gh3+v23IemaBk4QZHOx/XO2MfasXSqHHstIj8ItL7y/iMFcY+LPCG/U04y
	6mAgJkDTjGOUS7MbgH6kxvMZOMSbsUg=
Date: Fri, 5 Sep 2025 10:20:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
To: Amery Hung <ameryhung@gmail.com>
Cc: Nimrod Oren <noren@nvidia.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, kuba@kernel.org, martin.lau@kernel.org,
 mohsin.bashr@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
 <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
 <afdc16b0-fd53-4d4c-b322-09d1a0d8cb86@linux.dev>
 <CAMB2axO1Hb=pNMw8p2Ca+4XfVmDTA+TxbbXaD4G6kxUVEsHERg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axO1Hb=pNMw8p2Ca+4XfVmDTA+TxbbXaD4G6kxUVEsHERg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/4/25 10:28 AM, Amery Hung wrote:
> On Fri, Aug 29, 2025 at 11:22 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 8/28/25 6:39 AM, Nimrod Oren wrote:
>>> I'm currently working on a series that converts the xdp_native program
>>> to use dynptr for accessing header data. If accepted, it should provide
>>> better performance, since dynptr can access without copying the data.
>>
>> The bpf_xdp_adjust_tail is aware of xdp_buff_has_frags. Is there a reason that
>> bpf_xdp_adjust_head cannot handle frags also?
> 
> I am not aware of reasons that would stop this.
> 
> Are you suggesting another way to pop headers? E.g., use
> bpf_xdp_adjust_head() to shrink the first frag from the front and call
> bpf_xdp_store_bytes() to move the remaining headers

bpf_xdp_pull_data is useful on its own, nothing change there. On top of that, 
bpf_xdp_adjust_head() should be useful also for bpf prog that does not care 
about the linear/frag layout and stay with the bpf_dynptr helpers (or the 
bpf_xdp_{store,load}_bytes you mentioned). Also, if I read it correctly, 
bpf_xdp_adjust_head can increase the head of multi buf xdp but not shrinking it 
while the bpf_xdp_adjust_tail can do both. It could be a surprise to use. The 
adjust_head support can be a followup though. I think some of your work in this 
series is pretty close to having adjust_head support also, so I was wondering if 
there is reason that adjust_head cannot be supported.

