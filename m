Return-Path: <bpf+bounces-8080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5309780F43
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDC8281BE9
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8455B19897;
	Fri, 18 Aug 2023 15:34:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E5718C22
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 15:34:37 +0000 (UTC)
Received: from out-49.mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7B13C3D
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:34:35 -0700 (PDT)
Message-ID: <4a45663d-2982-bc6a-a895-c0117833339f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692372873; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YAkfoYMksF403IUqFFyp+EirQplTpIkhnhTL+B0f1s=;
	b=GyHjdH4bajoU+LRJmmrE3zQofv+9Bv8+BmtSPG1neh0uK2aGNKb5b9N0JP/ZbF4SIDF2S7
	dORHR/8/DtXcIwLwF2z4BjiSi5zYA9mCTyXaemkdGbWHF+aV2PMdho2wAz3d5w+8tReOFC
	g/k3JwmD9jQ4Y6pz7RgwDlZYvaAyBNI=
Date: Fri, 18 Aug 2023 08:34:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Enable cpu v4 tests for arm64
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, Xu Kuohai <xukuohai@huawei.com>,
 Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Yonghong Song <yhs@fb.com>,
 Zi Shen Lim <zlim.lnx@gmail.com>
References: <20230815154158.717901-1-xukuohai@huaweicloud.com>
 <20230815154158.717901-8-xukuohai@huaweicloud.com>
 <f1b6fde2-5097-7a0f-29ad-7390a165bf16@linux.dev>
 <67212714-15f3-84e8-d5c6-84746632eedd@huaweicloud.com>
 <2fd02263-669f-82cf-d2c0-86fb5e4ad993@linux.dev>
 <6e8244b3-acf8-acd3-2dda-8777b2b4c7f9@huawei.com>
 <28f7de40-4941-4554-25bf-370dd2ec3226@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <28f7de40-4941-4554-25bf-370dd2ec3226@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/18/23 7:04 AM, Daniel Borkmann wrote:
> On 8/16/23 4:31 AM, Xu Kuohai wrote:
>> On 8/16/2023 9:57 AM, Yonghong Song wrote:
>>> On 8/15/23 6:28 PM, Xu Kuohai wrote:
>>>> On 8/16/2023 12:57 AM, Yonghong Song wrote:
>>>>> On 8/15/23 8:41 AM, Xu Kuohai wrote:
>>>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>>>
>>>>>> Enable cpu v4 instruction tests for arm64.
>>>>>>
>>>>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>>>>
>>>>> Thanks for adding cpu v4 support for arm64. The CI looks green as 
>>>>> well for arm64.
>>>>>
>>>>> https://github.com/kernel-patches/bpf/actions/runs/5868919914/job/15912774884?pr=5525
>>>>
>>>> Well, it looks like the CI's clang doesn't support cpu v4 yet:
>>>>
>>>>    #306/1   verifier_bswap/cpuv4 is not supported by compiler or 
>>>> jit, use a dummy test:OK
>>>>    #306     verifier_bswap:OK
>>>>
>>>>> Ack this patch which enabled cpu v4 tests for arm64.
>>>
>>> Ah. Sorry. Could you paste your local cpu v4 run results for
>>> these related tests in the commit message then?
>>
>> Sure. The results are as follows. I'll post these in the commit message.
> 
> Thanks, I've added these to the commit message given Florent's review and
> tests came in.
> 
> Yonghong, did you ping all other JIT folks as well, so they are aware 
> and have
> a chance to look into adding support for their archs?

Thanks, Daniel for reminder. Will ping them soon to get
cpu v4 support for other arch's as well.

> 
> Thanks,
> Daniel
> 

