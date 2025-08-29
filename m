Return-Path: <bpf+bounces-67028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6284BB3C25F
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 20:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0801C26BDC
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758BF340D9A;
	Fri, 29 Aug 2025 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KA3788Ke"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514C1401B
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491731; cv=none; b=SCIyoEOpIOYRteVi435SXsSqk78UB9TpGlt4pLlJS0oRXCmbWy69ifN+mEzQXeIyh7FbwK1F5RVM6qpgx6cvxDOi81iH6/4seib0XX3H5Ny3koSja5PVamXZMb+2r/UoKj4nVZHkcI0IYMpqcrnNmaUOA0b/G+mlLqSKMBflwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491731; c=relaxed/simple;
	bh=f/o3yyuAdpIS6fumQMRpWedhDk0OWbhdvg4/SpRnWJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UotI0YZBhyzuyiwpnn7araq+Kng1fF72i83yUFzESf0Ck6l3Q5SZBfR/ULO9yeo8D3eKOXIvjkQx3AXB5bmMMr/aTkvJZr0CBvkxK/HikkR1OtR4C9wvf9TGlpTrN56NlVmgF2Yrc3BOqqAluXSqxsSfYUFUFahRdxwAIjmJ2aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KA3788Ke; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <afdc16b0-fd53-4d4c-b322-09d1a0d8cb86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756491726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XnZvhtXoRglRMKZgokPOJEDrhVDhrptaz8Qku4BP0U=;
	b=KA3788Ke7GaG33hXsu9TCaS5uBwows913gtMyiGnb+ND8INwYGg1BIIMpvHmXo068yjlW/
	kqOB7JLO1Jufq+jccj0IRnxz+7K2/A2BOhk5M/EhkapDHfUZ/TOb3sQfxrK//tGVClrb3q
	Op4UvO04tb3RQOkuvZNq6suywE62Hn4=
Date: Fri, 29 Aug 2025 11:21:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
To: Nimrod Oren <noren@nvidia.com>, Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 kuba@kernel.org, martin.lau@kernel.org, mohsin.bashr@gmail.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maciej.fijalkowski@intel.com, kernel-team@meta.com,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
 <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/25 6:39 AM, Nimrod Oren wrote:
> I'm currently working on a series that converts the xdp_native program
> to use dynptr for accessing header data. If accepted, it should provide
> better performance, since dynptr can access without copying the data.

The bpf_xdp_adjust_tail is aware of xdp_buff_has_frags. Is there a reason that 
bpf_xdp_adjust_head cannot handle frags also?

