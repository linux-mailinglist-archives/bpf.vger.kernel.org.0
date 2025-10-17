Return-Path: <bpf+bounces-71225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0F5BEACCE
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7E0745908
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCABA29A310;
	Fri, 17 Oct 2025 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O+ScOfHw"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF3296BAB
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718701; cv=none; b=Vn7YI/RYPGLI188TY0birhzbqlzmE9lEyTHMbA+c+mylYOTQu0JpMecPi98glV8guOVuQ4R1v+dINNekrGXX/8PGzoX7LTEVXql2X2sTd2t5jiwDZ84TdxIvoh5giGwbWDiLwXHwETNb5Yaab0VfCsmg0T5KUapb3R4GA4FJOkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718701; c=relaxed/simple;
	bh=sGK4AUTYey+Xq1MX+vF5oX4JfqJ8kpUT5irJ9iUFnCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uf+/8s90dJvCOKESZ9gvCwhUDeFeztue6gfOCD7FLe9or36h+R+6rMwYNwWMejDxZtNK8qpPMk60cy8bgBcDViLC9jRSjywIoKaih1nsSvcwETcCypnX95YEwao71ObRbu69FkOrhhE8BbkQqo7w/r8ai5iPHj5n57mpLPL30jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O+ScOfHw; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9552754b-b7e0-4f39-9d2f-11aaa8993b66@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760718695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGK4AUTYey+Xq1MX+vF5oX4JfqJ8kpUT5irJ9iUFnCc=;
	b=O+ScOfHwJGpoYYNMcZ36DYfLEkj1/NDJHV23UF1pfDMUQJQUkaW9Zorm7F/PVkfrsIzAVg
	QWsx0L8klV4aLCucb6/YATVzf9DpQ6YdaVXmFSddHAJ1ZH0pl3QJZt+liiXJZFiopSBUlS
	kfWoRgmyX/B3+UQIPPYbqhqcNpe7b2U=
Date: Fri, 17 Oct 2025 09:31:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: fix list_del() in arena list
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
References: <20251017141727.51355-1-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251017141727.51355-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/17/25 7:17 AM, Puranjay Mohan wrote:
> The __list_del fuction doesn't set the previous node's next pointer to
> the next node of the node to be deleted. It just updates the local variable
> and not the actual pointer in the previous node.
>
> The test was passing up till now because the bpf code is doing bpf_free()
> after list_del and therfore reading head->first from the userspace will
> read all zeroes. But after arena_list_del() is finished, head->first should
> point to NULL;
>
> If you remove the bpf_free() call in arena_list_del(), the test will start
> crashing because now the userpsace will read 0x100 (LIST_POISON1) in
> head->first and segfault.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


