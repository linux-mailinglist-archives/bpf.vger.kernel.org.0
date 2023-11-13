Return-Path: <bpf+bounces-14966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8707E9582
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 04:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40E61C20AA1
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 03:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478FA8829;
	Mon, 13 Nov 2023 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zi+4fq7n"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A808466
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 03:28:10 +0000 (UTC)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ac])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5C7171C
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 19:28:07 -0800 (PST)
Message-ID: <24d0e85a-4129-4bf3-8ef7-bcece3e9616e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699846083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRypFmT0gonA5vA1X1Va423ykewRIIi0SJhwQhSdTlk=;
	b=Zi+4fq7nb+xqirT7py4dTzwLkfxx4h/GCfvMkg6bz1nJ6/fLugcpFMIYz1QsfbyJ3CvF8F
	mZ+WA/ldZEzvFN0crm1eRDhzQQ7dIbohlTYg/Hd36WCaEQ6f/ItEM2nOmSdEWd1Ev4ItYz
	qvDaMG2UmkKhchaffnwb5nMYeAgZPWg=
Date: Sun, 12 Nov 2023 22:27:53 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf/tests: Remove test for MOVSX32 with offset=32
Content-Language: en-GB
To: Stanislav Fomichev <sdf@google.com>, Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20231110175150.87803-1-puranjay12@gmail.com>
 <ZVEkJ9waaH9X11GR@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZVEkJ9waaH9X11GR@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/12/23 11:14 AM, Stanislav Fomichev wrote:
> On 11/10, Puranjay Mohan wrote:
>> MOVSX32 only supports sign extending 8-bit and 16-bit operands into 32
>> bit operands. The "ALU_MOVSX | BPF_W" test tries to sign extend a 32 bit
>> operand into a 32 bit operand which is equivalent to a normal BPF_MOV.
>>
>> Remove this test as it tries to run an invalid instruction.
>>
>> Fixes: daabb2b098e0 ("bpf/tests: add tests for cpuv4 instructions")
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202310111838.46ff5b6a-oliver.sang@intel.com
> Acked-by: Stanislav Fomichev <sdf@google.com>
>
> (based on the fact that emit_movsx_reg doesn't handle 32 bit case under !is64)

The test failure signature is:
   #83 ALU_MOVSX | BPF_W jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)

If the asm code went though verifier, we should get a verification failure.
But in test_bpf.ko case, the asm code is directly jited (see jited:1 above),
so there is no verification failure.

The current jit does not do error handling and assumes asm code are all legal,
so for !is64 case, the size = 32 asm code is silently ignored for x86 side
and caused the error. But the test is introduced by arm64 and the test passed
for arm64.

Not sure how we could prevent such issues. To handle *all* illegal insns in jit
definitely not a good idea. In any case, the change for this patch looks good.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


