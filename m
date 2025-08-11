Return-Path: <bpf+bounces-65375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7CBB21570
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669147A20A7
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 19:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A3E2BD580;
	Mon, 11 Aug 2025 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AEiUPnhG"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7B4284B25
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941186; cv=none; b=Xqm65aVSe1sqmbb2451kFxn/LVM5En2oPcYF273N5xM3A3uLH7o6g4//5ZhLKF7A9qChwzBXiqfnEVsj9ioutaRLzwhGC87Vq1i0/RPbnIWRTUDtC4TyzGxVKlYG8aoMOoIt2DhSqBOa4o4msJdv+M09YrFiGP5psO2sFwqVLtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941186; c=relaxed/simple;
	bh=EaHPOBRkvUWOXygDbX7X2gdwaH1u/3O6aBKuerg6T0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfusyxMlRMlBhCslFAVBLueMJ4PfqRvj7UNhcvo+fUG8BuLUByaCi5+1wRt19wF4GOti4fn1pC5RZUGwSfFNJnIWuEf8Bf+qdquuwUyZpIKVp0rzdrBkYrEu+4WsCQvAY3+sOtnZjWDIdfye8gZYN9QoDeDawqMl2MArQaXT9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AEiUPnhG; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e9652471-39f6-4388-a231-f2fbd7fdafe3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754941182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EaHPOBRkvUWOXygDbX7X2gdwaH1u/3O6aBKuerg6T0o=;
	b=AEiUPnhG5N+RdWIWKBYZMtxoLMfKDuFm7a4Nb6H/Xw1MgDMwAEa9S5TAnQLX87gj4M127t
	UuFt2nnQbld4x5Xxc37BmKCXC4OGfRHlyTfhtEqQssnw2iPMr23Vk1t4cz70bx+VrlaC5a
	V7X6hc6NE5fq9oGmvtbh60xYv9AiKfE=
Date: Mon, 11 Aug 2025 12:39:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add a test for
 bpf_cgroup_from_id lookup in non-root cgns
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Dan Schatzberg <dschatzberg@meta.com>,
 kkd@meta.com, kernel-team@meta.com, bpf@vger.kernel.org, tj@kernel.org
References: <20250811175045.1055202-1-memxor@gmail.com>
 <20250811175045.1055202-3-memxor@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250811175045.1055202-3-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/11/25 10:50 AM, Kumar Kartikeya Dwivedi wrote:
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Please add a commit message in the respin. Thanks.


