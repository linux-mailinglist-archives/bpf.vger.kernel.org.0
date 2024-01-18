Return-Path: <bpf+bounces-19844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C608321AC
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 23:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359E11C2330E
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 22:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7110B1DA4A;
	Thu, 18 Jan 2024 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UoCilrZ1"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147321DA33
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705617716; cv=none; b=bCUwArJLqgimAUWsd3UJSWdd1RQQ4ZiEzeOwmFXgN3NG3JkoLF2rhf5kc473v5Lf2brFsKIM4tVhiAI2B+kHkoVQ/CPrJVPT60ITIJAENOE+arjrbJrp75Kl6m/UDWWgIYwgH44krv+xG+w36mCdktuFi0Rq8DuYaAJ8wkUXu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705617716; c=relaxed/simple;
	bh=o0APbXhEBynSg7W2VIKHlPhuvNwZ2amWa/t92JKf2C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQJcQ8mNQYY8B4gy6jn5fKrGrB0h3MWtn3hSa2MTtPBQvk7jLzCPc2c3vsrX8O++Ipl7+vSrePHmDVTWDmyg3CS4GVet6318PCBpjkkNn3K2IjZIwEb1dJOH/RwqhMqBhACoUkAA71BDjd1AR57QDJ/qmSzcA09qhhsDbJzmPJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UoCilrZ1; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <df0c03f8-d510-4559-b1fe-7ef3991e6b8b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705617712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLiXP9CaFih6g2JFTa/5ISpVYbci9eXAUxMWJDbBT8U=;
	b=UoCilrZ1MMXgYyzpuAemIpuk8/5KUSIfQ8mvTDc7SPo8xNCWRxDukYmPYn3OcPf8eoNmXc
	OR787dk15PVEwxW9yeCYMW6JrpkeDw7+aeoNwIFZfARG7YoHbBp55fJxSun/DbX0U2fUta
	T6hqicRgh6TKnH/3YfCvnAEbYay1rPs=
Date: Thu, 18 Jan 2024 14:41:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v16 14/14] selftests/bpf: test case for
 register_bpf_struct_ops().
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-15-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240118014930.1992551-15-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Create a new struct_ops type called bpf_testmod_ops within the bpf_testmod
> module. When a struct_ops object is registered, the bpf_testmod module will
> invoke test_2 from the module.

lgtm. One very minor nit on the newly added copyright comment is to 
s/2023/2024/. Thanks.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> new file mode 100644
> index 000000000000..333d70c5f708
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */


