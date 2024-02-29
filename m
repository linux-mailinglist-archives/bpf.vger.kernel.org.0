Return-Path: <bpf+bounces-22982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609E486BDA5
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 02:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C30C1C2421E
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35D036124;
	Thu, 29 Feb 2024 00:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QYu7NPvp"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAED13D2E8
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168210; cv=none; b=DoeF+EzOctAVW+HzViB+CfZ6BMIudjNrqH+eyGbr1qDhjjUPRNPDvUy9MKhGd3jyTcOGQ+DjDLl/3MFCWWfjvgA7ha7agX3G3JpRDcQ1vgrGaEN+hi/6R3FpQkV2OdEEJqI0atoLmbwr0Tq6RNleRJ/xtU9lNLBXvhZgro4f3pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168210; c=relaxed/simple;
	bh=U0XUkIH5Y96ksReuol4IblIO0K1aeSD/QRJfIq34jFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RM2MIIo8XWkc4YF0Lwk9BeGjSndkiU4O4xWZZtgD4bC/c17TR3y+ayDMCtmbvax00RiLDK19ICuWRqpNJemFsRHkSsrbk5Iu8HD1ev9uM485AQuHna/95VikOuwnHJnsQQajKGH1GxgaK0MIYiVNZGCIykaQkemQq6UqAKg3Hbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QYu7NPvp; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9641831b-823c-48e9-924b-8e68f9d731e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709168206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/CKleXIAXuhRZ0PwOQAo/SgG0cwg3Vi+EI2pcrZxNE=;
	b=QYu7NPvp3gY369HaRX2qCeGvZd8nvGxXh0q+NyR2IPlTBpcrd+hJiuKsyTTTasVNLo+aKC
	Lpmdt5jW0SSu6CiPvnziq96uDPtq3fy8ci9bbBval3OQlYdy/Lf+ESl6/uvQiQNLUyqDzt
	va+BISwnG86Z40ZgjmNaArfZ7eeFu3I=
Date: Wed, 28 Feb 2024 16:56:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 6/8] selftests/bpf: test autocreate behavior
 for struct_ops maps
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, yonghong.song@linux.dev,
 void@manifault.com
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-7-eddyz87@gmail.com>
 <CAEf4BzbXzsDUx-dvUQQEMcCVUeUjnBnbF6V4fmc36C0YzVF73A@mail.gmail.com>
 <d5fda01ecfac47e096e741a68ac8a1d2d726fc16.camel@gmail.com>
 <CAEf4BzYRS-wd_FTi-_=1t9mjgMp3P6yrTqbkQ+359aKmcjZDNQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAEf4BzYRS-wd_FTi-_=1t9mjgMp3P6yrTqbkQ+359aKmcjZDNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/28/24 4:02 PM, Andrii Nakryiko wrote:
>> Also, what would happen when two tests would set struct_ops for same
>> attachment point?
> I'm not sure, Martin?

The kernel bpf struct_ops infra can handle it. For example, different userspace 
processes may register bpf-tcp-cc in parallel also. It is a matter of the 
subsystem (tcp in the bpf-tcp-cc case) can handle it or not.

In the testmod case, it will be bpf_dummy_reg[2] and nothing in there is 
stopping parallel run afaict.

